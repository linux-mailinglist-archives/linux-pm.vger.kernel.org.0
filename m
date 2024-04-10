Return-Path: <linux-pm+bounces-6204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF489F411
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 15:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5C71F2CC0B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13B161909;
	Wed, 10 Apr 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2Dmmmyp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBF160860
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755212; cv=none; b=acoBh2cEFGMq6undEcexeEklokdWpfOj2GiKLIo5T9l31MGl4+EsLl0NzNapidtUvrIoMCTUozuC88QRQLxPPkdW7iAD3FaKU/Ab5pkysAsVetmSoB1O8WFEBypsR8TvKlp4s5zGV05qJJvEzbdHMPMs7avLcKslJzTBbKK49Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755212; c=relaxed/simple;
	bh=5eAZYWV3YY/RDgHaLdfLx0BLlBA3RW4LEvbKMLVXbSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aT64nM138COUC82bDCf4ZYI2bCN87eolZix1YdGbGh/vQvD5aRKAL7hpj/QmfUhO9hz2oYXlTWOuvAhgHDUOeXmOyKrqhpdh+JbNnHRh3saLdsRK7W03uo+vosHgCnWniWET5sK/otQ7WQuKqxa1imug+dSc4o00m9MPsr1j1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2Dmmmyp; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6153d85053aso58497407b3.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712755209; x=1713360009; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7FWGyE6sU+FTNUj5d+DsS4piS48Tua6JF6v1iBb6fU=;
        b=R2DmmmypNMkQGEB/301q17+V2TBI5+NDQms+LY64gr8F9gBdgELOW8FEV5+3r/dvME
         UEauGi9M6K0sg46rZvznwOVkAl15jbHteyb39R7e/WeQloUFEsgLqIxIF+k2aG7SnS1r
         SKUKZnpDmN1bBWjhPkrK43eo3VT0yGgFq2/Xi+QdpEUb7xv2yJKOGiDKuLy9NGSq/v0s
         dBwMw29NWcp6qqlKoLl8e0e6NNHmyuEV3dL1NxslvY507+nz6apLJgCP3kje/6N9tBwV
         CS7yxWqwVvuwWrw5FfA+2bIaOVlxhPn4FB2JHlSneLsXlD01LOQ6dobMRfOi+O/MyDT7
         lZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755209; x=1713360009;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7FWGyE6sU+FTNUj5d+DsS4piS48Tua6JF6v1iBb6fU=;
        b=iRQ80JpvyhiugGti8Y5tCAT/x3j580O8i/UNOXl7O48199bKVQynDHAHLe93EURpdY
         Vt9vYvH9weM9JcgqiSHUW3q3M17TZS7Qb43xb3IQrv7+8b2EaDyATAst1wN2Y14jPzLX
         N2MykiNAFxgt6DvFfbdpwKabj4rXleyRHhVL138xb/acdkao6mUE8Mz94gr9uDpodOoh
         JnqStgDcYg+kP0rajKPoL/w/TqYYdmz1fTGW+4pC3KujKWonD8+R1v0PNwlT2v3jJ9T8
         hIK4U9+lDOJJObFciiIK5lSMAroC/vi76Wd1X0u60bAM5T0kiMf6LZO92ENtSGuHLhgi
         rZJw==
X-Gm-Message-State: AOJu0YyWZZws0+8AMj+K6pQ6SzHwrlyLvrWL0hsipdRj5H/0ggS3C17c
	9ePRZjys5fhf2mvXKoL3n3D23MhjMWNlbZGtZQWq74WCU16OpuEkd4iOdCo/
X-Google-Smtp-Source: AGHT+IH4qr1OmdambhNilR3k6DAaLSMb/tKwHBVGkd8otXl0oHVJfytdpDa17f+YIVYVN8i0ojgTMw==
X-Received: by 2002:a0d:cb15:0:b0:615:3b4a:5c9b with SMTP id n21-20020a0dcb15000000b006153b4a5c9bmr2722709ywd.31.1712755209637;
        Wed, 10 Apr 2024 06:20:09 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-b580-a474-89e0-3bb1.inf6.spectrum.com. [2603:9000:9f01:67cf:b580:a474:89e0:3bb1])
        by smtp.gmail.com with ESMTPSA id x66-20020a0dd545000000b006143d243915sm2700864ywd.10.2024.04.10.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:20:09 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 24/26] tools/power/turbostat: Add support for new i915 sysfs knobs
Date: Wed, 10 Apr 2024 09:19:47 -0400
Message-Id: <dc02dc937a3ef819c5da10e97084af6977be26bf.1712754901.git.len.brown@intel.com>
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

On Meteorlake platform, i915 driver supports the traditional graphics
sysfs knobs including
   /sys/class/drm/card0/power/rc6_residency_ms
   /sys/class/drm/card0/gt_cur_freq_mhz
   /sys/class/drm/card0/gt_act_freq_mhz

At the same time, it also supports
   /sys/class/drm/card0/gt/gt0/rc6_residency_ms
   /sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz
   /sys/class/drm/card0/gt/gt0/rps_act_freq_mhz
   /sys/class/drm/card0/gt/gt1/rc6_residency_ms
   /sys/class/drm/card0/gt/gt1/rps_cur_freq_mhz
   /sys/class/drm/card0/gt/gt1/rps_act_freq_mhz
gt0 is for GFX and gt1 is for SA Media.

Enhance turbostat to prefer the i915 new sysfs knobs.
Export gt0 via BIC_GFX_rc6/BIC_GFXMHz/BIC_GFXACTMHz.
Export gt1 via BIC_SMA_mc6/BIC_SMAMHz/BIC_SMAACTMHz.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4fa2810da1a3..feca7f4cb5cd 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5380,6 +5380,29 @@ static void probe_intel_uncore_frequency(void)
 
 static void probe_graphics(void)
 {
+	/* New i915 graphics sysfs knobs */
+	if (!access("/sys/class/drm/card0/gt/gt0/rc6_residency_ms", R_OK)) {
+		gfx_info[GFX_rc6].path = "/sys/class/drm/card0/gt/gt0/rc6_residency_ms";
+
+		if (!access("/sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz", R_OK))
+			gfx_info[GFX_MHz].path = "/sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz";
+
+		if (!access("/sys/class/drm/card0/gt/gt0/rps_act_freq_mhz", R_OK))
+			gfx_info[GFX_ACTMHz].path = "/sys/class/drm/card0/gt/gt0/rps_act_freq_mhz";
+
+		if (!access("/sys/class/drm/card0/gt/gt1/rc6_residency_ms", R_OK))
+			gfx_info[SAM_mc6].path = "/sys/class/drm/card0/gt/gt1/rc6_residency_ms";
+
+		if (!access("/sys/class/drm/card0/gt/gt1/rps_cur_freq_mhz", R_OK))
+			gfx_info[SAM_MHz].path = "/sys/class/drm/card0/gt/gt1/rps_cur_freq_mhz";
+
+		if (!access("/sys/class/drm/card0/gt/gt1/rps_act_freq_mhz", R_OK))
+			gfx_info[SAM_ACTMHz].path = "/sys/class/drm/card0/gt/gt1/rps_act_freq_mhz";
+
+		goto end;
+	}
+
+	/* Fall back to traditional i915 graphics sysfs knobs */
 	if (!access("/sys/class/drm/card0/power/rc6_residency_ms", R_OK))
 		gfx_info[GFX_rc6].path = "/sys/class/drm/card0/power/rc6_residency_ms";
 
@@ -5394,6 +5417,7 @@ static void probe_graphics(void)
 	else if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", R_OK))
 		gfx_info[GFX_ACTMHz].path = "/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz";
 
+end:
 	if (gfx_info[GFX_rc6].path)
 		BIC_PRESENT(BIC_GFX_rc6);
 	if (gfx_info[GFX_MHz].path)
-- 
2.40.1


