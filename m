Return-Path: <linux-pm+bounces-20278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEB1A0A564
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 19:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91A61886B59
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470C1B5823;
	Sat, 11 Jan 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFq2xh4N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1441B4237
	for <linux-pm@vger.kernel.org>; Sat, 11 Jan 2025 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736621643; cv=none; b=Kz3eF+axwjykId0QFCLhZSbINFDnfvOg1PX0jiX5zVRqel9I6gitbcHyTkfi+6tuBEUBhY5YoalCoWv0IGhQT1rsNjU6xVAD0ZT1Ojo/K0qLK9FsHxrHSOOaYX+TKvAmLih5CrYjgAbVSFqiindfHqJgeh3qHcPog00uEPENSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736621643; c=relaxed/simple;
	bh=VMkFXdlKupe/Vo0hC58uh8Q1V7VfPokQohZNH9TpUMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUz9Fu9U7zJ4DKV7pOGDThE+XsMzRF/y1wsHy6/BBgimfBgkqsQopezxEHdOEltOFKKZXlDVlQDIms17HdlMZcY8lcnVh6QN/qiyObPT5d5ncfLR6Jjcrk2L/w7m3drk7fRRtidfNsUdhZD50RGg/NSz1MDLyxGKI12cRNPGEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFq2xh4N; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436284cdbe0so4361205e9.3
        for <linux-pm@vger.kernel.org>; Sat, 11 Jan 2025 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736621640; x=1737226440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUbuynTw3nLmo+iUBj5GAwH3abxm4CzEksjMH3G3tPI=;
        b=sFq2xh4NfPBzySI6UmVvCT/N/FfNlP69CWqaUcRRIjGYq3BpMKL1DUNHk2rOmmbfVS
         iPqTbOQR32ltgCwXx6kW2yNtVCVw1Og0NXHGFF7lzd/N/7yYKx4yAfcikXD5F7dh62es
         LvJA3BIh8FHkpqvn0Eo7cyvsUD5UxpuKrbmo73HexGqjN7etJsuKWoU0v4IgeeFkQ0aG
         k5rNXfD0zCQABSXBqvqFlPErQkYj69LppN8c6YVXii0sH3CTtYb8lXlvplhls0xeq6Z2
         u3paQN3I/Jr5LlQfvprZv/bwVficRsSMIcIm5ku79c6vJ8H+cLLO3RzasmwNALRctYaw
         6E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736621640; x=1737226440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUbuynTw3nLmo+iUBj5GAwH3abxm4CzEksjMH3G3tPI=;
        b=AnRM6h63W1f2Uw2GzZPLQRjV1cUdQ2Gn59XXgvWwT/QmIJ4vxWaCh++Ih02ryc83XI
         +OmUo04mRD0tdI++2Y+M3h9pYS0BG5wcxjvem4vwYqz5A2g/rTWUCItaRvcT+Jdwl9Zl
         DC6k43taPlwjSMmJLsgWx8Qcyf1004m/JBDEQ9Ucv9XlUeeaIhrnBZotHqiavVrXzA3V
         xIcKZX4tmKqHj7ZL+qFnaz8YJqlOJrnw7kA9MGceA58zMxrQpNTMbP5abDdbbeVTwSTd
         5byBWSgII6DMaWtQcM+phJGV9pyrHaXaM497aqPExtukZZn//Q9JVh4LV/bTX19RHeut
         /J8A==
X-Forwarded-Encrypted: i=1; AJvYcCX87SC9+Ejk2iZEDDn+vj7isaWxDMmBh/gKy9pHXL/d1U9/0E/erBATmfZ2YQKKWf9ECrX5IefPyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRKwOJz0BLlFixluBunWUInnD4pBXW525xBgd6AEdoICCVQRt
	A5XxTMOdCKESj2Z/BqtCI3qMnSfB3UeojAgu2SkLK/GmJM7m293YHX1FTokQYoc0KLmkfhaib57
	X
X-Gm-Gg: ASbGncvqD1zzkEwA+ZLe1L26hEbhuSKFgOHYX/D1A1KyBHc4qNLV9J7kNYtnGOnn/IC
	dZjTHZFEL2p6X2AZjqw/YHE/1SPCLHaJVFHka5CB9tHNBsGvIF6BvoxXmUVEdGv9Epj4MWfiAh/
	8zvtkd3fHxjpLXJCiQF+UeaNuDnUXxUNmEVuRL4wEwCvQuFWY0/E33m4QA2p4O0t0rBOXXtGW9W
	B5lqUj3pZ5VfHx+a0Q4R5RXLp4GcFhlpV13uLhSInrnAWqByuz+qIQ/oGtuaTZbWGMAbas=
X-Google-Smtp-Source: AGHT+IGSOdbn08to4HCodxQ0MZs8k5PRpq0ooeuMQ+MMYxq7yNQNNfpQaPmt1mVKzJPEYYulnOOrnw==
X-Received: by 2002:a5d:64e9:0:b0:385:f79d:21a2 with SMTP id ffacd0b85a97d-38a87308a22mr5127018f8f.11.1736621640071;
        Sat, 11 Jan 2025 10:54:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b7f79sm7972351f8f.69.2025.01.11.10.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 10:53:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] reset: keystone: Use syscon_regmap_lookup_by_phandle_args
Date: Sat, 11 Jan 2025 19:53:58 +0100
Message-ID: <20250111185358.183725-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/reset/keystone-reset.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index cfaa54ced0d0..d9268d150e1f 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -87,26 +87,16 @@ static int rsctrl_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* get regmaps */
-	pllctrl_regs = syscon_regmap_lookup_by_phandle(np, "ti,syscon-pll");
+	pllctrl_regs = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-pll",
+							    1, &rspll_offset);
 	if (IS_ERR(pllctrl_regs))
 		return PTR_ERR(pllctrl_regs);
 
-	devctrl_regs = syscon_regmap_lookup_by_phandle(np, "ti,syscon-dev");
+	devctrl_regs = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-dev",
+							    1, &rsmux_offset);
 	if (IS_ERR(devctrl_regs))
 		return PTR_ERR(devctrl_regs);
 
-	ret = of_property_read_u32_index(np, "ti,syscon-pll", 1, &rspll_offset);
-	if (ret) {
-		dev_err(dev, "couldn't read the reset pll offset!\n");
-		return -EINVAL;
-	}
-
-	ret = of_property_read_u32_index(np, "ti,syscon-dev", 1, &rsmux_offset);
-	if (ret) {
-		dev_err(dev, "couldn't read the rsmux offset!\n");
-		return -EINVAL;
-	}
-
 	/* set soft/hard reset */
 	val = of_property_read_bool(np, "ti,soft-reset");
 	val = val ? RSCFG_RSTYPE_SOFT : RSCFG_RSTYPE_HARD;
-- 
2.43.0


