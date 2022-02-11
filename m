Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1034B2D8E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Feb 2022 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352830AbiBKTc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Feb 2022 14:32:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344239AbiBKTcy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Feb 2022 14:32:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AA2CED
        for <linux-pm@vger.kernel.org>; Fri, 11 Feb 2022 11:32:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 181991F47016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644607972;
        bh=0QuecXQAggkih/M/C1CunhF2V6s5lNLpjucigFvDULs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIOZKGXY5FMbgSafvWJLvXKevcyAMtamDyH8moHQeY7Wxym4zHpX9Ouzuhqw43Qf4
         ci4cnhS1cYnib59rO2nOtfX41arme/8VWHecTouOxW/Zg1RwsSleHUGehBFRg5PQ4C
         kZqwomzHqGpZgzdQDG2IXAR2CVztfz3WTHQhdwVk9+X52xMfi9v85EnCiZlU02iMi/
         YaPHBXhFNovV6jckNVMAqu+SOdd9xz+X6os1SLJ1dzXiPt4FLyFOxDLaewivF13FxD
         hXFlgrjlaHJ+CKgtRmQW0XtbM2LkiUPa9tQMzCyhB7THE1YMsGndtuwTL94yqaZEqc
         1imMx9c3dsxVA==
Received: by mercury (Postfix, from userid 1000)
        id 73F841060908; Fri, 11 Feb 2022 20:32:49 +0100 (CET)
Date:   Fri, 11 Feb 2022 20:32:49 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/11 v2] power: supply: ab8500_fg: Break out load
 compensated voltage
Message-ID: <20220211193249.w47s2can4cu4yq4m@mercury.elektranox.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
 <20220129004925.639684-6-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ron4ga24bzu5hgs2"
Content-Disposition: inline
In-Reply-To: <20220129004925.639684-6-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ron4ga24bzu5hgs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 29, 2022 at 01:49:19AM +0100, Linus Walleij wrote:
> Break out the part of the function providing the load compensated
> capacity that provides the load compensated voltage and use
> that to get the load compensated capacity.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix patch ordering issue: I was using a uv argument to
>   ab8500_fg_battery_resistance() however that refactoring is
>   later on in the series. Fixed now.
> ---
>  drivers/power/supply/ab8500_fg.c | 50 ++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 29896f09fd17..1797518c4b0e 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -909,18 +909,20 @@ static int ab8500_fg_battery_resistance(struct ab85=
00_fg *di)
>  }
> =20
>  /**
> - * ab8500_fg_load_comp_volt_to_capacity() - Load compensated voltage bas=
ed capacity
> + * ab8500_load_comp_fg_bat_voltage() - get load compensated battery volt=
age
>   * @di:		pointer to the ab8500_fg structure
>   *
> - * Returns battery capacity based on battery voltage that is load compen=
sated
> - * for the voltage drop
> + * Returns compensated battery voltage (on success) else error code.
> + * If always is specified, we always return a voltage but it may be
> + * uncompensated.

This documents the always parameter, which is only introduced in the
next patch :) Since I found nothing else I merged the patchset anyways.

I also noticed that 'always' is always true at the end of this
patchset (and assumed it will be used in a future patchset).

Greetings,

-- Sebastian

--ron4ga24bzu5hgs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGueEACgkQ2O7X88g7
+prUMw//QMXSgb74UqsJ1tghVGchKGMcpowSikbu4UBOSWQJcSw7ImSxY0uRn1ei
5Ut1KD/XgqSqPahWUwDbY06bzTXNjIFNh5eG/IkmvdlSI1V79nnqydBn3ti0LcLz
I3lt0diwDXmOiybB4Lj0e/W1II+WzCWfjS7H9PS1OSS3YgMu3AaWuEYULWrVsgcO
a+BnuiIX7xlMD+9IhaIrufjozpZDo4kH9cQmyqNnZ2LbtIaHQBkWoOUlloajSsyA
EfmQHlj8S1p3TxKmX0nu/Nu3BtHsIMtcCwVjI3L+eGc9MhI3cBE6r9cHAMt0y4gQ
dIqYCS/otBYwp+HArxrAiCq0sCV0OO+Elp0VifNvYguso9kTcqYfI3qVYeYJdaH/
emNSqgqCVAUIR5ySLgj5mE2f0U0iLp7vHOoyynsGLUiDRiEPojl/HqYls4BO2LAL
eoek/N/iW+2h3wLWmQpSn3e/M+5TISTdPRqS5gGNnFUTeF/aTQaRn0xuz2/0cstF
7l0ChuWHFZ0Y2ac9eUl+qUKClsaeGRfDsmq+NasuJdBi99rnpe9EiQZ/CsHPqsCq
0ih6kiLbcFPSSQWhxzCO3xfneqbYWvs7g7BTb5vL35xQr1lVmNFOEa/iUC9I89E1
MHKCbaXW+Ki8BVx7qDQg91Tjjs7RFS+ZTjsat1Z7vyO5X8LLohg=
=tdgS
-----END PGP SIGNATURE-----

--ron4ga24bzu5hgs2--
