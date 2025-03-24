Return-Path: <linux-pm+bounces-24468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF9A6E037
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 17:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1DA3AB4EE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB02638A0;
	Mon, 24 Mar 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvY5EWYg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7B3B1A4;
	Mon, 24 Mar 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835179; cv=none; b=ZTIMSZa2m7rxjUwBGJQPYRA4yBOJ4lP7gCVr6VEg9Z+QGYpBJp4b/uEaLkk6Cao2+QHGj/Rd8WJkd2M1aJ2V5wK3zXNU1EsAxbuAcO2H2vGOd+1vCpCBa6+Ak58lfbkosQXdJ6BWd+kchly6xe06sNA3mhKys7PAAfm+vH6EtQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835179; c=relaxed/simple;
	bh=ZTlTu5sNpwCy1aVL9V1BZdWECKB+NIhSRBl+nZGyj00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0a84arbtJ+wDtKr/Cf2WpGBuzQdMNFu/Vlx0SQRM+/uOP0kC3C5xpc3pZiltTfENr9rjcjRtFRvqPw2wV/4sXUbBr8s50bjK19sqDT4uDKMMokocToqwHc57PUNTWbJqbMlUoaHPQQcmZ5f5ErvbKF5aYNWptXWpD7aeB6mhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvY5EWYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF6C4CEDD;
	Mon, 24 Mar 2025 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835178;
	bh=ZTlTu5sNpwCy1aVL9V1BZdWECKB+NIhSRBl+nZGyj00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvY5EWYghYlT3yZ8uUFdIUzBMVuEXGcXOwik2FTH10HnrPmA9JQTqKn1w/GnL8Owq
	 0a+T+f7wrtF7IQ/RGapvxGfJakRb/oxycqF9CyKPs/jnJ6ykriB9+Yd1fWMq4wSV1m
	 7+3/bVdAZEIXpnA1TnGeVMOtuAkZ8JQW2Nk63l+tFkbtnhbMwu7RDPJpp4bAbJAvMG
	 VzxpH5SLmyLz2qFCFy3XXtUCxB2Fd3Rv/Nz9awWUeOAtFwhE/frzts9FnCkpiHXp9K
	 8ikw+6rHVfHvLgRMdOowz9BInDkWi1HW3b7KxZJIGvZi93JoFfstklKfgczQ/ZSmmf
	 fyY+z+nPH8jow==
Date: Mon, 24 Mar 2025 11:52:57 -0500
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/4] dt-bindings: mfd: Document Infineon/Cypress
 CG7153AM MCU
Message-ID: <20250324165257.GA458528-robh@kernel.org>
References: <20250323071424.48779-1-clamor95@gmail.com>
 <20250323071424.48779-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323071424.48779-3-clamor95@gmail.com>

On Sun, Mar 23, 2025 at 09:14:22AM +0200, Svyatoslav Ryhel wrote:
> Add binding for Cypress CG7153AM embedded controller. Pegatron implemented
> a custom configuration of this MCU in their Chagall tablets, utilizing it
> for battery monitoring.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/mfd/cypress,cg7153am.yaml        | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> new file mode 100644
> index 000000000000..f8469b5e3816
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/cypress,cg7153am.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon/Cypress Semicon CG7153AM Microcontroller
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  The CG7153AM, an 8-bit programmable microcontroller from Infineon/Cypress
> +  Semiconductor, communicates over I2C and is implemented in devices like the
> +  Pegatron Chagall tablet for fuel gauge and battery control functions.
> +
> +$ref: /schemas/power/supply/power-supply.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pegatron,chagall-ec # Pegatron Chagall tablet device
> +          - const: cypress,cg7153am
> +      - items:
> +          const: cypress,cg7153am

Is this just some general purpose uC which could be used for anything 
and the interface exposed is Pegatron's invention. If so, then I'd drop 
the cypress,cg7153am compatible. What use would it be to software?

> +
> +  reg:
> +    maxItems: 1
> +
> +  monitored-battery: true
> +  power-supplies: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        embedded-controller@10 {
> +            compatible = "pegatron,chagall-ec", "cypress,cg7153am";
> +            reg = <0x10>;
> +
> +            monitored-battery = <&battery>;
> +            power-supplies = <&mains>;
> +        };
> +    };
> +...
> -- 
> 2.43.0
> 

