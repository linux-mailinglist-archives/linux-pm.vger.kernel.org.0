Return-Path: <linux-pm+bounces-6093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E4789CF70
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA44E284BCE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0585CB0;
	Tue,  9 Apr 2024 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIiJVKSn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE38BE8
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622724; cv=none; b=RrctfkEllPNfKfuYv5pUUClUtscr0sFB1PzARveGZge6i+BOnG3Sm+qcuCccSCn/nwrNch21uSDkm/QGNNIMYWN27AAb8YnF2Nr+4E1RNwhqa3MNPCXweOQ/Vdwx/CShetAJexpSomSrs0/cJqV05QT7kW1eKt0r2YSiWqp7kGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622724; c=relaxed/simple;
	bh=9DvyiQ5cmVfEHS9en053kSG/3AnU3Q6AB/z1DwyOqWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpmXu7c5FKgf4yi3cwNcAJ6BPf4dALM7US4i3GVaCQp7gy1Y/VG8PWEoTjAVbXkG74jbQkvOfREROPFJm3SDSiADT1wcRkomMzHUWca/xYYfMZxokPxBFB9x6x5ZwfCYDIlL9b/XfR+CRu59eSjecb6F/FHIOtyuSNDipj5Ic38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIiJVKSn; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so4972260276.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622722; x=1713227522; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiiR+qQjnUBO6RaNbAiylki53QLfCNwffKMAjAsmniA=;
        b=fIiJVKSnVTVD2ATcQtFhmz5SXZXcea3ANZc8CB4p0dotdINsExWQE5ai66ozqcF4Q1
         LeOWCkGrQxckFlhqS+PMPHMc4fwwAzU4qmDELNMr4diLxApJXJHJKZmeq+wliXxZBcmi
         ubvuweEKv7x6jw6qyNuc0ZfHJACfUcH6XPyTr0wQeGR/XgHpvvZeLDQiHt5Irk3kaYHr
         vkYK/o5vbU2PB6w1TlLqxg54abdXFHYhoyd8Jz5WksGESvqygU1CAwHUWCfvAXpfcA3w
         WOxs4I8IROq+OqvnFEt2y6JZJE7UOmqdNleaWuCWtxgHSdJPjp57S5ANqBC7xYqwVdgQ
         wTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622722; x=1713227522;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiiR+qQjnUBO6RaNbAiylki53QLfCNwffKMAjAsmniA=;
        b=JT6AHJ0FrOj4WymEXpaF0eusgNrm2SsfI5PFwZVASWo2RN3mTnoXkHACCxsA06dvdd
         z0nppitQa0XThKTbOBnoRR8QU96IcnVF1qwd/skszKPbl84TmA43fVVzNfS5f17F4h4T
         hJorg1D4Oy+H50aRHjA+abE2zl3ATV++hCgmwDMv+V8x5YafyZRCn9gzKhJ9hbN444Pc
         h5m88sk6BR5OzqQ1id+eL0hcw/WTloG2FGHKX4U6S9wvsAj1mYZtUMEeeMhTV+Q0Z5xY
         C8d3/xE/9uxA7Odn1F6b70UKycNOV12KORAKQOHBoLugZ3YhEul8siGyuZ27h33Xr7Y3
         xExg==
X-Gm-Message-State: AOJu0YzSUpHDs9xUd4nqhsF79qqtF7w2CdUXwud/rj26S0/CvEmaQLcA
	k7bL3U2iXhTZUwoq7JpzGCjKXXqB4LoCYz9+92aZTbhqGO3tgbZJMi/WUCA7
X-Google-Smtp-Source: AGHT+IGrchvSgUOSCqosLjtJxbOEPriEoVhXDlBnWssgcvdixN/L3Lp8+dHib1sc/pB6A9BNsPF2ZQ==
X-Received: by 2002:a25:148b:0:b0:dc6:d808:cf75 with SMTP id 133-20020a25148b000000b00dc6d808cf75mr7763912ybu.20.1712622722006;
        Mon, 08 Apr 2024 17:32:02 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:32:01 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 21/26] tools/power/turbostat: Unify graphics sysfs snapshots
Date: Mon,  8 Apr 2024 20:31:15 -0400
Message-Id: <ed9ddd35267bed801eb86e78847e533bb31c45b4.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
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

Graphics sysfs snapshots share similar logic.
Combine them into one function to avoid code duplication.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 109 ++++++++------------------
 1 file changed, 34 insertions(+), 75 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4c26eefeca24..cba000c198d7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -251,11 +251,8 @@ char *output_buffer, *outp;
 unsigned int do_dts;
 unsigned int do_ptm;
 unsigned int do_ipc;
-unsigned long long gfx_cur_rc6_ms;
 unsigned long long cpuidle_cur_cpu_lpi_us;
 unsigned long long cpuidle_cur_sys_lpi_us;
-unsigned int gfx_cur_mhz;
-unsigned int gfx_act_mhz;
 unsigned int tj_max;
 unsigned int tj_max_override;
 double rapl_power_units, rapl_time_units;
@@ -285,6 +282,9 @@ enum gfx_sysfs_idx {
 
 struct gfx_sysfs_info {
 	const char *path;
+	FILE *fp;
+	unsigned int val;
+	unsigned long long val_ull;
 };
 
 static struct gfx_sysfs_info gfx_info[GFX_MAX];
@@ -3571,17 +3571,17 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	}
 
 	if (DO_BIC(BIC_GFX_rc6))
-		p->gfx_rc6_ms = gfx_cur_rc6_ms;
+		p->gfx_rc6_ms = gfx_info[GFX_rc6].val_ull;
 
 	/* n.b. assume die0 uncore frequency applies to whole package */
 	if (DO_BIC(BIC_UNCORE_MHZ))
 		p->uncore_mhz = get_uncore_mhz(p->package_id, 0);
 
 	if (DO_BIC(BIC_GFXMHz))
-		p->gfx_mhz = gfx_cur_mhz;
+		p->gfx_mhz = gfx_info[GFX_MHz].val;
 
 	if (DO_BIC(BIC_GFXACTMHz))
-		p->gfx_act_mhz = gfx_act_mhz;
+		p->gfx_act_mhz = gfx_info[GFX_ACTMHz].val;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (get_mp(cpu, mp, &p->counter[i]))
@@ -4617,81 +4617,40 @@ int snapshot_proc_interrupts(void)
 }
 
 /*
- * snapshot_gfx_rc6_ms()
+ * snapshot_graphics()
  *
- * record snapshot of
- * /sys/class/drm/card0/power/rc6_residency_ms
+ * record snapshot of specified graphics sysfs knob
  *
  * return 1 if config change requires a restart, else return 0
  */
-int snapshot_gfx_rc6_ms(void)
+int snapshot_graphics(int idx)
 {
 	FILE *fp;
 	int retval;
 
-	fp = fopen_or_die(gfx_info[GFX_rc6].path, "r");
-
-	retval = fscanf(fp, "%lld", &gfx_cur_rc6_ms);
-	if (retval != 1)
-		err(1, "GFX rc6");
-
-	fclose(fp);
-
-	return 0;
-}
-
-/*
- * snapshot_gfx_mhz()
- *
- * fall back to /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz
- * when /sys/class/drm/card0/gt_cur_freq_mhz is not available.
- *
- * return 1 if config change requires a restart, else return 0
- */
-int snapshot_gfx_mhz(void)
-{
-	static FILE *fp;
-	int retval;
-
-	if (fp == NULL) {
-		fp = fopen_or_die(gfx_info[GFX_MHz].path, "r");
-	} else {
-		rewind(fp);
-		fflush(fp);
-	}
-
-	retval = fscanf(fp, "%d", &gfx_cur_mhz);
-	if (retval != 1)
-		err(1, "GFX MHz");
-
-	return 0;
-}
-
-/*
- * snapshot_gfx_cur_mhz()
- *
- * fall back to /sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz
- * when /sys/class/drm/card0/gt_act_freq_mhz is not available.
- *
- * return 1 if config change requires a restart, else return 0
- */
-int snapshot_gfx_act_mhz(void)
-{
-	static FILE *fp;
-	int retval;
-
-	if (fp == NULL) {
-		fp = fopen_or_die(gfx_info[GFX_ACTMHz].path, "r");
-	} else {
-		rewind(fp);
-		fflush(fp);
+	switch (idx) {
+	case GFX_rc6:
+		fp = fopen_or_die(gfx_info[idx].path, "r");
+		retval = fscanf(fp, "%lld", &gfx_info[idx].val_ull);
+		if (retval != 1)
+			err(1, "rc6");
+		fclose(fp);
+		return 0;
+	case GFX_MHz:
+	case GFX_ACTMHz:
+		if (gfx_info[idx].fp == NULL) {
+			gfx_info[idx].fp = fopen_or_die(gfx_info[idx].path, "r");
+		} else {
+			rewind(gfx_info[idx].fp);
+			fflush(gfx_info[idx].fp);
+		}
+		retval = fscanf(gfx_info[idx].fp, "%d", &gfx_info[idx].val);
+		if (retval != 1)
+			err(1, "MHz");
+		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	retval = fscanf(fp, "%d", &gfx_act_mhz);
-	if (retval != 1)
-		err(1, "GFX ACT MHz");
-
-	return 0;
 }
 
 /*
@@ -4756,13 +4715,13 @@ int snapshot_proc_sysfs_files(void)
 			return 1;
 
 	if (DO_BIC(BIC_GFX_rc6))
-		snapshot_gfx_rc6_ms();
+		snapshot_graphics(GFX_rc6);
 
 	if (DO_BIC(BIC_GFXMHz))
-		snapshot_gfx_mhz();
+		snapshot_graphics(GFX_MHz);
 
 	if (DO_BIC(BIC_GFXACTMHz))
-		snapshot_gfx_act_mhz();
+		snapshot_graphics(GFX_ACTMHz);
 
 	if (DO_BIC(BIC_CPU_LPI))
 		snapshot_cpu_lpi_us();
-- 
2.40.1


