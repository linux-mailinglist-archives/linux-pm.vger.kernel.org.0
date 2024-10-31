Return-Path: <linux-pm+bounces-16783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3199B71A4
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 02:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC861C20D59
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 01:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471DB83CD6;
	Thu, 31 Oct 2024 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="VrFWHSmu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471F49638;
	Thu, 31 Oct 2024 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337601; cv=none; b=hXeMdb/UqPlRUd99IINLTFJ7EgOiRQBvihHqkeeGlNy1vD/XksWldrazDC+aVjBdET+LZ9kvsxCzEbbuKyFsM4QdIwLShgKtr7mmDG5dRaJJLjiFFeoKtEqheFm1n8bM6B7eEovMjeNlKYy1T9YD889y+wdMPD1ztXyKVtyNBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337601; c=relaxed/simple;
	bh=BBAdp36djuzq9jB3XZPXi7HS1o2IGwaAGahoDu/Mgcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ho6e1rzVAbvXhCt/NkpwI+65VZ0Dv+Rrv46TMsHQ/5LUp0wsKvJKXvIxv9Go/4VYkCNKIRl4sKjWZ5c80gfNS95tt39KDvI4a36SfazEpknEzQXSp8zckDFZhE2mNUOydXACxR9rLQkP1hvH5UHkRdIbKyZmPxDqV8DXBKDGuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=VrFWHSmu; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.162] (BC24936A.dsl.pool.telekom.hu [188.36.147.106])
	by mail.mainlining.org (Postfix) with ESMTPSA id 347F0E45BD;
	Thu, 31 Oct 2024 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730337595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkY88coumVlb2DOH5tb3TnVthjgOS6f6PPbgwerkoU0=;
	b=VrFWHSmu1tEBJX20+YjccPlW8wqPWG0Hyq7+mjnoZ+RyKQicfv1hvcCetTlO4Xwba4L82I
	sD2bsZSUeh/kEgZhq5OPop+WYtozp2tBI+9aCbpazcPTMfQfR6HPtcmPA8gCXyV49B6iiy
	M+u5WyXa1UBtLb9p4qyFlvrI707WOxpgsA+bp7JyZLC0idAzKonyP/40vhxDI+tARaiwBe
	14CxDRGu8iyW3JWrPOXfzEolUZvMyaetxo9NAePTuPHJ7zzs9//M8cUVOytSOVuLbB/TTJ
	6UGwseZsfX/G4oVFkgcxTnAm+3kPXFhGyXk0oxyrXUvHrr7j2nJPzWaQMlDGhg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 31 Oct 2024 02:19:51 +0100
Subject: [PATCH v2 10/15] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-msm8917-v2-10-8a075faa89b1@mainlining.org>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730337585; l=2346;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=BBAdp36djuzq9jB3XZPXi7HS1o2IGwaAGahoDu/Mgcg=;
 b=endH82adyQFOXz+Q8atEy+LaQ/Ep3Ar+UTasaKgq9WAT8upIBmCvw833lxOrPnSjmpDuniTEB
 DKEqeb4TO1EDTwoSlIXj9dN+q2V+AimzUJwAqVZhHdxkDLfb6IS8v1s
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add support for tsens v1.4 block what can be found in
MSM8937 and MSM8917.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/thermal/qcom/tsens-v1.c | 13 +++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index dc1c4ae2d8b01b42a0edbb7f12a5780b25d0c8ac..50787cf68bfae48da6061d8e75956308f41053be 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -162,6 +162,19 @@ struct tsens_plat_data data_tsens_v1 = {
 	.fields	= tsens_v1_regfields,
 };
 
+static const struct tsens_ops ops_8937 = {
+	.init		= init_common,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_8937 = {
+	.num_sensors	= 11,
+	.ops		= &ops_8937,
+	.feat		= &tsens_v1_feat,
+	.fields		= tsens_v1_regfields,
+};
+
 static const struct tsens_ops ops_8956 = {
 	.init		= init_8956,
 	.calibrate	= tsens_calibrate_common,
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


