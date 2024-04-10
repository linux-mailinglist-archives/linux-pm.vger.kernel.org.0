Return-Path: <linux-pm+bounces-6205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A118D89F412
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 15:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5088528213B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BCF1649D3;
	Wed, 10 Apr 2024 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiizXirk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71402161319
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755213; cv=none; b=Qyj1p6zlLCK5YBg5peK+H1D3KFoOXcaVJwvxD1hGc6z3DmQu1mzSjJLsl6gR2q8rC3/vwfL+6W1FiH5cHi8RaSZKRMpQKrBfMnKIGrlLwPsQyPAfHYMjR+9l6naVhFlE2/8CmTv3qMfq3l9hAG5AOk4OL0PlvbSb3gTQskLeX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755213; c=relaxed/simple;
	bh=jqdwA3kLWi8Ypqo/ij1AV2g4ZKTIbnrzMTECO3pkf7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T93rL4R1ADY2I/v3tvAYdEVizqMhKAOWNJRdm0GhmHe0Xx7sxP3VT03gTbEw3/0xVz7b+PY4EebX1QIC6td8SOenYEyUaIhYcLwNsGP9DP/+Y5BaWFchVYJw0hS/nsbJ5+4Gyx2KWkFTvodHj162K1BXfsgccyfDMbMGIRXDooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiizXirk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-618509f818eso3438847b3.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755210; x=1713360010; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55XV768O8agZx3h/NgCQ+TWIkd/irmITVY/GIifvzdo=;
        b=hiizXirkYhFE/V80RvjlzhiNPNat1e76/H/KyM8ZokLrW4sRWjTpGGW7Wh9JHqGoef
         Hz6wmYCaNiztGeBz+Iocq6/5PgYW0mA4SCMyJKXSNUG2JKkQ2Sq/IYr3XENUEd8phPzj
         mRtjwdvJsjjI+XVDahLw8a2F9S4jMa6SVGhUa2JzSPtXPewr3wmXut9gLgOMx1bH+Iwo
         G17724XuBWcW7hj81trpm0kUmrVTmOgexPGFQoceEy/EKgcbs1wjx69uxTGri4y94ZC9
         d9Y7hWl8xXGwzsoYBEstcpciVZHNTqSxIu5BU81ZyMGONSxFgxDBAN1X3Q2AH4GpKsLj
         qIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755210; x=1713360010;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55XV768O8agZx3h/NgCQ+TWIkd/irmITVY/GIifvzdo=;
        b=Vk8Fu838HymBHIuGPIcbcqRG1J62SRXgTCKKIIyImRlKYvkksATQvchoXnXvyFprTi
         jUmfznlSzeQDbMPI5hsD+1BGcU8+5GhG2j9sBdVwyY8jy/jud+poqP5ayjOGWBSiDCmE
         ypVBTPS7sU4gOkStBXsryoDbYFueXbFM33EI3cmaGzcwpML3I2sRbeDI3V62pqPbETab
         BSX4wKJTuNj7cUBTd4V7Ju3E+O/HoNm/gb4+UDULNI9TCdaXtuz1kjuqBAjgtbsqz7sn
         flBfy4j+S5i5xcXV2tXXC2U3bg98PlGfEJP6Gk7Io16OQkM9Ek7Us94L0rWfBKM6U99+
         pKxw==
X-Gm-Message-State: AOJu0YxOMQpaWuQjfuh8TTR15Df9pOlXC/OZq5OCk5abi6MmObo9SD4f
	tbAVVe22cmN/WVGXQCaq1UvPO/HMa+hGU6k5O1u2QMqoQ6AYlPl2nLCkG2yH
X-Google-Smtp-Source: AGHT+IF0eZtlFBPl8oGMrT2WcOQbDSaVcVjrM6Z2uoPoWs9vWJE3E/rm7m4Zmuo6oTZvcpo/f5KeyQ==
X-Received: by 2002:a0d:d609:0:b0:614:5d7a:fc55 with SMTP id y9-20020a0dd609000000b006145d7afc55mr3542254ywd.23.1712755210266;
        Wed, 10 Apr 2024 06:20:10 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-b580-a474-89e0-3bb1.inf6.spectrum.com. [2603:9000:9f01:67cf:b580:a474:89e0:3bb1])
        by smtp.gmail.com with ESMTPSA id x66-20020a0dd545000000b006143d243915sm2700864ywd.10.2024.04.10.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:20:09 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 25/26] tools/power/turbostat: Add support for Xe sysfs knobs
Date: Wed, 10 Apr 2024 09:19:48 -0400
Message-Id: <91a91d389543a86963beec148d98d37875154bd4.1712754901.git.len.brown@intel.com>
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

Xe graphics driver uses different graphics sysfs knobs including
   /sys/class/drm/card0/device/tile0/gt0/gtidle/idle_residency_ms
   /sys/class/drm/card0/device/tile0/gt0/freq0/cur_freq
   /sys/class/drm/card0/device/tile0/gt0/freq0/act_freq
   /sys/class/drm/card0/device/tile0/gt1/gtidle/idle_residency_ms
   /sys/class/drm/card0/device/tile0/gt1/freq0/cur_freq
   /sys/class/drm/card0/device/tile0/gt1/freq0/act_freq

Plus that,
   /sys/class/drm/card0/device/tile0/gt<n>/gtidle/name
returns either gt<n>-rc or gt<n>-mc. rc is for GFX and mc is SA Media.

Enhance turbostat to prefer the Xe sysfs knobs when they are available.
Export gt<n>-rc via BIC_GFX_rc6/BIC_GFXMHz/BIC_GFXACTMHz.
Export gt<n>-mc via BIC_SMA_mc6/BIC_SMAMHz/BIC_SMAACTMHz.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index feca7f4cb5cd..bc103851df70 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5380,6 +5380,57 @@ static void probe_intel_uncore_frequency(void)
 
 static void probe_graphics(void)
 {
+	/* Xe graphics sysfs knobs */
+	if (!access("/sys/class/drm/card0/device/tile0/gt0/gtidle/idle_residency_ms", R_OK)) {
+		FILE *fp;
+		char buf[8];
+		bool gt0_is_gt;
+		int idx;
+
+		fp = fopen("/sys/class/drm/card0/device/tile0/gt0/gtidle/name", "r");
+		if (!fp)
+			goto next;
+
+		if (!fread(buf, sizeof(char), 7, fp)) {
+			fclose(fp);
+			goto next;
+		}
+		fclose(fp);
+
+		if (!strncmp(buf, "gt0-rc", strlen("gt0-rc")))
+			gt0_is_gt = true;
+		else if (!strncmp(buf, "gt0-mc", strlen("gt0-mc")))
+			gt0_is_gt = false;
+		else
+			goto next;
+
+		idx = gt0_is_gt ? GFX_rc6 : SAM_mc6;
+		gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt0/gtidle/idle_residency_ms";
+
+		idx = gt0_is_gt ? GFX_MHz : SAM_MHz;
+		if (!access("/sys/class/drm/card0/device/tile0/gt0/freq0/cur_freq", R_OK))
+			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt0/freq0/cur_freq";
+
+		idx = gt0_is_gt ? GFX_ACTMHz : SAM_ACTMHz;
+		if (!access("/sys/class/drm/card0/device/tile0/gt0/freq0/act_freq", R_OK))
+			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt0/freq0/act_freq";
+
+		idx = gt0_is_gt ? SAM_mc6 : GFX_rc6;
+		if (!access("/sys/class/drm/card0/device/tile0/gt1/gtidle/idle_residency_ms", R_OK))
+			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt1/gtidle/idle_residency_ms";
+
+		idx = gt0_is_gt ? SAM_MHz : GFX_MHz;
+		if (!access("/sys/class/drm/card0/device/tile0/gt1/freq0/cur_freq", R_OK))
+			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt1/freq0/cur_freq";
+
+		idx = gt0_is_gt ? SAM_ACTMHz : GFX_ACTMHz;
+		if (!access("/sys/class/drm/card0/device/tile0/gt1/freq0/act_freq", R_OK))
+			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt1/freq0/act_freq";
+
+		goto end;
+	}
+
+next:
 	/* New i915 graphics sysfs knobs */
 	if (!access("/sys/class/drm/card0/gt/gt0/rc6_residency_ms", R_OK)) {
 		gfx_info[GFX_rc6].path = "/sys/class/drm/card0/gt/gt0/rc6_residency_ms";
-- 
2.40.1


