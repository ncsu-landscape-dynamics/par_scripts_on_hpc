library(Rmpi)
library(snow)

print(
    paste(
        "hello world! My host name is", Sys.info()["nodename"],
        "and I'm process #", mpi.comm.rank(), "(the main). There are",
        mpi.universe.size(), "processes including me."
    )
)

whats_my_info <- function(x) {
    print(
        paste(
            "hello world! My host name is", Sys.info()["nodename"],
            "and I'm process #", mpi.comm.rank(),
            ". The main process passed me number", x, "."
        )
    )
}

# you must subtract one from mpi.universe.size() to account for the main process
# when creating the cluster.
n_workers <- mpi.universe.size() - 1
cl <- makeCluster(n_workers, type = "MPI")
results <- parSapply(cl, 1:n_workers, whats_my_info)
print(results)
stopCluster(cl)
mpi.quit()