Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F67A2A41
	for <lists+linux-pm@lfdr.de>; Sat, 16 Sep 2023 00:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjIOWNE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjIOWMr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 18:12:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADF31FDE
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 15:12:40 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BEEDB66072BE;
        Fri, 15 Sep 2023 23:12:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694815958;
        bh=7+YUopNvephDvcm26CDJT1sI52MuUqcLhOLapSZJeH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLFmWWxxo4yj6gNDj4NdqFLkSRjASlGAHIRcF0ypcwM2+86mbe4xTrbK4/asbzy/c
         os5aweD6PxtknKHjL3wDdVMCw4fmpOao/ZXZ1FS6TZGOjug06C2m9iDp0iP8S0vwfo
         Nic3ubcjQG1FNsH5J7QlBzTerGn7VJ9R5o4yYW55MNAh/GzHHMbpHE/FxrzkICjfUB
         XPjPV9FTuAB4aFtz/GbzwCNggAGfb/Z5jzrFZt66S6CmCKwd5dirgq9WZe6iLcvNAz
         /jhKcDZdusjNjs18beh+Yh7v/YW+0NADS0myIsF6M61u+Q0q0FvvmLi8xb8IlUWZQr
         ATt36qXpwe3LA==
Received: by mercury (Postfix, from userid 1000)
        id 537B510603FB; Sat, 16 Sep 2023 00:12:36 +0200 (CEST)
Date:   Sat, 16 Sep 2023 00:12:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linqiheng@huawei.com,
        macromorgan@hotmail.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] power: supply: Fix additional refcount leak in
 rk817_charger_probe
Message-ID: <20230915221236.l2xaxkqofkqrfnuy@mercury.elektranox.org>
References: <20230518153230.1584962-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6l6kzw7qg5gcrrd"
Content-Disposition: inline
In-Reply-To: <20230518153230.1584962-1-macroalpha82@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--z6l6kzw7qg5gcrrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 18, 2023 at 10:32:30AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Dan Carpenter reports that the Smatch static checker warning has found
> that there is another refcount leak in the probe function. While
> of_node_put() was added in one of the return paths, it should in
> fact be added for ALL return paths that return an error.
>=20
> Fixes: 54c03bfd094f ("power: supply: Fix refcount leak in rk817_charger_p=
robe")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Closes: https://lore.kernel.org/linux-pm/dc0bb0f8-212d-4be7-be69-becd2a3f=
9a80@kili.mountain/
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---

This kind of fell through the cracks, sorry. Looking at it now it's
incomplete: Even after this patch there is still a leak on module
removal. You should use devm_add_action_or_reset() to register a
handler doing of_node_put(). That also results in a much smaller
diff :)

Greetings,

-- Sebastian

>  drivers/power/supply/rk817_charger.c | 76 ++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index 1a2143641e66..bd4f530910a5 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -1063,8 +1063,8 @@ static int rk817_charger_probe(struct platform_devi=
ce *pdev)
> =20
>  	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
>  	if (!charger) {
> -		of_node_put(node);
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto out_node_put;
>  	}
> =20
>  	charger->rk808 =3D rk808;
> @@ -1085,8 +1085,9 @@ static int rk817_charger_probe(struct platform_devi=
ce *pdev)
>  	ret =3D of_property_read_u32(node, "rockchip,resistor-sense-micro-ohms",
>  				   &of_value);
>  	if (ret < 0) {
> -		return dev_err_probe(dev, ret,
> -				     "Error reading sample resistor value\n");
> +		dev_err_probe(dev, ret,
> +			      "Error reading sample resistor value\n");
> +		goto out_node_put;
>  	}
>  	/*
>  	 * Store as a 1 or a 2, since all we really use the value for is as a
> @@ -1102,8 +1103,9 @@ static int rk817_charger_probe(struct platform_devi=
ce *pdev)
>  				   "rockchip,sleep-enter-current-microamp",
>  				   &of_value);
>  	if (ret < 0) {
> -		return dev_err_probe(dev, ret,
> -				     "Error reading sleep enter cur value\n");
> +		dev_err_probe(dev, ret,
> +			      "Error reading sleep enter cur value\n");
> +		goto out_node_put;
>  	}
>  	charger->sleep_enter_current_ua =3D of_value;
> =20
> @@ -1112,29 +1114,35 @@ static int rk817_charger_probe(struct platform_de=
vice *pdev)
>  				   "rockchip,sleep-filter-current-microamp",
>  				   &of_value);
>  	if (ret < 0) {
> -		return dev_err_probe(dev, ret,
> -				     "Error reading sleep filter cur value\n");
> +		dev_err_probe(dev, ret,
> +			      "Error reading sleep filter cur value\n");
> +		goto out_node_put;
>  	}
> =20
>  	charger->sleep_filter_current_ua =3D of_value;
> =20
>  	charger->bat_ps =3D devm_power_supply_register(&pdev->dev,
>  						     &rk817_bat_desc, &pscfg);
> -	if (IS_ERR(charger->bat_ps))
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Battery failed to probe\n");
> +	if (IS_ERR(charger->bat_ps)) {
> +		dev_err_probe(dev, -EINVAL,
> +			      "Battery failed to probe\n");
> +		goto out_node_put;
> +	}
> =20
>  	charger->chg_ps =3D devm_power_supply_register(&pdev->dev,
>  						     &rk817_chg_desc, &pscfg);
> -	if (IS_ERR(charger->chg_ps))
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Charger failed to probe\n");
> +	if (IS_ERR(charger->chg_ps)) {
> +		dev_err_probe(dev, -EINVAL,
> +			      "Charger failed to probe\n");
> +		goto out_node_put;
> +	}
> =20
>  	ret =3D power_supply_get_battery_info(charger->bat_ps,
>  					    &bat_info);
>  	if (ret) {
> -		return dev_err_probe(dev, ret,
> -				     "Unable to get battery info: %d\n", ret);
> +		dev_err_probe(dev, ret,
> +			      "Unable to get battery info: %d\n", ret);
> +		goto out_node_put;
>  	}
> =20
>  	if ((bat_info->charge_full_design_uah <=3D 0) ||
> @@ -1143,8 +1151,10 @@ static int rk817_charger_probe(struct platform_dev=
ice *pdev)
>  	    (bat_info->constant_charge_voltage_max_uv <=3D 0) ||
>  	    (bat_info->constant_charge_current_max_ua <=3D 0) ||
>  	    (bat_info->charge_term_current_ua <=3D 0)) {
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Required bat info missing or invalid\n");
> +		ret =3D -EINVAL;
> +		dev_err_probe(dev, ret,
> +			      "Required bat info missing or invalid\n");
> +		goto out_node_put;
>  	}
> =20
>  	charger->bat_charge_full_design_uah =3D bat_info->charge_full_design_ua=
h;
> @@ -1157,25 +1167,30 @@ static int rk817_charger_probe(struct platform_de=
vice *pdev)
>  	 */
>  	ret =3D rk817_battery_init(charger, bat_info);
>  	if (ret)
> -		return ret;
> +		goto out_node_put;
> =20
>  	power_supply_put_battery_info(charger->bat_ps, bat_info);
> =20
>  	plugin_irq =3D platform_get_irq(pdev, 0);
> -	if (plugin_irq < 0)
> -		return plugin_irq;
> +	if (plugin_irq < 0) {
> +		ret =3D plugin_irq;
> +		goto out_node_put;
> +	}
> =20
>  	plugout_irq =3D platform_get_irq(pdev, 1);
> -	if (plugout_irq < 0)
> -		return plugout_irq;
> +	if (plugout_irq < 0) {
> +		ret =3D plugout_irq;
> +		goto out_node_put;
> +	}
> =20
>  	ret =3D devm_request_threaded_irq(charger->dev, plugin_irq, NULL,
>  					rk817_plug_in_isr,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					"rk817_plug_in", charger);
>  	if (ret) {
> -		return dev_err_probe(&pdev->dev, ret,
> -				      "plug_in_irq request failed!\n");
> +		dev_err_probe(&pdev->dev, ret,
> +			      "plug_in_irq request failed!\n");
> +		goto out_node_put;
>  	}
> =20
>  	ret =3D devm_request_threaded_irq(charger->dev, plugout_irq, NULL,
> @@ -1183,19 +1198,24 @@ static int rk817_charger_probe(struct platform_de=
vice *pdev)
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					"rk817_plug_out", charger);
>  	if (ret) {
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "plug_out_irq request failed!\n");
> +		dev_err_probe(&pdev->dev, ret,
> +			      "plug_out_irq request failed!\n");
> +		goto out_node_put;
>  	}
> =20
>  	ret =3D devm_delayed_work_autocancel(&pdev->dev, &charger->work,
>  					   rk817_charging_monitor);
>  	if (ret)
> -		return ret;
> +		goto out_node_put;
> =20
>  	/* Force the first update immediately. */
>  	mod_delayed_work(system_wq, &charger->work, 0);
> =20
>  	return 0;
> +
> +out_node_put:
> +	of_node_put(node);
> +	return ret;
>  }
> =20
> =20
> --=20
> 2.34.1
>=20

--z6l6kzw7qg5gcrrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUE1skACgkQ2O7X88g7
+ppMTw/8CW6dUxenXeT54jGcpBlNTSF6vIYVW5ZfuWHIDlekaoBys8OevHXJnbZ0
oJxqijxavkN3i/huScQbjr/pQrglAa3zp0eJfAh6sdzbvIcv4u7LrTb1CXab/xNg
H24X9FRmWVR9QGYomLI6CUTVtucOTnEj6b8G4BAre8jvV9Xsw89uaenJIRIOniYB
0TfrRA2OxVbUvJbPKaTBpwkzcfZ5KxdlttnqCbApkfUffToUvszIKVzTc4Ck0zik
z607PrEAvUyhBqFsWXoeCVB8fYPy0plhVy0RFCb3FcJmDwfjcL70Wg+2tlvDd4BX
kAyyRgSsrimMOOY+G+dv97YyU7+Nl20B38gsr2bNC9rJQ3kPa+8MZn2KRqFm9B36
f8zxwSUOQ7NwmAao1PA+cq8m8R+CUql3rsZ2eoO1KgSq6rj33B/yu1aZWgME8L33
y9yxZpjrTMyn0o5FbCZN5NGZNx1HU37Jol5sKANvu6JXZZbqYl8q5zwOk3Z46XWo
M8J1SQC1fzrI+o9ZPczgjrcbueMSGZ0MhGbMQp2O0YqrzD8z0Ic6cOmwsy1wR1++
Oc7wqig6DJM90V6NG7L0it4kdnayHDYB+L4ac7XknsI9BngdrPQAwU+pADecWNiX
/r6jqQelZFM6IcVgRXt4hMFM365J2zpgv1ViwoqePEk7eJtNBLI=
=+Fq4
-----END PGP SIGNATURE-----

--z6l6kzw7qg5gcrrd--
