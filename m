Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869C945082A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhKOPZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 10:25:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53728 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhKOPZU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 10:25:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 301CE1F44DD6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636989744; bh=TA++YSDqnpbxawAR7LITn/nqkwigXPJ4fXQf9ty+PgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+w5tpL2HBQLpJ6JJvtbFz9AeZfT44oqpbtojAGomoKiSflzyyh1kUxStfw2rvP2O
         I8JKEhvYDGldVwVCUbhTPSeXBz5aCfEQpx8p2DzFGIPEZatxMHHqmSZG4PFBqv6dlj
         XNeu3Uq0JpyvjpQr/FSj1B/qXypMZ0hFZ7XUa5+hpzcjoMOLExWzfymiSMsEinRGDA
         apBp5rRBI6b5dFiqH7JNPHrS2T9JvhgjLuh2QdzoFg2bv0/S/quVPBnOIz9J3F1WYs
         lT/p/suwkSoP0xLjoHs9cNvx2PkjXeiblBC3Det+zHSDgOAOPH8vf+kN6N3v/kATcA
         xUJQopK/eSeyQ==
Received: by earth.universe (Postfix, from userid 1000)
        id A159C3C0F95; Mon, 15 Nov 2021 16:22:21 +0100 (CET)
Date:   Mon, 15 Nov 2021 16:22:21 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH] power: bq25890: temperature is also an adc value
Message-ID: <20211115152221.izjh36qlmlw5mbf6@earth.universe>
References: <20211110002440.71404-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4kwm62h3atuhhn7s"
Content-Disposition: inline
In-Reply-To: <20211110002440.71404-1-angus@akkea.ca>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4kwm62h3atuhhn7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 09, 2021 at 04:24:40PM -0800, Angus Ainslie wrote:
> Make sure that a conversion is forced when the power supply is offline so
> the temperature is valid.
>=20
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> ---

Thanks, queued to power-supply's fixes branch.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 945c3257ca93..23a91c5d1f9d 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -388,6 +388,7 @@ static bool bq25890_is_adc_property(enum power_supply=
_property psp)
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_TEMP:
>  		return true;
> =20
>  	default:
> --=20
> 2.25.1
>=20

--4kwm62h3atuhhn7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGSey0ACgkQ2O7X88g7
+pqsqA/+PLhM9nGPd3yVYVcMX+1871ieMMyrEmlvBhXKfZSpr6gPfmyLU4Ushwo8
g9rwEvkAyZmeWkBBljAVgTf6ummRlJK1aTnhuS2ysSHq9jbw5QkX2yt8BCuzA2co
Bticfk/nuCRtKP/2Vfg4Ebfb64yn77gcGGdwp/VRSUYQs+Jxu5L7K0pA5bGSkicB
oy5pYzUbtonV2UyKPSYdXqxuVVc7V4y6EoZib3lQKA1dKezJQDO+yNe5/QVr6zgu
J38bdYtUiFHV+UlblNLnq7QnqrlRCf6cMCEXjMqSpO1G6V9ROy7fi2zfLYsPIuch
WlMBM2WSaCJHrop7NIH76Ua0H3qSJbPllpQnQpFIL7iB7An1bhwrMJIcSO/ATldI
xjDpnITthGVN4QyoALr/1DdOpRReOJcnlXbSpCAHWqaAy5EoE8n5Mj7Kf2OFJfvX
MIitVfjsSlCG53m92ho48AacCENNnl+MZ9OFZpYQqF3k115v0kEovYUzXnOfHS8D
LH0WapGRMykCUiT+tMIEWVpboR1Q+tU6MukxistTUWmvuTnERtZiNlFB2QIBuBL7
/BnVBivtpbTWkN0Ibf6JcT+4HHL/AwPa9dFuDAiqdWopGYhfCL4MIahYCi9ba2Ey
XR0T1JJUFnUgfM5eC6uhhV5GGX4r8TTMYGnTUEf1JX4SzPDC1SE=
=r0Ws
-----END PGP SIGNATURE-----

--4kwm62h3atuhhn7s--
