Return-Path: <linux-pm+bounces-289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8617FA4A8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098E31C20BD6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8F328D7;
	Mon, 27 Nov 2023 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3TAiNK9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E91FC2
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54af1daf6a9so5861788a12.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098964; x=1701703764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6/lhVmHX/sXs0e46ClnnLz5Erfr7PRCNkXawgtymt8=;
        b=L3TAiNK961B+e2vdd8O3nLAD/FSNmUkcpOVDNA5ge13EgQfaTB34fAlqSa2aNNYjHE
         9CwGe32LwwOE/PzYvA07dGL9XKLGAqmw7svOpNg6OcJKDBf2zejUBK3SE5IiS/VenLv1
         qHeS6sd4wFej+qZhjtKucQXAD169UAYskstSVCvjQV6Z6NS7hRVWO/S2fuBh60c54PU/
         ZKtI3zd6LGGfbv01Wer4xD0uvF0t0ClAhK932BgdOAafJuE7TIiU2oRk/UVyLh/5Eonb
         /dB46YzLeo2Mcnz6BnWOs9D7fI/ck1XDaMsXG8vpNLcedOWXZ/ZKA+kUIiSJ+lU/7eS4
         DoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098964; x=1701703764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6/lhVmHX/sXs0e46ClnnLz5Erfr7PRCNkXawgtymt8=;
        b=QdGrKJ+gz6ZNT0ZSnco9IAoAK3ZfKI+HZlEUgeFcjkr4KezHv54moUh+4kWnf79Y6J
         MEwMzupvj7rNPjrIM4uMF39i3HIm/KGzAe2PZ6iE6DPA0+aK2XyYhAaAKyM4wqU1XaPa
         MN5sV1M/QabQxt08Et0JVao7mrPNuksu3JgFyfW+aGfmkZtCYYFq4x3CENUVctcFAvG6
         f5Z8m+swRbfFy7AnjlEQDfL5mVul/HLwn2UhEY1hS8i62StDlFSUeuxQwXHW9f5iithP
         ta72Su4LOVRxT0HUXkveOmJeL3SIT//bYASpyGlnpcLV/01HskQat5+JH9StxzeZVWc0
         LELQ==
X-Gm-Message-State: AOJu0Yy2D5ugI2D9bVspj8QNr7kmriN3IuCa9U4q/3fH0xd3N7DG+7DF
	971EU33MDvrXhTKZc3JAMPcGvQ==
X-Google-Smtp-Source: AGHT+IE12MRZ+K4+7Ya9XYiXHy8f8LRtqIz85wDPP5rtzWUU+R4ruteNN5riVPicBCMiZlt8klaJfQ==
X-Received: by 2002:aa7:c401:0:b0:54b:3bba:8372 with SMTP id j1-20020aa7c401000000b0054b3bba8372mr5621717edq.5.1701098964534;
        Mon, 27 Nov 2023 07:29:24 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:24 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:50 +0100
Subject: [PATCH v2 10/12] arm64: dts: qcom: qrb2210-rb1: Set up HDMI
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-10-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=2344;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HG+qKKvGUGteXhS1Efd/CaFsVpJbWzVwdo27Zc2OxfM=;
 b=bScEiiVF7H6OgG93/bEfiiBpKcPZrN5AKqa/34nrmj67oU8vvcbgzuavBX+sO/7vUBhqlFj4Q
 H4dnTJ831zLC3QqIiTvg8eNp9DXstc5E1AfZnn/Y3db9beLHUlgcQ+X
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the required nodes to support display output via the HDMI port.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 94885b9c21c8..ac6584164058 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -40,6 +40,17 @@ key-volume-up {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -158,6 +169,68 @@ vph_pwr: regulator-vph-pwr {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+		interrupts-extended = <&tlmm 46 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&vreg_hdmi_out_1p2>;
+		vcc-supply = <&lt9611_3v3>;
+
+		pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
+		pinctrl-names = "default";
+		#sound-dai-cells = <1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&pm2250_l5>;
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &pm2250_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
@@ -377,6 +450,19 @@ &sdhc_2 {
 };
 
 &tlmm {
+	lt9611_rst_pin: lt9611-rst-state {
+		pins = "gpio41";
+		function = "gpio";
+		input-disable;
+		output-high;
+	};
+
+	lt9611_irq_pin: lt9611-irq-state {
+		pins = "gpio46";
+		function = "gpio";
+		bias-disable;
+	};
+
 	sd_det_in_on: sd-det-in-on-state {
 		pins = "gpio88";
 		function = "gpio";

-- 
2.43.0


