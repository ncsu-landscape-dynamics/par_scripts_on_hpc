from mpi4py import MPI
from mpi4py.futures import MPIPoolExecutor, as_completed
import socket


def whats_my_info(x):
    """print the rank, host name, and number passed by main process

    Args:
        x (int): arbitrary integer

    Returns:
        string: hello message
    """

    rank = MPI.COMM_WORLD.Get_rank()
    # CPU/host name
    host_name = socket.gethostname()
    hello = (
        "hello world! My host name is {} and I'm process # {}. "
        + "The main process passed me number {}."
    ).format(host_name, rank, x)
    return hello


def main():
    # MPI world size
    n_cores = MPI.COMM_WORLD.size
    # rank. In main, this should always be 0
    rank = MPI.COMM_WORLD.Get_rank()
    # CPU/host name
    host_name = socket.gethostname()
    print(
        (
            "hello world! My host name is {} and I'm process # {} (the main). "
            + "There are {} processes including me."
        ).format(host_name, rank, n_cores)
    )
    # you can create a list to collect results from the workers
    results = []
    # use context manager for MPI
    with MPIPoolExecutor() as ex:
        # submit is for when you don't mind jobs returning out of order
        # useful if jobs are expected to differ in run length.
        # map can be used if order needs to be maintained.

        # here, we just pass an arbitrary integer to the function for demo.
        futures = [ex.submit(whats_my_info, i) for i in range(0, n_cores - 1)]

        # collect the results
        for future in as_completed(futures):
            results.append(future.result())
        # print the results
        print(*results, sep="\n")


if __name__ == "__main__":
    main()
