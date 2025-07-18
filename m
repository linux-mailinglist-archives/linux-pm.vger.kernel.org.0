Return-Path: <linux-pm+bounces-31044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAADEB09B7F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 08:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521A17BC380
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499CD1FBEB0;
	Fri, 18 Jul 2025 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM2D4w8c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D24219F40A;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820663; cv=none; b=bMHh0garsM6l02B8vDo0FweZ2JxU3wZWqvWuCScQqx5mKOQTId+GYitzMUVwblrfJHYN8/BP2Fxv1RBeW3JFFEWaTQoztsrJPVkfVH2xlL+7lvTPcxHm2THV2cayNOtf06IdhF/zcmPswDP08f/sIZ8Z2PYFK5Y1CD6TP5rkV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820663; c=relaxed/simple;
	bh=Al0PQ4WgTgiRp6IBkH7sto0mB5deBFgoepFFoWiIyo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxHthdFoKZ3L6P2XDWDZa+2F5Exz5VWncQPc2jKDRxL/b3rX1VK2pxWpX8rXBySRVXECqTGmGrc48yI2TaBRzWwV4ZPJ/TsPZZFsau93VlhD3NA81QGdOj23CCkFVt0YvhtJQd+OzfuMwyoJ01j/jCnRD+XuKRNdP8cQNb48d0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM2D4w8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF231C4CEF0;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752820662;
	bh=Al0PQ4WgTgiRp6IBkH7sto0mB5deBFgoepFFoWiIyo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FM2D4w8cBmcZME1z58dLOhLCT4fOJO7wkwmVKRJSyvuCYIAU+LmJFYlTQU3iV+jRg
	 BQuRAMmtybPTRjV3jn3y/MffHIwrGGUNzJdv+Vi7ivKT42/NsMlWcnJnlSDkI8U577
	 wOTwD85jK+0b9K14zenjJCOT5wS51aKda/ksng4xOCiiWKZivQAHH9mTdtXbBPmnhK
	 eBBlMpci2S3pcbX+zRzMujMI6f0fAxyf5YdkqgayAQ/b54/54mgpUQmEsSqcX9Y6PG
	 ddxaQyt2lX6dZrXLFDleQbBad1rVhtFmWx3MxskPxsR16cxY/I7ysRszmayH5nRroL
	 WBF18Or8/UUlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CBC83F3B;
	Fri, 18 Jul 2025 06:37:42 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 18 Jul 2025 14:37:42 +0800
Subject: [PATCH 2/3] thermal: amlogic: Support C3 thermal controller driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-c3-thermal-v1-2-674f9a991690@amlogic.com>
References: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
In-Reply-To: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Liming Xue <liming.xue@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752820661; l=1528;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=EsEZYshflk3g07X2o9lFN7MMXDrdVa6llyBRleDL6iE=;
 b=/WJc7hFo5hGlnBG5sOuV9xXaq9rc39za+LE5BXslsQe764jgsKJcE/hgckai+SJimk1E6wbLq
 ucy7yt1rCD8CAtyajT6DfX1+ZGTWOzE0SuDw9purCTxIw38g3vkU0Tq
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add the thermal controller driver for the C3 SoC family.

The main difference compared to other Amlogic chips lies in the
offset of the sec_ao base (referred to as u_efuse_off), which is
handled differently. Everything else remains consistent.

Signed-off-by: Liming Xue <liming.xue@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/thermal/amlogic_thermal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 5448d772db12..d1b08119c818 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -226,6 +226,12 @@ static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
 	.regmap_config = &amlogic_thermal_regmap_config_g12a,
 };
 
+static const struct amlogic_thermal_data amlogic_thermal_c3_cpu_param = {
+	.u_efuse_off = 0x108,
+	.calibration_parameters = &amlogic_thermal_g12a,
+	.regmap_config = &amlogic_thermal_regmap_config_g12a,
+};
+
 static const struct of_device_id of_amlogic_thermal_match[] = {
 	{
 		.compatible = "amlogic,g12a-ddr-thermal",
@@ -239,6 +245,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
 		.compatible = "amlogic,a1-cpu-thermal",
 		.data = &amlogic_thermal_a1_cpu_param,
 	},
+	{
+		.compatible = "amlogic,c3-cpu-thermal",
+		.data = &amlogic_thermal_c3_cpu_param,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);

-- 
2.37.1



