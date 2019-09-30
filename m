Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E11C1C7D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfI3IFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 04:05:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40311 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfI3IFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 04:05:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so11562968wmj.5;
        Mon, 30 Sep 2019 01:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iZ0dWjtkkU87tg8tjMyvrTlzm1TZ6zOH1FuVyCPP5js=;
        b=tku5GvoCac8CgL7RGMTXU7INk87u8sOuwpmY3lag/Yq4KzFoTLiez2kjQCGg1mWQNY
         L6mDpq0JiB2C6jQZtkDLHdBcGipkHdj8e+iJ2WJD4WpPWRSj8eJQ4UKsGeSfUuZS5RhF
         RpTyHsRvEd4woeBmQ18sGAmIBEyaswO7gfxsaWSeHSXlnt/poUbZ6LUMwzryy9Cn2Qzc
         5BoH0pJg8MM2MFNcg4HAr/cDZl+MCGyaP6R/luHsHVQXpD3MCYgtRn5qFVRWbe3knre9
         KOAXEvg3xeBJ4uKH6uloz6fN4QuQH2Fu+8jh98FgpsJu5okO0cwDkHAsIEP7xP8VLQ6O
         ON1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iZ0dWjtkkU87tg8tjMyvrTlzm1TZ6zOH1FuVyCPP5js=;
        b=uBBT2C6v6ylH39KibEjoahku1esBcobU75781Ef/g1RdYVA96nwv3dWFSqoAYTAygg
         zcpJ8fypr9F4MPntkIyE1l4enwzUk68K1o5emyTW7KCmSwapMXSYkKEWatmDr09xCVdf
         VpzRHP2l2S9PGEhQxxISv/zQTpu7XfzArFRABYr20/ETMM2YjrRJxD+wjB4TFKrxpixZ
         /a2GMzEpKrFH28Ry1AiaHVfK9G9yEWfC1F4pm8t6r2D+AfsIQIxbZ2pL6veroHMK+PsF
         VJtjzQbFwcNdHcLngPDFgdxLpW3FQAfVF77jynalFspwn6hWWEFpR2wSjS3I4WkpMTlO
         EfJg==
X-Gm-Message-State: APjAAAWN3oLcJVLbNY7Pa+EGGOXhNGEy4OTStNblidlSG5OtdKgi76D4
        lt5nOZXTF0Vs/Vbnaw9S3LjKmy5g
X-Google-Smtp-Source: APXvYqyJx2zrS3qEH/WgV2w4rKIMHxuLttTRAanwdd3xwtU4F7pO/NBuhvIHg0P4DFk3hHRxdSoDnA==
X-Received: by 2002:a7b:cb8b:: with SMTP id m11mr16507758wmi.145.1569830714359;
        Mon, 30 Sep 2019 01:05:14 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y19sm16771530wmi.13.2019.09.30.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:05:13 -0700 (PDT)
Date:   Mon, 30 Sep 2019 10:05:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/14] ARM: tegra: Make outer_disable() open-coded
Message-ID: <20190930080511.GE1518582@ulmo>
References: <20190929175952.22690-1-digetx@gmail.com>
 <20190929175952.22690-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <20190929175952.22690-9-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2019 at 08:59:46PM +0300, Dmitry Osipenko wrote:
> The outer_disable() of Tegra's suspend code is open-coded now since
> that helper produces spurious warning message about secondary CPUs being
> online. The secondaries are actually halted by the cpuidle driver on
> entering into LP2 idle-state. This fixes a storm of warnings once LP2
> idling state is enabled on Tegra30.

If the cpuidle driver halts the secondaries, shouldn't it set it offline
then so that outer_disable() can still work correctly?

Thierry

>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/pm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> index 7d9ef26e52a7..16a02937d3da 100644
> --- a/arch/arm/mach-tegra/pm.c
> +++ b/arch/arm/mach-tegra/pm.c
> @@ -146,9 +146,10 @@ static int tegra_sleep_cpu(unsigned long v2p)
>  	 * if any of secondary CPU's is online and this is the LP2-idle
>  	 * code-path only for Tegra20/30.
>  	 */
> -	if (trusted_foundations_registered())
> -		outer_disable();
> -
> +#ifdef CONFIG_OUTER_CACHE
> +	if (trusted_foundations_registered() && outer_cache.disable)
> +		outer_cache.disable();
> +#endif
>  	/*
>  	 * Note that besides of setting up CPU reset vector this firmware
>  	 * call may also do the following, depending on the FW version:
> --=20
> 2.23.0
>=20

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2RtzUACgkQ3SOs138+
s6Eq3RAAq+IM3JsJRvcEWa4zVK9I0xB+MNVeoUFLf4YWngs+qR/ozuEMfUGUf8yr
Zn/lNHPCFdfG905CuOrhlvK8WAuq3XZl7LsXDeAtwv/6/FAEUTn2ZIsDGOAas716
tCRbTmo1dU5Krs+Ws8NtbnZKqW1HZEck42lOkImjylj+9na7+BCOQJgkFjzX7M/k
eSpAmE+C+6HaZfJtmFxP5s8ukCCynw92T2S0w4zrruIwNM8aWSziuDgq4NLctbja
nLgQuvdOSvCIHbtnqJU0aO8DcezDW4UvpI5LD3DUfVaFP3iPsjtvGWfxhjKBy5oo
9jODrFIUMHoSzv0KXi86NVXHmcWUZS61Ww+YgRZRgFtRBQaKNzCohPwajiNEyZu2
Ss3AT5UFGSEhHI2fDFXe7YeaYhgHMh/fCKg+FYrsGAz6PmREkf9GSO7p8PFo7cv3
GxE8qlRjz2CqQA3voW+O38g7QW4bZYTTSVP9VHgwPjocRY300SM4AD7q7bzUraBx
RGbleDykkPVuwKRsno3Y85pcD2zANq3kx7VEgarc10llSewh7KLI0O3C7JnhR2C3
Y5M9jGTAF2LHjIj9X/pVz00/vyXdfSreqTQAIMfQYIFXXdQwsUWAdYtRhwOYrRYq
Z6QefJ+tE/IVq8Cmj7swr3Kc/zXxj1oAYjQbpwLhZXbEnsYbAsY=
=ZN/o
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
