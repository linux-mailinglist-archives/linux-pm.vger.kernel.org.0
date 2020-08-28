Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223B82559C1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 14:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgH1MCF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 08:02:05 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4714 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgH1MCE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 08:02:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f48f22b0001>; Fri, 28 Aug 2020 05:01:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Aug 2020 05:02:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Aug 2020 05:02:01 -0700
Received: from localhost (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 12:01:57 +0000
Date:   Fri, 28 Aug 2020 14:01:54 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        "Len Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [RFC][PATCH] pinctrl: Rework driver_deferred_probe_check_state()
 evaluation since default timeout has changed
Message-ID: <20200828120154.GA1674264@ulmo>
References: <20200808043512.106865-1-john.stultz@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200808043512.106865-1-john.stultz@linaro.org>
X-NVConfidentiality: public
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598616107; bh=9/WgoaqX9XSKJ6CVVc6mTKsdaYJII81w8EyRtpIjqyc=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=P1jDO76FMdxtRG297kU0Ll5W2Clgq2JZgLeWFlK+B+5Dk7gmszUlTpyYP8CriuQo0
         u9DO4q7ZKzzt7u5zzz5JEWPApsTLF9xjNbJU7f6No4GkUShWIj6v3t5zcRLgtA5zfc
         vATLsVmfv1nBengn0oeMdo/Cez9jXluVgUYQiVSxG4UbCP5lUYzZhcZz5DE7X0y2BW
         3rP1g5Mr/0RnT7bGOQoUiKxvue8J7B75glHpV/ssKC3ZDThoBih4R7Ym8dZ3bgZaT6
         1Qozh9r3CnMpiLYyBrhvJLfQzRFTtTiYF+SY2k0/cEkis3Twmjegkpia+gKY7ncrzQ
         YFrNODcSFOX5g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2020 at 04:35:12AM +0000, John Stultz wrote:
> In commit bec6c0ecb243 ("pinctrl: Remove use of
> driver_deferred_probe_check_state_continue()"), we removed the
> use of driver_deferred_probe_check_state_continue() which
> effectively never returned -ETIMED_OUT, with the
> driver_deferred_probe_check_state() function that had been
> reworked to properly return ETIMED_OUT when the deferred probe
> timeout expired. Along with that change, we set the default
> timeout to 30 seconds.
>=20
> However, since moving the timeout to 30 seconds caused some
> issues for some users with optional dt links, we set the
> default timeout back to zero - see commit ce68929f07de ("driver
> core: Revert default driver_deferred_probe_timeout value to 0")
>=20
> This in essence changed the behavior of the pinctrl's usage
> of driver_deferred_probe_check_state(), as it now would return
> ETIMED_OUT by default. Thierry reported this caused problems with
> resume on tegra platforms.
>=20
> Thus this patch tweaks the pinctrl logic so that it behaves as
> before. If modules are enabled, we'll only return EPROBE_DEFERRED
> while we're missing drivers linked in the DT.
>=20
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_=
state_continue()")
> Fixes: ce68929f07de ("driver core: Revert default driver_deferred_probe_t=
imeout value to 0")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/pinctrl/devicetree.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> index c6fe7d64c913..09ddf567ccb4 100644
> --- a/drivers/pinctrl/devicetree.c
> +++ b/drivers/pinctrl/devicetree.c
> @@ -129,9 +129,8 @@ static int dt_to_map_one_config(struct pinctrl *p,
>  		if (!np_pctldev || of_node_is_root(np_pctldev)) {
>  			of_node_put(np_pctldev);
>  			ret =3D driver_deferred_probe_check_state(p->dev);
> -			/* keep deferring if modules are enabled unless we've timed out */
> -			if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
> -			    (ret =3D=3D -ENODEV))
> +			/* keep deferring if modules are enabled */
> +			if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
>  				ret =3D -EPROBE_DEFER;
>  			return ret;
>  		}

I posted almost exactly the same patch a couple of days ago since I
hadn't noticed this:

	https://patchwork.ozlabs.org/project/linux-gpio/patch/20200825143348.13586=
79-1-thierry.reding@gmail.com/

I like that slightly better because it keeps the "ret < 0" condition,
which I think is perhaps a bit more future-proof. Thinking about it, I'm
not sure your version above is entirely correct. For example if the call
to driver_deferred_probe_check_state() were to ever return 0, we might
still be returning -EPROBE_DEFER here.

That's not something that happens currently, but I suspect that these
implications will be easy to overlook.

Actually... I think it might be best to just bring back (albeit perhaps
in a modified form) driver_deferred_probe_check_state_continue() because
we're now basically doing exactly what that was supposed to do: special-
casing the case where we do want to continue returning -EPROBE_DEFER in
some special cases.

Thierry

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9I8jAACgkQ3SOs138+
s6Hu9hAApfTBuRlf69eu2V0wppfR0Fzbbw6OA9g1weChMOg1z/IqvffHjpQNLkz5
j2Invo8QExFJIMZjFR6HAutSd/ZziRkfuufF4FE769UFF7dD8qjlbov2lw02esPZ
81y9IgVf2Xmmyhu/P9JcoR+LkqSWRBqvddvGvF6dJoAYLum8lO6/B0PVz3zGSo4q
KlkthLC2acc857c1UFo5suK9oi5n924WvHXTDwvTaJx/FNsMBLWdVgjauzksEFCW
bE/dR2Kp0SbZKRlJi3qg7ACE6rB83NYhB9ttYafZKMerJOgqTFIWjtp9QiD4gtgp
huW+E/+NFDgZFsUdzuhhfUiX3QBw7qeoe2AqQdR0XtSsQYiNJjOq/V9RAqj+CgZX
MRU27mKzVOVAXV1kI5BRAWodO7WFz/55arOcp0/3+jua2Je8i4mtqW7K1/oJ4WFe
hAXcJTvwFG++Bhq9Q80Ryo2wQtu5hEWMs9dG93SEvaJm+ShSpux2lSeiQ1h6gP0F
AJqWgA2NdILCCxz2g2Aq2AQEcob5XhtK36rNAbyr2oJ3zTdB/vyro++/3f+fvrjE
MwcNODW/Qny4JwNRTGXzQ4eChDaCjZhQVZaoe2r0ToFbXZAnThWDqxlw+UPWM5wf
Nv8XWHnl+LFc+AQ+98StnEgBhb0hQLsVfZ9er4e0YqhwswHGa6E=
=bfLv
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
