Return-Path: <linux-pm+bounces-21827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB91A30C26
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C8D188AF83
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51021E097;
	Tue, 11 Feb 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyAhij7R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF31EF0AB
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278607; cv=none; b=ukMhaSJqd+co0ZNgc9GRO9qgSRsv4tWJklRqf7JDxqhaSTGAlKRnmcEZE6rw7HhZjJD14w0Kk7YwE1u9BB/eWmR/VlHPRctXq4RtRennv3MZzkANjneUxB9ZCT/juXl3g2nqR8YNFblu/p2mRVtP7CHMppqnIWGYIqg5691TgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278607; c=relaxed/simple;
	bh=d+GjSlfsiPtSREFcW4TugBdSP8ZalkWtqO1Bjmm9SpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxNby2xmEieW39LEbT4NQSDGtkJmN9ac+hIzvwCfPAAy5DYFYNT+dspKE2NQfUApLIBvCNI/M/0iIMUK8okh2a4hV4PauqXlxUxFiceWmEXLpAy/aSVIV/xUGCDvxIuZsiul2ebhKle1ZbvsMLRGefQlD8WF/R753Gv7S+Lkw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IyAhij7R; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38dc0cd94a6so2611500f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 04:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739278604; x=1739883404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoASWxQXtVgWCHaFayYEr/E5Q8fw3DlK8oqmIqWCzcE=;
        b=IyAhij7Riz2cQxDQ82sq/X6sK7sreKDJi/3tYF2HMT32L0U/FsCOiB7Zd0LsPADo1Q
         YMquauMRnccSDzHqqsD/Tp65rNMBnIoQN0dxW4naeLurwK+llzZ1hp4kc6Zps/G4QBAC
         sXon9FKOZVJ251AG0gjdHNUgLFGeS9JIwxU8bXrRQtWDYQqpbwSToopmpYPshAxPpvlS
         0yzsOxQbYeibdFiQhOt2yIQ0Jo59kh7FlKMQjKtYgqxrfmXytce8e6k2PldHwzcFb6qT
         LWHsYGDGaBehgtHP/Zn37EF725zf1Rf+CMtjDYT6bvSWyvNSScpd67St0ts/OU3gQt2B
         Wh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739278604; x=1739883404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoASWxQXtVgWCHaFayYEr/E5Q8fw3DlK8oqmIqWCzcE=;
        b=hKrXAIK5Za7eKSOdZtXUktCRDTlcGpLSXLLuRheRXRVxqC1OQh0ud9ZpzpPVculkrY
         3zkJDz02NDWUVTee04jUID67TN+xmqRgQTiMCMRkEp3HfyKrG5IsIbximleKxKua7IRK
         nkVV4aV9gClVFdGNPt2ZfvwqvKavUB8DJ7Mouzj9GfXxVEJBhFtHd0/hG5Eg5Pe6h53L
         QrGNQ/h5WC3rhj50NZZfNglCE9X5h1N439pObrKzIxondPVtBy0tY3IGvcoZIjMA5haG
         lYgo9k7aYiGXNmdkkG5qlLYhMv8jOeXR2L8u2Rf2zm2LFRrIO/EXseY5PgrmnQQtFZkN
         rXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4erbe0a2gwWeDnbtKpPWffHnwwg9PWXKiQ7Lw2JwJGm+OW3N5S0uOqv64pIzsXt6EEYfrbSiPWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXd/woESCZ5aX/BDBKwOVEE5QPFRQYFcxzK+m1dbL3cMhwgf+
	OvTPyenalyoaBXY99+we7ciBc3X/N4P1IzRA8tJDxgnej4a1WJwsfIIyUmA9RPA=
X-Gm-Gg: ASbGncuYJ3UEAH4xUHN50jg6HXnyWmq8ZG7ZNgh702vLLRqKQr+Bg8pUuVDrJIk/QkS
	S5d5di6ediRMi82nwgDZn4NFza86N4NkHwm0Uehf2Y+VqnBLqAOesRlxz61tamxo2xboSVoVR0B
	O/p7iVA6sjie5dvcgjTBoYmuuCVMqP54Q5+0TsLdnoAKQBKaXAEjLs39ylEKh7aqRJ6qrZ/pva8
	Q2+JPG84e0gat7AysTDITwxgysT+jSu/Kyp+67He+uAlz2EJUfF4i9nRv5lQ7hSF+WtwljOuOF2
	sZkmBenX51kHkjRwMwzZbR2oDQbDorYLYgDO
X-Google-Smtp-Source: AGHT+IE7QsdzhZcPw6zibNK5UvGLFSYMv3UerAe3R8f0T0a8G9H3YZ9WijThZ1hoipc3YOPnigfRkw==
X-Received: by 2002:a5d:5887:0:b0:38d:e2ab:1969 with SMTP id ffacd0b85a97d-38de2ab1b35mr4273490f8f.14.1739278604210;
        Tue, 11 Feb 2025 04:56:44 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc73c2e00sm12863078f8f.57.2025.02.11.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:56:43 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 11 Feb 2025 13:56:38 +0100
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm8650: add cpu interconnect
 nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-topic-sm8650-ddr-bw-scaling-v2-2-a0c950540e68@linaro.org>
References: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
In-Reply-To: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4643;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=d+GjSlfsiPtSREFcW4TugBdSP8ZalkWtqO1Bjmm9SpI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnq0kIAYN9Xlykt4Y45YFKgX/+5nZVVCbhCPkiJyUx
 xHVpzMSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ6tJCAAKCRB33NvayMhJ0apTD/
 9HqK1MA5nLUfJRodntaIBfcxfz3Ii0gqCd/9fo49UJ2UHJsU+MT6dnV3zrgIVz1IZO0v/5PCqd7kw0
 swow99cgFATZ3P5IDBi8nyl4nI7yup1NvcvjMNtRChGs0XEEO1eMU8a5mNthDEcbxQfRnNwyoHSLfq
 sZtvbfi8ieKzZ6ltfzI+MoUkuzIFFjS+DZir10gxW50AViONUj/M3JtP2TXufBc9VfvGx7/yFpqPsD
 XTDJRpuvWe3AsiMuEo066EGGJhe8t5+RUbwBAcETgmfyPWm/j5qDw2q0HCiUqJIetG622DGV/Nr2BF
 mFd8ZEb3OoFbCbtMc3di4SNPDeTS+vyp1csdSiSIZOtyfxHVSwcRlHqk7HyVdWr2tN+et32mXVWYD+
 G7sE3xM6wrLJ29PXEpLxK2iZR9lEgEqtCfyazIoXoSDN28YbUAkPAx5aLQuW1NpIjVFcDscID5K8IP
 frSZ3HRN2NGPZM6NdU8dBY9PGaEhzKsl+h0TO11ne+9l3HWTGEai4oRFTRv+ezMhWTaHbeSG8b7zwt
 NYgA4W+kIt+V41T6xYRSXa18Cz5fn33uFKntuimKS2I1uJmfvvLKQ2TH2b1AEvg1xImqpzFqi7Lbuo
 etLf2AUxOTc3XoEV7mN2nnB5jcpnYkwdpQHeMBhio+AGUC3oEW4FliWIV7Bw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the interconnect entry for each cpu, with 3 different paths:
- CPU to Last Level Cache Controller (LLCC)
- Last Level Cache Controller (LLCC) to DDR
- L3 Cache from CPU to DDR interface

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index bc09e879c1440873a52daf3fc7a38f451f1f972c..e194a95cdcc0f0f692e62b942331cd9e07a4eae0 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8650-rpmh.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
@@ -85,6 +86,13 @@ cpu0: cpu@0 {
 
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_0: l2-cache {
@@ -118,6 +126,13 @@ cpu1: cpu@100 {
 
 			qcom,freq-domain = <&cpufreq_hw 0>;
 
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 		};
 
@@ -138,6 +153,13 @@ cpu2: cpu@200 {
 
 			qcom,freq-domain = <&cpufreq_hw 3>;
 
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_200: l2-cache {
@@ -165,6 +187,13 @@ cpu3: cpu@300 {
 
 			qcom,freq-domain = <&cpufreq_hw 3>;
 
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 		};
 
@@ -185,6 +214,13 @@ cpu4: cpu@400 {
 
 			qcom,freq-domain = <&cpufreq_hw 3>;
 
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_400: l2-cache {
@@ -212,6 +248,13 @@ cpu5: cpu@500 {
 
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_500: l2-cache {
@@ -239,6 +282,13 @@ cpu6: cpu@600 {
 
 			qcom,freq-domain = <&cpufreq_hw 1>;
 
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_600: l2-cache {
@@ -266,6 +316,13 @@ cpu7: cpu@700 {
 
 			qcom,freq-domain = <&cpufreq_hw 2>;
 
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3 MASTER_EPSS_L3_APPS
+					 &epss_l3 SLAVE_EPSS_L3_SHARED>;
+
 			#cooling-cells = <2>;
 
 			l2_700: l2-cache {

-- 
2.34.1


