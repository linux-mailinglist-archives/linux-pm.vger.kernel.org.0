Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E21C775D
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgEFRFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729414AbgEFRFM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:05:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145DC061A0F;
        Wed,  6 May 2020 10:05:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so3076809wra.7;
        Wed, 06 May 2020 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3x0uOI1BgySr4JAhryI/+ahsj3uZRjc+tpO/+35ZZwM=;
        b=Rgc7eSgJ+cqlaFrG9r5KSSCvjShNUu/8DSZbN8gI8P/1tuUWmgS+GTNh8XOlgSpfIb
         hI90vv6rQOPGLNIPE3iDemjFkSKLOa0yiT1y2J8Fa93JPIA+MLml+Xwy7JfTjPRKetQg
         1qclsBZFdjsCDg9AjerK1wjbNvXTaxS/y9YlGx1ryJJ4FR9MrvtXZjk0uci26KAuNsDO
         K08kZWBfXsZXqBUGgnsdj0GXTziUvmI0Qp8Rx8QZJJZoTJA+1Fgww+c7hs2l1/Xwfy8H
         vXvFD0gXJMEvinG6pZa+W8CIdWs9dCAWwUSFrc2aCGGyLz1PK7RSn2GPW6RKoTI8CABg
         qdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3x0uOI1BgySr4JAhryI/+ahsj3uZRjc+tpO/+35ZZwM=;
        b=BaUru9fQk80BQukvkSFKzweLUZqZo6A9p2vSYgH4F8MA5ONCfs4OYzJCAn12PNFgIE
         3LKdKSVXZeCR/qGrqyDkN3dFAoLPgxeKnmEPTqrKaeNSOjsdkgj401+N8PzLXk7fhGwB
         ckZdgx0EOyTYS5EhxKbqWMm6OVQ5uXcyrdwdFClPZH2dYClvTzQJ7eecZTvjM2wj/6QX
         85ixt61zIet5xxexkxfHhpREgiG7cxqtxSpTCUEoOUwoZ3eNGHRv6Zc+jG/EWibr6RHN
         Mw1z4fNvTcCJ3mPGRkcROQumkZTe3FjBlpLFSUZFiJd6AUAjOxSw1HbujQMdK1mXfy+f
         /A/g==
X-Gm-Message-State: AGi0PubTvAnZ64huk+nU4313E2eBynLajgop9HZvlgkmWTM0++pfWosQ
        T608kS2lQ90wwki888Bl4oqfyH8P+0E=
X-Google-Smtp-Source: APiQypIC+CI7iz0lwgrPCobaoNgtlY8ZcMXxo8iAjROexajFRgzSeVNvOyjJva4yc4ljkdQ68oMxBg==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr10557540wrq.14.1588784710844;
        Wed, 06 May 2020 10:05:10 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id 5sm3872042wmz.16.2020.05.06.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:05:09 -0700 (PDT)
Date:   Wed, 6 May 2020 19:05:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/12] NVIDIA Tegra20 CPUFreq driver major update
Message-ID: <20200506170508.GE2723987@ulmo>
References: <20200319190229.32200-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 10:02:17PM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> This series moves intermediate-clk handling from tegra20-cpufreq into
> tegra-clk driver. This allows us to switch to generic cpufreq-dt driver
> which brings voltage scaling, per-hardware OPPs and Tegra30 support out
> of the box. All boards need to adopt CPU OPPs in their device-trees in
> order to get cpufreq support.
>=20
> Changelog:
>=20
> v8: - Rebased on a recent linux-next because Thierry merged the cpuidle
>       series first and now there is one minor conflict.
>=20
>     - Added tested-by from Nicolas Chauvet who was one of the first
>       testers of the series.
>=20
> v7: - Added acks from Peter De Schrijver.
>=20
>     - Added tested-by from Marcel Ziswiler, Peter Geis, Jasper Korten and
>       David Heidelberg who tested these patches on Apalis/Colibri devboar=
ds,
>       Ouya, TF300T and Nexus 7 devices respectively.
>=20
>     - Rebased series on top of recent linux-next.
>=20
> v6: - Dropped "cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 =
SoCs"
>       patch from the series since Viresh picked up that patch separately.
>=20
>     - Added two new patches to this series:
>=20
>         ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/=
124
>         ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
>=20
>       Previously these patches were sent out separately from this series,
>       but it should be more consistent to include them into the series si=
nce
>       they directly relate to enabling of the cpufreq driver on Tegra30.
>=20
> v5: - The "Use generic cpufreq-dt driver (Tegra30 supported now)" patch
>       is separated now into two patches by factoring out the blacklisting
>       of cpufreq-dt-platdev into a standalone patch. This is done in a
>       response to request from Jon Hunter to fix the warning splats during
>       boot that are coming from OPP core because OPPs are unavailable. The
>       OPPs will become available once tegra20-cpufreq driver will be upda=
ted
>       to support the cpufreq-dt.
>=20
> v4: - Updated CCLK diagram in the "Add custom CCLK implementation" patch.
>=20
>     - <linux/cpu.h> is now included in the "Use generic cpufreq-dt driver"
>       patch, for consistency.
>=20
>     - Returned value of get_cpu_device() is now checked in the "Use gener=
ic
>       cpufreq-dt driver" patch, for consistency as well.
>=20
> v3: - The "Add custom CCLK implementation" patch was updated in accordance
>       to the comments from Peter De Schrijver. We will not use the clock
>       skipper.
>=20
>     - Re added OPPs for T30 Beaver board because Thierry has that board ;)
>=20
>     - Added r-b for the "DT binding" patch from Rob Herring.
>=20
> v2: - Kept modularity of the tegra20-cpufreq as was requested by Viresh K=
umar
>       in a review comment to v1.
>=20
>     - Added acks from Viresh Kumar.
>=20
>     - Added tested-by from Nicolas Chauvet to the "trimslice" patch.
>       Nicolas told me on IRC that it works fine.
>=20
>     - Fixed compilation of the "Add custom CCLK implementation" patch. The
>       error happened because v1 was based on top of yet unreviewed/unappl=
ied
>       patch "clk: tegra: divider: Support enable-bit for Super clocks".
>       Thanks to Peter Geis for reporting the problem.
>=20
>     - Replaced Tegra30 "beaver" board with "cardhu-a04" because turned out
>       that's what NVIDIA uses in the testing farm.
>=20
> Dmitry Osipenko (12):
>   clk: tegra: Add custom CCLK implementation
>   clk: tegra: pll: Add pre/post rate-change hooks
>   clk: tegra: cclk: Add helpers for handling PLLX rate changes
>   clk: tegra20: Use custom CCLK implementation
>   clk: tegra30: Use custom CCLK implementation

Applied to for-5.8/clk.

>   ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
>   ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30

Applied to for-5.8/arm/core.

>   dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30

Applied to for-5.8/dt-bindings.

>   cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
>     now)

Applied to for-5.8/cpufreq.

>   ARM: tegra: Create tegra20-cpufreq platform device on Tegra30

Applied to for-5.8/arm/core.

>   ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
>   ARM: dts: tegra30: beaver: Add CPU Operating Performance Points

Applied to for-5.8/arm/dt.

Thanks,
Thierry

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6y7kQACgkQ3SOs138+
s6HkfRAAnqVNjXF+MUQ97q3hoKS/cJkVfNxJMHxvr3vdibV/jEzw02C4pFTiXLUI
5bDlLr1I8SGVkSgaDYLq5ynvPwHaUtHZRUN15glFAm0iWHgga/OgKuMWJeQTwk5p
cmMVFyNuuTMftYpGIE4tmSTXQmwHej1NrjUWrR0sJSf99MP9nAAiUd/3RC3s00bg
OawwgEG4VDMvTuVhOIZNx1xDr2ZMbK81vChCLrI0ZIjvFoedmlR1AKheQ+io84Wf
85WeTTcLc4XcciGhE3cnmp0DEtib+WNmDYF6uZujvcX/Z4GbhgXZOzXLi5LQUY6f
2tuKez7A7LNhv7P4ix3VXRYwYlglhvkQagTpCjsqJKpZwEDbdVrvL0MWUcaIMmLW
VQ7T5y9j7GAYlza4FFzJvttJmQob5GH9lho4eKJXeSRNAtOLnR7iPS8JyAIBrMaR
8t7lRBjhcRwdllyAkvTtRlxwNavpvD2MkXwAt+pwIu1evSZIrSVQ/OIX0NWpxakn
KcgM/0/w3fzCbNH0/fTbYV/+wGRtIj045Qqh9X7RVXlv5Z/gEMj1HFejsF/HYzKS
MPAS9ykMwaMkfgb1d/Oe/j/fCkyyozewLnuXVKxjzLfc4YYtWhAs5Z/hjN0xLQnk
hAjvAmlDHOsGrdwHloNDl1IC7gTi72YDmixLhAyE0gCcnWVfjCA=
=H93k
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
