Return-Path: <linux-pm+bounces-16145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7249A91DC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 23:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5B31C22BFD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA9F1FDF9C;
	Mon, 21 Oct 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="jaaAJzxo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBA1FCC54;
	Mon, 21 Oct 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545308; cv=none; b=abdmK/vVsPwnSzsoqwbpi1kuA2aR6uSPi22myhki1ob8xp5cmPw1GkzMNVfriBEzwYzR878UFc8cl4/d3RqjUmmuwAOUx/OGuDgTPtQ10fozZYGycABcbwBImhgBBLdl52g7Txofkook6E+AiYvdvd4PDE5apZEkE7TsbXJDeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545308; c=relaxed/simple;
	bh=VWfaZX+Y/ryw5Uuk7731lsM+JgCF2dv2GJzm8gVHnv0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pgZk5d3xptdLVXyI/ATCGaOsztGndqgfcXjY9vkm6DQcY2o7UexYeqZS1vLAMBLcfPBwejUpNEc9v/UO4FliSnTYPSAeAcVCnJ2JYPfUZynOgrB7ewYQSEJT/3hyyXRjjIV0jYNRmXnTyYpgTPv9aZC4JvNF08nizH6UdPek678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=jaaAJzxo; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 07E38E459D;
	Mon, 21 Oct 2024 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729545296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHzBdVzuBppf1gqmqMV5XAJagDCb9Y+FAqD9V5XeUJo=;
	b=jaaAJzxot9ysi7bsKKxfvNPgpcnFEfzpE+KTeWZlqS+uYf73lUayi8q97Ef0gDn8RWJAby
	lOBGhJNVr3/YExxezjP8R8TQ294YtlltIwyUU/v+Ir1t8NXlvHoYyuKRuvWhwps3bmu8/P
	GNSRMbS961k2QsyhN3xatFGwwTIS4unFL34DTQMDE/IaaXv5jjzKLpdkj5bOGygIYXCUrc
	WPa2bwPi+xq/JT3M9x5qHk4oJuvzPHWXKB1KrP9mtmyg1X9ANnGEtwYuMInqte3RRv9M+j
	rNS3CgS72xGu8nSHXw96YK4Tld8VtQJuAJUrZNDccNQ08CX5+fQubSM5vnvo2g==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 23:14:55 +0200
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
 iommu@lists.linux.dev, =?UTF-8?Q?Otto_Pfl=C3=BCger?=
 <otto.pflueger@abscue.de>
Subject: Re: [PATCH RFC 12/14] arm64: dts: qcom: Add initial support for
 MSM8917
In-Reply-To: <2iayllvk5ohrmbhnn7up5gvys2ijzxuyf44c53uwcbsunre6np@ncrimgac2idz>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-12-f1f3ca1d88e5@mainlining.org>
 <2iayllvk5ohrmbhnn7up5gvys2ijzxuyf44c53uwcbsunre6np@ncrimgac2idz>
Message-ID: <19884457f1133a20a6ad014a75906e55@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-10-19 15:43, Dmitry Baryshkov wrote:
> On Sat, Oct 19, 2024 at 01:50:49PM +0200, Barnabás Czémán wrote:
>> From: Otto Pflüger <otto.pflueger@abscue.de>
>> 
>> Add initial support for MSM8917 SoC.
>> 
>> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>> [reword commit, rebase, fix schema errors]
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8917-pins.dtsi |  344 ++++++
>>  arch/arm64/boot/dts/qcom/msm8917.dtsi      | 1557 
>> ++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/pm8916.dtsi       |    9 +-
>>  3 files changed, 1909 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi 
>> b/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..f283ffd59b8aca8e510ef95d5526af9592a1c036
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi
> 
> Please merge into msm8917.dtsi (for generic parts) and
> msm8917-boatd.dtsi (for board-specific parts).
> 
>> @@ -0,0 +1,344 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> If possible, GPL-2.0 OR MIT, or GPL-2.0 OR BSD-2/3-Clause
Unfortunatelly i cannot change the license i do not own the original 
code.
> 
>> +&tlmm {
>> +	blsp1_uart1_default: blsp1-uart1-default-state {
>> +		pins = "gpio0", "gpio1", "gpio2", "gpio3";
>> +		function = "blsp_uart1";
>> +
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
>> +		pins = "gpio0", "gpio1", "gpio2", "gpio3";
>> +		function = "gpio";
>> +
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
> 
> Please sort all the pin states by the node name.
> 
>> +
>> +	wcnss_pin_a: wcnss-active-state {
>> +		wcss-wlan2-pins {
>> +			pins = "gpio76";
>> +			function = "wcss_wlan2";
>> +			drive-strength = <6>;
>> +			bias-pull-up;
>> +
>> +		};
>> +
>> +		wcss-wlan1-pins {
> 
> and subnodes too.
> 
>> +			pins = "gpio77";
>> +			function = "wcss_wlan1";
>> +			drive-strength = <6>;
>> +			bias-pull-up;
>> +
>> +		};
>> +
>> +		wcss-wlan0-pins {
>> +			pins = "gpio78";
>> +			function = "wcss_wlan0";
>> +			drive-strength = <6>;
>> +			bias-pull-up;
>> +
>> +		};
>> +
>> +		wcss-wlan-pins {
>> +			pins = "gpio79", "gpio80";
>> +			function = "wcss_wlan";
>> +			drive-strength = <6>;
>> +			bias-pull-up;
>> +
>> +		};
>> +	};
>> +
>> +	cci0_default: cci0-default-state {
>> +		pins = "gpio29", "gpio30";
>> +		function = "cci_i2c";
>> +
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	cci1_default: cci1-default-state {
>> +		pins = "gpio31", "gpio32";
>> +		function = "cci_i2c";
>> +
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	cdc_pdm_lines_act: pdm-lines-on-state {
>> +		pins = "gpio69", "gpio70", "gpio71", "gpio72",
>> +		       "gpio73", "gpio74";
>> +		function = "cdc_pdm0";
>> +
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +	};
>> +
>> +	cdc_pdm_lines_sus: pdm-lines-off-state {
>> +		pins = "gpio69", "gpio70", "gpio71", "gpio72",
>> +		       "gpio73", "gpio74";
>> +		function = "cdc_pdm0";
>> +
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi 
>> b/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..e5f580c6ec28ad6442b31a0e1ee256c376c5438d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
>> @@ -0,0 +1,1557 @@
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
>> +
>> +	chosen { };
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the reg */
>> +		reg = <0 0x80000000 0 0>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		reserved@85b00000 {
>> +			reg = <0x0 0x85b00000 0x0 0x800000>;
>> +			no-map;
>> +		};
>> +
>> +		smem@86300000 {
>> +			compatible = "qcom,smem";
>> +			reg = <0x0 0x86300000 0x0 0x100000>;
>> +			no-map;
>> +
>> +			hwlocks = <&tcsr_mutex 3>;
>> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
>> +		};
>> +
>> +		reserved@86400000 {
>> +			reg = <0x0 0x86400000 0x0 0x400000>;
>> +			no-map;
>> +		};
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
>> +			reg = <0x0 0x86800000 0x0 0>; /* size is device-specific */
>> +			no-map;
>> +			status = "disabled";
>> +		};
>> +
>> +		adsp_mem: adsp {
>> +			size = <0x0 0x1100000>;
>> +			alignment = <0x0 0x100000>;
>> +			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
>> +			no-map;
>> +			status = "disabled";
>> +		};
>> +
>> +		wcnss_mem: wcnss {
>> +			size = <0x0 0x700000>;
>> +			alignment = <0x0 0x100000>;
>> +			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
>> +			no-map;
>> +			status = "disabled";
>> +		};
>> +
>> +		venus_mem: venus {
>> +			size = <0x0 0x400000>;
>> +			alignment = <0x0 0x100000>;
>> +			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
>> +			no-map;
>> +			status = "disabled";
>> +		};
>> +
>> +		mba_mem: mba {
> 
> Please sort these nodes too.
> 
>> +			size = <0x0 0x100000>;
>> +			alignment = <0x0 0x100000>;
>> +			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
>> +			no-map;
>> +			status = "disabled";
>> +		};
>> +
>> +		rmtfs@92100000 {
> 
> This one should be after mpss_mem, just before adsp.
> 
>> +			compatible = "qcom,rmtfs-mem";
>> +			reg = <0x0 0x92100000 0x0 0x180000>;
>> +			no-map;
>> +
>> +			qcom,client-id = <1>;
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
> 
> lowercase all labels.
> 
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x100>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +			clocks = <&apcs>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +			power-domains = <&CPU_PD0>;
>> +			power-domain-names = "psci";
>> +		};
>> +
>> +		CPU1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x101>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +			clocks = <&apcs>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +			power-domains = <&CPU_PD1>;
>> +			power-domain-names = "psci";
>> +		};
>> +
>> +		CPU2: cpu@2 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x102>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +			clocks = <&apcs>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +			power-domains = <&CPU_PD2>;
>> +			power-domain-names = "psci";
>> +		};
>> +
>> +		CPU3: cpu@3 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53";
>> +			reg = <0x103>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +			clocks = <&apcs>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +			power-domains = <&CPU_PD3>;
>> +			power-domain-names = "psci";
>> +		};
>> +
>> +		L2_0: l2-cache {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-unified;
>> +		};
>> +
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&CPU0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&CPU1>;
>> +				};
>> +
>> +				core2 {
>> +					cpu = <&CPU2>;
>> +				};
>> +
>> +				core3 {
>> +					cpu = <&CPU3>;
>> +				};
>> +			};
>> +		};
>> +
>> +		idle-states {
>> +			entry-method = "psci";
>> +
>> +			CPU_SLEEP_0: cpu-sleep-0 {
>> +				compatible = "arm,idle-state";
>> +				idle-state-name = "standalone-power-collapse";
>> +				arm,psci-suspend-param = <0x40000003>;
>> +				entry-latency-us = <125>;
>> +				exit-latency-us = <180>;
>> +				min-residency-us = <595>;
>> +				local-timer-stop;
>> +			};
>> +		};
>> +
>> +		domain-idle-states {
>> +			CLUSTER_PWRDN: cluster-gdhs {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x41000043>;
>> +				entry-latency-us = <240>;
>> +				exit-latency-us = <280>;
>> +				min-residency-us = <806>;
>> +			};
>> +
>> +			CLUSTER_RET: cluster-retention {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x41000023>;
>> +				entry-latency-us = <700>;
>> +				exit-latency-us = <650>;
>> +				min-residency-us = <1972>;
>> +			};
>> +
>> +			CLUSTER_PC: cluster-power-collapse {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x41000053>;
>> +				entry-latency-us = <700>;
>> +				exit-latency-us = <1000>;
>> +				min-residency-us = <6500>;
>> +			};
>> +		};
>> +	};
>> +
>> +	cpu_opp_table: opp-table-cpu {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-960000000 {
>> +			opp-hz = /bits/ 64 <960000000>;
>> +		};
>> +
>> +		opp-1094400000 {
>> +			opp-hz = /bits/ 64 <1094400000>;
>> +		};
>> +
>> +		opp-1248000000 {
>> +			opp-hz = /bits/ 64 <1248000000>;
>> +		};
>> +
>> +		opp-1401600000 {
>> +			opp-hz = /bits/ 64 <1401600000>;
>> +		};
>> +	};
>> +
>> +	timer {
> 
> Again, please sort the nodes.
> 
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <19200000>;
>> +	};
>> +
>> +	clocks {
>> +		xo_board: xo-board {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <19200000>;
>> +			clock-output-names = "xo";
> 
> Freq goes to the board dts.
> Please drop clock-output-names.
> 
>> +		};
>> +
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <32768>;
>> +			clock-output-names = "sleep_clk";
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		scm: scm {
>> +			compatible = "qcom,scm-msm8916", "qcom,scm";
>> +			clocks = <&gcc GCC_CRYPTO_CLK>,
>> +				 <&gcc GCC_CRYPTO_AXI_CLK>,
>> +				 <&gcc GCC_CRYPTO_AHB_CLK>;
>> +			clock-names = "core", "bus", "iface";
>> +			#reset-cells = <1>;
>> +
>> +			qcom,dload-mode = <&tcsr 0x6100>;
>> +		};
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,cortex-a53-pmu";
>> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | 
>> IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +
>> +		CPU_PD0: power-domain-cpu0 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD1: power-domain-cpu1 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD2: power-domain-cpu2 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_SLEEP_0>;
>> +		};
>> +
>> +		CPU_PD3: power-domain-cpu3 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_SLEEP_0>;
>> +		};
>> +
>> +		CLUSTER_PD: power-domain-cluster {
>> +			#power-domain-cells = <0>;
>> +			domain-idle-states = <&CLUSTER_PWRDN>, <&CLUSTER_RET>, 
>> <&CLUSTER_PC>;
>> +		};
>> +	};
>> +
>> +	rpm: remoteproc {
>> +		compatible = "qcom,msm8917-rpm-proc", "qcom,rpm-proc";
>> +
>> +		smd-edge {
>> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>> +			qcom,ipc = <&apcs 8 0>;
>> +			qcom,smd-edge = <15>;
>> +
>> +			rpm_requests: rpm-requests {
>> +				compatible = "qcom,rpm-msm8917", "qcom,smd-rpm";
>> +				qcom,smd-channels = "rpm_requests";
>> +
>> +				rpmcc: clock-controller {
>> +					compatible = "qcom,rpmcc-msm8917", "qcom,rpmcc";
>> +					#clock-cells = <1>;
>> +					clocks = <&xo_board>;
>> +					clock-names = "xo";
>> +				};
>> +
>> +				rpmpd: power-controller {
>> +					compatible = "qcom,msm8917-rpmpd";
>> +					#power-domain-cells = <1>;
>> +					operating-points-v2 = <&rpmpd_opp_table>;
>> +
>> +					rpmpd_opp_table: opp-table {
>> +						compatible = "operating-points-v2";
>> +
>> +						rpmpd_opp_ret: opp1 {
>> +							opp-level = <RPM_SMD_LEVEL_RETENTION>;
>> +						};
>> +
>> +						rpmpd_opp_ret_plus: opp2 {
>> +							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
>> +						};
>> +
>> +						rpmpd_opp_min_svs: opp3 {
>> +							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
>> +						};
>> +
>> +						rpmpd_opp_low_svs: opp4 {
>> +							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
>> +						};
>> +
>> +						rpmpd_opp_svs: opp5 {
>> +							opp-level = <RPM_SMD_LEVEL_SVS>;
>> +						};
>> +
>> +						rpmpd_opp_svs_plus: opp6 {
>> +							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
>> +						};
>> +
>> +						rpmpd_opp_nom: opp7 {
>> +							opp-level = <RPM_SMD_LEVEL_NOM>;
>> +						};
>> +
>> +						rpmpd_opp_nom_plus: opp8 {
>> +							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
>> +						};
>> +
>> +						rpmpd_opp_turbo: opp9 {
>> +							opp-level = <RPM_SMD_LEVEL_TURBO>;
>> +						};
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +
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
>> +	smsm {
>> +		compatible = "qcom,smsm";
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		qcom,ipc-1 = <&apcs 8 13>;
>> +		qcom,ipc-3 = <&apcs 8 19>;
> 
> Please use mboxes instead
> 
>> +
>> +		apps_smsm: apps@0 {
>> +			reg = <0>;
>> +
>> +			#qcom,smem-state-cells = <1>;
>> +		};
>> +
>> +		hexagon_smsm: hexagon@1 {
>> +			reg = <1>;
>> +			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +
>> +		wcnss_smsm: wcnss@6 {
>> +			reg = <6>;
>> +			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +		};
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
>> +		compatible = "simple-bus";
>> +
>> +		rng@22000 {
>> +			compatible = "qcom,prng";
>> +			reg = <0xe3000 0x1000>;
>> +			clocks = <&gcc GCC_PRNG_AHB_CLK>;
>> +			clock-names = "core";
>> +		};
>> +
>> +		restart@4ab000 {
>> +			compatible = "qcom,pshold";
>> +			reg = <0x004ab000 0x4>;
>> +		};
>> +
>> +		qfprom: qfprom@a4000 {
>> +			compatible = "qcom,msm8917-qfprom", "qcom,qfprom";
>> +			reg = <0x000a4000 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
> 
> empty line
> 
>> +			tsens_caldata: caldata@d0 {
>> +				reg = <0x01d8 0x14>;
>> +			};
> 
> No, individual bit definitions for each of tsens fuse values.
> 
>> +		};
>> +
>> +		rpm_msg_ram: sram@60000 {
>> +			compatible = "qcom,rpm-msg-ram";
>> +			reg = <0x00060000 0x8000>;
>> +		};
>> +
>> +		tsens: thermal-sensor@4a9000 {
>> +			compatible = "qcom,msm8917-tsens", "qcom,tsens-v1";
>> +			reg = <0x004a9000 0x1000>,
>> +			      <0x004a8000 0x1000>;
>> +			nvmem-cells = <&tsens_caldata>;
>> +			nvmem-cell-names = "calib";
> 
> And here too, individual bits instead of a single blob.
I do not know how to do that i have only find some parts at downstream 
driver to be able to separate
the cells but i do not have every information for it.
> 
>> +			#qcom,sensors = <10>;
>> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "uplow";
>> +			#thermal-sensor-cells = <1>;
>> +		};
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
>> +		};
>> +
>> +		gcc: clock-controller@1800000 {
>> +			compatible = "qcom,gcc-msm8917";
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +			reg = <0x01800000 0x80000>;
>> +			clocks = <&xo_board>,
>> +				 <&sleep_clk>,
>> +				 <&mdss_dsi0_phy 1>,
>> +				 <&mdss_dsi0_phy 0>;
>> +			clock-names = "xo",
>> +				      "sleep_clk",
>> +				      "dsi0pll",
>> +				      "dsi0pllbyte";
>> +		};
>> +
>> +		tcsr_mutex: hwlock@1905000 {
>> +			compatible = "qcom,tcsr-mutex";
>> +			reg = <0x01905000 0x20000>;
>> +			#hwlock-cells = <1>;
>> +		};
>> +
>> +		tcsr: syscon@1937000 {
>> +			compatible = "qcom,tcsr-msm8917", "syscon";
>> +			reg = <0x01937000 0x30000>;
>> +		};
>> +
>> +		apps_iommu: iommu@1e00000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			#iommu-cells = <1>;
>> +			compatible = "qcom,msm8917-iommu", "qcom,msm-iommu-v1";
>> +			ranges = <0 0x01e20000 0x20000>;
>> +
>> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
>> +				 <&gcc GCC_APSS_TCU_CLK>;
>> +			clock-names = "iface", "bus";
>> +
>> +			qcom,iommu-secure-id = <17>;
>> +
>> +			/* VFE */
>> +			iommu-ctx@14000 {
>> +				compatible = "qcom,msm-iommu-v1-ns";
>> +				reg = <0x00014000 0x1000>;
>> +				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			/* MDP_0 */
>> +			iommu-ctx@15000 {
>> +				compatible = "qcom,msm-iommu-v1-ns";
>> +				reg = <0x00015000 0x1000>;
>> +				interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			/* VENUS_NS */
>> +			iommu-ctx@16000 {
>> +				compatible = "qcom,msm-iommu-v1-ns";
>> +				reg = <0x00016000 0x1000>;
>> +				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +		};
>> +
>> +		gpu_iommu: iommu@1f00000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			#iommu-cells = <1>;
>> +
>> +			compatible = "qcom,msm8917-iommu", "qcom,msm-iommu-v1";
>> +
>> +			ranges = <0 0x01f08000 0x10000>;
>> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
>> +				 <&gcc GCC_GFX_TCU_CLK>;
>> +			clock-names = "iface", "bus";
>> +			qcom,iommu-secure-id = <18>;
>> +
>> +			iommu-ctx@0 {
>> +				compatible = "qcom,msm-iommu-v2-ns";
>> +				reg = <0x0000 0x1000>;
>> +				interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +		};
>> +
>> +		mdss: display-subsystem@1a00000 {
> 
> Please keep the nodes sorted by the address.
> 
>> +			compatible = "qcom,mdss";
>> +			reg = <0x01a00000 0x1000>,
>> +			      <0x01ab0000 0x1040>;
>> +			reg-names = "mdss_phys", "vbif_phys";
>> +
>> +			power-domains = <&gcc MDSS_GDSC>;
>> +
>> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +				 <&gcc GCC_MDSS_AXI_CLK>,
>> +				 <&gcc GCC_MDSS_VSYNC_CLK>;
>> +			clock-names = "iface",
>> +				      "bus",
>> +				      "vsync";
>> +
>> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			status = "disabled";
>> +
>> +			mdp: display-controller@1a01000 {
>> +				compatible = "qcom,msm8917-mdp5", "qcom,mdp5";
>> +				reg = <0x01a01000 0x89000>;
>> +				reg-names = "mdp_phys";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <0>;
>> +
>> +				power-domains = <&gcc MDSS_GDSC>;
>> +
>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>> +					 <&gcc GCC_MDSS_MDP_CLK>,
>> +					 <&gcc GCC_MDSS_VSYNC_CLK>;
>> +				clock-names = "iface",
>> +					      "bus",
>> +					      "core",
>> +					      "vsync";
>> +
>> +				iommus = <&apps_iommu 0x15>;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
> 
> Please add missing empty lines between properties and subnodes.
> 
>> +						mdp5_intf1_out: endpoint {
> 
> mdss_mdp_intf1_out:
> 
>> +							remote-endpoint = <&mdss_dsi0_in>;
>> +						};
>> +					};
>> +				};
>> +			};
>> +
>> +			mdss_dsi0: dsi@1a94000 {
>> +				compatible = "qcom,mdss-dsi-ctrl";
>> +				reg = <0x01a94000 0x300>;
>> +				reg-names = "dsi_ctrl";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <4>;
>> +
>> +				assigned-clocks = <&gcc BYTE0_CLK_SRC>,
>> +						  <&gcc PCLK0_CLK_SRC>;
>> +				assigned-clock-parents = <&mdss_dsi0_phy 0>,
>> +							 <&mdss_dsi0_phy 1>;
>> +
>> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
>> +					 <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
>> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
>> +					 <&gcc GCC_MDSS_ESC0_CLK>;
>> +				clock-names = "mdp_core",
>> +					      "iface",
>> +					      "bus",
>> +					      "byte",
>> +					      "pixel",
>> +					      "core";
>> +				phys = <&mdss_dsi0_phy>;
>> +
>> +				operating-points-v2 = <&mdss_dsi0_opp_table>;
>> +				power-domains = <&rpmpd MSM8917_VDDCX>;
>> +
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						mdss_dsi0_in: endpoint {
>> +							remote-endpoint = <&mdp5_intf1_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						mdss_dsi0_out: endpoint {
>> +						};
>> +					};
>> +				};
>> +
>> +				mdss_dsi0_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-125000000 {
>> +						opp-hz = /bits/ 64 <125000000>;
>> +						required-opps = <&rpmpd_opp_svs>;
>> +					};
>> +
>> +					opp-187500000 {
>> +						opp-hz = /bits/ 64 <187500000>;
>> +						required-opps = <&rpmpd_opp_nom>;
>> +					};
>> +				};
>> +			};
>> +
>> +			mdss_dsi0_phy: phy@1a94400 {
>> +				compatible = "qcom,dsi-phy-28nm-8937";
>> +				reg = <0x01a94a00 0xd4>,
>> +				      <0x01a94400 0x280>,
>> +				      <0x01a94b80 0x30>;
>> +				reg-names = "dsi_pll",
>> +					    "dsi_phy",
>> +					    "dsi_phy_regulator";
>> +
>> +				#clock-cells = <1>;
>> +				#phy-cells = <0>;
>> +
>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&xo_board>;
>> +				clock-names = "iface", "ref";
>> +			};
>> +		};
>> +
>> +		a53pll: clock@b016000 {
>> +			compatible = "qcom,msm8939-a53pll";
>> +			reg = <0x0b016000 0x40>;
>> +			clocks = <&xo_board>;
>> +			clock-names = "xo";
>> +			#clock-cells = <0>;
>> +			operating-points-v2 = <&pll_opp_table>;
>> +
>> +			pll_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-960000000 {
>> +					opp-hz = /bits/ 64 <960000000>;
>> +				};
>> +
>> +				opp-1094400000 {
>> +					opp-hz = /bits/ 64 <1094400000>;
>> +				};
>> +
>> +				opp-1248000000 {
>> +					opp-hz = /bits/ 64 <1248000000>;
>> +				};
>> +
>> +				opp-1401600000 {
>> +				      opp-hz = /bits/ 64 <1401600000>;
>> +				};
>> +			};
>> +		};
>> +
>> +		gpu: gpu@1c00000 {
>> +			compatible = "qcom,adreno-306.32", "qcom,adreno";
> 
> Is it really .32 ?
Yes it is A306A (Adreno 308)
> 
>> +			reg = <0x01c00000 0x20000>;
>> +			reg-names = "kgsl_3d0_reg_memory";
>> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "kgsl_3d0_irq";
>> +			clock-names = "core",
>> +				      "iface",
>> +				      "mem_iface",
>> +				      "alt_mem_iface",
>> +				      "gfx3d";
>> +			clocks = <&gcc GCC_OXILI_GFX3D_CLK>,
>> +				 <&gcc GCC_OXILI_AHB_CLK>,
>> +				 <&gcc GCC_BIMC_GFX_CLK>,
>> +				 <&gcc GCC_BIMC_GPU_CLK>,
>> +				 <&gcc GFX3D_CLK_SRC>;
>> +			power-domains = <&gcc OXILI_GX_GDSC>;
>> +			operating-points-v2 = <&gpu_opp_table>;
>> +			#cooling-cells = <2>;
>> +
>> +			iommus = <&gpu_iommu 0>;
>> +
>> +			status = "disabled";
>> +
>> +			gpu_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-598000000 {
>> +					opp-hz = /bits/ 64 <598000000>;
>> +				};
>> +
>> +				opp-523200000 {
>> +					opp-hz = /bits/ 64 <523200000>;
>> +				};
>> +
>> +				opp-484800000 {
>> +					opp-hz = /bits/ 64 <484800000>;
>> +				};
>> +
>> +				opp-400000000 {
>> +					opp-hz = /bits/ 64 <400000000>;
>> +				};
>> +
>> +				opp-270000000 {
>> +					opp-hz = /bits/ 64 <270000000>;
>> +				};
>> +
>> +				opp-19200000 {
>> +					opp-hz = /bits/ 64 <19200000>;
>> +				};
>> +			};
>> +		};
>> +
>> +		spmi_bus: spmi@200f000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg = <0x0200f000 0x001000>,
>> +			      <0x02400000 0x800000>,
>> +			      <0x02c00000 0x800000>,
>> +			      <0x03800000 0x200000>,
>> +			      <0x0200a000 0x002100>;
>> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>> +			interrupt-names = "periph_irq";
>> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
>> +			qcom,ee = <0>;
>> +			qcom,channel = <0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <4>;
>> +		};
>> +
>> +		bam_dmux_dma: dma-controller@4044000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0x04044000 0x19000>;
>> +			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			qcom,ee = <0>;
>> +
>> +			num-channels = <6>;
>> +			qcom,num-ees = <1>;
>> +			qcom,powered-remotely;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		apcs: mailbox@b011000 {
>> +			compatible = "qcom,msm8939-apcs-kpss-global", "syscon";
>> +			reg = <0x0b011000 0x1000>;
>> +			#mbox-cells = <1>;
>> +			clocks = <&a53pll>, <&gcc GPLL0_EARLY>, <&rpmcc 
>> RPM_SMD_XO_CLK_SRC>;
>> +			clock-names = "pll", "aux", "ref";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		sdhc_1: mmc@7824900 {
>> +			compatible = "qcom,sdhci-msm-v4";
>> +			reg = <0x07824900 0x500>, <0x07824000 0x800>;
>> +			reg-names = "hc", "core";
>> +
>> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>> +				 <&xo_board>;
>> +			clock-names = "iface", "core", "xo";
>> +			power-domains = <&rpmpd MSM8917_VDDCX>;
>> +			mmc-hs200-1_8v;
>> +			mmc-hs400-1_8v;
>> +			mmc-ddr-1_8v;
>> +			bus-width = <8>;
>> +			non-removable;
>> +			status = "disabled";
>> +		};
>> +
>> +		sdhc_2: mmc@7864900 {
>> +			compatible = "qcom,sdhci-msm-v4";
>> +			reg = <0x07864900 0x500>, <0x07864000 0x800>;
>> +			reg-names = "hc", "core";
>> +
>> +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>> +				 <&gcc GCC_SDCC2_APPS_CLK>,
>> +				 <&xo_board>;
>> +			clock-names = "iface", "core", "xo";
>> +			power-domains = <&rpmpd MSM8917_VDDCX>;
>> +			bus-width = <4>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp1_dma: dma-controller@7884000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0x07884000 0x1f000>;
>> +			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "bam_clk";
>> +			qcom,controlled-remotely;
>> +			#dma-cells = <1>;
>> +			num-channels = <12>;
>> +			qcom,num-ees = <4>;
>> +			qcom,ee = <0>;
>> +		};
>> +
>> +		blsp2_dma: dma-controller@7ac4000 {
>> +			compatible = "qcom,bam-v1.7.0";
>> +			reg = <0x07ac4000 0x1d000>;
>> +			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
>> +			clock-names = "bam_clk";
>> +			qcom,controlled-remotely;
>> +			#dma-cells = <1>;
>> +			num-channels = <10>;
>> +			qcom,num-ees = <4>;
>> +			qcom,ee = <0>;
>> +		};
>> +
>> +		blsp1_uart1: serial@78af000 {
>> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +			reg = <0x078af000 0x200>;
>> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp1_dma 0>, <&blsp1_dma 1>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&blsp1_uart1_default>;
>> +			pinctrl-1 = <&blsp1_uart1_sleep>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp1_uart2: serial@78b0000 {
>> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +			reg = <0x078b0000 0x200>;
>> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&blsp1_uart2_default>;
>> +			pinctrl-1 = <&blsp1_uart2_sleep>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c2: i2c@78b6000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b6000 0x600>;
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c2_default>;
>> +			pinctrl-1 = <&i2c2_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c3: i2c@78b7000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b7000 0x600>;
>> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c3_default>;
>> +			pinctrl-1 = <&i2c3_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi3: spi@78b7000 {
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x078b7000 0x600>;
>> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp1_dma 8>, <&blsp1_dma 9>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&spi3_default>;
>> +			pinctrl-1 = <&spi3_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c4: i2c@78b8000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x078b8000 0x500>;
>> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c4_default>;
>> +			pinctrl-1 = <&i2c4_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_i2c5: i2c@7af5000 {
>> +			compatible = "qcom,i2c-qup-v2.2.1";
>> +			reg = <0x07af5000 0x600>;
>> +			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
>> +				 <&gcc GCC_BLSP2_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp2_dma 4>, <&blsp2_dma 5>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&i2c5_default>;
>> +			pinctrl-1 = <&i2c5_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp_spi6: spi@7af6000 {
>> +			compatible = "qcom,spi-qup-v2.2.1";
>> +			reg = <0x07af6000 0x600>;
>> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>,
>> +				 <&gcc GCC_BLSP2_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-names = "default", "sleep";
>> +			pinctrl-0 = <&spi6_default>;
>> +			pinctrl-1 = <&spi6_sleep>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		usb_hs_phy: phy@6c000 {
>> +			compatible = "qcom,usb-hs-28nm-femtophy";
>> +			reg = <0x6c000 0x200>;
>> +			#phy-cells = <0>;
>> +			clocks = <&xo_board>,
>> +				 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>> +				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
>> +			clock-names = "ref", "ahb", "sleep";
>> +			resets = <&gcc GCC_QUSB2_PHY_BCR>,
>> +				 <&gcc GCC_USB2_HS_PHY_ONLY_BCR>;
>> +			reset-names = "phy", "por";
>> +			status = "disabled";
>> +		};
>> +
>> +		usb: usb@78db000 {
>> +			compatible = "qcom,ci-hdrc";
>> +			reg = <0x078db000 0x200>,
>> +			      <0x078db200 0x200>;
>> +			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
>> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
>> +			clock-names = "iface", "core";
>> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
>> +			assigned-clock-rates = <80000000>;
>> +			resets = <&gcc GCC_USB_HS_BCR>;
>> +			reset-names = "core";
>> +			phy_type = "ulpi";
>> +			dr_mode = "otg";
>> +			hnp-disable;
>> +			srp-disable;
>> +			adp-disable;
>> +			ahb-burst-config = <0>;
>> +			phy-names = "usb-phy";
>> +			phys = <&usb_hs_phy>;
>> +			status = "disabled";
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		pronto: wcnss: remoteproc@a21b000 {
> 
> One label should be enough.
> 
>> +			compatible = "qcom,pronto-v3-pil", "qcom,pronto";
>> +			reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 
>> 0x3000>;
>> +			reg-names = "ccu", "dxe", "pmu";
>> +
>> +			memory-region = <&wcnss_mem>;
>> +
>> +			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
>> +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "wdog", "fatal", "ready", "handover", 
>> "stop-ack";
>> +
>> +			power-domains = <&rpmpd MSM8917_VDDCX>,
>> +					<&rpmpd MSM8917_VDDMX>;
>> +			power-domain-names = "cx", "mx";
>> +
>> +			qcom,smem-states = <&wcnss_smp2p_out 0>;
>> +			qcom,smem-state-names = "stop";
>> +
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&wcnss_pin_a>;
>> +
>> +			status = "disabled";
>> +
>> +			wcnss_iris: iris {
>> +				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
>> +				clock-names = "xo";
>> +			};
>> +
>> +			smd-edge {
>> +				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
>> +
>> +				qcom,ipc = <&apcs 8 17>;
> 
> mboxes
> 
>> +				qcom,smd-edge = <6>;
>> +				qcom,remote-pid = <4>;
>> +
>> +				label = "pronto";
>> +
>> +				wcnss_ctrl: wcnss {
>> +					compatible = "qcom,wcnss";
>> +					qcom,smd-channels = "WCNSS_CTRL";
>> +
>> +					qcom,mmio = <&pronto>;
>> +
>> +					wcnss_bt: bluetooth {
>> +						compatible = "qcom,wcnss-bt";
>> +					};
>> +
>> +					wcnss_wifi: wifi {
>> +						compatible = "qcom,wcnss-wlan";
>> +
>> +						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>> +							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
>> +						interrupt-names = "tx", "rx";
>> +
>> +						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
>> +						qcom,smem-state-names = "tx-enable",
>> +									"tx-rings-empty";
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		intc: interrupt-controller@b000000 {
>> +			compatible = "qcom,msm-qgic2";
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			reg = <0x0b000000 0x1000>,
>> +			      <0x0b002000 0x1000>;
>> +		};
>> +
>> +		watchdog@b017000 {
>> +			compatible = "qcom,apss-wdt-qcs404", "qcom,kpss-wdt";
>> +			reg = <0x0b017000 0x1000>;
>> +			clocks = <&sleep_clk>;
>> +		};
>> +
>> +		timer@b120000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			compatible = "arm,armv7-timer-mem";
>> +			reg = <0x0b120000 0x1000>;
>> +			clock-frequency = <19200000>;
>> +
>> +			frame@b121000 {
>> +				frame-number = <0>;
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b121000 0x1000>,
>> +				      <0x0b122000 0x1000>;
>> +			};
>> +
>> +			frame@b123000 {
>> +				frame-number = <1>;
>> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b123000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b124000 {
>> +				frame-number = <2>;
>> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b124000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b125000 {
>> +				frame-number = <3>;
>> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b125000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b126000 {
>> +				frame-number = <4>;
>> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b126000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b127000 {
>> +				frame-number = <5>;
>> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b127000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b128000 {
>> +				frame-number = <6>;
>> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x0b128000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +	};
>> +
>> +	thermal_zones: thermal-zones {
>> +		aoss-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 0>;
>> +
>> +			trips {
>> +				aoss_alert0: trip-point0 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		mdm-core-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 1>;
>> +
>> +			trips {
>> +				mdm_core_alert0: trip-point0 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		q6-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 2>;
>> +
>> +			trips {
>> +				q6_alert0: trip-point0 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		camera-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 3>;
>> +
>> +			trips {
>> +				camera_alert0: trip-point0 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +			};
>> +		};
>> +
>> +		cpuss1-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 4>;
>> +
>> +			trips {
>> +				cpuss1_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				cpuss1_alert1: trip-point1 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +
>> +				cpuss1_crit: cpuss1-crit {
>> +					temperature = <100000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpuss1_alert0>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		cpu0-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 5>;
>> +
>> +			trips {
>> +				cpu0_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				cpu0_alert1: trip-point1 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +
>> +				cpu0_crit: cpu-crit {
>> +					temperature = <100000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu0_alert1>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		cpu1-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 6>;
>> +
>> +			trips {
>> +				cpu1_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +
>> +				cpu1_alert1: trip-point1 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				cpu1_crit: cpu-crit {
>> +					temperature = <100000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu1_alert1>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		cpu2-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 7>;
>> +
>> +			trips {
>> +				cpu2_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +
>> +				cpu2_alert1: trip-point1 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				cpu2_crit: cpu-crit {
>> +					temperature = <100000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu2_alert1>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		cpu3-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 8>;
>> +
>> +			trips {
>> +				cpu3_alert0: trip-point0 {
>> +					temperature = <75000>;
>> +					hysteresis = <2000>;
>> +					type = "hot";
>> +				};
>> +
>> +				cpu3_alert1: trip-point1 {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				cpu3_crit: cpu-crit {
>> +					temperature = <100000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu3_alert1>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		gpu-thermal {
>> +			polling-delay-passive = <250>;
>> +			polling-delay = <1000>;
>> +
>> +			thermal-sensors = <&tsens 9>;
>> +
>> +			trips {
>> +				gpu_alert: trip-point0 {
>> +					temperature = <70000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				gpu_crit: gpu-crit {
>> +					temperature = <90000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&gpu_alert>;
>> +					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +#include "msm8917-pins.dtsi"
>> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi 
>> b/arch/arm64/boot/dts/qcom/pm8916.dtsi
>> index 
>> f8e4829ff7f7de1f1f4f5da0f41020875d6c7e17..df0f679250ccb6c49a76288fad12f67b01fa6b61 
>> 100644
>> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> 
> Separate commit, please. Or move this to the board file submission.
> 
>> @@ -47,7 +47,7 @@ pon@800 {
>>  			mode-bootloader = <0x2>;
>>  			mode-recovery = <0x1>;
>> 
>> -			pwrkey {
>> +			pm8916_pwrkey: pwrkey {
>>  				compatible = "qcom,pm8941-pwrkey";
>>  				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>>  				debounce = <15625>;
>> @@ -210,6 +210,10 @@ pm8916_pwm: pwm {
>>  			status = "disabled";
>>  		};
>> 
>> +		pm8916_spmi_regulators: regulators {
>> +			compatible = "qcom,pm8916-regulators";
>> +		};
>> +
>>  		pm8916_vib: vibrator@c000 {
>>  			compatible = "qcom,pm8916-vib";
>>  			reg = <0xc000>;
>> @@ -219,6 +223,9 @@ pm8916_vib: vibrator@c000 {
>>  		pm8916_codec: audio-codec@f000 {
>>  			compatible = "qcom,pm8916-wcd-analog-codec";
>>  			reg = <0xf000>;
>> +			reg-names = "pmic-codec-core";
>> +			clocks = <&xo_board>;
>> +			clock-names = "mclk";
> 
> Why? Is this compatible with other boards?
> 
>>  			interrupt-parent = <&spmi_bus>;
>>  			interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
>>  				     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
>> 
>> --
>> 2.47.0
>> 

