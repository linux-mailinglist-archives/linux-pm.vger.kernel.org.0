Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B3C1D1F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 10:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfI3I0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 04:26:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36426 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfI3I0v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 04:26:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so10169859wrd.3;
        Mon, 30 Sep 2019 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Y3H/SPQeg3jnz5y4/2SycJA/ZSoTyvz4wEHvwxwweY=;
        b=PKxxsMXnAoR9BsZh0MqIBsMRY4QulyWDl7biV6E1ohBu61/Wks9fd/t6hZOO6+tAli
         QvdyuUQoNqe8ztCpsqoRRqPjac/BNdaezxv0rMAR9o0K7grg/Ux+YponFBaDOEEFZqso
         lnWC2/k1wWFzVnxQ6GQP90qSlM9TXCqvYpD7wSmXIIJkg+ngS4TUUR5vD5LAkfUYK828
         kbOvRzg7cu+x9CY/UGtN/UPMMlez5HvwYuxQq4UrCvpjyNLqQSZvb/OkT4DFuh7aI6cU
         BldI3DL/lRxAQOeytmqeMm9T/dO0F52Tn3YE3CVEZmNHiSteHN046B5hQsqEuyXtxq0E
         2O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Y3H/SPQeg3jnz5y4/2SycJA/ZSoTyvz4wEHvwxwweY=;
        b=p/cNfNALcMzKv3MnENx2nfbd1XS62nx+ByVdIty1EL3gb+nNME7zHPHIiweTNuTC00
         WP7QyFJhognRmOL54X0AaYZAlryvy4+DuPSDweIscPc7YKZfzBtrmAiQf4eu9H7w87Hj
         cxbaN70cGbkeiwaEhflHB1S4pKJ5PwK9HZGjmlMG2QPAeUBVhcmIzEmHILEsIPubyR2w
         vCtVSFFuMdtyvC2EJ3m7gaUehbRZKZ4srm8ubm30V1Er7gELLktcfIP4Vrn/i15vYgCs
         4YWRrFOujG5FlJwTLm/5iZAkTMaVAh9CDARZysYqU6vVvziLZ0ktL2rcESSQutfl5vWn
         foJA==
X-Gm-Message-State: APjAAAXyshR282hfjAnvetb9FtUKTS4rNtQcoaKwUY+g/nRHPt2U6aec
        8hcNvTUDBO3tqqCaQzdeAds=
X-Google-Smtp-Source: APXvYqz9d/Z9K9xqRpMSMHOWtJn7iQhktYpcyZXEPlUZLTrqjj7MpiTsiEMDLetvVuAySDojm6ltkA==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr12598777wru.317.1569832007966;
        Mon, 30 Sep 2019 01:26:47 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id t18sm15250954wmi.44.2019.09.30.01.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 01:26:46 -0700 (PDT)
Date:   Mon, 30 Sep 2019 10:26:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
Message-ID: <20190930082645.GF1518582@ulmo>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2019 at 08:59:38PM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This series does the following:
>=20
>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>      into common drivers/cpuidle/ directory.
>=20
>   2. Enables CPU cluster power-down idling state on Tegra30.
>=20
> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
> and of the Tegra's arch code in general. Please review, thanks!

I generally like this series and it looks really good from a diffstat
point of view. However, removing existing drivers completely and then
incrementally add a new one make this impossible to review.

If you think about it, it also makes it really difficult to find what
went wrong if at any point in the future we find a regression caused by
the new driver. A bisection will always point at the commit that removes
the old driver because between that and the point where you add the new
driver, CPU idle just doesn't work at all anymore.

While I understand that it's very convenient to just throw away old code
and rewrite it from scratch, it's also impractical (and a little rude).
It's not how we do things in the kernel. Unless maybe under specific
circumstances.

Can you please try and make this a little more iterative? At the very
least I'd expect a series where you do all the preliminary work in
preparatory patches and then replace the old driver by the new driver in
a single patch. That way at least there will be an unambiguous commit in
a bisection.

Ideally, you'd also break up that last conversion patch into smaller
incremental patches to make it easier for people to review. Remember
that your chances to attract reviewers increases if you make the patches
easy to review, which means your patches should be small, logical
changes that (ideally) are obviously correct.

Thierry

> Changelog:
>=20
> v5: - Rebased on a recent linux-next, fixed one minor conflict in Kconfig.
>=20
>     - Improved commit's message of the "Support CPU cluster power-down st=
ate
>       on Tegra30" patch.
>=20
>     - The "Support CPU cluster power-down state on Tegra30" patch is also
>       got split and now there is additional "Make outer_disable() open-co=
ded"
>       patch.
>=20
>     - Made minor cosmetic changes to the "Introduce unified driver for
>       NVIDIA Tegra SoCs" patch by improving error message and renaming
>       one variable.
>=20
> v4: - Fixed compilation with !CONFIG_CACHE_L2X0 (and tested that it still
>       works).
>=20
>     - Replaced ktime_compare() with ktime_before() in the new driver,
>       for consistency.
>=20
> v3: - Addressed review comments that were made by Jon Hunter to v2 by
>       splitting patches into smaller (and simpler) chunks, better
>       documenting changes in the commit messages and using proper error
>       codes in the code.
>=20
>       Warnings are replaced with a useful error messages in the code of
>       "Introduce unified driver for NVIDIA Tegra SoCs" patch.
>=20
>       Secondary CPUs parking timeout increased to 100ms because I found
>       that it actually may happen to take more than 1ms if CPU is running
>       on a *very* low frequency.
>=20
>       Added diagnostic messages that are reporting Flow Controller state
>       when CPU parking fails.
>=20
>       Further polished cpuidle driver's code.
>=20
>       The coupled state entering is now aborted if there is a pending SGI
>       (Software Generated Interrupt) because it will be lost after GIC's
>       power-cycling. Like it was done by the old Tegra20 CPUIDLE driver.
>=20
> v2: - Added patches to enable the new cpuidle driver in the defconfigs:
>=20
>         ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
>         ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
>=20
>     - Dropped patches that removed CPUIDLE_FLAG_TIMER_STOP from the idling
>       states because that flag actually doesn't have any negative effects,
>       but still is correct for the case of a local CPU timer on older Teg=
ra
>       SoCs:
>=20
>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from Tegra114/124 =
idle-state
>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from all states
>=20
>     - The "Add unified driver for NVIDIA Tegra SoCs" patch got more polis=
h.
>       Tegra30 and Terga114 states are now squashed into a single common C7
>       state (following Parker TRM terminology, see 17.2.2.2 Power Managem=
ent
>       States), more comments added, etc minor changes.
>=20
> Dmitry Osipenko (14):
>   ARM: tegra: Remove cpuidle drivers to replace them with a new driver
>   ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
>   ARM: tegra: Propagate error from tegra_idle_lp2_last()
>   ARM: tegra: Compile sleep-tegra20/30.S unconditionally
>   ARM: tegra: Expose PM functions required for new cpuidle driver
>   ARM: tegra: Rename some of the newly exposed PM functions
>   ARM: tegra: Add tegra_pm_park_secondary_cpu()
>   ARM: tegra: Make outer_disable() open-coded
>   clk: tegra: Add missing stubs for the case of !CONFIG_PM_SLEEP
>   cpuidle: Introduce unified driver for NVIDIA Tegra SoCs
>   cpuidle: tegra: Support CPU cluster power-down state on Tegra30
>   ARM: tegra: Create simple platform device for cpuidle driver
>   ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
>   ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
>=20
>  arch/arm/configs/multi_v7_defconfig           |   1 +
>  arch/arm/configs/tegra_defconfig              |   1 +
>  arch/arm/mach-tegra/Makefile                  |  23 +-
>  arch/arm/mach-tegra/cpuidle-tegra114.c        |  89 -----
>  arch/arm/mach-tegra/cpuidle-tegra20.c         | 212 -----------
>  arch/arm/mach-tegra/cpuidle-tegra30.c         | 132 -------
>  arch/arm/mach-tegra/cpuidle.c                 |  50 ---
>  arch/arm/mach-tegra/cpuidle.h                 |  21 --
>  arch/arm/mach-tegra/irq.c                     |   3 +-
>  arch/arm/mach-tegra/pm.c                      |  50 +--
>  arch/arm/mach-tegra/pm.h                      |   4 -
>  arch/arm/mach-tegra/reset-handler.S           |  11 -
>  arch/arm/mach-tegra/reset.h                   |   9 +-
>  arch/arm/mach-tegra/sleep-tegra20.S           | 170 ---------
>  arch/arm/mach-tegra/sleep-tegra30.S           |   6 +-
>  arch/arm/mach-tegra/sleep.h                   |  15 -
>  arch/arm/mach-tegra/tegra.c                   |   7 +-
>  drivers/cpuidle/Kconfig.arm                   |   8 +
>  drivers/cpuidle/Makefile                      |   1 +
>  drivers/cpuidle/cpuidle-tegra.c               | 349 ++++++++++++++++++
>  drivers/soc/tegra/Kconfig                     |   1 -
>  include/linux/clk/tegra.h                     |  13 +
>  include/soc/tegra/cpuidle.h                   |   2 +-
>  .../mach-tegra =3D> include/soc/tegra}/irq.h    |   8 +-
>  include/soc/tegra/pm.h                        |  31 ++
>  25 files changed, 453 insertions(+), 764 deletions(-)
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle.c
>  delete mode 100644 arch/arm/mach-tegra/cpuidle.h
>  create mode 100644 drivers/cpuidle/cpuidle-tegra.c
>  rename {arch/arm/mach-tegra =3D> include/soc/tegra}/irq.h (59%)
>=20
> --=20
> 2.23.0
>=20

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2RvEMACgkQ3SOs138+
s6GpyA//Vx/ifjVN7GCkREIya9nFFTeAoC27H5LQZ5kvow0zD8roK0/nYlegdL0j
UsJ36dF2Kk/83wGicrFCVX5mDZHreIOT8W9sVt+VlsCYZ93z8afx+B6MPAx1Gnft
3HUcJrRkUX1wL5n0m+mN+Nzn79gNmhFLdlpXGy9esCcZrR2Rm2Ouf80ZKiSrumcM
txfhSEcK0uCIXU14Gc8ykSpfUpfUaN9A+5XnRx37Tl43AHJaugt5TQ92+ryWk7xE
5MhNJ5Vo7lB8uLn1X6afSpBQmTAV7W2Pou9bKr4yWjDrPUgjt7AP9NLPRmlsUjLV
P9sTfduBmvhpW5eETznIsdjbQL+ADr3zk1w442Yxt1mXlNRw+iN2b1slb4uv2Qie
eG5riVlyCFm63Or0EdMUo3jRrkfKPGViaaVAFGlgSgIszHc/sgC6AuiKnQqYsEkG
jyxGlhuFp3ah/POur8r/VefU1vsI8sCVXdRPhyPAPn5En++RpQ3nTdn2R9a1g7xq
voBpqkNThganApBrbpCp9O1ylqv46s3QH3LIfZaBdUnjIBMILVKs3udg9LIKDXkJ
jDhts6RKEB6isXmpCA7dCEp24+2ijc5gB4kwJ6YVTObFUymX1c7TX2KlPSLdh4Ao
KOEiHc4Zns7K085HqIgu7N3XQeUtUtvIgb/6xRTt+bFpo8eq3as=
=UqLp
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
