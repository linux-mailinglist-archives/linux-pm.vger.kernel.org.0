Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028B068F3D2
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 17:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBHQ4z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 11:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBHQ4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 11:56:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFEC83FC
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 08:56:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPnkL-0004Pj-GR; Wed, 08 Feb 2023 17:56:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPnkI-003Yhr-5a; Wed, 08 Feb 2023 17:56:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPnkI-001uAR-5y; Wed, 08 Feb 2023 17:56:34 +0100
Date:   Wed, 8 Feb 2023 17:56:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
        Kevin Hilman <khilman@kernel.org>,
        iresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>, linux-pm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] cpufreq: Make cpufreq_unregister_driver() return void
Message-ID: <20230208165633.dzfpkier6jcl54em@pengutronix.de>
References: <20230207195909.474953-1-u.kleine-koenig@pengutronix.de>
 <20230208160457.ouh2kg36s4kqpahe@beas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="knqz7kbydnvdpef4"
Content-Disposition: inline
In-Reply-To: <20230208160457.ouh2kg36s4kqpahe@beas>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--knqz7kbydnvdpef4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 08, 2023 at 04:04:57PM +0000, Wyes Karny wrote:
> On 07 Feb 20:59, Uwe Kleine-K=F6nig wrote:
> > All but a few drivers ignore the return value of
> > cpufreq_unregister_driver(). Those few that don't only call it after
> > cpufreq_register_driver() succeeded, in which case the call doesn't
> > fail.
> >=20
> > Make the function return no value and add a WARN_ON for the case that
> > the function is called in an invalid situation (i.e. without a previous
> > successful call to cpufreq_register_driver()).
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 +----
> >  drivers/cpufreq/cpufreq.c             | 8 +++-----
> >  drivers/cpufreq/davinci-cpufreq.c     | 4 +++-
> >  drivers/cpufreq/mediatek-cpufreq-hw.c | 4 +++-
> >  drivers/cpufreq/omap-cpufreq.c        | 4 +++-
> >  drivers/cpufreq/qcom-cpufreq-hw.c     | 4 +++-
> >  include/linux/cpufreq.h               | 2 +-
> >  7 files changed, 17 insertions(+), 14 deletions(-)
>=20
> > base-commit: 05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
>=20
> You may have to rebase it on top of this [1].
> Recently this patch series was picked up by Rafael.
> You have to add the below hunk in your patch.
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 168a28bed6ee..70debd5a9f40 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -831,7 +831,7 @@ static void amd_pstate_driver_cleanup(void)
>=20
>  static int amd_pstate_update_status(const char *buf, size_t size)
>  {
> -       int ret;
> +       int ret =3D 0;
>         int mode_idx;
>=20
>         if (size > 7 || size < 6)
> @@ -844,7 +844,7 @@ static int amd_pstate_update_status(const char *buf,
> size_t size)
>                         return -EINVAL;
>                 if (cppc_state =3D=3D AMD_PSTATE_ACTIVE)
>                         return -EBUSY;
> -               ret =3D cpufreq_unregister_driver(current_pstate_driver);
> +               cpufreq_unregister_driver(current_pstate_driver);
>                 amd_pstate_driver_cleanup();
>                 break;
>         case AMD_PSTATE_PASSIVE:

Good catch. The adaption looks right. @Rafael, please tell me, if you
want me to adapt my patch and resend.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--knqz7kbydnvdpef4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPj1D4ACgkQwfwUeK3K
7AnVxgf+ILsyJwNmEvnAnizS6MgxdLlPUiJftEk6PnIdgwAmCH0zkQzc6w6rQ8Hn
5vQ2IkoYxDwn9sVYZte5k63thHvBzkdSz0aX2pgUSWWxTJNXraJeNwKaUoMX5bjv
vADTUsMWmPishXMmUkp/aPhFAKA3+hGiKyQS4vVCtWibnjk57H2B6nnXxGtKRO7S
zjo46yLa1/C4h5Io9ICvEu9KKCU48qhv8r1HdMckI0ziOdu0zsnX+FP1ZpbAOvLA
qSr7G7VHdcADBJlM69aRFliyH25ePUyVl5SexuJynMzuNCMwVCjpSt3ZJCWDbO13
gWG6FmwvepzA5GI4ZTIjRQuUUJqqzg==
=Zzsp
-----END PGP SIGNATURE-----

--knqz7kbydnvdpef4--
