Return-Path: <linux-pm+bounces-6459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0888A6535
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 09:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958DA1F217ED
	for <lists+linux-pm@lfdr.de>; Tue, 16 Apr 2024 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1AD78C8E;
	Tue, 16 Apr 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m8YNJqle"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3916EB76
	for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252954; cv=none; b=rkgk4xTcuPneOyrakQUdkQ/zuUJbTqmFPxlHcTRlIyLPRCji/89OPc6PSmcBbajSZYBxPriXtOJF1Vy7CnV/xqsNR9s1+eKWSanMUfhmnTOuSODgE5y9dRfSq72Xng++suMhibE0GGTJ0/wd08BWfIPAqjj9d03n6ADCVv+evyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252954; c=relaxed/simple;
	bh=Mzy1RLChKpTXckeRfOn3L90L6pWcJRlTrF3gU8yBosw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d0pBYnBNGAA8cp/e6HsdupvSdDBtAN1Ze/5qLtqozWyKbytMaJsnvekX91I0Drs1Tbw7nfpFTYEsMkY+r4wptzkgfULtiryQXOTv/2hhYcFUKaJrn2Uk2w14ZO+zUc51SHFVVlPKxGxLUkjcQF4LiVqOGTZ8hUD3iNOIX3Bm8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m8YNJqle; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a7d6bc81c6so2993379eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2024 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713252952; x=1713857752; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Y56dDS984KsDzs2nzTKgy6adBy9joM/agCd66RARo=;
        b=m8YNJqleWJawjxqYMgdPyDvNSAxyEGyQieFXU+xYCur64y6QjTg9nl5J5nCO8pv7st
         CFrRu/S01DkAF+yulHAH61ryd6s4oIKjJU6hhY5EOJkBcSCA8os57qi3MGvpsFAqGOxJ
         QJKJ+vTRnSQ19nyRbyxZTmi+LuT/HXVFHJ9HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252952; x=1713857752;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3Y56dDS984KsDzs2nzTKgy6adBy9joM/agCd66RARo=;
        b=eYi2ZdKVfmBt3zIfNHslP5v1GeRK6Ni59A2n7w+cPb31WltJnw4mpOIXa6OeqOSpq9
         yL3JaGuHpccSINfy+iNFeZMM4GcLIz8YO61CPkbv7MILJ6/lw2ov+L4zIu9NdyUOu2kR
         DfqySsNK/KFbUHtPb78W/kLQD+ZwKg3baONFxCoyE0qk1u1lqJxd1gURvSzxKjhf+P8e
         pVoDWZ+9/+V/rcf9iQQ8tt56dI/eLF+7wsPmnADv6LYT2v/TqYCo3HJtse8uQF0cgKEv
         Epd0+IzPPi83NhPNobHLrEdMfgwJ6kFejpWzGDwPn2wR0vL38XL4kAQmCw2qDCouFG0x
         eG1w==
X-Forwarded-Encrypted: i=1; AJvYcCWd/FjQVZ0dpCruRPXPFGoMVIv/CEFSeb62N9XqbDVar/PrVzZ1c5NOEGOm45uIWcL1FSpQS+CD1kxdzAQ1Hf7+hEiy1B+gDm0=
X-Gm-Message-State: AOJu0YxsMu9v7PeYGlDDXPbhTtak4P73PsqhmYgnm2r+8P/gcOK44Nt1
	ReXtQmmq53e502KrdxXt0K0fkHsZo2TnDyPRJul9a8/jNts0/gi0wHoA282jZg==
X-Google-Smtp-Source: AGHT+IHNjgaqMYg1Csze8sajKRyaaqmq9zLpH84gQd3fhwrzyArn1i3A0GueOZmBPZ6aUxRl85D33Q==
X-Received: by 2002:a05:6870:568c:b0:232:fba4:4594 with SMTP id p12-20020a056870568c00b00232fba44594mr15920699oao.49.1713252952526;
        Tue, 16 Apr 2024 00:35:52 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (88.216.124.34.bc.googleusercontent.com. [34.124.216.88])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b006ea9108ec12sm8307092pff.115.2024.04.16.00.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:35:52 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 16 Apr 2024 07:35:47 +0000
Subject: [PATCH RESEND v2] thermal/drivers/mediatek/lvts_thermal: Add coeff
 for mt8192
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-lvts_thermal-v2-1-f8a36882cc53@chromium.org>
X-B4-Tracking: v=1; b=H4sIAFIqHmYC/32NPQ/CIBRF/4phFgOvH6iTg10ddDTGUPpaSNpio
 BJN0/8uYTTG8d6bc+5MPDqDnuxXM3EYjDd2jAHWK6K0HDukpomZAIOc5ZzRPkz+Pml0g+xp1mR
 lsc2FVG1LIvJw2JpX0l3JubpUpyO5xV4bP1n3Ti+Bp/W3MHDKKWLBatgpLoryoLSzg3kOG+u65
 Arwj4fIl8BVLRQTMoMvflmWDyKXp07zAAAA
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
Changes in v2:
- Reusing mt8195 coeff instead of creating duplicate definitions
- Link to v1: https://lore.kernel.org/r/20240410-lvts_thermal-v1-1-ee50b29c1756@chromium.org
---
 drivers/thermal/mediatek/lvts_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd650c77a6..4e5c213a89225 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1530,11 +1530,15 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
 	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {

---
base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
change-id: 20240410-lvts_thermal-3d365847acff

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


