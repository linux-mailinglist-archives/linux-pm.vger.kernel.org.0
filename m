Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C541FCDE
	for <lists+linux-pm@lfdr.de>; Sat,  2 Oct 2021 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhJBPyW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Oct 2021 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhJBPyW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Oct 2021 11:54:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568EC0613EC;
        Sat,  2 Oct 2021 08:52:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6D0931F411C6
Received: by earth.universe (Postfix, from userid 1000)
        id 348223C0CA8; Sat,  2 Oct 2021 17:52:31 +0200 (CEST)
Date:   Sat, 2 Oct 2021 17:52:31 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: max17040: switch to
 unevaluatedProperties
Message-ID: <20211002155231.esfpwvirwjkhhij4@earth.universe>
References: <20210929160605.74831-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ab4zly5rdnua3eyf"
Content-Disposition: inline
In-Reply-To: <20210929160605.74831-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ab4zly5rdnua3eyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 29, 2021 at 06:06:05PM +0200, David Heidelberg wrote:
> Required for validation of power-supplies from power-supply.yaml.
>=20
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Thanks, queued.

-- Sebastian

>  .../devicetree/bindings/power/supply/maxim,max17040.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1704=
0.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> index f792d06db413..ffb344987a7b 100644
> --- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> @@ -62,7 +62,7 @@ required:
>    - compatible
>    - reg
> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.33.0
>=20

--ab4zly5rdnua3eyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFYgD8ACgkQ2O7X88g7
+pppyw/+Pr45fsL2424436n0/uBMv7viJDetLGP4IpWijlWCA4MgFBndngjRjyK3
5dzfsjd7+JarWzyCSeA1L8FrAb/H9sl+LLUoLAF0CtFxV0lHluW3R1ND+0hv0ubZ
dQXQ7Hx24csnXM7ONVyljhEQI/w4XwB2eHN4D0+vyFwVGEUHHSSFH/cqEhtABerU
OODcgs1ZC+42y/XwYF9EsLYMkRNsQqWYBcLSi2OZg1c1QST1TSJ7pakKGqmGzyZc
PvcQDTe8uInveS7Sm7aArMgLRoCY81F33ykMz2BFDvCT4SetQittn0NLgiglXDFd
9DeRa4Q1k83pSwQKols7TRa4Z3T8LZkcHXxGVEQFgMSNsS8WwAhHd2SlsW8S20KL
Zfg0GC/Fx0o9BwyJa9j+CoZ6WeLa83IIpvVwPPln/WqSeV6F7HUDz9tAF/RDbo3K
luTzAxy4a5IECm36LnrgQ8ydEC42VQGII1gkjHMDmbUmD3HlCiVyCsCh/Ayjgq0d
DPyKXjV0zdPWAHXgV3CgGkZpgpVEwknyQLgVnd2/7uq5zc/n8ZexVjJxIG+UjXux
6puN1CpIJl+l/WSlg+5HZIdVwnFgiqLpwvqjhA5OjFpn206Zl1sUWedqfLPoEK88
Db7FDGuysN6ncIa1Ta9Dfb1uwoF3yF8jiRSMH7PbkjdKYu73EBc=
=j8W1
-----END PGP SIGNATURE-----

--ab4zly5rdnua3eyf--
