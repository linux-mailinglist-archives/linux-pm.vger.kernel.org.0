Return-Path: <linux-pm+bounces-17452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C559C60C5
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 19:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B8E1F236EA
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A0C21790F;
	Tue, 12 Nov 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Xjko5r3q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8B201249;
	Tue, 12 Nov 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437366; cv=none; b=MyLgRzVxciSs0aybpwwuB5wamMlGhuJo3QpdjYvFXiqUskg9qL4WBd99edSPn79Ruoxiy5Mk6SAt4ZqXERwX+vdlF2360XOBBvEb0B2jccgP1Qn8+GvjMpvgB4BwrV76wX3RXPkPjTIISTJfjBfRFakBu5yt39bokNhtbVKMu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437366; c=relaxed/simple;
	bh=mEQre+K2Jof7YSqhQzQZt0O46vsmuqIaW/XRDC6I1RI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZJwBo43LSSxepKeAKQE/kEh3RUha+AiwZXfiQ4yq++fMedGyBpD+9PG2wijofFZT9AiQOSRGE9qq63j1wMPnz4hYRSkyeBQSzEyusnhfJVeP919xXpi4/q82EW6rfVB07qwjGNOHUVQs9KCBED8lZJj3TMHk9/citJRMsw6w86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Xjko5r3q; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id C9B58E45C8;
	Tue, 12 Nov 2024 18:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731437358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6fl+REPDaaxq1ljcrPGFk2JX/FX55Eh3bhEKDJ2hSM=;
	b=Xjko5r3qntRxx+TWuY4S1pEkPQY8AzTMwxgfvNlOdKOx8ytnfgPttkCerD2I4mffnep577
	anjd/MEqSlHSbb4oWVn79l6XbDIpVm9HqQ7l5jeIcFKecUeA1nW5jJHYSKkrktFXVR8+fT
	23XEA02Ghw1quLUKJThVWxDplLXg+/72tli9RYBZXQJ4iGP+U68oWerJFZ0qghGwIhQN42
	5FpGGdXLYFKjmNRQOp6aRnVsd6xhRKy7tUx9xFWoNrbD21aMY8wWx3kdLMTBYvi80YH5og
	nlQw1BdDe4endHz/dYuDeHJIE96ToH3Z9sbO12YzJGiQFwAoJvYCbI1W+ih6LQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 19:49:18 +0100
From: barnabas.czeman@mainlining.org
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz
 Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: Add initial support for
 MSM8917
In-Reply-To: <ZzOQEgLLhkH-IymV@linaro.org>
References: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
 <20241112-msm8917-v5-8-3ca34d33191b@mainlining.org>
 <ZzOQEgLLhkH-IymV@linaro.org>
Message-ID: <0dae1cea420bd335be591e4b1be3d07c@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-12 18:27, Stephan Gerhold wrote:
> On Tue, Nov 12, 2024 at 04:49:38PM +0100, Barnabás Czémán wrote:
>> From: Otto Pflüger <otto.pflueger@abscue.de>
>> 
>> Add initial support for MSM8917 SoC.
>> 
>> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>> [reword commit, rebase, fix schema errors]
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1974 
>> +++++++++++++++++++++++++++++++++
>>  1 file changed, 1974 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi 
>> b/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..cf0a0eec1141e11faca0ee9705d6348ab32a0f50
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> @@ -0,0 +1,1974 @@
>> [...]
>> +		domain-idle-states {
>> +			cluster_sleep_0: cluster-sleep-0 {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x41000023>;
>> +				entry-latency-us = <700>;
>> +				exit-latency-us = <650>;
>> +				min-residency-us = <1972>;
>> +			};
>> +
>> +			cluster_sleep_1: cluster-sleep-1 {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x41000043>;
>> +				entry-latency-us = <240>;
>> +				exit-latency-us = <280>;
>> +				min-residency-us = <806>;
>> +			};
> 
> I think my comment here is still open:
> 
> This is strange, the deeper sleep state has lower timings than the
> previous one?
I was reordering based on Konrad comments when i have renamed the nodes 
maybe it is not correct then.
I am searching for how to validate these levels, i have find these
https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.10.6.2.c26-01500-89xx.0/arch/arm64/boot/dts/qcom/msm8917-pm.dtsi#L45-91
Do you know where can i find psci-suspend-param-s? Should I also add wfi 
level?
> 
>> +
>> +			cluster_sleep_2: cluster-sleep-2 {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x41000053>;
>> +				entry-latency-us = <700>;
>> +				exit-latency-us = <1000>;
>> +				min-residency-us = <6500>;
>> +			};
>> +		};
>> +
>> [...]
>> +		restart@4ab000 {
>> +			compatible = "qcom,pshold";
>> +			reg = <0x004ab000 0x4>;
>> +		};
> 
> This one too:
> 
> You have PSCI for shutting down, do you actually need this?
> 
>> +
>> +		tlmm: pinctrl@1000000 {
>> +			compatible = "qcom,msm8917-pinctrl";
>> +			reg = <0x01000000 0x300000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			gpio-ranges = <&tlmm 0 0 134>;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +
>> [...]
>> +			sdc1_clk_on: sdc1-clk-on-state {
>> +				pins = "sdc1_clk";
>> +				bias-disable;
>> +				drive-strength = <16>;
>> +			};
>> +
>> +			sdc1_clk_off: sdc1-clk-off-state {
>> +				pins = "sdc1_clk";
>> +				bias-disable;
>> +				drive-strength = <2>;
>> +			};
>> +
>> +			sdc1_cmd_on: sdc1-cmd-on-state {
>> +				pins = "sdc1_cmd";
>> +				bias-disable;
>> +				drive-strength = <10>;
>> +			};
>> +
>> +			sdc1_cmd_off: sdc1-cmd-off-state {
>> +				pins = "sdc1_cmd";
>> +				bias-disable;
>> +				drive-strength = <2>;
>> +			};
>> +
>> +			sdc1_data_on: sdc1-data-on-state {
>> +				pins = "sdc1_data";
>> +				bias-pull-up;
>> +				drive-strength = <10>;
>> +			};
>> +
>> +			sdc1_data_off: sdc1-data-off-state {
>> +				pins = "sdc1_data";
>> +				bias-pull-up;
>> +				drive-strength = <2>;
>> +			};
>> +
>> +			sdc1_rclk_on: sdc1-rclk-on-state {
>> +				pins = "sdc1_rclk";
>> +				bias-pull-down;
>> +			};
>> +
>> +			sdc1_rclk_off: sdc1-rclk-off-state {
>> +				pins = "sdc1_rclk";
>> +				bias-pull-down;
>> +			};
>> +
>> +			sdc2_clk_on: sdc2-clk-on-state {
>> +				pins = "sdc2_clk";
>> +				drive-strength = <16>;
>> +				bias-disable;
>> +			};
>> +
>> +			sdc2_clk_off: sdc2-clk-off-state {
>> +				pins = "sdc2_clk";
>> +				bias-disable;
>> +				drive-strength = <2>;
>> +			};
>> +
>> +			sdc2_cmd_on: sdc2-cmd-on-state {
>> +				pins = "sdc2_cmd";
>> +				bias-pull-up;
>> +				drive-strength = <10>;
>> +			};
>> +
>> +			sdc2_cmd_off: sdc2-cmd-off-state {
>> +				pins = "sdc2_cmd";
>> +				bias-pull-up;
>> +				drive-strength = <2>;
>> +			};
> 
> These are not referenced anywhere? Not here in the sdhc_X nodes, and
> also not in your msm8917-xiaomi-riva.dts. Would also recommend
> consolidating these to a single node like in msm8916.dtsi, see commit
> c943e4c58b2f ("arm64: dts: qcom: msm8916/39: Consolidate SDC pinctrl").
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c943e4c58b2ffb0dcd497f8b12f284f5e8fc477e
> 
>> +
>> +			sdc2_cd_on: cd-on-state {
>> +				pins = "gpio67";
>> +				function = "gpio";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			sdc2_cd_off: cd-off-state {
>> +				pins = "gpio67";
>> +				function = "gpio";
>> +				drive-strength = <2>;
>> +				bias-disable;
>> +			};
> 
> It does not make sense to have different on/off states for the card
> detect (CD) pin of the SD card. It needs to work even when the SD card
> is suspended so we can detect insertions/removals. Also should be 
> placed
> in the board-specific DT part.
> 
> See commit dfbda20dabaa ("arm64: dts: qcom: msm8916/39: Fix SD card
> detect pinctrl").
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dfbda20dabaa1f284abd550035db5887384c8e4c
> 
> 
>> +
>> +			sdc2_data_on: sdc2-data-on-state {
>> +				pins = "sdc2_data";
>> +				bias-pull-up;
>> +				drive-strength = <10>;
>> +			};
>> +
>> +			sdc2_data_off: sdc2-data-off-state {
>> +				pins = "sdc2_data";
>> +				bias-pull-up;
>> +				drive-strength = <2>;
>> +			};
>> +
>> [...]
>> +		blsp1_i2c4: i2c@78b8000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b8000 0x500>;
>> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-0 = <&blsp1_i2c4_default>;
>> +			pinctrl-1 = <&blsp1_i2c4_sleep>;
>> +			pinctrl-names = "default", "sleep";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp2_i2c5: i2c@7af5000 {
> 
> This is actually blsp2_i2c1 if you look at the clock name below:
> 
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x07af5000 0x600>;
>> +			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
> 
> here ^
> 
> But I realize now that the pinctrl functions are consecutively numbered
> without the BLSP number. Sorry for the confusion.
> 
> Basically:
>   - blsp1_i2c2 == blsp_i2c2
>   - blsp2_i2c1 == blsp_i2c5
> 
> Looking at some other examples upstream I guess you can choose between
> one of the following options:
> 
>  1. msm8974/msm8976/msm8996/msm8998: Use &blspX_i2cY labels for the 
> i2c@
>     node and pinctrl and only have the slightly confusing pinctrl
>     function. E.g. this in msm8976.dtsi:
> 
> 			/* 4 (not 6!) interfaces per QUP, BLSP2 indexes are numbered (n)+4 
> */
> 			blsp2_i2c2_default: blsp2-i2c2-default-state {
> 				pins = "gpio22", "gpio23";
> 				function = "blsp_i2c6";
> 				drive-strength = <2>;
> 				bias-disable;
> 			};
> 
>     Note how blsp2_i2c2 == blsp_i2c6.
> 
>  2. msm8994: Use &blspX_i2cY labels for the i2c@ node, but keep pinctrl
>     named &i2cN_default. E.g. this in msm8994.dtsi:
> 
> 		blsp2_i2c1: i2c@f9963000 {
> 			/* ... */
> 			pinctrl-names = "default", "sleep";
> 			pinctrl-0 = <&i2c7_default>;
> 			pinctrl-1 = <&i2c7_sleep>;
> 			/* ... */
> 		};
> 
>     Note how blsp2_i2c1 == i2c7_default here.
> 
>  3. msm8953: Use &i2c_N labels everywhere like on downstream. E.g. this
>     in msm8953.dtsi. This is pretty much what you had originally:
> 
> 		i2c_5: i2c@7af5000 {
> 			/* ... */
> 			pinctrl-names = "default", "sleep";
> 			pinctrl-0 = <&i2c_5_default>;
> 			pinctrl-1 = <&i2c_5_sleep>;
> 			/* ... */
> 		};
> 
> All of these are fine for me. Feel free to pick the one you prefer. But
> let's not introduce a new confusing variant of this. :-)
> 
> Thanks,
> Stephan

