Return-Path: <linux-pm+bounces-16011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13F99A4D5B
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185F7B23732
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1F51E132F;
	Sat, 19 Oct 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="gH16FJTL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1441E0DE5;
	Sat, 19 Oct 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338655; cv=none; b=tzTt9G1+kVT51Cy1E7ZqACst1i6AGIcCskzfydp7HIo56DDc1JB5Ox8K6F9a8Ei8hKJN2F0iTIZXiUy79P5/gu/iJH+9jpqHw/Sdj/bk1gWGm6H++1pfZ6Ro/pRumVLVMDw4NxamC3PZA86QOiw/F8ZXGAWOXJb2XnLVG7wyBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338655; c=relaxed/simple;
	bh=u8x5Y76BpR7GHm0tcI8s42oOSgTRRalW68806GGcELk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+tDuEUGzuJIcjOaRJ857C9Um3QnQPonoPNxEdaPllPjfopk/LU2f8OS/BXayhoWb6hY+327RJfg0jT+peKfLqSDeJ66w00DQtEbXE4ggu9W3ar5Tjftz+Fd71nqiAXgb0JDWxZoAIwqxyFOZhTaAHwLD/MhG/5GSGT3UwHp9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=gH16FJTL; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 0B203E45A4;
	Sat, 19 Oct 2024 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3+UAizzWXsZekrxnLJdeu9Ruj4MIRyoNFA7cvKypSE=;
	b=gH16FJTLWMW4j5HW38K6k0StfWUvgA5cwGnDQITxWaP05n/4JCceElAkuEYRhrlXaevFuI
	6NTZT7NVYRm2uG5ZGW5nnG5nQgojg80TB+LkS+5Rw5IV4NP1ubL6g3K61kWyhE4ta3PvW7
	Nxqke26VTtOZ4Ayx1TZKhKjBOVkpxg6gDz8FlitUgTbGijrSwkZt3Prkv/Dz5KeJp9NH7p
	T3xQdmdVaR7lUQIQdDi/JvYvquIJgeU4vTvFRoXe3I1uZGxx5LCiOTu8UUgY36VGE59SF7
	LMlIncnX3TBa+IkSK/LSxU0BBUVm78nGEdAtPMEfPXiAUrtzafyKRATe97gDPw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:45 +0200
Subject: [PATCH RFC 08/14] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8917
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-8-f1f3ca1d88e5@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=824;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=u8x5Y76BpR7GHm0tcI8s42oOSgTRRalW68806GGcELk=;
 b=i+NdQ+S9ej8/pGzje2ajBDoOYtWjt16eE0oIprmWbmXEKq+IypS3/uIR7WP+TdJpDvDuOYJeK
 LUl/aoemcqfAe4JHE+SUImsB8TnS3dIFmAYyYVgb0EjdTPYcMwzdfQw
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the qcom,msm8917-tcsr compatible.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index c4fcf501f502724b5ca36bc4a26f77a00104ac48..79add913e35c848363941a8634a361c45d296392 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -50,6 +50,7 @@ properties:
           - qcom,tcsr-msm8226
           - qcom,tcsr-msm8660
           - qcom,tcsr-msm8916
+          - qcom,tcsr-msm8917
           - qcom,tcsr-msm8953
           - qcom,tcsr-msm8960
           - qcom,tcsr-msm8974

-- 
2.47.0


