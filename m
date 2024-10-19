Return-Path: <linux-pm+bounces-16009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253259A4D4E
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC21A28357A
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFAD1E1026;
	Sat, 19 Oct 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="AXY6qiyP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B561E0B66;
	Sat, 19 Oct 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338654; cv=none; b=ayZvYtRZ1Vo2HENdEm2cRJ5Na1bHQBgiFkxaYRx7E+hiuj800Ro92G2+xudKHz5nZbE+w6+5Fu6VNkh/hVEWnull/a/l2opwCe5GseDNhPY8nlgZYLKbJGn+g3WUTzufinghUbu7Oh51MVYgUyQbcSqqL988x1/sW8umyLBpQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338654; c=relaxed/simple;
	bh=kANJbusz/1wsoZAzBf9MgUzpPoVv15jJLK4rJBNHHIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aitDxMCUExKnCXvBakLgPWiFvxN2VsoPdTbww4CTNM/ZBdTUXeGXcJ/+nAzhK7kFd7CY5pRykhRdIgBZ/r4bCf+p0fau6zZfSqHPvGiy5Lg1TZMU/IVE+IAayUrgQFCJ2kHwX0Ff6SM46ZAp2ZHmCx5SKdYjk00ctR0LLAlcN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=AXY6qiyP; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 1CE55E459F;
	Sat, 19 Oct 2024 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoFhgvV9a9kora5JIHDRkULnX8QqLWjcJwM1ZxNV22U=;
	b=AXY6qiyPCQ77l35uzMpOoiDG70WUJTNJidpdjX4Fibi4TGU9Ga7KJDrbNKDREcJtPCYjuJ
	eBrb/fYje/P/UWLHlzcFyIki5mhExUCrNrWyth+QTLnoC1pg+n9gXtdaS2spf4DyxCysSY
	kbOmmrg1XNPYRpKEA1thMGXP4sC/HGh/EQeCq0gye3H+9WjfGJ26MV3mYPpuisG2pPVjpM
	lpfs1s9YHQ800yUQGRzWDCh6r13UA5Q5/WQdNb4KlvdjRRaHIzVGtInJKvSnmFjjM8rTzQ
	g35lNbhL/tDQ8eCIr4WN6wDi/qscnngVyhA+Lm/jEJxzjdP9Y68UxbOdzSnRaQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:40 +0200
Subject: [PATCH RFC 03/14] dt-bindings: pinctrl: qcom,pmic-mpp: Document
 PM8937 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-3-f1f3ca1d88e5@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=1209;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=kANJbusz/1wsoZAzBf9MgUzpPoVv15jJLK4rJBNHHIw=;
 b=Lc6quThl4hMz+nKEIqPddVDf0/5bSQxarhJmpvvTABs2NAA8TgC7b77d0PQqBTZ/kYBjgch3v
 eJNCvtHQyNLAyyC7qav2Ff9TLwNTbNShKe1MG7e0/6KqDES6x96rQ3x
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


