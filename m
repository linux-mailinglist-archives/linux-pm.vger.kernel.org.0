Return-Path: <linux-pm+bounces-17257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E09C2C89
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC4282EBF
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FB1991CC;
	Sat,  9 Nov 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="VeeHrty8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776C197A9A;
	Sat,  9 Nov 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731154104; cv=none; b=jUkmZGyz0U4zurroNR9JNczNT2oTS6GfDB02yk9mdEfBmpLPSYwKMLgJhQ4A/kztLyQy6cOzi1Q3EoB7rbt7PNXC7t/X0kAWBKP3AfmYiPtDsPL8DDcUMRvpLTwVSZAV3KRT2btnpB6RqOX+HAigI4sYacu0Mq9RxX9UqILN898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731154104; c=relaxed/simple;
	bh=Nrz9w5zBv/QnJ7uzu+/afmMrCtwXjWWUkRPBG4nE14g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHJSJmLfArqNewgDm6GqQi3nn8P7kynqQPEQ8Hqx8eH6RGJno8a1Fs34AUgu2/4VgH5mcA+anKI0+T4JauXIEefZmQrrB/YJwpHBK5uk4KC1wDE1VBXOTSCSMKgcYND0nGXrfBhlRG/Txop498ZDWDkA1GwJJ6zdAao1beYnZo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=VeeHrty8; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C229A.nat.pool.telekom.hu [37.76.34.154])
	by mail.mainlining.org (Postfix) with ESMTPSA id C587FE45C9;
	Sat,  9 Nov 2024 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731154099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbrXjZM+gi6Zbc2dB5/3D6eieJAq+E0T8kg8nHD8OLk=;
	b=VeeHrty8mP5cZmCnDbgDd1/7GV5Z5kcaUevIiIdDGmtzsybYynWvcQYQE/yZXBUjapspgS
	xbSut/hUhgCVhaGoYTK9V5YNoO/7RRIe/zfeW4VeJ+a4joHNiy9EHNcCEqtL5XZJE/JmVH
	FECyd0b713ur3CNqrauWCrlNfKAyg0SnOAlB2fUpTD9HmSJXRE1qHSviHvUBwIR3hp8KTj
	Loas3xF96bgZ4rqcbtA1BlIC4D3zUlrRI4vZ+2o3arQuBx7q+xFZzYpdUSkjp7scXeaizu
	X8kl9tt0UqOOQzNOfQy6h69hM5HilZ8V2UPwnRCrq29V5cHZbxJGS0OBqR8D5Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 09 Nov 2024 13:08:07 +0100
Subject: [PATCH v4 05/10] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241109-msm8917-v4-5-8be9904792ab@mainlining.org>
References: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
In-Reply-To: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731154089; l=2992;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=Nrz9w5zBv/QnJ7uzu+/afmMrCtwXjWWUkRPBG4nE14g=;
 b=XDuU+ArfUft3c4H3n1BZDhFTX7M9RrHdSHeEy3mFN2ukmruUR/NZEpVUybtbGl5xdDGU7NzHZ
 RUNPGfIPvynB0mW1bN7Q/CcdTojYRMzdsNvZfrRwoQC+VIXKAPm/JP1
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add support for tsens v1.4 block what can be found in
MSM8937 and MSM8917.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/thermal/qcom/tsens-v1.c | 21 ++++++++++++++-------
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index dc1c4ae2d8b01b42a0edbb7f12a5780b25d0c8ac..1a7874676f68e456749faa1f8b6064f5bd38b146 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -162,28 +162,35 @@ struct tsens_plat_data data_tsens_v1 = {
 	.fields	= tsens_v1_regfields,
 };
 
-static const struct tsens_ops ops_8956 = {
-	.init		= init_8956,
+static const struct tsens_ops ops_common = {
+	.init		= init_common,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
 };
 
-struct tsens_plat_data data_8956 = {
+struct tsens_plat_data data_8937 = {
 	.num_sensors	= 11,
-	.ops		= &ops_8956,
+	.ops		= &ops_common,
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
 
-static const struct tsens_ops ops_8976 = {
-	.init		= init_common,
+static const struct tsens_ops ops_8956 = {
+	.init		= init_8956,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
 };
 
+struct tsens_plat_data data_8956 = {
+	.num_sensors	= 11,
+	.ops		= &ops_8956,
+	.feat		= &tsens_v1_feat,
+	.fields		= tsens_v1_regfields,
+};
+
 struct tsens_plat_data data_8976 = {
 	.num_sensors	= 11,
-	.ops		= &ops_8976,
+	.ops		= &ops_common,
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 0b4421bf478544dfa071c792dc812ffaedc9c635..d2db804692f01d300b555d491e8a1acc597b3819 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1119,6 +1119,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
+	}, {
+		.compatible = "qcom,msm8937-tsens",
+		.data = &data_8937,
 	}, {
 		.compatible = "qcom,msm8939-tsens",
 		.data = &data_8939,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index cab39de045b100030de6a1209c58bb09561a3224..7b36a0318fa6a078e73ce26dfe7387e4435148b4 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -647,7 +647,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
+extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;

-- 
2.47.0


