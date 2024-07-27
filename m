Return-Path: <linux-pm+bounces-11487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7893E08D
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2081F21960
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1D187568;
	Sat, 27 Jul 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntbR9y2n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C35187353
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104824; cv=none; b=EMu/WcWFHvMkT2y50C80KArgDrbwE5zvkfSlYnjmtgAjF6wsAVWYiFKl2sukknLLp9N8l09rLo9L4bMvGiy9lMBdl2LPQ//Y4UCASoHGijNRTXvyuzgluyOXqUP/TMEmNlzUfHJuAjX/kbP9cFsPDBT8UFTuxzkAfauAlmdHHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104824; c=relaxed/simple;
	bh=+mQ06OcK/AsgTTVZgaabGhID5UJw0Ot/QuA2UzgqPV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWawWKAD0Ic0ja2Qjj764kHMfy5u8ZB1Z3EdyJ6qKdaZV2b3AnYEZfM/AA5bWuDFprIoN88RmiNxs8QCa0jFOQ5Flr1lpPg2CRnRZ5N/vYDDJwe6LsYvZUsE4T+33IMf7lZPiD26uBkObW+/O1RKj0RyAf7XOekQFDvJmNUIIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntbR9y2n; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5af743b8fso1057087eaf.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104822; x=1722709622; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tK0c1fQvqk8x/6mwc5S14OPA08FERnPTY0Z5fCGx4J8=;
        b=ntbR9y2nIqvLaK7RGMdhL/CY5HL/sxDUSzWBH1hPYtRgdtEb64EZ66HXE6kk67PZ/f
         38tADdR5VBXnguoddRVrXDJQdedM3+V0QoMWw+EMilHrgyhjb+4/vr90jtD2saDeHY0I
         oXf6kfHZXSO8UezHV/EgeDHSAu6i56uJAzZNLvfB3KxYU9h/3EKeAumxUd4ubVLWegli
         Xu7fOBji3v/g/ibBOx01TJO4k/tUFTbXgypAx0nDUmaU9P7ZKufZzA1f1KJmEH2jUf/B
         9k74edCa+ni94w8+mBDgFBCK6lpZpuqmCTygGuGlAXAlPDZep1fFeFJrkTRhtb12H19W
         /zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104822; x=1722709622;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tK0c1fQvqk8x/6mwc5S14OPA08FERnPTY0Z5fCGx4J8=;
        b=u5b8/xyONidXCfeVmn2+J+FQEfVSMzLFF7oKrOm+AWrimh3VtYkO1Akb5+MnKkjJVM
         JPiugg8IEgfWN9dYJehztwJFj0Ifu5OmTNsutExUTv6FvXoql0J+Fe/K7NkxvpEMqHw6
         5GvR5F6ckuCdxU3KrZbq0tbYvEQjbdA5uOo+pfAd2s1VtahSJ/bNG9LpjQKHTSk08oKw
         X0s67gIXe79/4dY84yLuO/PQpFYcIUe/KHyMVQWqDw6mleqvvgQcD0NqDKg10psLMWDt
         k1NPDpQxMDCjTx42VkE+S/YLxhukWhMc1BWW6x6Ci+YadXbKwkxFVpLch852Qode5531
         ywnA==
X-Gm-Message-State: AOJu0Yy1BQJglGXSY3Odikz1Vga7iHvvaDMnvYNnpV8LS93VlJknJvMt
	MtdDAa2NzQMhaDq5d+3Pk+uQkDdE61tN/xxck8dXa/6cjTCA1parCcvehg==
X-Google-Smtp-Source: AGHT+IFXLmTxI6m6GrU+qWekznEMWdoms+olHVeAdRxpLGq6fAhjZPgwjElVroSjRo/2iR5Q4hOB/w==
X-Received: by 2002:a05:6870:5594:b0:260:ee08:8e43 with SMTP id 586e51a60fabf-267d4dd3d63mr3881104fac.29.1722104821589;
        Sat, 27 Jul 2024 11:27:01 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:27:01 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 17/18] tools/power turbostat: Include umask=%x in perf counter's config
Date: Sat, 27 Jul 2024 14:23:43 -0400
Message-ID: <19d076903b95896ce55c7cc3679f795731591ac6.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Some counters, like cpu/cache-misses/, expose and require umask=%x
parameter alongside event=%x in the sysfs perf counter's event file.
This change make sure we parse and use it when opening user added
counters.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 60 ++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f769e8beabd3..ed5f032c6b3f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4017,15 +4017,55 @@ static unsigned int read_perf_type(const char *subsys)
 	return read_perf_counter_info_n(path, format);
 }
 
-static unsigned int read_rapl_config(const char *subsys, const char *event_name)
+static unsigned int read_perf_config(const char *subsys, const char *event_name)
 {
 	const char *const path_format = "/sys/bus/event_source/devices/%s/events/%s";
-	const char *const format = "event=%x";
+	FILE *fconfig = NULL;
 	char path[128];
+	char config_str[64];
+	unsigned int config;
+	unsigned int umask;
+	bool has_config = false;
+	bool has_umask = false;
+	unsigned int ret = -1;
 
 	snprintf(path, sizeof(path), path_format, subsys, event_name);
 
-	return read_perf_counter_info_n(path, format);
+	fconfig = fopen(path, "r");
+	if (!fconfig)
+		return -1;
+
+	if (fgets(config_str, ARRAY_SIZE(config_str), fconfig) != config_str)
+		goto cleanup_and_exit;
+
+	for (char *pconfig_str = &config_str[0]; pconfig_str;) {
+		if (sscanf(pconfig_str, "event=%x", &config) == 1) {
+			has_config = true;
+			goto next;
+		}
+
+		if (sscanf(pconfig_str, "umask=%x", &umask) == 1) {
+			has_umask = true;
+			goto next;
+		}
+
+	next:
+		pconfig_str = strchr(pconfig_str, ',');
+		if (pconfig_str) {
+			*pconfig_str = '\0';
+			++pconfig_str;
+		}
+	}
+
+	if (!has_umask)
+		umask = 0;
+
+	if (has_config)
+		ret = (umask << 8) | config;
+
+cleanup_and_exit:
+	fclose(fconfig);
+	return ret;
 }
 
 static unsigned int read_perf_rapl_unit(const char *subsys, const char *event_name)
@@ -4044,7 +4084,7 @@ static unsigned int read_perf_rapl_unit(const char *subsys, const char *event_na
 	return RAPL_UNIT_INVALID;
 }
 
-static double read_perf_rapl_scale(const char *subsys, const char *event_name)
+static double read_perf_scale(const char *subsys, const char *event_name)
 {
 	const char *const path_format = "/sys/bus/event_source/devices/%s/events/%s.scale";
 	const char *const format = "%lf";
@@ -7425,7 +7465,7 @@ int add_rapl_perf_counter_(int cpu, struct rapl_counter_info_t *rci, const struc
 	if (no_perf)
 		return -1;
 
-	const double scale = read_perf_rapl_scale(cai->perf_subsys, cai->perf_name);
+	const double scale = read_perf_scale(cai->perf_subsys, cai->perf_name);
 
 	if (scale == 0.0)
 		return -1;
@@ -7436,7 +7476,7 @@ int add_rapl_perf_counter_(int cpu, struct rapl_counter_info_t *rci, const struc
 		return -1;
 
 	const unsigned int rapl_type = read_perf_type(cai->perf_subsys);
-	const unsigned int rapl_energy_pkg_config = read_rapl_config(cai->perf_subsys, cai->perf_name);
+	const unsigned int rapl_energy_pkg_config = read_perf_config(cai->perf_subsys, cai->perf_name);
 
 	const int fd_counter =
 	    open_perf_counter(cpu, rapl_type, rapl_energy_pkg_config, rci->fd_perf, PERF_FORMAT_GROUP);
@@ -7598,7 +7638,7 @@ int add_cstate_perf_counter_(int cpu, struct cstate_counter_info_t *cci, const s
 		return -1;
 
 	const unsigned int type = read_perf_type(cai->perf_subsys);
-	const unsigned int config = read_rapl_config(cai->perf_subsys, cai->perf_name);
+	const unsigned int config = read_perf_config(cai->perf_subsys, cai->perf_name);
 
 	const int fd_counter = open_perf_counter(cpu, type, config, *pfd_group, PERF_FORMAT_GROUP);
 
@@ -7628,7 +7668,7 @@ int add_msr_perf_counter_(int cpu, struct msr_counter_info_t *cci, const struct
 		return -1;
 
 	const unsigned int type = read_perf_type(cai->perf_subsys);
-	const unsigned int config = read_rapl_config(cai->perf_subsys, cai->perf_name);
+	const unsigned int config = read_perf_config(cai->perf_subsys, cai->perf_name);
 
 	const int fd_counter = open_perf_counter(cpu, type, config, cci->fd_perf, PERF_FORMAT_GROUP);
 
@@ -8571,7 +8611,7 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 				continue;
 			}
 
-			perf_config = read_rapl_config(pinfo->device, pinfo->event);
+			perf_config = read_perf_config(pinfo->device, pinfo->event);
 			if (perf_config == (unsigned int)-1) {
 				warnx("%s: perf/%s/%s: failed to read %s",
 				      __func__, pinfo->device, pinfo->event, "config");
@@ -8579,7 +8619,7 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 			}
 
 			/* Scale is not required, some counters just don't have it. */
-			perf_scale = read_perf_rapl_scale(pinfo->device, pinfo->event);
+			perf_scale = read_perf_scale(pinfo->device, pinfo->event);
 			if (perf_scale == 0.0)
 				perf_scale = 1.0;
 
-- 
2.43.0


