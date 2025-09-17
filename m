Return-Path: <linux-pm+bounces-34914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62AB81A33
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 21:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B133188FF8A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69C22D662D;
	Wed, 17 Sep 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFBRx0CE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B839820E03F;
	Wed, 17 Sep 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137467; cv=none; b=sJqKVgw0BSxXLcv/JiXrw0bs2gmYMyJgAD1ONQaw+QqlUabBprs2fGK5uIVURBnkcGFF1jKHL4X2jxBGmKeX7iKsDQhJIyJJBH0tMQaiHn/kUtvIGdrFjUTz4Ptf4zb4Q12mEE3wKnItcAm+7KxVJMrcgIG+EOia6pSivFjrnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137467; c=relaxed/simple;
	bh=CqHwmT9jquJeX+EOuVFi/0NzpVRGCzy+hiZmGgVtW60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDGnjMD6Y+l2RcpKH44lqlGMkffqKM0+13ADI64UU2X9tmjWwN4ivcR8zeA0W2vnZ1FPA1Htm0ohiBu0EccTlR7kQoHo4fBJpqNVdqrpu9krGKcHQVMBEahQwnI+IaObkPxo2c+nRCEebs6HgYx5v0LNdsefzZmGGgMxBMTlQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFBRx0CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9F4C4CEF7;
	Wed, 17 Sep 2025 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758137467;
	bh=CqHwmT9jquJeX+EOuVFi/0NzpVRGCzy+hiZmGgVtW60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFBRx0CEoMoBxb7hu4YJFHjQFHjSbGtjzre87bEBhm34jP6xjcJiUEwdATpcjUYkw
	 SRG2RoHicyG/894mlK9TWuGmMNM475o19F2JfEEIc85onRIivFD7NHqeABm7hUKCOC
	 s5SsRpTIZgCyA0+NK1AhDUCr4o/pBURjCjE4wc89Bae4c1W7FESfXqhEtqAO6grm8D
	 Q4eaF08o+ZUJWcxHT+lk1Nc9QQa/+IVtUrY+r8HnlyMmAajwCNRoqWi+pkO36em7YR
	 hAunXLRVwqzVVRTAYM4dqxS86uL295XAeCrBfb1rp8b4YKwhD7bXQMzZhrle/3gSr9
	 RNKFWLo3RPHVA==
Date: Wed, 17 Sep 2025 20:31:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Willow Cunningham <willow.e.cunningham@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 2/4] dt-bindings: soc: bcm: Add bcm2712 compatible
Message-ID: <20250917-crept-romp-8c02570c1d6f@spud>
References: <20250917063233.1270-1-svarbanov@suse.de>
 <20250917063233.1270-3-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hsLFofKKl/aa/7Bd"
Content-Disposition: inline
In-Reply-To: <20250917063233.1270-3-svarbanov@suse.de>


--hsLFofKKl/aa/7Bd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 09:32:31AM +0300, Stanimir Varbanov wrote:
> Add bcm2712-pm compatible and update the bindings to satisfy it's
> requirements. The PM hardware block inside bcm2712 lacks the "asb"
> and "rpivid_asb" register ranges and also does not has clocks, update
> the bindings accordingly.
>=20
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.ya=
ml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> index e28ef198a801..c8d3d6131a8d 100644
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> @@ -13,8 +13,7 @@ description: |
>  maintainers:
>    - Nicolas Saenz Julienne <nsaenz@kernel.org>
> =20
> -allOf:
> -  - $ref: /schemas/watchdog/watchdog.yaml#
> +$ref: /schemas/watchdog/watchdog.yaml#

Please move this down with the allof.

> =20
>  properties:
>    compatible:
> @@ -22,14 +21,15 @@ properties:
>        - enum:
>            - brcm,bcm2835-pm
>            - brcm,bcm2711-pm
> +          - brcm,bcm2712-pm
>        - const: brcm,bcm2835-pm-wdt
> =20
>    reg:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 3
> =20
>    reg-names:
> -    minItems: 2
> +    minItems: 1
>      items:
>        - const: pm
>        - const: asb
> @@ -62,7 +62,25 @@ required:
>    - reg
>    - "#power-domain-cells"
>    - "#reset-cells"
> -  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - brcm,bcm2835-pm
> +              - brcm,bcm2711-pm
> +    then:
> +      required:
> +        - clocks
> +
> +      properties:
> +        reg:
> +          minItems: 2
> +
> +        reg-names:
> +          minItems: 2

If the new device doesn't have clocks or the extra reg ranges, please
add an else clause that enforces it.

> =20
>  additionalProperties: false
> =20
> --=20
> 2.47.0
>=20

--hsLFofKKl/aa/7Bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMsMdQAKCRB4tDGHoIJi
0oEUAP96o7GTUuuNQybMRhkNw285zZaGo8XaVxkYQ3BLGFgV6wD/RPPmf9sqKXEb
fpXxJZcldGF1WuzX8uE8HjH1H+SKgAU=
=7ERd
-----END PGP SIGNATURE-----

--hsLFofKKl/aa/7Bd--

