Return-Path: <linux-pm+bounces-18559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9438E9E413E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD3E167EDE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01848216387;
	Wed,  4 Dec 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvy++nzZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750F21C9EF;
	Wed,  4 Dec 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331726; cv=none; b=QMSy/gKicoFSz/HR2e7ub6BPVWVIXbh/UQAEFuY4wpZHd/xRdfMzV+wSpVZlaYmKS8lgI//x1P41qViMFH18f2IgcuLStLVaCPdYq8fzCRM6f2SR7INDp0rN8fSmFZMzBb7rzeRKBzrLezn67mUAkTpGsqH7oySbGfVUk82VZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331726; c=relaxed/simple;
	bh=kHYfCnF2W10W2c/6rhFhdRAr3NERXQwySnI8TYIPp24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgfwOx2jzjm2kCdzpTU55S6hUZjSU3xPRm4uMQpC9xEc9mT1B2z3dLZrUGOEIfM9wQQ08H4JMdP7npLjhEMBOT9LBL2WUURhw7xN5Q/Sehg8v4/GtAmlx4wmFthFXu7ZpVknRBSH8DG9s7qvzr1Hbi44oT0s/G+A01OSvOWupuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvy++nzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6A1C4CECD;
	Wed,  4 Dec 2024 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331726;
	bh=kHYfCnF2W10W2c/6rhFhdRAr3NERXQwySnI8TYIPp24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvy++nzZ1xg3O2v6Q0urBopf4aD2JTmsSey4tuOdFgeSVUs/lATWdmNnnyLJ4WMoN
	 6rycgG4tpZijPyuKwZqycSsN1blKirSZgjig/4NcYG8Jczh6zOq9wQvE1vfsMHakNm
	 ikf8T3NZToTTQige+/E4WD8A1jqGLoGpgHZhj/so3AVcsf0CGVk1/AzfSt2TUENA8J
	 5K+gyYO2MFpN0O8m9zdUaLCo4EWqwu6QxE3AHS7qDU/MmOzpxjDiD56uoOD84pGyg4
	 R64q8Mo2YpGcJxxpSefpPm95X39mch2qUXlmRBhKnEYpRSsbGI7q4XmDq4tNZEnQhi
	 tVmLe6AuG/GJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 21/24] thermal/drivers/qcom/tsens-v1: Add support for MSM8937 tsens
Date: Wed,  4 Dec 2024 10:49:41 -0500
Message-ID: <20241204155003.2213733-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155003.2213733-1-sashal@kernel.org>
References: <20241204155003.2213733-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Barnabás Czémán <barnabas.czeman@mainlining.org>

[ Upstream commit e2ffb6c3a40ee714160e35e61f0a984028b5d550 ]

Add support for tsens v1.4 block what can be found in
MSM8937 and MSM8917.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Link: https://lore.kernel.org/r/20241113-msm8917-v6-5-c348fb599fef@mainlining.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/tsens-v1.c | 21 ++++++++++++++-------
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index dc1c4ae2d8b01..1a7874676f68e 100644
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
index ee22672471e81..0aff3318aa19a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1118,6 +1118,9 @@ static const struct of_device_id tsens_table[] = {
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
index 2805de1c68279..b94a84c94e29a 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -642,7 +642,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
+extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
-- 
2.43.0


