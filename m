Return-Path: <linux-pm+bounces-19055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3CC9ED45D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F81188A633
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 18:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4B82010F6;
	Wed, 11 Dec 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Zj4rjjRt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA461DE3B5;
	Wed, 11 Dec 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940287; cv=none; b=qvoxDCFVpeXFFOGyiQMvB+WoCOsF6J30H1V3TJZJVWBlWJIU28EvtJLg+h6Sb9kv29cKm3TnpCypoW6/bk//qwWGzd8uu8kiuHhXj+LjNyTkwhH3JXnm8O+wRh+A555I0I8s84aTo1zFWtzKpAddA9qbbA5Im0ESI1vyWGazQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940287; c=relaxed/simple;
	bh=Y++CNUqzjXWsPf4Zcj2fLzVqAacF4Z85g5UXnE+7d7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQF46gnOqh7roUlwbiX8z7XxUQudNuBUAmgivTUx3cBP9cz4F4FbVPP1eTeUSJJEU+pSo7sFU/CpzIEVO596FeQukMlZqO6poLmyL1GWXQjtUcKYCkrFa/yYGuCyQFyp41bMfH6nW0dFkAp13ajMjKNgZF1aibw7H4wc9AdJ1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Zj4rjjRt; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2319.nat.pool.telekom.hu [37.76.35.25])
	by mail.mainlining.org (Postfix) with ESMTPSA id 963D9E482A;
	Wed, 11 Dec 2024 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1733939956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aToYUm7oAK25LLaBmzvxvxGndbFyAE5ts9xwrCvSyxk=;
	b=Zj4rjjRthnxyJVJvJTIsdBfqTXoQs6fzZePCyHQ4BupUcQGQ2dgVgjdxCSZ7IWqIaIYT7b
	5Qa0sYIlu2k0rrLgBNh/KdN+6hSfxraWC0Jk/o+PNzkKf5BFb9vUORR9/4ZiMfzm/z1a41
	vHGy2AKrWMl5hnu92TQtXIj1i2Xk7LAv+APJOOmYLlT+g7uWhHP8wHFdPVMiVCwKT5w9nW
	kN7tISnj3LDDxjdeVhagmr0hNcME7pHMUhAkCgAvl0tajzXxlZIGoMUn6JVl2PhieMKmVl
	I+aSxfzk9hkIyTbOxia3BSoZsjv5WtU92n56BWFtr9Me0uIcFnknEoOv0mthIQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Wed, 11 Dec 2024 18:59:08 +0100
Subject: [PATCH v8 4/8] dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU
 to SMMUv1 compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-msm8917-v8-4-197acc042036@mainlining.org>
References: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
In-Reply-To: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939948; l=1003;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=Y++CNUqzjXWsPf4Zcj2fLzVqAacF4Z85g5UXnE+7d7Q=;
 b=D5eoN3JIN+8u2AC5aYzTe5SLxByJSF6uQUlxbdUKPnOadQ3HOre/luuCjSDcsHwUQcUZpsjnc
 VTBRgvWjj9xBlX/P8Bf0nBtZGcX/M1J7bkyt3V19P3JW9dTcKkXzKLi
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
2.47.1


