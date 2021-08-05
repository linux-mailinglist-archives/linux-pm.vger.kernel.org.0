Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF23E19B5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhHEQha (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhHEQha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 12:37:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C36C061765;
        Thu,  5 Aug 2021 09:37:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CC7041F442B8
Received: by earth.universe (Postfix, from userid 1000)
        id C368C3C0C9B; Thu,  5 Aug 2021 18:37:11 +0200 (CEST)
Date:   Thu, 5 Aug 2021 18:37:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ting Wang <zxc52fgh@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, wangting11 <wangting11@xiaomi.com>
Subject: Re: [PATCH v11 4/4] power: supply: core: property to control reverse
 charge
Message-ID: <20210805163711.nvmjedsiuf6soips@earth.universe>
References: <cover.1627992564.git.wangting11@xiaomi.com>
 <0d72b2e799ec764b851f3efecffbcc20f9b2c55c.1627992564.git.wangting11@xiaomi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kiivi6ddmteezb57"
Content-Disposition: inline
In-Reply-To: <0d72b2e799ec764b851f3efecffbcc20f9b2c55c.1627992564.git.wangting11@xiaomi.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kiivi6ddmteezb57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 04, 2021 at 07:02:01PM +0800, Ting Wang wrote:
> From: wangting11 <wangting11@xiaomi.com>
>=20
> Interface to control wireless reverse charge.
>=20
> Signed-off-by: wangting11 <wangting11@xiaomi.com>
> ---

In mainline Linux this is handled by registering a regulator, see
e.g. "otg-vbus" regulator in the Qualcomm driver.

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 14 ++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 16 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 4a6b4970cb7d..59518568d594 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -807,3 +807,17 @@ Description:
> =20
>  		Access: Read-Only
>  		Valid values: 0 - 100
> +
> +What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +Description:
> +		Some devices support wireless reverse charge function which
> +		charge other devices.The property provider interface to
> +		enable/disable wireless reverse charge.If enabled, start TX
> +		mode and detect RX. Disabled when timeout or manual setting.
> +
> +		Access: Read, Write
> +		Valid values:
> +		- 1: enabled
> +		- 0: disabled
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 4de91dce2001..934563eed155 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -214,6 +214,7 @@ static struct power_supply_attr power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
>  	POWER_SUPPLY_ATTR(TX_ADAPTER),
>  	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
> +	POWER_SUPPLY_ATTR(REVERSE_CHG_MODE),
>  };
> =20
>  static struct attribute *
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 0dfec19cb473..3fe3f9665389 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -174,6 +174,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
>  	POWER_SUPPLY_PROP_TX_ADAPTER,
>  	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
> +	POWER_SUPPLY_PROP_REVERSE_CHG_MODE,
>  };
> =20
>  enum power_supply_type {
> --=20
> 2.17.1
>=20

--kiivi6ddmteezb57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEME7cACgkQ2O7X88g7
+pp0wQ//S5p1M36nkO3a7eBQ6C2jIHhWHrrDnDwTN0682x0+EuzAT/VCR72gS54Y
2/ya8hFqLfjAVvwzfr5oONQzzMO1QBoI2gwuY9tr47JS5SxNkez12oK0PLKQS7hg
oN+1mhdDfChpz/ymyGCslDMm0TesFyNcYgdYjLmWS/Kzte2qI3QBASyGZz1kQsqJ
2aIuCDRD3q9eG4wWynjYlwZbxKIRvEfvqqBL2177RCnFuu3XlEM8dtNYC+8raxTk
Ik/1d7ArjKlPFb2Dlrrz5KXw7bOHQPR9yGBiz8xawTl1xkGE4qiGKTiGJgRpH5Sw
6RA8M/sn/Ucx1+mjvdi4dROj8m2sDEGdgp0/VwfWGBFDlBr5e5/49RWTf+np5KYd
f2EBMbpNeWdVJJpr/C48GmH2+l+7kuMbHS5HnZCKpy3t3aPjVR3DxTvr46Hlz3vC
bg3k8tCIcPNrSNYy81Z6WkJoj1MNF8dYWWh6/aOzkf6LgaCogHfVizqqO+bOleww
5loeiA5OhQ1rF4u0ZO3dpraI3kr45beFvJ4xPpixgTFXqikuURKLQUKIikmZRiBJ
fZHQ1/ASBSfV719Ntvlx1EsmOVYhcYGlrHy70m9fhXe2Pj/OcttbITqCTjcRPUR+
TZgf4TyZsWXoCaP3RIL/tRsP+RAgQRapkBijA5QdmSopODenPZQ=
=Anyi
-----END PGP SIGNATURE-----

--kiivi6ddmteezb57--
