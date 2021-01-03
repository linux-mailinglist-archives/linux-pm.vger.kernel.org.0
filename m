Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED02E89ED
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jan 2021 02:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhACBy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Jan 2021 20:54:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48456 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbhACBy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2021 20:54:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E4D231F410AD
Received: by earth.universe (Postfix, from userid 1000)
        id DC47C3C0C94; Sun,  3 Jan 2021 02:53:41 +0100 (CET)
Date:   Sun, 3 Jan 2021 02:53:41 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 3/8] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20210103015341.atzgzdk4orcp2nrx@earth.universe>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-3-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hgoeyxu2tkjevfuo"
Content-Disposition: inline
In-Reply-To: <20201230205139.1812366-3-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hgoeyxu2tkjevfuo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 30, 2020 at 08:52:15PM +0000, Timon Baetz wrote:
> Register for extcon notification and set charging current depending on
> the detected cable type. Current values are taken from vendor kernel,
> where most charger types end up setting 650mA [0].
>=20
> Also enable and disable the CHARGER regulator based on extcon events.
>=20
> [0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-ep=
ic-4g-touch-sph-d710-exynos4210-dump/drivers/misc/max8997-muic.c#L1675-L1678
>=20
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

> v6: dev_info() instead of dev_err().
> v5: Use devm_regulator_get_optional(), dev_err() on failure.
>     dev_err() on extcon_get_edev_by_phandle() failure.
> v4: Make extcon and charger-supply optional.
> v3: Split MFD change.
>     return on regulator_set_current_limit() failure.
> v2: Split DTS changes.
>     Add missing include.
>     Rename charger_data members.
>     Disable regulator on regulator_set_current_limit() failure.
>     Fix ret declaration.
>     Remove unneeded variables.
>     Don't dev_err() on deferral.
>     Get regulator and extcon from DTS.
>     Use devm_regulator_get().=20
>     Fix indentation.
>=20
>  drivers/power/supply/max8997_charger.c | 96 ++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>=20
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/suppl=
y/max8997_charger.c
> index 1947af25879a..23df91ed2c72 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -6,12 +6,14 @@
>  //  MyungJoo Ham <myungjoo.ham@samsung.com>
> =20
>  #include <linux/err.h>
> +#include <linux/extcon.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
> +#include <linux/regulator/consumer.h>
> =20
>  /* MAX8997_REG_STATUS4 */
>  #define DCINOK_SHIFT		1
> @@ -31,6 +33,10 @@ struct charger_data {
>  	struct device *dev;
>  	struct max8997_dev *iodev;
>  	struct power_supply *battery;
> +	struct regulator *reg;
> +	struct extcon_dev *edev;
> +	struct notifier_block extcon_nb;
> +	struct work_struct extcon_work;
>  };
> =20
>  static enum power_supply_property max8997_battery_props[] =3D {
> @@ -88,6 +94,67 @@ static int max8997_battery_get_property(struct power_s=
upply *psy,
>  	return 0;
>  }
> =20
> +static void max8997_battery_extcon_evt_stop_work(void *data)
> +{
> +	struct charger_data *charger =3D data;
> +
> +	cancel_work_sync(&charger->extcon_work);
> +}
> +
> +static void max8997_battery_extcon_evt_worker(struct work_struct *work)
> +{
> +	struct charger_data *charger =3D
> +	    container_of(work, struct charger_data, extcon_work);
> +	struct extcon_dev *edev =3D charger->edev;
> +	int current_limit;
> +
> +	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
> +		dev_dbg(charger->dev, "USB SDP charger is connected\n");
> +		current_limit =3D 450000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
> +		dev_dbg(charger->dev, "USB DCP charger is connected\n");
> +		current_limit =3D 650000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
> +		dev_dbg(charger->dev, "USB FAST charger is connected\n");
> +		current_limit =3D 650000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
> +		dev_dbg(charger->dev, "USB SLOW charger is connected\n");
> +		current_limit =3D 650000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
> +		dev_dbg(charger->dev, "USB CDP charger is connected\n");
> +		current_limit =3D 650000;
> +	} else {
> +		dev_dbg(charger->dev, "USB charger is diconnected\n");
> +		current_limit =3D -1;
> +	}
> +
> +	if (current_limit > 0) {
> +		int ret =3D regulator_set_current_limit(charger->reg, current_limit, c=
urrent_limit);
> +
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set current limit: %d\n", ret);
> +			return;
> +		}
> +		ret =3D regulator_enable(charger->reg);
> +		if (ret)
> +			dev_err(charger->dev, "failed to enable regulator: %d\n", ret);
> +	} else {
> +		int ret  =3D regulator_disable(charger->reg);
> +
> +		if (ret)
> +			dev_err(charger->dev, "failed to disable regulator: %d\n", ret);
> +	}
> +}
> +
> +static int max8997_battery_extcon_evt(struct notifier_block *nb,
> +				unsigned long event, void *param)
> +{
> +	struct charger_data *charger =3D
> +		container_of(nb, struct charger_data, extcon_nb);
> +	schedule_work(&charger->extcon_work);
> +	return NOTIFY_OK;
> +}
> +
>  static const struct power_supply_desc max8997_battery_desc =3D {
>  	.name		=3D "max8997_pmic",
>  	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
> @@ -170,6 +237,35 @@ static int max8997_battery_probe(struct platform_dev=
ice *pdev)
>  		return PTR_ERR(charger->battery);
>  	}
> =20
> +	charger->reg =3D devm_regulator_get_optional(&pdev->dev, "charger");
> +	if (IS_ERR(charger->reg)) {
> +		if (PTR_ERR(charger->reg) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(&pdev->dev, "couldn't get charger regulator\n");
> +	}
> +	charger->edev =3D extcon_get_edev_by_phandle(&pdev->dev, 0);
> +	if (IS_ERR(charger->edev)) {
> +		if (PTR_ERR(charger->edev) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(charger->dev, "couldn't get extcon device\n");
> +	}
> +
> +	if (!IS_ERR(charger->reg) && !IS_ERR(charger->edev)) {
> +		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
> +		ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_wo=
rk, charger);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to add extcon evt stop action: %d\n", ret=
);
> +			return ret;
> +		}
> +		charger->extcon_nb.notifier_call =3D max8997_battery_extcon_evt;
> +		ret =3D devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
> +							&charger->extcon_nb);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to register extcon notifier\n");
> +			return ret;
> +		};
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.25.1
>=20
>=20

--hgoeyxu2tkjevfuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/xI5wACgkQ2O7X88g7
+pqLHhAAobZV0Wjf5ejo2tYNf+W2Qlmvls8NMsmSk7/X2kmiAN7FbHbWVq0SGeGX
IX6ja3niIS1NTPlR8DpOYPVGIY7Z8KHvFKSXX8JkEqj9e9lXM1DnfQ1Od0tGiwpl
9B5xSRk4kAUK9l/+GGxiP1jCHhSK+x/uboNrwMmcJV5mUAXoGtM7OxXQ2jnnUoEE
Ya0G5+bJ/XM7OZkHApVmBcuHZa0g8ih3SVPbSi7petnt2aLDWypDBwAWvrxuTq4Q
jSATQ1G7qMlrWNk6ybJzktBGvolnM+hnTLTFFHMYo7USP8aH5E/bVBDrnxvD0bpk
c+l2W2OjUhQxHIg7p8zbibexOndDZmGEgky7buHs/o5y8gAPR8C3req5uJYw4cIs
/CjceYG5RXzaGNgjHR9/5mWGPasz/gq7F4qDeVtOT9/rkHHfRjOOquyhrkizhamh
S6ZxRhLN1tSUCyt38CZLfClUac8gt/8Y3ahrIEEmU8WfSS/XJCiT/uoemnYZCedy
ioA9Z8DqxXioFKRXYp+7EuPDFqzSU0pCa/0KBGG+A5BLvlf+VCRLVtA6u58US2ul
n1qRxlcyam3p6Kf6xIR+pkD7fDYGfN3R7wupjAIbOrpApoGfQV1ONdYZdjB0VyNI
A9FXjBuC52XV8N4Vwk6rYbb6n7KAI6inYpBXbMmp4h35b5dIehg=
=Qfsr
-----END PGP SIGNATURE-----

--hgoeyxu2tkjevfuo--
