Return-Path: <linux-pm+bounces-6206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201BF89F417
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 15:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C236F282CF7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71B16C69C;
	Wed, 10 Apr 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMYMvEcr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A5161325
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755214; cv=none; b=Nw+ZoCxtIpOzbQ0msInexJUf8PNyfMZV0HHiaCylmZk8GUwGvq3nUBnXoE7naeRI/6hxBm6FbweQ7EGlpMBoAiagRGdRhwklrH+Hc/ab+29mNamfal6QqYa3RkKs2suYJsk+/E9Kn9PZC2wsFZgoVOOskW1srm+dBWBwSSmwYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755214; c=relaxed/simple;
	bh=X887HemCG+eyK7JH8Zd7i/QBE26b6bKfH+zZbSx/NXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cvw4JZyqa4+i1g7s1hHuQo7/pN9BDVKhvve31XfjGfA8B4fQaD5rLYKkVPeR9+kLcHrvGTszEi7xudfhISHunUTA//ge/aResakMboun5JMVDI/61NKz5JSvsShVZPU8mS/X3mGPHMphLQrK6dJmLIezkXUtnExCiKTV8HrXQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMYMvEcr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-617e6c873f3so46210457b3.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755211; x=1713360011; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqX1Rbo124TpDubklxmnunkvyYyx3GcO6VcqeCzHs78=;
        b=BMYMvEcrZQTUHcpOS4pn7TDNuIC+dHU1fjnx5NYSBJkK+vxXx6+VRoynUpwknbG3Rv
         XTJHKDLG4oKaSFHhEek/47Ea0/7UhAwrpPbwXe24+Ge2bq1n+Y5q7ueV7YFEotLV8ZBC
         s3rOQJXlfoA3Uo1CUXXSYOznH0a7nyvqeyp6Buo7QJjsBkCwr4xMr3e7uDjCNh+Q8fWk
         XTIBz0bpj0HtcrpvFGgjfEjfz/Tr2TpjTB1h9tdpr7MSP/h4W/ZW++a0F60Yo3x7DR8t
         hnGXpCWFSOZolBU80gW7/cmlmvFPcrLbtHh92b3aEbkRK4YV8+2iGuivA3HxWvhWvOkW
         6Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755211; x=1713360011;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqX1Rbo124TpDubklxmnunkvyYyx3GcO6VcqeCzHs78=;
        b=bQD8fc7a7msJo0+vmPs5LnnrsW3omg2j5UisehM+cx1gXOuuS5Z743la6yAC3JRAdW
         bpbwEPdD3tsfHxIrco3K6mLqQIYDc5vBwHauTzcdM8mA5dpvPXEp3C510AkYkF7wmhIk
         B71Tl3mDSeJn03rhlCNuKaDitV/lA2bnmXcR7nUZ87SWDac2kJeqPR/x+X9MyKi9+hmN
         dlml9xUx61LqV9NVrCQS0oME/xFlqBYG8enWAY6SHIqSpQJEZ45FigLs7E4U4f5JYvTv
         YZWcgRqrSOrO/HvQn5+iZ0aLNLSeb1BTbflFQmuZtZxN69n03D7yW2ZmWD3xb4cYp4RK
         yhJQ==
X-Gm-Message-State: AOJu0YxIcF75mkr0kwF6AU3A1qeXo0vMpVRUboiXLaTwKfoU+skiMzfz
	NG0g5X7m2313xuT9JsOZ62pIEkDDLzbFNGMGWK+IOhVBOBqWww0yBCPqnHyh
X-Google-Smtp-Source: AGHT+IFKhjc2mHWwjcTS6moZAWAP1NmDxjbAMUmZ1/nJjNQ7GWB7ZvB+SogMMR3T4476hlx2uZSVPQ==
X-Received: by 2002:a81:d251:0:b0:609:af49:7995 with SMTP id m17-20020a81d251000000b00609af497995mr2743081ywl.50.1712755210953;
        Wed, 10 Apr 2024 06:20:10 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-b580-a474-89e0-3bb1.inf6.spectrum.com. [2603:9000:9f01:67cf:b580:a474:89e0:3bb1])
        by smtp.gmail.com with ESMTPSA id x66-20020a0dd545000000b006143d243915sm2700864ywd.10.2024.04.10.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:20:10 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 26/26] tools/power turbostat: v2024.04.10
Date: Wed, 10 Apr 2024 09:19:49 -0400
Message-Id: <3ab7296a7e6aa34634dcc2926af933107a117996.1712754901.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712754901.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712754901.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Much of turbostat can now run with perf, rather than using the MSR driver

Some of turbostat can now run as a regular non-root user.

Add some new output columns for some new GFX hardware.

[This patch updates the version, but otherwise changes no function;
 it touches up some checkpatch issues from previous patches]

Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS                                   |  1 +
 tools/power/x86/turbostat/turbostat.c         | 41 ++++++++++++-------
 .../testing/selftests/turbostat/defcolumns.py |  1 +
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..b8582a466128 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22116,6 +22116,7 @@ Q:	https://patchwork.kernel.org/project/linux-pm/list/
 B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
 F:	tools/power/x86/turbostat/
+F:	tools/testing/selftests/turbostat/
 
 TW5864 VIDEO4LINUX DRIVER
 M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bc103851df70..98256468e248 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3,7 +3,7 @@
  * turbostat -- show CPU frequency and C-state residency
  * on modern Intel and AMD processors.
  *
- * Copyright (c) 2023 Intel Corporation.
+ * Copyright (c) 2024 Intel Corporation.
  * Len Brown <len.brown@intel.com>
  */
 
@@ -1360,6 +1360,7 @@ struct sys_counters {
 void free_sys_counters(void)
 {
 	struct msr_counter *p = sys.tp, *pnext = NULL;
+
 	while (p) {
 		pnext = p->next;
 		free(p);
@@ -1979,6 +1980,7 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 
 		const unsigned long long energy_value = c->core_energy.raw_value * c->core_energy.scale;
 		const double energy_scale = c->core_energy.scale;
+
 		if (c->core_energy.unit == RAPL_UNIT_JOULES)
 			outp += sprintf(outp, "Joules: %0llX (scale: %lf)\n", energy_value, energy_scale);
 
@@ -3153,7 +3155,7 @@ static unsigned int read_perf_counter_info_n(const char *const path, const char
 	return v;
 }
 
-static unsigned read_msr_type(void)
+static unsigned int read_msr_type(void)
 {
 	const char *const path = "/sys/bus/event_source/devices/msr/type";
 	const char *const format = "%u";
@@ -3161,7 +3163,7 @@ static unsigned read_msr_type(void)
 	return read_perf_counter_info_n(path, format);
 }
 
-static unsigned read_aperf_config(void)
+static unsigned int read_aperf_config(void)
 {
 	const char *const path = "/sys/bus/event_source/devices/msr/events/aperf";
 	const char *const format = "event=%x";
@@ -3169,7 +3171,7 @@ static unsigned read_aperf_config(void)
 	return read_perf_counter_info_n(path, format);
 }
 
-static unsigned read_mperf_config(void)
+static unsigned int read_mperf_config(void)
 {
 	const char *const path = "/sys/bus/event_source/devices/msr/events/mperf";
 	const char *const format = "event=%x";
@@ -3177,7 +3179,7 @@ static unsigned read_mperf_config(void)
 	return read_perf_counter_info_n(path, format);
 }
 
-static unsigned read_perf_type(const char *subsys)
+static unsigned int read_perf_type(const char *subsys)
 {
 	const char *const path_format = "/sys/bus/event_source/devices/%s/type";
 	const char *const format = "%u";
@@ -3188,7 +3190,7 @@ static unsigned read_perf_type(const char *subsys)
 	return read_perf_counter_info_n(path, format);
 }
 
-static unsigned read_rapl_config(const char *subsys, const char *event_name)
+static unsigned int read_rapl_config(const char *subsys, const char *event_name)
 {
 	const char *const path_format = "/sys/bus/event_source/devices/%s/events/%s";
 	const char *const format = "event=%x";
@@ -3199,7 +3201,7 @@ static unsigned read_rapl_config(const char *subsys, const char *event_name)
 	return read_perf_counter_info_n(path, format);
 }
 
-static unsigned read_perf_rapl_unit(const char *subsys, const char *event_name)
+static unsigned int read_perf_rapl_unit(const char *subsys, const char *event_name)
 {
 	const char *const path_format = "/sys/bus/event_source/devices/%s/events/%s.unit";
 	const char *const format = "%s";
@@ -3235,7 +3237,7 @@ static struct amperf_group_fd open_amperf_fd(int cpu)
 	const unsigned int msr_type = read_msr_type();
 	const unsigned int aperf_config = read_aperf_config();
 	const unsigned int mperf_config = read_mperf_config();
-	struct amperf_group_fd fds = {.aperf = -1,.mperf = -1 };
+	struct amperf_group_fd fds = {.aperf = -1, .mperf = -1 };
 
 	fds.aperf = open_perf_counter(cpu, msr_type, aperf_config, -1, PERF_FORMAT_GROUP);
 	fds.mperf = open_perf_counter(cpu, msr_type, mperf_config, fds.aperf, PERF_FORMAT_GROUP);
@@ -3277,6 +3279,7 @@ static int read_aperf_mperf_tsc_perf(struct thread_data *t, int cpu)
 	t->tsc = rdtsc();
 
 	const int n = read(fd_amperf, &cnt.as_array[0], sizeof(cnt.as_array));
+
 	if (n != sizeof(cnt.as_array))
 		return -2;
 
@@ -3371,7 +3374,7 @@ int get_rapl_counters(int cpu, int domain, struct core_data *c, struct pkg_data
 	struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[domain];
 
 	if (debug)
-		fprintf(stderr, "get_rapl_counters: cpu%d domain%d\n", cpu, domain);
+		fprintf(stderr, "%s: cpu%d domain%d\n", __func__, cpu, domain);
 
 	assert(rapl_counter_info_perdomain);
 
@@ -3382,8 +3385,9 @@ int get_rapl_counters(int cpu, int domain, struct core_data *c, struct pkg_data
 		size_t num_perf_counters = rapl_counter_info_count_perf(rci);
 		const ssize_t expected_read_size = (num_perf_counters + 1) * sizeof(unsigned long long);
 		const ssize_t actual_read_size = read(rci->fd_perf, &perf_data[0], sizeof(perf_data));
+
 		if (actual_read_size != expected_read_size)
-			err(-1, "get_rapl_counters: failed to read perf_data (%zu %zu)", expected_read_size,
+			err(-1, "%s: failed to read perf_data (%zu %zu)", __func__, expected_read_size,
 			    actual_read_size);
 	}
 
@@ -3454,7 +3458,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	int status;
 
 	if (cpu_migrate(cpu)) {
-		fprintf(outf, "get_counters: Could not migrate to CPU %d\n", cpu);
+		fprintf(outf, "%s: Could not migrate to CPU %d\n", __func__, cpu);
 		return -1;
 	}
 
@@ -6411,15 +6415,17 @@ int add_rapl_perf_counter_(int cpu, struct rapl_counter_info_t *rci, const struc
 		return -1;
 
 	const double scale = read_perf_rapl_scale(cai->perf_subsys, cai->perf_name);
+
 	if (scale == 0.0)
 		return -1;
 
 	const enum rapl_unit unit = read_perf_rapl_unit(cai->perf_subsys, cai->perf_name);
+
 	if (unit == RAPL_UNIT_INVALID)
 		return -1;
 
-	const unsigned rapl_type = read_perf_type(cai->perf_subsys);
-	const unsigned rapl_energy_pkg_config = read_rapl_config(cai->perf_subsys, cai->perf_name);
+	const unsigned int rapl_type = read_perf_type(cai->perf_subsys);
+	const unsigned int rapl_energy_pkg_config = read_rapl_config(cai->perf_subsys, cai->perf_name);
 
 	const int fd_counter =
 	    open_perf_counter(cpu, rapl_type, rapl_energy_pkg_config, rci->fd_perf, PERF_FORMAT_GROUP);
@@ -6441,7 +6447,7 @@ int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct
 	int ret = add_rapl_perf_counter_(cpu, rci, cai, scale, unit);
 
 	if (debug)
-		fprintf(stderr, "add_rapl_perf_counter: %d (cpu: %d)\n", ret, cpu);
+		fprintf(stderr, "%s: %d (cpu: %d)\n", __func__, ret, cpu);
 
 	return ret;
 }
@@ -6462,6 +6468,7 @@ void linux_perf_init(void)
 	}
 
 	const bool aperf_required = is_aperf_access_required();
+
 	if (aperf_required && has_aperf && amperf_source == AMPERF_SOURCE_PERF) {
 		fd_amperf_percpu = calloc(topo.max_cpu_num + 1, sizeof(*fd_amperf_percpu));
 		if (fd_amperf_percpu == NULL)
@@ -6483,6 +6490,7 @@ void rapl_perf_init(void)
 	 */
 	for (int domain_id = 0; domain_id < num_domains; ++domain_id) {
 		struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[domain_id];
+
 		rci->fd_perf = -1;
 		for (size_t i = 0; i < NUM_RAPL_COUNTERS; ++i) {
 			rci->data[i] = 0;
@@ -7296,6 +7304,7 @@ static void set_amperf_source(void)
 	amperf_source = AMPERF_SOURCE_PERF;
 
 	const bool aperf_required = is_aperf_access_required();
+
 	if (no_perf || !aperf_required || !has_amperf_access_via_perf())
 		amperf_source = AMPERF_SOURCE_MSR;
 
@@ -7373,10 +7382,12 @@ void check_msr_access(void)
 void check_perf_access(void)
 {
 	const bool intrcount_required = BIC_IS_ENABLED(BIC_IPC);
+
 	if (no_perf || !intrcount_required || !has_instr_count_access())
 		bic_enabled &= ~BIC_IPC;
 
 	const bool aperf_required = is_aperf_access_required();
+
 	if (!aperf_required || !has_amperf_access()) {
 		bic_enabled &= ~BIC_Avg_MHz;
 		bic_enabled &= ~BIC_Busy;
@@ -7486,7 +7497,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2023.11.07 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2024.04.08 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
diff --git a/tools/testing/selftests/turbostat/defcolumns.py b/tools/testing/selftests/turbostat/defcolumns.py
index 70d3b7780311..d9b042097da7 100755
--- a/tools/testing/selftests/turbostat/defcolumns.py
+++ b/tools/testing/selftests/turbostat/defcolumns.py
@@ -1,4 +1,5 @@
 #!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
 
 import subprocess
 from shutil import which
-- 
2.40.1


