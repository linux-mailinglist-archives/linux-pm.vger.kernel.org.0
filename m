Return-Path: <linux-pm+bounces-7778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1098C47BB
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31689286906
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B6979B7E;
	Mon, 13 May 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgjE2p+8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832807580A
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629279; cv=none; b=pXScslGqCeG7+rhTdOlGtLc352qVipPMeO0ijMROsfQwyKH5ErYcHugA/DKqL5kr9ik+8E47XbmBSv2VLtgTlDZ/re+8bMDusiA3F8ppRDy0XiGkemHMdva8N+dr6hSd0eYRVmnWdCsoFbuaMSO6Hahc5BPVn6Ldj7vsu9ypmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629279; c=relaxed/simple;
	bh=0ehA2aE2OemOlH1RwElMjcEWZJ3/V0K2FtjVDAWUoZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgbWjmq2grnRhKVo5VgtCIaoo6uq/2OIviQW2qXQ/jVDD9JH4Dgb0/V5GQjeCJ6oaxmAK86HnJFoQVIs1H++y6piCiPX+ewajpYeGw1v6a7eex59Pn8zAE48+7N0mQv5OeF8YD0f4JFiifxVMDBRV5L0bpJdaMJiaujmCNmZFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgjE2p+8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61bee45d035so49300557b3.1
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629276; x=1716234076; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+CFEy6eUKyhIXPy2kq3SbB6VVk+B2qSFqSZP/ZPQr0=;
        b=BgjE2p+8jDTe0JmVDKxPH2cwSa6LWWV9cj3crsLfVqZT5AcR08LwQPEz4A5y0xCHCk
         hJfVJ+RURZb6VNA4DI3PD4VAdSG/ZT4WyZcMuO8LY4NgS7KLuewZLKgtC8q9SjOQ5KPl
         iDcqcwFbEcsKbu4QK27DcM1mEWR6GkxvqmCuzf2uM8E6j6ja8B333c5l7mO6QM3lCZBa
         qcrc5/H8JYeCS7vq17N7XcRqg0jRYsKl6iiWtgnhlyi6dRFb7Y8AVDW1sYU/ZARDk3pD
         SjI2xqeCC7uGaUcEBdIAoxy96EGHVV6tv/ltHUiFzf1dS+Y5W2+TBpg4GIkoNHy/8+Ah
         nzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629276; x=1716234076;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+CFEy6eUKyhIXPy2kq3SbB6VVk+B2qSFqSZP/ZPQr0=;
        b=kTyXxVNR3yt8hUBiB+KWU4OJF9vjkF6Excp9tABdOtKVIvK4SSWjgrsmyaejMtWdD2
         /tXKwwlyRU7QUe1xunPUqO2L//PwgsQGCeQN3fBmCD2RP5Zxiy1N5p/aZxxqU3vcEYEM
         NtOZSYDhzqJqJ4EaH+c+E/mtJt5ZAQFTSusBKvlzjzFsU6I9PBBi/2/BvwAxEeqRRRAZ
         v5q3GzExw4j3adLOEoqIj0CmlhWtVm5EMEAgzJx4WcN2PGRnMuwJYAZbsrDZoNp46kPi
         YvgbuOeh14TbL7mp0Zq39NxJc1f1GUNdcgePWuYtecUXgbGKmpJA3isWroTEoDbDDBk1
         P5bg==
X-Gm-Message-State: AOJu0YxdhrR4iQ1+EUl8HJglE/8poAu2e9T4GLIq2QHO48ryxS8AA9UY
	sMWzy97vlwYuc2Agg8nhQPGygsnhONuDwRqh4GZ8oEdLCGETpuPorzOcWQ==
X-Google-Smtp-Source: AGHT+IEqrXnTTq30a+aTH6mD0Vm1LubdwqQzxhWUYCDh1Ib/cWZ/6+Gy0S/Iw9Cb4Pu1lKLGAPGDpA==
X-Received: by 2002:a81:4912:0:b0:617:c9b0:e12c with SMTP id 00721157ae682-622b0147eb7mr85812767b3.38.1715629275796;
        Mon, 13 May 2024 12:41:15 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:15 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/15] tools/power turbostat: Add columns for clustered uncore frequency
Date: Mon, 13 May 2024 15:40:45 -0400
Message-Id: <f333b3bf3f1f1f83b5fba176ecffd260e5428374.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
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

New machines have multiple uncore frequencies per package,
visible in /sys/devices/system/cpu/intel_uncore_frequency/uncore##/

turbostat now samples these frequencies each measurement interval.

For each package, turbostat now prints "UMHzX.Y" columns,
where X = domain_id, and Y = fabric_cluster_id.

The system summary for each UMHzX.Y column is the average value
for across all of the packages in the system.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |   4 +-
 tools/power/x86/turbostat/turbostat.c | 323 +++++++++++++++++---------
 2 files changed, 212 insertions(+), 115 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 0d3672e5d9ed..8d37acd39201 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -155,7 +155,9 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBRAM_%\fP percent of the interval that RAPL throttling was active on DRAM.
 .PP
-\fBUncMHz\fP uncore MHz, instantaneous sample.
+\fBUncMHz\fP per-package uncore MHz, instantaneous sample.
+.PP
+\fBUMHz1.0\fP per-package uncore MHz for domain=1 and fabric_cluster=0, instantaneous sample.  System summary is the average of all packages.
 .SH TOO MUCH INFORMATION EXAMPLE
 By default, turbostat dumps all possible information -- a system configuration header, followed by columns for all counters.
 This is ideal for remote debugging, use the "--out" option to save everything to a text file, and get that file to the expert helping you debug.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f92b46cfda31..3bf9bb6145f3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -59,15 +59,21 @@
 #define MAX_NOFILE 0x8000
 
 enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
-enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC };
-enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
+enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC, COUNTER_K2M };
+enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT, FORMAT_AVERAGE };
 enum amperf_source { AMPERF_SOURCE_PERF, AMPERF_SOURCE_MSR };
 enum rapl_source { RAPL_SOURCE_NONE, RAPL_SOURCE_PERF, RAPL_SOURCE_MSR };
 
+struct sysfs_path {
+	char path[PATH_BYTES];
+	int id;
+	struct sysfs_path *next;
+};
+
 struct msr_counter {
 	unsigned int msr_num;
 	char name[NAME_BYTES];
-	char path[PATH_BYTES];
+	struct sysfs_path *sp;
 	unsigned int width;
 	enum counter_type type;
 	enum counter_format format;
@@ -79,64 +85,64 @@ struct msr_counter {
 };
 
 struct msr_counter bic[] = {
-	{ 0x0, "usec", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Time_Of_Day_Seconds", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Package", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Node", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Avg_MHz", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Busy%", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Bzy_MHz", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "TSC_MHz", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "IRQ", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "SMI", "", 32, 0, FORMAT_DELTA, NULL, 0 },
-	{ 0x0, "sysfs", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CPU%c1", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CPU%c3", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CPU%c6", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CPU%c7", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "ThreadC", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CoreTmp", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CoreCnt", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "PkgTmp", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "GFX%rc6", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "GFXMHz", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Pkg%pc2", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Pkg%pc3", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Pkg%pc6", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Pkg%pc7", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Pkg%pc8", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Pkg%pc9", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Pk%pc10", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CPU%LPI", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "SYS%LPI", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "PkgWatt", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CorWatt", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "GFXWatt", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "PkgCnt", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "RAMWatt", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "PKG_%", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "RAM_%", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Pkg_J", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Cor_J", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "GFX_J", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "RAM_J", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Mod%c6", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Totl%C0", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Any%C0", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "GFX%C0", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CPUGFX%", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Core", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CPU", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "APIC", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "X2APIC", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "Die", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "GFXAMHz", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "IPC", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "CoreThr", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "UncMHz", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "SAM%mc6", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "SAMMHz", "", 0, 0, 0, NULL, 0 },
-	{ 0x0, "SAMAMHz", "", 0, 0, 0, NULL, 0 },
+	{ 0x0, "usec", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Time_Of_Day_Seconds", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Package", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Node", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Avg_MHz", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Busy%", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Bzy_MHz", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "TSC_MHz", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "IRQ", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "SMI", NULL, 32, 0, FORMAT_DELTA, NULL, 0 },
+	{ 0x0, "sysfs", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CPU%c1", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CPU%c3", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CPU%c6", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CPU%c7", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "ThreadC", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CoreTmp", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CoreCnt", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "PkgTmp", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "GFX%rc6", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "GFXMHz", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Pkg%pc2", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Pkg%pc3", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Pkg%pc6", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Pkg%pc7", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Pkg%pc8", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Pkg%pc9", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Pk%pc10", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CPU%LPI", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "SYS%LPI", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "PkgWatt", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CorWatt", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "GFXWatt", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "PkgCnt", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "RAMWatt", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "PKG_%", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "RAM_%", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Pkg_J", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Cor_J", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "GFX_J", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "RAM_J", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Mod%c6", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Totl%C0", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Any%C0", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "GFX%C0", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CPUGFX%", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Core", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CPU", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "APIC", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "X2APIC", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "Die", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "GFXAMHz", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "IPC", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "CoreThr", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "UncMHz", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "SAM%mc6", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "SAMMHz", NULL, 0, 0, 0, NULL, 0 },
+	{ 0x0, "SAMAMHz", NULL, 0, 0, 0, NULL, 0 },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -300,6 +306,9 @@ struct gfx_sysfs_info {
 static struct gfx_sysfs_info gfx_info[GFX_MAX];
 
 int get_msr(int cpu, off_t offset, unsigned long long *msr);
+int add_counter(unsigned int msr_num, char *path, char *name,
+		unsigned int width, enum counter_scope scope,
+		enum counter_type type, enum counter_format format, int flags, int package_num);
 
 /* Model specific support Start */
 
@@ -999,8 +1008,9 @@ char *progname;
 #define CPU_SUBSET_MAXCPUS	1024	/* need to use before probe... */
 cpu_set_t *cpu_present_set, *cpu_effective_set, *cpu_allowed_set, *cpu_affinity_set, *cpu_subset;
 size_t cpu_present_setsize, cpu_effective_setsize, cpu_allowed_setsize, cpu_affinity_setsize, cpu_subset_size;
-#define MAX_ADDED_COUNTERS 8
 #define MAX_ADDED_THREAD_COUNTERS 24
+#define MAX_ADDED_CORE_COUNTERS 8
+#define MAX_ADDED_PACKAGE_COUNTERS 16
 #define BITMASK_SIZE 32
 
 /* Indexes used to map data read from perf and MSRs into global variables */
@@ -1201,7 +1211,7 @@ struct core_data {
 	struct rapl_counter core_energy;	/* MSR_CORE_ENERGY_STAT */
 	unsigned int core_id;
 	unsigned long long core_throt_cnt;
-	unsigned long long counter[MAX_ADDED_COUNTERS];
+	unsigned long long counter[MAX_ADDED_CORE_COUNTERS];
 } *core_even, *core_odd;
 
 struct pkg_data {
@@ -1234,7 +1244,7 @@ struct pkg_data {
 	struct rapl_counter rapl_dram_perf_status;	/* MSR_DRAM_PERF_STATUS */
 	unsigned int pkg_temp_c;
 	unsigned int uncore_mhz;
-	unsigned long long counter[MAX_ADDED_COUNTERS];
+	unsigned long long counter[MAX_ADDED_PACKAGE_COUNTERS];
 } *package_even, *package_odd;
 
 #define ODD_COUNTERS thread_odd, core_odd, package_odd
@@ -1955,13 +1965,15 @@ void print_header(char *delim)
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
 				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
-			else
+			else if (mp->width == 32)
 				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
+			else
+				outp += sprintf(outp, "%s%7.7s", delim, mp->name);
 		} else {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
 				outp += sprintf(outp, "%s%8s", delim, mp->name);
 			else
-				outp += sprintf(outp, "%s%s", delim, mp->name);
+				outp += sprintf(outp, "%s%7.7s", delim, mp->name);
 		}
 	}
 
@@ -1993,7 +2005,7 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 			outp +=
 			    sprintf(outp, "tADDED [%d] %8s msr0x%x: %08llX %s\n", i, mp->name, mp->msr_num,
-				    t->counter[i], mp->path);
+				    t->counter[i], mp->sp->path);
 		}
 	}
 
@@ -2014,7 +2026,7 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 			outp +=
 			    sprintf(outp, "cADDED [%d] %8s msr0x%x: %08llX %s\n", i, mp->name, mp->msr_num,
-				    c->counter[i], mp->path);
+				    c->counter[i], mp->sp->path);
 		}
 		outp += sprintf(outp, "mc6_us: %016llX\n", c->mc6_us);
 	}
@@ -2050,7 +2062,7 @@ int dump_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 			outp +=
 			    sprintf(outp, "pADDED [%d] %8s msr0x%x: %08llX %s\n", i, mp->name, mp->msr_num,
-				    p->counter[i], mp->path);
+				    p->counter[i], mp->sp->path);
 		}
 	}
 
@@ -2415,7 +2427,8 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 				outp += sprintf(outp, "%s%lld", (printed++ ? delim : ""), p->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->counter[i] / tsc);
-		}
+		} else if (mp->type == COUNTER_K2M)
+			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->counter[i] / 1000);
 	}
 
 done:
@@ -2525,6 +2538,8 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			old->counter[i] = new->counter[i];
+		else if (mp->format == FORMAT_AVERAGE)
+			old->counter[i] = new->counter[i];
 		else
 			old->counter[i] = new->counter[i] - old->counter[i];
 	}
@@ -2997,7 +3012,7 @@ unsigned long long snapshot_sysfs_counter(char *path)
 	return counter;
 }
 
-int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
+int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp, char *counter_path)
 {
 	if (mp->msr_num != 0) {
 		assert(!no_msr);
@@ -3007,11 +3022,11 @@ int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
 		char path[128 + PATH_BYTES];
 
 		if (mp->flags & SYSFS_PERCPU) {
-			sprintf(path, "/sys/devices/system/cpu/cpu%d/%s", cpu, mp->path);
+			sprintf(path, "/sys/devices/system/cpu/cpu%d/%s", cpu, mp->sp->path);
 
 			*counterp = snapshot_sysfs_counter(path);
 		} else {
-			*counterp = snapshot_sysfs_counter(mp->path);
+			*counterp = snapshot_sysfs_counter(counter_path);
 		}
 	}
 
@@ -3486,6 +3501,18 @@ int get_rapl_counters(int cpu, int domain, struct core_data *c, struct pkg_data
 	return 0;
 }
 
+char *find_sysfs_path_by_id(struct sysfs_path *sp, int id)
+{
+	while (sp) {
+		if (sp->id == id)
+			return (sp->path);
+		sp = sp->next;
+	}
+	if (debug)
+		warnx("%s: id%d not found", __func__, id);
+	return NULL;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -3547,7 +3574,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	}
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
-		if (get_mp(cpu, mp, &t->counter[i]))
+		if (get_mp(cpu, mp, &t->counter[i], mp->sp->path))
 			return -10;
 	}
 
@@ -3602,7 +3629,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		get_core_throt_cnt(cpu, &c->core_throt_cnt);
 
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
-		if (get_mp(cpu, mp, &c->counter[i]))
+		if (get_mp(cpu, mp, &c->counter[i], mp->sp->path))
 			return -10;
 	}
 
@@ -3694,7 +3721,16 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		p->sam_act_mhz = gfx_info[SAM_ACTMHz].val;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
-		if (get_mp(cpu, mp, &p->counter[i]))
+		char *path = NULL;
+
+		if (mp->msr_num == 0) {
+			path = find_sysfs_path_by_id(mp->sp, p->package_id);
+			if (path == NULL) {
+				warnx("%s: package_id %d not found", __func__, p->package_id);
+				return -10;
+			}
+		}
+		if (get_mp(cpu, mp, &p->counter[i], path))
 			return -10;
 	}
 done:
@@ -5390,6 +5426,7 @@ static void probe_intel_uncore_frequency_cluster(void)
 		int k, l;
 		char path_base[128];
 		int package_id, domain_id, cluster_id;
+		char name_buf[16];
 
 		sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/uncore%02d", i);
 
@@ -5422,6 +5459,11 @@ static void probe_intel_uncore_frequency_cluster(void)
 		sprintf(path, "%s/current_freq_khz", path_base);
 		k = read_sysfs_int(path);
 		fprintf(outf, " %d MHz\n", k / 1000);
+
+		sprintf(path, "%s/current_freq_khz", path_base);
+		sprintf(name_buf, "UMHz%d.%d", domain_id, cluster_id);
+
+		add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0, package_id);
 	}
 }
 
@@ -7575,61 +7617,114 @@ void print_bootcmd(void)
 	fclose(fp);
 }
 
+struct msr_counter *find_msrp_by_name(struct msr_counter *head, char *name)
+{
+	struct msr_counter *mp;
+
+	for (mp = head; mp; mp = mp->next) {
+		if (debug)
+			printf("%s: %s %s\n", __func__, name, mp->name);
+		if (!strncmp(name, mp->name, strlen(mp->name)))
+			return mp;
+	}
+	return NULL;
+}
+
 int add_counter(unsigned int msr_num, char *path, char *name,
 		unsigned int width, enum counter_scope scope,
-		enum counter_type type, enum counter_format format, int flags)
+		enum counter_type type, enum counter_format format, int flags, int id)
 {
 	struct msr_counter *msrp;
 
 	if (no_msr && msr_num)
 		errx(1, "Requested MSR counter 0x%x, but in --no-msr mode", msr_num);
 
-	msrp = calloc(1, sizeof(struct msr_counter));
-	if (msrp == NULL) {
-		perror("calloc");
-		exit(1);
-	}
-
-	msrp->msr_num = msr_num;
-	strncpy(msrp->name, name, NAME_BYTES - 1);
-	if (path)
-		strncpy(msrp->path, path, PATH_BYTES - 1);
-	msrp->width = width;
-	msrp->type = type;
-	msrp->format = format;
-	msrp->flags = flags;
+	if (debug)
+		printf("%s(msr%d, %s, %s, width%d, scope%d, type%d, format%d, flags%x, id%d)\n", __func__, msr_num,
+		       path, name, width, scope, type, format, flags, id);
 
 	switch (scope) {
 
 	case SCOPE_CPU:
-		msrp->next = sys.tp;
-		sys.tp = msrp;
-		sys.added_thread_counters++;
-		if (sys.added_thread_counters > MAX_ADDED_THREAD_COUNTERS) {
-			fprintf(stderr, "exceeded max %d added thread counters\n", MAX_ADDED_COUNTERS);
-			exit(-1);
+		msrp = find_msrp_by_name(sys.tp, name);
+		if (msrp) {
+			if (debug)
+				printf("%s: %s FOUND\n", __func__, name);
+			break;
+		}
+		if (sys.added_thread_counters++ >= MAX_ADDED_THREAD_COUNTERS) {
+			warnx("ignoring thread counter %s", name);
+			return -1;
 		}
 		break;
-
 	case SCOPE_CORE:
-		msrp->next = sys.cp;
-		sys.cp = msrp;
-		sys.added_core_counters++;
-		if (sys.added_core_counters > MAX_ADDED_COUNTERS) {
-			fprintf(stderr, "exceeded max %d added core counters\n", MAX_ADDED_COUNTERS);
-			exit(-1);
+		msrp = find_msrp_by_name(sys.cp, name);
+		if (msrp) {
+			if (debug)
+				printf("%s: %s FOUND\n", __func__, name);
+			break;
+		}
+		if (sys.added_core_counters++ >= MAX_ADDED_CORE_COUNTERS) {
+			warnx("ignoring core counter %s", name);
+			return -1;
 		}
 		break;
-
 	case SCOPE_PACKAGE:
-		msrp->next = sys.pp;
-		sys.pp = msrp;
-		sys.added_package_counters++;
-		if (sys.added_package_counters > MAX_ADDED_COUNTERS) {
-			fprintf(stderr, "exceeded max %d added package counters\n", MAX_ADDED_COUNTERS);
-			exit(-1);
+		msrp = find_msrp_by_name(sys.pp, name);
+		if (msrp) {
+			if (debug)
+				printf("%s: %s FOUND\n", __func__, name);
+			break;
+		}
+		if (sys.added_package_counters++ >= MAX_ADDED_PACKAGE_COUNTERS) {
+			warnx("ignoring package counter %s", name);
+			return -1;
 		}
 		break;
+	default:
+		warnx("ignoring counter %s with unknown scope", name);
+		return -1;
+	}
+
+	if (msrp == NULL) {
+		msrp = calloc(1, sizeof(struct msr_counter));
+		if (msrp == NULL)
+			err(-1, "calloc msr_counter");
+		msrp->msr_num = msr_num;
+		strncpy(msrp->name, name, NAME_BYTES - 1);
+		msrp->width = width;
+		msrp->type = type;
+		msrp->format = format;
+		msrp->flags = flags;
+
+		switch (scope) {
+		case SCOPE_CPU:
+			msrp->next = sys.tp;
+			sys.tp = msrp;
+			break;
+		case SCOPE_CORE:
+			msrp->next = sys.cp;
+			sys.cp = msrp;
+			break;
+		case SCOPE_PACKAGE:
+			msrp->next = sys.pp;
+			sys.pp = msrp;
+			break;
+		}
+	}
+
+	if (path) {
+		struct sysfs_path *sp;
+
+		sp = calloc(1, sizeof(struct sysfs_path));
+		if (sp == NULL) {
+			perror("calloc");
+			exit(1);
+		}
+		strncpy(sp->path, path, PATH_BYTES - 1);
+		sp->id = id;
+		sp->next = msrp->sp;
+		msrp->sp = sp;
 	}
 
 	return 0;
@@ -7731,7 +7826,7 @@ void parse_add_command(char *add_command)
 			sprintf(name_buffer, "M0X%x%s", msr_num, format == FORMAT_PERCENT ? "%" : "");
 	}
 
-	if (add_counter(msr_num, path, name_buffer, width, scope, type, format, 0))
+	if (add_counter(msr_num, path, name_buffer, width, scope, type, format, 0, 0))
 		fail++;
 
 	if (fail) {
@@ -7796,7 +7891,7 @@ void probe_sysfs(void)
 		if (is_deferred_skip(name_buf))
 			continue;
 
-		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_USEC, FORMAT_PERCENT, SYSFS_PERCPU);
+		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_USEC, FORMAT_PERCENT, SYSFS_PERCPU, 0);
 	}
 
 	for (state = 10; state >= 0; --state) {
@@ -7824,7 +7919,7 @@ void probe_sysfs(void)
 		if (is_deferred_skip(name_buf))
 			continue;
 
-		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU);
+		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
 	}
 
 }
-- 
2.40.1


