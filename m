Return-Path: <linux-pm+bounces-16787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FDD9B71B4
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 02:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7806E1C21443
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835613A3FF;
	Thu, 31 Oct 2024 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ZufDzBoh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48098121F;
	Thu, 31 Oct 2024 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337604; cv=none; b=oeCAd1Ij3jGMPM7/SzlyzsqQaQ6wgOO562b4GN4zGVjcPtOgZDsmBvkJejYut+M4v2iN4Ei6rQj/j6YT39ZVvDZe/vq4AqAvhIh6VJlDiTurhUYte41F0E+f6k4ZcIiiD6DWvUWZf/fBBuXYq/DVbzv9cjy7guN3GhdThOmHOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337604; c=relaxed/simple;
	bh=6D5H41ec1nxegNJadqc+rZUly56/XsNie7MblnUEmvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAlXfdNEy+/zokbhCwu7skxzE+9t5iugRHWB5BiE5zrKSWCcQgFW4Kxcg/Dw+TSGAZS4FUePRnABUaiNaWS1MO7Y0plP32C7u3kau0je2i+SvqcaZn1b97sjHFhD+EjOmR33ka8OeQbYcX5oYdMw41NmO8tZahZOeRngRmTPTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ZufDzBoh; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.162] (BC24936A.dsl.pool.telekom.hu [188.36.147.106])
	by mail.mainlining.org (Postfix) with ESMTPSA id 01EECE45C1;
	Thu, 31 Oct 2024 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730337598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8IfF61PQu07hVmfK0WNYOSRAQysImCvF/TIxJswNzA=;
	b=ZufDzBoheUX2GE+0mraN7biJwXKLhCd/5voVuZHRGqJoxtnw6WMjgS/xzqs9LVZFCumw3e
	KkFG9ZNIdK0+H8Cg5Xub/igNhrrm+0mKGNhT/Gbq4ykjgX7J0YqYszh6/WDJj+MrABRj1Y
	TUxCa1ZrjyESlKbStvjyFpFjvXzPjeIq/jPt7a60snhGrC2LfoWUeW799qrKkS0dyaN3/+
	9bDwsWV3hF+65hoIyH8v/mggeD5maNWlK3gDZScbvdkdiVDAghOpqyia0bfe/auRacKI95
	xiNkH76yIMgfL5CcWmrslYzoq1EzJWb8YKcOTJdjNu7j0HTn/amsy9ys+ZssjA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 31 Oct 2024 02:19:55 +0100
Subject: [PATCH v2 14/15] dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-msm8917-v2-14-8a075faa89b1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730337585; l=1278;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=6D5H41ec1nxegNJadqc+rZUly56/XsNie7MblnUEmvA=;
 b=FCOHqgjb6FhZ/VogC76To/Pnf6gwp2BmZEHQG2ZOxBf8eFUOU3NSjBvEySOZh397CDTC720ld
 E54FcWVqJ+6AnJBoiUdMP6EiCO1f8P/jx0e67JYGo/LF9L2D5x0DFRB
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document Xiaomi Remi 5A (riva).
Add qcom,msm8917 for msm-id, board-id allow-list.

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


