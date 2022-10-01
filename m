Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1035A5F1F4B
	for <lists+linux-pm@lfdr.de>; Sat,  1 Oct 2022 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJAUVg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Oct 2022 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJAUVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Oct 2022 16:21:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67ED240A9
        for <linux-pm@vger.kernel.org>; Sat,  1 Oct 2022 13:21:33 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E4BF6601FAF;
        Sat,  1 Oct 2022 21:21:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664655692;
        bh=dVQ6xV8G7OVjjwCVr6BNKcRSXHmzHENFNR7l4d1BLlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZ07OgL0KZaiSAFF/LP+KA5EE6iC+FG1zx+/IyUOwCZFPbZjVpaERtyqs5pUBMvJs
         E2OfEQOGqjbafCkEf7ZPpocyICm8upqS5buwcT4UEaRL+fawQcfoM8hSFzStnquxeW
         MBXYENc6amDv5RlUQ2ung1ZNBFt830nrMR3VNbqeycB0qN1Y6K+xDCPXB+5/evTngu
         mJqzXT6xebtBoshHXGyrtPUT5B8OnJACTXf+5EM0IX4C8U2EDkT5xZgYxm3wq68+2V
         ixS+xzyW9jF6QT+h1LrMenNCpo351LGpYCQ4+9/rOFZA6FXc3H8pGmGbvrlCxojCPo
         7xypmkA5WtaWA==
Received: by mercury (Postfix, from userid 1000)
        id B4067106090C; Sat,  1 Oct 2022 22:21:29 +0200 (CEST)
Date:   Sat, 1 Oct 2022 22:21:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yuan Can <yuancan@huawei.com>
Cc:     linus.walleij@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500: Remove unused struct
 ab8500_chargalg_sysfs_entry
Message-ID: <20221001202129.ckgaksrjaomjajdn@mercury.elektranox.org>
References: <20220927133758.98745-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gy3oyayto5hnbg5b"
Content-Disposition: inline
In-Reply-To: <20220927133758.98745-1-yuancan@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gy3oyayto5hnbg5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 27, 2022 at 01:37:58PM +0000, Yuan Can wrote:
> After commit 75ee3f6f0c1a("power: supply: ab8500_chargalg: Drop enable/di=
sable
> sysfs"), no one use struct ab8500_chargalg_sysfs_entry, so remove it.
>=20
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/power/supply/ab8500_chargalg.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index 05146d436a6a..ea4ad61d4c7e 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -252,12 +252,6 @@ static enum power_supply_property ab8500_chargalg_pr=
ops[] =3D {
>  	POWER_SUPPLY_PROP_HEALTH,
>  };
> =20
> -struct ab8500_chargalg_sysfs_entry {
> -	struct attribute attr;
> -	ssize_t (*show)(struct ab8500_chargalg *di, char *buf);
> -	ssize_t (*store)(struct ab8500_chargalg *di, const char *buf, size_t le=
ngth);
> -};
> -
>  /**
>   * ab8500_chargalg_safety_timer_expired() - Expiration of the safety tim=
er
>   * @timer:     pointer to the hrtimer structure

Thanks, queued.

-- Sebastian

--gy3oyayto5hnbg5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM4oUkACgkQ2O7X88g7
+pp+1Q//XCMjz0WDz9z4whfjhanGf4H7XdhPFGuvgNQ/DwwTxiNdd4t6voEgdKTH
amQstLUaBftUA0zdPBq7OsxQqkqWGcaC7+xs3HJxrq+UCh9isg8mHWd6pJSYhbdA
0neFxGJXsGz0iD634cPqnksy9wySb97865RIiBvmO7p0Q03iiYDFvei3XSy32QAL
FR7jJL0RNIZPJ6Y8cQ4GRyoVD7l/RhLooi4QPEIm0z25kOZ3ePQ9PsR4sA1CL2pN
G/uCJMt+D3QCNaCF4OFqkkdUysFr4K45rPaM5z9HLIfhcfnTQ5ibwOcV+jX3I6Hy
vLD+iC/g+2LHZa1JOLlnupEXeADyRVLmIL8A544J7K63UANsfUaIJnSADR3mV2jo
HFVdfgnLtpuFrNFMX2ovB97JEBGDMqx2K55ovxIuHebGHNESBp6+ODSf9dr/jh0Z
UDmAGYx5MDoAWu3RaQVVlsmjH8KRTl7PVyIqJJaqYzaQRAyCjARFKP6Xonry/0Nj
2uYlObOgLpahK7I8K0kzZ1vxPNjWlidjuNzy66NFfk9TvEqTKY6QjfkVezNB54Fs
Vdo8Cu5ZYcrLoQKGPR1y5ihIgAPZU/p5Y2bl6C85W37Raw0+L3OTv1MduNEwXenD
UhssC4u0dfk/46rOe17L6u5m4MpkLYvccxEbnS6wQCjGACXtlEE=
=rTjt
-----END PGP SIGNATURE-----

--gy3oyayto5hnbg5b--
