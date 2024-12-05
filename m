Return-Path: <linux-pm+bounces-18604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B5F9E4F49
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 09:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3132884E0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9E1CEEB4;
	Thu,  5 Dec 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOsOAnGY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC25EC0;
	Thu,  5 Dec 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386080; cv=none; b=sUqtz7OFcud76HHMDOp/nD6v1ZJr4vsST7GygOvwYSO0Y87Ttj588IvVlleli/y0rL+LJeRWmt8x8asuiE2ksSym2EinMjMY8aO2kQzi888jiAGomlKafU1My7o+3LN6atrqES+MJugUOascABJTM0rfXwGR8XiGZpp7zd737Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386080; c=relaxed/simple;
	bh=VV++W7MV/knILy+1Ihxx+85hraOXG32eoC+C6TADWL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eihp2nwRyK/3RpGyES6r+S+unMLkmQCiL4UAz3Ln/Qc4MKKkuBQLi59Kx6gKCdzsS25qfteHsb+ftYdF6DybBxX7J+CdJ0yiWGpy88WvUfGzoMoBtui9/R/Cbm72VSLcPZI3XJsLuC/iJAKzss8yJkksVL7LvOcuZM46tWJNVAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOsOAnGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3335C4CED1;
	Thu,  5 Dec 2024 08:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733386079;
	bh=VV++W7MV/knILy+1Ihxx+85hraOXG32eoC+C6TADWL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOsOAnGYb8GZIAK4VwUnu3WydQTFvmMQPJLzsSPPBarCgDBN45FfresV7QpdGQcZF
	 EXTKw3ccTUwELrDs5Mc073prX0E5laYpgTTgVRjWKNCsJEBNox/OAmth3p18bA88jR
	 8qqj+yxW2iA8F3xGQPYXTr1iWm20OyfFGT5+DPSKR69z8IMQlla/o/dejBRP9L2xPs
	 P0dYw20LZvFvJMz9tajy4kAv6UgIyjyWl3Qs13NPTwO3EPNcpgxB97WAG9K6xVXway
	 RBDD576eKBC9tSeX/eWRZD+VcCIpA387ZulXf7aVmJ3Rwo1yQT5pc8VSXCkGx4tb85
	 sYZjWg8WS7U5Q==
Date: Thu, 5 Dec 2024 09:07:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
Message-ID: <aidraihg7zkbaojj72zsstwfwdrth4734tiozli2qd6cu36ybs@ea3y3oaiexgy>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-3-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204131706.20791-3-quic_janathot@quicinc.com>

On Wed, Dec 04, 2024 at 06:47:04PM +0530, Janaki Ramaiah Thota wrote:
> Add a node for the PMU module of the WCN6750 present on the
> qcs6490-rb3gen board and assign its power outputs to the Bluetooth
> module.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
>  1 file changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 27695bd54220..07650648214e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /*
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
> @@ -33,6 +33,7 @@
>  
>  	aliases {
>  		serial0 = &uart5;
> +		serial1 = &uart7;
>  	};
>  
>  	chosen {
> @@ -217,6 +218,63 @@
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	wcn6750-pmu {
> +		compatible = "qcom,wcn6750-pmu";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en>;
> +		vddaon-supply = <&vreg_s7b_0p972>;
> +		vddasd-supply = <&vreg_l11c_2p8>;
> +		vddpmu-supply = <&vreg_s7b_0p972>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> +
> +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> +
> +		regulators {
> +			vreg_pmu_rfa_cmn: ldo0 {
> +				regulator-name = "vreg_pmu_rfa_cmn";
> +			};
> +
> +			vreg_pmu_aon_0p59: ldo1 {
> +				regulator-name = "vreg_pmu_aon_0p59";
> +			};
> +
> +			vreg_pmu_wlcx_0p8: ldo2 {
> +				regulator-name = "vreg_pmu_wlcx_0p8";
> +			};
> +
> +			vreg_pmu_wlmx_0p85: ldo3 {
> +				regulator-name = "vreg_pmu_wlmx_0p85";
> +			};
> +
> +			vreg_pmu_btcmx_0p85: ldo4 {
> +				regulator-name = "vreg_pmu_btcmx_0p85";
> +			};
> +
> +			vreg_pmu_rfa_0p8: ldo5 {
> +				regulator-name = "vreg_pmu_rfa_0p8";
> +			};
> +
> +			vreg_pmu_rfa_1p2: ldo6 {
> +				regulator-name = "vreg_pmu_rfa_1p2";
> +			};
> +
> +			vreg_pmu_rfa_1p7: ldo7 {
> +				regulator-name = "vreg_pmu_rfa_1p7";
> +			};
> +
> +			vreg_pmu_pcie_0p9: ldo8 {
> +				regulator-name = "vreg_pmu_pcie_0p9";
> +			};
> +
> +			vreg_pmu_pcie_1p8: ldo9 {
> +				regulator-name = "vreg_pmu_pcie_1p8";
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> @@ -758,6 +816,39 @@
>  	status = "okay";
>  };
>  
> +&qup_uart7_cts {
> +	/*
> +	 * Configure a bias-bus-hold on CTS to lower power
> +	 * usage when Bluetooth is turned off. Bus hold will
> +	 * maintain a low power state regardless of whether
> +	 * the Bluetooth module drives the pin in either
> +	 * direction or leaves the pin fully unpowered.
> +	 */
> +	bias-bus-hold;
> +};
> +
> +&qup_uart7_rts {
> +	/* We'll drive RTS, so no pull */
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +&qup_uart7_rx {
> +	/*
> +	 * Configure a pull-up on RX. This is needed to avoid
> +	 * garbage data when the TX pin of the Bluetooth module is
> +	 * in tri-state (module powered off or not driving the
> +	 * signal yet).
> +	 */
> +	bias-pull-up;
> +};
> +
> +&qup_uart7_tx {
> +	/* We'll drive TX, so no pull */
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -801,12 +892,84 @@
>  &tlmm {
>  	gpio-reserved-ranges = <32 2>, /* ADSP */
>  			       <48 4>; /* NFC */
> +	bt_en: bt-en-state {
> +		pins = "gpio85";
> +		function = "gpio";
> +		output-low;
> +		bias-disable;
> +	}

Missing blank line

> +	qup_uart7_sleep: qup_uart7_sleep {
> +		qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
> +			pins = "gpio28";
> +			function = "gpio";
> +			/*
> +			 * Configure a bias-bus-hold on CTS to lower power
> +			 * usage when Bluetooth is turned off. Bus hold will
> +			 * maintain a low power state regardless of whether
> +			 * the Bluetooth module drives the pin in either
> +			 * direction or leaves the pin fully unpowered.
> +			 */
> +			bias-bus-hold;
> +		};
> +
> +		qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
> +			pins = "gpio29";
> +			function = "gpio";
> +			/*
> +			 * Configure pull-down on RTS. As RTS is active low
> +			 * signal, pull it low to indicate the BT SoC that it
> +			 * can wakeup the system anytime from suspend state by
> +			 * pulling RX low (by sending wakeup bytes).
> +			 */
> +			bias-pull-down;
> +		};
> +
> +		qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
> +			pins = "gpio31";
> +			function = "gpio";
> +			/*
> +			 * Configure a pull-up on RX. This is needed to avoid
> +			 * garbage data when the TX pin of the Bluetooth module
> +			 * is floating which may cause spurious wakeups.
> +			 */
> +			bias-pull-up;
> +		};
> +
> +		qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
> +			pins = "gpio30";
> +			function = "gpio";
> +			/*
> +			 * Configure pull-up on TX when it isn't actively driven
> +			 * to prevent BT SoC from receiving garbage during sleep.
> +			 */
> +			bias-pull-up;
> +		};
> +	};
>  };
>  
>  &uart5 {
>  	status = "okay";
>  };
>  
> +&uart7 {
> +	/delete-property/interrupts;
> +	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> +				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> +	pinctrl-1 = <&qup_uart7_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";

Missing blank line


Best regards,
Krzysztof


