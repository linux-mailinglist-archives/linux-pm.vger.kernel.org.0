Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954AA17C6A0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 20:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCFT5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 14:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFT5t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 14:57:49 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D3D206E6;
        Fri,  6 Mar 2020 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583524669;
        bh=S33Vg0QEtYOC7CV9qRfXg6zNcqxlYmRuwdXeUhLzRfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmMA0lACCwRodXNw6HFjQv27WIqlGL5r+W+bQiZhkcjQFEBxXOuwgZNo7CZVu6ma9
         4X74RmOkmtHeL2sVhd+k66QlmEaJnRXKdi33hRmbxlkggGcEodnV0EswSUBrWxT+K1
         Ut//KbFOgKz8n22qk5BxlnpN+1tDeMXPLgbav/hk=
Received: by earth.universe (Postfix, from userid 1000)
        id 7154B3C0C83; Fri,  6 Mar 2020 20:57:45 +0100 (CET)
Date:   Fri, 6 Mar 2020 20:57:45 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] power: reset: syscon-reboot-mode: Add regmap
 dts-property support
Message-ID: <20200306195745.tnpybwqtpkqqyc4n@earth.universe>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130407.136888030701@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="en7xqwo5ij4oph2d"
Content-Disposition: inline
In-Reply-To: <20200306130407.136888030701@mail.baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--en7xqwo5ij4oph2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 06, 2020 at 04:03:41PM +0300, Sergey.Semin@baikalelectronics.ru=
 wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> 'Reboot-mode'-type of devices are supposed to work in conjunction with
> 'reboot'-type devices. In particular Baikal-T1 SoC provides a special
> CCU_WDT_RCR register, which is preserved during any type of the CPU
> reset (standard and caused by a watchdog one). Since both of them are
> responsible for the system-wide operation and related with each other
> it would be better to place them at the same place in the dt hierarchy.
> In particular the best location would be the dt root node. Currently
> 'syscon-reboot' device node can be placed anywhere in a dtb as long as
> the corresponding device is created at the system boot-up procedure.
> While according to the corresponding bindings file 'system-boot-mode'
> should be represented as a sub-node of a "syscon", "simple-mfd" node.
> This isn't always suitable especially when the reboot-preserved
> register is provided by some device, which we don't want to declared
> as MFD. In this case it would be good to have the 'syscon-reboot-mode'
> node accepting the 'regmap' property with a phandle reference to the
> 'syscon' dt-node, in the same way the 'syscon-reboot' driver does.
> This is what this patch provides - it makes the driver to handle the
> optional 'regmap' property. In case if one isn't provided the
> previously implemented scheme is expected to be found in dtb.
>=20
> Moreover seeing current dt-interface implementation of the
> 'syscon-reboot', 'syscon-poweroff' and 'syscon-reboot-mode' drivers,
> they look more or less similar. All of them handle 'offset' and
> 'mask' dt-properties. While 'value' property is only acceptable
> by the 'syscon-reboot' and 'syscon-poweroff' driver, the 'mode-*'
> properties of 'syscon-reboot-mode' serve to the similar purpose.
> The only strong difference between them is the ability to get the
> syscon regmap from the 'regmap' property. By having this patch merged
> we'll have that difference eliminated, so the interfaces would look
> unified.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/syscon-reboot-mode.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/res=
et/syscon-reboot-mode.c
> index e0772c9f70f7..f8f8218ae3ee 100644
> --- a/drivers/power/reset/syscon-reboot-mode.c
> +++ b/drivers/power/reset/syscon-reboot-mode.c
> @@ -40,6 +40,7 @@ static int syscon_reboot_mode_probe(struct platform_dev=
ice *pdev)
>  {
>  	int ret;
>  	struct syscon_reboot_mode *syscon_rbm;
> +	struct regmap *map;
> =20
>  	syscon_rbm =3D devm_kzalloc(&pdev->dev, sizeof(*syscon_rbm), GFP_KERNEL=
);
>  	if (!syscon_rbm)
> @@ -49,9 +50,13 @@ static int syscon_reboot_mode_probe(struct platform_de=
vice *pdev)
>  	syscon_rbm->reboot.write =3D syscon_reboot_mode_write;
>  	syscon_rbm->mask =3D 0xffffffff;
> =20
> -	syscon_rbm->map =3D syscon_node_to_regmap(pdev->dev.parent->of_node);
> -	if (IS_ERR(syscon_rbm->map))
> -		return PTR_ERR(syscon_rbm->map);
> +	map =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
> +	if (IS_ERR(map)) {
> +		map =3D syscon_node_to_regmap(pdev->dev.parent->of_node);
> +		if (IS_ERR(map))
> +			return PTR_ERR(map);
> +	}
> +	syscon_rbm->map =3D map;
> =20
>  	if (of_property_read_u32(pdev->dev.of_node, "offset",
>  	    &syscon_rbm->offset))
> --=20
> 2.25.1
>=20

--en7xqwo5ij4oph2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5iqzkACgkQ2O7X88g7
+pq0/w/+NAZy5WKjjVMy05rZVBnfZ+hVoAWapV8e4p+FsyStoGeC2WTe/m7pCe6t
orMK0b8dI613b2K0RmisZzyB6+az657WhUJPMRnKPKwYNBIbyC5mA4zJ54qdapMa
NU5W0S9UfQ6SHhSL/C13k0DhN3EzD/F7l6SI48i5CnKf3TLaQJZ9Ckl3TDtf6Mg9
EhrZZ70WQww31KOJECCuOD0d6FcZdz9ZgkxG2I36TuXNEXYDTqwL9dWb9Zyt9o4R
RjLWdj3+l8R/BUmzmzyMzMcVQl+85Sbr48+2ifKmSxxBL2fxcB5bJVDJ9yyMiLyC
0bkJiQwyYvo/Vsbcdzqp2reZLqNUu/onmpONwJ23QC2qRYvsXGic7doKn5XntcTK
glcYnml7itWAr8aOYSfA+Y8Dp+ZDkrwMOLdRIF8mO2dKrVKEbBT4dAi3Kb8ZsfCY
PIzPOFyKa5PpJPTacGG7QetD0z0UpLeaUXeHoM4JB1FtVJYxJ5c2IijgLvRIudG2
DsuVm8hbUGKrXgTx2e2jJbVIWw+BOByS4zvxHmBFZA+Ku47wjAxoNqQOrBXieCJ6
A1xRqidkmD9ilImjgXSsVXOs9OedqUi4lI4c7kSY1fONf8HclvPoZq5ErL09RQsz
+yFsP2DsWUo53xUeYr3sXktcAlz7/ghrBv+lWaUc9txEHjo6Nvc=
=/Stg
-----END PGP SIGNATURE-----

--en7xqwo5ij4oph2d--
