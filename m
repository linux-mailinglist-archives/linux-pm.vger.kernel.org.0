Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC014BFF1
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 19:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgA1SgD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 13:36:03 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:38969 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgA1SgD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 13:36:03 -0500
Received: by mail-io1-f41.google.com with SMTP id c16so15562327ioh.6
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2020 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=HGMVyBRslBoDXkOLtZnv7IYjm94HHcEjYHLxlYe5nro=;
        b=IRvFjnMhktU1a6MUD8Xcx87RK39EuoR2WFky7KZY0NwSQ67jnjfiFTvB7ulrOVzf9s
         QGPEuxOFMKww5c6pZ2UMa1IoW/zH0Tt1fJgy7g7b5Np85KoiJRudcEFA0JyBDjKzW0G2
         Ah4AKbEzB5a9aucETQCjgTZUpg5u1X8jddp90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=HGMVyBRslBoDXkOLtZnv7IYjm94HHcEjYHLxlYe5nro=;
        b=IbJsr9G4tdzYuUkzWDQiIg/FN520oHnPgTrBJeCsh0Z5hXTxP7Ng6MHMZqOPCKphnL
         +mZp/FhVhT+C8hkk0s3lWBh0ZQSixpIVjrr/TQE15bjACzcTsRts/vozrD7QuVgOT/Oj
         HJqr5MDxgEwCSZCCVWDrEX9dEs7bYWgHOAGVuPxzKkz0JESa8zR+Hom5TS+TjCqMg62U
         qF4I5Jzd/2ZAxUKSWH3Eve73gSAOMRtvbu4SWKlILVFrLLZ0qlhXtlPv6SPThQFc3Atm
         kmaFsZILYOZ7RHtkfq9qlRgj38uUdEeL2gFZNwnzxKiC7y0Iw8nD9odYz+RpyLhryZGh
         aR1g==
X-Gm-Message-State: APjAAAVMyIgT6I//CFBBz88AvYdtNF5cv834Qn/UpXzcori1udOoWdu3
        3u3yuOGe7g9aG/daf2tcYbixdzjOhUg=
X-Google-Smtp-Source: APXvYqwd5SIBMidfWS1x33h4ytVFOL5R0O8El+cz4EvAiSK6KbzvtHDg2owDc1hlc7q9feJz/sWMcw==
X-Received: by 2002:a6b:8ec9:: with SMTP id q192mr18318115iod.237.1580236562084;
        Tue, 28 Jan 2020 10:36:02 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v3sm1916908ili.0.2020.01.28.10.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 10:36:01 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, latha@linux.vnet.ibm.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.6-rc1
Message-ID: <7c92807e-073e-c2a1-e229-9b5d5dd24f14@linuxfoundation.org>
Date:   Tue, 28 Jan 2020 11:36:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7D88E2DF8230E1D817EE4FF0"
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------7D88E2DF8230E1D817EE4FF0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following update for Linux 5.6-rc1.

This cpupower update for Linux 5.6-rc1 consists of a revert from
Thomas Renninger and a manpage correction from Brahadambal Srinivasan.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

   Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.6-rc1

for you to fetch changes up to 8c30fa7666ff08dad632411d1a9b9883940e53ef:

   Correction to manpage of cpupower (2020-01-27 08:43:31 -0700)

----------------------------------------------------------------
linux-cpupower-5.6-rc1

This cpupower update for Linux 5.6-rc1 consists of a revert from
Thomas Renninger and a manpage correction from Brahadambal Srinivasan.

----------------------------------------------------------------
Brahadambal Srinivasan (1):
       Correction to manpage of cpupower

Thomas Renninger (1):
       cpupower: Revert library ABI changes from commit 
ae2917093fb60bdc1ed3e

  tools/power/cpupower/lib/cpufreq.c        | 78 
+++++++++++++++++++++++++++----
  tools/power/cpupower/lib/cpufreq.h        | 20 +++++---
  tools/power/cpupower/man/cpupower.1       |  6 +--
  tools/power/cpupower/utils/cpufreq-info.c | 12 ++---
  4 files changed, 90 insertions(+), 26 deletions(-)

----------------------------------------------------------------

--------------7D88E2DF8230E1D817EE4FF0
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.6-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.6-rc1.diff"

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
diff --git a/tools/power/cpupower/man/cpupower.1 b/tools/power/cpupower/man/cpupower.1
index baf741d06e82..a5e4523a219b 100644
--- a/tools/power/cpupower/man/cpupower.1
+++ b/tools/power/cpupower/man/cpupower.1
@@ -62,9 +62,9 @@ all cores
 Print the package name and version number.
 
 .SH "SEE ALSO"
-cpupower-set(1), cpupower-info(1), cpupower-idle(1),
-cpupower-frequency-set(1), cpupower-frequency-info(1), cpupower-monitor(1),
-powertop(1)
+cpupower-set(1), cpupower-info(1), cpupower-idle-info(1),
+cpupower-idle-set(1), cpupower-frequency-set(1), cpupower-frequency-info(1),
+cpupower-monitor(1), powertop(1)
 .PP
 .SH AUTHORS
 .nf
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

--------------7D88E2DF8230E1D817EE4FF0--
