Return-Path: <linux-pm+bounces-8003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A198CA2D8
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 21:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CCA1C2151E
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7226136E22;
	Mon, 20 May 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0MZ8AYf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2931AAC4;
	Mon, 20 May 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234288; cv=none; b=qh5fIyzZUeHQCzNV4snCl/yeCmdfdqsxpi++8SReVBiz9ETOe4SFNlGLGnK6y+SMKxFdhZBBwARq2O6saPRmaYDxx5KyNxE1RvA8IBDEQp012KwbHGTCOA6oOFeyfNrVnCRdJ+hKgx3QWjYP+NP6EyaPwSSCpNEFlACA56ZFl+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234288; c=relaxed/simple;
	bh=10RuVPJyv0cb0NDS7drH+ekYsGtckzk+dNuzrvyX0L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBqq1wZyQZ6VzR1VS+EKMgHxG+xINSXjr1m1V/QIMrq5M3sF8NoMdrrpN4Nu4/SoKny9PNBfqlBeJKmn2jpqZYrjVF5AqWHrnkO7HziUZaSiwseU9vI7OVc7s3h/L6MW7OqgjCp+/039axn7OneBcJqbWVodxRDzD/JiHeIK38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0MZ8AYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A28C2BD10;
	Mon, 20 May 2024 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234288;
	bh=10RuVPJyv0cb0NDS7drH+ekYsGtckzk+dNuzrvyX0L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0MZ8AYfLzpSg33qbrY/GlyIG7TurBlDzvbW4IM97qpgkf2laz8xA37tYK5x9I7/F
	 Fb63qN2NBIaLGXlyEAAjtRRtn3zDT1DBUUY3S50NdbEXmtWHKw13QML7rTjyzAfVWK
	 N4sSl5dfqO/xO4Ln0xZZglAyYbVxRaDTxCTfYkv/4ntiAJspw/E2IsAfvtghiKGfbV
	 8hoM2kLaBTA9imNTw9ufAODojkpgsbbeTuE3cSPcsM02ftgk3V9LhzFM6hiEIsvaHx
	 dXRvOmkHy/vf1NQ4agWEWHmfiPd0KaM0lGyoGFoFFW6sf4JV8qTKC/uskgsn74yo81
	 axIBT7WkDWwRA==
Date: Mon, 20 May 2024 14:44:46 -0500
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
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: Document reboot mode magic
Message-ID: <20240520194446.GA1368012-robh@kernel.org>
References: <20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com>
 <20240515-arm-psci-system_reset2-vendor-reboots-v3-2-16dd4f9c0ab4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515-arm-psci-system_reset2-vendor-reboots-v3-2-16dd4f9c0ab4@quicinc.com>

On Wed, May 15, 2024 at 04:09:45PM -0700, Elliot Berman wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 43 +++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index cbb012e217ab..47b5bbe540ce 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -137,8 +137,34 @@ allOf:
>        required:
>          - cpu_off
>          - cpu_on
> -
> -additionalProperties: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: arm,psci-1.0
> +    then:
> +      properties:
> +        reset-types:

The normal structure is declare all properties and nodes at the top 
level (outside of if/then schemas) and then add restrictions with 
if/then schemas. 

> +          type: object
> +          $ref: /schemas/power/reset/reboot-mode.yaml#

             additionalProperties: false

and a blank line

> +          properties:
> +            # "mode-normal" is just SYSTEM_RESET
> +            mode-normal: false
> +          patternProperties:
> +            "^mode-.*$":
> +              items:
> +                maxItems: 2
> +              description: |
> +                Describes a vendor-specific reset type. The string after "mode-"
> +                maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
> +
> +                Parameters are named mode-xxx = <type[, cookie]>, where xxx
> +                is the name of the magic reboot mode, type is the lower 31 bits
> +                of the reset_type, and, optionally, the cookie value. If the cookie
> +                is not provided, it is defaulted to zero.
> +                The 31st bit (vendor-resets) will be implicitly set by the driver.
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |+
> @@ -261,4 +287,17 @@ examples:
>          domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
>        };
>      };
> +
> +  - |+
> +
> +    // Case 5: SYSTEM_RESET2 vendor resets
> +    psci {
> +      compatible = "arm,psci-1.0";
> +      method = "smc";
> +
> +      reset-types {
> +        mode-edl = <0>;
> +        mode-bootloader = <1 2>;
> +      };
> +    };
>  ...
> 
> -- 
> 2.34.1
> 

