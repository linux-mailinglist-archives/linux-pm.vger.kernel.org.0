Return-Path: <linux-pm+bounces-27758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D1BAC7247
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 22:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E858F189F8FA
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F357220F36;
	Wed, 28 May 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXVrx4Sr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BFB8F6B;
	Wed, 28 May 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464534; cv=none; b=Q2IWzqSGFCWzFhDJRZZH29r+fE3nPE+BcmYXZaWosq6EACDgua6SsXHkTPHdAEptZQg/EGtAaesEomC9CSbZni2DQz1cQInmSCEo4HddGF9WmZePfHfreqydppiBDJaN3sk9eF+fGu9VEdUNpQ/3tipV2iRr0C4kmwyPk9UtnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464534; c=relaxed/simple;
	bh=avCNmZfyuO05l7d+1PoNV7xnMEo8BcBGoUvR/4OT5/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6uvTRj2XNztXVG1HtV6hWK2CJJxGFj6MWoiN0jB27uFqH5yjKsNXxflQCoD3cPfZju2EKunNWf3h/koByd6fvpwpffHWXPHlJBppfPsB3BOzb1XPJiuzg3iWoUA/2Ivn+BrK/XK0vA0sYhD63GFX6HeY0jt3vFdpP3/2ShWSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXVrx4Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A056AC4CEE3;
	Wed, 28 May 2025 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748464533;
	bh=avCNmZfyuO05l7d+1PoNV7xnMEo8BcBGoUvR/4OT5/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXVrx4SraKxU/IrxYw4EJ+dWqcfTOLm7ig/7ipHzrB3PvS9fEePASz+Gh6Yvn4/XJ
	 JJtwlr3RwQleZstiyP2vKuuZgZyAwvJTe3cC5O5qbyVrbxVpLiXkA8GOavMlw/+j/K
	 QJkA6OAMpAbzjNmEpZQRdYuLqlk+WblBVCjw5GCUI3W0n5fxEfPhqtofqtij0shqiL
	 5VgyiMAySQjafhdxI8xdUGHLilEppSh/VrgOgQd3mhGqzlD6xcbZ2YPnLzXgXYePQy
	 0XGhWqIo9GvhSElWPGnOsiR1nCr/TAO3f3L83NiBsMFHugq4U8RJBnrOhT027dDHHI
	 gIXXjCZvceRKw==
Date: Wed, 28 May 2025 15:35:32 -0500
From: Rob Herring <robh@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org
Subject: Re: [PATCH RFC] pmdomain: core: add hierarchy support for onecell
 providers
Message-ID: <20250528203532.GA704342-robh@kernel.org>
References: <20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com>

On Wed, May 28, 2025 at 01:03:43PM -0700, Kevin Hilman wrote:
> Currently, PM domains can only support hierarchy for simple
> providers (e.g. ones with #power-domain-cells = 0).
> 
> Add support for oncell providers as well by adding a new property
> `power-domains-child-ids` to describe the parent/child relationship.
> 
> For example, an SCMI PM domain provider might be a subdomain of
> multiple parent domains. In this example, the parent domains are
> MAIN_PD and WKUP_PD:
> 
>     scmi_pds: protocol@11 {
>         reg = <0x11>;
>         #power-domain-cells = <1>;
>         power-domains = <&MAIN_PD>, <&WKUP_PD>;
>         power-domains-child-ids = <15>, <19>;
>     };
> 
> With the new property, child domain 15 (scmi_pds 15) becomes a
> subdomain of MAIN_PD, and child domain 19 (scmi_pds 19) becomes a
> subdomain of WKUP_PD.
> 
> Note: this idea was previously discussed on the arm-scmi mailing
> list[1] where this approach was proposed by Ulf.  This is my initial
> attempt at implementing it for discussion.  I'm definitely a noob at
> adding support new DT properties, so I got some help from an AI friend
> named Claude in writing this code, so feedback on the apprach is
> welcomed.
> 
> [1] https://lore.kernel.org/arm-scmi/CAPDyKFo_P129sVirHHYjOQT+QUmpymcRJme9obzKJeRgO7B-1A@mail.gmail.com/
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  Documentation/devicetree/bindings/power/power-domain.yaml |  39 ++++++++++++++++++++++++++++++++
>  drivers/pmdomain/core.c                                   | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> index 8fdb529d560b..1db82013e407 100644
> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -68,6 +68,21 @@ properties:
>        by the given provider should be subdomains of the domain specified
>        by this binding.
>  
> +  power-domains-child-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      An array of child domain IDs that correspond to the power-domains
> +      property. This property is only applicable to power domain providers
> +      with #power-domain-cells > 0 (i.e., providers that supply multiple
> +      power domains). It specifies which of the provider's child domains
> +      should be associated with each parent domain listed in the power-domains
> +      property. The number of elements in this array must match the number of
> +      phandles in the power-domains property. Each element specifies the child
> +      domain ID (index) that should be made a subdomain of the corresponding
> +      parent domain. This enables hierarchical power domain structures where
> +      different child domains from the same provider can have different
> +      parent domains.
> +
>  required:
>    - "#power-domain-cells"
>  
> @@ -133,3 +148,27 @@ examples:
>              min-residency-us = <7000>;
>          };
>      };
> +
> +  - |
> +    // Example of power-domains-child-ids usage
> +    MAIN_PD: main-power-controller {
> +        compatible = "foo,main-power-controller";
> +        #power-domain-cells = <0>;
> +    };
> +
> +    WKUP_PD: wkup-power-controller {
> +        compatible = "foo,wkup-power-controller";
> +        #power-domain-cells = <0>;
> +    };
> +
> +    scmi_pds: protocol@11 {
> +        reg = <0x11>;
> +        #power-domain-cells = <1>;
> +        power-domains = <&MAIN_PD>, <&WKUP_PD>;
> +        power-domains-child-ids = <15>, <19>;
> +    };

This all looks like a nexus map which is defined in the DT spec. To 
date, the only ones are interrupt-map and gpio-map. Here that would look 
like this:

power-domain-map = <15 &MAIN_PD>,
                   <19 &WKUP_PD>;

Quite simple in this case, but the general form of each entry is:
<<child address> <provider specifier cells> <parent provider> <parent provider specifier cells>>

<child address> is specific to interrupts dating back to the days when 
interrupt and bus hierarchies were the same (e.g. ISA).

For the existing cases, there's no s/w involvement by the child 
provider. For example, with an interrupt, the device ends up with the 
parent provider interrupt and there's no involvement by the child 
provider to enable/disable/ack interrupts. That doesn't have to be the 
case here if that's not desired.

Rob

