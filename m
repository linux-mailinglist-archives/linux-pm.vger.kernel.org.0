Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989A6A256D
	for <lists+linux-pm@lfdr.de>; Sat, 25 Feb 2023 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBYAUO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Feb 2023 19:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBYAUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Feb 2023 19:20:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29168689
        for <linux-pm@vger.kernel.org>; Fri, 24 Feb 2023 16:20:12 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4003E6602FC5;
        Sat, 25 Feb 2023 00:20:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677284411;
        bh=Giq2onhB4zrej2Z88BDTPjKJqPhSTMw1oGZV4cLaq0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6PAy5Xku62Qa8OBGRf+Xiie/KBXPym8LjAQDDKMIT8ddjbRNLl70ovjwt5fJ5Zl4
         GpcX16kgjsnkGjthHr/QjSfeeRD7MphGpIPXjW4UN+P9IPoX1irpVfY40Lz0aNYF/y
         riGjL6ZeGrrAeD0opeVv1IoiWwbq1flGyf2uOTlU9u5Gz5ywgS8DHKMGRNjNGQ0W6S
         ga99hFUvbVZrl/7OobK93EDe2Kijl9cSW4ubPFhB/YZlFnd+Oh0aSvXVnXIbgbMyNg
         yEmmuj83z2hrNk1rccch1+W78Vw8cmjDd6aJnwimVHF79kgnomF5GIo1FQ/zmidsFx
         hn0nm3+ynBUHg==
Received: by mercury (Postfix, from userid 1000)
        id 667A31060924; Sat, 25 Feb 2023 01:20:08 +0100 (CET)
Date:   Sat, 25 Feb 2023 01:20:08 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     qinyu <qinyu32@huawei.com>
Cc:     linux-pm@vger.kernel.org, hewenliang4@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] power: supply: fix null pointer check order in
 __power_supply_register
Message-ID: <20230225002008.kba4wviceuacdpin@mercury.elektranox.org>
References: <20230223081047.219326-1-qinyu32@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzzx3g4e3zzg74nx"
Content-Disposition: inline
In-Reply-To: <20230223081047.219326-1-qinyu32@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vzzx3g4e3zzg74nx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 23, 2023 at 04:10:47PM +0800, qinyu wrote:
> There is an null pointer check order issue here: if we have to
> check !desc and !desc->name anyway, check it before dereferencing it in
> pr_warn().
>=20
> Signed-off-by: qinyu <qinyu32@huawei.com>
> ---

Thanks, queued for v6.3.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index cc5b2e22b..f3d7c1da2 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1207,13 +1207,13 @@ __power_supply_register(struct device *parent,
>  	struct power_supply *psy;
>  	int rc;
> =20
> +	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (!parent)
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
>  			__func__, desc->name);
> =20
> -	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
> -		return ERR_PTR(-EINVAL);
> -
>  	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
>  	    (!desc->usb_types || !desc->num_usb_types))
>  		return ERR_PTR(-EINVAL);
> --=20
> 2.33.0
>=20

--vzzx3g4e3zzg74nx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmP5VDgACgkQ2O7X88g7
+polJRAAla8XA7fLb9zHU6Z5WTadOF29OtuCw5SQK3bG4Ch/20GZcvFdBgFE2lRs
dLTJrbY7c+v0RIqOeRZB9ncAIPwUSQW9iZrMPcrIFMXX0Wf9phMBwFIx9CkAsgKs
7GxnxeDAvJNZHYj5hMxRSOfH4UWwEWbGmcPK4wiWogQGZPyl+UihiURclcQcPA8q
1lGxV392BA8SM5Y4NQbl0Tk0TlGuKGi5ebGiogNiPEq6wSBOqkYHteHSiooPPrWr
3PcBFC5eImWaGP2hhmLLxe7yEIaNN9w0/31oc569sI7T50YqBszZSlmz2/Ldbu6F
F9ahB3GuTZBUtLl0A6MQPOZ1qyEtuzD+48WJHZJFrC1gJc4Bv1TeNdTzS5bCWIvJ
tBuB651Z1SxVOV7306v1Zi3jo5n5Va2yBWCwcp9TbtW8bCXr44envT1bahXzy47v
msCTpi1jW3SeC+uljdxmJhs5Zvn9x01QU+WuYkUXCz0OdX2J31b4X+yfDqCZDf+u
FQjjBKCCp+mspZo6dgMcq/ozMeA7mWv2gZkQGwPVlXfnRgVCAwcmSpqgyur5IJon
pR3s8sboVnFvUGMsKDo2A2oKZsjdbcVmgY8c8XP0I2zC0iOFr1/D7wmCXorf7Rf1
uNIwEVpo7J22vcD/XLyUElY5r5eecF8KAkyqROXYc7EQtmBRkD0=
=npUT
-----END PGP SIGNATURE-----

--vzzx3g4e3zzg74nx--
