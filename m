Return-Path: <linux-pm+bounces-17201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375D9C1CDD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2155B284E53
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2880E1E7C03;
	Fri,  8 Nov 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI2Pr8n3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC511E47CE;
	Fri,  8 Nov 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068655; cv=none; b=J1X3AEoyfdV66oCCe2HAUiEYCq0k7/fra2IKOG81dnurLuFE8m35lFJU0/hI2zhd7CauuRatXdXa5q/fEQ/nl7HhA7ClgS2D3+QPJMDA8+3MZopiLYmnMIfbtya4SgRkkoMw7lLK8jlETfzgD7p4Os4kUQzDodVprnuNX3wRC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068655; c=relaxed/simple;
	bh=ysuLhuMYEEC7oX4y0iwjBEgPL1C/5lpgDLTDYdB0KFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W07JqtE7jol6PHptWAQmdrferfjMTiOA7UtB5P18R42c2KurGwr+I9c0lHYfkiMDcQ+bJ8ugVrTxmjzdT3GG9AhrB7SaFTXhDxADJ0p9gZS/Iae9qZROVRZAFEUws8QLMXgPcxmYdLhIjW5imvW/XBUlQ08poC8aOTPV84QKDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI2Pr8n3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A0EC4CECD;
	Fri,  8 Nov 2024 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731068654;
	bh=ysuLhuMYEEC7oX4y0iwjBEgPL1C/5lpgDLTDYdB0KFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZI2Pr8n3D33cVl/heubKCb1AtALRbMn0WDX2jXxKZvqNOBSAr3+XQKZPF9yNCFWrZ
	 Wf1wLykw0HBLbfov4EzKLHUQhk4XEdKt02QUbFNxvCbA+mZvTFybivzwlPM668X4PU
	 1bd9DSyVEYXsTHUazZinuQ3i5j7DXLfR3H/3GC5f14Fu02esA6XLSJhCH5aAS5h/Vr
	 NUXSBwWbCjBob32hiPpy3Nb/j627PV1BP/U4adaBUaTdKHHR7FVCdEUmg4DqihjvRn
	 ntTXDLYVW5mQOddiSLgh3hIOUlcJI36fwRfzNOUXOj/HepNR2VEByg33eFfiOmtc8r
	 2/wyK8i0RTl1g==
Date: Fri, 8 Nov 2024 13:24:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 06/14] dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
Message-ID: <ufamoryw2k3oquvusqzs2e7ixu6iptfbpmdevqthbps5w7szw3@6c7enohqv537>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
 <20241107-msm8917-v3-6-6ddc5acd978b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241107-msm8917-v3-6-6ddc5acd978b@mainlining.org>

On Thu, Nov 07, 2024 at 06:02:47PM +0100, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> +$defs:
> +  qcom-msm8917-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configu=
ration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +    unevaluatedProperties: false
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-3])$"

That's not a good pattern, unless really gpio129 is not existing?

> +            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, sdc2_clk,
> +                      sdc2_cmd, sdc2_data, qdsd_clk, qdsd_cmd, qdsd_data=
0,
> +                      qdsd_data1, qdsd_data2, qdsd_data3 ]
> +        minItems: 1
> +        maxItems: 16

Best regards,
Krzysztof


