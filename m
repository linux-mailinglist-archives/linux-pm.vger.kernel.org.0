Return-Path: <linux-pm+bounces-16016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC69A4D72
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CDEB241D0
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CC61E2315;
	Sat, 19 Oct 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bkadrJpX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79301E1A05;
	Sat, 19 Oct 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338658; cv=none; b=hfYYoBfn7DsDm/AdvaUgNzlBsilFatWfiEqb2xsFhIofUO5eZiPUAHtgZlecKM9qjRcZw/NRQq5SvfiiMWiX+qHmd8Afhz37FF5IihxWV6Px9Aam000qNYzv6EJXbWu7J1zoJk/v8Fz9viH8LukJHcOaJqCAHZhNbscW2IjrBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338658; c=relaxed/simple;
	bh=2nPuAQAvXP8Cx7DIAPS1I1Ekpq+3eK6gff1nwVFbJG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfigfPT2j5YgfzNK0/eT9iFNiFXLoqJkf1n7uxkHz+jMzoOqIVOUs21kshebQuE/LxHtAMlOlgKX15ZBVby/8LUKH0jfknRfXpdCSZnYOUxI0pO6oEdaQGpu/djkWSjCb9x9Yhqrp8qZ2NnQ3jCNl10osLOy4tCND63XZ6CkgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bkadrJpX; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id CF084E45A9;
	Sat, 19 Oct 2024 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWQMQa89WI1DdQtCFYAl2tQmrPPsbbO0kBTe4esXkms=;
	b=bkadrJpXo7jF1loZpZ82CJWsQxSKxCbRCq34TxJd0owwJgk0yj+ZL9ShfsonuDWjWHjU60
	EIZbeM3D5WXtLI1opMII0gjitL0hforW7a+nNahfAEakzwJPM4n6bNXkNlWVza3ufuT3Su
	vH0nDeVINuEQyHe+A0QK2znePxNKfx1HQM5dRNPlS+7dTQ4l0FzgtZ8xOzF27dXPDHnDIP
	9IT7CUA44iEzX6ZUfU6e3/3u4XVvwE9UsbEjpr/9rgwfPbL0SDJmQ2SqWwfg3bkzjkU7Xn
	a1fcUjIKKGLZ+u/OOUN922U0rshRaAsZcWGYefA2AhiL+Fe03MhzoU5Am9z57Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:50 +0200
Subject: [PATCH RFC 13/14] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-13-f1f3ca1d88e5@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=1227;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=2nPuAQAvXP8Cx7DIAPS1I1Ekpq+3eK6gff1nwVFbJG0=;
 b=kos7Z9FVbRHIVmbMRJdwDOMxeR2dsNnvYeKv9GB9lndF0p5UmbG9AqShRIkmCb2KAPhmA0lGK
 XPmOpb6AEaFBqDpmikFlmwM7A3M3257IwActlhEW9OGyyNUkD5Xt6s8
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document Xiaomi Remi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0d451082570edef9f2f80e2c7544a953eebe9edc..0d545a1744662df6d3c17771ae3cee80c89fb281 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -31,6 +31,7 @@ description: |
         mdm9615
         msm8226
         msm8916
+        msm8917
         msm8939
         msm8953
         msm8956
@@ -248,6 +249,11 @@ properties:
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
@@ -1144,6 +1150,7 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8917
               - qcom,msm8939
               - qcom,msm8953
               - qcom,msm8956

-- 
2.47.0


