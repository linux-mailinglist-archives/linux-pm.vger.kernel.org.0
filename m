Return-Path: <linux-pm+bounces-20123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BA1A06724
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 22:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C873E1889B3A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED223204088;
	Wed,  8 Jan 2025 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk2w2P+q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F421F8F14;
	Wed,  8 Jan 2025 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736371437; cv=none; b=RRuvlnjLCjAOgPcCVcLANRU8Nhbo4MYUuQ1geStVOZNDxKY7Vh7gkuea8PtYIvRv7SpwNRYTfteydB2unQkZIVNPTNAj/JksgI3CuHnNcvzV7pwglgjXErk3Yn8UoRHZ0uLoqcbfzEq07fNuhxQeQhgoo48/W3kGXNMk6DSkUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736371437; c=relaxed/simple;
	bh=B8bTJ4Op1IrfR6WvZO4ell/Npf93u8IsXGGibHmEDrw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LA2LFq76VQLrRzmWcJSkdJBFzSZrEkJDRLnCHaTOexLIOOeNsslxzuZz2FESNcNM5qL7CwZWoLy7f+0sj87XDKdK2pFW81FWnSR6MvNzk9JMo9ZalpWlNXxVXCTwScYGNtB0CRiHrftOLpbIlHLni3eNDC/iI4h9gWieh3XLBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk2w2P+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2739C4CED3;
	Wed,  8 Jan 2025 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736371437;
	bh=B8bTJ4Op1IrfR6WvZO4ell/Npf93u8IsXGGibHmEDrw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Sk2w2P+qJsoxgnWW1BfBKqg9Vm0U6Gvtk0Tz9s9zhpOj4Bsm1rAIYXfAI430AYyxE
	 mWkPPBNS34rOHqjg56f38yz2OxpoZdaPTrKJuNvTOAc6kvTKiuYLaCJnkoInO9ZbMI
	 eCkHBrBRo1JhoeqSqRy2vZ2nFAxBwFuoOp9rB0h+Q4kNI8y21h0egeJogVCF8r3IFe
	 aplB/okE5PyfR58jpE/TFfMRyOlIeWyDQimcB6kbMxjqjwbqB37yYbZ9HIdN7YDCVz
	 v04gQVDECRTWsZV0JPD0cJzfRWFGY/ztGGJeG8hmzDlFr7dUS89eKNAe6gCJrKb/ww
	 U1pJqEcPB26Gg==
Date: Wed, 08 Jan 2025 15:23:55 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Maya Matuszczyk <maccraft123mc@gmail.com>, 
 Viresh Kumar <vireshk@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konradybcio@kernel.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20250109-gpu-acd-v4-5-08a5efaf4a23@quicinc.com>
References: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
 <20250109-gpu-acd-v4-5-08a5efaf4a23@quicinc.com>
Message-Id: <173637143564.1057127.5997544431977689674.robh@kernel.org>
Subject: Re: [PATCH v4 5/7] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings


On Thu, 09 Jan 2025 02:10:01 +0530, Akhil P Oommen wrote:
> Add a new schema which extends opp-v2 to support a new vendor specific
> property required for Adreno GPUs found in Qualcomm's SoCs. The new
> property called "qcom,opp-acd-level" carries a u32 value recommended
> for each opp needs to be shared to GMU during runtime.
> 
> Also, update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 98 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Warning: Duplicate compatible "operating-points-v2" found in schemas matching "$id":
	http://devicetree.org/schemas/opp/opp-v2.yaml#
	http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.example.dtb: opp-table: opp-300000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.example.dtb: opp-table: opp-400000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.example.dtb: opp-table: opp-400000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-533000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-533000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-450000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-450000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-400000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-400000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-350000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-350000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-266000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-266000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-160000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-160000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-100000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-midgard.example.dtb: opp-table: opp-100000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-533000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-533000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-450000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-450000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-400000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-400000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-350000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-350000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-266000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-266000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-160000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-160000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-100000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.example.dtb: opp-table: opp-100000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb: opp-table-0: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb: opp-table-0: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb: opp-table-0: 'opp-shared', 'opp01', 'opp02' do not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb: opp-table-1: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb: opp-table-1: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.example.dtb: opp-table-1: 'opp-shared', 'opp01', 'opp02' do not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1000000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt', 'opp-suspend' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1000000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1100000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1100000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1200000000: 'clock-latency-ns', 'opp-microvolt', 'turbo-mode' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1000000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt', 'opp-suspend' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1000000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1100000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1100000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1200000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt', 'turbo-mode' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-1200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt', 'opp-suspend' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1100000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1100000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1200000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt', 'turbo-mode' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: opp-1300000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt', 'opp-suspend' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: opp-1300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: opp-1400000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: opp-1400000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: opp-1500000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt', 'turbo-mode' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: opp-1500000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000000: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000001: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000001: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000002: 'clock-latency-ns', 'opp-microamp', 'opp-microvolt' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000002: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-600000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-800000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: opp-900000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000000: 'opp-microamp-fast', 'opp-microamp-slow', 'opp-microvolt-fast', 'opp-microvolt-slow' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1000000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1200000000: 'opp-microamp', 'opp-microvolt-fast', 'opp-microvolt-slow' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: opp-1200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-0: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2.example.dtb: opp-table-1: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: opp-19200000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: opp-19200000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: opp-50000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: opp-50000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: opp-100000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: opp-100000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: opp-202000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb: opp-table: opp-202000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-171428571: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-171428571: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-345000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-345000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-460000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-460000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-187500000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-187500000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-358000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.example.dtb: opp-table: opp-358000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: opp-325000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: opp-325000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: opp-375000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: opp-375000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: opp-514000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.example.dtb: opp-table: opp-514000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-325000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-325000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-375000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-375000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-514000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-514000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-160000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-160000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-270000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-270000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-540000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-540000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-810000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb: opp-table: opp-810000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: opp-345000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: opp-345000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: opp-460000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.example.dtb: opp-table: opp-460000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-19200000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-19200000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-344000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-344000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-430000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.example.dtb: opp-table: opp-430000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-375000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-375000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-500000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-500000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-575000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-575000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-650000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-650000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-160000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-160000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-270000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-270000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-540000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-540000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-810000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.example.dtb: opp-table: opp-810000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/gpu.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/gpu.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-345000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-345000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-460000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-460000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-187500000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-187500000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-358000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.example.dtb: opp-table: opp-358000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-19200000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-19200000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-344000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-344000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-430000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-430000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-180000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-180000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-275000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-275000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-358000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-358000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-160000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-160000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-270000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-270000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-540000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-540000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-810000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.example.dtb: opp-table: opp-810000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-187500000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-187500000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-358000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-358000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-160000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-160000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-270000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-270000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-540000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-540000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-810000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-810000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-160000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-160000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-270000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-270000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-540000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-540000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-810000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: opp-table: opp-810000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-325000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-325000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-375000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-375000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-514000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-514000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-187500000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-187500000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-358000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.example.dtb: opp-table: opp-358000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-172000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-172000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-325000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-325000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-375000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-375000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-500000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-500000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-160310000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-160310000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-187500000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-187500000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-358000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: opp-table: opp-358000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-187500000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-187500000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-358000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-358000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-160000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-160000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-270000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-270000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-540000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-540000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-810000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-mdss.example.dtb: opp-table: opp-810000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-200000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-325000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-325000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-375000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-375000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-514000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-514000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-187500000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-187500000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-300000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-300000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-358000000: 'required-opps' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.example.dtb: opp-table: opp-358000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: 'opp1', 'opp10', 'opp2', 'opp3', 'opp4', 'opp5', 'opp6', 'opp7', 'opp8', 'opp9' do not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: 'opp1', 'opp2', 'opp3', 'opp4', 'opp5', 'opp6' do not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/qcom,rpmpd.example.dtb: opp-table: 'opp1', 'opp2', 'opp3', 'opp4' do not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.example.dtb: opp-table: 'opp1', 'opp10', 'opp2', 'opp3', 'opp4', 'opp5', 'opp6', 'opp7', 'opp8', 'opp9' do not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.example.dtb: opp-table: opp-1: 'opp-hz' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.example.dtb: opp-table: opp-2: 'opp-hz' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-273000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-273000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-338000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-338000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-403000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-403000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-463000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-463000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-546000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-546000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-624000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-624000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-689000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-689000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-767000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-767000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-845000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-845000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-871000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-871000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-923000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-923000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-962000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-962000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-1027000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-1027000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-1092000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-1092000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-1144000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-1144000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-1196000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: opp-1196000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/mediatek,cci.example.dtb: opp-table-cci: 'opp-shared' does not match any of the regexes: '^opp-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.example.dtb: opp-table: opp-133333333: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.example.dtb: opp-table: opp-800000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-0: 'opp-hz' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-0: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-1: 'opp-hz' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-1: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-2: 'opp-hz' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-2: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-3: 'opp-hz' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-3: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-4: 'opp-hz' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.example.dtb: opp-table: opp-4: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: compatible:0: 'operating-points-v2-adreno' was expected
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: compatible: ['operating-points-v2'] is too short
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-50000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-50000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-100000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-100000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-134000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-134000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-200000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-200000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-400000000: 'opp-microvolt' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.example.dtb: opp-table: opp-400000000: 'opp-level' is a required property
	from schema $id: http://devicetree.org/schemas/opp/opp-v2-qcom-adreno.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250109-gpu-acd-v4-5-08a5efaf4a23@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


