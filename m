Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFC10EC00
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 16:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfLBPAU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 10:00:20 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:48463 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBPAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 10:00:20 -0500
Received: from skinner.arch.suse.de ([195.135.221.2]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRBWU-1iNZgE0im4-00N8fy; Mon, 02 Dec 2019 16:00:10 +0100
From:   trenn@suse.com
To:     linux-pm@vger.kernel.org
Cc:     shuah@kernel.org, Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Revert library ABI changes from commit ae2917093fb60bdc1ed3e
Date:   Mon, 02 Dec 2019 16:00:08 +0100
Message-ID: <36653115.R70aLYaqeR@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:dkK5sS1/9A44N2fwvNWg6Pvb3Cw9H9orPAJKHGeGQ23DBJPhlmO
 JEKtYxToBYxWcWuoOULqOvU1zDeMO+J5s878PqvUANgJEfFmtQkFmonKhHpVuIn0+6dAaIN
 2CiYP9r6GCZ63dIpUxgy5O6ICMGxhKZjOetCu2N6+VrIkwHu+0ivROsU8uGlH8o2cPqf6OL
 YoedI4J65X7sa49Xol2qA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i30eF6LUS6A=:016q8yeXDnYzjB5KLJ6tw0
 g7/wCr0ilp1PNWZnaWZSOWXqJB1IdmyWB2ixocvxrp3xP0S4WMg5cnOHOPCuUHsuCDdwYBNG3
 C3U5Y9uYFh7476Z2/8Cw1rVr45FOc7lcfTrIk+REGPLtqY1hBGlkaGdR3SCi/AhNMJa31gYRT
 YLJyCPB6qIKM3L5Fx7yfwFLKrHmsbDq0PUXB8RIYBG57gbTLkCDs6lofrelSCbIpiylxE5qDH
 3J2QE57sfvwO6O0XpWWfa/7u+/0wFUo7Sx7dW/IzLbaiUXqyq1HGxvPSz8lg43kxo6NNIvaxu
 JnEb77Oiv8pOxMYW8YcpwH2VOqUaoHchul2wXLAln7e0e3N5705bagSnMQA6zbKyz3GE16c2a
 FoGqBz4gZXDzL4oPke1ffAFG7cMtpUlTpwYJ2YAD0UQZN4k6CFdKBdL4liBB09iqK9pUFomrx
 Dm80t2qCV/ZezA0h0t7R2WhZpBeXvTpGh/pzeIJkNd0PujDVYk+D67XO69TfbC0YFabl/p6E5
 BZOxXxN5uHrxx46B6UdrNbDlHcwqtUSsq3zvT5KG1ig/tfx3/9YkNyaWSvkMjHDeZ0bIgqpIz
 zrwF03/Ok/6LJCRrXPOLoHhr/hwjJ08+6kWcediRTnOiCV6CtcwMCcNl+P0An2RiDRd/FQTb9
 K3TqfmcAcD7e05Bjaa1CGG1f3ggRw9shWqfwHhFAFl0hzaEqU2bNS24tUPF4qsNwF7Y9J4U+B
 GuD0lusK1aEjx1ns8no7umXGUy8Pd+f0Cr6DY7fy8GYJFBoRfIXcCVfhN5HHx+Niodf/gW0M1
 O7rgQQnByxxuo6hCj52Zc9TH5K1WodZf1g7/vg7tWJlUvTtEsxd6EdNnr+GBYj4JASJD3X5Ef
 vNDG+Ot0aEKGAFl1A0Ow==
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

Cc: stable@vger.kernel.org

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



