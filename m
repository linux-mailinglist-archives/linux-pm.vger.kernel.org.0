Return-Path: <linux-pm+bounces-19574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F48F9F912F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 12:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401F41890661
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566831C5F37;
	Fri, 20 Dec 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="th839hc8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C361C4A29;
	Fri, 20 Dec 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734694032; cv=none; b=fTzpmx3cM91nC2fCKvs0+aP4Grti9F9yLG3J+1YP2IJbDMeki6dVZ6DkoGLJxIIbQjouHl/suBnxjL83loOPLSLOQDP2ZRo0LpC/i8ePrsFgSURa0GxKNrXud0K2GGL9eJRRHqwZ3XXQu04pXgcKcklr0VWHtVu0JZGbQ9dpnQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734694032; c=relaxed/simple;
	bh=nC/6B+AiD7x+c7OE7+G7e1enP5dQ8/O/fmP4XWnpiRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8I0PSqIlv5SbTriYWOM7yGI3/FvLq8uwndlaaWOHNXOXysqm1QVJ2yDBCvn3C2ZRT7k/JfCOEEY32zDGciJaKdBDJ02Xevnls0L4flpVkBBFNzARHi+JM7UmzAb43laUSB4FbReFRQ0YYbrvqUp4DPco07OFplz+oiiUoyZHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=th839hc8; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.30.162] (254C1A66.nat.pool.telekom.hu [37.76.26.102])
	by mail.mainlining.org (Postfix) with ESMTPSA id AEF8BE4837;
	Fri, 20 Dec 2024 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1734694027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kwYWwU4ZgME90LqS10gEkiS5e7P29TBeHupCmtlZ9M=;
	b=th839hc8hA9Qzsqs0PCOwn7KUqvZodAsGxJPjVJ4vBK+4fX8AaJERamZHX5xyP95rzP7Et
	BsTRLp9hYlI3SCClzjbade7wVMYhuPTvGQwJes52WtcUT9vWHSMT+6Htwu2BBYswPwGiAz
	M8f41CppwPO//6GlrW+W1H4wgP6l6TT0INgKWsvjXMOZZxkwp3z3Ya8LAetFulHfRDteeX
	kRtnxl5NFig6qT1vA/DwJB2OeDly4PkasZ3zXYF0Z7utFGffLukvXseUVQJlIpA6eOpWBJ
	mqdINI1njg0bfG+Eq6Tcz9aUJtCEmYe3izGTk+nQ6CZb5+C6t8sCJoNFMekDuw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 20 Dec 2024 12:26:54 +0100
Subject: [PATCH v10 2/5] dt-bindings: nvmem: Add compatible for MS8917
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241220-msm8917-v10-2-3d5734e8c3a6@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734694023; l=923;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=nC/6B+AiD7x+c7OE7+G7e1enP5dQ8/O/fmP4XWnpiRw=;
 b=1wCflirB+OX0hxjsv3K0HbNfKzR89h8sbxpc+HGSMqTvSUSkcLcQQkC+/uwMNtCQQrQSh8y6L
 biU10bKR50yBfTIz7gX1+LAqJ45nTG0cnScGz7F5Zr2bdM8gIAJQmPZ
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the QFPROM block found on MSM8917.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 80845c722ae46611c722effeaaf014a0caf76e4a..4d81f98ed37a3a12f01d444dbfa77badcc09c22d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,ipq9574-qfprom
           - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
+          - qcom,msm8917-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom

-- 
2.47.1


