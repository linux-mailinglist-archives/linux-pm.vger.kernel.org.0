Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6B0395AAA
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 14:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhEaMhJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 08:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaMhI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 08:37:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE1CC061574;
        Mon, 31 May 2021 05:35:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so6489088wmg.3;
        Mon, 31 May 2021 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zwFGkSHJb3QbK0O1r+cbPXbjHhDdfq8QipbeGJ1fOyI=;
        b=H9u+EJTbxOUDRB7aZqbiAz6XCRD2d9ZXwYnYQfUiiLDKopv/9pRUqmKlBjoRcR4Q++
         JD9OJkynNKK8uAfwhcgarzjbw45vsJI6RNTiQJztcxvs/j/ic/4yqQ9gsd1fEH4kauK3
         sOm6KbpzX3Oy4WIWiTxIDSW2kbDwqqIOxZ/uMGtIvTgau5Zy0LLoLMbuzLAGI91JuiHs
         Vbcqfgph8GTLA7zuDB07aydMhIHMP0ZgJDYCCqYOTpz+xbXwHePSSrZOzje234fxLDu7
         ojy3V1Yzjlm6gwmV+IeSH7xM92PNqUf8slXaeRIYUr1GafNjTD6wJVxxE1dTwx4FxlWC
         Y42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwFGkSHJb3QbK0O1r+cbPXbjHhDdfq8QipbeGJ1fOyI=;
        b=P2jyPUstjuxBQn054yVdwZh+qz9ycBd2sHIuDad0BSdLmbTI0MN4EfNtmJYbGUl3Sv
         4I9P2RAELe13KR+qAGwuba9hSxSxw2fHVq2VNX1a1LON5Yq28+oiC3zC5FJUT4FOgRF0
         +M5rfXIU/9kAckJucSZ3OMMPf2Ker3mImWEsPffThrUaDGrxiUZZDY3ben+rwyrrFOQZ
         lYaqZr1AFBtwEmkiio6oIH3e41Avsqg6KVAHR2swR10aG6fGpN+81CdBGn5DWdWcGU2t
         PG0rd1kVYenEz9kRnSquhXXWpu/1lieFMea9tag1W99GNZTCJD9tY/pf3Kr9iiAw9IHo
         8Hdg==
X-Gm-Message-State: AOAM531Qsbl5yg2VnnWjaAZ0lmyziXMA5Uo0Jf8jlNdCyjclA3DycB2d
        SpwuJdYk7Bnz+zKHGGKfDd4=
X-Google-Smtp-Source: ABdhPJwyTc8suT4h0iUXf2aZfNTaToq0xrly/3uwrO9Hi8GjZP5GxTIun5gWsy5RWZafSmDZREHMwg==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr13120634wmj.19.1622464526196;
        Mon, 31 May 2021 05:35:26 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s5sm15394602wmh.37.2021.05.31.05.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 05:35:24 -0700 (PDT)
Date:   Mon, 31 May 2021 14:36:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] soc/tegra: pmc: Add core power domain
Message-ID: <YLTYayQD7ufuUsXJ@orome.fritz.box>
References: <20210516231755.24193-1-digetx@gmail.com>
 <20210516231755.24193-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IwyGpgWj4kOLYU1V"
Content-Disposition: inline
In-Reply-To: <20210516231755.24193-3-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--IwyGpgWj4kOLYU1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2021 at 02:17:54AM +0300, Dmitry Osipenko wrote:
> NVIDIA Tegra SoCs have multiple power domains, each domain corresponds
> to an external SoC power rail. Core power domain covers vast majority of
> hardware blocks within a Tegra SoC. The voltage of a power domain should
> be set to a level which satisfies all devices within the power domain.
> Add support for the core power domain which controls voltage state of the
> domain. This allows us to support system-wide DVFS on Tegra20-210 SoCs.
> The PMC powergate domains now are sub-domains of the core domain, this
> requires device-tree updating, older DTBs are unaffected.
>=20
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/Kconfig  |  14 ++++
>  drivers/soc/tegra/pmc.c    | 143 +++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/common.h |   6 ++
>  3 files changed, 163 insertions(+)

Since this power domain code is all dealt with within the PMC driver,
and the PMC driver is enabled on all platforms, how about if we avoid
creating the additional SOC_TEGRA_COMMON kconfig option and instead
make SOC_TEGRA_PMC list the dependencies?

No need to resend, I can make that change when I apply, if you agree.

Thierry

--IwyGpgWj4kOLYU1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC02GkACgkQ3SOs138+
s6GW9g/8CaH4AWyc7KND08PWD4ZxPmCYNLI/uVuiH3tA0kP8t75NL6N4dcA6PVnm
7yHcjREEmE0B7L01R1/vs4MNU0zvIfvKVgz78DC5ro6xhsknfgcvyt6gqJapvQl6
EKdW7mqUjO0SH53jEM+AyyfI2k7M5GiowLz8+u1S2Lwt/CBE+/1Z1+5n5bFaP1b9
WUjKX0HXAnISBV4raGbejn3TXSQd0ST5SlYNvhG5ERIov03C/5pzoDhoJEM2D7EF
myf7G/uBpTSUpGENmm0ZvA7ybbaSjguiJ7XpJDMP7Y2KCO3uYkVAOchRKP4PPys/
qpG4DJXxhhG/snzXyb9LSnsp87pakkhnmQQ6Z8oiN9ojuX3r2zppgHXxPZi996UZ
juPMW39JVQFgL3Gv4VSk94q/C3hhyfGAcDNiU4JMXYvnQlw/rPkOdvRqMkrG6qLS
O8LtqufoP0fO9BlnuLCQouuWqLC4yCHP07baUjaoAtJu68TZvkJFhi04ma6bRBC2
roE5HBKrXlIVNaoHOSt/GJERjB6aVrF9Af9o2CNZyxGKGTCZqMxKTXOgF+LI/MsA
69BLF0sjQdhiDz/9r3G4z7q4NuiQm0JKt+wkntvr840N0dSxQ4zI7V4CK153T0Yx
xn1R8Qof2MJmj6KU0CPu/08M83VONsRqr5g2tDXbBHFmjt8lYxs=
=pWdv
-----END PGP SIGNATURE-----

--IwyGpgWj4kOLYU1V--
