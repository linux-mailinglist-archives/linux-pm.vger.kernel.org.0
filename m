Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201B1232640
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG2Uhl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 16:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG2Uhk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 16:37:40 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8AA120663;
        Wed, 29 Jul 2020 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596055059;
        bh=5Y90cAO96vlIWPIkt6RMdl2l5Jof4kn6D3cz4q0fRVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUO+4MhvtXmqF6/dgsNIQGFcEiYvb82k41PGtbeVGW3n9kLIDxr8x0oWoRuQX/rov
         EnmFGgGg383Ysy1uTmpBgm2XznU3DoFvvlKtXKC+N9lkyig5xD3oRxEGp9c546eUiY
         dcSjk83vjjhu3pPCzyfFAxNPKz2SifPEwBuAJjOU=
Received: by earth.universe (Postfix, from userid 1000)
        id B741F3C0B87; Wed, 29 Jul 2020 22:37:37 +0200 (CEST)
Date:   Wed, 29 Jul 2020 22:37:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     afd@ti.com, pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: power: Add BQ27Z561 compatible
Message-ID: <20200729203737.knwq45vy2seycbxa@earth.universe>
References: <20200729183145.6066-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zjful3mfhmqw7y3q"
Content-Disposition: inline
In-Reply-To: <20200729183145.6066-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zjful3mfhmqw7y3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 01:31:42PM -0500, Dan Murphy wrote:
> Add the Texas Instruments bq27z561 battery monitor to the bq27xxx
> binding.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml =
b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> index 03d1020a2e47..0aa33590ac24 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> @@ -49,6 +49,7 @@ properties:
>        - ti,bq27426
>        - ti,bq27441
>        - ti,bq27621
> +      - ti,bq27z561
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.28.0
>=20

--zjful3mfhmqw7y3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8h3g4ACgkQ2O7X88g7
+poIsg/9FYx9/wFD3fssLNLlLEAjM5E//gCI0WjRDE8wjBqphWwX30+PPiD91kyv
v9E61m82sgCnjY5HkElpNBD+g81WlJNKqtwyVfqG0jsniQGfoS33ARZVB1lZ/e37
ExM+oihKvDxdKeIz2YVPaszo6YFSgB5DMVa9abWTseooyQEBvlxEeTEuKSpQ2hng
yeNW4SEBEluAiM+qAKMyLC4gJCQFl49NipTKyAba5sZn/68nvQzu2IDTHGej2yKK
37QdOwNJOEZke6tIzoanwOIoqCohKEhlNmUvFT5pK8UXuM4feZrGwzmmqDX+zony
xCld5d+x9uocPDUv96hsvj9IHLMU/uGA8npxqcLqJSSyBKdlBusBm1/p4OnInFuq
203FDUn4YqAS6OhhgOb0wAjc3JnKxXG3uYxF2/Dx6QyR1vt6k2iVMTAxHV/I1BR/
+KUyHvjgUaL09RVQDxzHtnwHtwJL0w2NT4JgfcMLKNRQ4N6mUKe77jg0m+9Mnit4
nMxverZRpCKHqcMg8vv/2+/1BXwtm6/N28Dtmv1oxkS3LQw6R3sKZ4bkLVd+d4aM
kM0rlSG+2mZoqs8dzUeCOyXeBJmFdnDD1VcLwx5zt8cuMz1ATTlEvK4xw9zAYljB
ANBzDc4onRqmnohfb5RgxX4A8NusKfLGh+hKJahSaY8OFGPdsXs=
=po3s
-----END PGP SIGNATURE-----

--zjful3mfhmqw7y3q--
