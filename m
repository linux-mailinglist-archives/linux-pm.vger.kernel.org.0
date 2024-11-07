Return-Path: <linux-pm+bounces-17128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B529C0C25
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 18:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AEE1C22546
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110BA2170CF;
	Thu,  7 Nov 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="vQLC87CU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30610212F0E;
	Thu,  7 Nov 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998983; cv=none; b=P8XwAK9iiKf8L6gJpWor4Y3s5Ib2Pp1wwZmgj6R5OYlGvF9Q0qd4WnxeZXnhP6/C2Bpwf126zOwdzIxPlFyIT3X4ogWqinhXu54MRN8JaZUAwdRRGzW9ESxCQoRuh0iskqJSliO5DpCztNG8JtDdk4sfsFPt6JuTQqQ+WLHoUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998983; c=relaxed/simple;
	bh=LkaCWW3zjWDLBVsp88RQzozjsFyLCaGPD6+VtFvGVDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsfJG0J7woHy7/bcXQ1L2vrG5c4YDvCSSjGNANv8pO/ZX1TL0LF/i9/GhPAyKNxP43Q8nAYocEXlo23WBe16BiH0kk8u3BAlj4ja19is5nEm4mme5S37w0RBOmSL+KfmZk6bGWxZAKYzKIbzZNpLejCyfQzYUklChjJMrUHBhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=vQLC87CU; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2715.nat.pool.telekom.hu [37.76.39.21])
	by mail.mainlining.org (Postfix) with ESMTPSA id 3B27EE45C4;
	Thu,  7 Nov 2024 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730998973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ekjj10oUzQBlH9L8yVZcgYXaoycw+VSDrJGKyzti4PA=;
	b=vQLC87CU6N5c7bhxWXElqejUGzteRP/76CMzXnY8IRUF6lbVD6+p363GTxzKGCnnkDFfQ7
	qcd25bsIvn8+0wz6MQ2v2wiRP1AmCyjGyvn5dseM9TyOr/Y6D0BgSq+46HRZ6JYF9t0IpU
	9RsKre49xV4qU2mtgyOlAGPxpkYvt5YFe78oL+hfeu4MN1hQLDVlj9NfgBq+JUiabbKMXf
	t0r+w7kt+zQ5vmprD5bZ5u0beourNi/FAjjuPPBJZ6z1J4gZhEiqqi6lcxA51XAg7oTjir
	/TjY0FXG2em4lS4sS8JLrmyh1VXtBt+u73+YYTqiTja7i/BvHcFPOggkseHiUQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 07 Nov 2024 18:02:42 +0100
Subject: [PATCH v3 01/14] dt-bindings: pinctrl: qcom,pmic-gpio: Add PM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-msm8917-v3-1-6ddc5acd978b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730998970; l=1652;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=LkaCWW3zjWDLBVsp88RQzozjsFyLCaGPD6+VtFvGVDI=;
 b=IfpEWFE5Bv23ghs5uEmHFKDTzOV98RKqVrRW9GAj+hGddknVQoW7SpsBR3S0gRJ9t4ZiW792h
 R5TVIzSlFjCDyqHHAw+eeUqBto+iw8yJXvrMrrhvcRVfGNRCI01DoSW
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the 8 GPIOs found on PM8937. It has holes on
3,4 and 6 pins.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index c1b799167d81b0b4e1edff6a6fce557fa88fd1ea..055cea5452eb62ab6e251a3a9193d1e5da293ccb 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -48,6 +48,7 @@ properties:
           - qcom,pm8916-gpio
           - qcom,pm8917-gpio
           - qcom,pm8921-gpio
+          - qcom,pm8937-gpio
           - qcom,pm8941-gpio
           - qcom,pm8950-gpio
           - qcom,pm8953-gpio
@@ -184,6 +185,7 @@ allOf:
               - qcom,pm8226-gpio
               - qcom,pm8350b-gpio
               - qcom,pm8550ve-gpio
+              - qcom,pm8937-gpio
               - qcom,pm8950-gpio
               - qcom,pm8953-gpio
               - qcom,pmi632-gpio
@@ -468,6 +470,7 @@ $defs:
                  - gpio1-gpio6 for pm8550vs
                  - gpio1-gpio38 for pm8917
                  - gpio1-gpio44 for pm8921
+                 - gpio1-gpio8 for pm8937 (hole on gpio3, gpio4 and gpio6)
                  - gpio1-gpio36 for pm8941
                  - gpio1-gpio8 for pm8950 (hole on gpio3)
                  - gpio1-gpio8 for pm8953 (hole on gpio3 and gpio6)

-- 
2.47.0


