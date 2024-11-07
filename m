Return-Path: <linux-pm+bounces-17127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7D29C0C20
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 18:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90B41C2245F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006A9216E19;
	Thu,  7 Nov 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="VD0iOsfC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247321315B;
	Thu,  7 Nov 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998981; cv=none; b=MPy9HeVkgSefNB8TfFUFvgglslzgZS5/dEo/bb28Yvo/mlJ0u1lDqGJNbUWHVvI0yuDWxltyNFXi4BfO/CmBIF6Ui7Pp9NR7X1s9LTsBJ4IPaDdk6BlL2mrzvlDcUFh/NN0nfpHsZwJVMhJppXkwkdSZKVHn2V2K/61PM1nFooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998981; c=relaxed/simple;
	bh=ZUgeto9/E87fDiZJrXBC+X56+By41ZSfPN7XvT0Ux6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RN8oyfZ7h8Z5EG7wURW9qHq7KQwUoGflnydl1V5ZhtAnfLlAdnqhTqnVESGI2JHrkMq9b936ndjW5blaO9UDpCRNYxvjpPHxM6e0/+/jB0QzI7ZmXM2lcu3KFu5mTRr8zjEpDvzZRSY1fEB/feg7oxoUV94A3byP+1VDiES4Tfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=VD0iOsfC; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2715.nat.pool.telekom.hu [37.76.39.21])
	by mail.mainlining.org (Postfix) with ESMTPSA id DBFEEE45C7;
	Thu,  7 Nov 2024 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730998977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZFwbFxl+fO/yfXuNk3d5tUxPWCdUEMpagrp1Rl+Vgc=;
	b=VD0iOsfCy8Wuc3BP5weRCHJFY6ApGhkVDRfufi0V/mSPibkk//2bpdg/nz9Isxuew4uMvs
	Dhw6aLuACFw8WjeRThxVcCWjpk+43CgNbQ3ri4A7W2m+AkGKlpsVJMuNpf2EWa3NaMUaWh
	7U9byhps8r/uP1NLk+LA2Qkp35FxVMi08rHmUkDdeLWiPik+CQP4yc5Uzu1LgvmqKHKAzh
	lQLA6iJsVTFjg/Y4YF9qlatE5qw5CsQMEUWakjYm4kLSCk5WS9+eUSusVb/jw5HBGcWB7a
	ZLogLf+8lJn6JbMFXNsZ+szXIZzPpbJJTl84S1u6JPihvam7w2q7WvDaa0HL1g==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 07 Nov 2024 18:02:45 +0100
Subject: [PATCH v3 04/14] pinctrl: qcom: spmi-mpp: Add PM8937 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-msm8917-v3-4-6ddc5acd978b@mainlining.org>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
In-Reply-To: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
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
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730998970; l=1084;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=ZUgeto9/E87fDiZJrXBC+X56+By41ZSfPN7XvT0Ux6Y=;
 b=2VfRXLWfHUaF4RbGeGO0kiQ1+sIuXxrW8PbGA4tatq9Kkngy+a4GSFT+Yl0BB40+DEIczuT+y
 Hb7k0AKJ2JeCnmlYeXOKE6ZlXphGQ5PeNPdnPINkPSZ2XnfOdvyOf7X
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

The PM8937 provides 4 MPPs.
Add a compatible to support them.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index b5b3ac82f030b55f9e199bb4265c770cfde4a81a..84de584cf7ebbd35dd3e7aa89d4b971645b02f82 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -983,6 +983,7 @@ static const struct of_device_id pmic_mpp_of_match[] = {
 	{ .compatible = "qcom,pm8226-mpp", .data = (void *) 8 },
 	{ .compatible = "qcom,pm8841-mpp", .data = (void *) 4 },
 	{ .compatible = "qcom,pm8916-mpp", .data = (void *) 4 },
+	{ .compatible = "qcom,pm8937-mpp", .data = (void *) 4 },
 	{ .compatible = "qcom,pm8941-mpp", .data = (void *) 8 },
 	{ .compatible = "qcom,pm8950-mpp", .data = (void *) 4 },
 	{ .compatible = "qcom,pmi8950-mpp", .data = (void *) 4 },

-- 
2.47.0


