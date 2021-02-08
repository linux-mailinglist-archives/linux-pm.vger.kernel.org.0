Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8F2313901
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 17:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBHQNC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 11:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhBHQMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 11:12:30 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28519C061788
        for <linux-pm@vger.kernel.org>; Mon,  8 Feb 2021 08:11:50 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id p15so13224276ilq.8
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2021 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=x+689q1sSU4FVeSz7HFNbeWokD7qqnT7HAJPsw9nl0o=;
        b=LcsYV8UW4Yexx1UhkOIBHbLn+oF/epHxEFDXwchV+PhN+giQjkVcr+iRtz2OoAaBE4
         MZpmX3os7069q1U07Wq0/8AU1Cdnt1vUOc08Oq886Dgq3TgeKjUOpmYlr1l7JpsXKdOM
         zZbYQ+Uis3+0UVgqluV60FNT7RAxMr9fC0FSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=x+689q1sSU4FVeSz7HFNbeWokD7qqnT7HAJPsw9nl0o=;
        b=ZraUHwvlanhQ9UJqljk87Ycrsig4mGxuPt7CXqKvK+ecxVvLHzOw++uGpFmheezkjb
         CDXCHe95szQQJpBR7/lTOWFXHkRdhx7JPAndOIAxrhctH90jxCe4rwIsyJwCWFaqFhUe
         t/LIyo0jWm6M441yE5mD621EPncav8kSthfaWjHCyZoZ1FmCyfGxb8xJacf88PVJQUGa
         Ql116M1YaqgioeZu/2otvfhvd8W36WR3I/7fCzHygLbkHJCnxIHZzdhqs1+8Uq5wKjIU
         l50sh7Mqq1ng+p5X2DwivFlSXWXoI/ZGWzJOD5m6T0TXf0PvE/1WxkoOhcVW3jeRfOvH
         gHvQ==
X-Gm-Message-State: AOAM533WLijqW5cIfoDlpwzPMSPVaewlUGBuyYyB/w0f7CmWxvBpTU8c
        5REGOhtPXlavYkWWIXpHo/sfWA==
X-Google-Smtp-Source: ABdhPJz+6Oa9TIwtRNIALWet9YTZiH3norprnsJTKzbiBTzMyIHeOSKZrdRvpPI0Ly0+QvwkZavveQ==
X-Received: by 2002:a05:6e02:1545:: with SMTP id j5mr15977752ilu.296.1612800709586;
        Mon, 08 Feb 2021 08:11:49 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c6sm9191957ioc.26.2021.02.08.08.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 08:11:48 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>, rrichter@amd.com,
        Ivan Babrou <ivan@cloudflare.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.12-rc1
Message-ID: <b2393aa6-747f-56e0-707a-96bfc54d9a0f@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 09:11:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2EC6EF7D04807F078C8A1078"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------2EC6EF7D04807F078C8A1078
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.12-rc1

This cpupower update for Linux 5.12-rc1 consists of:

- Updates to the cpupower command to add support for AMD family 0x19
   and cleanup the code to remove many of the family checks to make
   future family updates easier.

- Adding Makefile dependencies for install targets to allow building
   cpupower in parallel rather than serially.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

   Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.12-rc1

for you to fetch changes up to 3a3ecfdb605cc8d98988012a4f88c34b4d220c21:

   cpupower: Add cpuid cap flag for MSR_AMD_HWCR support (2021-01-26 
09:40:45 -0700)

----------------------------------------------------------------
linux-cpupower-5.12-rc1

This cpupower update for Linux 5.12-rc1 consists of:

- Updates to the cpupower command to add support for AMD family 0x19
   and cleanup the code to remove many of the family checks to make
   future family updates easier.

- Adding Makefile dependencies for install targets to allow building
   cpupower in parallel rather than serially.

----------------------------------------------------------------
Ivan Babrou (1):
       cpupower: add Makefile dependencies for install targets

Nathan Fontenot (7):
       cpupower: Update msr_pstate union struct naming
       cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps flag
       cpupower: Remove unused pscur variable.
       cpupower: Update family checks when decoding HW pstates
       cpupower: Condense pstate enabled bit checks in decode_pstates()
       cpupower: Remove family arg to decode_pstates()
       cpupower: Add cpuid cap flag for MSR_AMD_HWCR support

Robert Richter (1):
       cpupower: Correct macro name for CPB caps flag

  tools/power/cpupower/Makefile                |  8 ++--
  tools/power/cpupower/bench/Makefile          |  2 +-
  tools/power/cpupower/utils/cpufreq-info.c    |  3 +-
  tools/power/cpupower/utils/helpers/amd.c     | 65 
+++++++++++++---------------
  tools/power/cpupower/utils/helpers/cpuid.c   | 20 +++++++--
  tools/power/cpupower/utils/helpers/helpers.h | 14 +++---
  tools/power/cpupower/utils/helpers/misc.c    |  9 +---
  7 files changed, 62 insertions(+), 59 deletions(-)

----------------------------------------------------------------

--------------2EC6EF7D04807F078C8A1078
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.12-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.12-rc1.diff"

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index c7bcddbd486d..3b1594447f29 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -270,14 +270,14 @@ clean:
 	$(MAKE) -C bench O=$(OUTPUT) clean
 
 
-install-lib:
+install-lib: libcpupower
 	$(INSTALL) -d $(DESTDIR)${libdir}
 	$(CP) $(OUTPUT)libcpupower.so* $(DESTDIR)${libdir}/
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
 
-install-tools:
+install-tools: $(OUTPUT)cpupower
 	$(INSTALL) -d $(DESTDIR)${bindir}
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
 	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
@@ -293,14 +293,14 @@ install-man:
 	$(INSTALL_DATA) -D man/cpupower-info.1 $(DESTDIR)${mandir}/man1/cpupower-info.1
 	$(INSTALL_DATA) -D man/cpupower-monitor.1 $(DESTDIR)${mandir}/man1/cpupower-monitor.1
 
-install-gmo:
+install-gmo: create-gmo
 	$(INSTALL) -d $(DESTDIR)${localedir}
 	for HLANG in $(LANGUAGES); do \
 		echo '$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo'; \
 		$(INSTALL_DATA) -D $(OUTPUT)po/$$HLANG.gmo $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	done;
 
-install-bench:
+install-bench: compile-bench
 	@#DESTDIR must be set from outside to survive
 	@sbindir=$(sbindir) bindir=$(bindir) docdir=$(docdir) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT) install
 
diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index f68b4bc55273..d9d9923af85c 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -27,7 +27,7 @@ $(OUTPUT)cpufreq-bench: $(OBJS)
 
 all: $(OUTPUT)cpufreq-bench
 
-install:
+install: $(OUTPUT)cpufreq-bench
 	mkdir -p $(DESTDIR)/$(sbindir)
 	mkdir -p $(DESTDIR)/$(bindir)
 	mkdir -p $(DESTDIR)/$(docdir)
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 6efc0f6b1b11..f9895e31ff5a 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -186,8 +186,7 @@ static int get_boost_mode_x86(unsigned int cpu)
 	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
 	     cpupower_cpu_info.family >= 0x10) ||
 	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
-		ret = decode_pstates(cpu, cpupower_cpu_info.family, b_states,
-				     pstates, &pstate_no);
+		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
 		if (ret)
 			return ret;
 
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 7c4f83a8c973..97f2c857048e 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -13,7 +13,8 @@
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
 
-union msr_pstate {
+union core_pstate {
+	/* pre fam 17h: */
 	struct {
 		unsigned fid:6;
 		unsigned did:3;
@@ -26,7 +27,8 @@ union msr_pstate {
 		unsigned idddiv:2;
 		unsigned res3:21;
 		unsigned en:1;
-	} bits;
+	} pstate;
+	/* since fam 17h: */
 	struct {
 		unsigned fid:8;
 		unsigned did:6;
@@ -35,37 +37,37 @@ union msr_pstate {
 		unsigned idddiv:2;
 		unsigned res1:31;
 		unsigned en:1;
-	} fam17h_bits;
+	} pstatedef;
 	unsigned long long val;
 };
 
-static int get_did(int family, union msr_pstate pstate)
+static int get_did(union core_pstate pstate)
 {
 	int t;
 
-	if (family == 0x12)
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF)
+		t = pstate.pstatedef.did;
+	else if (cpupower_cpu_info.family == 0x12)
 		t = pstate.val & 0xf;
-	else if (family == 0x17 || family == 0x18)
-		t = pstate.fam17h_bits.did;
 	else
-		t = pstate.bits.did;
+		t = pstate.pstate.did;
 
 	return t;
 }
 
-static int get_cof(int family, union msr_pstate pstate)
+static int get_cof(union core_pstate pstate)
 {
 	int t;
 	int fid, did, cof;
 
-	did = get_did(family, pstate);
-	if (family == 0x17 || family == 0x18) {
-		fid = pstate.fam17h_bits.fid;
+	did = get_did(pstate);
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF) {
+		fid = pstate.pstatedef.fid;
 		cof = 200 * fid / did;
 	} else {
 		t = 0x10;
-		fid = pstate.bits.fid;
-		if (family == 0x11)
+		fid = pstate.pstate.fid;
+		if (cpupower_cpu_info.family == 0x11)
 			t = 0x8;
 		cof = (100 * (fid + t)) >> did;
 	}
@@ -74,8 +76,7 @@ static int get_cof(int family, union msr_pstate pstate)
 
 /* Needs:
  * cpu          -> the cpu that gets evaluated
- * cpu_family   -> The cpu's family (0x10, 0x12,...)
- * boots_states -> how much boost states the machines support
+ * boost_states -> how much boost states the machines support
  *
  * Fills up:
  * pstates -> a pointer to an array of size MAX_HW_PSTATES
@@ -85,31 +86,23 @@ static int get_cof(int family, union msr_pstate pstate)
  *
  * returns zero on success, -1 on failure
  */
-int decode_pstates(unsigned int cpu, unsigned int cpu_family,
-		   int boost_states, unsigned long *pstates, int *no)
+int decode_pstates(unsigned int cpu, int boost_states,
+		   unsigned long *pstates, int *no)
 {
-	int i, psmax, pscur;
-	union msr_pstate pstate;
+	int i, psmax;
+	union core_pstate pstate;
 	unsigned long long val;
 
-	/* Only read out frequencies from HW when CPU might be boostable
-	   to keep the code as short and clean as possible.
-	   Otherwise frequencies are exported via ACPI tables.
-	*/
-	if (cpu_family < 0x10 || cpu_family == 0x14)
+	/* Only read out frequencies from HW if HW Pstate is supported,
+	 * otherwise frequencies are exported via ACPI tables.
+	 */
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_HW_PSTATE))
 		return -1;
 
 	if (read_msr(cpu, MSR_AMD_PSTATE_LIMIT, &val))
 		return -1;
 
 	psmax = (val >> 4) & 0x7;
-
-	if (read_msr(cpu, MSR_AMD_PSTATE_STATUS, &val))
-		return -1;
-
-	pscur = val & 0x7;
-
-	pscur += boost_states;
 	psmax += boost_states;
 	for (i = 0; i <= psmax; i++) {
 		if (i >= MAX_HW_PSTATES) {
@@ -119,12 +112,12 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		}
 		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
 			return -1;
-		if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
-			continue;
-		else if (!pstate.bits.en)
+
+		/* The enabled bit (bit 63) is common for all families */
+		if (!pstate.pstatedef.en)
 			continue;
 
-		pstates[i] = get_cof(cpu_family, pstate);
+		pstates[i] = get_cof(pstate);
 	}
 	*no = i;
 	return 0;
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 73bfafc60e9b..72eb43593180 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -128,9 +128,23 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 	/* AMD or Hygon Boost state enable/disable register */
 	if (cpu_info->vendor == X86_VENDOR_AMD ||
 	    cpu_info->vendor == X86_VENDOR_HYGON) {
-		if (ext_cpuid_level >= 0x80000007 &&
-		    (cpuid_edx(0x80000007) & (1 << 9)))
-			cpu_info->caps |= CPUPOWER_CAP_AMD_CBP;
+		if (ext_cpuid_level >= 0x80000007) {
+			if (cpuid_edx(0x80000007) & (1 << 9)) {
+				cpu_info->caps |= CPUPOWER_CAP_AMD_CPB;
+
+				if (cpu_info->family >= 0x17)
+					cpu_info->caps |= CPUPOWER_CAP_AMD_CPB_MSR;
+			}
+
+			if ((cpuid_edx(0x80000007) & (1 << 7)) &&
+			    cpu_info->family != 0x14) {
+				/* HW pstate was not implemented in family 0x14 */
+				cpu_info->caps |= CPUPOWER_CAP_AMD_HW_PSTATE;
+
+				if (cpu_info->family >= 0x17)
+					cpu_info->caps |= CPUPOWER_CAP_AMD_PSTATEDEF;
+			}
+		}
 
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 0642e60a6ce1..33ffacee7fcb 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -64,12 +64,15 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 
 #define CPUPOWER_CAP_INV_TSC		0x00000001
 #define CPUPOWER_CAP_APERF		0x00000002
-#define CPUPOWER_CAP_AMD_CBP		0x00000004
+#define CPUPOWER_CAP_AMD_CPB		0x00000004
 #define CPUPOWER_CAP_PERF_BIAS		0x00000008
 #define CPUPOWER_CAP_HAS_TURBO_RATIO	0x00000010
 #define CPUPOWER_CAP_IS_SNB		0x00000020
 #define CPUPOWER_CAP_INTEL_IDA		0x00000040
 #define CPUPOWER_CAP_AMD_RDPRU		0x00000080
+#define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
+#define CPUPOWER_CAP_AMD_PSTATEDEF	0x00000200
+#define CPUPOWER_CAP_AMD_CPB_MSR	0x00000400
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 
@@ -125,8 +128,8 @@ extern struct pci_dev *pci_slot_func_init(struct pci_access **pacc,
 
 /* AMD HW pstate decoding **************************/
 
-extern int decode_pstates(unsigned int cpu, unsigned int cpu_family,
-			  int boost_states, unsigned long *pstates, int *no);
+extern int decode_pstates(unsigned int cpu, int boost_states,
+			  unsigned long *pstates, int *no);
 
 /* AMD HW pstate decoding **************************/
 
@@ -143,9 +146,8 @@ unsigned int cpuid_edx(unsigned int op);
 /* cpuid and cpuinfo helpers  **************************/
 /* X86 ONLY ********************************************/
 #else
-static inline int decode_pstates(unsigned int cpu, unsigned int cpu_family,
-				 int boost_states, unsigned long *pstates,
-				 int *no)
+static inline int decode_pstates(unsigned int cpu, int boost_states,
+				 unsigned long *pstates, int *no)
 { return -1; };
 
 static inline int read_msr(int cpu, unsigned int idx, unsigned long long *val)
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 650b9a9a6584..fc6e34511721 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -16,17 +16,12 @@
 int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 			int *states)
 {
-	struct cpupower_cpu_info cpu_info;
 	int ret;
 	unsigned long long val;
 
 	*support = *active = *states = 0;
 
-	ret = get_cpu_info(&cpu_info);
-	if (ret)
-		return ret;
-
-	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CBP) {
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB) {
 		*support = 1;
 
 		/* AMD Family 0x17 does not utilize PCI D18F4 like prior
@@ -34,7 +29,7 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 		 * has Hardware determined variable increments instead.
 		 */
 
-		if (cpu_info.family == 0x17 || cpu_info.family == 0x18) {
+		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
 			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
 				if (!(val & CPUPOWER_AMD_CPBDIS))
 					*active = 1;

--------------2EC6EF7D04807F078C8A1078--
