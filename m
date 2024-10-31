Return-Path: <linux-pm+bounces-16808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1549B765E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 09:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C751B282549
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAAD15623B;
	Thu, 31 Oct 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXcy5aH5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7541547E3;
	Thu, 31 Oct 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363100; cv=none; b=WdA/jTENq3M1UzgUYKBDjYcmA1O5hzVlgmkNkgMGe6OQ5+WUQWbobJ02nmWh7WwB5RadtfatwlqUFAjcL3kMH+mHtFgYh4y+pXtbXfcag9YMy1jcx/AgCWDBDOfn6lX+kgwpiQCIavmLuKvDs/mwWG6hMzjCZhkoLOfBeouc3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363100; c=relaxed/simple;
	bh=Y2VeVrh7q8W6feFZvrcIbYqCZQdMbSAUHcDW1rUmOo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csjdh8+Eil9ISLLFSCCyIo5qGfQl5hF6l+8NPnSNSEuHT3TYRb7iK/VW//uHQiRPdoGH+AjuOERq8M5WIv0S2ZDVEzDTOZnXTjKpoTFM9wTJJofvpfmdxNkKt+0JpFU0kio9YuBbCU27wRSYRmnnhTdoXFEUyRdbSmzEv8ahBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXcy5aH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1287AC4CEC3;
	Thu, 31 Oct 2024 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730363100;
	bh=Y2VeVrh7q8W6feFZvrcIbYqCZQdMbSAUHcDW1rUmOo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXcy5aH5rjgmfnqJd6wcDTOnZV3NO3SLtyNb91xL83l3uPYr27/anqNaqR7Xu4LT8
	 0WM3wmR4WnlYQkR/kX9dDuug5TVk/bIN5RDs+Sz/H2zYhji3pGpYqtwhPIc0lrlhIK
	 A7kVHV/VlPdBgmFMgtLuYtq2bekO9gpmhmc/U3iBHK7B7EjsslhC0/Znq8mlGmQmIV
	 qhmZTprP2X4pc5Fj/pSjrAP9CKcEqTv3gjI79liYTEc5747qoklgP8G1128B+ie6qE
	 uuBDmbnecVkcvBodHqkx/cxVpk+qIUHsLkVy+pb7W983S8Y8jV0yoOGK24RGTJzfE+
	 AO9CGbbb3Aczw==
Date: Thu, 31 Oct 2024 09:24:56 +0100
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
Subject: Re: [PATCH v2 06/15] dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
 bindings
Message-ID: <rjfaxoxy5oko22ute6ttgtnm5oawudw5z2ykcrjztpajjnz5zk@gaapriqclxyw>
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
 <20241031-msm8917-v2-6-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031-msm8917-v2-6-8a075faa89b1@mainlining.org>

On Thu, Oct 31, 2024 at 02:19:47AM +0100, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-reserved-ranges: true

minItems: 1
maxItems: 66

No gpio-line-names allowed?

> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-msm8917-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-msm8917-tlmm-state"
> +        additionalProperties: false
> +
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
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-3][0-9]|14[01])$"

You have 134 GPIOs, not 142.

> +            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc1_rclk, sdc2_clk,
> +                      sdc2_cmd, sdc2_data, qdsd_clk, qdsd_cmd, qdsd_data=
0,
> +                      qdsd_data1, qdsd_data2, qdsd_data3 ]
> +        minItems: 1
> +        maxItems: 16

Best regards,
Krzysztof


