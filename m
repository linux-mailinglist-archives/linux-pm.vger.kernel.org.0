Return-Path: <linux-pm+bounces-19575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAF49F9134
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 12:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9D01888072
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245721D31A5;
	Fri, 20 Dec 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JZsz0BRk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890531ABEB7;
	Fri, 20 Dec 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734694035; cv=none; b=DCYlKWqc7hYa2qSbQEQLrTPTET1FGTjPO8VI5gedmDyKDSlSKci08OoKa8sbp125MBGRpqOpFrREH42+CfpVHRckkJ5D165ro7zQoG9R61LoE+5km/hH01Xm7suOXkt7SAm9+WUDZPeNKliL8wUHkjLS8im8vGPDx1Sk84GP6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734694035; c=relaxed/simple;
	bh=+8lEVMWw4obCV6Aj343SDrKXfcdizMCArJdr+FobTrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rth+GJ0SsvxZm1RBMxGRhWe8gl5i/kQAw57aeRdzil9L4oEKv0xCojPkl7RfsRgDK6nwDMoe89eHXP71XqbID2UJVrOHfe6U3CKh+jutYg6Mal1If5Yi8wtdlLbRRcOU47dc+qXLtMLaowm8K9TEMkdx1ty4KYOwM4iAVaIqCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JZsz0BRk; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.30.162] (254C1A66.nat.pool.telekom.hu [37.76.26.102])
	by mail.mainlining.org (Postfix) with ESMTPSA id 9C5F7E4836;
	Fri, 20 Dec 2024 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1734694031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEZixsrVYC5N42npda3u434fskPdLWwrhKEK+WqDQl4=;
	b=JZsz0BRkNqDWYMCFzImUGchWFY+vDrfyE2ZqzkiX66GoNLZnu7HWB6KHvgRQ7XOC1KrzXG
	Si7J7z3t+uukNX3A4MonTxw87LrNimid3a2EUJHTtj2vrsEDAwBmsJWYw79p1AAkORm7NY
	R2/UuzjC0m6QQsLB1aA+serc+6SA0pZbLCZOBDqCTPJsRWYX/wp0UAUEge2kvPBPQNiP7C
	65KmL6ZiIWmuWi9f3B4jueb25Y4+9W5xUuuHAQEYh2noRGR/b2+g0bTcFpGug40M5I3sje
	RXT7yA7V2h5IAM8RXE1yTEi+hmHAi73W1gn4h/qCdzv9K9U5lKS1dyvRa8jkYA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 20 Dec 2024 12:26:56 +0100
Subject: [PATCH v10 4/5] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241220-msm8917-v10-4-3d5734e8c3a6@mainlining.org>
References: <20241220-msm8917-v10-0-3d5734e8c3a6@mainlining.org>
In-Reply-To: <20241220-msm8917-v10-0-3d5734e8c3a6@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734694023; l=1345;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=+8lEVMWw4obCV6Aj343SDrKXfcdizMCArJdr+FobTrc=;
 b=uMr+WpxMfeExAHz0t74rm/7VXCcwRm1MrjoVoJf3fmlI3GBQmdeyQXzCU4jISskoV1QTUDWah
 Ix9bY2B0V57Atq1+LaRy/8jXgSdJjBasO9ARoT23ifdPfVj5azqgve1
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document Xiaomi Remi 5A (riva).
Add qcom,msm8917 for msm-id, board-id allow-list.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d394dffe3fba5a396b85a6093f34e9ef62b6f9cc..fa5e70cee0c6b7cc20f49005ebced0b9389ab910 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -37,6 +37,7 @@ description: |
         msm8226
         msm8660
         msm8916
+        msm8917
         msm8926
         msm8929
         msm8939
@@ -264,6 +265,11 @@ properties:
               - yiming,uz801-v3
           - const: qcom,msm8916
 
+      - items:
+          - enum:
+              - xiaomi,riva
+          - const: qcom,msm8917
+
       - items:
           - enum:
               - motorola,potter
@@ -1199,6 +1205,7 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8917
               - qcom,msm8939
               - qcom,msm8953
               - qcom,msm8956

-- 
2.47.1


