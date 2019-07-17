Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85346B6A9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfGQGaK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:30:10 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:34509 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQGaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:30:10 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 02:30:04 EDT
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-06.nifty.com with ESMTP id x6H6IkIs006709
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 15:18:46 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6H6I5Ol009435;
        Wed, 17 Jul 2019 15:18:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6H6I5Ol009435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563344292;
        bh=krZ6W+tHWJH7GffyTlc7LmZ013xkArEQ4cWHwqkczlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1UUbokfuSiom8ybRWL4NLaySYXk9YGt5C6zZmBwZrHiNY25DkHy9ZCk3z9Ax+bB9
         FIeWNPbolvDXCso6FTpmEtCTN3La8KWotw7YxepnqAfbxZR4e3VsYeuS0CJSuZUirY
         wNvi9UE5dpfFdO8FR1mcSyBoWqImXIQF2L9gBdkAGN/GvfuIwZ/rZr4m702R7+HgbJ
         ta2xoY73n7Yz1CwgqxTos+tNOY8dWfFfEWeWyifbtv31DrNC7Jm0ku2o/zQ4OLf2wg
         EQpWQ8HlASCNVxsyiQ12NIezVkPfz91Heb7vyhcIj1Yy7Kw8RBv7Ztxng+pAz8LHGF
         LwvF99gkXXpKw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 09/12] kbuild: create *.mod with full directory path and remove MODVERDIR
Date:   Wed, 17 Jul 2019 15:17:57 +0900
Message-Id: <20190717061800.10018-10-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717061800.10018-1-yamada.masahiro@socionext.com>
References: <20190717061800.10018-1-yamada.masahiro@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While descending directories, Kbuild produces objects for modules,
but do not link final *.ko files; it is done in the modpost.

To keep track of modules, Kbuild creates a *.mod file in $(MODVERDIR)
for every module it is building. Some post-processing steps read the
necessary information from *.mod files. This avoids descending into
directories again. This mechanism was introduced in 2003 or so.

Later, commit 551559e13af1 ("kbuild: implement modules.order") added
modules.order. So, we can simply read it out to know all the modules
with directory paths. This is easier than parsing the first line of
*.mod files.

$(MODVERDIR) has a flat directory structure, that is, *.mod files
are named only with base names. This is based on the assumption that
the module name is unique across the tree. This assumption is really
fragile.

Stephen Rothwell reported a race condition caused by a module name
conflict:

  https://lkml.org/lkml/2019/5/13/991

In parallel building, two different threads could write to the same
$(MODVERDIR)/*.mod simultaneously.

Non-unique module names are the source of all kind of troubles, hence
commit 3a48a91901c5 ("kbuild: check uniqueness of module names")
introduced a new checker script.

However, it is still fragile in the build system point of view because
this race happens before scripts/modules-check.sh is invoked. If it
happens again, the modpost will emit unclear error messages.

To fix this issue completely, create *.mod with full directory path
so that two threads never attempt to write to the same file.

$(MODVERDIR) is no longer needed.

Since modules with directory paths are listed in modules.order, Kbuild
is still able to find *.mod files without additional descending.

I also killed cmd_secanalysis; scripts/mod/sumversion.c computes MD4 hash
for modules with MODULE_VERSION(). When CONFIG_DEBUG_SECTION_MISMATCH=y,
it occurs not only in the modpost stage, but also during directory
descending, where sumversion.c may parse stale *.mod files. It would emit
'No such file or directory' warning when an object consisting a module is
renamed, or when a single-obj module is turned into a multi-obj module or
vice versa.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---

Changes in v3:
  - Fix build error of allnoconfig
  - Remove cmd_secanalysis
  - Fix up comment in scripts/adjust_autoksyms.sh
  - Fix up tools/power/cpupower/debug/kernel/Makefile

Changes in v2:
  - Remove -r of xargs, which is a GNU extension
  - Add '--' for extra safety

 .gitignore                                 |  1 +
 Documentation/dontdiff                     |  1 +
 Makefile                                   | 20 +++-----------------
 lib/Kconfig.debug                          | 12 +-----------
 scripts/Makefile.build                     | 15 +++------------
 scripts/Makefile.modpost                   |  4 ++--
 scripts/adjust_autoksyms.sh                | 14 +++++---------
 scripts/mod/sumversion.c                   | 16 +++-------------
 scripts/package/mkspec                     |  2 +-
 tools/power/cpupower/debug/kernel/Makefile |  4 ++--
 10 files changed, 22 insertions(+), 67 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7587ef56b92d..8f5422cba6e2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,7 @@
 *.lz4
 *.lzma
 *.lzo
+*.mod
 *.mod.c
 *.o
 *.o.*
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 5eba889ea84d..9f4392876099 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -30,6 +30,7 @@
 *.lzo
 *.mo
 *.moc
+*.mod
 *.mod.c
 *.o
 *.o.*
diff --git a/Makefile b/Makefile
index 396cd5e525d1..9ad9f8d1130d 100644
--- a/Makefile
+++ b/Makefile
@@ -486,11 +486,6 @@ export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export KBUILD_ARFLAGS
 
-# When compiling out-of-tree modules, put MODVERDIR in the module
-# tree rather than in the kernel tree. The kernel tree might
-# even be read-only.
-export MODVERDIR := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_versions
-
 # Files to ignore in find ... statements
 
 export RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o    \
@@ -1029,8 +1024,8 @@ vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
 
 # Recurse until adjust_autoksyms.sh is satisfied
 PHONY += autoksyms_recursive
-autoksyms_recursive: $(vmlinux-deps)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
+autoksyms_recursive: $(vmlinux-deps) modules.order
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
 	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
 endif
@@ -1113,7 +1108,6 @@ endif
 
 prepare1: prepare3 outputmakefile asm-generic $(version_h) $(autoksyms_h) \
 						include/generated/utsrelease.h
-	$(cmd_crmodverdir)
 
 archprepare: archheaders archscripts prepare1 scripts
 
@@ -1371,7 +1365,7 @@ endif # CONFIG_MODULES
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_DIRS  += $(MODVERDIR) include/ksym
+CLEAN_DIRS  += include/ksym
 CLEAN_FILES += modules.builtin.modinfo
 
 # Directories & files removed with 'make mrproper'
@@ -1641,7 +1635,6 @@ PHONY += $(clean-dirs) clean
 $(clean-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
 
-clean:	rm-dirs := $(MODVERDIR)
 clean: rm-files := $(KBUILD_EXTMOD)/Module.symvers
 
 PHONY += help
@@ -1655,8 +1648,6 @@ help:
 	@echo  ''
 
 PHONY += prepare
-prepare:
-	$(cmd_crmodverdir)
 endif # KBUILD_EXTMOD
 
 clean: $(clean-dirs)
@@ -1667,7 +1658,7 @@ clean: $(clean-dirs)
 		-o -name '*.ko.*' \
 		-o -name '*.dtb' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
 		-o -name '*.dwo' -o -name '*.lst' \
-		-o -name '*.su'  \
+		-o -name '*.su' -o -name '*.mod' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
@@ -1796,11 +1787,6 @@ quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
       cmd_depmod = $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DEPMOD) \
                    $(KERNELRELEASE)
 
-# Create temporary dir for module support files
-# clean it up only when building all modules
-cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
-                  $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)
-
 # read saved command lines for existing targets
 existing-targets := $(wildcard $(sort $(targets)))
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4ac4ca21a30a..cde5675340ba 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -353,23 +353,13 @@ config DEBUG_SECTION_MISMATCH
 	  which results in the code/data being placed in specific sections.
 	  The section mismatch analysis is always performed after a full
 	  kernel build, and enabling this option causes the following
-	  additional steps to occur:
+	  additional step to occur:
 	  - Add the option -fno-inline-functions-called-once to gcc commands.
 	    When inlining a function annotated with __init in a non-init
 	    function, we would lose the section information and thus
 	    the analysis would not catch the illegal reference.
 	    This option tells gcc to inline less (but it does result in
 	    a larger kernel).
-	  - Run the section mismatch analysis for each module/built-in.a file.
-	    When we run the section mismatch analysis on vmlinux.o, we
-	    lose valuable information about where the mismatch was
-	    introduced.
-	    Running the analysis for each module/built-in.a file
-	    tells where the mismatch happens much closer to the
-	    source. The drawback is that the same mismatch is
-	    reported at least twice.
-	  - Enable verbose reporting from modpost in order to help resolve
-	    the section mismatches that are reported.
 
 config SECTION_MISMATCH_WARN_ONLY
 	bool "Make section mismatch errors non-fatal"
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index be32a3752de4..c6dfcc028f56 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -67,8 +67,6 @@ ifeq ($(CONFIG_MODULES)$(need-modorder),y1)
 modorder-target := $(obj)/modules.order
 endif
 
-# We keep a list of all modules in $(MODVERDIR)
-
 __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
 	 $(if $(KBUILD_MODULES),$(obj-m) $(modorder-target)) \
 	 $(subdir-ym) $(always)
@@ -87,11 +85,6 @@ ifneq ($(KBUILD_ENABLE_EXTRA_GCC_CHECKS),)
   cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
 endif
 
-# Do section mismatch analysis for each module/built-in.a
-ifdef CONFIG_DEBUG_SECTION_MISMATCH
-  cmd_secanalysis = ; scripts/mod/modpost $@
-endif
-
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------
 
@@ -278,13 +271,11 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
-# Single-part modules are special since we need to mark them in $(MODVERDIR)
-
 $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 	@{ echo $(@:.o=.ko); echo $@; \
-	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
+	   $(cmd_undef_syms); } > $(patsubst %.o,%.mod,$@)
 
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
@@ -461,12 +452,12 @@ endif
 # module is turned into a multi object module, $^ will contain header file
 # dependencies recorded in the .*.cmd file.
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis)
+      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
 	@{ echo $(@:.o=.ko); echo $(filter %.o,$^); \
-	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
+	   $(cmd_undef_syms); } > $(patsubst %.o,%.mod,$@)
 $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
 
 targets += $(multi-used-m)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 5841508ffca9..6b19c1a4eae5 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -6,8 +6,8 @@
 # Stage one of module building created the following:
 # a) The individual .o files used for the module
 # b) A <module>.o file which is the .o files above linked together
-# c) A <module>.mod file in $(MODVERDIR)/, listing the name of the
-#    the preliminary <module>.o file, plus all .o files
+# c) A <module>.mod file, listing the name of the preliminary <module>.o file,
+#    plus all .o files
 # d) modules.order, which lists all the modules
 
 # Stage 2 is handled by this file and does the following
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index aab4e299d7a2..2e4a7320bfb4 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -8,8 +8,7 @@
 #
 
 # Create/update the include/generated/autoksyms.h file from the list
-# of all module's needed symbols as recorded on the third line of
-# .tmp_versions/*.mod files.
+# of all module's needed symbols as recorded on the third line of *.mod files.
 #
 # For each symbol being added or removed, the corresponding dependency
 # file's timestamp is updated to force a rebuild of the affected source
@@ -47,13 +46,10 @@ cat > "$new_ksyms_file" << EOT
  */
 
 EOT
-[ "$(ls -A "$MODVERDIR")" ] &&
-for mod in "$MODVERDIR"/*.mod; do
-	sed -n -e '3{s/ /\n/g;/^$/!p;}' "$mod"
-done | sort -u |
-while read sym; do
-	echo "#define __KSYM_${sym} 1"
-done >> "$new_ksyms_file"
+sed 's/ko$/mod/' modules.order |
+xargs -n1 sed -n -e '3{s/ /\n/g;/^$/!p;}' -- |
+sort -u |
+sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
 
 # Special case for modversions (see modpost.c)
 if [ -n "$CONFIG_MODVERSIONS" ]; then
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 0f6dcb4011a8..166f3fa247a9 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -396,21 +396,11 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 	unsigned long len;
 	struct md4_ctx md;
 	char *sources, *end, *fname;
-	const char *basename;
 	char filelist[PATH_MAX + 1];
-	char *modverdir = getenv("MODVERDIR");
 
-	if (!modverdir)
-		modverdir = ".";
-
-	/* Source files for module are in .tmp_versions/modname.mod,
-	   after the first line. */
-	if (strrchr(modname, '/'))
-		basename = strrchr(modname, '/') + 1;
-	else
-		basename = modname;
-	snprintf(filelist, sizeof(filelist), "%s/%.*s.mod", modverdir,
-		(int) strlen(basename) - 2, basename);
+	/* objects for a module are listed in the second line of *.mod file. */
+	snprintf(filelist, sizeof(filelist), "%.*smod",
+		 (int)strlen(modname) - 1, modname);
 
 	file = grab_file(filelist, &len);
 	if (!file)
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 2d29df4a0a53..8640c278f1aa 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -29,7 +29,7 @@ fi
 
 PROVIDES="$PROVIDES kernel-$KERNELRELEASE"
 __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
-EXCLUDES="$RCS_TAR_IGNORE --exclude=.tmp_versions --exclude=*vmlinux* \
+EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 --exclude=*.o --exclude=*.ko --exclude=*.cmd --exclude=Documentation \
 --exclude=.config.old --exclude=.missing-syscalls.d --exclude=*.s"
 
diff --git a/tools/power/cpupower/debug/kernel/Makefile b/tools/power/cpupower/debug/kernel/Makefile
index c23e5a6ceb7e..7b5c43684be1 100644
--- a/tools/power/cpupower/debug/kernel/Makefile
+++ b/tools/power/cpupower/debug/kernel/Makefile
@@ -12,8 +12,8 @@ default:
 	$(MAKE) -C $(KDIR) M=$(CURDIR)
 
 clean:
-	- rm -rf *.o *.ko .tmp-versions .*.cmd .*.mod.* *.mod.c
-	- rm -rf .tmp_versions* Module.symvers modules.order
+	- rm -rf *.o *.ko .*.cmd .*.mod.* *.mod.c
+	- rm -rf Module.symvers modules.order
 
 install: default
 	install -d $(KMISC)
-- 
2.17.1

