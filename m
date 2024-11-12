Return-Path: <linux-pm+bounces-17432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7899C5C57
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FD8282B0D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D42040AB;
	Tue, 12 Nov 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="kc1Dor48"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20E2038DD;
	Tue, 12 Nov 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426591; cv=none; b=p9f6rFtEgHyFwSAUtCWszpPcY1nSEJSsVhSEFFQPdoIbHc2J3ZkzvDvJBwAMCaXJN9CP62JW8bFRU7tNDMNKZf2rhKFNOQKiFru6Ncj+GmyWDju/PMKx9iMMf1zChfQK+PWYm9dkRI1uQRvUvgMvFRam+yfdKVlEyNSOBXpstlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426591; c=relaxed/simple;
	bh=Nrz9w5zBv/QnJ7uzu+/afmMrCtwXjWWUkRPBG4nE14g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QddKjeMDZaEfZhQeJCep15dLrpkqkP5+a8ZwK37pGH3x2bXrfhkDx06I5JM5YQvjFhpS6l1VhrSx4X9aAgvPTHNlbAq/SH2y3rgx06D0VnMtgMG/BDpifeDmPU+WrrNg54/vzy8SOYlSFzsnLwmoTJKBHEgYJ0FUxZUIc0EOa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=kc1Dor48; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.93.162] (254C22F6.nat.pool.telekom.hu [37.76.34.246])
	by mail.mainlining.org (Postfix) with ESMTPSA id 2B9D1E45D2;
	Tue, 12 Nov 2024 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731426586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbrXjZM+gi6Zbc2dB5/3D6eieJAq+E0T8kg8nHD8OLk=;
	b=kc1Dor48iSjziWpiijLhK4aVpLtNc41OO8ZwCLOl/3vlCSOVr8M0+6Kqu/SaxX4+JbbvvQ
	RBnHE6MG9bA5ebMf916sUBt7P12rTaRpYOnXhrY5N24R20w+SeK5hA1AlgSD+W6AZEWPAB
	4dOkAGPAZkwAITleHp67nQGpAqYRpXkKJAQk4exQwJ4ZyHQHEndQBcYl4o/7P+Ao5Z7FFG
	b3DhCZ7sJ+qn74W3cECUaYZGfipsk0MsTGsp8hSS0ib86kjoC8+r13ZlJYmBldY+Z3xY4R
	HBJ+ErUyLv+EI1n8vnyM66euiA0ALH/J5RoroJlxaXIC6KhMMmHZbE8y2jx7Dw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 12 Nov 2024 16:49:35 +0100
Subject: [PATCH v5 05/10] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-msm8917-v5-5-3ca34d33191b@mainlining.org>
References: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
In-Reply-To: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731426576; l=2992;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=Nrz9w5zBv/QnJ7uzu+/afmMrCtwXjWWUkRPBG4nE14g=;
 b=GdR+2rw5Xe/7si9U21YsYu/znviD5y4z5k1W4AEZ7KuEr31dOAu5m6YyrCRG1N3OsEOqMQ6qT
 rACzTehAo84DB4uPS125+DNxQcam6nXrIXVHAdbbnI2sGOs1lb5zQKR
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


