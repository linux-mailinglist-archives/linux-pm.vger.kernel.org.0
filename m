Return-Path: <linux-pm+bounces-32052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B23B1E3A1
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 09:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBE1723C06
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B6B233713;
	Fri,  8 Aug 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANxjiPOe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2AF222578;
	Fri,  8 Aug 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638497; cv=none; b=IWmsPi3JLXqP2WJSv7YVvyr39WcZmnvJfrTUzO1Bvb/ZjhJyaMFvawSWu8I7UhHZec60Idx6cpDvVCYrRni1mAXa0AgzAr0Ew2vinlLK2jgrTcWiuvBpNMs5RnXZyJBC51jWexS5pZIqo2SAgKzxgfo06+dv0RY3pP0O3CDvAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638497; c=relaxed/simple;
	bh=htYYTMvBIoJF3AsCajNAqmICTBXqJVYTEKxD4QMF3D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6Esjua4Cnr/8+9ANbYc2tfPHS9x3Gos/7dz220THmnX0BtvnLI+xEt17+eG0286M2AYDVDypzcmQqryFKpUWfz34oEwBrewtgvHUVFkM5IekTxPSc9O5/lEe1eyDTfjb3aa8PeBuOZfiFTZge9cb47kU6f2Pf15euJII09Vapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANxjiPOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB82C4CEED;
	Fri,  8 Aug 2025 07:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754638496;
	bh=htYYTMvBIoJF3AsCajNAqmICTBXqJVYTEKxD4QMF3D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANxjiPOewS3527iiBY1Trtv9QJ/OmWTljS3mBn4JNASVq1ZMOxzVTWGSS+spxi8O/
	 bJKqyUNR9Bfs/23ShbX4Zitb0Uollq10bGEygmjL0K/JfHRE1j1xSoX9r5GsoXt5CF
	 FrHsHcd9Z7gqNmYa7wSJXIk92MSMx15EYPaL8ZOFDQfSrn0Hl8dKfdTTIZQoNraF6W
	 vw9MUHVy4A6XNzl6fvrtbp1I6FzyeK0P8ao3L0QJuy5wNmj0qXlWxM0xxowolkFUYD
	 h6O+02wMdAm032dr7mnIApf41xcyr20RtNTlFQE8RD0gTTVmNwJ6xDzc+N8wymXp7P
	 cR8JYDBFoLRHw==
Date: Fri, 8 Aug 2025 09:34:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, David Wronek <david@mainlining.org>, 
	Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] dt-bindings: power: Add Marvell PXA1908 domains
Message-ID: <20250808-portable-expert-turkey-4f8f19@kuoka>
References: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
 <20250806-pxa1908-genpd-v1-2-16409309fc72@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250806-pxa1908-genpd-v1-2-16409309fc72@dujemihanovic.xyz>

On Wed, Aug 06, 2025 at 07:33:21PM +0200, Duje Mihanovi=C4=87 wrote:
> Add device tree bindings for Marvell PXA1908's power domains.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---
>  .../power/marvell,pxa1908-power-controller.yaml    | 105 +++++++++++++++=
++++++
>  include/dt-bindings/power/marvell,pxa1908-power.h  |  17 ++++
>  2 files changed, 122 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/marvell,pxa1908-powe=
r-controller.yaml b/Documentation/devicetree/bindings/power/marvell,pxa1908=
-power-controller.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..1cf3a45d56cbb7b75f7204d65=
6016a9a569da186
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/marvell,pxa1908-power-contr=
oller.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/marvell,pxa1908-power-controlle=
r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA1908 Power Domain Controller
> +
> +maintainers:
> +  - Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> +
> +description: |
> +  The Marvell PXA1908 SoC includes multiple power domains which can be p=
owered
> +  on/off to save power when different IP cores are not in use.
> +
> +properties:
> +  $nodename:
> +    pattern: '^power-controller$'
> +
> +  compatible:
> +    const: marvell,pxa1908-power-controller
> +
> +  '#power-domain-cells':
> +    const: 1

So this is power domain controller?

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    type: object

And this is as well?

You duplicated them.

> +
> +    description: |
> +      Represents a power domain within the power controller node as docu=
mented
> +      in Documentation/devicetree/bindings/power/power-domain.yaml.

We do not represent individual power domains, just like we do not
represent individual clocks.



> +
> +    properties:
> +      reg:
> +        description: |
> +          Power domain index. Valid values are defined in:
> +              "include/dt-bindings/power/marvell,pxa1908-power.h"
> +        maxItems: 1

So no address space, thus this is not a separate device node.

> +
> +      clocks:
> +        description: |

Drop everywhere |

> +          A number of phandles to clocks that need to be enabled during =
domain
> +          power up.

This does not exist in your example, so it is just confusing.

> +
> +      '#power-domain-cells':
> +        const: 0
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/power/marvell,pxa1908-power.h>
> +
> +    clock-controller@d4282800 {
> +      compatible =3D "marvell,pxa1908-apmu", "simple-mfd", "syscon";
> +      reg =3D <0xd4282800 0x400>;
> +      #clock-cells =3D <1>;
> +
> +      power-controller {
> +        compatible =3D "marvell,pxa1908-power-controller";

No address space, so this should be folded into the parent.

Best regards,
Krzysztof


