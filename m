Return-Path: <linux-pm+bounces-17993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F69D6C28
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 00:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7342F281772
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272F1B21B7;
	Sat, 23 Nov 2024 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qetC6/l5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D21AF0A4;
	Sat, 23 Nov 2024 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732403635; cv=none; b=PQMGIx1vhTWJUT2sBgTzkTklRYS4glegk80Md2izODXpalcuLHfwk0TVPxIrxxVeAuDYW7+gLZAzz0uBXhn4aGT8+E7ogcJMiPB9FdsXPttu2ZU8Mt9ztB6CLaV4idDNAOiZXhQNkGynq7Xa269kT0hN0Nq7lduUH5FA7VWkiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732403635; c=relaxed/simple;
	bh=SvfaqqT0K+jOw0HyatB5RBuXUygT+zWZCMPud8wGRcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJojojtj1AAK/6pTD32Avo9auR6HSDjvfXh/a64Q5/tAOLlsyfL8kJEiIhrbPNDme4bd+V7junRfjnF2YWi3gX5HKtR9xF9N4vnDGM8BkEfNhhb+y4+r86TVszY2DTAGdl9wWZPEsXzkf4UI7ZsX0RfXv9HL6M0xYiiVsorQg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qetC6/l5; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.149.162] (254C22A6.nat.pool.telekom.hu [37.76.34.166])
	by mail.mainlining.org (Postfix) with ESMTPSA id E48B6E480B;
	Sat, 23 Nov 2024 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1732403629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrEoZ3ny7Ish/zBoQQacJtivJ1caeYwq1aEh/pTcz8Y=;
	b=qetC6/l5u/Fgx+R0U0duzMURqh++eg924V5QFU6+5L5FhYp+07aEi2bwg96+yFiaA3lkTS
	WItDOuYYt+yZU0dnSeksa6QqqkDsbM+CF1mjcvzIIUXonSLwoX+MAAtjTmcXOfRXL+nGC6
	T8RhKiOzccmJfmnqwarHDIt6beiDs4UE7HaIHZZJdfZBkMRG1mH+gKU929LzJHvGqatVV8
	OotZPojm0ux1a9AFm/m0xD8PQObRLSMdXxULVYmz2UThk+XrZgtFHGtppP9da8uXJvb6BL
	4ohoo7rs9pGCOu4TrWoyIVoBuwyd7jUTJqHtHav82RQ5ax7w5cKmihJfYctmsQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sun, 24 Nov 2024 00:13:25 +0100
Subject: [PATCH v7 7/8] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241124-msm8917-v7-7-612729834656@mainlining.org>
References: <20241124-msm8917-v7-0-612729834656@mainlining.org>
In-Reply-To: <20241124-msm8917-v7-0-612729834656@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732403617; l=1345;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=SvfaqqT0K+jOw0HyatB5RBuXUygT+zWZCMPud8wGRcw=;
 b=YjCXo8SW3qFU5SlDpNzTVxUdMyOuYnqCEFCqoIk83ImrZUvGgd4Off7sQB9I6PJ+hzy9q5+Uv
 fbzb9mA+Kn8DrGuzKpC95ngrhCAcx6WcnFvm/R3iM71u1fAJ2vu+EHj
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
index ca39903935104b1833c84c3519856e2a50d2d5b7..8ef564a4c7f1feac37eddeda55a1899fa3c5024d 100644
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
@@ -262,6 +263,11 @@ properties:
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
@@ -1187,6 +1193,7 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8917
               - qcom,msm8939
               - qcom,msm8953
               - qcom,msm8956

-- 
2.47.0


