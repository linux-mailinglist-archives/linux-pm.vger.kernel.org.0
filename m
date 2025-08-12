Return-Path: <linux-pm+bounces-32209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99394B21BBD
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 05:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C565426A04
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 03:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E34238150;
	Tue, 12 Aug 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfc3lvRX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD91C2C9;
	Tue, 12 Aug 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970314; cv=none; b=ZppgR8OY1Xl/S3sMzcB7I5RjRhPYC3G8RN1IFWFGUXykIJ5QcJq5Kqt/GvT1Tu0K3iDiRD4W4M4sWYp2wAJAhlD4iu2hO3M2grIRsV89XLwA9my1tHsN5/4KzunapQI/l1nXXxd9nQMYl8E6FarOI7igxMHccMR+C0Vz+QcTjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970314; c=relaxed/simple;
	bh=fGznMj5kGw675RyQXLV/XCgKKgQRypn/BRq5eHB0/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osgfGFUc6WEnfWbKPKhib13zpyYH2mtA0OI9KnHCejmqfGisd/KT3fD9fIuZwIqmFJiWgpD6P8m9Z02AlEN/NQX1V5LYuyuuDMQ9XUWidOiNKdy14jdSotH5hyvP+h1osycyeWiYH0wvkWW7sKsvdsWEWlv8EDCZBz+MEpaEQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfc3lvRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD96C4CEED;
	Tue, 12 Aug 2025 03:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754970314;
	bh=fGznMj5kGw675RyQXLV/XCgKKgQRypn/BRq5eHB0/kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfc3lvRXmXf6zGDIm14OqBO4VLeZdKKDk/mjmFvoK0s7AMfLlrVsd/1HcV9GFH9vf
	 D2EvqrmRLqGE4yY/+rQ5YB6LRcRhakivxuWnfxo3M7GBBrbRVficiowQGdcyjehAWo
	 aGS35G48y/wMPe87HRumxLceA1IKv14zdTye5SbqsA7VYfr1eYoB3wTF61D8bLQ/a3
	 CNSm2Ky8p3jBvxl0EDN0HY1jfbPBQFRhFr3ec5XE9/97Qk7ZW5wzgJrpjzxAfBMQ+A
	 pWOfugmOL8erNNUHnbdUU+8Fdgbj0KgVaJrM9WnEqQhePefk60GyFjGcvrFRrX1opE
	 EQQQ2kSSaimLA==
Date: Mon, 11 Aug 2025 22:45:11 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
Message-ID: <vxeadjzwywqjjqm7elg5pltq3jtnv7fprquhdoydhxnjihpsw7@tlqoq5wpgcr3>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>

On Wed, Jul 02, 2025 at 02:43:10PM +0530, Taniya Das wrote:
> Add support for video, camera, display and gpu clock controller nodes
> for QCS615 platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---

  DTC [C] arch/arm64/boot/dts/qcom/qcs615-ride.dtb
/home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@100000: 'clock-names' is a required property
        from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
/home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: clocks: [[43, 0], [45, 2]] is too short
        from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
/home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: Unevaluated properties are not allowed ('clocks' was unexpected)
        from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
/home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: clocks: [[43, 0], [45, 29]] is too short
        from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
/home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: Unevaluated properties are not allowed ('clocks' was unexpected)
        from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#


The missing clock-names in clock-controller@100000 predates this series.
Sorry for merging broken patches in the past, please fix that as well.

Regards,
Bjorn

>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 51 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index bfbb210354922766a03fe05e6d117ea21d118081..5adf409d7ce7226042c759cc83ceca331097ae37 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -3,7 +3,11 @@
>   * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> +#include <dt-bindings/clock/qcom,qcs615-camcc.h>
> +#include <dt-bindings/clock/qcom,qcs615-dispcc.h>
>  #include <dt-bindings/clock/qcom,qcs615-gcc.h>
> +#include <dt-bindings/clock/qcom,qcs615-gpucc.h>
> +#include <dt-bindings/clock/qcom,qcs615-videocc.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/interconnect/qcom,icc.h>
> @@ -1506,6 +1510,18 @@ data-pins {
>  			};
>  		};
>  
> +		gpucc: clock-controller@5090000 {
> +			compatible = "qcom,qcs615-gpucc";
> +			reg = <0 0x05090000 0 0x9000>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GPLL0>;
> +
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		stm@6002000 {
>  			compatible = "arm,coresight-stm", "arm,primecell";
>  			reg = <0x0 0x06002000 0x0 0x1000>,
> @@ -3317,6 +3333,41 @@ gem_noc: interconnect@9680000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		videocc: clock-controller@ab00000 {
> +			compatible = "qcom,qcs615-videocc";
> +			reg = <0 0x0ab00000 0 0x10000>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&sleep_clk>;
> +
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		camcc: clock-controller@ad00000 {
> +			compatible = "qcom,qcs615-camcc";
> +			reg = <0 0x0ad00000 0 0x10000>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		dispcc: clock-controller@af00000 {
> +			compatible = "qcom,qcs615-dispcc";
> +			reg = <0 0x0af00000 0 0x20000>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
> +
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,qcs615-pdc", "qcom,pdc";
>  			reg = <0x0 0x0b220000 0x0 0x30000>,
> 
> -- 
> 2.34.1
> 

