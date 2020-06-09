Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5FB1F4A18
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 01:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgFIX3P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 19:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgFIX3P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jun 2020 19:29:15 -0400
Received: from earth.universe (dyndsl-037-138-184-022.ewe-ip-backbone.de [37.138.184.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF22206A4;
        Tue,  9 Jun 2020 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591745354;
        bh=so9mtAq9IjDAKHSiqosXpkJZ9H3m/cJJihtj8+pjvW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOfNUrJTZvqLC5gRSBiipLO0lLr4rkuFBrdmO4tJIMdfDfdTFKGSRLcwZQIm1btCI
         l3vNpB3D0CLEU6VfaSySI97qpS3hFMrdS0/kZK3bOGgogyjjDW3R4C6mL/ngCjG6KS
         +9TYqwT+FEVH/b9gLRi5hfHw0Tt+9S3o7FfWna8A=
Received: by earth.universe (Postfix, from userid 1000)
        id 7975F3C08C6; Wed, 10 Jun 2020 01:29:12 +0200 (CEST)
Date:   Wed, 10 Jun 2020 01:29:12 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: Add new power supply prop for date of
 manufacture
Message-ID: <20200609232912.oexmmr53feglqdg7@earth.universe>
References: <20200609192237.32571-1-twawrzynczak@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ciom6auqowqlhjxy"
Content-Disposition: inline
In-Reply-To: <20200609192237.32571-1-twawrzynczak@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ciom6auqowqlhjxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Support for SBS battery manufacturer date is part of power-supply's
pull request for v5.8 with a different API allowing other batteries
to expose less precise information:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
commit/?h=3Dfor-next&id=3Dfeabe49e46bb556b8d43e28d4a0d459940f7a5cb
https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
commit/?h=3Dfor-next&id=3D7721c2fd2668c751f9ba33b35db08b86293869e5

-- Sebastian

On Tue, Jun 09, 2020 at 01:22:36PM -0600, Tim Wawrzynczak wrote:
> The Smart Battery Specification v1.1 defines Manufacture Date as one of
> its availabe registers. This patch adds this as a property so that
> power_supply drivers can support the property and report it in syfs.
>=20
> Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
> Change-Id: I90bf8c67b0cd531f2155404424a98302a1c931d6
> ---
>  drivers/power/supply/power_supply_sysfs.c | 3 ++-
>  include/linux/power_supply.h              | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index f37ad4eae60b9..ac6d9992a8675 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -171,7 +171,7 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  		ret =3D sprintf(buf, "%s\n",
>  			      power_supply_scope_text[value.intval]);
>  		break;
> -	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_MANUFACTURE_DAT=
E:
>  		ret =3D sprintf(buf, "%s\n", value.strval);
>  		break;
>  	default:
> @@ -310,6 +310,7 @@ static struct device_attribute power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(model_name),
>  	POWER_SUPPLY_ATTR(manufacturer),
>  	POWER_SUPPLY_ATTR(serial_number),
> +	POWER_SUPPLY_ATTR(manufacture_date),
>  };
> =20
>  static struct attribute *
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 28413f737e7d0..67839bb0a46b6 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -162,6 +162,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +	POWER_SUPPLY_PROP_MANUFACTURE_DATE,
>  };
> =20
>  enum power_supply_type {
> --=20
> 2.26.2
>=20

--ciom6auqowqlhjxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7gG0EACgkQ2O7X88g7
+ppQ4g//dQB8TDo07iqPKqWYIBEtudBFSEGIfdNJ8qceSbxjZqBzA2TeQFnlCf+o
UUFCZzvnX3txGmL+TnPC8n9jshPoRegaqKl/3B8Bp/Aw0HAGXuLHb1uNSdS4M6hS
HXegBG34ToRo7WRKg6lJSpn24PATTxM9vElfDjTey4CJMaO6QiQvvwHyS7tfLHv8
IAPOGL+yKZ1ya1yfaEZxQTc1AVuo5rZMWpbOMSfpNWRY+nse6aeRLDRqP10cEtMb
r5TcxVwHn84T9uewkhfyrgxHQrGe1B0u4s/Ia7quFauZTM08AUvdVYMbMJI/WZaD
nRdzCLK8CQ6GjjKX7OP8/x6XZTr+ScBj8yniNVk0/0Y6WCXnFXCgS3enux1jX+DP
bKgonJ3iIyV4Y5c8MPtgq8exeKnOOpDdennqFzACp1j/MPvGMkkpeoNHbul3VkpU
ibFX1hRshlqLKBIxckmLw6LM2aXJ7o0VbBKTmycBxCMBueffL/XqfDJ0J/PR/DS1
EMYXj/DTXWPmlaaAhtrIl4rXXXBDj0Rri99N3lkGTtedFALCafTIq/NJlc0XxkNm
9ysZp2izumrGFHapeSZGZudb1izlm38GKZ6OEdBvpRp+ojwycTlaIijjaGEpzvg6
jSS/gn0Za62l2cU0iByXeX8w2PMvwHvDD/krEtFAsHW51yaIM+Y=
=1Muu
-----END PGP SIGNATURE-----

--ciom6auqowqlhjxy--
