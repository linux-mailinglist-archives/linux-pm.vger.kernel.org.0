Return-Path: <linux-pm+bounces-16035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 243829A4E73
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CCE2B21DCD
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85A2CCB7;
	Sat, 19 Oct 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Cy+4E040"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A0219F3;
	Sat, 19 Oct 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346279; cv=none; b=jDjd+5RYOGxDerQRGfIp2hAsB3BuCUSpIqNd1jWJ630PL+VbgvEfnNKo/f7bl3Uxi5U6nGkD/yV9czUITcm/3o+caTU+RcHUX2S9EbEByTJp7fqY8S60OzBmebF4uqq0P2iVv6MDDvIzKQiD5DXIBojSNpgM6i+a0XAKaEBvSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346279; c=relaxed/simple;
	bh=8g9+2HwIF541+9jYV9AL8FBJ7Tokqe6OXf37hARaVvM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WJ9L4DASe4EDbtaIvCnj56OdwVjyeyuSbIt0L8TVJVtjDSNfJsFW29VgR3U8Lmb5pgUz/MDg7p9jdXV4sMbVc5rC0IqGaxrCJO8poJ1O9yoxFO28zVWfkcyvyOs0VcBzKgw8UYWCjQUpnkh9nEP3s1p3VMahB3UrNjbDdXyA1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Cy+4E040; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 52B59E4205;
	Sat, 19 Oct 2024 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729346274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TZoEXN+jQTs7P/rJc9WGlrP1+mOocaJGyqIIIC14uE=;
	b=Cy+4E0409IhWBeKYh2JROqyy0PKNrisCBRuvdSTnZdM4JBLV6KC/XbohHfqdv1erF2L16e
	WjMB98bPXU/mkY9JuxroLSHEzPREDAl94xD/iVYCRWmmqdWaYlB6i6ni9vKRBuYUJdcU/3
	JjYCDVkz6wzTcFTI7nYVVxoXi1AjvgMVcLAYPAYAr8XKstV+IKmZfz0drgdKhsojVLNLkt
	vWynftibkldmADuiaWhtMBGJ5vovGx0/BNCGs7ivktSnVDS2f9mH6tV00ysT6YV1S0Gz45
	+EEz/dLkr5PwKcLo9ZCZGoEdSvvum9vDFga15lyHlnBXoiqINtFe6eGJ03B5Gw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 15:57:54 +0200
From: barnabas.czeman@mainlining.org
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria
 <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH RFC 14/14] arm64: dts: qcom: Add Xiaomi Redmi 5A
In-Reply-To: <pyr3t3kcpjj5zor226fwembjsbpp5zh7mpe2a3bqmwnbqccj7h@a55efscym3s7>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-14-f1f3ca1d88e5@mainlining.org>
 <pyr3t3kcpjj5zor226fwembjsbpp5zh7mpe2a3bqmwnbqccj7h@a55efscym3s7>
Message-ID: <46f7b167220a7d54242e9457d00d67e2@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-19 15:48, Dmitry Baryshkov wrote:
> On Sat, Oct 19, 2024 at 01:50:51PM +0200, Barnabás Czémán wrote:
>> Add initial support for Xiaomi Redmi 5A (riva).
>> 
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile                |   1 +
>>  arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts | 295 
>> +++++++++++++++++++++++
>>  2 files changed, 296 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile 
>> b/arch/arm64/boot/dts/qcom/Makefile
>> index 
>> 065bb19481c16db2affd291826d420c83a89c52a..79add0e07d8a5f3362d70b0aaaaa9b8c48e31239 
>> 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -59,6 +59,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= 
>> msm8916-wingtech-wt86518.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt86528.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8917-xiaomi-riva.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8929-wingtech-wt82918hd.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts 
>> b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..7553f73603fc87797b0d424a2af6f2da65c90f5f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
>> @@ -0,0 +1,295 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Barnabas Czeman
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/arm/qcom,ids.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include "msm8917.dtsi"
>> +#include "pm8937.dtsi"
>> +
>> +/ {
>> +	model = "Xiaomi Redmi 5A (riva)";
>> +	compatible = "xiaomi,riva", "qcom,msm8917";
>> +	chassis-type = "handset";
>> +
>> +	qcom,msm-id = <QCOM_ID_MSM8917 0>;
>> +	qcom,board-id = <0x1000b 2>, <0x2000b 2>;
> 
> Is this required to boot?
Yes
> 
>> +
>> +	battery: battery {
>> +		compatible = "simple-battery";
>> +		charge-full-design-microamp-hours = <3000000>;
>> +		energy-full-design-microwatt-hours = <11500000>;
>> +		constant-charge-current-max-microamp = <1000000>;
>> +		constant-charge-voltage-max-microvolt = <4400000>;
>> +		precharge-current-microamp = <256000>;
>> +		charge-term-current-microamp = <60000>;
>> +		voltage-min-design-microvolt = <3400000>;
>> +	};
>> +
>> +	chosen {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		stdout-path = "framebuffer0";
>> +
>> +		framebuffer0: framebuffer@90001000 {
>> +			compatible = "simple-framebuffer";
>> +			reg = <0x0 0x90001000 0x0 (720 * 1280 * 3)>;
>> +			width = <720>;
>> +			height = <1280>;
>> +			stride = <(720 * 3)>;
>> +			format = "r8g8b8";
>> +
>> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +				 <&gcc GCC_MDSS_AXI_CLK>,
>> +				 <&gcc GCC_MDSS_VSYNC_CLK>,
>> +				 <&gcc GCC_MDSS_MDP_CLK>,
>> +				 <&gcc GCC_MDSS_BYTE0_CLK>,
>> +				 <&gcc GCC_MDSS_PCLK0_CLK>,
>> +				 <&gcc GCC_MDSS_ESC0_CLK>;
>> +			power-domains = <&gcc MDSS_GDSC>;
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		key-volup {
>> +			label = "Volume Up";
>> +			linux,code = <KEY_VOLUMEUP>;
>> +			gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <15>;
>> +		};
>> +	};
>> +
>> +	reserved-memory {
>> +		/delete-node/ reserved@85b00000;
>> +		qseecom_mem: reserved@84a00000 {
>> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
>> +			no-map;
>> +		};
>> +
>> +		framebuffer_mem: memory@90001000 {
>> +			reg = <0x0 0x90001000 0x0 (720 * 1280 * 3)>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	vph_pwr: vph-pwr-regulator {
> 
> regulator-vph-pwr, please
> 
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vph_pwr";
>> +		regulator-min-microvolt = <3700000>;
>> +		regulator-max-microvolt = <3700000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +};
>> +
>> +&blsp_i2c3 {
>> +	status = "okay";
>> +
>> +	touchscreen@38 {
>> +		compatible = "edt,edt-ft5306";
>> +		reg = <0x38>;
>> +		interrupt-parent = <&tlmm>;
>> +		interrupts = <65 0x2008>;
>> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
>> +		vcc-supply = <&pm8937_l10>;
>> +		iovcc-supply = <&pm8937_l5>;
>> +
>> +		touchscreen-size-x = <720>;
>> +		touchscreen-size-y = <1280>;
>> +	};
>> +};
>> +
>> +&blsp_i2c5 {
>> +	status = "okay";
>> +
>> +	bq27426@55 {
>> +		compatible = "ti,bq27426";
>> +		reg = <0x55>;
>> +		monitored-battery = <&battery>;
>> +	};
>> +
>> +	bq25601@6b{
>> +		compatible = "ti,bq25601";
>> +		reg = <0x6b>;
>> +		monitored-battery = <&battery>;
>> +
>> +		interrupt-parent = <&tlmm>;
>> +		interrupts = <61 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +		input-voltage-limit-microvolt = <4400000>;
>> +		input-current-limit-microamp = <1000000>;
>> +	};
>> +};
>> +
>> +&pm8937_resin {
>> +	linux,code = <KEY_VOLUMEDOWN>;
>> +	status = "okay";
>> +};
>> +
>> +&pm8937_spmi_regulators {
>> +	pm8937_s5: s5 {
> 
> Which regulator is this?
> 
>> +		regulator-min-microvolt = <1050000>;
>> +		regulator-max-microvolt = <1350000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +};
>> +
> 
> [..]
> 
>> +
>> +&wcnss {
>> +	vddpx-supply = <&pm8937_l5>;
>> +	status = "okay";
>> +
> 
> rogue empty line
> 
>> +};
>> +
>> +&wcnss_iris {
>> +	compatible = "qcom,wcn3620";
>> +	vddxo-supply = <&pm8937_l7>;
>> +	vddrfa-supply = <&pm8937_l19>;
>> +	vddpa-supply = <&pm8937_l9>;
>> +	vdddig-supply = <&pm8937_l5>;
>> +};
>> +
>> +&wcnss_mem {
>> +	status = "okay";
>> +};
>> 
>> --
>> 2.47.0
>> 

