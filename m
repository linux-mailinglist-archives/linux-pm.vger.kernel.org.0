Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3645CDE75A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfJUJFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 05:05:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60678 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfJUJFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 05:05:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D6C2C265D34
Received: by earth.universe (Postfix, from userid 1000)
        id D7A113C0CA0; Mon, 21 Oct 2019 11:05:04 +0200 (CEST)
Date:   Mon, 21 Oct 2019 11:05:04 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Tony Lindgren <tony@atomide.com>, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH power-supply] power: supply: cpcap-charger:
 cpcap_charger_voltage_to_regval() can be static
Message-ID: <20191021090504.qqkynac4jmxeru33@earth.universe>
References: <201910210600.WlHJI3rO%lkp@intel.com>
 <20191020222052.hud2r3jx2rvrrip3@4978f4969bb8>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bni24srr2gghv7xz"
Content-Disposition: inline
In-Reply-To: <20191020222052.hud2r3jx2rvrrip3@4978f4969bb8>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bni24srr2gghv7xz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2019 at 06:20:52AM +0800, kbuild test robot wrote:
> Fixes: d4ee021c410f ("power: supply: cpcap-charger: Limit voltage to 4.2V=
 for battery")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---

Thanks, I added a long description and queued it to power-supply's
-next branch. I did not fold it into the original patch, which is in
an immutable branch.

-- Sebastian

>  cpcap-charger.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index 88bbab6e62f07..b4b7f9dc6c4ea 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -478,7 +478,7 @@ static void cpcap_charger_update_state(struct cpcap_c=
harger_ddata *ddata,
>  	dev_dbg(ddata->dev, "state: %s\n", status);
>  }
> =20
> -int cpcap_charger_voltage_to_regval(int voltage)
> +static int cpcap_charger_voltage_to_regval(int voltage)
>  {
>  	int offset;
> =20

--bni24srr2gghv7xz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2tdL0ACgkQ2O7X88g7
+po4Rw/+OR3E3IKfuROtwdXhHh1/w8BKqTQ6mI/tFcoRZwyHRcEnN6UtBE29ol0Y
zp0hU6n/gwvp7VcGHojiP5DB3JcZHsZ/r5un2sdPIU6k3tRy3sjl1qNUgZSH3cRV
H4RWkRj8j2S3OmV1LHlWj7WgSNQvG1r4eAUj7oASPi7Yxptlz/wk56UZ3gxtpWn8
fa6jvh3Q0a7LK11G/abCMgWzeFOQ3fUVIY+ivHb0LUJSAch7n177sHBhQWj/ftbb
CwNRVNLn5Zhpyq+LBX9X0suIADqg1L6uB3JZpjnigO06N/YWn7BvDDU/4A93h15M
TjsiCALCZF8nJfou6EAmqolP0/6tIk6ROOYeK9WtP0p1cxaYA0u3q7NLpyqYTfZ7
r1NDXCeT9lvz+o0tlxFzQrcs0CjKC0u9DbS5uyzjjJ4YcqnPWmU2cG+y6ZEVYlo5
1g6g9dUr6bkedddGVClMw2QcO+1sJailX7cVLyStw+rsvmUJVkbCF3n/VFwRxfgp
oIowFPEajgeePcG3W7znzijYYkBOaD0VTEpu5HTDu5X6V/MrOS8BSQD2LFPxzpaE
OgeFiJghOudiGuCsrjLx3UbzYuTvl/ee1SviIDUHTcVb4n2V4TG9JhadmQJ1andB
AGTkidwSNdG2U3lGoIAdzuEcsk5V8tQOpitnh/dcfm/NuDSA500=
=QaEr
-----END PGP SIGNATURE-----

--bni24srr2gghv7xz--
