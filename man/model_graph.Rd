% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_graph.R
\name{model_graph}
\alias{model_graph}
\title{Generate a Graph of Models}
\usage{
model_graph(
  object,
  node_size_by_x = TRUE,
  x = NULL,
  node_size = 5,
  min_size = 5,
  max_size = 35,
  color_original = "lightblue",
  color_add = "burlywood1",
  color_drop = "lightgreen",
  color_others = "lightgrey",
  color_label = "black",
  node_label_size = 1,
  original = "original",
  drop_redundant_direct_paths = TRUE,
  label_arrow_by_df = NULL,
  arrow_label_size = 1,
  weight_arrows_by_df = c("inverse", "normal", "none"),
  arrow_min_width = 0.5,
  arrow_max_width = 2,
  progress = TRUE,
  short_names = FALSE,
  min_bpp_labelled = NULL,
  ...
)
}
\arguments{
\item{object}{Must be a
\code{model_set}-class object for now.}

\item{node_size_by_x}{Logical. Whether
node (vertex) sizes are determined
by a variable. Default is \code{TRUE}.
See \code{x} below on how size is
determined.}

\item{x}{If not \code{NULL}, it should be
a numeric vector of length equal to
the number of models. The node sizes
will be proportional to the values
of \code{x}, offset by \code{min_size}. If
\code{NULL}, the default, the BIC
posterior probabilities
stored in \code{object} will be retrieved.}

\item{node_size}{If \code{node_size_by_x}
is \code{FALSE}, this is the size for
all nodes.}

\item{min_size}{The minimum size
of a node. Default is 5.}

\item{max_size}{The maximum size
of a node. Default is 35.}

\item{color_original}{The color
of node of the original model.
Default is \code{"lightblue"}.}

\item{color_add}{The color of
the nodes of models formed by
adding one or more free parameters to
the original model.
Default is \code{"burlywood1"}.}

\item{color_drop}{The color of
the nodes of models formed by
dropping one or more free parameters
from the original model.
Default is \code{"lightgreen"}.}

\item{color_others}{The color
of other models not specified above.
Default is \code{"grey50"}.}

\item{color_label}{The color of the
text labels of the nodes. Default
is \code{"black"}.}

\item{node_label_size}{The size of
the labels of the nodes. Default is
1.}

\item{original}{String. The name
of the original model (target model).
Default is \code{"original"}.}

\item{drop_redundant_direct_paths}{Logical. Whether the redundant direct
path between two models. A direct path
is redundant if two models are also
connected through at least one
another model. Default is \code{TRUE}.}

\item{label_arrow_by_df}{If \code{TRUE},
then an arrow (edge) is always labelled
by the difference in model \emph{df}s.
If \code{FALSE}, then no arrows are
labelled. If \code{NULL}, then arrows are
labelled when not all differences
in model \emph{df}s are equal to one.
Default is \code{NULL}.}

\item{arrow_label_size}{The size of
the labels of the arrows (edges), if labelled.
Default is 1.}

\item{weight_arrows_by_df}{String.
Use if model \emph{df}
differences are stored.
If \code{"inverse"}, larger the
difference in model \emph{df}, \emph{narrower}
an arrow. That is, more similar two
models are, thicker the arrow. If
\code{"normal"}, larger the difference
in model \emph{df}, \emph{wider} an arrow.
If \code{"none"}, then arrow width is
constant, set to \code{arrow_max_width}.
Default is \code{"inverse"}.}

\item{arrow_min_width}{If
\code{weight_arrows_by_df} is not \code{"none"},
this is the minimum width of an
arrow.}

\item{arrow_max_width}{If
\code{weight_arrows_by_df} is not \code{"none"},
this is the maximum width of an
arrow. If \code{weight_arrows_by_df} is
\code{"none"}, this is the width of all
arrows.}

\item{progress}{Whether a progress
bar will be displayed for some
steps (e.g., checking for nested
relations). Default
is \code{TRUE}.}

\item{short_names}{If \code{TRUE} and
short model names are stored,
they will be used as model labels.
Please print the object with
\code{short_names = TRUE} to find the
corresponding full model names.}

\item{min_bpp_labelled}{If not \code{NULL},
this is the minimum BPP for a model
to be labelled. Models with BPP less
than this value will not be labelled.
Useful when the number of models
is large.}

\item{...}{Optional arguments. Not
used for now.}
}
\value{
A \code{model_graph}-class object that
can be used as as an \code{igraph}-object,
with a plot method (\code{\link[=plot.model_graph]{plot.model_graph()}})
with settings
suitable for plotting a network
of models with BIC posterior probabilities
computed.
}
\description{
Generate an 'igraph' object from a
'model_set' object.
}
\details{
It extracts the model list stored
in \code{object}, creates an adjacency
matrix, and then creates an \code{igraph}
object customized for visualizing
model relations.
\subsection{Construction of the Graph}{

This is the default way to construct
the graph when the model set is
automatically by \code{\link[=model_set]{model_set()}}.
\itemize{
\item Each model is connected by an
arrow, pointing from one model to
another model that

a. can be formed by adding one
or more free parameter, or

b. can be formed by releasing one
or more equality constraint
between two
parameters.

c. has nested relation with this
model as determined by the
method proposed by Bentler
and Satorra (2010), if the
models are not generated
internally.
}

That is, it points to a model with
more degrees of freedom (more
complicated),
and
is nested within that model in either
parameter sense or covariance sense.
\itemize{
\item By default, the size of the node
for each model is scaled by its
BIC posterior probability, if
available. See \emph{The Size of a Node}
below.
\item If a model is designated as the
original (target) model,
than he original model, the models
with
more degrees of freedom than the
original model,
and the models with fewer degrees
of freedom than the original models,
are colored differently.
\item The default layout is the Sugiyama
layout, with simpler models (models
with fewer degrees of freedom) on
the top. The lower a model is in
the network, the more the degrees
of freedom it has. This layout is
suitable for showing the nested
relations of the models. Models on
the same level (layer) horizontally
have the same model \emph{df}.
}

The output is an \code{igraph} object.
Users can customize it in any way
they want using functions from
the \code{igraph} package.

If a model has no nested relation
with all other model, it will not
be connected to other models.

If no model is named \code{original}
(default is \code{"original"}), then no
model is colored as the original model.
}

\subsection{User-Provided Models}{

If \code{object} contained one or more
user-provided models which are not
generated automatically by
\code{\link[=model_set]{model_set()}} or similar functions
(e.g., \code{\link[=gen_models]{gen_models()}}), then the
method by Bentler and Satorra (2010)
will be used to determine model
relations. Models connected by an
arrow has a nested relation based on
the NET method by Bentler and Satorra
(2010). An internal function inspired
by the \code{net} function from the
\code{semTools} package is used to
implement the NET method.
}

\subsection{The Size of a Node}{

When a model is scaled by \code{x},
which usually is the BIC posterior
probability, its size is determined
by:

\code{max_size * (x - min(x))/(max(x) - min(x)) + min_size}
}
}
\examples{

library(lavaan)

mod <-
"
m1 ~ x
y ~ m1
"

fit <- sem(mod, dat_serial_4, fixed.x = TRUE)

out <- model_set(fit)
out

g <- model_graph(out)
plot(g)

}
\references{
Bentler, P. M., & Satorra, A. (2010).
Testing model nesting and equivalence.
\emph{Psychological Methods, 15}(2),
111--123. \doi{10.1037/a0019625}
Asparouhov, T., & Muthén, B. (2019).
Nesting and Equivalence Testing for
Structural Equation Models.
\emph{Structural Equation Modeling: A Multidisciplinary Journal, 26}(2),
302--309. \doi{10.1080/10705511.2018.1513795}
}
\author{
Shu Fai Cheung \url{https://orcid.org/0000-0002-9871-9448}
The internal function for nesting
inspired by the \code{net} function
from the \code{semTools} package,
which was developed by
Terrence D. Jorgensen.
}
