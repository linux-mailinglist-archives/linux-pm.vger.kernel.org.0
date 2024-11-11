Return-Path: <linux-pm+bounces-17313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD79C3C58
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 11:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60DDB23110
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DAB18B466;
	Mon, 11 Nov 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSsVdZ1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9D17BECA
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321855; cv=none; b=QrMxhGhLMr6JvdJx1gXxAiDGm+nbCpzrvkScAu3d0TYiv/aWcYNpfyYxS1J3J3fT229066eJh6xPDEjy5T2Vkxi7qKRH4lVNOL3B6VneUJ+XalGli9DZAeHi7NR0CNSBjl3tgJW5EJnXM2jH6YLJURq6N6ttCNlJ/a3RUgn7Y1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321855; c=relaxed/simple;
	bh=viI1zXUB7rgBr9BKaHg9ecokLINqTsbbL1vWFmyx5sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F05O1gfmm1an/RRFuWJuk97os40Kr3Y6gUomluwrmizFiaMuZ9SfHqjr71/ZAkNnOop3WCMt92owqvX5hbTYlFWC6HxyGzlMjj8P43XQSIhnA9Dxvp42Vf2ARKd3XPXePX73CX9sIgjZmCo+gIhBR4Y7fvogcI+4XzmUDA3OzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BSsVdZ1u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so38334355e9.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 02:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731321850; x=1731926650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uzxzm9xXLTbZgUXHxeJ9mNLyYRjtxj0f3W1XXKiT9+0=;
        b=BSsVdZ1udYrSYrs7Uxf97JblrqPvOh1cfT3s1XK/iToj7ENuXtBenCrIW+xz6pUtqi
         HGLwFNHl2NOFSB/JQIvYKs5DOYyADHNz9hU6tuP5AnsCUaXYivK0A6nBXmH7BWZkIChL
         VHAOU7hXJgIXpJsrbYA3NfjlqVQlw8OHkxTbt5lEAP5mT4wLg6nAlzoAmSXWjEPOC00J
         0Bl2reWpFE3hads8AAeYjkaydlUTiIDZI75p1tJCdKkkKKCAsTqKqPYHWgyALvX1lsyL
         e2Dco15a9XKLWBN537BuwndSfFfcJYU4kDaLLx589ehy7RN/Mcqv2802wyXXZ4x/4io/
         sU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321850; x=1731926650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzxzm9xXLTbZgUXHxeJ9mNLyYRjtxj0f3W1XXKiT9+0=;
        b=MPVF6R/jEeDAM+B7K2fMhEqwHJL0x2r6In7I9NApv2gRAvcc0FKWZGOaD8S6myFtF3
         i8Kzj5SPSsQ6+Ew7r0YTjmLKu/bscp9KUlGnJQUr21IHD10cQDHYCMElD6E1/lGETWbL
         0QAepMKAg7kO6Py8AXDVXSk3rYbXZ7fxBnxfQitFsykp5whthLspWQeIJKxay7wwS0mJ
         kZ9Ch6j6QhlS7YoH/XEvHyTDkBGp45WoD2QHAIFmPR2z9dDHD8Y3RdD7OmfiSTWt7MSh
         pXwFC6bunF5WGvN34E1rmodnNQhuhfQAqDcGkiiJ40cx7Ay7P6AR0flsyqagYrq+J2xc
         t7cw==
X-Forwarded-Encrypted: i=1; AJvYcCW4elGS8xqHbnVg/tAme42jPQY1S4POD9rtZBBAuHhJDfyz/SnX2jo6Vqb/sVPIdIBWTqR89vItCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPzFtDq4h3yejbUk70w/DmGhk0cV3UJXZ57T6Wy776xAZo6eV
	EPVQIKdP228gm2dng9JOxcobOLNyIKlkxCoxPAdq8fzCmHv4Q3cmTrSxfcA4b6g=
X-Google-Smtp-Source: AGHT+IFWbm5G98XNys1mSFOeg/rULU9TcIwIPAzzQ5wDgRA27UVUt+JopDpTX1ttncoYAk1OkBdKHA==
X-Received: by 2002:a05:600c:4f04:b0:431:5f1c:8359 with SMTP id 5b1f17b1804b1-432b75091cdmr85229145e9.15.1731321849412;
        Mon, 11 Nov 2024 02:44:09 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:11f:3141:b8c5:27b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6bee9asm213622655e9.19.2024.11.11.02.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:44:09 -0800 (PST)
Date: Mon, 11 Nov 2024 11:44:04 +0100
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
Subject: Re: [PATCH v4 08/10] arm64: dts: qcom: Add initial support for
 MSM8917
Message-ID: <ZzHf9J0Y2uB7_vy4@linaro.org>
References: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
 <20241109-msm8917-v4-8-8be9904792ab@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241109-msm8917-v4-8-8be9904792ab@mainlining.org>

On Sat, Nov 09, 2024 at 01:08:10PM +0100, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> Add initial support for MSM8917 SoC.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> [reword commit, rebase, fix schema errors]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1997 +++++++++++++++++++++++++++++++++
>  1 file changed, 1997 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..f866843772684c695069debfc764f7a0a58843bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> @@ -0,0 +1,1997 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8917.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,apr.h>
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
> +	};

I think we put aliases in each board separately nowadays, see e.g.
commit 154f23a8d70c ("arm64: dts: qcom: msm8916: Move aliases to
boards").

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
> [...]
> +
> +	rpm: remoteproc {
> +		compatible = "qcom,msm8917-rpm-proc", "qcom,rpm-proc";
> +
> +		smd-edge {
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,ipc = <&apcs 8 0>;

Can you use mboxes here?

> +			qcom,smd-edge = <15>;
> +
> [...]
> +
> +		mpss_mem: mpss@86800000 {
> +			/*
> +			 * The memory region for the mpss firmware is generally
> +			 * relocatable and could be allocated dynamically.
> +			 * However, many firmware versions tend to fail when
> +			 * loaded to some special addresses, so it is hard to
> +			 * define reliable alloc-ranges.
> +			 *
> +			 * alignment = <0x0 0x400000>;
> +			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
> +			 */

Not sure how many devices you have access to, but have you tried if this
is actually still the case? I'd have hoped they fixed those issues in
the firmware.

Thanks for using alloc-ranges instead of fixed addresses BTW :)

> +			reg = <0x0 0x86800000 0x0 0>; /* size is device-specific */
> +			no-map;
> +			status = "disabled";
> +		};
> +
> [...]
> +	smp2p-adsp {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <443>, <429>;
> +
> +		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
> +
> +		mboxes = <&apcs 10>;
> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <2>;
> +
> +		adsp_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		adsp_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-modem {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +
> +		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
> +
> +		qcom,ipc = <&apcs 8 14>;

You have mboxes for adsp above, what about modem and

> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <1>;
> +
> +		modem_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		modem_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-wcnss {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <451>, <431>;
> +
> +		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
> +
> +		qcom,ipc = <&apcs 8 18>;

... wcnss?

> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <4>;
> +
> +		wcnss_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		wcnss_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> [...]
> +
> +		restart@4ab000 {
> +			compatible = "qcom,pshold";
> +			reg = <0x004ab000 0x4>;
> +		};

You have PSCI for shutting down, do you actually need this?

> [...]
> +		blsp_i2c4: i2c@78b8000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b8000 0x500>;
> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
> +			dma-names = "tx", "rx";
> +			pinctrl-0 = <&i2c4_default>;
> +			pinctrl-1 = <&i2c4_sleep>;
> +			pinctrl-names = "default", "sleep";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		blsp_i2c5: i2c@7af5000 {

Please use a full label here with the BLSP number and QUP instance
(&blspX_i2cY). This corresponds to the name of the clock, so this node
is actually

> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x07af5000 0x600>;
> +			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,

... &blsp2_i2c1.

I guess the current naming is taken from downstream, but I think they
just assigned consecutive numbers to all the QUP instances they needed.
This will cause headaches in the future if someone wants to add an
instance that wasn't used by QC in the reference designs.

> +				 <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp2_dma 4>, <&blsp2_dma 5>;
> +			dma-names = "tx", "rx";
> +			pinctrl-0 = <&i2c5_default>;
> +			pinctrl-1 = <&i2c5_sleep>;

&blsp2_i2c1_default/sleep for clarity

> +			pinctrl-names = "default", "sleep";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		blsp_spi6: spi@7af6000 {

&blsp2_spi2

> +			compatible = "qcom,spi-qup-v2.2.1";
> +			reg = <0x07af6000 0x600>;
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>,
> +				 <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
> +			dma-names = "tx", "rx";
> +			pinctrl-0 = <&spi6_default>;
> +			pinctrl-1 = <&spi6_sleep>;

&blsp2_spi2_default/sleep

> +			pinctrl-names = "default", "sleep";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> [...]
> +		timer@b120000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0b120000 0x1000>;
> +			clock-frequency = <19200000>;

Should be unneeded unless the firmware is broken. Can you try dropping
it and see if you get a warning in dmesg?

> [...]
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <19200000>;

Same here.

Thanks,
Stephan

