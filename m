Return-Path: <linux-pm+bounces-10869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA06892BA4A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B29287E81
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7202916A921;
	Tue,  9 Jul 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/9dXpZv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BC166301
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530008; cv=none; b=fcdRwpUrvYuKj4k4QzgzfROCNtP9akd9WmtTNRLB0/PiQnB7IwnEh+PWIKhaR19tf7hoYOLETBbi6t/D+sm3JkLNkTZ4Mh3gsf7Fn2+EIeLNB26/iB85r/r/Qzqkd71gnZOJM1yRKWRukBQGu1s4PtVQbi/WE/J5trkoEqXe0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530008; c=relaxed/simple;
	bh=Q6+hCxLVHj6awAkKLZL/lFMRRO+jJnpOsXWYwuQTpws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEKrmIBG8NMPKaXPfdQPOF5VPSxOpdozJ+thJrtSlUD3sRsXU36ROAoJT5Cwro8KRBGV0TlIF1dSxOY10qfpIyZlrExl8V03zyZF/9GWwgPZ/FS+p0U02BjXP6eoP1mi95/lQcjrRdK1uUG1T2FXM79Bx5XKZTRIE7UIXemEXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/9dXpZv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77cb7c106dso494781766b.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720530005; x=1721134805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpaXR5hesM6QQA2KpWYBxtlXYQSJSMhrc0LMERSNaQc=;
        b=a/9dXpZvNxJWD8QTEP1zIXzfzwag6hxxlNUDIHiFVChFQ9H8qg2U5f798WQYH/OeP8
         PKkDz3OTXbfD7uYawNToWSOLDR01wrf6hL1QNaHnkNzvOtSJRwv1sKx6w0rtmBEJ/qVt
         M7U5jddPmChESNn7877xh2YGwaCELcNSlOXbzXxa1xVvyKINHkPoDwMEpYvqHqhoYjul
         LxDeG9SK6C3jECR2TtsJTyI8POVY+Z+7VwZXiGl9eDvbKi7t8SJV8x8c1sJV8jYk6nGw
         WGStIUElfVIyQPVwCixYRnIYElzUwatVh4FgXv5/GfaHc4sJ2JHjIsP6qCwsAVo31Rps
         OIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530005; x=1721134805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpaXR5hesM6QQA2KpWYBxtlXYQSJSMhrc0LMERSNaQc=;
        b=SLk/miGW/9ePpVpxF0YMfmt/ww8wkyub2K1OCWPqct7xYR7bfTO0tw1Hiigzk0aKH8
         YhVHf6aaq9wq4Xsy9CgEf09fYSoNtI654Iqloa1wcj1n2uIEX5sqX3QoPzPmFNf6wVCV
         FeHiuAADj80RL0UuTQu95WvVMmZGyiFJ7KaBxDkixYV1YkPjs2pW41YDNqXxVZe67Wrd
         dSDkQivRSmEXHbOAUwhSKVjFQWd09EwVvnXITqiMP7Jeghe1juyIQH+yI9E/gSSuC9OV
         VaZq9GlSOU4K/fkhzePJrkdSSSoncjVRY36aswfGjF3wr2shasNHEpb6kpTrJKCV+zxq
         arFw==
X-Gm-Message-State: AOJu0YzqNd/hHV3GkBk+IBGNOplW1bKnYJzXMrN2jAb3g8aHhM4uq93T
	aquTlXYEIL/81XmK0zaMAn7ay1k6zoC/OI2g9Rxg/PBhm51GNROk205B/hqL4lI=
X-Google-Smtp-Source: AGHT+IFpuXSVDfR9zcYD6UEE6dUM0zQ38CBB1md2Ad0sjVV+v+MC1CRRqx3iEirLTHQ2eq8mi1TqYA==
X-Received: by 2002:a17:906:fb96:b0:a77:c26c:a56e with SMTP id a640c23a62f3a-a780b7053cfmr141321866b.45.1720530005087;
        Tue, 09 Jul 2024 06:00:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76643166b.80.2024.07.09.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:00:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Jul 2024 14:59:36 +0200
Subject: [PATCH 06/12] thermal/drivers/hisi: simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-thermal-probe-v1-6-241644e2b6e0@linaro.org>
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
In-Reply-To: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Q6+hCxLVHj6awAkKLZL/lFMRRO+jJnpOsXWYwuQTpws=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjTRBwaAjkvl6lx45yY9/ImDeEubME5uwgWFGE
 i+bNA0kPUGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo00QQAKCRDBN2bmhouD
 11BuD/4vPwK3V9A2LjND5Im9CSALekgwK8+81reARKO6RvGE9eBpawhpL5BznjBw1QsJ6n5wEDW
 u4HfkL6X73SnVpVPx3wBkV55taP5y2WeYsDyuiSHFVYjPy+iGBCstOTmi+I2w9ep99Qoi+C4f0S
 saeTt6RowTWLn+n8PNcDYWh0bl6kkVTt25vdxaIEkifGnPnDCOUPrcA9eG0BzgEk4B1pXdyxQun
 xnzdYByJAnsbHiozgVSObIsmTDQfpk5guaL10G+OlcAWbN8L1i1pAukfDqQvcgRJGuAKviAWrkg
 EX+bMPSx0PZi2MtGkX53wq5+BHeGXMTuLFGuYXqXKE3i2FhBwAjY5wJp8+ay7pr3PVITVz4/5pD
 7bf+V8ig7bAjt2E7vXkYTf79XHF+bZZnmyyyOZfANe/PGCcn7TAS+WTz9KBuN2zDgnYHcpcnIZG
 il2JHZSSkpyLmdulaW1Zw9To9yd7c6+A3okG8069epEysKAZ90Jy+Vg7xOjiLCe0q5/n27wcgFv
 oh6z4UgCqokMVSzGM/BdzM5D1DhOqbjQ99uxdOBtm7s3jSZHxnXnl/4v2XW0SNCdrgze9x9ttdu
 /+Kw/YJn0iYsTK/MqqjfXF/gOCBGincfblbkRGlpqnqB25c0g8opnegbeXBSaEu0tf3nGxYLLZN
 Hj6BN/VzrNndFyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Error handling in probe() can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index dd751ae63608..0eb657db62e4 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -388,15 +388,10 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 {
 	struct platform_device *pdev = data->pdev;
 	struct device *dev = &pdev->dev;
-	int ret;
 
 	data->clk = devm_clk_get(dev, "thermal_clk");
-	if (IS_ERR(data->clk)) {
-		ret = PTR_ERR(data->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get thermal clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(data->clk))
+		return dev_err_probe(dev, PTR_ERR(data->clk), "failed to get thermal clk\n");
 
 	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor), GFP_KERNEL);
 	if (!data->sensor)

-- 
2.43.0


