Return-Path: <linux-pm+bounces-6203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002C89F44A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CE5B2BDFA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42116161326;
	Wed, 10 Apr 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1qn1kXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F352161301
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755212; cv=none; b=FIADXtWaHy7kzq54yD9Ie+5w/AzvcZf+TE5h7nvwUERJYAZ5D7W8U9xyw9XTx6NFOqqy9ogobGasnomrzsZwlrVEAUnzbQRiMaaMdXtG4bkNytgQmV+BHLyWKoVIchsqa0g2+tLnieoVWp59yVEi60PQxNlTF8MwQCZr48CccM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755212; c=relaxed/simple;
	bh=dzm8bi6KpiHGeT8611eTq3bovQ/krbAcBuzZjvTpwgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sdch+bXkA74BPZs4XPGbLte/4B4Qm/DDaO/L8hTpuI3RxzUD1/9C9ZTAuV/eXFwQVWHdJpCjq0b95gAQdR2cVgOhjLBxZ0MxKKTZ8UEwGvjrYxMpu4nhonLEg0ePqRaAiKKiSS3l9vlaz4kNRXX8d6y7aDOBz+lwC+Gnnz2QtKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1qn1kXP; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6151d79db7bso77001097b3.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755209; x=1713360009; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhDTDlM2HBPnJHvGy4cqJbenh9/TlUPOYaDHOE0QtlQ=;
        b=O1qn1kXP/2rD5CuocfZLDiRKyFC8gtzBgEw35LjPZSyDT7Qqh+hdv4scKiDoF7IYBa
         XOcTsO80OEmldvzkdUz3HW59jRlViylxvkfrq9OazdM3EGhd1lD0S3mstA0ETG+RrBlV
         SlVlRNy6GCC6uCrjtWLB5qpvKfuQxdkYomG7vQ9URMhXBqDFzDxpxxbfMw5qrJmSqtLj
         GqiJOj1tJTy9T1fA61fvpQZpLQkJuYnCE0CZlSGEIkWeXbv5byktTHBO7hBQvCTxzTMn
         6XSKR39AtzWNezg7To4IsA55PwbEKoqO8rCFprSP69ThAzYxK61+tmEiFT5PgTTQhbKX
         YUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755209; x=1713360009;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhDTDlM2HBPnJHvGy4cqJbenh9/TlUPOYaDHOE0QtlQ=;
        b=sDWCtsBfVAjPqHuzwmiux1z9YR1z7E55yiwMmG6mAW5fhHd1Y2G2SZU6NJj9IKgqhm
         DZ5Erb2o+lYCpL7jUwkRZxUSbDd58ieaPn1K3bmBhd3okjwSVxIjwFwVQHsmxjNco7Ie
         qDYdNzkSjm1uhrjL0K4pNmshVmpDIwiHJKaKQtrCiY/Wi5f2yZS6AypPPf1CC/PM7ays
         7jT493wJ+gYCfNob8/hCw6o7SeTGPupciR5pbGFVLc58v0gZSv3SMSqi7nXqhkElWFMD
         H5AITsOU44ibaJ/u90e6ugmPfA3bMdXc/rZF+RglT79q/76WfWEK2w2Bpkx4bb7/DzUZ
         9o2A==
X-Gm-Message-State: AOJu0Yzu/6IlpkepMqQlMpBP30jizvAtoSiUhnI9GeecCL06nhnsMSRM
	KxVasbdqC+VDLhxhr6/6/ULuO3zAuKrvgfjByTvfdmbbteTmQTxFMr36Auzp
X-Google-Smtp-Source: AGHT+IFKKaSD9T8j6CG0YkHHTaaU0dZbUj/O6z9uKxb+i2gL1/nEATmAiVjfxd7EMNrwTTPuYHJJhA==
X-Received: by 2002:a0d:eb8a:0:b0:615:48e:cc63 with SMTP id u132-20020a0deb8a000000b00615048ecc63mr2756665ywe.44.1712755208852;
        Wed, 10 Apr 2024 06:20:08 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-b580-a474-89e0-3bb1.inf6.spectrum.com. [2603:9000:9f01:67cf:b580:a474:89e0:3bb1])
        by smtp.gmail.com with ESMTPSA id x66-20020a0dd545000000b006143d243915sm2700864ywd.10.2024.04.10.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:20:08 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 23/26] tools/power/turbostat: Introduce BIC_SAM_mc6/BIC_SAMMHz/BIC_SAMACTMHz
Date: Wed, 10 Apr 2024 09:19:46 -0400
Message-Id: <3bbb331c1d34fdd5520a050fce35f71579430485.1712754901.git.len.brown@intel.com>
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

From: Zhang Rui <rui.zhang@intel.com>

Graphics driver (i915/Xe) on mordern platforms splits GFX and SA Media
information via different sysfs knobs.

Existing BIC_GFX_rc6/BIC_GFXMHz/BIC_GFXACTMHz columns can be reused for
GFX.

Introduce BIC_SAM_mc6/BIC_SAMMHz/BIC_SAMACTMHz columns for SA Media.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 12 +++-
 tools/power/x86/turbostat/turbostat.c | 91 +++++++++++++++++++++++++--
 2 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 567327b004e6..0d3672e5d9ed 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -129,9 +129,17 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBPkgTmp\fP Degrees Celsius reported by the per-package Package Thermal Monitor.
 .PP
-\fBGFX%rc6\fP The percentage of time the GPU is in the "render C6" state, rc6, during the measurement interval. From /sys/class/drm/card0/power/rc6_residency_ms.
+\fBGFX%rc6\fP The percentage of time the GPU is in the "render C6" state, rc6, during the measurement interval. From /sys/class/drm/card0/power/rc6_residency_ms or /sys/class/drm/card0/gt/gt0/rc6_residency_ms or /sys/class/drm/card0/device/tile0/gtN/gtidle/idle_residency_ms depending on the graphics driver being used.
 .PP
-\fBGFXMHz\fP Instantaneous snapshot of what sysfs presents at the end of the measurement interval. From /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz.
+\fBGFXMHz\fP Instantaneous snapshot of what sysfs presents at the end of the measurement interval. From /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz or /sys/class/drm/card0/gt_cur_freq_mhz or /sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz or /sys/class/drm/card0/device/tile0/gtN/freq0/cur_freq depending on the graphics driver being used.
+.PP
+\fBGFXAMHz\fP Instantaneous snapshot of what sysfs presents at the end of the measurement interval. From /sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz or /sys/class/drm/card0/gt_act_freq_mhz or /sys/class/drm/card0/gt/gt0/rps_act_freq_mhz or /sys/class/drm/card0/device/tile0/gtN/freq0/act_freq depending on the graphics driver being used.
+.PP
+\fBSAM%mc6\fP The percentage of time the SA Media is in the "module C6" state, mc6, during the measurement interval. From /sys/class/drm/card0/gt/gt1/rc6_residency_ms or /sys/class/drm/card0/device/tile0/gtN/gtidle/idle_residency_ms depending on the graphics driver being used.
+.PP
+\fBSAMMHz\fP Instantaneous snapshot of what sysfs presents at the end of the measurement interval. From /sys/class/drm/card0/gt/gt1/rps_cur_freq_mhz or /sys/class/drm/card0/device/tile0/gtN/freq0/cur_freq depending on the graphics driver being used.
+.PP
+\fBSAMAMHz\fP Instantaneous snapshot of what sysfs presents at the end of the measurement interval. From /sys/class/drm/card0/gt/gt1/rps_act_freq_mhz or /sys/class/drm/card0/device/tile0/gtN/freq0/act_freq depending on the graphics driver being used.
 .PP
 \fBPkg%pc2, Pkg%pc3, Pkg%pc6, Pkg%pc7\fP percentage residency in hardware package idle states.  These numbers are from hardware residency counters.
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 016a5c7dc9bf..4fa2810da1a3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -133,6 +133,9 @@ struct msr_counter bic[] = {
 	{ 0x0, "IPC", "", 0, 0, 0, NULL, 0 },
 	{ 0x0, "CoreThr", "", 0, 0, 0, NULL, 0 },
 	{ 0x0, "UncMHz", "", 0, 0, 0, NULL, 0 },
+	{ 0x0, "SAM%mc6", "", 0, 0, 0, NULL, 0 },
+	{ 0x0, "SAMMHz", "", 0, 0, 0, NULL, 0 },
+	{ 0x0, "SAMAMHz", "", 0, 0, 0, NULL, 0 },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -191,11 +194,14 @@ struct msr_counter bic[] = {
 #define	BIC_IPC		(1ULL << 52)
 #define	BIC_CORE_THROT_CNT	(1ULL << 53)
 #define	BIC_UNCORE_MHZ		(1ULL << 54)
+#define	BIC_SAM_mc6		(1ULL << 55)
+#define	BIC_SAMMHz		(1ULL << 56)
+#define	BIC_SAMACTMHz		(1ULL << 57)
 
 #define BIC_TOPOLOGY (BIC_Package | BIC_Node | BIC_CoreCnt | BIC_PkgCnt | BIC_Core | BIC_CPU | BIC_Die )
 #define BIC_THERMAL_PWR ( BIC_CoreTmp | BIC_PkgTmp | BIC_PkgWatt | BIC_CorWatt | BIC_GFXWatt | BIC_RAMWatt | BIC_PKG__ | BIC_RAM__)
-#define BIC_FREQUENCY ( BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_UNCORE_MHZ)
-#define BIC_IDLE ( BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX)
+#define BIC_FREQUENCY (BIC_Avg_MHz | BIC_Busy | BIC_Bzy_MHz | BIC_TSC_MHz | BIC_GFXMHz | BIC_GFXACTMHz | BIC_SAMMHz | BIC_SAMACTMHz | BIC_UNCORE_MHZ)
+#define BIC_IDLE (BIC_sysfs | BIC_CPU_c1 | BIC_CPU_c3 | BIC_CPU_c6 | BIC_CPU_c7 | BIC_GFX_rc6 | BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_CPU_LPI | BIC_SYS_LPI | BIC_Mod_c6 | BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_SAM_mc6)
 #define BIC_OTHER ( BIC_IRQ | BIC_SMI | BIC_ThreadC | BIC_CoreTmp | BIC_IPC)
 
 #define BIC_DISABLED_BY_DEFAULT	(BIC_USEC | BIC_TOD | BIC_APIC | BIC_X2APIC)
@@ -277,6 +283,9 @@ enum gfx_sysfs_idx {
 	GFX_rc6,
 	GFX_MHz,
 	GFX_ACTMHz,
+	SAM_mc6,
+	SAM_MHz,
+	SAM_ACTMHz,
 	GFX_MAX
 };
 
@@ -1193,6 +1202,9 @@ struct pkg_data {
 	long long gfx_rc6_ms;
 	unsigned int gfx_mhz;
 	unsigned int gfx_act_mhz;
+	long long sam_mc6_ms;
+	unsigned int sam_mhz;
+	unsigned int sam_act_mhz;
 	unsigned int package_id;
 	struct rapl_counter energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
 	struct rapl_counter energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
@@ -1844,6 +1856,15 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_GFXACTMHz))
 		outp += sprintf(outp, "%sGFXAMHz", (printed++ ? delim : ""));
 
+	if (DO_BIC(BIC_SAM_mc6))
+		outp += sprintf(outp, "%sSAM%%mc6", (printed++ ? delim : ""));
+
+	if (DO_BIC(BIC_SAMMHz))
+		outp += sprintf(outp, "%sSAMMHz", (printed++ ? delim : ""));
+
+	if (DO_BIC(BIC_SAMACTMHz))
+		outp += sprintf(outp, "%sSAMAMHz", (printed++ ? delim : ""));
+
 	if (DO_BIC(BIC_Totl_c0))
 		outp += sprintf(outp, "%sTotl%%C0", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Any_c0))
@@ -2251,6 +2272,24 @@ int format_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	if (DO_BIC(BIC_GFXACTMHz))
 		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->gfx_act_mhz);
 
+	/* SAMmc6 */
+	if (DO_BIC(BIC_SAM_mc6)) {
+		if (p->sam_mc6_ms == -1) {	/* detect GFX counter reset */
+			outp += sprintf(outp, "%s**.**", (printed++ ? delim : ""));
+		} else {
+			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""),
+					p->sam_mc6_ms / 10.0 / interval_float);
+		}
+	}
+
+	/* SAMMHz */
+	if (DO_BIC(BIC_SAMMHz))
+		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->sam_mhz);
+
+	/* SAMACTMHz */
+	if (DO_BIC(BIC_SAMACTMHz))
+		outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->sam_act_mhz);
+
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
 	if (DO_BIC(BIC_Totl_c0))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pkg_wtd_core_c0 / tsc);
@@ -2437,6 +2476,15 @@ int delta_package(struct pkg_data *new, struct pkg_data *old)
 	old->gfx_mhz = new->gfx_mhz;
 	old->gfx_act_mhz = new->gfx_act_mhz;
 
+	/* flag an error when mc6 counter resets/wraps */
+	if (old->sam_mc6_ms > new->sam_mc6_ms)
+		old->sam_mc6_ms = -1;
+	else
+		old->sam_mc6_ms = new->sam_mc6_ms - old->sam_mc6_ms;
+
+	old->sam_mhz = new->sam_mhz;
+	old->sam_act_mhz = new->sam_act_mhz;
+
 	old->energy_pkg.raw_value = new->energy_pkg.raw_value - old->energy_pkg.raw_value;
 	old->energy_cores.raw_value = new->energy_cores.raw_value - old->energy_cores.raw_value;
 	old->energy_gfx.raw_value = new->energy_gfx.raw_value - old->energy_gfx.raw_value;
@@ -2661,6 +2709,9 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	p->uncore_mhz = 0;
 	p->gfx_mhz = 0;
 	p->gfx_act_mhz = 0;
+	p->sam_mc6_ms = 0;
+	p->sam_mhz = 0;
+	p->sam_act_mhz = 0;
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next)
 		t->counter[i] = 0;
 
@@ -2775,6 +2826,9 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	average.packages.uncore_mhz = p->uncore_mhz;
 	average.packages.gfx_mhz = p->gfx_mhz;
 	average.packages.gfx_act_mhz = p->gfx_act_mhz;
+	average.packages.sam_mc6_ms = p->sam_mc6_ms;
+	average.packages.sam_mhz = p->sam_mhz;
+	average.packages.sam_act_mhz = p->sam_act_mhz;
 
 	average.packages.pkg_temp_c = MAX(average.packages.pkg_temp_c, p->pkg_temp_c);
 
@@ -3572,19 +3626,28 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		p->pkg_temp_c = tj_max - ((msr >> 16) & 0x7F);
 	}
 
-	if (DO_BIC(BIC_GFX_rc6))
-		p->gfx_rc6_ms = gfx_info[GFX_rc6].val_ull;
-
 	/* n.b. assume die0 uncore frequency applies to whole package */
 	if (DO_BIC(BIC_UNCORE_MHZ))
 		p->uncore_mhz = get_uncore_mhz(p->package_id, 0);
 
+	if (DO_BIC(BIC_GFX_rc6))
+		p->gfx_rc6_ms = gfx_info[GFX_rc6].val_ull;
+
 	if (DO_BIC(BIC_GFXMHz))
 		p->gfx_mhz = gfx_info[GFX_MHz].val;
 
 	if (DO_BIC(BIC_GFXACTMHz))
 		p->gfx_act_mhz = gfx_info[GFX_ACTMHz].val;
 
+	if (DO_BIC(BIC_SAM_mc6))
+		p->sam_mc6_ms = gfx_info[SAM_mc6].val_ull;
+
+	if (DO_BIC(BIC_SAMMHz))
+		p->sam_mhz = gfx_info[SAM_MHz].val;
+
+	if (DO_BIC(BIC_SAMACTMHz))
+		p->sam_act_mhz = gfx_info[SAM_ACTMHz].val;
+
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (get_mp(cpu, mp, &p->counter[i]))
 			return -10;
@@ -4634,6 +4697,7 @@ int snapshot_graphics(int idx)
 
 	switch (idx) {
 	case GFX_rc6:
+	case SAM_mc6:
 		fp = fopen_or_die(gfx_info[idx].path, "r");
 		retval = fscanf(fp, "%lld", &gfx_info[idx].val_ull);
 		if (retval != 1)
@@ -4642,6 +4706,8 @@ int snapshot_graphics(int idx)
 		return 0;
 	case GFX_MHz:
 	case GFX_ACTMHz:
+	case SAM_MHz:
+	case SAM_ACTMHz:
 		if (gfx_info[idx].fp == NULL) {
 			gfx_info[idx].fp = fopen_or_die(gfx_info[idx].path, "r");
 		} else {
@@ -4727,6 +4793,15 @@ int snapshot_proc_sysfs_files(void)
 	if (DO_BIC(BIC_GFXACTMHz))
 		snapshot_graphics(GFX_ACTMHz);
 
+	if (DO_BIC(BIC_SAM_mc6))
+		snapshot_graphics(SAM_mc6);
+
+	if (DO_BIC(BIC_SAMMHz))
+		snapshot_graphics(SAM_MHz);
+
+	if (DO_BIC(BIC_SAMACTMHz))
+		snapshot_graphics(SAM_ACTMHz);
+
 	if (DO_BIC(BIC_CPU_LPI))
 		snapshot_cpu_lpi_us();
 
@@ -5325,6 +5400,12 @@ static void probe_graphics(void)
 		BIC_PRESENT(BIC_GFXMHz);
 	if (gfx_info[GFX_ACTMHz].path)
 		BIC_PRESENT(BIC_GFXACTMHz);
+	if (gfx_info[SAM_mc6].path)
+		BIC_PRESENT(BIC_SAM_mc6);
+	if (gfx_info[SAM_MHz].path)
+		BIC_PRESENT(BIC_SAMMHz);
+	if (gfx_info[SAM_ACTMHz].path)
+		BIC_PRESENT(BIC_SAMACTMHz);
 }
 
 static void dump_sysfs_cstate_config(void)
-- 
2.40.1


