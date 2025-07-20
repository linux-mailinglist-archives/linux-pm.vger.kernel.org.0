Return-Path: <linux-pm+bounces-31107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66BEB0B359
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 05:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9E17AEF55
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 03:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD318858C;
	Sun, 20 Jul 2025 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnAT9twI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11717BA5;
	Sun, 20 Jul 2025 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752982622; cv=none; b=FgcZaU7PmlMrK9D8T38hD8M5HaZCNWBZjNplU/6GdhyrE5AjUvs8Vg+8T/5vlkZzcPH5M3GAx9n3QZxlGBFDOyVB/SN4TGI5s0/S+tueunsUvVMeAPRXYhjt2jJ2dUOz2Y5naOqbkzR0FIo64XwzyybkaO1eZntP331wEcImj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752982622; c=relaxed/simple;
	bh=+DpSzgU4gtQbFYEFCOlFoqE4leUc0drbsHZHlj6bzis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1K4hcxQcF5z9oAMctdyNOyUj1sX742yFBE4Pss1pzM/eWF1XJsrslSa6ovSJnR2Z3jVQFFFFXd9cOPDx6M+kO9N4MMhA41+0pI86P718LSxyNWF0WdaZ3iiT52B8cpshf+eBp9RL1emYo/h7lO+3k1zKgIqofOdmoiknPkiZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnAT9twI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C114C4CEF4;
	Sun, 20 Jul 2025 03:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752982621;
	bh=+DpSzgU4gtQbFYEFCOlFoqE4leUc0drbsHZHlj6bzis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnAT9twIA28l+7jGUIt2p+0S20d7/J9SN3EZbn3s+qPUEPi3AGlAnNFllKYi9Ti7Q
	 iuh1eaGWKf+bGJvzTXeHc3uWVhhC6CMBTHC0gwdI5KVDch27YmEGZoIUoIcMChHhb3
	 FO2cPSzn4sE01xXzVS7j6UWXZVW6wQAbp4qlhqq19l23jLhM6LN99G9nq5hiyHI5D1
	 hxRDia4dogUG3LsM5NoY0vKaCrGF5WFTDwx9i+j7Lsn1+XhZJSRfFC6jdpCWZFD1eC
	 S/NX0n4BmyeQbVWKZaX2v07ZBk+xEBgmAcFKRFNhB1y106YzaFOQBPFsRCKeGfm5Jd
	 XMRUbBFz4bsMQ==
Date: Sat, 19 Jul 2025 22:36:58 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/8] arm64: dts: qcom: dts: switch to RPMPD_* indices
Message-ID: <bubac7n7qx2ww5dzzsth7dsw5vtzwfom2r42ox6n6aft474hyx@mlo3jpfozvha>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
 <20250718-rework-rpmhpd-rpmpd-v1-5-eedca108e540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-5-eedca108e540@oss.qualcomm.com>

On Fri, Jul 18, 2025 at 07:13:43PM +0300, Dmitry Baryshkov wrote:
> Use generic RPMPD_* defines for power domain instead of using
> platform-specific defines.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi |  8 ++++----
>  arch/arm64/boot/dts/qcom/msm8917.dtsi | 10 +++++-----
>  arch/arm64/boot/dts/qcom/msm8976.dtsi |  4 ++--
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 16 ++++++++--------
>  arch/arm64/boot/dts/qcom/sdm630.dtsi  | 16 ++++++++--------
>  arch/arm64/boot/dts/qcom/sm6125.dtsi  | 12 ++++++------
>  6 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index b50c7e6e0bfcd35ab4f8b84aeabe214fd60e8d7c..ca184ee3af065df0dfb3c7106d29360a860b8b36 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1943,8 +1943,8 @@ mpss: remoteproc@4080000 {
>  			interrupt-names = "wdog", "fatal", "ready",
>  					  "handover", "stop-ack";
>  
> -			power-domains = <&rpmpd MSM8916_VDDCX>,
> -					<&rpmpd MSM8916_VDDMX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>,
> +					<&rpmpd RPMPD_VDDMX>;
>  			power-domain-names = "cx", "mx";
>  
>  			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
> @@ -2445,8 +2445,8 @@ wcnss: remoteproc@a204000 {
>  					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>  			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
>  
> -			power-domains = <&rpmpd MSM8916_VDDCX>,
> -					<&rpmpd MSM8916_VDDMX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>,
> +					<&rpmpd RPMPD_VDDMX>;
>  			power-domain-names = "cx", "mx";
>  
>  			qcom,smem-states = <&wcnss_smp2p_out 0>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> index 8a642fce2e40d6d252a1cfbdfed602e6789ef09a..87dfc1e7e131cd4192ffbdd4913f934af17c5c88 100644
> --- a/arch/arm64/boot/dts/qcom/msm8917.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> @@ -1070,7 +1070,7 @@ mdss_dsi0: dsi@1a94000 {
>  				phys = <&mdss_dsi0_phy>;
>  
>  				operating-points-v2 = <&mdss_dsi0_opp_table>;
> -				power-domains = <&rpmpd MSM8917_VDDCX>;
> +				power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -1288,7 +1288,7 @@ sdhc_1: mmc@7824900 {
>  			pinctrl-0 = <&sdc1_default>;
>  			pinctrl-1 = <&sdc1_sleep>;
>  			pinctrl-names = "default", "sleep";
> -			power-domains = <&rpmpd MSM8917_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  			mmc-hs200-1_8v;
>  			mmc-hs400-1_8v;
>  			mmc-ddr-1_8v;
> @@ -1313,7 +1313,7 @@ sdhc_2: mmc@7864900 {
>  			pinctrl-0 = <&sdc2_default>;
>  			pinctrl-1 = <&sdc2_sleep>;
>  			pinctrl-names = "default", "sleep";
> -			power-domains = <&rpmpd MSM8917_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  			bus-width = <4>;
>  			status = "disabled";
>  		};
> @@ -1517,8 +1517,8 @@ wcnss: remoteproc@a204000 {
>  					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>  			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
>  
> -			power-domains = <&rpmpd MSM8917_VDDCX>,
> -					<&rpmpd MSM8917_VDDMX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>,
> +					<&rpmpd RPMPD_VDDMX>;
>  			power-domain-names = "cx", "mx";
>  
>  			qcom,smem-states = <&wcnss_smp2p_out 0>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index f9962512f243d6c1af4931787f4602554c63bb39..80a0a09e055d79c5e56f89e5d67baf9971d87069 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -1558,8 +1558,8 @@ wcnss: remoteproc@a204000 {
>  					  "handover",
>  					  "stop-ack";
>  
> -			power-domains = <&rpmpd MSM8976_VDDCX>,
> -					<&rpmpd MSM8976_VDDMX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>,
> +					<&rpmpd RPMPD_VDDMX>;
>  			power-domain-names = "cx", "mx";
>  
>  			qcom,smem-states = <&wcnss_smp2p_out 0>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 0b0a9379cb05b01ebb17cef9fe7d22d56790efd3..2d7c45fec94e868b41a2b8d7acf8175a7b02c0b7 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -1497,8 +1497,8 @@ remoteproc_mss: remoteproc@4080000 {
>  
>  			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
>  
> -			power-domains = <&rpmpd MSM8998_VDDCX>,
> -					<&rpmpd MSM8998_VDDMX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>,
> +					<&rpmpd RPMPD_VDDMX>;
>  			power-domain-names = "cx", "mx";
>  
>  			status = "disabled";
> @@ -1544,7 +1544,7 @@ adreno_gpu: gpu@5000000 {
>  			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
>  			iommus = <&adreno_smmu 0>;
>  			operating-points-v2 = <&gpu_opp_table>;
> -			power-domains = <&rpmpd MSM8998_VDDMX>;
> +			power-domains = <&rpmpd RPMPD_VDDMX>;
>  			status = "disabled";
>  
>  			gpu_opp_table: opp-table {
> @@ -1680,7 +1680,7 @@ remoteproc_slpi: remoteproc@5800000 {
>  			qcom,smem-states = <&slpi_smp2p_out 0>;
>  			qcom,smem-state-names = "stop";
>  
> -			power-domains = <&rpmpd MSM8998_SSCCX>;
> +			power-domains = <&rpmpd RPMPD_SSCCX>;
>  			power-domain-names = "ssc_cx";
>  
>  			status = "disabled";
> @@ -2871,7 +2871,7 @@ mdss_mdp: display-controller@c901000 {
>  				assigned-clock-rates = <19200000>;
>  
>  				operating-points-v2 = <&mdp_opp_table>;
> -				power-domains = <&rpmpd MSM8998_VDDMX>;
> +				power-domains = <&rpmpd RPMPD_VDDMX>;
>  
>  				mdp_opp_table: opp-table {
>  					compatible = "operating-points-v2";
> @@ -2953,7 +2953,7 @@ mdss_dsi0: dsi@c994000 {
>  							 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
>  
>  				operating-points-v2 = <&dsi_opp_table>;
> -				power-domains = <&rpmpd MSM8998_VDDCX>;
> +				power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  				phys = <&mdss_dsi0_phy>;
>  				phy-names = "dsi";
> @@ -3029,7 +3029,7 @@ mdss_dsi1: dsi@c996000 {
>  							 <&mdss_dsi1_phy DSI_PIXEL_PLL_CLK>;
>  
>  				operating-points-v2 = <&dsi_opp_table>;
> -				power-domains = <&rpmpd MSM8998_VDDCX>;
> +				power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  				phys = <&mdss_dsi1_phy>;
>  				phy-names = "dsi";
> @@ -3277,7 +3277,7 @@ remoteproc_adsp: remoteproc@17300000 {
>  			qcom,smem-states = <&adsp_smp2p_out 0>;
>  			qcom,smem-state-names = "stop";
>  
> -			power-domains = <&rpmpd MSM8998_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  			power-domain-names = "cx";
>  
>  			status = "disabled";
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 8b1a45a4e56ed1ae02e5bb6e78ca6255d87add1c..412d7f7d6de67008c1f406ac5a73a51ff7f4f98d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1058,8 +1058,8 @@ remoteproc_mss: remoteproc@4080000 {
>  
>  			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
>  
> -			power-domains = <&rpmpd SDM660_VDDCX>,
> -					<&rpmpd SDM660_VDDMX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>,
> +					<&rpmpd RPMPD_VDDMX>;
>  			power-domain-names = "cx", "mx";
>  
>  			memory-region = <&mba_region>, <&mpss_region>, <&mdata_mem>;
> @@ -1096,7 +1096,7 @@ adreno_gpu: gpu@5000000 {
>  				"rbcpr",
>  				"core";
>  
> -			power-domains = <&rpmpd SDM660_VDDMX>;
> +			power-domains = <&rpmpd RPMPD_VDDMX>;
>  			iommus = <&kgsl_smmu 0>;
>  
>  			nvmem-cells = <&gpu_speed_bin>;
> @@ -1396,7 +1396,7 @@ sdhc_2: mmc@c084000 {
>  			pinctrl-names = "default", "sleep";
>  			pinctrl-0 = <&sdc2_state_on>;
>  			pinctrl-1 = <&sdc2_state_off>;
> -			power-domains = <&rpmpd SDM660_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  			status = "disabled";
>  
> @@ -1450,7 +1450,7 @@ sdhc_1: mmc@c0c4000 {
>  			pinctrl-names = "default", "sleep";
>  			pinctrl-0 = <&sdc1_state_on>;
>  			pinctrl-1 = <&sdc1_state_off>;
> -			power-domains = <&rpmpd SDM660_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  			bus-width = <8>;
>  			non-removable;
> @@ -1612,7 +1612,7 @@ mdp: display-controller@c901000 {
>  						     "rotator-mem";
>  				iommus = <&mmss_smmu 0>;
>  				operating-points-v2 = <&mdp_opp_table>;
> -				power-domains = <&rpmpd SDM660_VDDCX>;
> +				power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  				ports {
>  					#address-cells = <1>;
> @@ -1664,7 +1664,7 @@ mdss_dsi0: dsi@c994000 {
>  				reg-names = "dsi_ctrl";
>  
>  				operating-points-v2 = <&dsi_opp_table>;
> -				power-domains = <&rpmpd SDM660_VDDCX>;
> +				power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  				interrupt-parent = <&mdss>;
>  				interrupts = <4>;
> @@ -2280,7 +2280,7 @@ adsp_pil: remoteproc@15700000 {
>  			clock-names = "xo";
>  
>  			memory-region = <&adsp_region>;
> -			power-domains = <&rpmpd SDM660_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  			power-domain-names = "cx";
>  
>  			qcom,smem-states = <&adsp_smp2p_out 0>;
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 8f2d65543373e70b48b4015478e21e8e74fd23c9..80c42dff5399b7c60576c2b6cf79afdbd8b9b1d4 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -724,7 +724,7 @@ sdhc_1: mmc@4744000 {
>  			clock-names = "iface", "core", "xo";
>  			iommus = <&apps_smmu 0x160 0x0>;
>  
> -			power-domains = <&rpmpd SM6125_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  			qcom,dll-config = <0x000f642c>;
>  			qcom,ddr-config = <0x80040873>;
> @@ -755,7 +755,7 @@ sdhc_2: mmc@4784000 {
>  			pinctrl-1 = <&sdc2_off_state>;
>  			pinctrl-names = "default", "sleep";
>  
> -			power-domains = <&rpmpd SM6125_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  			qcom,dll-config = <0x0007642c>;
>  			qcom,ddr-config = <0x80040873>;
> @@ -1275,7 +1275,7 @@ mdss_mdp: display-controller@5e01000 {
>  				assigned-clock-rates = <19200000>;
>  
>  				operating-points-v2 = <&mdp_opp_table>;
> -				power-domains = <&rpmpd SM6125_VDDCX>;
> +				power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  				ports {
>  					#address-cells = <1>;
> @@ -1345,7 +1345,7 @@ mdss_dsi0: dsi@5e94000 {
>  							 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
>  
>  				operating-points-v2 = <&dsi_opp_table>;
> -				power-domains = <&rpmpd SM6125_VDDCX>;
> +				power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  				phys = <&mdss_dsi0_phy>;
>  				phy-names = "dsi";
> @@ -1406,7 +1406,7 @@ mdss_dsi0_phy: phy@5e94400 {
>  					      "ref";
>  
>  				required-opps = <&rpmpd_opp_nom>;
> -				power-domains = <&rpmpd SM6125_VDDMX>;
> +				power-domains = <&rpmpd RPMPD_VDDMX>;
>  
>  				status = "disabled";
>  			};
> @@ -1434,7 +1434,7 @@ dispcc: clock-controller@5f00000 {
>  				      "gcc_disp_gpll0_div_clk_src";
>  
>  			required-opps = <&rpmpd_opp_ret>;
> -			power-domains = <&rpmpd SM6125_VDDCX>;
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
>  
>  			#clock-cells = <1>;
>  			#power-domain-cells = <1>;
> 
> -- 
> 2.39.5
> 

