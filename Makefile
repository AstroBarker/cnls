NAME=ProjectNarrative
TARGET=$(NAME).pdf
SOURCE=$(NAME).tex
AUX=$(NAME).aux

#FIGS=$(wildcard fig/*.pdf)
#BIBS=$(shell find bibliography/ -name \*.bib)
#PLTS=$(shell find fig -name \*.py -perm +111)

JUNK=.aux .bbl .blg .dvi .log .nav .out .ps .snm .tex.backup .toc Notes.bib

all: $(TARGET)

$(TARGET): $(SOURCE) $(FIGS) .FORCE
	@pdflatex $(SOURCE)
	@bibtex $(NAME)
	@pdflatex $(SOURCE)
	@pdflatex $(SOURCE)

bib: $(SOURCE) $(FIGS) $(BIBS) .FORCE
	-rm $(NAME).bib
	@pdflatex $(SOURCE)
	@bibtool -r $(PTOOLSDIR)/bibtoolrsc -x $(AUX) -i $(PTOOLSDIR)/mainDB.bib -o temp.bib
	@cat *.bib > $(NAME).bib
	@rm temp.bib

clean:
	@for ext in $(JUNK); do\
	    rm -f $(NAME)$$ext;\
	done

quick:  $(SOURCE) $(FIGS) $(BIBS) .FORCE
	@pdflatex $(SOURCE)

milestones: .FORCE
	@pdflatex incite_ccsn_milestones.tex 

.FORCE:
