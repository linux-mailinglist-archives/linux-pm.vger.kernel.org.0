Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D465B1404AD
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 08:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAQH4N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 02:56:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:51664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgAQH4N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jan 2020 02:56:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE330AD89;
        Fri, 17 Jan 2020 07:56:10 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     shuah@kernel.org
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v3] cpupower: Revert library ABI changes from commit ae2917093fb60bdc1ed3e
Date:   Fri, 17 Jan 2020 08:55:54 +0100
Message-ID: <1835520.PWyA4J24ZB@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit ae2917093fb60bdc1ed3e modified the library function:
    
struct cpufreq_available_frequencies
*cpufreq_get_available_frequencies(unsigned int cpu)

to
struct cpufreq_frequencies
*cpufreq_get_frequencies(const char *type, unsigned int cpu)

This patch recovers the old API and implements the new functionality
in a newly introduce method:
struct cpufreq_boost_frequencies
*cpufreq_get_available_frequencies(unsigned int cpu)


This one should get merged into stable kernels back to 5.0 when
commit ae2917093fb60bdc1ed3e had been introduced.

Fixes: ae2917093fb6 ("tools/power/cpupower: Display boost frequency 
separately")

Cc: stable@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>

v3: - Add Signed-off tag
v2: - Add fixes: tag
    - Add [PATCH] and cpupower in title

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 2f55d4d23446..6e04304560ca 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -332,21 +332,74 @@ void cpufreq_put_available_governors(struct cpufreq_available_governors *any)
 }
 
 
-struct cpufreq_frequencies
-*cpufreq_get_frequencies(const char *type, unsigned int cpu)
+struct cpufreq_available_frequencies
+*cpufreq_get_available_frequencies(unsigned int cpu)
 {
-	struct cpufreq_frequencies *first = NULL;
-	struct cpufreq_frequencies *current = NULL;
+	struct cpufreq_available_frequencies *first = NULL;
+	struct cpufreq_available_frequencies *current = NULL;
 	char one_value[SYSFS_PATH_MAX];
 	char linebuf[MAX_LINE_LEN];
-	char fname[MAX_LINE_LEN];
 	unsigned int pos, i;
 	unsigned int len;
 
-	snprintf(fname, MAX_LINE_LEN, "scaling_%s_frequencies", type);
+	len = sysfs_cpufreq_read_file(cpu, "scaling_available_frequencies",
+				      linebuf, sizeof(linebuf));
+	if (len == 0)
+		return NULL;
 
-	len = sysfs_cpufreq_read_file(cpu, fname,
-				linebuf, sizeof(linebuf));
+	pos = 0;
+	for (i = 0; i < len; i++) {
+		if (linebuf[i] == ' ' || linebuf[i] == '\n') {
+			if (i - pos < 2)
+				continue;
+			if (i - pos >= SYSFS_PATH_MAX)
+				goto error_out;
+			if (current) {
+				current->next = malloc(sizeof(*current));
+				if (!current->next)
+					goto error_out;
+				current = current->next;
+			} else {
+				first = malloc(sizeof(*first));
+				if (!first)
+					goto error_out;
+				current = first;
+			}
+			current->first = first;
+			current->next = NULL;
+
+			memcpy(one_value, linebuf + pos, i - pos);
+			one_value[i - pos] = '\0';
+			if (sscanf(one_value, "%lu", &current->frequency) != 1)
+				goto error_out;
+
+			pos = i + 1;
+		}
+	}
+
+	return first;
+
+ error_out:
+	while (first) {
+		current = first->next;
+		free(first);
+		first = current;
+	}
+	return NULL;
+}
+
+struct cpufreq_available_frequencies
+*cpufreq_get_boost_frequencies(unsigned int cpu)
+{
+	struct cpufreq_available_frequencies *first = NULL;
+	struct cpufreq_available_frequencies *current = NULL;
+	char one_value[SYSFS_PATH_MAX];
+	char linebuf[MAX_LINE_LEN];
+	unsigned int pos, i;
+	unsigned int len;
+
+	len = sysfs_cpufreq_read_file(cpu, "scaling_boost_frequencies",
+				      linebuf, sizeof(linebuf));
 	if (len == 0)
 		return NULL;
 
@@ -391,9 +444,9 @@ struct cpufreq_frequencies
 	return NULL;
 }
 
-void cpufreq_put_frequencies(struct cpufreq_frequencies *any)
+void cpufreq_put_available_frequencies(struct cpufreq_available_frequencies *any)
 {
-	struct cpufreq_frequencies *tmp, *next;
+	struct cpufreq_available_frequencies *tmp, *next;
 
 	if (!any)
 		return;
@@ -406,6 +459,11 @@ void cpufreq_put_frequencies(struct cpufreq_frequencies *any)
 	}
 }
 
+void cpufreq_put_boost_frequencies(struct cpufreq_available_frequencies *any)
+{
+	cpufreq_put_available_frequencies(any);
+}
+
 static struct cpufreq_affected_cpus *sysfs_get_cpu_list(unsigned int cpu,
 							const char *file)
 {
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index a55f0d19215b..95f4fd9e2656 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -20,10 +20,10 @@ struct cpufreq_available_governors {
 	struct cpufreq_available_governors *first;
 };
 
-struct cpufreq_frequencies {
+struct cpufreq_available_frequencies {
 	unsigned long frequency;
-	struct cpufreq_frequencies *next;
-	struct cpufreq_frequencies *first;
+	struct cpufreq_available_frequencies *next;
+	struct cpufreq_available_frequencies *first;
 };
 
 
@@ -124,11 +124,17 @@ void cpufreq_put_available_governors(
  * cpufreq_put_frequencies after use.
  */
 
-struct cpufreq_frequencies
-*cpufreq_get_frequencies(const char *type, unsigned int cpu);
+struct cpufreq_available_frequencies
+*cpufreq_get_available_frequencies(unsigned int cpu);
 
-void cpufreq_put_frequencies(
-		struct cpufreq_frequencies *first);
+void cpufreq_put_available_frequencies(
+		struct cpufreq_available_frequencies *first);
+
+struct cpufreq_available_frequencies
+*cpufreq_get_boost_frequencies(unsigned int cpu);
+
+void cpufreq_put_boost_frequencies(
+		struct cpufreq_available_frequencies *first);
 
 
 /* determine affected CPUs
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index e63cf55f81cf..6efc0f6b1b11 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -244,14 +244,14 @@ static int get_boost_mode_x86(unsigned int cpu)
 
 static int get_boost_mode(unsigned int cpu)
 {
-	struct cpufreq_frequencies *freqs;
+	struct cpufreq_available_frequencies *freqs;
 
 	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD ||
 	    cpupower_cpu_info.vendor == X86_VENDOR_HYGON ||
 	    cpupower_cpu_info.vendor == X86_VENDOR_INTEL)
 		return get_boost_mode_x86(cpu);
 
-	freqs = cpufreq_get_frequencies("boost", cpu);
+	freqs = cpufreq_get_boost_frequencies(cpu);
 	if (freqs) {
 		printf(_("  boost frequency steps: "));
 		while (freqs->next) {
@@ -261,7 +261,7 @@ static int get_boost_mode(unsigned int cpu)
 		}
 		print_speed(freqs->frequency);
 		printf("\n");
-		cpufreq_put_frequencies(freqs);
+		cpufreq_put_available_frequencies(freqs);
 	}
 
 	return 0;
@@ -475,7 +475,7 @@ static int get_latency(unsigned int cpu, unsigned int human)
 
 static void debug_output_one(unsigned int cpu)
 {
-	struct cpufreq_frequencies *freqs;
+	struct cpufreq_available_frequencies *freqs;
 
 	get_driver(cpu);
 	get_related_cpus(cpu);
@@ -483,7 +483,7 @@ static void debug_output_one(unsigned int cpu)
 	get_latency(cpu, 1);
 	get_hardware_limits(cpu, 1);
 
-	freqs = cpufreq_get_frequencies("available", cpu);
+	freqs = cpufreq_get_available_frequencies(cpu);
 	if (freqs) {
 		printf(_("  available frequency steps:  "));
 		while (freqs->next) {
@@ -493,7 +493,7 @@ static void debug_output_one(unsigned int cpu)
 		}
 		print_speed(freqs->frequency);
 		printf("\n");
-		cpufreq_put_frequencies(freqs);
+		cpufreq_put_available_frequencies(freqs);
 	}
 
 	get_available_governors(cpu);





