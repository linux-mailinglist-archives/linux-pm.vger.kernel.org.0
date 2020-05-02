Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F501C288E
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 00:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgEBWXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 18:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728530AbgEBWXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 18:23:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB3C061A0C;
        Sat,  2 May 2020 15:23:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 35F9B260157
Received: by earth.universe (Postfix, from userid 1000)
        id 0F1993C08C7; Sun,  3 May 2020 00:23:49 +0200 (CEST)
Date:   Sun, 3 May 2020 00:23:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] power: supply: core: add input voltage/current
 measurements
Message-ID: <20200502222349.tfa72nr5zunybpla@earth.universe>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
 <249d7ad42b02bfeb8c31c49a64ee92b3e745086d.1588345420.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3ivjy5uiv4t2q7t"
Content-Disposition: inline
In-Reply-To: <249d7ad42b02bfeb8c31c49a64ee92b3e745086d.1588345420.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--g3ivjy5uiv4t2q7t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 05:11:18PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Introduce input voltage and current limits and measurements.
> This makes room for e.g. VBUS measurements in USB chargers.

We already have properties for charger input voltage/current.
Unfortunately the naming is not as straight forward, as it
could be. Basically the properties have been added over time
and are ABI now. Things are documented in

Documentation/ABI/testing/sysfs-class-power

I provided the relevant properties below.

> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

[...]

> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -273,7 +273,9 @@ static struct device_attribute power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(charge_control_limit_max),
>  	POWER_SUPPLY_ATTR(charge_control_start_threshold),
>  	POWER_SUPPLY_ATTR(charge_control_end_threshold),
> +	POWER_SUPPLY_ATTR(input_current_now),
>  	POWER_SUPPLY_ATTR(input_current_limit),
> +	POWER_SUPPLY_ATTR(input_voltage_now),
>  	POWER_SUPPLY_ATTR(input_voltage_limit),
>  	POWER_SUPPLY_ATTR(input_power_limit),
>  	POWER_SUPPLY_ATTR(energy_full_design),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6a34df65d4d1..5313d1284aad 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -127,7 +127,9 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_NOW,

What:           /sys/class/power_supply/<supply_name>/current_avg   =20
Date:           May 2007
Contact:        linux-pm@vger.kernel.org                         =20
Description:                 =20
                Reports an average IBUS current reading over a fixed period=
=2E  =20
                Normally devices will provide a fixed interval in which the=
y  =20
                average readings to smooth out the reported value.         =
   =20
                                                                           =
    =20
                Access: Read   =20
                Valid values: Represented in microamps

>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW,

What:           /sys/class/power_supply/<supply_name>/voltage_now   =20
Date:           May 2007   =20
Contact:        linux-pm@vger.kernel.org   =20
Description:   =20
                Reports the VBUS voltage supplied now. This value is genera=
lly   =20
                read-only reporting, unless the 'online' state of the suppl=
y   =20
                is set to be programmable, in which case this value can be =
set   =20
                within the reported min/max range.   =20
   =20
                Access: Read, Write   =20
                Valid values: Represented in microvolts   =20

>  	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>  	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,

-- Sebastian

--g3ivjy5uiv4t2q7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6t8u0ACgkQ2O7X88g7
+ppPhg//Zc1WwfEDVYa11+sBTdEsTb4FGzPsFixlXe4GE6kNmXK/uFzUmwH+8Jbe
YLtwTb7Disi0ub04w6ZAc3gwGLmRU6hRj/ybkFAcBh3WNli5AtY6K/hFU3mSZc9f
i2mNHKP/15VTswHgoteCx1LFvNsIhuH2D3CuR85zZneiX3vT8rT9MFItAvr+mNTK
pegtIIhaGEgg44ab6k5PmSvrS3L/KhEM3ditb4mrWNCxt5yPDrB8oaYV9cRjKdPo
y7UGF6kM80fp5ggI9IWgysi7egLa49gb+3VNWOhgNUclEAgbQuRnM78nxQpPHtG0
xQO5h9jz5xrIEp7O8WKaDmtPz/lAZm62ofD15dGh+sZju4h8tWh8bbW0vAIekpXS
a+JjS5qeZVW1EvmDSC7wrVkUl5RGzZYvNoqftKxSVYCXVIPKOrDPmCFKiMGYe1+P
t7PsOwfmMvrEXH8dDAw1AOd9xIBAUx5PFAjN6T8Tmir0I81JDGeAN37gzCigoIJb
eeB+9vedR7PskCG0JzU+//Jx5mFKjZP6Ltk8PapowpT/TOca6LKrX24pCnYVzv+0
V27N/38P4bCnUSc0yFj2k2BSsFhISXCmUMjZv49pmoA4rqTC7bATIlRJX+2o5RpU
/J6Es9QaNPmtVSWwcLStnGtS6jKQZc4pQoKMHfG9SvZHovTb4JQ=
=Y7im
-----END PGP SIGNATURE-----

--g3ivjy5uiv4t2q7t--
