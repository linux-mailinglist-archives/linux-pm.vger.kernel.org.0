Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36522232301
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgG2Q7B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 12:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2Q7B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 12:59:01 -0400
Received: from earth.universe (dyndsl-095-033-172-175.ewe-ip-backbone.de [95.33.172.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9062B2075F;
        Wed, 29 Jul 2020 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596041940;
        bh=kcEKB3QzEwAil6vLUBn483iFGDd4Ij/50IyvUbfn3jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jlyqb7Dk8h6hBB9q7zBIzaXTQOBQIBNt2zlpnKpmnI9Gkym6YVohzfZdZzVrV51oj
         dAe1rzx5t9F1VP6o0u58DtOdexwg5B62w+GsY497Wh4wI3zSzTopr3s29SjhOJzttt
         aEUwU4kLPt1VH7EdDx7dtCnu21smZWZzcl4PPdE4=
Received: by earth.universe (Postfix, from userid 1000)
        id EA98C3C0B87; Wed, 29 Jul 2020 18:58:58 +0200 (CEST)
Date:   Wed, 29 Jul 2020 18:58:58 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Fix kerneldoc of
 power_supply_temp2resist_simple()
Message-ID: <20200729165858.l7o54jv3z2r7nzhu@earth.universe>
References: <20200729074348.28317-1-krzk@kernel.org>
 <20200729074348.28317-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3phqothtz62xkjcn"
Content-Disposition: inline
In-Reply-To: <20200729074348.28317-2-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3phqothtz62xkjcn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 09:43:48AM +0200, Krzysztof Kozlowski wrote:
> Fix W=3D1 compile warnings (invalid kerneldoc):
>=20
>     drivers/power/supply/power_supply_core.c:747: warning: Function param=
eter or member 'temp' not described in 'power_supply_temp2resist_simple'
>     drivers/power/supply/power_supply_core.c:747: warning: Excess functio=
n parameter 'ocv' description in 'power_supply_temp2resist_simple'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks, merged.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 90e56736d479..ccbad435ed12 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -733,7 +733,7 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
>   * percent
>   * @table: Pointer to battery resistance temperature table
>   * @table_len: The table length
> - * @ocv: Current temperature
> + * @temp: Current temperature
>   *
>   * This helper function is used to look up battery internal resistance p=
ercent
>   * according to current temperature value from the resistance temperatur=
e table,
> --=20
> 2.17.1
>=20

--3phqothtz62xkjcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8hqtIACgkQ2O7X88g7
+prYvg/+KMhioz3PNtgPsW+e1QlHaTfb2IyiW6RXBEVxpSSCO0h5CsuEznDuhm5b
YavOe/0bAqqCCopBmUQTFOLX3aTssEaY8BA9y7Ft+BdqZ4P2lj/JM6HYE2TF/tgV
evrIOf7t1X3xrJ0WSL0kdh/vQyqhErK10frQLTtCgzVsiFw3xthD1FaclEyelCjY
h6pPVYj0h96g7oYokBr0aj1yiZmB0cZyowIPDBhKNOTCsaf0V6XBhpdolactz5YV
d/JOlyMbUWmlI67WQn8FNcYkycmgj73dtczb0dpAXYG0a+csPUNHhwzZH+xMIdaD
uJehkXeO2ypd3RA8RLltAef1AjzIIaRRN7yy/j2BPcWe+gmmAieRTN9DvthFSD0q
L/c9mO44Qxc3ukEE/8XZO2ts+t/HeHfVZoiLZswm2nLriLhFNlW/jGvMReDpS3Yb
Nbkky4RxFz2caFNse2ignPxb0hoaCi8tvvoMdH1VgSoc9BWC+WYky7XIZIeLTZTB
r/gAEhrV0eRpJk12Z8mdSTvhOW6FLyouqvk+Wv7BM+/kOwiix9qyO64UHK2cM0je
6T8b9Ypf4AMf1MgeJtX+WLRm+OD1EyBgQ8X8gjADiGWpFXoyFlb0/WYTQauQOm56
5zHAplUunRRTKlMgLd6ciZz5t6vs3DLT42GTBgmhc+r8LvcftvI=
=BUS8
-----END PGP SIGNATURE-----

--3phqothtz62xkjcn--
