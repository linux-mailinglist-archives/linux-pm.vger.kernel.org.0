Return-Path: <linux-pm+bounces-16784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6139B71A3
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 02:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABCD1C20E03
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 01:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684E84A32;
	Thu, 31 Oct 2024 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="njj8ReVv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477749641;
	Thu, 31 Oct 2024 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337601; cv=none; b=smaAXsaU3q1k0S7gfTIPLMFrQ5E8tCnUubz8eqtIGxPXHUS3ipAND57NbsYMUvwzkKLUYbSN91JLqoBJkpKkiytq2bbLLeALZD2DyWeK9ym8QK6SkF9JBmyi5s0a35fXvSMxlxhF/BBw72Wew3RkvrhvQEgU0vHWGrZlkE0h5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337601; c=relaxed/simple;
	bh=AczDvjjtQvU0Ios2VDrVwCdMZ4DLpXoYa3jXJ5Y4jEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5TtfygiJFGZrcL6dXSZ0Gxoqf8A4ERS3wp7ANPiyCq3otNFTPjqsX4u4eFQnaFzEsD3UWvDOtazyyuvdVkVkxV36CWMVHGKDcRxRggAqUtQ3/twcC/pkOGxYOCwfU/sQVq6RpL5WdcDS4ZHRe7KGp4x5PK0hbZwoaXmE8UTbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=njj8ReVv; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.162] (BC24936A.dsl.pool.telekom.hu [188.36.147.106])
	by mail.mainlining.org (Postfix) with ESMTPSA id 73FBCE45BC;
	Thu, 31 Oct 2024 01:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730337595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hw/rJtw/czkq6uxJajEJe89LGTzzvGdMuCvlculAbg=;
	b=njj8ReVvcmX8MHZVqUFcQBllJokOH8ORxqJ4FX713pl5y4OjzYq+aAlaRmVfTKNaweHwEE
	sxYvsaYCC9revnsod6mjvugsBeW56b5JfJd9sy+QlCklwNns6akx9qngVbYFlR26tMWZ2b
	xJoytvrMbCmgukdK6EfeS/rCC3vWMbXTc/GyxQUC19BXGd7zBPwrR+pK2OinhzqBGB7V8z
	GQ1TWMdABk+exk5BejODRlJK/vNs6tT9VMhVUe+q0tOlJSV916soFKEUudk3H01EiPQIUS
	Yh6gVsZNhB4cDDoyJrcBWoyhzqszgnuFxS4K0RDq08rfLjCC5tHfW08AXiTyGA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 31 Oct 2024 02:19:50 +0100
Subject: [PATCH v2 09/15] dt-bindings: thermal: tsens: Add MSM8937
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-msm8917-v2-9-8a075faa89b1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730337585; l=871;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=AczDvjjtQvU0Ios2VDrVwCdMZ4DLpXoYa3jXJ5Y4jEo=;
 b=3KNb+uCutuy54IL6MoKA7VsvpXLJGE+znYofbvCHBmlQejZc6t7g2ExjTpOmISWLzxb1ncWk3
 bf9FqT3Jl/vAZOXTVt0dw4VCQD9l0Nu1WrDe561aw9V11I0C7peLegJ
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the compatible string for tsens v1.4 block found in MSM8937.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index a12fddc8195500a0e7bdd51952a558890b35935c..f51656b672030b12ea0405fd392af11056093be7 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
       - description: v1 of TSENS
         items:
           - enum:
+              - qcom,msm8937-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens

-- 
2.47.0


