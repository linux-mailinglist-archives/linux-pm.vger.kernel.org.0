Return-Path: <linux-pm+bounces-8002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63258CA2BB
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 21:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2DEB21FA4
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757281384B4;
	Mon, 20 May 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhEYg9TS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBE138496;
	Mon, 20 May 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233347; cv=none; b=NzFlnp4sTbiZL1ez4fCScyulppBnudDuXYfZIB9uppmP2RUJRvqpwrDMOLUIc/SJOGkvrlDGbKxYTnOLnw+jaN8MaF5x+v+oZ1+pyDq8NkPdSsaLDNFK755Q8LWPC85Y2EwWpLtnbCmnbfxLmHmUhYDPIuLabcrHkW/6YPUJgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233347; c=relaxed/simple;
	bh=XUJS0Nr3vYVX0F8uk+6ZJ1bmsN6ximLLLBQTiJ2ot4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfKUS3WVp4YhsWbWgHXL4yUj6Y6PpefL2AyqIxsD5Cgzn0Sroc0iTCALgwLCc1EJ/zdr0OZYvAX4RbDOTQdiBzPMaHAy8ucai121MaBiq9lKrfU0LWQ3fkPvGJEiDuyqJe7392GAFa+y/ZQ02QO56QRIL1GeLlTnHTbj/V/RcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhEYg9TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910FBC2BD10;
	Mon, 20 May 2024 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716233346;
	bh=XUJS0Nr3vYVX0F8uk+6ZJ1bmsN6ximLLLBQTiJ2ot4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhEYg9TSNmjmqsi4z5nUbjshugz1fFBtkFH2PhPoUnp6gGAGsjyZC6Mg9+o9NMDEE
	 Y/gcdIwhMguzNueJwnw0GgYHoBUBuvU+3CVKqGXKBdHD1mhHXwzYFmZKsN3tsaLCSU
	 Zpom41x7pESpNRUxUfMw8FxCP4MJptcduDANtfdd1oLaaoM3pizIr6JCl5klPQq12M
	 /++/5H7iwoD+Lp8p56BLpH0yXkecBBes0MZutT1l3o6T5blQ5B7HrYgYZnCsaNS+Kf
	 Rv34ZUkPgBHQHEoH3U2klhWMaNUxCRFD0o5tHLonTogbTfAWy74SOq0N5IwTaYrjq4
	 1jFUl/FrKH+nA==
Date: Mon, 20 May 2024 14:29:05 -0500
From: Rob Herring <robh@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Message-ID: <20240520192905.GA1345016-robh@kernel.org>
References: <20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com>
 <20240515-arm-psci-system_reset2-vendor-reboots-v3-1-16dd4f9c0ab4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515-arm-psci-system_reset2-vendor-reboots-v3-1-16dd4f9c0ab4@quicinc.com>

On Wed, May 15, 2024 at 04:09:44PM -0700, Elliot Berman wrote:
> PSCI reboot mode will map a mode name to multiple magic values instead
> of just one. Convert the mode-.* property to an array. Users of the
> reboot-mode schema will need to specify the maxItems of the mode-.*
> properties. Existing users will all be 1.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml |  4 ++++
>  .../devicetree/bindings/power/reset/qcom,pon.yaml          |  4 ++++
>  .../devicetree/bindings/power/reset/reboot-mode.yaml       | 14 ++++++++++++--
>  .../bindings/power/reset/syscon-reboot-mode.yaml           |  4 ++++
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> index 627f8a6078c2..03b3b9be36de 100644
> --- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> @@ -30,6 +30,10 @@ properties:
>  
>  allOf:
>    - $ref: reboot-mode.yaml#
> +  - patternProperties:
> +      "^mode-.*$":
> +        items:
> +          maxItems: 1
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index fc8105a7b9b2..95964e04d5d6 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -68,6 +68,10 @@ allOf:
>      then:
>        allOf:
>          - $ref: reboot-mode.yaml#
> +        - patternProperties:
> +            "^mode-.*$":
> +              items:
> +                maxItems: 1
>  
>        properties:
>          reg:
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> index ad0a0b95cec1..feb70609bb5f 100644
> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> @@ -28,13 +28,23 @@ description: |
>  
>  properties:
>    mode-normal:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: "#/patternProperties/^mode-.*$"
>      description:
>        Default value to set on a reboot if no command was provided.
>  
>  patternProperties:
>    "^mode-.*$":
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    # Limit to 1 outer cell, e.g. no mode-normal = <0>, <1>;
> +    maxItems: 1

So it's an array, not a matrix...

> +    # Note: to reference this schema, the allOf should include hint about
> +    # maxItems for the inner cell
> +    # allOf:

Don't need allOf here.

> +    # - $ref: /schemas/power/reset/reboot-mode.yaml#
> +    # - patternProperties:
> +    #     "^mode-.*$":
> +    #       items:
> +    #         maxItems: 1
>  
>  additionalProperties: true
>  
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> index b6acff199cde..bf6d68355e7f 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> @@ -31,6 +31,10 @@ properties:
>  
>  allOf:
>    - $ref: reboot-mode.yaml#
> +  - patternProperties:
> +      "^mode-.*$":
> +        items:
> +          maxItems: 1
>  
>  unevaluatedProperties: false
>  
> 
> -- 
> 2.34.1
> 

