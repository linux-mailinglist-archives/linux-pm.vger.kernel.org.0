Return-Path: <linux-pm+bounces-16006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFFB9A4D40
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2281F21C24
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002AE1E0B82;
	Sat, 19 Oct 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Dzl/peBA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9B1DE4D8;
	Sat, 19 Oct 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338651; cv=none; b=NZLS9Vg6O2mby4OIeiufE8eDoWAtH0VXHfpJhMdRxmiFBeHnrxf32USV4jpu2pcauoE1dsQErS0OZqsmJ0jxDxBoCwpwDgT+82AAvbZnni6jtVnXr0yUrIcxs+z63ilfKjKliJUgw9J9cxKEph+QWQs2C4zSQ1gF2XW8NdOEHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338651; c=relaxed/simple;
	bh=WQ5LcC5dxomf+Jk8o6tbrfygW77imH/aaZDIzSsjPZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EC6dgiQQLSAHtZiFjwbXOruzNSrZ9RZA4TblelqOPGBozyxYtSLkF5C9+COWqVfVfyeU7K/hUgd+mUWzVAojyoS5HNQLoSNWWb4ECnoIexAOf96Z8e4cFZ1PE8lKy19EOXFNLeYid9UbR4j+luGEUwF4qzt17wcsNWh7TSoxe48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Dzl/peBA; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 8E8A9E459D;
	Sat, 19 Oct 2024 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8cvryaZPKYiI0Nyj6A8ssk4KjXnZlrTtmSMkN+/r2k=;
	b=Dzl/peBADOvEWtYvEcgR0HdIs230YvCiAK8U9ujq8ZuTSFA+qXTue7gg6/7JDF2I9FheEW
	MbRThb8thwZy6h2gAolyWffomDeg42fFJ+hKXamJ/4us8ORJtLiYG0pWyvVlMuK5o4M4cr
	nLEPnS2PAAPS2gsq9pTNDk7C5+OPMlbBGsmkyKPG6iKp6b5uA3EI2CmbddQc0GFGkLNBU1
	jNoX5wkrX09WHWGCVQmFrZQfvZkFPX/uE8mlURBadEH6hSaWSa3Uf85hm3UCzkzKr6fVlq
	sSZixrSBnzz1HoBwEKP4enVX8D0pu4zmjHm8n5MLME8sBzUN08ueuiq/hFvXjg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Sat, 19 Oct 2024 13:50:38 +0200
Subject: [PATCH RFC 01/14] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241019-msm8917-v1-1-f1f3ca1d88e5@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=1585;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=WQ5LcC5dxomf+Jk8o6tbrfygW77imH/aaZDIzSsjPZM=;
 b=f0IA5PHv7MnjhaEhvKgo5IuG1YbuSqNz+AQYQbX8T/8jJmY0r0y9k9sXToJfDUBhE1LF/Uw8Y
 2OE2FCXyCZiCM5zHZTqR3/9RraAOHiPTFes5Q0PRnRBvrUCtRc/OEP1
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Document the 8 GPIOs found on PM8937. It has holes on
3,4 and 6 pins.

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


