Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A829437FA4F
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhEMPMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEMPMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 11:12:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B6C061574;
        Thu, 13 May 2021 08:11:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C43321F42C58
Received: by earth.universe (Postfix, from userid 1000)
        id 20E0D3C0C95; Thu, 13 May 2021 17:11:03 +0200 (CEST)
Date:   Thu, 13 May 2021 17:11:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola =?utf-8?Q?Milosavljevi=C4=87?= <mnidza@outlook.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] power: supply: sbs-battery: Silence warning about
 unknown chemistry
Message-ID: <20210513151103.hihvxg7kvych4nwr@earth.universe>
References: <20210510220827.11595-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lyzvqae6qiq3zjju"
Content-Disposition: inline
In-Reply-To: <20210510220827.11595-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lyzvqae6qiq3zjju
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 11, 2021 at 01:08:26AM +0300, Dmitry Osipenko wrote:
> Older variants of controller don't support reporting type of the battery.
> Make warning message about unknown chemistry to be printed only once in
> order to stop flooding kernel log with the message on each request of the
> property. This patch fixes the noisy messages on Asus Transformer TF101.
>=20
> Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # TF101
> Tested-by: Nikola Milosavljevi=C4=87 <mnidza@outlook.com> # TF101
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

I believe the problem should be fixed as side-effect of the
following patch:

https://lore.kernel.org/linux-pm/20210513020308.4011440-1-ikjn@chromium.org/

With my suggested change the message is printed once for each
battery plug, so probably only once per boot for most users.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 8d7a10730e43..b71fbf543428 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -814,7 +814,7 @@ static int sbs_get_chemistry(struct i2c_client *clien=
t,
>  		val->intval =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> =20
>  	if (val->intval =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> -		dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
> +		dev_warn_once(&client->dev, "Unknown chemistry: %s\n", chemistry);
> =20
>  	return 0;
>  }
> --=20
> 2.30.2
>=20

--lyzvqae6qiq3zjju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCdQYEACgkQ2O7X88g7
+pqVwg//cYFlMccwaqLE2aR3E40lWPQM14FlZYq8FCJLeuCYXnE6NRcZDMZkH1A8
DcskPOxpNUNPvhKjCZMMzYCZU4vPv8ZqdUTrsxC6H0B4xAa3zgMWVvgdrDWtu5+1
wBZ9rHeIs7ko/vTcn3TNbj9EaRuuFYvUbjVzVHp7N2S7NFNOtSHu4r/FSksuCWEN
qcd2YtvkZECN6i7FESQ1PxDN8gR2VzDSDF0fkEBzLkkVXcZ90se74Kq8wfmc4uMC
XMM/9MDhJpZxaXfHE/xMhhF1SntAfGJ5pjpPhhRxbNh71K80OxMcGM2V3rhrrt5a
4kostmwHoEoVb1d/fQ/nxTSusUO9ujhE2Qrda2qfTIzp7wahMrPQTdp70tzf/rEI
Udr85I7c5dC3OTZkGossB/e1Za6XdllWu7KpoQkiLsPL444EaMKuMaCveC617X0a
5rPQxIKmc3QKxvC2TKsr9mbd0akZ5xhDVnE/+JJ4EoEwd2rpaa9Mbu5MSdO18B1W
RchfbmRFsaXtSvBzGRZCWMLdNOJSJnm+5n7aGc6nKsyRRHs6z/uzHDn8WHXrVt6v
bOOxmjb/1WQlhybnA0UC6pkzJNMsPOlZtwpTG4C9Tlh3rbaJ9yKMFnbkO313RyRa
UI3UM+L5ruL4FiplM0K6nW9gK+lSc69NUQmcTsxhumkg3yqcYg4=
=hYys
-----END PGP SIGNATURE-----

--lyzvqae6qiq3zjju--
