Return-Path: <linux-pm+bounces-11488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3D93E08E
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40B9281D47
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9B187547;
	Sat, 27 Jul 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgCaPaB+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9818735C
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104825; cv=none; b=HfHm054qRsZlin0MK2tx4Me1KZkRVIkF9Y2uXpCcb3m/TW6xcmVWUUd0eGmLyTGKzYS8Qn792CdXLQdMVKIuckmnsZI8DF6r9T91ZET6l9Q8lzwMWKsACW2S3dguPwskSZTlVj0DJLY/5f2TcTtrARx5RogQCUCtdlkECptKcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104825; c=relaxed/simple;
	bh=56EgyZLh0OE6+kJvR5K0o1wgYknfOho8gp3IjzWV/yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8WsKNfzFHfstMJK2EEP4t12h3qHksM6SXjYuS0KrlTtH8dmgmKcQkhgA+X7NulizTJiDmqM11eGhFLNojV0hUmT3Fvtvj7Rczp5W7sE+TvAnFeP9vGliHnuxl0vxyHmaQtRQI4F2fs0TmV1yLjCR3wQBGl4DuT04XlcZ6BeHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgCaPaB+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7092fb4317dso1779257a34.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104823; x=1722709623; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9B/hMEJ+HhhdLFjSAFbaQoD083eWbzM0UgdjfmNmIM=;
        b=GgCaPaB+EPfTvGDiIY+MiMzlrTkbnMj6w0X8JVYPNkJbDOoOp6lkbjpZahzLUZX9Na
         7kSJ5BBRQuG43f+oqTkb1b6p9sGJsxbDUIKQVLJBYEx2CrrQknGF5I9KrVF2nGKsmK6D
         zfEzXzcBQnc/1LRUOOEHQ5eTHGm51ywvswRYJQgGYlKKfPwzjZqm0O35Vl6WDoubQzc0
         71gKGpYXMxsXiCfmhMRVpsxkpbcIPXnbbjHOUKmOsuxYvvWxSt6hTxi7StTXhewxIiMy
         d6Cm8ZBlSu8YZ7pwjhHyGKodZL4rQTkuRfDe0e4quKs5y4z2iBRx1Q/7UFvYAVKy8gP2
         0OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104823; x=1722709623;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9B/hMEJ+HhhdLFjSAFbaQoD083eWbzM0UgdjfmNmIM=;
        b=Uiz7N+3s8B61bsF3tNJ4vfEfqY0f/+bYgLzlUOxbT6+wteD3hM+IvjFmogHxBalzV1
         LiXQzKSlohCdOYjj3XJ2Ej6n18xmNLzI8sKqonJHceF8JccoGvgbYPhhD0xC5Vy/VHjH
         3xJuWvoiRTPT2fIfmtfSohZf/OJb0kDu+vHY3QWg+7ffJOm2zHr1JEH0rplExMPGcjbL
         tI4e5TaGQOSWbIO5gPbWgvwlShqZUe3uQPD6JJV2yddtqQXyS2cxTGEfLweKrtpol1Bb
         3no/idNcwzlWx1i8V2NUsHEceOKgw7cSKNqVMQGQCM9RCslLdNfkLboAHoUid7s9Tn3R
         +7Xg==
X-Gm-Message-State: AOJu0Yw6UcdTPiiFsieybnonUX9VjWY3WwFIqROOnpdH4MaX9/h7l0E3
	R3nlF/rhqMCf8bD8QYMq9u11eYM3Kf7sYss0Yu3xZ1ANXf5F7XhY93WklQ==
X-Google-Smtp-Source: AGHT+IHEcARK9TPYSc+W1YDxJLLHCvzs3tFCWEtKxiyQvD8CFC05Pzxg8QWXm1ZhVm5uGw3vQNynww==
X-Received: by 2002:a05:6870:1cd:b0:260:e3c1:1788 with SMTP id 586e51a60fabf-267d4f49920mr3387877fac.44.1722104822552;
        Sat, 27 Jul 2024 11:27:02 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:27:02 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/18] tools/power turbostat: version 2024.07.26
Date: Sat, 27 Jul 2024 14:23:44 -0400
Message-ID: <866d2d36b81d7d0e6d91423b6dd9b1bcfd0510dd.1722019621.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Release 2024.07.26:

Enable turbostat extensions to add both perf and PMT
(Intel Platform Monitoring Technology) counters from the cmdline.

Demonstrate PMT access with built-in support for Meteor Lake's Die%c6 counter.

This commit:

Clean up white-space nits introduced since version 2024.05.10

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 105 +++++++++++++-------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ed5f032c6b3f..089220aaa5c9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1057,8 +1057,7 @@ void probe_platform_features(unsigned int family, unsigned int model)
 		return;
 
 	for (i = 0; turbostat_pdata[i].features; i++) {
-		if (VFM_FAMILY(turbostat_pdata[i].vfm) == family &&
-		    VFM_MODEL(turbostat_pdata[i].vfm) == model) {
+		if (VFM_FAMILY(turbostat_pdata[i].vfm) == family && VFM_MODEL(turbostat_pdata[i].vfm) == model) {
 			platform = turbostat_pdata[i].features;
 			return;
 		}
@@ -1448,28 +1447,28 @@ enum msr_arch_info_index {
 
 static struct msr_counter_arch_info msr_counter_arch_infos[] = {
 	[MSR_ARCH_INFO_APERF_INDEX] = {
-		.perf_subsys = "msr",
-		.perf_name = "aperf",
-		.msr = MSR_IA32_APERF,
-		.msr_mask = 0xFFFFFFFFFFFFFFFF,
-		.rci_index = MSR_RCI_INDEX_APERF,
-	},
+				       .perf_subsys = "msr",
+				       .perf_name = "aperf",
+				       .msr = MSR_IA32_APERF,
+				       .msr_mask = 0xFFFFFFFFFFFFFFFF,
+				       .rci_index = MSR_RCI_INDEX_APERF,
+				        },
 
 	[MSR_ARCH_INFO_MPERF_INDEX] = {
-		.perf_subsys = "msr",
-		.perf_name = "mperf",
-		.msr = MSR_IA32_MPERF,
-		.msr_mask = 0xFFFFFFFFFFFFFFFF,
-		.rci_index = MSR_RCI_INDEX_MPERF,
-	},
+				       .perf_subsys = "msr",
+				       .perf_name = "mperf",
+				       .msr = MSR_IA32_MPERF,
+				       .msr_mask = 0xFFFFFFFFFFFFFFFF,
+				       .rci_index = MSR_RCI_INDEX_MPERF,
+				        },
 
 	[MSR_ARCH_INFO_SMI_INDEX] = {
-		.perf_subsys = "msr",
-		.perf_name = "smi",
-		.msr = MSR_SMI_COUNT,
-		.msr_mask = 0xFFFFFFFF,
-		.rci_index = MSR_RCI_INDEX_SMI,
-	},
+				     .perf_subsys = "msr",
+				     .perf_name = "smi",
+				     .msr = MSR_SMI_COUNT,
+				     .msr_mask = 0xFFFFFFFF,
+				     .rci_index = MSR_RCI_INDEX_SMI,
+				      },
 };
 
 /* Can be redefined when compiling, useful for testing. */
@@ -1535,14 +1534,14 @@ struct pmt_counter {
 
 unsigned int pmt_counter_get_width(const struct pmt_counter *p)
 {
-	return (p->msb - p->lsb)+1;
+	return (p->msb - p->lsb) + 1;
 }
 
 void pmt_counter_resize_(struct pmt_counter *pcounter, unsigned int new_size)
 {
 	struct pmt_domain_info *new_mem;
 
-	new_mem = (struct pmt_domain_info*) reallocarray(pcounter->domains, new_size, sizeof(*pcounter->domains));
+	new_mem = (struct pmt_domain_info *)reallocarray(pcounter->domains, new_size, sizeof(*pcounter->domains));
 	if (!new_mem) {
 		fprintf(stderr, "%s: failed to allocate memory for PMT counters\n", __func__);
 		exit(1);
@@ -1567,7 +1566,7 @@ void pmt_counter_resize(struct pmt_counter *pcounter, unsigned int new_size)
 	 */
 	if (new_size < 8)
 		new_size = 8;
-	new_size = MAX(new_size, pcounter->num_domains*2);
+	new_size = MAX(new_size, pcounter->num_domains * 2);
 
 	pmt_counter_resize_(pcounter, new_size);
 }
@@ -2282,7 +2281,7 @@ void print_header(char *delim)
 
 	ppmt = sys.pmt_tp;
 	while (ppmt) {
-		switch(ppmt->type) {
+		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
 				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
@@ -2356,7 +2355,7 @@ void print_header(char *delim)
 
 	ppmt = sys.pmt_cp;
 	while (ppmt) {
-		switch(ppmt->type) {
+		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
 				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
@@ -2487,7 +2486,7 @@ void print_header(char *delim)
 
 	ppmt = sys.pmt_pp;
 	while (ppmt) {
-		switch(ppmt->type) {
+		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
 				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), ppmt->name);
@@ -2969,7 +2968,8 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10 / tsc);
 
 	if (DO_BIC(BIC_Diec6))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->die_c6 / crystal_hz / interval_float);
+		outp +=
+		    sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->die_c6 / crystal_hz / interval_float);
 
 	if (DO_BIC(BIC_CPU_LPI)) {
 		if (p->cpu_lpi >= 0)
@@ -4049,7 +4049,7 @@ static unsigned int read_perf_config(const char *subsys, const char *event_name)
 			goto next;
 		}
 
-	next:
+next:
 		pconfig_str = strchr(pconfig_str, ',');
 		if (pconfig_str) {
 			*pconfig_str = '\0';
@@ -4463,9 +4463,9 @@ unsigned long pmt_gen_value_mask(unsigned int lsb, unsigned int msb)
 	if (msb == 63)
 		mask = 0xffffffffffffffff;
 	else
-		mask = ((1<<(msb+1))-1);
+		mask = ((1 << (msb + 1)) - 1);
 
-	mask -= (1<<lsb)-1;
+	mask -= (1 << lsb) - 1;
 
 	return mask;
 }
@@ -8636,7 +8636,7 @@ int added_perf_counters_init_(struct perf_counter_info *pinfo)
 
 			if (debug)
 				fprintf(stderr, "Add perf/%s/%s cpu%d: %d\n",
-				       pinfo->device, pinfo->event, cpu, pinfo->fd_perf_per_domain[next_domain]);
+					pinfo->device, pinfo->event, cpu, pinfo->fd_perf_per_domain[next_domain]);
 		}
 
 		pinfo = pinfo->next;
@@ -8687,7 +8687,7 @@ int parse_telem_info_file(int fd_dir, const char *info_filename, const char *for
 	return 0;
 }
 
-struct pmt_mmio* pmt_mmio_open(unsigned int target_guid)
+struct pmt_mmio *pmt_mmio_open(unsigned int target_guid)
 {
 	DIR *dirp;
 	struct dirent *entry;
@@ -8793,7 +8793,7 @@ struct pmt_mmio* pmt_mmio_open(unsigned int target_guid)
 	return ret;
 }
 
-struct pmt_mmio* pmt_mmio_find(unsigned int guid)
+struct pmt_mmio *pmt_mmio_find(unsigned int guid)
 {
 	struct pmt_mmio *pmmio = pmt_mmios;
 
@@ -8802,22 +8802,22 @@ struct pmt_mmio* pmt_mmio_find(unsigned int guid)
 			return pmmio;
 
 		pmmio = pmmio->next;
-	 }
+	}
 
 	return NULL;
 }
 
-void* pmt_get_counter_pointer(struct pmt_mmio *pmmio, unsigned long counter_offset)
+void *pmt_get_counter_pointer(struct pmt_mmio *pmmio, unsigned long counter_offset)
 {
 	char *ret;
 
 	/* Get base of mmaped PMT file. */
-	ret = (char*)pmmio->mmio_base;
+	ret = (char *)pmmio->mmio_base;
 
 	/*
 	 * Apply PMT MMIO offset to obtain beginning of the mmaped telemetry data.
 	 * It's not guaranteed that the mmaped memory begins with the telemetry data
-	 * 	- we might have to apply the offset first.
+	 *      - we might have to apply the offset first.
 	 */
 	ret += pmmio->pmt_offset;
 
@@ -8827,7 +8827,7 @@ void* pmt_get_counter_pointer(struct pmt_mmio *pmmio, unsigned long counter_offs
 	return ret;
 }
 
-struct pmt_mmio* pmt_add_guid(unsigned int guid)
+struct pmt_mmio *pmt_add_guid(unsigned int guid)
 {
 	struct pmt_mmio *ret;
 
@@ -8843,7 +8843,7 @@ enum pmt_open_mode {
 	PMT_OPEN_REQUIRED,	/* Open failure is a fatal error. */
 };
 
-struct pmt_counter* pmt_find_counter(struct pmt_counter *pcounter, const char *name)
+struct pmt_counter *pmt_find_counter(struct pmt_counter *pcounter, const char *name)
 {
 	while (pcounter) {
 		if (strcmp(pcounter->name, name) == 0)
@@ -8855,9 +8855,9 @@ struct pmt_counter* pmt_find_counter(struct pmt_counter *pcounter, const char *n
 	return pcounter;
 }
 
-struct pmt_counter** pmt_get_scope_root(enum counter_scope scope)
+struct pmt_counter **pmt_get_scope_root(enum counter_scope scope)
 {
-	switch(scope) {
+	switch (scope) {
 	case SCOPE_CPU:
 		return &sys.pmt_tp;
 	case SCOPE_CORE:
@@ -8873,7 +8873,7 @@ void pmt_counter_add_domain(struct pmt_counter *pcounter, unsigned long *pmmio,
 {
 	/* Make sure the new domain fits. */
 	if (domain_id >= pcounter->num_domains)
-		pmt_counter_resize(pcounter, domain_id+1);
+		pmt_counter_resize(pcounter, domain_id + 1);
 
 	assert(pcounter->domains);
 	assert(domain_id < pcounter->num_domains);
@@ -8882,12 +8882,12 @@ void pmt_counter_add_domain(struct pmt_counter *pcounter, unsigned long *pmmio,
 }
 
 int pmt_add_counter(unsigned int guid, const char *name, enum pmt_datatype type,
-	unsigned int lsb, unsigned int msb, unsigned int offset, enum counter_scope scope,
-	enum counter_format format, unsigned int domain_id, enum pmt_open_mode mode)
+		    unsigned int lsb, unsigned int msb, unsigned int offset, enum counter_scope scope,
+		    enum counter_format format, unsigned int domain_id, enum pmt_open_mode mode)
 {
 	struct pmt_mmio *mmio;
 	struct pmt_counter *pcounter;
-	struct pmt_counter ** const pmt_root = pmt_get_scope_root(scope);
+	struct pmt_counter **const pmt_root = pmt_get_scope_root(scope);
 	bool new_counter = false;
 	int conflict = 0;
 
@@ -8927,7 +8927,7 @@ int pmt_add_counter(unsigned int guid, const char *name, enum pmt_datatype type,
 	}
 
 	if (new_counter) {
-		strncpy(pcounter->name, name, ARRAY_SIZE(pcounter->name)-1);
+		strncpy(pcounter->name, name, ARRAY_SIZE(pcounter->name) - 1);
 		pcounter->type = type;
 		pcounter->scope = scope;
 		pcounter->lsb = lsb;
@@ -9071,7 +9071,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2024.05.10 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2024.07.26 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
@@ -9299,7 +9299,7 @@ int add_perf_counter(const char *perf_device, const char *perf_event, const char
 	// FIXME: we might not have debug here yet
 	if (debug)
 		fprintf(stderr, "%s: %s/%s, name: %s, scope%d\n",
-		       __func__, pinfo->device, pinfo->event, pinfo->name, pinfo->scope);
+			__func__, pinfo->device, pinfo->event, pinfo->name, pinfo->scope);
 
 	return 0;
 }
@@ -9450,10 +9450,10 @@ void parse_add_command_pmt(char *add_command)
 	bool has_offset = false;
 	bool has_lsb = false;
 	bool has_msb = false;
-	bool has_format = true; /* Format has a default value. */
+	bool has_format = true;	/* Format has a default value. */
 	bool has_guid = false;
 	bool has_scope = false;
-	bool has_type = true; /* Type has a default value. */
+	bool has_type = true;	/* Type has a default value. */
 
 	/* Consume the "pmt," prefix. */
 	add_command = strchr(add_command, ',');
@@ -9490,7 +9490,7 @@ void parse_add_command_pmt(char *add_command)
 
 			if (!has_scope) {
 				printf("%s: invalid value for scope. Expected cpu%%u, core%%u or package%%u.\n",
-					__func__);
+				       __func__);
 				exit(1);
 			}
 
@@ -9536,8 +9536,7 @@ void parse_add_command_pmt(char *add_command)
 	}
 
 	if (strlen(name) >= PMT_COUNTER_NAME_SIZE_BYTES) {
-		printf("%s: name has to be at most %d characters long\n",
-			__func__, PMT_COUNTER_NAME_SIZE_BYTES);
+		printf("%s: name has to be at most %d characters long\n", __func__, PMT_COUNTER_NAME_SIZE_BYTES);
 		exit(1);
 	}
 
-- 
2.43.0


