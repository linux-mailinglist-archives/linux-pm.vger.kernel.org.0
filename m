Return-Path: <linux-pm+bounces-27482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD28AC0465
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B35A218ED
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6BB1ADC8D;
	Thu, 22 May 2025 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tsjRLGmB"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A428F3;
	Thu, 22 May 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894305; cv=none; b=ASzgWHr38WSYzxuY23b2bKaE2NTJreuzqmDVMi4H09vVrX3J68g+RK5+8emqoGv7ko0hDcw5l6PCtcoTBER5r1OoKVFjHATmq6g84IxMMh7TxgT36D17MeZNr2wCuUhSNmAVpbK+uD6AVlS7J+9FAvU3WnGjjborOrQevskGm/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894305; c=relaxed/simple;
	bh=By3hPiRzdD3IFUzIygmJg9yzZJTN9tlRZmC5lTaquOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeKpJHfFkV3MdW2IgO+Y6TUMJ4C5YlmFu94pNa0pyCyK/9JuFu2A3J+MfBcyskjBr7l0D2kifuEmn0FeAvWOXi6LfE3g9FWjlypmL52q3LeudjzzFt/HhwuPko+ns53cQFPVpTEnQYbaOkfa95odBKkPg9HRdc2CayQn57OsdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tsjRLGmB; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1747894303; x=1779430303;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=By3hPiRzdD3IFUzIygmJg9yzZJTN9tlRZmC5lTaquOs=;
  b=tsjRLGmBWdwN3bNgKX2YEnd7xtmbjYlvdV2xF3UVcdGs+fFB4K//hx9R
   LkT9zWQeH+hOslfQSMkNefVDGRlinT1vL92gPasQf6+8Xlc4dBJwfsGHT
   JeME5adCdMDreWexO21irshmfqnNTVr1VyNXFJkVY3gR1TswbqHuYRNwJ
   MAeIZnvmefz9Owzvj4/TtMXOjygp3Tb9g5kQ5bq4MO04r5JFrcSJth8q5
   YyQa72THbLfwCSObXN1IMU6LtJbJWr2uwY5Or9Ln76fLyMXcbPke8z0DD
   X0IaOFo2gfe/nJpHmoIkElhZrh5n3c19cH322Hr1PCw5OofyDZbEWGAHM
   g==;
X-CSE-ConnectionGUID: 3fCEUfStQtaqSRVeTj8k7g==
X-CSE-MsgGUID: 4s/Q7vGbT/2+USr1R7krNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="179177454"
X-IronPort-AV: E=Sophos;i="6.15,305,1739804400"; 
   d="scan'208";a="179177454"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 15:11:33 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2DA04D5054;
	Thu, 22 May 2025 15:11:31 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0316D17CB6;
	Thu, 22 May 2025 15:11:31 +0900 (JST)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om3.fujitsu.com (Postfix) with ESMTP id A3522400585BA;
	Thu, 22 May 2025 15:11:30 +0900 (JST)
From: Shinji Nomoto <fj5851bi@fujitsu.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Shinji Nomoto <fj5851bi@fujitsu.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpupower: Allow control of boost feature on non-x86 based systems with boost support.
Date: Thu, 22 May 2025 15:10:59 +0900
Message-ID: <20250522061122.2149188-3-fj5851bi@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq subsystem has a generic sysfs interface for controlling boost
(/sys/devices/system/cpu/cpufreq/boost).
The sysfs interface can be used to enable boost control from the cpupower
command on non-x86 platforms as well. So, allow boost controlling
on non-x86 system if boost sysfs file exists.

The set subcommand enables/disables the boost feature using the following
syntax:
    cpupower set --boost 1
    cpupower set --boost 0

The --boost option is an alias for --turbo-boost. We provided the neutral
option name because the name "turbo boost" is specific to Intel technology.

The frequency-info subcommand displays the enabled/disabled state of
the boost feature as follows:
    boost state support:
        Active: yes (or no)

Signed-off-by: Shinji Nomoto <fj5851bi@fujitsu.com>
---
 tools/power/cpupower/man/cpupower-set.1      |  7 +-
 tools/power/cpupower/utils/cpufreq-info.c    | 16 ++++-
 tools/power/cpupower/utils/cpupower-set.c    |  1 +
 tools/power/cpupower/utils/helpers/helpers.h | 14 ++--
 tools/power/cpupower/utils/helpers/misc.c    | 76 ++++++++++++++------
 5 files changed, 81 insertions(+), 33 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-set.1 b/tools/power/cpupower/man/cpupower-set.1
index 500653ef98c7..8ac82b6f9189 100644
--- a/tools/power/cpupower/man/cpupower-set.1
+++ b/tools/power/cpupower/man/cpupower-set.1
@@ -81,10 +81,11 @@ Refer to the AMD P-State kernel documentation for further information.
 .RE
 
 .PP
-\-\-turbo\-boost, \-t
+\-\-turbo\-boost, \-\-boost, \-t
 .RS 4
-This option is used to enable or disable the turbo boost feature on
-supported Intel and AMD processors.
+This option is used to enable or disable the boost feature on
+supported Intel and AMD processors, and other boost supported systems.
+(The --boost option is an alias for the --turbo-boost option)
 
 This option takes as parameter either \fB1\fP to enable, or \fB0\fP to disable the feature.
 
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index fc750e127404..7d3732f5f2f6 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -128,7 +128,7 @@ static int get_boost_mode_x86(unsigned int cpu)
 	/* ToDo: Make this more global */
 	unsigned long pstates[MAX_HW_PSTATES] = {0,};
 
-	ret = cpufreq_has_boost_support(cpu, &support, &active, &b_states);
+	ret = cpufreq_has_x86_boost_support(cpu, &support, &active, &b_states);
 	if (ret) {
 		printf(_("Error while evaluating Boost Capabilities"
 				" on CPU %d -- are you root?\n"), cpu);
@@ -204,6 +204,18 @@ static int get_boost_mode_x86(unsigned int cpu)
 	return 0;
 }
 
+static int get_boost_mode_generic(unsigned int cpu)
+{
+	bool active;
+
+	if (!cpufreq_has_generic_boost_support(&active)) {
+		printf(_("  boost state support:\n"));
+		printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
+	}
+
+	return 0;
+}
+
 /* --boost / -b */
 
 static int get_boost_mode(unsigned int cpu)
@@ -214,6 +226,8 @@ static int get_boost_mode(unsigned int cpu)
 	    cpupower_cpu_info.vendor == X86_VENDOR_HYGON ||
 	    cpupower_cpu_info.vendor == X86_VENDOR_INTEL)
 		return get_boost_mode_x86(cpu);
+	else
+		get_boost_mode_generic(cpu);
 
 	freqs = cpufreq_get_boost_frequencies(cpu);
 	if (freqs) {
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 59ace394cf3e..c2117e5650dd 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -21,6 +21,7 @@ static struct option set_opts[] = {
 	{"epp", required_argument, NULL, 'e'},
 	{"amd-pstate-mode", required_argument, NULL, 'm'},
 	{"turbo-boost", required_argument, NULL, 't'},
+	{"boost", required_argument, NULL, 't'},
 	{ },
 };
 
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 95749b8ee475..82ea62bdf5a2 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -103,6 +103,9 @@ extern struct cpupower_cpu_info cpupower_cpu_info;
 
 /* cpuid and cpuinfo helpers  **************************/
 
+int cpufreq_has_generic_boost_support(bool *active);
+int cpupower_set_turbo_boost(int turbo_boost);
+
 /* X86 ONLY ****************************************/
 #if defined(__i386__) || defined(__x86_64__)
 
@@ -118,7 +121,6 @@ extern unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu);
 
 extern int cpupower_set_epp(unsigned int cpu, char *epp);
 extern int cpupower_set_amd_pstate_mode(char *mode);
-extern int cpupower_set_turbo_boost(int turbo_boost);
 
 /* Read/Write msr ****************************/
 
@@ -139,8 +141,8 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
 
 /* AMD HW pstate decoding **************************/
 
-extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
-				     int *active, int * states);
+int cpufreq_has_x86_boost_support(unsigned int cpu, int *support,
+				  int *active, int *states);
 
 /* AMD P-State stuff **************************/
 bool cpupower_amd_pstate_enabled(void);
@@ -181,13 +183,11 @@ static inline int cpupower_set_epp(unsigned int cpu, char *epp)
 { return -1; };
 static inline int cpupower_set_amd_pstate_mode(char *mode)
 { return -1; };
-static inline int cpupower_set_turbo_boost(int turbo_boost)
-{ return -1; };
 
 /* Read/Write msr ****************************/
 
-static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
-					    int *active, int * states)
+static inline int cpufreq_has_x86_boost_support(unsigned int cpu, int *support,
+						int *active, int *states)
 { return -1; }
 
 static inline bool cpupower_amd_pstate_enabled(void)
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 76e461ff4f74..166dc1e470ea 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -8,15 +8,14 @@
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
 #include "cpufreq.h"
+#include "cpupower_intern.h"
 
 #if defined(__i386__) || defined(__x86_64__)
 
-#include "cpupower_intern.h"
-
 #define MSR_AMD_HWCR	0xc0010015
 
-int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
-			int *states)
+int cpufreq_has_x86_boost_support(unsigned int cpu, int *support, int *active,
+				  int *states)
 {
 	int ret;
 	unsigned long long val;
@@ -124,24 +123,6 @@ int cpupower_set_amd_pstate_mode(char *mode)
 	return 0;
 }
 
-int cpupower_set_turbo_boost(int turbo_boost)
-{
-	char path[SYSFS_PATH_MAX];
-	char linebuf[2] = {};
-
-	snprintf(path, sizeof(path), PATH_TO_CPU "cpufreq/boost");
-
-	if (!is_valid_path(path))
-		return -1;
-
-	snprintf(linebuf, sizeof(linebuf), "%d", turbo_boost);
-
-	if (cpupower_write_sysfs(path, linebuf, 2) <= 0)
-		return -1;
-
-	return 0;
-}
-
 bool cpupower_amd_pstate_enabled(void)
 {
 	char *driver = cpufreq_get_driver(0);
@@ -160,6 +141,39 @@ bool cpupower_amd_pstate_enabled(void)
 
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
 
+int cpufreq_has_generic_boost_support(bool *active)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[2] = {};
+	unsigned long val;
+	char *endp;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpufreq/boost");
+
+	if (!is_valid_path(path))
+		return -EACCES;
+
+	if (cpupower_read_sysfs(path, linebuf, 2) <= 0)
+		return -EINVAL;
+
+	val = strtoul(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return -EINVAL;
+
+	switch (val) {
+	case 0:
+		*active = false;
+		break;
+	case 1:
+		*active = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* get_cpustate
  *
  * Gather the information of all online CPUs into bitmask struct
@@ -259,3 +273,21 @@ void print_speed(unsigned long speed, int no_rounding)
 		}
 	}
 }
+
+int cpupower_set_turbo_boost(int turbo_boost)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[2] = {};
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpufreq/boost");
+
+	if (!is_valid_path(path))
+		return -1;
+
+	snprintf(linebuf, sizeof(linebuf), "%d", turbo_boost);
+
+	if (cpupower_write_sysfs(path, linebuf, 2) <= 0)
+		return -1;
+
+	return 0;
+}
-- 
2.43.0


