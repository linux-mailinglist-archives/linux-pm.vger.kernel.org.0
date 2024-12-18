Return-Path: <linux-pm+bounces-19451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CAD9F6DDD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F67618890B6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71B1FC0F7;
	Wed, 18 Dec 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ+MlRtA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1771FAC40
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549129; cv=none; b=hqSPEjFbOcf3AqUUU+jUZp43v+TyGvG+f98bEg200hkIDYaBzFX1uU/E2Iy+l2/2xeB0WippkZS2XptGuHoRWlA62X5p/C4c8LRGge7lbtbtBDDhPxr2ls+OBenHjk9Igl7gym3XgXZWgPRwDM9Ddmj4Pf5dHcSCRe7TVpIsxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549129; c=relaxed/simple;
	bh=RBlJn7kJazVA2Z7Y7DdRGx8zUnRq8xka3qeIQ7oNXXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWcWh3XRTcvKaJHpjwX0M2rFUFkNhA12ao7cp/iTCsJvQsWpwaWNwukjlwZ1RWT7WwVnmGhmWAu8iAgPqUmC5B2MO30Om9XyzMH2MMmdFVWoPo0dDXhqqGNe1P5/zUIPvZjel8FnnIne7El7xXxBRZ6JWQ9+bAL3WBvk0ZXutUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ+MlRtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8DFC4CECD;
	Wed, 18 Dec 2024 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734549129;
	bh=RBlJn7kJazVA2Z7Y7DdRGx8zUnRq8xka3qeIQ7oNXXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJ+MlRtA11Dx0Ptk9nRGDhC1rq5feKTm1tzlmbB/zrBuMOjZ0Dn1iCFiYvSTCVjGm
	 sLWMkpWKip6/8u0E7TvePFMOoeObc6AsweqFN/dw1LzCi9EmqK+CsiTkKbvZuUul7v
	 aCotTCQK9ek8R3RCC6Yt3QlPMSEsGfk3Mbrrjv/WkK0/aKJvEnonsqKjA66eygk1XF
	 CWw+xhBGYfz7sbnl3TKeDXxsvxK3JeCROWQMV+2drg70I2VZm3GUb/nce3TbCIHB2O
	 DDQObWLyty362TgdpiOA/R8iBUFiQKkl9FOGECWkbAJR0usxKw6WP+WkFSdnxkz5NT
	 3LGH7mx1q4xjQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 5/7] cpupower: Add support for showing energy performance preference
Date: Wed, 18 Dec 2024 13:09:54 -0600
Message-ID: <20241218191144.3440854-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218191144.3440854-1-superm1@kernel.org>
References: <20241218191144.3440854-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The EPP value is useful for characterization of performance. Show
it in cpupower frequency-info output.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/power/cpupower/lib/cpufreq.c        | 14 +++++++++++++
 tools/power/cpupower/lib/cpufreq.h        |  8 ++++++++
 tools/power/cpupower/utils/cpufreq-info.c | 25 ++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index f27ee6d4b000c..8dda3db2dff0e 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -127,12 +127,14 @@ static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
 enum cpufreq_string {
 	SCALING_DRIVER,
 	SCALING_GOVERNOR,
+	ENERGY_PERFORMANCE_PREFERENCE,
 	MAX_CPUFREQ_STRING_FILES
 };
 
 static const char *cpufreq_string_files[MAX_CPUFREQ_STRING_FILES] = {
 	[SCALING_DRIVER] = "scaling_driver",
 	[SCALING_GOVERNOR] = "scaling_governor",
+	[ENERGY_PERFORMANCE_PREFERENCE] = "energy_performance_preference",
 };
 
 
@@ -207,6 +209,18 @@ unsigned long cpufreq_get_transition_latency(unsigned int cpu)
 	return sysfs_cpufreq_get_one_value(cpu, CPUINFO_LATENCY);
 }
 
+char *cpufreq_get_energy_performance_preference(unsigned int cpu)
+{
+	return sysfs_cpufreq_get_one_string(cpu, ENERGY_PERFORMANCE_PREFERENCE);
+}
+
+void cpufreq_put_energy_performance_preference(char *ptr)
+{
+	if (!ptr)
+		return;
+	free(ptr);
+}
+
 int cpufreq_get_hardware_limits(unsigned int cpu,
 				unsigned long *min,
 				unsigned long *max)
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 2f3c840358063..bfc617311ebd6 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -68,6 +68,14 @@ unsigned long cpufreq_get_freq_hardware(unsigned int cpu);
 unsigned long cpufreq_get_transition_latency(unsigned int cpu);
 
 
+/* determine energy performance preference
+ *
+ * returns NULL on failure, else the string that represents the energy performance
+ * preference requested.
+ */
+char *cpufreq_get_energy_performance_preference(unsigned int cpu);
+void cpufreq_put_energy_performance_preference(char *ptr);
+
 /* determine hardware CPU frequency limits
  *
  * These may be limited further by thermal, energy or other
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 3df28e45be421..eb9cc0f106342 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -422,6 +422,23 @@ static int get_freq_stats(unsigned int cpu, unsigned int human)
 	return 0;
 }
 
+/* --epp / -z */
+
+static int get_epp(unsigned int cpu, bool interactive)
+{
+	char *epp;
+
+	epp = cpufreq_get_energy_performance_preference(cpu);
+	if (!epp)
+		return -EINVAL;
+	if (interactive)
+		printf(_("  energy performance preference: %s\n"), epp);
+
+	cpufreq_put_energy_performance_preference(epp);
+
+	return 0;
+}
+
 /* --latency / -y */
 
 static int get_latency(unsigned int cpu, unsigned int human)
@@ -461,6 +478,7 @@ static void debug_output_one(unsigned int cpu)
 	get_related_cpus(cpu);
 	get_affected_cpus(cpu);
 	get_latency(cpu, 1);
+	get_epp(cpu, true);
 	get_hardware_limits(cpu, 1);
 
 	freqs = cpufreq_get_available_frequencies(cpu);
@@ -501,6 +519,7 @@ static struct option info_opts[] = {
 	{"human",	 no_argument,		 NULL,	 'm'},
 	{"no-rounding", no_argument,	 NULL,	 'n'},
 	{"performance", no_argument,	 NULL,	 'c'},
+	{"epp",		 no_argument,		 NULL,	 'z'},
 	{ },
 };
 
@@ -514,7 +533,7 @@ int cmd_freq_info(int argc, char **argv)
 	int output_param = 0;
 
 	do {
-		ret = getopt_long(argc, argv, "oefwldpgrasmybnc", info_opts,
+		ret = getopt_long(argc, argv, "oefwldpgrasmybncz", info_opts,
 				  NULL);
 		switch (ret) {
 		case '?':
@@ -538,6 +557,7 @@ int cmd_freq_info(int argc, char **argv)
 		case 's':
 		case 'y':
 		case 'c':
+		case 'z':
 			if (output_param) {
 				output_param = -1;
 				cont = 0;
@@ -647,6 +667,9 @@ int cmd_freq_info(int argc, char **argv)
 		case 'c':
 			ret = get_perf_cap(cpu);
 			break;
+		case 'z':
+			ret = get_epp(cpu, true);
+			break;
 		}
 		if (ret)
 			return ret;
-- 
2.43.0


