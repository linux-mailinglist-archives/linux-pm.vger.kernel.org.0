Return-Path: <linux-pm+bounces-15957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724049A3ED2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 14:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2AA1C241DF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8465C1FCF7F;
	Fri, 18 Oct 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QNudas2H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145B1EE000
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255790; cv=none; b=HF+yAd/sf1qyXXjnlEcEHPhPuSpilUM2vXUzD2nGnFSUoFFIs83xYbkp8spUm28yeUntQGf/XfGfeygwk4tB0gwvg8To2yHpThtf/TS0iwr+Z0W0Ov625Cu/Q+m73Qnh5hb4RXQAqbKEr5BLMmSuh9iofPshpboBUGHMkopD5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255790; c=relaxed/simple;
	bh=3k37DmjvVVitbZLKPGImu5/pI96IV+YohC0dbWztqgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXZXpUWwRfTHekMmh3BmVL+KQmVgXxSHOSrQQ7b7TspKbTHtLqpZw+dvmxQ6YNMyxQpuh9Y8QiuknCNxZ0Bt6WQ14HBNFaN2kelVToMsp7dcVMyt4UWrCFDNCfRUR3aUEhnVtfSNMpfo7E0gX9ko5EZrN3xJhNI5Whcku3jXQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QNudas2H; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so20604605e9.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729255785; x=1729860585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cqwZVP+zqyJHBNtjkA+B0HPwS7hbZ/3iwJT6bTaS8o=;
        b=QNudas2HMPcXKznENmgH9tD2OK++aB2Ivs6ErTx3uesmUaeYvtr2l3bVNRNue0ez5w
         paX+VUlr1/FxjXZLF7Asto5JgJyxZ7SE3z0mMLaG+hgS064kX43jjXJt+z+9TQemoP5e
         HlGhrGaxw9K9zchwdxVD7pZ5WSwlmldosrNLK+Iv6t33Pz6FYBJGz5gSvwZ1zpq4Cxrd
         KmBa3SlIaUQJLRIxu1Evb8NcubO4NbamgN5YzRcMLvn7EiBPK53LTakjVVicIFpSKcwf
         dKv8+EVMVYyzyNnPeuUJcdXRakFXWKr4eJBvzNEtWYvoTelosc9pYLc3iGnNCCFEZaX+
         WfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255785; x=1729860585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cqwZVP+zqyJHBNtjkA+B0HPwS7hbZ/3iwJT6bTaS8o=;
        b=FpRS9QIY/BnhB6ID/1NnmZXz52tLKk+efmzAz6S4L7cJoWKvdKKiGzOc3yTDFoX9Pu
         K130Nf8i3R0CDNVLxwoPANJA24Cy8ZT8LQxr/BvlbvAnsrZgb1JuTx8ebNtVbUoGK6OE
         VT21ycijue5AlUx0+nBRA/4xlmvpIoAi3pzqmY0KXlC9qaomRHiv6cB4yR73lFs1Czzs
         cvwSXMSaCZ834Ts7wwjJmpQHUgvF78r3hdELi4vpT60vyDgaTKdrM8fLgxBys3RKDACk
         +SVX/5VCwjf1J2p/oTqleuYBlRPS1jjpoix/cdc5LNHTKCJxkex4UXwQUYU4QbJ+/VoJ
         AG5g==
X-Forwarded-Encrypted: i=1; AJvYcCVv+ro8LB4sgidYx+bH4ZKFGO3tMwxSCLwr4K14anl0bcik9CgD0OKY2tMjuUEhVHrKRqa+pJBibQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytzctehzf7S36YmV1f+rJptDwe8T+O3SgzTgLDNYNQFzq/ENNM
	j/kWxwt2CJA44YBNSCcKpxDjhc95l400T6Oy6JaLGnkKrzvdn3s/Qozdco0AbKQ=
X-Google-Smtp-Source: AGHT+IHLkVNVhQBqO7zNNKeqKThK+CBSku3/uu/wTH7YA3otDEk1NvjE+42e7TZmZ+HlcqalO8sWIQ==
X-Received: by 2002:a05:600c:468a:b0:431:5187:28dd with SMTP id 5b1f17b1804b1-4316168edc6mr19255125e9.28.1729255785071;
        Fri, 18 Oct 2024 05:49:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160695d8fsm26640835e9.27.2024.10.18.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:49:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 14:49:16 +0200
Subject: [PATCH v6 6/6] arm64: dts: qcom: sm8450-hdk: model the PMU of the
 on-board wcn6855
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-sc8280xp-pwrseq-v6-6-8da8310d9564@linaro.org>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5563;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=1R0dZeOAv50eWbW4Hszj2kUWLcatmibvSfqEpRoAU7g=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEllgjbd04ztjzNExSs78CJOOz337EN0NxtRd/
 6gbQKZKbQaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxJZYAAKCRARpy6gFHHX
 ch9mEADBKXRTjzn7x8VnOkmoocbJwx64bVMcwPh/++m2yzmBzTYKWIiwWrB7R8Ely+i6yH75N0G
 TEzdL22l49vqCuAKbnegOKtBLnhn8pDheNcnaLLDYU46aDwZIDLwGnRWVroEOizyZTDb/IaFEsf
 mQ+LSu77Via9GacpG5/UgMlxhxuxP6lEO95y+FnYPOx7PlKLnu/PkdPlH3NrGmLGTofa+FOSspm
 qTVyT3CPQesxgSTYlcx6wLHkZ+YSV303q+GYCXh3zIG4BzDGe1jTEP+RW/Gad/QeUbWYMhuwoIY
 bpMk7KxNIpQxmGGoJ7yrK7i1ykdb79auFjNePh9DsBnPFptJkEjqxjwTy1LpCUMOHSbpWpfhNjT
 dlurZvNDmx0aeMxeObhq3yR8/ZjpTMLLTiWeFLlW84JN4ES5Djix2EDVDMCdoOBJjbNkyYOsLID
 KW+bLfXEfC/RNFofJhYmW/UTbLMg9n/LSi0xlGSVmeEcnoPNjT3DT+jW2+8akBaZ9e5QYMPGJkG
 PqLjKONZIZsrs4c3UPNO6OfziRdpAb3rB+BPc3CazgDHAbImkJH8Yor7LAT33osfUWkf6d7zH5Q
 NJcTCrerA4ERcNub+h7JGId1Nt3BPY8kLQrIcdtiMW25/s/MMGQlmwc78GOLggdCPCbNlqe1x8B
 O9WGTT60S76XGAA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add nodes for the WCN6855 PMU, the WLAN and BT modules and relevant
regulators and pin functions to fully describe how the wifi is actually
wired on this platform.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 157 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi    |   2 +-
 2 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 67443822653d..2ff40a120aad 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -26,6 +26,7 @@ / {
 
 	aliases {
 		serial0 = &uart7;
+		serial1 = &uart20;
 	};
 
 	wcd938x: audio-codec {
@@ -247,6 +248,71 @@ active-config0 {
 		};
 	};
 
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&bt_en>, <&wlan_en>, <&xo_clk_default>;
+		pinctrl-names = "default";
+
+		wlan-enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 82 GPIO_ACTIVE_HIGH>;
+		xo-clk-gpios = <&tlmm 204 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s10b_1p8>;
+		vddaon-supply = <&vreg_s11b_0p95>;
+		vddpmu-supply = <&vreg_s12b_1p25>;
+		vddpmumx-supply = <&vreg_s2e_0p85>;
+		vddpmucx-supply = <&vreg_s11b_0p95>;
+		vddrfa0p95-supply = <&vreg_s11b_0p95>;
+		vddrfa1p3-supply = <&vreg_s12b_1p25>;
+		vddrfa1p9-supply = <&vreg_s1c_1p86>;
+		vddpcie1p3-supply = <&vreg_s12b_1p25>;
+		vddpcie1p9-supply = <&vreg_s1c_1p86>;
+
+		regulators {
+			vreg_pmu_rfa_cmn_0p8: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn_0p8";
+			};
+
+			vreg_pmu_aon_0p8: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p8";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p8: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p8";
+			};
+
+			vreg_pmu_btcmx_0p8: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p8";
+			};
+
+			vreg_pmu_pcie_1p8: ldo5 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo6 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_rfa_0p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo8 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo9 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -685,6 +751,23 @@ &pcie0_phy {
 	vdda-pll-supply = <&vreg_l6b_1p2>;
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &pcie1 {
 	status = "okay";
 };
@@ -892,6 +975,10 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &sdhc_2 {
 	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default", "sleep";
@@ -1069,6 +1156,26 @@ &uart7 {
 	status = "okay";
 };
 
+&uart20 {
+	pinctrl-0 = <&uart20_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6855-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &ufs_mem_hc {
 	status = "okay";
 
@@ -1130,6 +1237,14 @@ &vamacro {
 };
 
 &tlmm {
+	bt_en: bt-en-state {
+		pins = "gpio81";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-down;
+	};
+
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio1";
 		function = "gpio";
@@ -1153,4 +1268,46 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio80";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-down;
+	};
+
+	uart20_default: uart20-default-state {
+		cts-pins {
+			pins = "gpio76";
+			function = "qup20";
+			bias-disable;
+		};
+
+		rts-pins {
+			pins = "gpio77";
+			function = "qup20";
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio78";
+			function = "qup20";
+			bias-disable;
+		};
+
+		tx-pins {
+			pins = "gpio79";
+			function = "qup20";
+			bias-disable;
+		};
+	};
+
+	xo_clk_default: xo-clk-state {
+		pins = "gpio204";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-down;
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1b5dc5b8cecb..be876a919455 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1880,7 +1880,7 @@ opp-8000000 {
 				};
 			};
 
-			pcie@0 {
+			pcieport0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.43.0


