Return-Path: <linux-pm+bounces-17448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2339C627F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 21:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2243BB30EC9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74072139A6;
	Tue, 12 Nov 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rV9TyvPT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC512123F8
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432478; cv=none; b=ZOYdZzRlxYX7kyMJ3vvthPTQfN9mf4S5ff690S/CE3ymkc5twgvR4Qwy4b3+pdjOKfXh2t7R/ZuAyGcNw8GZCFgI2e4Cw4khcfaOjF9AdRwsYwNOF5Ufml+hgyWUKF/EdF/yixbbZP3O8A9HP0X/36xS+HGL0HgDAvSnhCYxn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432478; c=relaxed/simple;
	bh=/r0OYPqICBFR5VtOll1qmVLyzaVPdEQeWZCbK4/E4WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAmkeIWPdz4FwXZV/woGG4R3WbAVbSwOMAt62dnFiCrOQycNUrTmpmNG2k+j2udzdnmRC11rkjO6nul5lA9WBzhY09UNlKWAkMrxJYCwNKq1lglRzAneUJlnYMpgOyJZ/dYc380vCEsbl9lk8X3aYfKbeTDssNawa45WYoVvYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rV9TyvPT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so3974858f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 09:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731432475; x=1732037275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r9C7zut+QQcjHwHSGcJuOPsgWncFr28LdU47xW3z+sc=;
        b=rV9TyvPToWZXbti6zhU50Nssa/1nt+aI3m+cDC9gH7nTFmfhY37gB2I2NxNOZwAxGd
         QoJ4aWK6mY+iIeWK2VkmyqMnRUdr39031pMN5g1Nr1pRf6V2NguTyhd2zbhq+kiBj/d3
         he0X3IaHIZwaLTNDFGU9MLGRDI1+a90r8g1EtIw6O4JQokNPs1kxaswxXD1Qy6JQtkFU
         huqWYZpgD7VKggtMM9hVfNUKDwVZQae6Dtl7iHV8vMymeRgr0E30sMj/6mwrLlOaV+CS
         adhdInBmajpmXP6MGHGtyrwShCnakpT1QFb8M8j+DR6buTIFAeA0BK6PywRrDdiDDMWI
         ygfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432475; x=1732037275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9C7zut+QQcjHwHSGcJuOPsgWncFr28LdU47xW3z+sc=;
        b=r8VB386SxvK/QTzbpp2kgfZoBABhdi+rZ6ZbkMFXHMBkgKUqzMWubB1U2tXoyPYu02
         s0CQhU0ojOKMEfZxHPHt8G6tv3iK8jFTWsAY9wBXVzGSAlCbQigMxjAA7Ug1S5ghrgIO
         V8dleHasuLH2ogs0UnXNLVOelhRg5CCtz9hmcIJLXR7osR2PzYgsQJCppC2ZrLVhBX3m
         A+5LLuRCMN9N/7eocsw9tvZ1VX0BfuwpTqgbe+ohB3DOMlHnxWI+/foKsfBfTPkJVYWJ
         n4TtDRMep6+J7qvGUhFhB7msDjt+StgFT0dLhj2xdUycj2bwpPSTspQARYaMifAOzIOa
         KATA==
X-Forwarded-Encrypted: i=1; AJvYcCW/fgiGA5xTLTuTEH6Rc6aY9v2XQD0P8ReZeGr2X1FNKzr0ukQX+dCZyENiXz+7nrX7KW2Z9YT8OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0ot+OJvzrFLuHgtriDoQnyJBpzazPBRoLlgNEzovMlfKYi6c
	gDcmLKFRfBpJufIeGMkx2FftFtyLCsnerD7knaRusR0nyYX5AYPpYD6tklboEuk=
X-Google-Smtp-Source: AGHT+IH5vPmQaPivGg0an3CBEX+0qooI5KTDMC56HM1MBHvWy2i4JiGZmehqc8VpzCO1+qgEokzUkg==
X-Received: by 2002:a5d:6d03:0:b0:37c:cfeb:e612 with SMTP id ffacd0b85a97d-381f17261e1mr14714587f8f.1.1731432474567;
        Tue, 12 Nov 2024 09:27:54 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:f548:3a80:2990:6de4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9f8984sm16180830f8f.71.2024.11.12.09.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:27:54 -0800 (PST)
Date: Tue, 12 Nov 2024 18:27:46 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: Add initial support for
 MSM8917
Message-ID: <ZzOQEgLLhkH-IymV@linaro.org>
References: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
 <20241112-msm8917-v5-8-3ca34d33191b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112-msm8917-v5-8-3ca34d33191b@mainlining.org>

On Tue, Nov 12, 2024 at 04:49:38PM +0100, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add initial support for MSM8917 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [reword commit, rebase, fix schema errors]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1974 +++++++++++++++++++++++++++++++++
>  1 file changed, 1974 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..cf0a0eec1141e11faca0ee9705d6348ab32a0f50
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> @@ -0,0 +1,1974 @@
> [...]
> +		domain-idle-states {
> +			cluster_sleep_0: cluster-sleep-0 {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x41000023>;
> +				entry-latency-us = <700>;
> +				exit-latency-us = <650>;
> +				min-residency-us = <1972>;
> +			};
> +
> +			cluster_sleep_1: cluster-sleep-1 {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x41000043>;
> +				entry-latency-us = <240>;
> +				exit-latency-us = <280>;
> +				min-residency-us = <806>;
> +			};

I think my comment here is still open:

This is strange, the deeper sleep state has lower timings than the
previous one?

> +
> +			cluster_sleep_2: cluster-sleep-2 {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x41000053>;
> +				entry-latency-us = <700>;
> +				exit-latency-us = <1000>;
> +				min-residency-us = <6500>;
> +			};
> +		};
> +
> [...]
> +		restart@4ab000 {
> +			compatible = "qcom,pshold";
> +			reg = <0x004ab000 0x4>;
> +		};

This one too:

You have PSCI for shutting down, do you actually need this?

> +
> +		tlmm: pinctrl@1000000 {
> +			compatible = "qcom,msm8917-pinctrl";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			gpio-ranges = <&tlmm 0 0 134>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> [...]
> +			sdc1_clk_on: sdc1-clk-on-state {
> +				pins = "sdc1_clk";
> +				bias-disable;
> +				drive-strength = <16>;
> +			};
> +
> +			sdc1_clk_off: sdc1-clk-off-state {
> +				pins = "sdc1_clk";
> +				bias-disable;
> +				drive-strength = <2>;
> +			};
> +
> +			sdc1_cmd_on: sdc1-cmd-on-state {
> +				pins = "sdc1_cmd";
> +				bias-disable;
> +				drive-strength = <10>;
> +			};
> +
> +			sdc1_cmd_off: sdc1-cmd-off-state {
> +				pins = "sdc1_cmd";
> +				bias-disable;
> +				drive-strength = <2>;
> +			};
> +
> +			sdc1_data_on: sdc1-data-on-state {
> +				pins = "sdc1_data";
> +				bias-pull-up;
> +				drive-strength = <10>;
> +			};
> +
> +			sdc1_data_off: sdc1-data-off-state {
> +				pins = "sdc1_data";
> +				bias-pull-up;
> +				drive-strength = <2>;
> +			};
> +
> +			sdc1_rclk_on: sdc1-rclk-on-state {
> +				pins = "sdc1_rclk";
> +				bias-pull-down;
> +			};
> +
> +			sdc1_rclk_off: sdc1-rclk-off-state {
> +				pins = "sdc1_rclk";
> +				bias-pull-down;
> +			};
> +
> +			sdc2_clk_on: sdc2-clk-on-state {
> +				pins = "sdc2_clk";
> +				drive-strength = <16>;
> +				bias-disable;
> +			};
> +
> +			sdc2_clk_off: sdc2-clk-off-state {
> +				pins = "sdc2_clk";
> +				bias-disable;
> +				drive-strength = <2>;
> +			};
> +
> +			sdc2_cmd_on: sdc2-cmd-on-state {
> +				pins = "sdc2_cmd";
> +				bias-pull-up;
> +				drive-strength = <10>;
> +			};
> +
> +			sdc2_cmd_off: sdc2-cmd-off-state {
> +				pins = "sdc2_cmd";
> +				bias-pull-up;
> +				drive-strength = <2>;
> +			};

These are not referenced anywhere? Not here in the sdhc_X nodes, and
also not in your msm8917-xiaomi-riva.dts. Would also recommend
consolidating these to a single node like in msm8916.dtsi, see commit
c943e4c58b2f ("arm64: dts: qcom: msm8916/39: Consolidate SDC pinctrl").

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c943e4c58b2ffb0dcd497f8b12f284f5e8fc477e

> +
> +			sdc2_cd_on: cd-on-state {
> +				pins = "gpio67";
> +				function = "gpio";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			sdc2_cd_off: cd-off-state {
> +				pins = "gpio67";
> +				function = "gpio";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};

It does not make sense to have different on/off states for the card
detect (CD) pin of the SD card. It needs to work even when the SD card
is suspended so we can detect insertions/removals. Also should be placed
in the board-specific DT part.

See commit dfbda20dabaa ("arm64: dts: qcom: msm8916/39: Fix SD card
detect pinctrl").

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dfbda20dabaa1f284abd550035db5887384c8e4c


> +
> +			sdc2_data_on: sdc2-data-on-state {
> +				pins = "sdc2_data";
> +				bias-pull-up;
> +				drive-strength = <10>;
> +			};
> +
> +			sdc2_data_off: sdc2-data-off-state {
> +				pins = "sdc2_data";
> +				bias-pull-up;
> +				drive-strength = <2>;
> +			};
> +
> [...]
> +		blsp1_i2c4: i2c@78b8000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b8000 0x500>;
> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
> +			dma-names = "tx", "rx";
> +			pinctrl-0 = <&blsp1_i2c4_default>;
> +			pinctrl-1 = <&blsp1_i2c4_sleep>;
> +			pinctrl-names = "default", "sleep";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		blsp2_i2c5: i2c@7af5000 {

This is actually blsp2_i2c1 if you look at the clock name below:

> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x07af5000 0x600>;
> +			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,

here ^

But I realize now that the pinctrl functions are consecutively numbered
without the BLSP number. Sorry for the confusion.

Basically:
  - blsp1_i2c2 == blsp_i2c2
  - blsp2_i2c1 == blsp_i2c5

Looking at some other examples upstream I guess you can choose between
one of the following options:

 1. msm8974/msm8976/msm8996/msm8998: Use &blspX_i2cY labels for the i2c@
    node and pinctrl and only have the slightly confusing pinctrl
    function. E.g. this in msm8976.dtsi:

			/* 4 (not 6!) interfaces per QUP, BLSP2 indexes are numbered (n)+4 */
			blsp2_i2c2_default: blsp2-i2c2-default-state {
				pins = "gpio22", "gpio23";
				function = "blsp_i2c6";
				drive-strength = <2>;
				bias-disable;
			};

    Note how blsp2_i2c2 == blsp_i2c6.

 2. msm8994: Use &blspX_i2cY labels for the i2c@ node, but keep pinctrl
    named &i2cN_default. E.g. this in msm8994.dtsi:

		blsp2_i2c1: i2c@f9963000 {
			/* ... */
			pinctrl-names = "default", "sleep";
			pinctrl-0 = <&i2c7_default>;
			pinctrl-1 = <&i2c7_sleep>;
			/* ... */
		};

    Note how blsp2_i2c1 == i2c7_default here.

 3. msm8953: Use &i2c_N labels everywhere like on downstream. E.g. this
    in msm8953.dtsi. This is pretty much what you had originally:

		i2c_5: i2c@7af5000 {
			/* ... */
			pinctrl-names = "default", "sleep";
			pinctrl-0 = <&i2c_5_default>;
			pinctrl-1 = <&i2c_5_sleep>;
			/* ... */
		};

All of these are fine for me. Feel free to pick the one you prefer. But
let's not introduce a new confusing variant of this. :-)

Thanks,
Stephan

