Return-Path: <linux-pm+bounces-4810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9586877156
	for <lists+linux-pm@lfdr.de>; Sat,  9 Mar 2024 14:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C281F2169B
	for <lists+linux-pm@lfdr.de>; Sat,  9 Mar 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCBA4437B;
	Sat,  9 Mar 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQyMCZLH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49C3FB9C
	for <linux-pm@vger.kernel.org>; Sat,  9 Mar 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709990118; cv=none; b=Go49xGvGg+8pftSH/hJ1y5adbP6BycxGISNqp1afL7SORfLQafrKZ4VywsIsofyMquyLq7D6MJgOf3OBae4Pj9inAGmDIfeAgyMZwkMHn98hbb89ySHUq1VfgrQPEm4LzsSjUAiDh0yYLH6yTJ/H8cmOKcsjEUQe/FvwgdZ/nHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709990118; c=relaxed/simple;
	bh=jrOFTMCntFqOIhBMm68qr8H/xgDF3gFVfyHkGoBalZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dzz4djX4gFEsezFL7mXjI8HJltcQIj0/xdRcqR/tUwC0XHqN3SGlC8laNYHGwsGBVK48GsJIWibDTWdo3Q7gB0BWbVs0c8xcLfsTltjjast2JXKGPfeb+gxIgHjcYQadaH6oOxRTJp5CdRiuholhZ+EeOV0BySKsmYYbL3T7xBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQyMCZLH; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d228a132acso36392921fa.0
        for <linux-pm@vger.kernel.org>; Sat, 09 Mar 2024 05:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709990113; x=1710594913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6Sple/2ZZdRH/Vvx8i+an89/boBf3Gnas4pdauUz+A=;
        b=rQyMCZLH/0Y8iNXsgiLKozjRB9cTOEPaLEvPfhgVEQg7GSNqBu42fOXQMFb4qfSgdp
         LEQ3/S5asMFU8m/U1TV0aVEnAbuSnrVBYgP2+AM4X1nJ7WauZDALRxk/FUMm5HSo1V3S
         Gavj79o3KaVTmE2uUYBBLPqyTZtFHSQI/TkprL4boIRvdtQmYd69NfnryED6IQbXu6zU
         Dse8A9vGFujqqUO22uI2TPa8E5DFNGe0ABiOTueB5MD8mk1yUfKgfqKhDaCdSfvJmwng
         grnKf9yDzuQky4FMRaYALZCSoWjc0+R9072/6xPCLeLDij2pm/kCodzvJtUsbEiRfl2A
         AXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709990113; x=1710594913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6Sple/2ZZdRH/Vvx8i+an89/boBf3Gnas4pdauUz+A=;
        b=eMCrkfMk8yPtqnccGfZ4A14dDsJjVLrAMkAexTzGZlgyydD7X5o09+yltRXZhRgDDe
         8SiDLqEgRdp2u9Q/IyOrYhqLnSgWRgtwsiAtC4hV4UCxqbT06VMo8Gv9r5eRbfRYaEy8
         pG3l2QRoRYMJVway+4B64YaP8qUH4l1/rWhBZhKkrxzal5jFedxGF07NIwBt9sYxQEfD
         mhoLGCyHx1+2Dy/UKve0PR3cMFJZriMuJgM1HlASVgOTIaphwo+KTDx8N9qQ9a69M5fg
         FUARqAgNsX4NR7bhovRPkpZ3uYrlLtWneB5yR6UgA071sftGna7VKXTQD/Hf+70nm6em
         dOQA==
X-Forwarded-Encrypted: i=1; AJvYcCUl4zdH26DaP7uZQG1ksl87FC3QhEo04dtmG/4sMU/eXuo+JYk9LZOoSXzRASTONyS4BkTNlAlFsPvksHlPXfVQ/S5nN6yNRhs=
X-Gm-Message-State: AOJu0YzKF3UE1aDAqlGHp8xRhdVwAEJMkhS9rgdWm9PWXzKV41OSlMfD
	+m9OIPm5blZ1NgAWRGDf/GvmYyteJQEZd1tqB0a0kNITreOEq+yB1dwBnYDNeaI=
X-Google-Smtp-Source: AGHT+IFJLAytUkHELZ+tKQCNdstE4VZYqgVMmbL7iQAZfoMj7LyG8cr60snwA1EFoIGHOI9j+byTMw==
X-Received: by 2002:a05:651c:104a:b0:2d2:a3ae:b339 with SMTP id x10-20020a05651c104a00b002d2a3aeb339mr1161270ljm.48.1709990113309;
        Sat, 09 Mar 2024 05:15:13 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i26-20020a2ea37a000000b002d3e6ce75cesm297596ljn.70.2024.03.09.05.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 05:15:13 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 09 Mar 2024 14:15:04 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: qcm2290: Add LMH node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-topic-rb1_lmh-v2-3-bac3914b0fe3@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
In-Reply-To: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Loic Poulain <loic.poulain@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709990106; l=1580;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=N3iZ4RWL64J9KIrMZcxBsUxhgEKVEWBB91k8Rvp8UdQ=;
 b=KuOaBM5yLNvJjgYyczPohcnrS6i2fHLRlRPwCX3R0BQIBV2vj2vKIxhMZWAu+vnruHDZhgrs5
 YOZmplen22fAPynqjNXj7OfAHvuwjZthpHkHnkOo9kXkDbJucohmPdw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Loic Poulain <loic.poulain@linaro.org>

Add a node for the Limits Management Hardware to ensure it can be
configured by the operating system.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
[Konrad: add commit msg, rebase]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 89beac833d43..1aacad50e7fc 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1858,7 +1858,7 @@ cpufreq_hw: cpufreq@f521000 {
 			compatible = "qcom,qcm2290-cpufreq-hw", "qcom,cpufreq-hw";
 			reg = <0x0 0x0f521000 0x0 0x1000>;
 			reg-names = "freq-domain0";
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&lmh_cluster 0>;
 			interrupt-names = "dcvsh-irq-0";
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
 			clock-names = "xo", "alternate";
@@ -1866,6 +1866,18 @@ cpufreq_hw: cpufreq@f521000 {
 			#freq-domain-cells = <1>;
 			#clock-cells = <1>;
 		};
+
+		lmh_cluster: lmh@f550800 {
+			compatible = "qcom,qcm2290-lmh", "qcom,sm8150-lmh";
+			reg = <0x0 0x0f550800 0x0 0x400>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU0>;
+			qcom,lmh-temp-arm-millicelsius = <65000>;
+			qcom,lmh-temp-low-millicelsius = <94500>;
+			qcom,lmh-temp-high-millicelsius = <95000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
 	};
 
 	thermal-zones {

-- 
2.44.0


