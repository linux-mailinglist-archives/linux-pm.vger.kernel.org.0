Return-Path: <linux-pm+bounces-7908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C68C74CE
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 12:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7DC1C23ED2
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 10:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB7B145348;
	Thu, 16 May 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GS1T+skl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838FB1459E3
	for <linux-pm@vger.kernel.org>; Thu, 16 May 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856285; cv=none; b=P84KwSV9jVZcf7RK7YIrPBz53F0dQSQuSHKwispe7WchnJwJWEYqSbAoJ+K3jANlhWoWMDMRvhty0KoZ62zoj4lFPRk2qgPEhjCiXbhCXGGRAJwOU1Hz1HpMvW8hB8iO7kSlCTPNbERh8yohzZQHeQjpZyE9gO4s6vF6D/pe1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856285; c=relaxed/simple;
	bh=0Idu940agGS+y36TO2/QtyC3yMbEY7iqlAyR1r26iUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HmQDLSrYZza2bI8H1g49AMkxtmGdfGEjV8WUvXSxmm08LvOmPEKSbLv7mifgLE9HCu6gvK0bOaJv4mHuCn0QWGaUXTXsO/1agZLVWREq5rsD2vTuGIIqwaoaULd/Cm3OV8IY5J70b7jcw0Y/0Pr/gH2Mg5olT5CHvNoDRveriL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GS1T+skl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572e8028e0cso3191048a12.3
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2024 03:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715856281; x=1716461081; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odc+1s3TU5qEstRr4mHfnv2o7wrGMkD8UFQyNruiv4A=;
        b=GS1T+skl5Ky1SP7b3ZNP4LO8vU4GXDnIdgs1yQqyljjGdSTEusoFjiPJB0BvGUfOUj
         dw1wIvW0dV/K8wVqwHc95Tzf3fXoyyVBbgNzKiKIo8I0p7ddNvsVwTvP3fqy7XS/CIfk
         WnKtYScdIIqrQWGhuWv+W3MFEiVvYwFImL9g+QTX0q7Bvn3JINL9+DpYlEl1IGsbftv6
         pFo+AUB/Y5Pm3G/Bp54Cuq61DHFOuvDjwxTSA11+ENxB0DxBNklZX4lY/9WH2ZvCLao4
         j/a3PIDrP7sx/dKUHha4C6e09wHHxsWfVG5KbZzFF2sK74cxEmRjCgbis/PfBWiiuFf+
         uF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715856281; x=1716461081;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odc+1s3TU5qEstRr4mHfnv2o7wrGMkD8UFQyNruiv4A=;
        b=XusunmeMuJP17Vv7rcG+7CP65fsHKAU5PE13x3rsx0goeIVQRAmrzb56tL3ikyTTWN
         3DeBUAiC0TETvb/QumfBI0GFc9boLAVsUmSsnV41Vr3ebC07bhiiB8d8Q8r9AawmQmB6
         XZ8KGFmNchw9aQw0qCJgNo8NX1T6TWYKnDYu0j/C7OKgdWrHgDoxJEaNdZ8+sDXXkE2R
         KKoE/uJt6/w2uRV2SJykGblIQt+DYGD6+YnvIvTQRUSgru259yp0CNkhQW4aid2aPqbw
         eYtcU7sLXN5+tpXLdRWd36EWHQewxT3bB76zTswNCbCDMYfdW8HCOf9isen1TtjGMUxb
         GKYw==
X-Gm-Message-State: AOJu0YztcnnzuT1OCDTt7ePaiOw+RBVfmx24rxtgyilShGTh2EiM2CzE
	I+FTYE7Vub+A757V4X9E1oNM2FSA2jUzgpFG8RmsbuUL/iduII4KUc37TAFCHiU=
X-Google-Smtp-Source: AGHT+IGc4W9anY/Ok7tCtxfeeTNTCqptWKd1JUnjCEvpDFURgnWnplCK8xvXGfi6PFSRUHhgN9TA+Q==
X-Received: by 2002:a50:cc9a:0:b0:568:a30c:2db5 with SMTP id 4fb4d7f45d1cf-5734d6b2e5fmr10275856a12.40.1715856280925;
        Thu, 16 May 2024 03:44:40 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.179])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322c3csm10441844a12.83.2024.05.16.03.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 03:44:40 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Thu, 16 May 2024 12:44:37 +0200
Subject: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Remove filtered
 mode for mt8188
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-mtk-thermal-mt8188-mode-fix-v2-1-40a317442c62@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJTjRWYC/42NQQ6CMBBFr0Jm7RgGLFZX3sOwaOkgEy01LSESw
 t2tnMDdf2/x/gqJo3CCa7FC5FmShDFDdSigG8z4YBSXGaqyOpWKFPrpidPA0ZtX3pq0Rh8cYy8
 fZKVrdzE1OUOQC+/IWe/1e5t5kDSFuOxnM/3sf92ZkJAb1diaStuc+5s1y0ts5GMXPLTbtn0Bl
 FlS98kAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715856279; l=2498;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=0Idu940agGS+y36TO2/QtyC3yMbEY7iqlAyR1r26iUs=;
 b=SHXUPUedcFXL8PeWXiY2328X9uItNmQDRG2jo5LUSO/Mu1dC5oMQ/x5QTGgqCZqa8F5RUuZFR
 QJB8iWzOZ4YD49AGKHecQBW6PlXDlNyIpx1+haBh9xfiJrWqMzqX3Mm
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Filtered mode is not supported on mt8188 SoC and is the source of bad
results. Move to immediate mode which provides good temperatures.

Fixes: f4745f546e60 ("thermal/drivers/mediatek/lvts_thermal: Add MT8188 support")
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Filtered mode was set by mistake and difficulties with the test setup
prevented from catching this earlier. Use default mode (immediate mode)
instead.
---
Changes in v2:
- Add the Fixes tag.
- Link to v1: https://lore.kernel.org/r/20240515-mtk-thermal-mt8188-mode-fix-v1-1-e656b310b67f@baylibre.com
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0bb3a495b56e..82c355c466cf 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1458,7 +1458,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset = 0x0,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1469,7 +1468,6 @@ static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x100,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	}
 };
 
@@ -1483,7 +1481,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(0, 1, 0, 0),
 		.offset = 0x0,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1496,7 +1493,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset = 0x100,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1507,7 +1503,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x200,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	},
 	{
 		.lvts_sensor = {
@@ -1518,7 +1513,6 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset = 0x300,
-		.mode = LVTS_MSR_FILTERED_MODE,
 	}
 };
 

---
base-commit: 82d92a9a1b9ea0ea52aff27cddd05009b4edad49
change-id: 20240515-mtk-thermal-mt8188-mode-fix-e583d9a31da1

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


