Return-Path: <linux-pm+bounces-16015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65DA9A4D6B
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0BD1F2536E
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAC1E22EC;
	Sat, 19 Oct 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="G0kj8Kd7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DD1E103D;
	Sat, 19 Oct 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338657; cv=none; b=q1j4PeilHy9aiigU5eta9DgtOwJ0N9Ss0drZ1kNID6AERAbHBfzHwatA3hyQI/v6He7yZq9q2FRBOIC36ZgwiwVXAXUh4adkyeQhRYAz86IHzeMQvF3gQFa0xcMyHNqjy5yQqGBIHSGJx+LYCvjVDbED9dACuV3YgmGlQn/1UDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338657; c=relaxed/simple;
	bh=+auV2xbHnH8Ew5XeZexktMLe4HULByqQHcRGhcce8AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAF10XqlcIUOw8MwGa4/gl+dIhFiF+WVDOsDVix91Jwmo5Jz+FlHgYVYhJ62X7fkRvDURx5UMx2b8XpRlcx3tFdNFa6VeTtnnY32Y0F/3iYic2gj2j4OhV7u2REPOZmekCvluMfygd4k0H/PL+AWmI0mjBtvyDOW06mQYrzoL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=G0kj8Kd7; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id B7EE1E45A6;
	Sat, 19 Oct 2024 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSjtl8egN/7amHQK4rd+lA7Mo+LBp5UxTJkQiEalxxA=;
	b=G0kj8Kd7yFJp1V011CW6hIEGyP3Z8wa22Pw2s9JlobBOBpsWkz/ztSMhXY1x9vKxhf2lum
	VnK7d1D9RIfj5S+cifq5cjzN6dNKNzehUs2JcgFCTBYAkqn7Pd8JAaKHawScEO3d+uExl9
	yEaYIV7e/ZUvEMaw65kz9+nb8PdlmwNKVKvbi4qmHwtwXgSTQ8+XJM+ng9/ZH9Vh5E4UKN
	xTWfA9w4C7Y0aiAFIpzGN2GwtVnghx1G0E/J72ausBDJvtLRBDEuK7ypWN0m/J58Z+TEEe
	Rh9Eh9FWoWRFPvjR5XkI11/VG/V0LPITeSsz3/cqKf4wGPeh8og1euWxqBFnvA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:47 +0200
Subject: [PATCH RFC 10/14] dt-bindings: iommu: qcom,iommu: Add MSM8917
 IOMMU to SMMUv1 compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-10-f1f3ca1d88e5@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=939;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=+auV2xbHnH8Ew5XeZexktMLe4HULByqQHcRGhcce8AI=;
 b=mNOPhhrVpRQixxGld4RDKS/wBnAShh0zzApIWIZiN9PugJfI29a1VYKHo4+ninOR9hr+za1SC
 cm/glkJsPZDC56qJ7K0oM3IeIeQ/jnbgUgpqe2jLYDKQWaBwixRwiPH
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


