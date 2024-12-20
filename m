Return-Path: <linux-pm+bounces-19615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D119F9D29
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 00:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002821895C6C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34265229144;
	Fri, 20 Dec 2024 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pn7WjGOt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7E228C9E;
	Fri, 20 Dec 2024 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738076; cv=none; b=n4/leJmeKEQEMNE2bsfBjvXhj/CHXCjt0uY6VXDCY4euxoSHvRVXHPEuM+4X17SYdq0rNX/UpgmSgyR0AxAbSJa4tZJ+Y17eSHIJF+4cNaErgwU79GhJsuX/F9tncJxqw4qodov5TS+S4CM5Qu4DAgKTez/tMPtjk6NjD5Mkv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738076; c=relaxed/simple;
	bh=+8lEVMWw4obCV6Aj343SDrKXfcdizMCArJdr+FobTrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpH2Vtj+czsZcJab0QwQhIftpkUKltJutQ/QfDX7UwbbWXW9fWFn/kg+N7K96+GV/HerlbPyZ+F8H0QL4X+bh5qr5qGMBzFkHJ4cnOoMtMaSIgNtU+TiOXFBMlNPo/1YdMBbBqV9XGNqm5VihJ/RDoBq9y6DEoJ/yI0L0CJHils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pn7WjGOt; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.30.162] (254C14D2.nat.pool.telekom.hu [37.76.20.210])
	by mail.mainlining.org (Postfix) with ESMTPSA id AA64DE483A;
	Fri, 20 Dec 2024 23:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1734738071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEZixsrVYC5N42npda3u434fskPdLWwrhKEK+WqDQl4=;
	b=pn7WjGOtXXD6ck4f8n9SINk7sUqviIViDSs+GTEfK5Y+47Et768wMy4WVaxcAEKEVJpXJO
	U8S+ntXDsY8d0P1xgcSB+0iogYnka22/GTciQfrQq2M8Xs2jwcoVOVqj/czJhylHIqD6lf
	zwsCnrtg3P27v2+5LJ48B8AzSCWz7fYE1FiqITb5lgM8u8n/AdIqopDR/VBt4kQEEQkFA6
	9+b+g5ZE+AaNlvlKes+tWX/SQpyGL05PIxPLmALeS1u8NJ7pW3HJUUmgMy/ufNJhxcwekE
	iitNq9jiEDsYwYVV9RVx0xDXADkG3mLU5pD3x+cvooAkyowTAadIaVr6gOddgw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 21 Dec 2024 00:40:50 +0100
Subject: [PATCH v11 3/4] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-msm8917-v11-3-901a74db4805@mainlining.org>
References: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
In-Reply-To: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734738064; l=1345;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=+8lEVMWw4obCV6Aj343SDrKXfcdizMCArJdr+FobTrc=;
 b=tkGaLUewfKMYG0LYOl4ZhhdlZWu2uUu3bFUwbr2pVnAUXgXspmusIx7dLCXbCq9uP2WhAG8G7
 S4lyJBBKno6Ch3tRt3VgVnqY/C+ItizkyJW+nsSZ+UqHGNzGzKQ6nW2
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


