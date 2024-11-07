Return-Path: <linux-pm+bounces-17134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4309C0C44
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 18:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48CCB218C9
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6CA218327;
	Thu,  7 Nov 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="kEDdVhZX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54166217F29;
	Thu,  7 Nov 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998989; cv=none; b=OZQcCxDOZChnhOVsMlkHmhmodvB/TRUyf+V1PxcOp55KO5kcxOQFPT3WKbgaUkTOlHewn+AcYfI2WcQvo91v7WjImBqQSMP284KG/cxAfuk7LUYPDIOKqIN0eTuMjBEa+zEzKMBN6g8WThI8jACGDv5ys/G30aDd9Ezb9gLr390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998989; c=relaxed/simple;
	bh=HpsJRRqcEB7ubb20AIGzwyE59bS3PSN7BTK6n02gdPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=toq5o8fPic6WL/1r3p8xLtxYAv1xTL7whw+q9YpmqMAtvWmz0wSTd9TWhLdrKn4aBPktnWeWzWu67lxA+4qYPLPTk2HiK0HwCdMhBUq+Ju+gyj0D2V4hmV2gwzBWLonIyvcZJdiJPurPDmSV25rt6nRYBMxtVGHlcXxjUtjNVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=kEDdVhZX; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2715.nat.pool.telekom.hu [37.76.39.21])
	by mail.mainlining.org (Postfix) with ESMTPSA id 7F515E45BA;
	Thu,  7 Nov 2024 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730998984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJVsYRZf77zXzY1oz4aX5qV6KoAi5dZCp6QEtJjBO5E=;
	b=kEDdVhZXNK78WFQugHEvzi38i6K1hfYYZ5AdcV9j+M1iz6xGKGobgS7XIGs2SUi39dXWqk
	ZM1bu2VtQZ3QLEZYSWHhKyXPQjCfKxDLHYGB3U4NpbbZW48SOrvnBrnYzCLQWEDK6e6gIy
	WwhMWAxH8mX5jdbOCaAH9mgmNUN1loArrESxIe+rHCcNyMz/eN9F6EI9DV5qNU45RISNSm
	TnbeOkC6Um8hzdkISRM3US9LweFRkoDlIzX3D9sAfVTjW4knX5SS5fdIZOzv0HBsNeADQh
	gBnLIFGGfV8j4+YrEAce8n+4r9CLlsogxBOUYfC4fKZ2eiW/6KtC7szJWx8aqA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 07 Nov 2024 18:02:49 +0100
Subject: [PATCH v3 08/14] dt-bindings: thermal: tsens: Add MSM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-msm8917-v3-8-6ddc5acd978b@mainlining.org>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
In-Reply-To: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
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
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730998970; l=935;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=HpsJRRqcEB7ubb20AIGzwyE59bS3PSN7BTK6n02gdPE=;
 b=cGwGyNO8XN/GQLArpKASfGZHiyWTyIaZIA9bC6H45VQ+wd4cQHvoxBAWGmxbKjQI31v4j5AXu
 cmLOT5488zlBVLWP4B6GTFpqYlaixsNUS8PTl9Ako2h9s45FHMAnEFn
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the compatible string for tsens v1.4 block found in MSM8937.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


