Return-Path: <linux-pm+bounces-38911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85060C93B64
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F43485AF
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818B274B23;
	Sat, 29 Nov 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SST5/dt7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2126738B;
	Sat, 29 Nov 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764408820; cv=none; b=V1S/M9Ff2840mibyR8xTaWglA4bARcLg57jFHcsYRZmskEa+0QGrMZYm1dFNn3/nLrjMIXQyRW7TIT/mMYRWd/HPu8Q562YksbCvz2Al7G8vldyib9q/cWirllHGhKcPiHugA3/N3je5R0reeihapBv75V7WmK4r9p82D5b29z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764408820; c=relaxed/simple;
	bh=fBspl33yqQiZQhG3L57M/Uc6CoPOerhwAx6TmmhBzoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXVbokiHJMHfrHe5t++DzzIplpQQCuHqZRVkTWzJ2qk1Dl8xSicB1t0KXUtTrn2YrOjZ3g0j6Q4ndCgKC9UP4TA43v0DeVhBiNF8djdCc8lMH2AkpJdzuMOwCjI2rxFFL+kBLo8NLhuPdSS9zDr18i/Oejvid+m+AzKYm/z/S0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SST5/dt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79792C4CEF7;
	Sat, 29 Nov 2025 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764408819;
	bh=fBspl33yqQiZQhG3L57M/Uc6CoPOerhwAx6TmmhBzoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SST5/dt7rFQoCEuqvuAtXdzxATnbjdYeGf+w6XP5xXNLAkwAJaPZ8TkCjA0e/h78Q
	 aG/mQaXQ2V9brI6T1iWBzfUKEY0foAdfjICK6lhaYcyL0zMu1kMF/zR3w4CTsEbfM7
	 2l2RUcPll3aEao/PH+WrVGO3CVNN+t09ukiMG2CtTHQ5o6imyplYsXXjNyemS5ESOH
	 jNou/iB7BAKdpkwYUNP8Tm+sUfXAoC6t0ihXu9nVBeK721QsF9k2Ry4NUIW97dZzdC
	 L/ouNVTGx6dr5uPy4ikM6KsEUUantHutDwhgZm/G7XI+QrVf4x1KzeUKdm+8sAsDcz
	 WC+eSHTOk+duQ==
Message-ID: <bf8fbe4b-d89e-424f-8445-0da2f80422c1@kernel.org>
Date: Sat, 29 Nov 2025 10:33:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on qcs8300
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
 <20251128150106.13849-2-odelu.kukatla@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251128150106.13849-2-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2025 16:01, Odelu Kukatla wrote:
> Add 'clocks' property to enable QoS configuration. This property
> enables the necessary clocks for QoS configuration.
> 
> QoS configuration is essential for ensuring that latency sensitive
> components such as CPUs and multimedia engines receive prioritized
> access to memory and interconnect resources. This helps to manage
> bandwidth and latency across subsystems, improving system responsiveness
> and performance in concurrent workloads.

I don't see how clocks property help here at all. Are you getting clock
rates in the driver of some other clocks to make QoS decisions?

> 
> Both 'reg' and 'clocks' properties are optional. If either is missing,

No! They are not. How they can be optional in the hardware? How SoC can
have for ONE GIVEN device optional reg, meaning one board with the same
Soc has the IO address space but other board with the same SoC does not
have it.

> QoS configuration will be skipped. This behavior is controlled by the
> 'qos_requires_clocks' flag in the driver, which ensures that QoS
> configuration is bypassed when required clocks are not defined.

This suggests that - driver is not helping. Please describe the
hardware, not your drivers.

> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,qcs8300-rpmh.yaml       | 53 ++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
> index e9f528d6d9a8..594e835d1845 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml
> @@ -35,6 +35,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +
>  required:
>    - compatible
>  
> @@ -45,14 +49,39 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,qcs8300-clk-virt
> -              - qcom,qcs8300-mc-virt
> +              - qcom,qcs8300-aggre1-noc
>      then:
>        properties:
> -        reg: false
> -    else:
> -      required:
> -        - reg

Why do you remove this? You cannot make random changes.

> +        clocks:
> +          items:
> +            - description: aggre UFS PHY AXI clock
> +            - description: aggre QUP PRIM AXI clock
> +            - description: aggre USB2 PRIM AXI clock
> +            - description: aggre USB3 PRIM AXI clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qcs8300-aggre2-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: RPMH CC IPA clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qcs8300-gem-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: GCC DDRSS GPU AXI clock

So all devices have clocks now? You made the schema less strict now,
removed pieces of it and you add more relaxed code telling every device
has a clock.

And none of this is explained in the commit msg.

>  
>  unevaluatedProperties: false
>  
> @@ -63,6 +92,7 @@ examples:
>          reg = <0x9100000 0xf7080>;
>          #interconnect-cells = <2>;
>          qcom,bcm-voters = <&apps_bcm_voter>;
> +        clocks = <&gcc_ddrss_gpu_axi_clk>;
>      };
>  
>      clk_virt: interconnect-0 {
> @@ -70,3 +100,14 @@ examples:
>          #interconnect-cells = <2>;
>          qcom,bcm-voters = <&apps_bcm_voter>;
>      };
> +
> +    aggre1_noc: interconnect@16c0000 {

No need for new example, it is the same as previous.

> +        compatible = "qcom,qcs8300-aggre1-noc";
> +        reg = <0x016c0000 0x17080>;
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +        clocks = <&gcc_aggre_ufs_phy_axi_clk>,
> +                 <&gcc_aggre_noc_qupv3_axi_clk>,
> +                 <&gcc_aggre_usb2_prim_axi_clk>,
> +                 <&gcc_aggre_usb3_prim_axi_clk>;
> +    };


Best regards,
Krzysztof

