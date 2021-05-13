Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A437FB0D
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhEMPwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhEMPwV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 11:52:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79156C061760;
        Thu, 13 May 2021 08:51:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4730D1F40EFD
Received: by earth.universe (Postfix, from userid 1000)
        id 8881C3C0C95; Thu, 13 May 2021 17:51:07 +0200 (CEST)
Date:   Thu, 13 May 2021 17:51:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: power: supply: charger-manager: Convert
 to DT schema format
Message-ID: <20210513155107.qyur6dsrwpkrxpjk@earth.universe>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
 <20210412230320.382885-5-sebastian.reichel@collabora.com>
 <20210413152641.GA1707619@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f3dxslgfbnr5shxd"
Content-Disposition: inline
In-Reply-To: <20210413152641.GA1707619@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--f3dxslgfbnr5shxd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 13, 2021 at 10:26:41AM -0500, Rob Herring wrote:
> On Tue, 13 Apr 2021 01:03:18 +0200, Sebastian Reichel wrote:
> > Convert the binding to DT schema format.
> >=20
> > I slightly modified the binding by allowing regulator-[0-9] and cable-[=
0-9]
> > instead of regulator@[0-9] and cable@[0-9], so that DT compiler does not
> > complain about missing 'reg' property. The driver actually ignores the
> > nodename and can handle both styles.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../bindings/power/supply/charger-manager.txt |  91 --------
> >  .../power/supply/charger-manager.yaml         | 215 ++++++++++++++++++
> >  2 files changed, 215 insertions(+), 91 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/supply/char=
ger-manager.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/char=
ger-manager.yaml
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--f3dxslgfbnr5shxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCdSuYACgkQ2O7X88g7
+pqAqA/8D3sftstSxvWSAwrnIc71f6dMiQc8fkBjKfdHwxKa2wuGK/ujBrtn5u6p
y6cQ8uLLGJL0qUlZstQ85VdsJBsEYla3yc6HoIsRFLF3xn4oBPMD6hSQmp/x03E7
ay1fVAQo+9R9uV/OzBKQDJ0LxPw07LpE6KE5vAyz8E+N8E1XH3latq0cih8xVbK3
j+8NZZoCA/puOhMLt0fN5LXYEwP9rzG4aqWYd+MOJZOmMExnbSAQHvR9m0t6QlL/
zA3klBxOp2Vn3p9wflnXR5zbBbA3zNroYSsOsOWrw39vGNTsgzukeHyunMKkyTZb
ow7L+zlDDU4nggqDMzu/6sU1D6lMeWRpqJZn1DdM7akkptONML3Dnk4cFs/OzVLq
e1cic3QovO9/uWU7l/9f5nNhuBUzxe+JBWbHZ4UNb0Ve3pxP5u1VdQbJgXoGlu6y
esLOyOl9zllYupLsFjP5qFCIbYnHvuQ7UjPBrlDMKQhbOSJy/Oysa0ghkzViHhec
HQXLTQOQBlEHzc6iHrw31CF5BWku2MoWZd9eo5d4TOerCHrNMi6lCjeoDeUeZQIv
vtmCdrR0Ncf1p5cqLGzXXdvIdxoYfTSJW3LvekOosfRuAg0b17EYdjnNyN3ykM1s
yZN9UaYqyspSIbJX3kkwZSqvEAFA4SvwGmQBfX/+Ck+afOcm2E8=
=diRH
-----END PGP SIGNATURE-----

--f3dxslgfbnr5shxd--
