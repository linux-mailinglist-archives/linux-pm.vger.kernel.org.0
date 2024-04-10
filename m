Return-Path: <linux-pm+bounces-6173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCDF89EF7D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 12:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C5B203AE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8F156C77;
	Wed, 10 Apr 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G03OLYCa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00350156861
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743572; cv=none; b=CIaUlP33I/t1J8e0yv1AJY0VPGRInPMW4zGS7kjfUUtJ14HT+WjFEGsjoNZ6pGVa8idbVLQkOHKuZbu+WQfQtKLD2jsvKmFEnYGoKq0PbQbGKb2NGGYMmww41p7C6GbtMISWx+RCy5RnXgJlTzdAPcu+J3J145bwrjejqwRxBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743572; c=relaxed/simple;
	bh=j7jhjPXzHWwRadactMkVoJM5y4LJns+b5jjXbm6w+Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BfQjLQr5S5FJ/jLrWSuVIkvKib/2yP0nTtx91u8EkGOwyIdlCiYQ8pG9TPulyvBq1+NLj2Zrw2rl2Vnwiatfbcx47YAZq1PGCt4EyYBeX/P9id0QQUlHnAzoayD2exOyUl71yOuj7lmoNf8sKu71Wzedj235rx32GXUGs+Ys7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G03OLYCa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a28b11db68so4146255a91.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712743569; x=1713348369; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T1LpKFL+yI+IpX+c47vgJ/x998fTDNJ7BUtB4SB1yXE=;
        b=G03OLYCabSasZG4X0lQPnSwxyswsZ5dXyZ1vMfV2pfL64kL2NSTIHSIcBW3nEXK69W
         edCg2jhxwSwDUYpmW03kpPh6lUkH+mlBYTVi4BnAcOoSXJgTR/9sIeIG2EOybpFvXapM
         UkTE+DUXtWQAE14Ov4oKzLmhn1NbM58cRqn8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712743569; x=1713348369;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1LpKFL+yI+IpX+c47vgJ/x998fTDNJ7BUtB4SB1yXE=;
        b=VkLjIbJokci3wRFLWwNLew9Nwn7DuATvEZuFGoSMk0FahD6ruhtDgdIesORZ8i0Jhx
         2/+6oeQPyuTSxvd/+Z2i+o04Sdw3hvyEibO7uD4ziOwPt57zq2VFwVoRNYc81vR/SMXr
         +CPwWi5M1ELfnNqE2CJ5Pu/26U2/PI/alKc6x8xivI2yJXjAqwD5x6G+ZGoygAHhyA4f
         LH9TLd57jhfvv9Z5oEqeA6OfJBJOvpAuBtIyMbxtXlOkP1USyKhU8hXHDXX8oOl8NZ7V
         piCdyia/tl7Y61eaB2AyJVTEBXpIuh29bNHzIS6KT1v1XXFIuG9s70rMsMo0fJbnrXko
         wcRg==
X-Forwarded-Encrypted: i=1; AJvYcCVhvQFFnqSWxvfN77R/Pdg5vKhEVxmahdDdKrn0yjj5SIQcDBY9sDGXz+rJ3OOKjiEJniksugvAg8sOs0H2+42KXwj/1yiPPsw=
X-Gm-Message-State: AOJu0Yz+xTj0C+5WVUtOwfyuO1wCexz/ZQPVOFaqSZ+XcLQJFi7r4vlT
	nP8qttC1aq5RlycQ7IpRZhevQ6VhX9NvRDgQg5/WQNo+rFj/MNNPufynXIQH2A==
X-Google-Smtp-Source: AGHT+IEgWW/yvuflbCPPd3wcdtqJfAQHQgU5ksKHqoN0JvvBwSkc10gWcYuN/ly4S2nYghQ9sKh4yg==
X-Received: by 2002:a17:90a:e514:b0:2a2:672f:ef66 with SMTP id t20-20020a17090ae51400b002a2672fef66mr1861559pjy.7.1712743569253;
        Wed, 10 Apr 2024 03:06:09 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (88.216.124.34.bc.googleusercontent.com. [34.124.216.88])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090a740b00b002a4ce78e3e8sm1014434pjg.35.2024.04.10.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 03:06:08 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 10 Apr 2024 10:06:04 +0000
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Add coeff for
 mt8192
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-lvts_thermal-v1-1-ee50b29c1756@chromium.org>
X-B4-Tracking: v=1; b=H4sIAItkFmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0MD3ZyykuL4kozUotzEHF3jFGMzUwsT88TktDQloJaCotS0zAqwcdG
 xtbUAtac9M14AAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
 Balsam CHIHI <bchihi@baylibre.com>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

In order for lvts_raw_to_temp to function properly on mt8192,
temperature coefficients for mt8192 need to be added.

Fixes: 288732242db4 ("thermal/drivers/mediatek/lvts_thermal: Add mt8192 support")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd650c77a6..6d226c3e135ca 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -80,6 +80,8 @@
 #define LVTS_SENSOR_MAX				4
 #define LVTS_GOLDEN_TEMP_MAX		62
 #define LVTS_GOLDEN_TEMP_DEFAULT	50
+#define LVTS_COEFF_A_MT8192			-250460
+#define LVTS_COEFF_B_MT8192			250460
 #define LVTS_COEFF_A_MT8195			-250460
 #define LVTS_COEFF_B_MT8195			250460
 #define LVTS_COEFF_A_MT7988			-204650
@@ -1530,11 +1532,15 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8192,
+	.temp_offset	= LVTS_COEFF_B_MT8192,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
 	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8192,
+	.temp_offset	= LVTS_COEFF_B_MT8192,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {

---
base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
change-id: 20240410-lvts_thermal-3d365847acff

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


