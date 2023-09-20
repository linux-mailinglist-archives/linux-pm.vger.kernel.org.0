Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832E27A8DCC
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 22:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjITUbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 16:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITUbP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 16:31:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19C6A1
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 13:31:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1364BC433C7;
        Wed, 20 Sep 2023 20:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695241869;
        bh=aomLEjvqVoS7S2dd5cXZDRCXyImfDH90pVE/YnMMx74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FvlgRkxGnqsj3K/XrKdjpkzvsS+ne9YlnxBo6Zc3Ew6HMIpvmjGl9f7wnrLX6VhB/
         L4wQPXHNXW13qnLdXOfjeoXdzJWctpjE9ShAxYC73jbOKFaeXjH2tQKK4vGeluaq3P
         Myc/2cMDd9m+hfRWQIPjyViJa/EiaXNsmP3E6xxTx+f1vZRWgR1VYHFV3E59hkJpUY
         dwgitKwGfiv3Y0VNf5lZJeJALNigVFsHGzOplhSEL/mAumprJu+3MTuYQe9eJr2fn5
         fw3rN6Ph+uxGAdGycn0ynlHzh6Y42xLIb386aEWq73vo/way4NapEPQG15szVuuVjG
         J3AV2FX6YMakw==
Received: by mercury (Postfix, from userid 1000)
        id 51C44106091E; Wed, 20 Sep 2023 22:31:06 +0200 (CEST)
Date:   Wed, 20 Sep 2023 22:31:06 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linqiheng@huawei.com,
        Chris Morgan <macromorgan@hotmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2] power: supply: Fix additional refcount leak in
 rk817_charger_probe
Message-ID: <20230920203106.rbghsn24fsey73ma@mercury.elektranox.org>
References: <20230920145644.57964-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5gl7esxxu3fnay5"
Content-Disposition: inline
In-Reply-To: <20230920145644.57964-1-macroalpha82@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--l5gl7esxxu3fnay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

As you saw I applied this, but I did some modifications:

On Wed, Sep 20, 2023 at 09:56:44AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Dan Carpenter reports that the Smatch static checker warning has found
> that there is another refcount leak in the probe function. While
> of_node_put() was added in one of the return paths, it should in
> fact be added for ALL return paths that return an error.
>=20
> Changes Since V1:
>  - Use devm_add_action_or_reset() to call of_node_put() instead of
>    calling it in every single error path from the probe() function.

^ this should be below the ---

>=20
> Fixes: 54c03bfd094f ("power: supply: Fix refcount leak in rk817_charger_p=
robe")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Closes: https://lore.kernel.org/linux-pm/dc0bb0f8-212d-4be7-be69-becd2a3f=
9a80@kili.mountain/
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/power/supply/rk817_charger.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index 8328bcea1a29..708689d34959 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -1045,6 +1045,13 @@ static void rk817_charging_monitor(struct work_str=
uct *work)
>  	queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(8000));
>  }
> =20
> +static void rk817_cleanup_node(void *data)
> +{
> +	struct device_node *node =3D data;
> +
> +	of_node_put(node);
> +}
> +
>  static int rk817_charger_probe(struct platform_device *pdev)
>  {
>  	struct rk808 *rk808 =3D dev_get_drvdata(pdev->dev.parent);
> @@ -1061,12 +1068,16 @@ static int rk817_charger_probe(struct platform_de=
vice *pdev)
>  	if (!node)
>  		return -ENODEV;
> =20
> -	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> -	if (!charger) {
> +	ret =3D devm_add_action_or_reset(&pdev->dev, rk817_cleanup_node, node);
> +	if (ret) {
>  		of_node_put(node);

devm_add_action_or_reset() calls the action on failure (that's the
'_or_reset' part). So this of_node_put() is wrong.

Thanks,

-- Sebastian

> -		return -ENOMEM;
> +		return ret;
>  	}
> =20
> +	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
>  	charger->rk808 =3D rk808;
> =20
>  	charger->dev =3D &pdev->dev;
> --=20
> 2.34.1
>=20

--l5gl7esxxu3fnay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmULVnwACgkQ2O7X88g7
+prIKQ/6AlcV7xRSsW9od/4udRRAmRyLQv5AaOck/5LJvSVVDQUmUSNCVpgozYlz
7P+1oRMPHaMiG1lRlbZLsJDmOxuarIVJUpnJdpe11FMmlfXTJEuG421UEyLrgFEV
6CZr5TGhC3mXZtXcI8BtNIso5v0IewBRAEGujZ9lW6PPR0q/z5Z10iwrG3q5BQRR
SJIg85LM2tmPkOohbpnGwl78LRBIksKzLQVHyVXROVv8mzLrsE5wQ4KGMqtxgLXh
I5pNB9Xa61zizAwX28w8nHBGef4s1+Z08MBeCVKoUCEJyMGhE+v2u4wg66QH1dgm
YyKCLuwo2CUTKyVZ1OzUeTgxxBjpK0eGo+7wKBII6I6d7zhByHoFgu17K8Zg7GIR
OKwFFwIRbTQny85fCKBwFRw/g26sSGDZco/nvZC/zza5vjDnyP08X6LyyfaPleYe
7/bx7UvrmTj2QsxVXzLeyy6dvMYZIB5yEMnHTQYcRXowclbT5QTMKJdtbLcpLA83
I8eRYLi9OkpOCFb63HdcWR84tGaY9uNJu96pWQ2iYwYMfm97DwKxywdCkXnPIJM+
V8WqdzjBqMebjk+2+WzCqQFOkiBZq6gCV3fyq1hC7Uik6XDVsV9edekYzNycde+R
Y3uErHGxL9Q8oqx/msCK8JbQgx/uzUQu440E4WUAC9b0i1Y6Ud4=
=6/31
-----END PGP SIGNATURE-----

--l5gl7esxxu3fnay5--
