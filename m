Return-Path: <linux-pm+bounces-16791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84D9B71D7
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 02:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926311C2335B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 01:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7666A019;
	Thu, 31 Oct 2024 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="e7qXaZuG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE54C80;
	Thu, 31 Oct 2024 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338187; cv=none; b=pbnUqGkMmEO7KhLV3YSQE120PaIqMB660ZJD3gHLVCxlcPrfQFkPyKmhzuNjkUdz2x8urYxK/66QtbxQYx8MKv0lxGgm2sI4LsJ82rLIcHlFs0+B8wYYdUrv++u/iCiJYn+kgRw5MIKux1W4mRRQHIcpC/9HqUTgunmeJEZQEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338187; c=relaxed/simple;
	bh=WQ5LcC5dxomf+Jk8o6tbrfygW77imH/aaZDIzSsjPZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYKqTGdILznF4golxezW+lo48k+Y5ePOmh7doeGBfmyWQP9vZFFHzgA+lOt7r5KFdEL6XBbb0/BHHqZtXX5fjc5nb6mZ+N4MeHjrTjGa/WFu1sHEQPR83O3rbRWgpvGMLzvVL3C93BmplNhQn4W4wUx7pk7IP8fjGkOeR9XoZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=e7qXaZuG; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.162] (BC24936A.dsl.pool.telekom.hu [188.36.147.106])
	by mail.mainlining.org (Postfix) with ESMTPSA id 3484AE45B4;
	Thu, 31 Oct 2024 01:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730337587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8cvryaZPKYiI0Nyj6A8ssk4KjXnZlrTtmSMkN+/r2k=;
	b=e7qXaZuGpFVtoOtSkgjyW18FfufhX2sielhUaKqipUQwmnUgcnit0DxVxIEkeRgUwDT1qD
	zk4S+af1dxyPKQNVwXnauMAnoj6ID2fUx5fhZ2Sb6YnqGiU7fNMozbGI9YjX7p07WaAmpM
	iT345BV4InRPaJxK7rjl1Lur3Ff/Tym0hHkvGhSZSo/OEAbug0c2/dL4xiT5vsRRJDw0CU
	G9DxWHe8fjbqO3UoUFT1oMWFhAefcKApWc1j8SXO2RQ75M29TBZPKD7KdA/Tx44qjnNxyA
	5oZ+sOuSbZa5oH7n+BMKb/b7JhRvL4lfQhNDYlW7I4mtILrY88MMNEuCwUj69Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Thu, 31 Oct 2024 02:19:42 +0100
Subject: [PATCH v2 01/15] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8937
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-msm8917-v2-1-8a075faa89b1@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730337585; l=1585;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=WQ5LcC5dxomf+Jk8o6tbrfygW77imH/aaZDIzSsjPZM=;
 b=Y/IeWw07v0eJaOQliyWLZxb9IciMETlnPtNA9X++Fc9/29pffIxh+jQqEI9q1Wwjc26CIv8Ij
 dzUtiiRfHitD0pMrkeWLJODg8bc4uwiJc+EBa0x2jqUtwmxRtRDA3u+
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


