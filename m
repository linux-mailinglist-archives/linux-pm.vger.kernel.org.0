Return-Path: <linux-pm+bounces-19252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E11439F235D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4861886517
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B918FDD5;
	Sun, 15 Dec 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="mzObtnyU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F080187876;
	Sun, 15 Dec 2024 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734261345; cv=none; b=tsX6U8G6GPWFAeB+QoBBCxnodYF3U7/1GTZIMsQnSafhFUzvOPVm0PTDuL/Z8EJwsC7Lb8f0gH2nqB9jCxLCu2oyjhutY0quZb6J5ZDQ3z78S+EzmYZH0fyd130TfBZObwNPazRNX6Fp9NoguQF/vDqcg8h1TB3hbN6qMfkkpu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734261345; c=relaxed/simple;
	bh=Y++CNUqzjXWsPf4Zcj2fLzVqAacF4Z85g5UXnE+7d7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHVjxziGt7lzJ7WwQEFK/DoP+14MPxwQXxGXTgNwRzy/9pinfzjFSORroNGT3q8gJsMJdjmrb8P5gndg83m17EjHMqSM4XX8VzZWmaPLH2Vva15g2lFy6WE0VKbf4nzs9aqE08WP/pkBq2UMaCQFWRdkSwLwP4PTC/PAje7xUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=mzObtnyU; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.220] (catv-176-63-31-221.catv.fixed.vodafone.hu [176.63.31.221])
	by mail.mainlining.org (Postfix) with ESMTPSA id 670CFE4830;
	Sun, 15 Dec 2024 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1734261336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aToYUm7oAK25LLaBmzvxvxGndbFyAE5ts9xwrCvSyxk=;
	b=mzObtnyUaCi05fgrUk72M84bHwogDYPnZco02mNJD43X3plcAWPht3MVfysVugJkt2yZed
	M7kqgbywZiD1Dt7695d5WG1+kXpC8zJQeVOAbt+7HZMWJHuovSRxDONbNMrpSfbgQ4Nzw7
	X5BMx21ioH7nl1nBqg3gIUm7VE9x+HcQXs+SEGirj7MvZfiu6RYV0nElbAXdGxd5TYeZoo
	MIw/lmICLuejRP/Nm1YYXNltYcw7XvnuC2BOBb8VAk1PccT05dTn10tUTPkyHmnR5fP+Pb
	qsBP/bYsU1hRZjKpo7EAIZEiErU+Xs/YHeHyENmeQlOoLuP957YOo5MKeU8UUg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sun, 15 Dec 2024 12:14:59 +0100
Subject: [PATCH v9 4/8] dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU
 to SMMUv1 compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-msm8917-v9-4-bacaa26f3eef@mainlining.org>
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734261329; l=1003;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=Y++CNUqzjXWsPf4Zcj2fLzVqAacF4Z85g5UXnE+7d7Q=;
 b=8d+Hy56cQX6bG43qMGNqciHmHJuwGJJGIJ9Zjs9KiP3wLgfC7ipZDIM3+cAHF8n7QHoJiT5D1
 mAcfX4AC7AGDztjsVNgSh1qTW5R7t6QFFlivz+5PibsH2QJH7o0CVw3
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


