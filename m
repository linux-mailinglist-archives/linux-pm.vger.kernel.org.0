Return-Path: <linux-pm+bounces-37338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9603FC2F0BB
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 04:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AD274E3491
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9F26A1BB;
	Tue,  4 Nov 2025 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqyjLxM7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959582405ED;
	Tue,  4 Nov 2025 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225220; cv=none; b=pM+v3c3iMqLeriyp6/KZOWZzxBW/h1DV4xxjNXyU3IoKlf3oc0QNNbGS2Dlsj1MGGj69/XDRwUh+jHyDOr3LPnR1eq0f5OMOM+H4sBWo2SsJVWbYm/f7ifsU/mT7zSRfgJoGIASYqnFDDjMER2ufNYWm13+/UjnyoGWtJ+v4h5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225220; c=relaxed/simple;
	bh=P6Nb7RFYcU3sUy6HTw6nBzT/0oqmgJRzlf4c5vKrZAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7B+UJLXtuQgUd0T9iFYy3G6SMUZmkvjJP4FcWm9Z+HHF2ZPuFXRdT5POI2W+ItI7fmGk3zrFBJU14/qmF6XGBZFDgoegUScaP1KN/ItewihPwc/I1fPimJZy/MjrZ7qN5azJ3D5SRR2ioUyqFXfOU8oqpmdPapNOFGFlmAny00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqyjLxM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F75C4CEE7;
	Tue,  4 Nov 2025 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762225220;
	bh=P6Nb7RFYcU3sUy6HTw6nBzT/0oqmgJRzlf4c5vKrZAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqyjLxM7qeV/bTpp62d2Rpk/yuCkN/+0noh2VDzvMudn6cUMu28UMvFIsSoPC3Cv6
	 j4JO8BGkTR4JXSw7fOpXz2wgk0LJr/k510xVyAXvhGW1fDu95eZQbcFS2iXTH4jfJJ
	 Jw7O/50wpTrXxsIgvLDRbnbEFOAf7DINPMLV93cR2K8r9/cyEQ5lEvUVX/sMMhjTbO
	 6zMHeAXgQOz9xqNz0X42+KvTceDW2Rnw9nVyGMznv1X2JWUVuHF3JaXJHd2ylQfdbn
	 fmXpx3hTdTdGfDYOzplAom/pJYWcSVFG+Al0M2iKX8T1rUBEzBMkG5KxyEzP8YEpXi
	 RDrVieIevAeUg==
Date: Mon, 3 Nov 2025 21:03:52 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: add reg and clocks
 properties to enable QoS on sa8775p
Message-ID: <ws5skjwjnte3ftf3skr3mbq6gdnm2ereaf3d4frytabbglmff3@dd2hjxdzblod>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
 <20251001073344.6599-2-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001073344.6599-2-odelu.kukatla@oss.qualcomm.com>

On Wed, Oct 01, 2025 at 01:03:42PM +0530, Odelu Kukatla wrote:
> Add 'reg' and 'clocks' properties to enable QoS configuration. These
> properties enable access to QoS registers and necessary clocks for
> configuration.
> 
> QoS configuration is essential for ensuring that latency sensitive
> components such as CPUs and multimedia engines receive prioritized
> access to memory and interconnect resources. This helps to manage
> bandwidth and latency across subsystems, improving system responsiveness
> and performance in concurrent workloads.
> 
> Both 'reg' and 'clocks' properties are optional. If either is missing,
> QoS configuration will be skipped. This behavior is controlled by the
> 'qos_requires_clocks' flag in the driver, which ensures that QoS
> configuration is bypassed when required clocks are not defined.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  .../interconnect/qcom,sa8775p-rpmh.yaml       | 50 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
> index db19fd5c5708..71428d2cce18 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
> @@ -33,18 +33,66 @@ properties:
>        - qcom,sa8775p-pcie-anoc
>        - qcom,sa8775p-system-noc
>  
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 5
> +
>  required:
>    - compatible
>  
>  allOf:
>    - $ref: qcom,rpmh-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-aggre1-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre UFS PHY AXI clock
> +            - description: aggre QUP PRIM AXI clock
> +            - description: aggre USB2 PRIM AXI clock
> +            - description: aggre USB3 PRIM AXI clock
> +            - description: aggre USB3 SEC AXI clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-aggre2-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre UFS CARD AXI clock
> +            - description: RPMH CC IPA clock
>  
>  unevaluatedProperties: false
>  
>  examples:
>    - |
> -    aggre1_noc: interconnect-aggre1-noc {
> +    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +    clk_virt: interconnect-clk-virt {
> +        compatible = "qcom,sa8775p-clk-virt";
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    aggre1_noc: interconnect@16c0000 {
>          compatible = "qcom,sa8775p-aggre1-noc";
> +        reg = <0x016c0000 0x18080>;
>          #interconnect-cells = <2>;
>          qcom,bcm-voters = <&apps_bcm_voter>;
> +        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +                 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
> +                 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
> +                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +                 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>;
>      };
> -- 
> 2.17.1
> 

