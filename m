Return-Path: <linux-pm+bounces-7774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B68C47B6
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A750285107
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8878C9A;
	Mon, 13 May 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTgLx/G9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4601E49F
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629275; cv=none; b=u7J39tRBbYhyKkWRiPALNo8nGqUBjLvYWpfxgsJoDD6TLKTqMxcv4M1TchlmBB6DvHIhXEgmrUuuddNJ6vv0RP6a7EoCp4g/fat5JkM3ki0BjuHTjeqiAuJogCH6N1cYLOzdBzZJz/cJ+GaIduOKdFTw+oLZIiTarfM9Rjo/ubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629275; c=relaxed/simple;
	bh=+OdgoNDdKMbWpvqHj0SCJxBvgOb0Yw9znjZlQMMThzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hF9JnmK6xLbz+FpReNFopxbbQ7xOlFZ/i/2yKbZgG3PCg/s5dYmHx96ro2CpwSHGEY8ruVrtoq+/iWFnltpxXneOTOiMv10+nckfixa7nxnDpF537PWmpk0sHz57cWx30puMogDaIr2DW/vtfSRZXCyzJ9aVX+YcRWTl+CEb9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTgLx/G9; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61e04fcf813so54180007b3.3
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629272; x=1716234072; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Oio2qRWpGeogQitr73NSx3qKsbFlWVqP0Io6HdqBM0=;
        b=OTgLx/G9qn4C/055HixpqNOF9akXDQGQgyfbJuH4yXINdhBcpMOEtyZwnHl1KG/ztz
         K8DhKLH2abK3FpZTwzOj59Frv2v1+YNE3glMt1Df7caYVzNd/wwffu1h8T2PlPHiy9R5
         iVgAydZndG/FVvMhaXfXTv6uCA/jOLvdhhg+ZaDooFfdGiZiVrQJcDM26CX5tx/s2VSG
         awNrr6/NpoSZVQeoGse/UC3Wlb0QOZ0t98DIHMilbDsSw+HzGX9o76DSyRnln/QD17Du
         YqXZt43oWjoF/69AT1M0Lcb3KmY5bha2cnBe8AQVeq6HM4AbAKFpJwG7BtKP6EwtIk/T
         2NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629272; x=1716234072;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Oio2qRWpGeogQitr73NSx3qKsbFlWVqP0Io6HdqBM0=;
        b=KBGs1ScO4ErgndzygWsCfZCF6ECKrY3MZ/1nojl0pl9GCXv3jeBrsqzqpslwoiSEzz
         WliBQ/BuxI5hxfSU2Ot1LvHo6+Ga4Nphp+LRcrLHjtqA6PiAydJYOW/WOsC0Lwzm4B9P
         661sBbC4SkihhwzTKuC1+p24pegb3RuKHzv/6bRLLu/mbunEw+cHwwbtUCAD49fqd2OW
         yxOiRFULqKeWN0tHbsuuoXxfLeDIrVTy5YfmMKWywdmrEmosaq48riLft6EHqATfMdwD
         qQ81F6UTVPRvDHgKrx8XAa/6tUwDPms7go9JoLJtSTIt7xDUpQa2Of1tqO97DoLxm8jI
         z5NA==
X-Gm-Message-State: AOJu0Yy0TtNQ3yf3Hjwve5VvsEzUb2nPrLX+xt/PlRim+7w3w2tOaLf1
	97t9N/L0UFB955iXICLEvssfeAciN5I8pCHl2uWdHV9H86DP0z5AyMZOXg==
X-Google-Smtp-Source: AGHT+IFn0KXonTiyL3v00eslfSNAWkawMjRYs8u6Vc4FsiHimmkJMmOV7dIgi00VxcHqTuXi75v+QA==
X-Received: by 2002:a0d:cc52:0:b0:61b:14a8:7944 with SMTP id 00721157ae682-622b0147b2cmr105822747b3.39.1715629272424;
        Mon, 13 May 2024 12:41:12 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:11 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 05/15] tools/power turbostat: Enhance ARL/LNL support
Date: Mon, 13 May 2024 15:40:41 -0400
Message-Id: <196eca020600470ca44da94c65607e7a98aa9d3c.1715628187.git.len.brown@intel.com>
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

From: Zhang Rui <rui.zhang@intel.com>

ARL/LNL don't have PC8, other than that, it behaves the same as CNL.
Copy cnl_features for ARL/LNL, except that PC8 support is removed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4b95fd90e16c..672936015b55 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -663,6 +663,23 @@ static const struct platform_features adl_features = {
 	.enable_tsc_tweak = 1,
 };
 
+static const struct platform_features arl_features = {
+	.has_msr_misc_feature_control = 1,
+	.has_msr_misc_pwr_mgmt = 1,
+	.has_nhm_msrs = 1,
+	.has_config_tdp = 1,
+	.bclk_freq = BCLK_100MHZ,
+	.supported_cstates = CC1 | CC6 | CC7 | PC2 | PC3 | PC6 | PC10,
+	.cst_limit = CST_LIMIT_HSW,
+	.has_irtl_msrs = 1,
+	.has_msr_core_c1_res = 1,
+	.has_ext_cst_msrs = 1,
+	.trl_msrs = TRL_BASE,
+	.tcc_offset_bits = 6,
+	.rapl_msrs = RAPL_PKG_ALL | RAPL_CORE_ALL | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_GFX,
+	.enable_tsc_tweak = 1,
+};
+
 static const struct platform_features skx_features = {
 	.has_msr_misc_feature_control = 1,
 	.has_msr_misc_pwr_mgmt = 1,
@@ -905,8 +922,8 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_FAM6_RAPTORLAKE_S, &adl_features },
 	{ INTEL_FAM6_METEORLAKE, &cnl_features },
 	{ INTEL_FAM6_METEORLAKE_L, &cnl_features },
-	{ INTEL_FAM6_ARROWLAKE, &cnl_features },
-	{ INTEL_FAM6_LUNARLAKE_M, &cnl_features },
+	{ INTEL_FAM6_ARROWLAKE, &arl_features },
+	{ INTEL_FAM6_LUNARLAKE_M, &arl_features },
 	{ INTEL_FAM6_ATOM_SILVERMONT, &slv_features },
 	{ INTEL_FAM6_ATOM_SILVERMONT_D, &slvd_features },
 	{ INTEL_FAM6_ATOM_AIRMONT, &amt_features },
-- 
2.40.1


