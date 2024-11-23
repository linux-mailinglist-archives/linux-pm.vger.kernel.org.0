Return-Path: <linux-pm+bounces-17987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16B9D6C11
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 00:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A77B21587
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 23:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE31AAE02;
	Sat, 23 Nov 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="F7KgTzuH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C9A1A08A6;
	Sat, 23 Nov 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732403629; cv=none; b=bfS8ZMHB69YR8GmH5vIIfpdEBfch0vCuwkCXgEqAnY2dz7ErSV7Z1BjCLr8xGUA9LotJMS10GfESZF5ar4OCb6+Ar8lLW0HXQsSSSP7de+PLKDuEGPoRzBvDS1fE4fV9qZh0E6VZHrxtv0rdNAaLCp8GrJC/QnpKsTmqakckFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732403629; c=relaxed/simple;
	bh=9EpBDn6+VrUhl6s9RDziNCH5FD1n12+IVb+sGxL5HO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7JwK7r+h2a5DZomw7POn91xIfQBEb0jULTfq9ZcPNeLp03EmP5ztOLm6vIEkqgtFdzVAltP5H1BI8TIGtMW4tv6EbCuiK6hamjaQS8mr7RXh65ebObqGMs8pf5Y2oLYYnYzXLDNeN70MIyoQlc1PePtnrP+p4Jopy+oATz3DKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=F7KgTzuH; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.149.162] (254C22A6.nat.pool.telekom.hu [37.76.34.166])
	by mail.mainlining.org (Postfix) with ESMTPSA id A988AE4808;
	Sat, 23 Nov 2024 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1732403624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgTkMERpFtHVYtKjLiYY15MruMqcfI9oO4bj8B7L2VI=;
	b=F7KgTzuH/VjfHnmbIBQjaVUI1wgg82y0JdJo7n3Cr9Q2C/6WXIbmFCBt3cJpBxhhXGIqmh
	iKO8w18DuuUn1JGhlsWn1AaL1QP+yHkv8qByV9lOAf+uLPNWymA36/G4vgXMJCcAsETGZX
	AFrwAuJaTFm9PSArEXMdsKoEwIeyEGOeuxXe/rJyhjHDOWUYPg09TAt2BfWyKiQA9R7LSM
	88M4aMZ5lTN2QWi8AofqOXWp5t64asVZHpOiUt4RbhNmScuXFF8ClkJKZma7iOh9dZ58Ss
	/ccb7yHcWywEmLSwZu+9uuY1pweMTf0S1rUCje1Tfyjr1GenOfW84Y+sM6jhqQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sun, 24 Nov 2024 00:13:22 +0100
Subject: [PATCH v7 4/8] dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU
 to SMMUv1 compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241124-msm8917-v7-4-612729834656@mainlining.org>
References: <20241124-msm8917-v7-0-612729834656@mainlining.org>
In-Reply-To: <20241124-msm8917-v7-0-612729834656@mainlining.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732403617; l=1003;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=9EpBDn6+VrUhl6s9RDziNCH5FD1n12+IVb+sGxL5HO0=;
 b=+7DVzGahaQHlmap6YsWsgRMNsY+8dydFrEDkB37+0EBr+Pb+bmvPPzK5uWPVxMZj81JjTEISq
 R+zhw18tOUNCeyK4vD9hKwRrWZvtbNAcz1xdE3w2T+ylnBqu2MSHWMe
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add MSM8917 compatible string with "qcom,msm-iommu-v1" as fallback
for the MSM8917 IOMMU which is compatible with Qualcomm's secure
fw "SMMU v1" implementation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index f8cebc9e8cd9d46b449cd297153dbebe5c84bf3f..5ae9a628261fd251c1e991a70662c6d37ef2c4e3 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - qcom,msm8916-iommu
+              - qcom,msm8917-iommu
               - qcom,msm8953-iommu
           - const: qcom,msm-iommu-v1
       - items:

-- 
2.47.0


