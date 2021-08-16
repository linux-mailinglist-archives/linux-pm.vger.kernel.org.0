Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580DD3ED14F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhHPJxn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 05:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhHPJxn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 05:53:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2001C061764;
        Mon, 16 Aug 2021 02:53:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x10so16377088wrt.8;
        Mon, 16 Aug 2021 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JAhbLXhuiKr15f569cp5ZlH29FsUdWP9r+HrMVJpIZI=;
        b=ZTYDLcpgsR+WBvS9Ay5rkaSI2IDGZJx7bHVphRf9rG25VzfxPWNxwM2FBOQYlksEYJ
         nkbRT5W4oE6Zb6uSH23FVDcxJ1U6vRGkxonLza7J371J+nFmuF52PzHezn3AJ84/iBfk
         wLsqHgfC/b0EmBIpmDVTUDi1s/xWEogvnuY2U6Z9heaHoU03aGviK8EG6HDr7cwvWcCS
         EJT5aur4lYO8970HvvRs88lu3rIv2gXi5Fac5Ux5SufAulQxXsdFx82LbcjbuSm8qnNr
         7DH/aELVrFdCz9pcz0yP4eDWo7EPDg+lZcewV9DtsPMIKhJbKSqgSLc+k0cxYpa1lnxz
         kmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JAhbLXhuiKr15f569cp5ZlH29FsUdWP9r+HrMVJpIZI=;
        b=B2xSR/c2gRBqAUhSCm8UA6UrbnLAwPJQQ9DyiwiOBrO5Qvt6k7ToMX5OJmWFRoLkEs
         1me09sZwfGykfkRLQZmZTVGUqm+m7U1qRFQnvuc7GbwKQvH/aH2TdalbVdl2xjGw/vHz
         VHmQvEaWYWEEpA8b4LwIp+hDhWVbVEm+41gtt19Z+dV7Pso95bk3BRv/x3git13gVEF9
         7XoN34RA5rLo1szm9EDSb4+TZcINhJw5rpveGjlaMY34Ya+JzBmF0JsE3ih2YQWnSgcX
         ZZGZJPrULslDHBfF/g5bsP89WtJzFMceKUm43kKneumICuj/ruZDQ2S59SzLh3IPSmLb
         XIeQ==
X-Gm-Message-State: AOAM533steB8XBOLhEWRhjBuO/0X3pooqxkP4Jn5KlO2kWjTNGTrn9go
        bZHOyooMPdVTJCjAd6+DpkQ=
X-Google-Smtp-Source: ABdhPJzkq0DMPLKzLvG3MOiFX8IELX/UVhokVOU8VeEoHR+ro93o2BiXPK7pgpZuDyfCQ9CEkmBwlw==
X-Received: by 2002:a05:6000:186:: with SMTP id p6mr17698437wrx.19.1629107590269;
        Mon, 16 Aug 2021 02:53:10 -0700 (PDT)
Received: from localhost (pd9e51807.dip0.t-ipconnect.de. [217.229.24.7])
        by smtp.gmail.com with ESMTPSA id m6sm3398602wms.42.2021.08.16.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:53:09 -0700 (PDT)
Date:   Mon, 16 Aug 2021 11:53:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] cpuidle: tegra: Check whether PMC is ready
Message-ID: <YRo1hK/KnS0oA1vj@orome.fritz.box>
References: <20210718212706.21659-1-digetx@gmail.com>
 <20210718212706.21659-3-digetx@gmail.com>
 <YROdQXO4aVLQ8DkP@orome.fritz.box>
 <8d61d4d5-8e4b-5c18-923c-eceb954e8d5d@linaro.org>
 <8f22c97d-63f7-6d2a-7b1e-92b0b80a5275@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/FxjFLhUbsKPIo++"
Content-Disposition: inline
In-Reply-To: <8f22c97d-63f7-6d2a-7b1e-92b0b80a5275@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--/FxjFLhUbsKPIo++
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 14, 2021 at 04:45:42PM +0300, Dmitry Osipenko wrote:
> 14.08.2021 13:37, Daniel Lezcano =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On 11/08/2021 11:49, Thierry Reding wrote:
> >> On Mon, Jul 19, 2021 at 12:27:06AM +0300, Dmitry Osipenko wrote:
> >>> Check whether PMC is ready before proceeding with the cpuidle registr=
ation.
> >>> This fixes racing with the PMC driver probe order, which results in a
> >>> disabled deepest CC6 idling state if cpuidle driver is probed before =
the
> >>> PMC.
> >>>
> >>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>> ---
> >>>  drivers/cpuidle/cpuidle-tegra.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>
> >> Rafael, Daniel,
> >>
> >> would you mind if I took this into the Tegra tree? It's got a dependen=
cy
> >> on the PMC driver, which usually goes via the Tegra tree already, and
> >> there's nothing cpuidle-specific in here, it's all Tegra-specific
> >> integration quirks.
> >=20
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> I got another thought about how it could be solved. We could move the
> creation of the cpuidle platform device into the PMC driver. Thierry,
> what do you think?

Looking around a bit, it looks like we've got two "virtual" platform
devices related to CPU on Tegra20 and some of the later SoCs. A little
while ago when we introduced the CPU frequency driver for Tegra194 we
had a similar discussion. The problem at the time was that there was no
way to create a virtual platform device from platform code, and adding a
device tree node for this wasn't really an option either, since it does
not actually describe the hardware accurately.

What we ended up doing for Tegra194 was to add a compatible string to
the /cpus node ("nvidia,tegra194-ccplex") which was then used for
matching a CPU frequency driver against.

I imagine we could do something similar for these older chips and
perhaps even have a single driver for the CCPLEX that either registers
CPU idle and CPU frequency scaling functionality, or have that driver
register virtual devices. I slightly prefer the first variant because
then we associate the driver with the hardware that it's actually
driving. It's slightly unconventional because now CPU idle and CPU
frequency drivers would be implemented in the same driver, but it isn't
all that exotic these days anymore, either.

If the maintainers prefer we could always keep the code split into two
source files, one per subsystem, and call into that code from the CCPLEX
driver. I think even then it'd still be the cleanest solution because we
don't have to "invent" a new device just for the sake of fitting the
driver model that we happen to have.

Thierry

--/FxjFLhUbsKPIo++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEaNYEACgkQ3SOs138+
s6HT+w//ZI+9IViNuhkUW3Z7Peo91l6nKc6T7XOGIXQfV19555Sj60sEI6t/iVJq
b3FFliv1NUCr3LgZRD+YzGQbW00GiVunreVgI/EDhXiXDAHAlT8n1dsf4qqoa5lc
H8frsJOGd0B+nMG13ycwFQYGh1xUVUxU80lPhbdivPucCIDB+1B/XKexN7Leqd82
idhpaHw+gT6YWBrR8dDxdX2tBYox/9n6Iy8HjIx4G9ErKErVkKk26grNKzmHY07X
2tUF727WFpunZsnpOKbgdPr3yBmg0MxAvhygG4otqQz92SzY0ZiHFYtVO4nCwDz+
XmwaklY2NMUeSoNjekCNj7sPhCkGw8cPhYTIgs6twg+xXQgkwSdkHmcDm2WP81D1
5H5YVNfQznxONIAD9xSqS3EdIAT9wzd7sipcDp/IHzMG3L83pi/DN6tYNyhBdbPO
1a8/oskfmNWKJ/sx7mRgzrvybGcFaIO3MxTnafRMOnWoVVpAOLFyhnNuKaupdEEs
K/KvkJEZaTbcxDYP323WTkZ3RMNn4OczQELL7lcJW2TZOikLFLooEu6/lSI4iAVa
ICoKuQwmA9KLA67AVViFwRlZAvsCHjZi6t2HFErtBpwdvZKLQzoLNdfS5DinL5o3
OVpk+2IeZ4XSTUd/gn859qgNJMD94gSnJ3uqvdRBNv04etaiQ2U=
=N2nq
-----END PGP SIGNATURE-----

--/FxjFLhUbsKPIo++--
