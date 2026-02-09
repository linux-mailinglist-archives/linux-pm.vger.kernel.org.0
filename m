Return-Path: <linux-pm+bounces-42324-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO9IOAtUiWly6wQAu9opvQ
	(envelope-from <linux-pm+bounces-42324-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 04:27:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29310B60D
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7C930056C6
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 03:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426082FBE1F;
	Mon,  9 Feb 2026 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQyAQsbg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A247258ED4;
	Mon,  9 Feb 2026 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770607625; cv=none; b=u8S4/3Ybjx2qD7RxO6yV//XnndFZkg2eLh95NDdzSPgzyrAiu2EwSb08iRxFs6gNB12z4cGNVAUR5a/HXgHK8/d1p0V/ANACy+xBhx67OKga5wI59db5aQx4DrNe5vMsocIHJEbLzi1Ds2epCRz51mjAt69rxPpjFc4eEngg0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770607625; c=relaxed/simple;
	bh=4NjF6tn4oXaoH1DHSInGluQrT1BreEoxiADk5x7Ywv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+0pL0VAKdSsnecPcybiFr2J9Xt9+supg3LbyMhSdgJhIoQaPNIoL5VVQThUjyZbWF7TR1i4NSuLT1PEEJs15efOE9B4HAtNgMyOKw2dmuT59z5HE1dftSIvik4OirRAfRsKA6wMQGUX8HNwNcWV5FTW2gqTUUwUkYyIIgl6wXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQyAQsbg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770607625; x=1802143625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4NjF6tn4oXaoH1DHSInGluQrT1BreEoxiADk5x7Ywv0=;
  b=BQyAQsbgrRGpi89VKC83eUxyC1fjuYTh/eAsaALA78NEAyTtWMyzyLcb
   WV8eMj5KnZQXyDzMyvUk/vvW0WSmWRJO8BevlhxpepiJtviQpyMEvmVG/
   h+v79O/DpQ+UG/8n/Zeq6QVlGrWgFp2u8IfrI5upjUy5g+RzvpIefmHIV
   nlGaQL0osB30FypHn3KyI9ae1oLXo0swjMEsX0TkDs2UzLuxH2qKV9i3j
   RpNIjSxYQj6KUyRn4KKc5XLQIFgtKUkLlGIQ9eERbPBnhdFuS+3fv8NfY
   cMCMESA8H8t5GLBupL72SPV91/i+3ZNMFdH1crrGLYqApSnyN27CgEq0j
   g==;
X-CSE-ConnectionGUID: tKbu6gb9RqC4fg5+kNhdkw==
X-CSE-MsgGUID: oRy91zIuTWSVJBNqpSUW9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71897511"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="71897511"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 19:27:04 -0800
X-CSE-ConnectionGUID: 7Puxe9F8QOSoeS5naZ5Msg==
X-CSE-MsgGUID: VkkudTItS4CdW/qMioWpeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241670406"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.35])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 19:27:01 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com
Cc: fj5851bi@fujitsu.com,
	kaushlendra.kumar@intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: Add intel_pstate turbo boost support for Intel platforms
Date: Mon,  9 Feb 2026 11:24:41 +0800
Message-ID: <20260209032441.489281-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[rui.zhang@intel.com,linux-pm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-42324-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 3A29310B60D
X-Rspamd-Action: no action

On modern Intel platforms, the intel_pstate driver is commonly used and
it provides turbo boost control via
/sys/devices/system/cpu/intel_pstate/no_turbo.

However, cpupower doesn't handle this. it
1. shows turbo boost as "active" blindly for Intel platforms
2. controls turbo boost functionality via the generic
   /sys/devices/system/cpu/cpufreq/boost sysfs interface only.

Enhance the cpupower tool to ensure the "--boost" command works
seamlessly on Intel platforms with intel_pstate driver running.

Without this patch,
   $ echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo
   1
   $ sudo cpupower frequency-info --boost
   analyzing CPU 21:
     boost state support:
       Supported: yes
       Active: yes
   $ sudo cpupower set --boost 0
   Error setting turbo-boost
   $ sudo cpupower set --boost 1
   Error setting turbo-boost

With this patch,
   $ cat /sys/devices/system/cpu/intel_pstate/no_turbo
   0
   $ sudo cpupower set --boost 0
   $ sudo cpupower frequency-info --boost
   analyzing CPU 21:
     boost state support:
       Supported: yes
       Active: no
   $ cat /sys/devices/system/cpu/intel_pstate/no_turbo
   1
   $ sudo cpupower set --boost 1
   $ sudo cpupower frequency-info --boost
   analyzing CPU 28:
     boost state support:
       Supported: yes
       Active: yes
   $ cat /sys/devices/system/cpu/intel_pstate/no_turbo
   0

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/cpupower/utils/cpupower-set.c    |  6 ++-
 tools/power/cpupower/utils/helpers/helpers.h |  5 ++-
 tools/power/cpupower/utils/helpers/misc.c    | 41 +++++++++++++++++++-
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index c2117e5650dd..550a942e72ce 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -124,7 +124,11 @@ int cmd_set(int argc, char **argv)
 	}
 
 	if (params.turbo_boost) {
-		ret = cpupower_set_turbo_boost(turbo_boost);
+		if (cpupower_cpu_info.vendor == X86_VENDOR_INTEL)
+			ret = cpupower_set_intel_turbo_boost(turbo_boost);
+		else
+			ret = cpupower_set_generic_turbo_boost(turbo_boost);
+
 		if (ret)
 			fprintf(stderr, "Error setting turbo-boost\n");
 	}
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 82ea62bdf5a2..a3ad80b9c2c2 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -104,7 +104,7 @@ extern struct cpupower_cpu_info cpupower_cpu_info;
 /* cpuid and cpuinfo helpers  **************************/
 
 int cpufreq_has_generic_boost_support(bool *active);
-int cpupower_set_turbo_boost(int turbo_boost);
+int cpupower_set_generic_turbo_boost(int turbo_boost);
 
 /* X86 ONLY ****************************************/
 #if defined(__i386__) || defined(__x86_64__)
@@ -143,6 +143,7 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
 
 int cpufreq_has_x86_boost_support(unsigned int cpu, int *support,
 				  int *active, int *states);
+int cpupower_set_intel_turbo_boost(int turbo_boost);
 
 /* AMD P-State stuff **************************/
 bool cpupower_amd_pstate_enabled(void);
@@ -189,6 +190,8 @@ static inline int cpupower_set_amd_pstate_mode(char *mode)
 static inline int cpufreq_has_x86_boost_support(unsigned int cpu, int *support,
 						int *active, int *states)
 { return -1; }
+static inline int cpupower_set_intel_turbo_boost(int turbo_boost)
+{ return -1; }
 
 static inline bool cpupower_amd_pstate_enabled(void)
 { return false; }
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 166dc1e470ea..eebfc79a4889 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -19,6 +19,9 @@ int cpufreq_has_x86_boost_support(unsigned int cpu, int *support, int *active,
 {
 	int ret;
 	unsigned long long val;
+	char linebuf[MAX_LINE_LEN];
+	char path[SYSFS_PATH_MAX];
+	char *endp;
 
 	*support = *active = *states = 0;
 
@@ -42,8 +45,42 @@ int cpufreq_has_x86_boost_support(unsigned int cpu, int *support, int *active,
 		}
 	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
 		amd_pstate_boost_init(cpu, support, active);
-	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
+	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA) {
 		*support = *active = 1;
+
+		snprintf(path, sizeof(path), PATH_TO_CPU "intel_pstate/no_turbo");
+
+		if (!is_valid_path(path))
+			return 0;
+
+		if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
+			return -1;
+
+		val = strtol(linebuf, &endp, 0);
+		if (endp == linebuf || errno == ERANGE)
+			return -1;
+
+		*active = !val;
+	}
+	return 0;
+}
+
+int cpupower_set_intel_turbo_boost(int turbo_boost)
+{
+	char path[SYSFS_PATH_MAX];
+	char linebuf[2] = {};
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "intel_pstate/no_turbo");
+
+	/* Fallback to generic solution when intel_pstate driver not running */
+	if (!is_valid_path(path))
+		return cpupower_set_generic_turbo_boost(turbo_boost);
+
+	snprintf(linebuf, sizeof(linebuf), "%d", !turbo_boost);
+
+	if (cpupower_write_sysfs(path, linebuf, 2) <= 0)
+		return -1;
+
 	return 0;
 }
 
@@ -274,7 +311,7 @@ void print_speed(unsigned long speed, int no_rounding)
 	}
 }
 
-int cpupower_set_turbo_boost(int turbo_boost)
+int cpupower_set_generic_turbo_boost(int turbo_boost)
 {
 	char path[SYSFS_PATH_MAX];
 	char linebuf[2] = {};
-- 
2.43.0


