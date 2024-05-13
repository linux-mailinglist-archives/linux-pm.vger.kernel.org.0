Return-Path: <linux-pm+bounces-7773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2198C47B7
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA05B21590
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC7A78285;
	Mon, 13 May 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM5GlRGA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D97580A
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629274; cv=none; b=uVBfIp6NbbzMkJb/YeuLAaZ0UXflvbvAEn6ODKDWOYNQfn7i8yzAh1d2ky6CVV4BGxpYC9WAxdqxJPoJ/Y5n5be78GoS84zHafm0NYgrCsQnZ9q5QVFODfNWge8i2nOcbMPlx5+Iw5+5sTN6dLMceEP5VMBRMGP1owKCE/gsMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629274; c=relaxed/simple;
	bh=6hMZj58kanRfjfOsVxuQv1MQytywa3GW3FqrjMXlAho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEGVTNw0kUki/07DVS7l2+gL0qmaexE20cKWnbqgB3sKK1d6LkMYJztqgFXvpkMfARVfvSG+mr+qbN9sGE6pJMzSVgqwOHHiqusYRLLLGpzGY2v1dByaF5wfjAxYDwh2MVcbnYoEWbM1nEhvonZ02HdTB+l7bgoxnI1AGP1v8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IM5GlRGA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62026f59233so34852317b3.1
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629271; x=1716234071; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rctY62oYjWx5LL0x4h9ZxoVUJPCQwnanE8cB96y/dL8=;
        b=IM5GlRGAL+yHkt0jSdnrJxVnZRlZwqeHFmz8dlatmdUQ5WlMAmXNWx8B8V71ijquZP
         mnzzHGWCXLCgl66jlu72rwwZHPR4P/UiMSp86uQqjLz4dlnATkXW2DyrPJ7t3fucp+eB
         7IpOFV1bWso7wvHu28ac7PaTwZA527wgqUU3ujnKk6EDvntqKYDv5gu+C9VlqKIP9Gag
         NT/p46lr9LUdT+CFvbOjK3JQOMntNctQIust1xch0x2b5e5JJANK/CoCqENzBuIg5xGf
         YSPfcfUIk/eKa3Nv/+e6gWzDrCwKoc5gNlkYeXE5W/Cq+LulUyXER6FmB89s62DdrQgs
         edng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629271; x=1716234071;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rctY62oYjWx5LL0x4h9ZxoVUJPCQwnanE8cB96y/dL8=;
        b=dzqFmqPo8qMxrtJnjxLbuTzrlxqg2fGnfL+yAOTQCJub1BUhzRl+kbYhho59L/AKCQ
         Siw+NHUS0bABdiYFFMcO02W7cbMSzupD+hewvCnxeX0A17RJOdQAqal9wLnQzn0AXk8/
         qp2EMNoMnDTVRfryZAl8GDwjlFs0No6Q3ExfMbLgfpanKn3MD3FBk0zEpAkOGzjRqhX3
         z4OWvX93hGeVfHlEbHZ1WTr3riAh8cxi8cw+bqRU0lMLZ2IJ9UC7rUEFQige70yemkf2
         L+DOPRHdHQXAP8tC7/LU5gsF3VvXVQzpZjkCVz/DLGlvobmb0gIPLr7XLOsnQLATKGRC
         CinA==
X-Gm-Message-State: AOJu0YwyGBh+JprIjISH6sSeovkw9M/pCnO9xXBgkhqNfRpeQ4l7AiPO
	C2pPKuthPjwWNedF5lfk4HCPnnw0xChGtWsmouf7hmaDISItq/J06kEzAQ==
X-Google-Smtp-Source: AGHT+IEop9rTZ0aQxuK0rIFJnXevVzIDsLw4PWrdSf/I2psR1dytwibZu5abm8h+kKsLtzZpWhb94g==
X-Received: by 2002:a81:a0c9:0:b0:61b:1364:5904 with SMTP id 00721157ae682-62099335b45mr105368177b3.3.1715629271319;
        Mon, 13 May 2024 12:41:11 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:10 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 04/15] tools/power turbostat: Survive sparse die_id
Date: Mon, 13 May 2024 15:40:40 -0400
Message-Id: <c8b246ea2ea5771f2a0ca6f6a9a520406e6b6eb7.1715628187.git.len.brown@intel.com>
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

Turbostat assumed that every package had a die_id = 0.
When this assumption was violated, it exited
when looking for the package uncore frequency:

turbostat: /sys/.../intel_uncore_frequency/package_01_die_00/current_freq_khz: open failed: No such file or directory

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 45 +++++++++++++++++----------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e6d643a58cd8..4b95fd90e16c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2992,14 +2992,29 @@ int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
 	return 0;
 }
 
-unsigned long long get_uncore_mhz(int package, int die)
+unsigned long long get_legacy_uncore_mhz(int package)
 {
 	char path[128];
+	int die;
+	static int warn_once;
 
-	sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/current_freq_khz", package,
-		die);
+	/*
+	 * for this package, use the first die_id that exists
+	 */
+	for (die = 0; die <= topo.max_die_id; ++die) {
+
+		sprintf(path, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d/current_freq_khz",
+			package, die);
 
-	return (snapshot_sysfs_counter(path) / 1000);
+		if (access(path, R_OK) == 0)
+			return (snapshot_sysfs_counter(path) / 1000);
+	}
+	if (!warn_once) {
+		warnx("BUG: %s: No %s", __func__, path);
+		warn_once = 1;
+	}
+
+	return 0;
 }
 
 int get_epb(int cpu)
@@ -3631,9 +3646,8 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		p->pkg_temp_c = tj_max - ((msr >> 16) & 0x7F);
 	}
 
-	/* n.b. assume die0 uncore frequency applies to whole package */
 	if (DO_BIC(BIC_UNCORE_MHZ))
-		p->uncore_mhz = get_uncore_mhz(p->package_id, 0);
+		p->uncore_mhz = get_legacy_uncore_mhz(p->package_id);
 
 	if (DO_BIC(BIC_GFX_rc6))
 		p->gfx_rc6_ms = gfx_info[GFX_rc6].val_ull;
@@ -5300,22 +5314,22 @@ static void probe_intel_uncore_frequency_legacy(void)
 	int i, j;
 	char path[256];
 
-	if (access("/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00/current_freq_khz", R_OK))
-		return;
-
-	BIC_PRESENT(BIC_UNCORE_MHZ);
-
-	if (quiet)
-		return;
-
 	for (i = 0; i < topo.num_packages; ++i) {
-		for (j = 0; j < topo.num_die; ++j) {
+		for (j = 0; j <= topo.max_die_id; ++j) {
 			int k, l;
 			char path_base[128];
 
 			sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/package_%02d_die_%02d", i,
 				j);
 
+			if (access(path_base, R_OK))
+				continue;
+
+			BIC_PRESENT(BIC_UNCORE_MHZ);
+
+			if (quiet)
+				return;
+
 			sprintf(path, "%s/min_freq_khz", path_base);
 			k = read_sysfs_int(path);
 			sprintf(path, "%s/max_freq_khz", path_base);
@@ -5480,7 +5494,6 @@ static void probe_graphics(void)
 	else if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", R_OK))
 		gfx_info[GFX_MHz].path = "/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz";
 
-
 	if (!access("/sys/class/drm/card0/gt_act_freq_mhz", R_OK))
 		gfx_info[GFX_ACTMHz].path = "/sys/class/drm/card0/gt_act_freq_mhz";
 	else if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", R_OK))
-- 
2.40.1


