Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C926B3E3116
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbhHFVZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbhHFVZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:25:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F505C0613CF;
        Fri,  6 Aug 2021 14:25:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A005C1F44D9A
Received: by earth.universe (Postfix, from userid 1000)
        id B97AE3C0C99; Fri,  6 Aug 2021 23:25:32 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:25:32 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: max17042: Document
 max77849-battery
Message-ID: <20210806212532.ifzhel4lwqzl7tya@earth.universe>
References: <20210727170345.115004-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bskezvipt2ws3npr"
Content-Disposition: inline
In-Reply-To: <20210727170345.115004-1-nikita@trvn.ru>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bskezvipt2ws3npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 27, 2021 at 10:03:44PM +0500, Nikita Travkin wrote:
> max77849 is a combined fuel-gauge, charger and MUIC device. Add it to
> the bindings documentation.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

Thanks, queued.

-- Sebastian

>  .../devicetree/bindings/power/supply/maxim,max17042.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1704=
2.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> index c70f05ea6d27..42ebf87d300b 100644
> --- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> @@ -19,6 +19,7 @@ properties:
>        - maxim,max17047
>        - maxim,max17050
>        - maxim,max17055
> +      - maxim,max77849-battery
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.30.2
>=20

--bskezvipt2ws3npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENqMcACgkQ2O7X88g7
+pqssQ//WB+VBHviKgOSMiCP3rb8/zNY6+ppZHXcUOYFa5Kb12oJYW18L6XjrUtT
ZvJaNnTB0uVxWUbOv5sel3uX3bpLVQUFDGGi6ausZ0vpGhK0w6gLct3JMq3LmOeN
a4UMIQxWcB8BZvH2Lf7eQ4ZLcx0leoeksmTd1EZfFh4GrnR00/CNLPryPQWCO2Wu
JLtEtVcLVnVbev3OnTrzSeJBD1tAC6FBZyz1ikmD5xzFimWzULmSxRqFwlpFpXpS
t7xCNO1vMqM6JFeerdbWe3w+gnUNi6DOsOz1XnNY0uHaAjyljGNjO+xZRyN/ybIa
pZyMoRjSut3zXK1ZgD7RuplGoUAf6y/HA9v4oh0PUk1lkaVxQaKLPt3l5nCAOO2F
2pqj2hv6CIJ0gOLnXr02ZDZsuZz1tV3glaWtZSlZcR6dDm0bvlD1sQ1u7l93672f
gVHD+d0Taipmka79ZSdC9hF1B+tPytdwich/YiTa+GVlRKPwK5C703iWI3fw7cdz
h8ZYqzfT9SEoTqYvqCW69dmuf6bf1VWW3nw71JdensG4y1DF5lRQpovXb2Gtkiz4
jp/6CVOTIccOqQhcYrZyd/9BLnbuL4M4EC+/rTCluOt7QAVWNzDmFd09YJPL2Dm3
jX/rwJFML7+eFYOH3ZYWD4v5BU0/Y5C+RR8RHJbnmbqhXVu0JUI=
=bub2
-----END PGP SIGNATURE-----

--bskezvipt2ws3npr--
