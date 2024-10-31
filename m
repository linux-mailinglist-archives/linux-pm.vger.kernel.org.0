Return-Path: <linux-pm+bounces-16795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C69B71ED
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 02:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EC41F24107
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E220127E01;
	Thu, 31 Oct 2024 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="SuWuWr+s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A143FB8B;
	Thu, 31 Oct 2024 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338188; cv=none; b=enxSiDfyvr3CTeCC2M+J8iHxESIlZHkozWQ9unBAHljkbp7q7SMHUvXW5r3+5NtZDf2ON6iG4rhNoceejVM3nWGmCHUWYsDsx0NSCAL4ekULsEFlMw99jov0HdllCZJ3eaxykEahBAXWgcK/7+JS3MJ0ZoUP5yZpqHWMCsxOidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338188; c=relaxed/simple;
	bh=kANJbusz/1wsoZAzBf9MgUzpPoVv15jJLK4rJBNHHIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCg/tAToobh9Y/tB+B0ykLXGOVu2QZBNFVoPBk+4qpzp2G8YPhMNij/8m9ebNOWa5ymf7xQzOqvxcQcLIooyvZ620qMtUIVN0xyanzkEnWjr0/tWrQmyExVm0gJNLqft8Lb6AdaFnvl4yC0+6d9vO+37rfLnCNsQMG5RfgrYwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=SuWuWr+s; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.162] (BC24936A.dsl.pool.telekom.hu [188.36.147.106])
	by mail.mainlining.org (Postfix) with ESMTPSA id E7457E45B6;
	Thu, 31 Oct 2024 01:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730337589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoFhgvV9a9kora5JIHDRkULnX8QqLWjcJwM1ZxNV22U=;
	b=SuWuWr+s1nl8e/G/5hOfiFn0AugFje0ihAyQagTXaIu2qsUaPezQEeW1SM1Id2HLmYXTpf
	/5eXWvPOm2Jx2vUXPT09f1EQwZR7JbOpqruYZfbmHB6O/ahj9oOk0tCfQ8nxWQmQnFTmEr
	MD4znfe7Sy6Ik5969hln9t6ktPFRklYAimB2MOhYjfk1/V4Ao9xciEYn4gbwjP9l73FIxp
	3yjvpPFHQnwWqJ5t7LE+xb7IQSbrW3l0JD1kFGgW+ROKcOMD+fBnB45uacowgFOCeBm/MT
	ihQdimmVH5Maz11gOkdSUUPl4GFMvJqtho3xCCiScrNegEgglwlkm+RmBoms4g==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 31 Oct 2024 02:19:44 +0100
Subject: [PATCH v2 03/15] dt-bindings: pinctrl: qcom,pmic-mpp: Document
 PM8937 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-msm8917-v2-3-8a075faa89b1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730337585; l=1209;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=kANJbusz/1wsoZAzBf9MgUzpPoVv15jJLK4rJBNHHIw=;
 b=sEQAKn+ugy8i1FA5+ScQ/S6OSJQf20UU6xmt4G+TzlXYrUJ/8Dz9hmELfNhkxj44WMurhnLnm
 Ihn/g+uUf+2Bk01VcovDMA8qN17x9eY/RLF7qQGLzn3DLDQhdDiP/PV
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the Device Tree binding for PM8937 MPPs.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index 43146709e2044d9dead08a6786b98672ef766629..9364ae05f3e68f3a2f4dd78ba3c0f94b3ccc3c51 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -22,6 +22,7 @@ properties:
               - qcom,pm8226-mpp
               - qcom,pm8841-mpp
               - qcom,pm8916-mpp
+              - qcom,pm8937-mpp
               - qcom,pm8941-mpp
               - qcom,pm8950-mpp
               - qcom,pmi8950-mpp
@@ -92,6 +93,7 @@ $defs:
           this subnode.  Valid pins are
                  - mpp1-mpp4 for pm8841
                  - mpp1-mpp4 for pm8916
+                 - mpp1-mpp4 for pm8937
                  - mpp1-mpp8 for pm8941
                  - mpp1-mpp4 for pm8950
                  - mpp1-mpp4 for pmi8950

-- 
2.47.0


