Return-Path: <linux-pm+bounces-33460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B99B3C9A3
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417F27B5384
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18499256C61;
	Sat, 30 Aug 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnaqmkCz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA132BA4A;
	Sat, 30 Aug 2025 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756544888; cv=none; b=X5T0bgc+4efQfJeuLYQeoyBDcLC1U0U+cyJqn8SXIL2TZdJbClaSqvMJrCM2JJDs8L5aICC9Cq+wdjauBxz23DQFLOghk/AVSphYB9YmUQxzTvAUMfkVTcXWGh+DvSRKd/8uXdOJhyNT7JsnODeSnSpPP/G8oEoNg2yZFMMY4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756544888; c=relaxed/simple;
	bh=27PN1sfIWBxKnrB+V8uXnT6HNOKJLQY9Xodlg62IbR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+y3djK8f/MQgNmfdFr+9u9ReuLuax6GNOqzsZQIHgIZ7CFuIaMYkN6pAgxJLvCUffbv2l74vnies5FJ8Sq35McbD3RahbSB+DUnL4zVX4/dDL9AnKSYaEF96HiKktJ6/it2ZKkpRnKifpnmEt4/dpGnzb4ZuuqBg5ml/pO3+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnaqmkCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A92C4CEEB;
	Sat, 30 Aug 2025 09:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756544887;
	bh=27PN1sfIWBxKnrB+V8uXnT6HNOKJLQY9Xodlg62IbR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nnaqmkCzKPmrCdXaUrhuw7f7bZ4Jmc7ppApy0f6hZ+rbMsTGmdHo2ODTCxEEMCVuG
	 1PPRV29acvR2qoqEPpPa4Ax2aht866VSfujm7Gb1DKHGNy8UVHhpHts0J+w0Fa/t2j
	 SG9LZTvdGWa4jOp+Y0+iX7eGn0xvuOuGsIwGZYdE0OlZW230i7mGlePb6LlOmIPjCQ
	 hfaCGErRX11VypQPykDjuMvruSkP+zTTpWofcxpE7CEfVC/N2GjQXRT6g7bzK/4tDy
	 YSbESYOPu0Uuov/dnSyiLDlqrQWe+AQ69OshxUxOtZ7kzf9O8yCogq3a5O/InEokpN
	 /rZMEWDUpyjdQ==
Message-ID: <e573cfc8-be9c-482c-9b06-4eedbb92d520@kernel.org>
Date: Sat, 30 Aug 2025 11:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: exynosautov920: Add tmu hardware binding
To: Shin Son <shin.son@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250825064929.188101-1-shin.son@samsung.com>
 <CGME20250825064933epcas2p40a7c491366097f90add675bc36822ef9@epcas2p4.samsung.com>
 <20250825064929.188101-4-shin.son@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250825064929.188101-4-shin.son@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2025 08:49, Shin Son wrote:
> Create a new exynosautov920-tmu.dtsi describing new TMU hardware
> and include it from exynosautov920.dtsi.
> 
> The exynosautov920-tmu node uses the misc clock as its source
> and exposes two new DT properties:
> 
> - tmu-name: identifies the TMU variant for sensor skipping
> - sensor-index-ranges: defines valid sensor index ranges for the bitmap
> 
> This TMU binding defines six thermal zones with a critical trip point
> at 125 degrees:
> 
> tmu_top : cpucl0-left, cpucl1
> tmu_sub0: cpucl0-right, cpucl2
> tmu_sub1: g3d, npu
> 
> Signed-off-by: Shin Son <shin.son@samsung.com>
> ---
>  .../boot/dts/exynos/exynosautov920-tmu.dtsi   | 92 +++++++++++++++++++
>  .../arm64/boot/dts/exynos/exynosautov920.dtsi | 34 +++++++
>  2 files changed, 126 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
> new file mode 100644
> index 000000000000..fa88e9bcdfec
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's ExynosAuto920 TMU configurations device tree source
> + *
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *
> + * Samsung's ExynosAuto920 SoC TMU(Thermal Managemenut Unit) are listed as
> + * device tree nodes in this file.
> + */
> +
> +/ {
> +	thermal-zones {
> +		cpucl0left-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tmuctrl_top 0>;
> +
> +			trips {
> +				cpucl0_0_critical: cpucl0-0-critical {
> +					temperature = <125000>;	/* millicelsius */
> +					hysteresis = <0>;	/* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};

Missing blank line.

> +		cpucl0right-thermal {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tmuctrl_sub0 0>;
> +
> +			trips {
> +				cpucl0_1_critical: cpucl0-1-critical {
> +					temperature = <125000>;	/* millicelsius */
> +					hysteresis = <0>;	/* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +		cpucl1-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tmuctrl_top 1>;
> +
> +			trips {
> +				cpucl1_critical: cpucl1-critical {
> +					temperature = <125000>;	/* millicelsius */
> +					hysteresis = <0>;	/* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +		cpucl2-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tmuctrl_sub0 1>;
> +
> +			trips {
> +				cpucl2_critical: cpucl2-critical {
> +					temperature = <125000>;	/* millicelsius */
> +					hysteresis = <0>;	/* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +		g3d-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tmuctrl_sub1 0>;
> +
> +			trips {
> +				g3d_critical: g3d-critical {
> +					temperature = <125000>; /* millicelsius */
> +					hysteresis = <0>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +		npu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tmuctrl_sub1 1>;
> +
> +			trips {
> +				npu_critical: npu-critical {
> +					temperature = <125000>; /* millicelsius */
> +					hysteresis = <0>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> index 0fdf2062930a..a4ff941f8e43 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> @@ -330,6 +330,39 @@ watchdog_cl1: watchdog@10070000 {
>  			samsung,cluster-index = <1>;
>  		};
>  
> +		tmuctrl_top: tmutop-thermal@100a0000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).


Best regards,
Krzysztof

