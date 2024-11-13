Return-Path: <linux-pm+bounces-17491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5899C75DB
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57F21F2634D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0BB205E13;
	Wed, 13 Nov 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="SF6Aqp6q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6C204096;
	Wed, 13 Nov 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510719; cv=none; b=Nacn+NxPn+MyyGbXOkzwlUqffu7IFwQjOqphLc4stDVYLv6jwqPuWXPYdnzvOMB9oi9mB/CnedRzLCchf+7Syl2z/1nY4EZpYNUwctBxjLE1duG/PB14YzFwIELozyqr3h+ydjjRccrvLDI/q9xxEUgCUF3EBGukpT29CiblzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510719; c=relaxed/simple;
	bh=Nrz9w5zBv/QnJ7uzu+/afmMrCtwXjWWUkRPBG4nE14g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LEij1c4Ek8DtJGWqrKV56H5JLsu8w6Z4IsrydaVeqtqjBFrxrmhr3inkxDwrJfK26IfHpemKuc7Vb73uylmM9+z1EJ5HRpfeC/POv0Z96qvh8yaZECF5lkLC8i9MOPejD610ACP4ix3XTz7hwrvBjZSNEA7Q8LI1bsrLt2BSAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=SF6Aqp6q; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.93.162] (254C230F.nat.pool.telekom.hu [37.76.35.15])
	by mail.mainlining.org (Postfix) with ESMTPSA id 4BADAE44EA;
	Wed, 13 Nov 2024 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731510715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbrXjZM+gi6Zbc2dB5/3D6eieJAq+E0T8kg8nHD8OLk=;
	b=SF6Aqp6qgk0lBOKXUzXYmQ3G/ygejDZpeSjNEB/BUNXJHIaUX02xoFW3kMGo/dqK/QPhWp
	etnqeZgyFqFjUsW2/MwC8aVtacnHAiv7o2j6uYXaseJYWxeMxJmsq5qtW2M+VYO+RalqTR
	zmyy5SCHfTkhGM/FlyRdbImsluFDCxSq0057GUfCbqPCD3Qm8d9t/zha2o+jmOeaE4S0Xq
	8l6gLnI4nAZsGHsCTBmVWXQp76e21oerPQ421YyM6XMVgyuTAz5Vsp/oQHH91oQtnLKTLH
	6U7kCd/voCxYFyFj7Q1LqEIUPEe50FeCV1QKr1TK9eyIdNb3zyu6XqgH34bG1g==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Wed, 13 Nov 2024 16:11:46 +0100
Subject: [PATCH v6 05/10] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241113-msm8917-v6-5-c348fb599fef@mainlining.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
In-Reply-To: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731510705; l=2992;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=Nrz9w5zBv/QnJ7uzu+/afmMrCtwXjWWUkRPBG4nE14g=;
 b=j8TvLrS5DdLezJIJwH+TW/forAQyp0sOZYMMbBSAxWD/0/YsBPyR+BxLyJqTWcu4/KcWLwOWW
 UcJz3cmpU1uBiD8zSbI0O+3Poze+uniaGgxprJfTOyKfQ1N2150R2/d
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


