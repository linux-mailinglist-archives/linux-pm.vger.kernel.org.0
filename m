Return-Path: <linux-pm+bounces-15596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44099C193
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B579C1C226D6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D4154435;
	Mon, 14 Oct 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkPM3WvD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BC15350B;
	Mon, 14 Oct 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891545; cv=none; b=FwIxP3oCVFpRGRH7wcMs+qib7SIhvqIXZsjMqXbaVRIKxQDnpMi/a51f3P1pRc8iaW0eq85TDIaf4eLBw1skns6rmebdxKawzNU/n23q8OjphTn4NnFU34CErSoIWQK0YRQfpVCQgJl8GoGXiDlGdryjofr7A9o+dT5d1vMYGKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891545; c=relaxed/simple;
	bh=SJl4FEfP+nFMTQVy4tk0uK5eIrcooOIDOFEZGLbbHSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi/p/9npCpuCIGqrJMI2TPWaAFRmLIHQiJgp3cxTL7FKwh8S29YmlfcRdHFn7gDbXaOSeLoMoea4+Wsth5vI2HKUKfhxEHwjKyEeVRY5djBcK5t7cKw9Fwq3yws2JXSbgIGTjJNao+d3aPtgwcqbmvhFuK2etNkH/5tw7hGNyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkPM3WvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59887C4CECE;
	Mon, 14 Oct 2024 07:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728891545;
	bh=SJl4FEfP+nFMTQVy4tk0uK5eIrcooOIDOFEZGLbbHSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkPM3WvD4Bm+q0U9C6GsoeBUkQCJ/71dmvFjrQY1d28bY6LwJ/sJXX753NAKeaq5b
	 k/DuKevASrcm62uL5riOxx5PDaxsxj9Sx4P/2lw/XcMYmZ0em0PJcKigtjjvSfvWOq
	 aCtsgfQf6p5H6T3N1I4jJ6r8FncLwTfqwcmUiufajbeCprDXVEW35OfJmQHzrhkzco
	 jWwj9pRMyncU/fdEvCw+GIxA/TR59ec0ieHpX0s8xdBHH18SK3HM2qie3D2Q1u8OKe
	 zPCWgoMGsWo/wuYEVsjmXSXnPHZEkH3tJzGTi4z9Y3bm+0/cHvSuNT9Gq1w+zi4LbX
	 CDz3u/OyWRtaQ==
Date: Mon, 14 Oct 2024 09:39:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings
Message-ID: <he6cfrofgmdw2se4mcok25c54sboovevmlli42xh6ttnqiogat@ja6el35jyd65>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-2-1e5e91aa95b6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241012-gpu-acd-v1-2-1e5e91aa95b6@quicinc.com>

On Sat, Oct 12, 2024 at 01:59:29AM +0530, Akhil P Oommen wrote:
> Add a new schema which extends opp-v2 to support a new vendor specific
> property required for Adreno GPUs found in Qualcomm's SoCs. The new
> property called "qcom,opp-acd-level" carries a u32 value recommended
> for each opp needs to be shared to GMU during runtime.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> new file mode 100644
> index 000000000000..9fb828e9da86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Adreno compatible OPP supply
> +
> +description:
> +  Adreno GPUs present in Qualcomm's Snapdragon chipsets uses an OPP specific
> +  ACD related information tailored for the specific chipset. This binding
> +  provides the information needed to describe such a hardware value.
> +
> +maintainers:
> +  - Rob Clark <robdclark@gmail.com>
> +
> +allOf:
> +  - $ref: opp-v2-base.yaml#
> +
> +properties:
> +  compatible:
> +    const: operating-points-v2-adreno
> +
> +patternProperties:
> +  '^opp-?[0-9]+$':
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      opp-hz: true
> +
> +      opp-level: true
> +
> +      opp-peak-kBps: true
> +
> +      opp-supported-hw: true
> +
> +      qcom,opp-acd-level:
> +        description: |
> +          A positive value representing the acd level associated with this

What is acd?

> +          OPP node. This value is shared to GMU during GPU wake up. It may

What is GMU?

> +          not be present for some OPPs and GMU will disable ACD while

acd or ACD?

> +          transitioning to that OPP.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    required:
> +      - opp-hz
> +      - opp-level
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Drop blank line

> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    gpu_opp_table: opp-table {
> +        compatible = "operating-points-v2-adreno";
> +
> +        opp-550000000 {
> +                opp-hz = /bits/ 64 <550000000>;
> +                opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +                opp-peak-kBps = <6074219>;
> +                qcom,opp-acd-level = <0xc0285ffd>;
> +        };
> +
> +        opp-390000000 {
> +                opp-hz = /bits/ 64 <390000000>;
> +                opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +                opp-peak-kBps = <3000000>;
> +                qcom,opp-acd-level = <0xc0285ffd>;

That's the same value used everywhere. What's the point? Just encode it
in the driver.

> +        };
> +
> +        opp-300000000 {
> +                opp-hz = /bits/ 64 <300000000>;
> +                opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> +                opp-peak-kBps = <2136719>;
> +                /* Intentionally left out qcom,opp-acd-level property here */
> +        };
> +

Stray blank line

> +    };
> 
> -- 
> 2.45.2
> 

