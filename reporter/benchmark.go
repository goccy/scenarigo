package reporter

import "testing"

type benchReporter struct {
	*testing.B
}

func FromB(b *testing.B) Reporter {
	return &benchReporter{b}
}

func (r *benchReporter) Run(name string, f func(b Reporter)) bool {
	f(FromB(r.B))
	return true
}

func (r *benchReporter) Parallel() {

}
