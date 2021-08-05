Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E573E19C8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhHEQqH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 12:46:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60890 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHEQqG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 12:46:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 12AC11F4015F
Received: by earth.universe (Postfix, from userid 1000)
        id 1EA8F3C0C9B; Thu,  5 Aug 2021 18:45:46 +0200 (CEST)
Date:   Thu, 5 Aug 2021 18:45:46 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ting Wang <zxc52fgh@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, wangting11 <wangting11@xiaomi.com>
Subject: Re: [PATCH v11 3/4] power: supply: core: add wireless signal
 strength property
Message-ID: <20210805164546.i4psvxng6h6fscow@earth.universe>
References: <cover.1627992564.git.wangting11@xiaomi.com>
 <8599adb4d1c966c8d0cd6e25137a660546c1115c.1627992564.git.wangting11@xiaomi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yqzemd5iw44vgp46"
Content-Disposition: inline
In-Reply-To: <8599adb4d1c966c8d0cd6e25137a660546c1115c.1627992564.git.wangting11@xiaomi.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yqzemd5iw44vgp46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 04, 2021 at 07:02:00PM +0800, Ting Wang wrote:
> From: wangting11 <wangting11@xiaomi.com>
>=20
> reports wireless signal strength.
> The value show degree of coupling between tx and rx.
>=20
> Signed-off-by: wangting11 <wangting11@xiaomi.com>
> ---

You also need a user for this property.

>  Documentation/ABI/testing/sysfs-class-power | 22 +++++++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 24 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 36808bf8731b..4a6b4970cb7d 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -785,3 +785,25 @@ Description:
>  			13: ADAPTER_VOICE_BOX,
>  			14: ADAPTER_PRIVATE_PD_50W.
> =20
> +What:		/sys/class/power_supply/<supply_name>/signal_strength
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		In PING phase, RX transmits a signal strength packet as the
> +		first communication packet to instruct the base to keep power
> +		signal on.The value reports wireless signal strength and show
> +		degree of coupling.
> +
> +		The Qi Wireless Power Transfer System is published by the
> +		Wireless Power Consortium.The ping phase is the necessary stage
> +		for matching transmitter and receiver. In this phase,the Power
> +		Transmitter executes a Digital Ping, and listens for a response.
> +		If the Power Transmitter discovers a Power Receiver, the Power
> +		Transmitter may extend the Digital Ping,i.e. maintain the Power
> +		Signal at the level of the Digital Ping. This causes the system
> +		to proceed to the identification & configuration phase. If the
> +		Power Transmitter does not extend the Digital Ping, the system
> +		shall revert to the selection phase.

A lot of text, but not much information what 'signal_strength' reports.
IIUIC it could be rephrased like this simple sentence?

Reports the degree coupling between wireless RX and TX side of a
wireless charger in %.

-- Sebastian

> +		Access: Read-Only
> +		Valid values: 0 - 100
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 561cffef9d61..4de91dce2001 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -213,6 +213,7 @@ static struct power_supply_attr power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
>  	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
>  	POWER_SUPPLY_ATTR(TX_ADAPTER),
> +	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
>  };
> =20
>  static struct attribute *
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index bcfadf2a995f..0dfec19cb473 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -173,6 +173,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_SERIAL_NUMBER,
>  	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
>  	POWER_SUPPLY_PROP_TX_ADAPTER,
> +	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
>  };
> =20
>  enum power_supply_type {
> --=20
> 2.17.1
>=20

--yqzemd5iw44vgp46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEMFbkACgkQ2O7X88g7
+pp91g/9E4Kx9jkSG0p9sdKDpD3+XWsWBxtSY4H9N3uEVCfolFH0ePFAJ3PkF5Re
1VHobmqrl7WvUgjlJmsnGGs4i4IN8e1KL/ERxGDA/PtOgBuKEXPDrBWBCus7boZ4
UihxBM93L9Ry837Gb54CPLa36yx79ZUh2KwNeMS2oZfINjK+C2hz53NP4i/iRgNh
JxH+QoeLCMFlzb0y6cz91YtV/2tVbEC+QtWQkWMn2IhEx3TRYkuS5yL6ixVTCylc
YfLXzHcPFRtWWib7jdWvGxtnt1wcvbeBxRpns7vf1aTiFdPXe4Ay1gsAWcsjYkAG
n3S5faNNiWzvjG77z1KdgmSX1uDkaGElqQWPwlhT13aVEAH0iNfpeVTFKCjv5Ing
pJ68t3YTdBo1GyLkrmqPfNN6DYxxnXgqr6hL8azzbxaV/TQzXCYDuqX3rIWjEsoI
JIs9XiDr7xQd1JbN8WGJRyOZIRQf1nobbqQrC5kpE6Rido1mjwt+Ucr15JWFk6lk
dnFMVzR6CNj/zn2+0Gggea6HRaD4Sx2/eAYli3bYFBzUDXWKdmLlzMLxUw9VEmPj
ktiy0w0eFKefhevIkS1Skv0F4R2jXOf7qSSvKy7ywOvi6KIUu5MQwJIM+bZvm8ST
S7Bo1Cj3/Ox6Tlwy85jBbeHWsMqbTdukvQHLKMz3pdTbQKAKzCE=
=jlp5
-----END PGP SIGNATURE-----

--yqzemd5iw44vgp46--
