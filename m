Return-Path: <linux-pm+bounces-6092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE5289CF6E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D781C23F3B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4309079CF;
	Tue,  9 Apr 2024 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi1+vm+9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8B5231
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622724; cv=none; b=EQll0Q7ohARc/zN41KNE7RjYEsYD/IGWhmjndO+9URZIzNCpwRu4pA29/oYHOztkyoJjd1L3F8TfHMBYg8G+GFZx0DBZzbc2rzvL1+mq1Npym+R2kK3vPVoTZa9ZUHxpNPDuSkMZfzidraPBDCqoUXNmpdNqmKM70CxtcsQn1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622724; c=relaxed/simple;
	bh=OR4/ymGzinO2JG/WSH+n5uNXciQdd1TW4KdGxybvODA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbTEY3j7JDCsh3c8UOC0WI3+3+zCgfN/uKS1r+wtXgnJ9uFSSk4s4x65aNdfvAK2DOsU6I6jZUvhUu/2b4Wr3jsxV3lmkyv/moOJ3ZqrHOK0ZYeoQNYl1soiIjlFEtCITqa3qv/BKRw2zNQ64N+RV1XdLHzbn3Kc4/IR4BjGWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi1+vm+9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so4975667276.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622721; x=1713227521; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sk2ylhTUvpRDkyAxMxGuAEs6OqeCTy/nYzwuc5GiXXc=;
        b=Zi1+vm+90lsa6etTcE3M48WJdjMnGMYhiwoTZUBhHv5FybdH+U0sw4FGi+CPFsozGr
         PI7mAvzthkp8dBIqVPEWLseFSxO0FEait2InNAP3MKgoCWf9JLBr+uKoW5Rligxypm3d
         5fsOXL5fhILQ7vYbDVMmSqAaoLUML28xbCsfyeBsdKqJwHatrCT2StKdKoLWWpODLo8G
         vNBO4+2Y3b8m3+yCsY/ptnvCsTFtev8Y7DgfCn6E4jDcv51uhvTBIfG1G31lE30H2JqM
         3OoKOvILhjRax1gBDpSqidAZmo/Mk/b4s33T7vYXQmkr22XJ/ZtyCFljnEOUPfUtmcGZ
         0cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622721; x=1713227521;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk2ylhTUvpRDkyAxMxGuAEs6OqeCTy/nYzwuc5GiXXc=;
        b=YZLE68yk+XldGdKItZkwaJXuPNipOR5lUF6OElX+Voq/e5bj3hn3thKG0DoPS/0Pbr
         OVAwBH7eE11wBYJAXTenJ++gKsBPjIWtj0swdK1dehmDMltmlOKu1GAIxrBMow3kdPHg
         Q7EehsaQ8CR1R6/Hu/2K0JY/gzRt9DGY7KnChiLVbYrL/8aiU7nYI0hPHbNUc6vK32Ah
         YQVKudV5f72agAokB4TaPD7GlaDihj7LoNNAljhp6GVxrPIG9TtRhVzHYfpVqVlxEDyE
         VZB325znq2OC4ZUBZB6Z9qbKwOdiP7IKYdO0KePmsHFUNGQT/n4A/ikTof1EiTQeQKx9
         EbIA==
X-Gm-Message-State: AOJu0Yzx/OJiX21ZWDXofK/hdVrRuyPAo1A8tfJAJ4Ucmt/jYaw9Usfl
	cIEZ0eKbXLQga6UqvDD767H3iFFkd9O3p8wvJtlFQ1g9D6RRBeHQkHBnb9l8
X-Google-Smtp-Source: AGHT+IE2c/vBYLx0t5kKlJqOSJ46o3gJgogQDFVJ6Ea1/foL8Fcl07gsWTsf85ulCEBz3kbRq+gGSQ==
X-Received: by 2002:a05:6902:20c9:b0:dcf:3ef2:6182 with SMTP id dj9-20020a05690220c900b00dcf3ef26182mr10254367ybb.0.1712622721344;
        Mon, 08 Apr 2024 17:32:01 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:32:01 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 20/26] tools/power/turbostat: Cache graphics sysfs path
Date: Mon,  8 Apr 2024 20:31:14 -0400
Message-Id: <6dc2648536279c918cf6e0dbaed90be923a6c49a.1712621427.git.len.brown@intel.com>
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

Graphics drivers (i915/Xe) have different sysfs knobs on different
platforms, and it is possible that different sysfs knobs fit into the
same turbostat columns.

Instead of specifying different sysfs knobs every time, detect them
once and cache the path for future use.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 45 +++++++++++++++++++--------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c8b148942fa0..4c26eefeca24 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -276,6 +276,19 @@ bool no_msr;
 bool no_perf;
 enum amperf_source amperf_source;
 
+enum gfx_sysfs_idx {
+	GFX_rc6,
+	GFX_MHz,
+	GFX_ACTMHz,
+	GFX_MAX
+};
+
+struct gfx_sysfs_info {
+	const char *path;
+};
+
+static struct gfx_sysfs_info gfx_info[GFX_MAX];
+
 int get_msr(int cpu, off_t offset, unsigned long long *msr);
 
 /* Model specific support Start */
@@ -4616,7 +4629,7 @@ int snapshot_gfx_rc6_ms(void)
 	FILE *fp;
 	int retval;
 
-	fp = fopen_or_die("/sys/class/drm/card0/power/rc6_residency_ms", "r");
+	fp = fopen_or_die(gfx_info[GFX_rc6].path, "r");
 
 	retval = fscanf(fp, "%lld", &gfx_cur_rc6_ms);
 	if (retval != 1)
@@ -4641,9 +4654,7 @@ int snapshot_gfx_mhz(void)
 	int retval;
 
 	if (fp == NULL) {
-		fp = fopen("/sys/class/drm/card0/gt_cur_freq_mhz", "r");
-		if (!fp)
-			fp = fopen_or_die("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", "r");
+		fp = fopen_or_die(gfx_info[GFX_MHz].path, "r");
 	} else {
 		rewind(fp);
 		fflush(fp);
@@ -4670,9 +4681,7 @@ int snapshot_gfx_act_mhz(void)
 	int retval;
 
 	if (fp == NULL) {
-		fp = fopen("/sys/class/drm/card0/gt_act_freq_mhz", "r");
-		if (!fp)
-			fp = fopen_or_die("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", "r");
+		fp = fopen_or_die(gfx_info[GFX_ACTMHz].path, "r");
 	} else {
 		rewind(fp);
 		fflush(fp);
@@ -5334,14 +5343,24 @@ static void probe_intel_uncore_frequency(void)
 static void probe_graphics(void)
 {
 	if (!access("/sys/class/drm/card0/power/rc6_residency_ms", R_OK))
-		BIC_PRESENT(BIC_GFX_rc6);
+		gfx_info[GFX_rc6].path = "/sys/class/drm/card0/power/rc6_residency_ms";
 
-	if (!access("/sys/class/drm/card0/gt_cur_freq_mhz", R_OK) ||
-	    !access("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", R_OK))
-		BIC_PRESENT(BIC_GFXMHz);
+	if (!access("/sys/class/drm/card0/gt_cur_freq_mhz", R_OK))
+		gfx_info[GFX_MHz].path = "/sys/class/drm/card0/gt_cur_freq_mhz";
+	else if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", R_OK))
+		gfx_info[GFX_MHz].path = "/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz";
+
+
+	if (!access("/sys/class/drm/card0/gt_act_freq_mhz", R_OK))
+		gfx_info[GFX_ACTMHz].path = "/sys/class/drm/card0/gt_act_freq_mhz";
+	else if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", R_OK))
+		gfx_info[GFX_ACTMHz].path = "/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz";
 
-	if (!access("/sys/class/drm/card0/gt_act_freq_mhz", R_OK) ||
-	    !access("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", R_OK))
+	if (gfx_info[GFX_rc6].path)
+		BIC_PRESENT(BIC_GFX_rc6);
+	if (gfx_info[GFX_MHz].path)
+		BIC_PRESENT(BIC_GFXMHz);
+	if (gfx_info[GFX_ACTMHz].path)
 		BIC_PRESENT(BIC_GFXACTMHz);
 }
 
-- 
2.40.1


