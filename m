Return-Path: <linux-pm+bounces-16008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E1C9A4D4B
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF53CB221C9
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A341E0DEE;
	Sat, 19 Oct 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="iy/mKOQN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1B1E0B6A;
	Sat, 19 Oct 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338653; cv=none; b=KCzaptQhvyLXJf4OrjWGe1ONT9of5MioGUifGJTv8QS0ra6me8xmNW/edByzc4+3ckKeodpUHE7Y3GPtKBLGqyXsHYStQJwXnh8d9vwdk3MEdXkNf7YzMPriKtteLD9QcQD0nMwsN+2z2pW58wDKHQBtWnifuMN86i9Kh/RcvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338653; c=relaxed/simple;
	bh=cDWauIFOhCPNbwkCVY3LkMwztyH8z561yVG1fYO4mVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0iJqd50rH23WRk2NtBxa9dhgGGevgGkv6GNlCrwwK8/7icxloTzI4kr5PtSPJMY/U64qF9AXKMIJZrEI6n4+1BwOqSzUVuLCxBawAir9QXRzTjHBgY1dMWDY08UbvE+xWr1SZkgZxqwDP3g4nmIpYfDTDdsXCMpxmRdJPTIMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=iy/mKOQN; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id C43E8E45A0;
	Sat, 19 Oct 2024 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnmFf/TpFXfbNZ2S1IT03EPJKNClcoQzc2cdpLaxzbE=;
	b=iy/mKOQNv/w8rWL1e4vUd09XTDszMSJNBGwzpos1KfBdcAYEMfpJgXJWRKKPyKs0H4Ad1O
	ZhPniovDiOGsmNim3vrmHFuVM+R6r9wEhnCzzNt7T+6iNpSGUQ4QjMZ/J7jKay9ZcNLSJj
	JoQePMExnEwlmIR07pzyWmkhG37BIlEng6loWREnoUfyuc5fUTpSsvc/8IPtYMLrlBiKVV
	XOZgdAVVbjCOd7clk5vVqZ5SDPKfidBMgnQGoBtM43/H/zTfPj3dJee6P9EunOijtPxyyc
	IhS91X0JOmYTAc6/zlNLKrX8ABk3Al9KJ+3GIGtkc92gPsGt6feZgAXh9b3xoA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:41 +0200
Subject: [PATCH RFC 04/14] pinctrl: qcom: spmi-mpp: Add PM8937 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-4-f1f3ca1d88e5@mainlining.org>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
In-Reply-To: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=1023;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=cDWauIFOhCPNbwkCVY3LkMwztyH8z561yVG1fYO4mVA=;
 b=9L8g6ZfQQ3E3qOqsanyM3Zu0oNP0L/K8rbxg5zpTgtvqTTmff8R3EPmxNeg1d43ZNAK8+5786
 CkGyD3O1erbBBUM2tU18HFoq1tnuy0EuCqjFnsRtN4n6WioYmmg2GB3
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

The PM8937 provides 4 MPPs.
Add a compatible to support them.

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


