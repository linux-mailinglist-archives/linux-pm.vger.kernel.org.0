Return-Path: <linux-pm+bounces-17332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0879C41F6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 16:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E46B25456
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198519EEC2;
	Mon, 11 Nov 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="E7jzRMNy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B949625;
	Mon, 11 Nov 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339276; cv=none; b=PzxSihjU1p3bzjMQuU9u+681XnGRhRpdR5HaHHz0L25WG3HWPQAsANtayUO5rHE/mVLwBzP+Nbr5Lx6sifyBe4w2Jl5Jw7CzJpNIWeYz+cwX8LsI9A/PKabWJyj5pk0EDGsIbQWpKr7WJYWVBQQCYHKrWcVDabKMShlEFgQ2AY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339276; c=relaxed/simple;
	bh=s+r8MKSfjOUgsLlcKit7gbhB1uOR+p7/d0nO74Q29mc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HvDugNOjR1xpXj2izGAA3pbr3MFRBAycc8GKBAXF7TiRHjuoRfZtRUH28JAcoaPnVAqAnpxxPDwdh7580IHVhOKSziBfMxiWE/NJfwfLBEuwYmMrGOxuJ82/rYefu4KfaNVHAco8TeNwil9/fHlvg7tfn8UJkF6AKzFIvbpQp0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=E7jzRMNy; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 5D313E45C8;
	Mon, 11 Nov 2024 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731339266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgH5SDBs70jQ4C2U/avkzi9hwI1VhBBZzHkW8+ms7HI=;
	b=E7jzRMNyOIGQuTY31m7mi34wUHcZCy490mwQaIZ39ylLaTQY+lQQMeJpV++pCjfOD3RU+4
	LW17xHcNtAQwBcn8AMv8LxRNDWwX/vB62KczSVQbaeNJmMRJk8Ha8iuh2gyjembaYD3Q/y
	bCPQW41NUthuIjrGkXhPMMX9pbgDBsZj359KX+flJh0rqEI8sEDdj5xldYwa7LvKdvyV69
	+5KJTeDlpZfOA+kDr+/VnVsEmSivcSGGliCMjHZMqHGQfKb0rjqe3pNMdHNOkMwxpPRNon
	vLK17MEdir+Qr37ta3v3iXhXjiZh9AJhv7u1QH4zrQWIl53o+9oyeP++QKC1fw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 16:34:26 +0100
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
Subject: Re: [PATCH v4 08/10] arm64: dts: qcom: Add initial support for
 MSM8917
In-Reply-To: <ZzHf9J0Y2uB7_vy4@linaro.org>
References: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
 <20241109-msm8917-v4-8-8be9904792ab@mainlining.org>
 <ZzHf9J0Y2uB7_vy4@linaro.org>
Message-ID: <84ae6914700eff1ad66dd1048efeff97@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-11 11:44, Stephan Gerhold wrote:
> On Sat, Nov 09, 2024 at 01:08:10PM +0100, Barnabás Czémán wrote:
>> From: Otto Pflüger <otto.pflueger@abscue.de>
>> 
>> Add initial support for MSM8917 SoC.
>> 
>> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>> [reword commit, rebase, fix schema errors]
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1997 
>> +++++++++++++++++++++++++++++++++
>>  1 file changed, 1997 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi 
>> b/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..f866843772684c695069debfc764f7a0a58843bb
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> @@ -0,0 +1,1997 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <dt-bindings/clock/qcom,gcc-msm8917.h>
>> +#include <dt-bindings/clock/qcom,rpmcc.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/soc/qcom,apr.h>
>> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	aliases {
>> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
>> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
>> +	};
> 
> I think we put aliases in each board separately nowadays, see e.g.
> commit 154f23a8d70c ("arm64: dts: qcom: msm8916: Move aliases to
> boards").
> 
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
> This is strange, the deeper sleep state has lower timings than the
> previous one?
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
>> [...]
>> +
>> +	rpm: remoteproc {
>> +		compatible = "qcom,msm8917-rpm-proc", "qcom,rpm-proc";
>> +
>> +		smd-edge {
>> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>> +			qcom,ipc = <&apcs 8 0>;
> 
> Can you use mboxes here?
No, it cause deferred probe because of dependency cycle like at other 
SoCs where it was reverted.
> 
>> +			qcom,smd-edge = <15>;
>> +
>> [...]
>> +
>> +		mpss_mem: mpss@86800000 {
>> +			/*
>> +			 * The memory region for the mpss firmware is generally
>> +			 * relocatable and could be allocated dynamically.
>> +			 * However, many firmware versions tend to fail when
>> +			 * loaded to some special addresses, so it is hard to
>> +			 * define reliable alloc-ranges.
>> +			 *
>> +			 * alignment = <0x0 0x400000>;
>> +			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
>> +			 */
> 
> Not sure how many devices you have access to, but have you tried if 
> this
> is actually still the case? I'd have hoped they fixed those issues in
> the firmware.
> 
> Thanks for using alloc-ranges instead of fixed addresses BTW :)
> 
>> +			reg = <0x0 0x86800000 0x0 0>; /* size is device-specific */
>> +			no-map;
>> +			status = "disabled";
>> +		};
>> +
>> [...]
>> +	smp2p-adsp {
>> +		compatible = "qcom,smp2p";
>> +		qcom,smem = <443>, <429>;
>> +
>> +		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		mboxes = <&apcs 10>;
>> +
>> +		qcom,local-pid = <0>;
>> +		qcom,remote-pid = <2>;
>> +
>> +		adsp_smp2p_out: master-kernel {
>> +			qcom,entry-name = "master-kernel";
>> +
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		adsp_smp2p_in: slave-kernel {
>> +			qcom,entry-name = "slave-kernel";
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> +	smp2p-modem {
>> +		compatible = "qcom,smp2p";
>> +		qcom,smem = <435>, <428>;
>> +
>> +		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		qcom,ipc = <&apcs 8 14>;
> 
> You have mboxes for adsp above, what about modem and
Maybe i should set back qcom,ipc there.
> 
>> +
>> +		qcom,local-pid = <0>;
>> +		qcom,remote-pid = <1>;
>> +
>> +		modem_smp2p_out: master-kernel {
>> +			qcom,entry-name = "master-kernel";
>> +
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		modem_smp2p_in: slave-kernel {
>> +			qcom,entry-name = "slave-kernel";
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> +	smp2p-wcnss {
>> +		compatible = "qcom,smp2p";
>> +		qcom,smem = <451>, <431>;
>> +
>> +		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
>> +
>> +		qcom,ipc = <&apcs 8 18>;
> 
> ... wcnss?
> 
>> +
>> +		qcom,local-pid = <0>;
>> +		qcom,remote-pid = <4>;
>> +
>> +		wcnss_smp2p_out: master-kernel {
>> +			qcom,entry-name = "master-kernel";
>> +
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		wcnss_smp2p_in: slave-kernel {
>> +			qcom,entry-name = "slave-kernel";
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> [...]
>> +
>> +		restart@4ab000 {
>> +			compatible = "qcom,pshold";
>> +			reg = <0x004ab000 0x4>;
>> +		};
> 
> You have PSCI for shutting down, do you actually need this?
> 
>> [...]
>> +		blsp_i2c4: i2c@78b8000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b8000 0x500>;
>> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-0 = <&i2c4_default>;
>> +			pinctrl-1 = <&i2c4_sleep>;
>> +			pinctrl-names = "default", "sleep";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c5: i2c@7af5000 {
> 
> Please use a full label here with the BLSP number and QUP instance
> (&blspX_i2cY). This corresponds to the name of the clock, so this node
> is actually
> 
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x07af5000 0x600>;
>> +			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
> 
> ... &blsp2_i2c1.
> 
> I guess the current naming is taken from downstream, but I think they
> just assigned consecutive numbers to all the QUP instances they needed.
> This will cause headaches in the future if someone wants to add an
> instance that wasn't used by QC in the reference designs.
> 
>> +				 <&gcc GCC_BLSP2_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp2_dma 4>, <&blsp2_dma 5>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-0 = <&i2c5_default>;
>> +			pinctrl-1 = <&i2c5_sleep>;
> 
> &blsp2_i2c1_default/sleep for clarity
> 
>> +			pinctrl-names = "default", "sleep";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi6: spi@7af6000 {
> 
> &blsp2_spi2
> 
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x07af6000 0x600>;
>> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP2_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-0 = <&spi6_default>;
>> +			pinctrl-1 = <&spi6_sleep>;
> 
> &blsp2_spi2_default/sleep
> 
>> +			pinctrl-names = "default", "sleep";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> [...]
>> +		timer@b120000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			compatible = "arm,armv7-timer-mem";
>> +			reg = <0x0b120000 0x1000>;
>> +			clock-frequency = <19200000>;
> 
> Should be unneeded unless the firmware is broken. Can you try dropping
> it and see if you get a warning in dmesg?
> 
>> [...]
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <19200000>;
> 
> Same here.
> 
> Thanks,
> Stephan

