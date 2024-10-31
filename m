Return-Path: <linux-pm+bounces-16786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36219B71AF
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 02:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119601C20E1F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F912BF25;
	Thu, 31 Oct 2024 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="su6hr/kG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D26F066;
	Thu, 31 Oct 2024 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337602; cv=none; b=kBRf01u/U6GdczujuyhLbd4X4LIvwUlqA3Orna4n1gBZFkUI6BG3zplPcltWgMPDpjxQrLfF6hv8tJglwdtdTUy6RACNgsX0ScLw1c9NhOTtAGZ7sxijNPEMdHiS3miqc7dqLvkTTEbCLfSai1FKP2q2YMeliN7vWDMyWW4wMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337602; c=relaxed/simple;
	bh=+auV2xbHnH8Ew5XeZexktMLe4HULByqQHcRGhcce8AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txcyItztX8KSAKvDvw7sAEGMfV8Aml/hgDr/b6FWkozWsRptGVyoYJDtfLI+aD9P+eHkXKs/u6eiSHTZA/ueEoMhibEX5w4bgrGe+nZCKCpphQACy0RuAG5Arwl2grMwEQae8OoSkfCYIukmYyNbcVnPyyQT/Jg2S/n3TdzR6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=su6hr/kG; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.162] (BC24936A.dsl.pool.telekom.hu [188.36.147.106])
	by mail.mainlining.org (Postfix) with ESMTPSA id D401CE45BE;
	Thu, 31 Oct 2024 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730337596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSjtl8egN/7amHQK4rd+lA7Mo+LBp5UxTJkQiEalxxA=;
	b=su6hr/kGUUxmz+I9XCScilK8EvHkXkK4nH0K5mJWBjQw0El7mxP2etcCuOiOVcTtOuAwtE
	67roShL+UY8HBWbSaXIfQfWRHljDJBNrGbPlynPlGVp3/b3UlnXjYWR+Kh6+7/j/zNMMdg
	km+dQ5d84MaAVaXn+DAGw0iRtODVvc85TxhaOGoZTBoCL9EYD/82RGoY96VEOTxaw/RRWo
	ilSkl+p0UVKQOWbyENnDitsFF4e+ZsjA+IHyAAspogks2ckrWvwT9+8vwYKfim8c/a1tPz
	OlJWivqoF/t3qnPIrOVMxWeWlMXX64mK9DGR22YMd1T2m8jgUkcDFszuRT6Qmw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 31 Oct 2024 02:19:52 +0100
Subject: [PATCH v2 11/15] dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU
 to SMMUv1 compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-msm8917-v2-11-8a075faa89b1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730337585; l=939;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=+auV2xbHnH8Ew5XeZexktMLe4HULByqQHcRGhcce8AI=;
 b=8inYbgSn8grWR0K/GfRPG9fnSC7k057pACS12fCl5gZqEHZN3MAYBjF5tp4ZD43tLfJPOg+/E
 Xh473sTPqtlArBkRv5YyuomamCAeFdRKztrCUt5dBWPYVsEQknOzxYl
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add MSM8917 compatible string with "qcom,msm-iommu-v1" as fallback
for the MSM8917 IOMMU which is compatible with Qualcomm's secure
fw "SMMU v1" implementation.

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


