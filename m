Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7282E3068B1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhA1AfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhA1AfM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:35:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC8C061573;
        Wed, 27 Jan 2021 16:34:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 91E071F45627
Received: by earth.universe (Postfix, from userid 1000)
        id 5ABC23C0C97; Thu, 28 Jan 2021 01:34:27 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:34:27 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] power: supply: smb347-charger: Fix interrupt usage if
 interrupt is unavailable
Message-ID: <20210128003427.dil4b7vtqdt5p27u@earth.universe>
References: <20210122191734.27584-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hevgxstszn4dg4ig"
Content-Disposition: inline
In-Reply-To: <20210122191734.27584-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hevgxstszn4dg4ig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 22, 2021 at 10:17:34PM +0300, Dmitry Osipenko wrote:
> The IRQ=3D0 could be a valid interrupt number in kernel because interrupt
> numbers are virtual in a modern kernel. Hence fix the interrupt usage in
> a case if interrupt is unavailable by not overriding the interrupt number
> which is used by the driver.
>=20
> Note that currently Nexus 7 is the only know device which uses SMB347
> kernel diver and it has a properly working interrupt, hence this patch
> doesn't fix any real problems, it's a minor cleanup/improvement.
>=20
> Fixes: 99298de5df92 ("power: supply: smb347-charger: Replace mutex with I=
RQ disable/enable")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index d3bf35ed12ce..8cfbd8d6b478 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -137,6 +137,7 @@
>   * @mains_online: is AC/DC input connected
>   * @usb_online: is USB input connected
>   * @charging_enabled: is charging enabled
> + * @irq_unsupported: is interrupt unsupported by SMB hardware
>   * @max_charge_current: maximum current (in uA) the battery can be charg=
ed
>   * @max_charge_voltage: maximum voltage (in uV) the battery can be charg=
ed
>   * @pre_charge_current: current (in uA) to use in pre-charging phase
> @@ -193,6 +194,7 @@ struct smb347_charger {
>  	bool			mains_online;
>  	bool			usb_online;
>  	bool			charging_enabled;
> +	bool			irq_unsupported;
> =20
>  	unsigned int		max_charge_current;
>  	unsigned int		max_charge_voltage;
> @@ -862,6 +864,9 @@ static int smb347_irq_set(struct smb347_charger *smb,=
 bool enable)
>  {
>  	int ret;
> =20
> +	if (smb->irq_unsupported)
> +		return 0;
> +
>  	ret =3D smb347_set_writable(smb, true);
>  	if (ret < 0)
>  		return ret;
> @@ -923,8 +928,6 @@ static int smb347_irq_init(struct smb347_charger *smb,
>  	ret =3D regmap_update_bits(smb->regmap, CFG_STAT,
>  				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
>  				 CFG_STAT_DISABLED);
> -	if (ret < 0)
> -		client->irq =3D 0;
> =20
>  	smb347_set_writable(smb, false);
> =20
> @@ -1345,6 +1348,7 @@ static int smb347_probe(struct i2c_client *client,
>  		if (ret < 0) {
>  			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
>  			dev_warn(dev, "disabling IRQ support\n");
> +			smb->irq_unsupported =3D true;
>  		} else {
>  			smb347_irq_enable(smb);
>  		}
> @@ -1357,8 +1361,8 @@ static int smb347_remove(struct i2c_client *client)
>  {
>  	struct smb347_charger *smb =3D i2c_get_clientdata(client);
> =20
> -	if (client->irq)
> -		smb347_irq_disable(smb);
> +	smb347_irq_disable(smb);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.29.2
>=20

--hevgxstszn4dg4ig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASBpMACgkQ2O7X88g7
+poujBAAjurIzj0e+muNxEkKHCmG2/i6Zoj2oMRQSC8KdUK9mCGm5gtKBx54jdFA
VqieEtJxlCMwpyfEWKFbAdQEll3w07nG24IHWd+U7GWpeaymERDV/a01Zdvf9oo+
U385cXbGtOpjSRhOMQXSBfn5GPpZnfs24LpCXwXhH6h6s6knXTmyYcn24NPtqJxw
Cxytin9QkU6HSY/eAZOY8q1DRszVHtLVJJYJoHHkzr8Q3z/d11q7y62AROhk/PMH
tq8McX5nZewdmTj4M3NYYe6DA5WzH/7sS9xJNLpAMW7IN6OXPFShW+O9jOmEBHpT
sEgFnURyRlsyhclTp9QBz/mTQBOPE0jKWLF4Wlfu+rmYyj3V729q+a3aiCGWDkoP
vLlZkHRHw9g77GuyXbOXBInoZIvx6cTNinnrZLPHH3A/+csiQMfiB/XcvRTPBexe
/l9pSoFoufMqgvxOa/Ppk/9F8yBWbWAffxbVIsxSnJsopuZKKwMtVQOJBC3uVHwm
lAJtKa3P1OAXPrmz1uQCVDhmWqGhQymoc3Y3CoVq7r4njUNhuTElv8Vns34FKnmB
u1TS0xrMjq6nko9ip6wn8L491HicdKLZwpfKC7V2NGiCa36NuB8rYgAAITkJa4p8
I7KipfASEB3WIm2dSHbRYNDt55VURZB+GATuNSLz1iAkJDyolcQ=
=NZYk
-----END PGP SIGNATURE-----

--hevgxstszn4dg4ig--
