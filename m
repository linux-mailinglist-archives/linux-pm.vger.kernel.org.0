Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB5839DDBE
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFGNgb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 09:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhFGNga (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 09:36:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE57C061766;
        Mon,  7 Jun 2021 06:34:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so5921997wmg.4;
        Mon, 07 Jun 2021 06:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=72Aq2IRVVuAlG+BxVmjLTJ3arbYuvMQ1+eZPQ9a8xXQ=;
        b=oxZD6Zqnln0Io1phX+iliNpQP3rcAd/5VPQ9pTnnOMQV5bYbKZkH6nrKJjiJzXEIWy
         CTKE16jnk5MIGtra3WVZjd6Kwpfq+ZqkT+5C9HCfYJeMLmh4OBTknBSIGvOaoX4CTHRR
         VqteXdoHhEZ5fm5+PQ/Hnb9DbSKqYA7INxn6AOvJaGR4OUMyY9aR5e9pirME8dTs2120
         AWO6y/0LB/Wgq4kVQQTucfpjfwuqg5CNuJvcaYbYbSbxJZ1B6y6uxU4OZkJ62IveuqPM
         hc4q4Kbz9cRK1/mn1L5D0bAUE/3JuyvAbIsGNhEIHNs9kuem67gHHnWS/6iAUkxw+j4X
         WaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=72Aq2IRVVuAlG+BxVmjLTJ3arbYuvMQ1+eZPQ9a8xXQ=;
        b=igu8TkOolpPHKkq4WWMoLBFLRNERX1XVWKxMPoB28YppxBnmvAjt+tCVDdLEw2rgqZ
         EVAIuBa7opmg3NBI1qjYDloG8ptI3PmamZUBYOT3MON1IB/hOHPhMURdmdLVsZgz19eE
         G82ud3slyJ3hfYAhgohCABzvz0vUgGljLs5S9A1zXc98kbymkUD2sGwZixkMVNQoMFa2
         YIG3LwPErhmWCfKbu7oZke4L4de+15dipTLY9ScPqGW3tuLTwysHAvEOZD+fYiRxqNx7
         xNyOH4cntzQoByHhyT1yZvq+JK5ihnvmD7Z9xwO3n32Q3vICdO6YaauByrljiJIJBDK9
         H/OQ==
X-Gm-Message-State: AOAM533pMIcu0csq4WvM8sILZL3LmdPKYHMksEqe1k5DXe2/J6irJio7
        O2ubA93jrKFOtuwk1MJ64zg=
X-Google-Smtp-Source: ABdhPJx78Hb1ow2zyDK514tMIszmaR8bb/TUHyENVmt1hS7sq8OY1P401AE2jjgHMilCoFs70oRWyQ==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr17077892wmj.46.1623072864255;
        Mon, 07 Jun 2021 06:34:24 -0700 (PDT)
Received: from localhost (pd9e51d70.dip0.t-ipconnect.de. [217.229.29.112])
        by smtp.gmail.com with ESMTPSA id u6sm17359575wre.76.2021.06.07.06.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 06:34:22 -0700 (PDT)
Date:   Mon, 7 Jun 2021 15:36:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nikola =?utf-8?Q?Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 08/14] memory: tegra: Enable compile testing for all
 drivers
Message-ID: <YL4gwxWopKT7LomG@orome.fritz.box>
References: <20210601023119.22044-1-digetx@gmail.com>
 <20210601023119.22044-9-digetx@gmail.com>
 <41899ef4-bb16-6c3a-035c-1e840a993bec@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aMbWj/kSYVzrzPWY"
Content-Disposition: inline
In-Reply-To: <41899ef4-bb16-6c3a-035c-1e840a993bec@canonical.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--aMbWj/kSYVzrzPWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2021 at 08:01:28AM +0200, Krzysztof Kozlowski wrote:
> On 01/06/2021 04:31, Dmitry Osipenko wrote:
> > Enable compile testing for all Tegra memory drivers.
> >=20
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/memory/tegra/Kconfig | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >=20
>=20
> Hi Dmitry,
>=20
> This fails on x86_64 and i386:
> https://krzk.eu/#/builders/38/builds/260
> https://krzk.eu/#/builders/40/builds/261
>=20
> /bin/ld: warning: orphan section `__reservedmem_of_table' from `drivers/m=
emory/tegra/tegra210-emc-table.o' being placed in section `__reservedmem_of=
_table'
> /bin/ld: drivers/memory/tegra/mc.o: in function `tegra_mc_probe':
> mc.c:(.text+0x87a): undefined reference to `reset_controller_register'
> make[1]: *** [/home/buildbot/worker/builddir/build/Makefile:1191: vmlinux=
] Error 1
>=20
> It's a defconfig with:
> scripts/config --file out/.config -e COMPILE_TEST -e OF -e SRAM -e
> MEMORY -e PM_DEVFREQ -e ARM_PL172_MPMC -e ATMEL_SDRAMC -e ATMEL_EBI -e
> BRCMSTB_DPFE -e BT1_L2_CTL -e TI_AEMIF -e TI_EMIF -e OMAP_GPMC -e
> TI_EMIF_SRAM -e MVEBU_DEVBUS -e FSL_CORENET_CF -e FSL_IFC -e JZ4780_NEMC
> -e MTK_SMI -e DA8XX_DDRCTL -e PL353_SMC -e RENESAS_RPCIF -e
> STM32_FMC2_EBI -e SAMSUNG_MC -e EXYNOS5422_DMC -e EXYNOS_SROM -e
> TEGRA_MC -e TEGRA20_EMC -e TEGRA30_EMC -e TEGRA124_EMC -e
> TEGRA210_EMC_TABLE -e TEGRA210_EMC

Ugh... that's exactly one of the reasons why I dislike COMPILE_TEST...
though admittedly it does point out a missing dependency here. I think
we need to add && RESET_CONTROLLER to that || branch of the depends on
to fix that. ARCH_TEGRA selects RESET_CONTROLLER explicitly, so the
COMPILE_TEST branch needs to mirror that.

Either that, or I suppose we could add the depends on RESET_CONTROLLER
explicitly to TEGRA_MC, or perhaps even select it (although that could
cause conflicts down the road, but should be fine right now because
RESET_CONTROLLER doesn't have any other dependencies right now).

Not sure what to do about that orphaned __reservedmem_of_table section.
Maybe all we need to do is to select OF_RESERVED_MEM from
TEGRA210_EMC_TABLE?

Let me to a few test builds.

Thierry

--aMbWj/kSYVzrzPWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC+IMMACgkQ3SOs138+
s6HeDw//bUmVhBYQZAdR05dHVxNlK483hLerAbOIp/XZHKTPYqPuv8Awx4UPiYWI
tuKqP9WupRe8cBtKVxslslOpFIktT1ewJx7/lODQre4FU/qsID3MqGl9rsGWnRRO
QGRdXJM0GTF7Ysy8Su6rM8qshfnBqgo71DgYC7QZdNLa0XFThnjmfu+fYMo9VTZN
j6WjB3DcbY4SkXGsECgwmFkrQD2WomJR4C4aPaujp4QND7I7O6RpODJrjTDj2t+A
5nwFhQXgCb1mKh0aivRj/FVNQJ1MZGoIG2TXmyETPbELkbCKi/uUJa2AfPEOF3J0
XlhlIwOPyOYb2hJt4ijIvU+emlM9CYR5aY2vUMiIF7Euz+n5yyTgxgk1zF/6QFGr
gCIqoMXcmG3BbvsNRRSpsco2LKrtTcPNtEQwKsV00lhrzp1Ez8x3XNlyyEm+g4L6
I3xUGzOpPqxk2O5RHX8oqyh2BW9Dk6o38wZmPdpMjdvsdjuqG/EbzB68mDbt9hPo
I7WSJLVPwdk+Jb+VfS28OrW0CvpR50HEBFoxbDbwmnOt8Ba5iWHSBUTalEhSOd5G
a9WPFqioVzPuTGHxB1bxogH8B5V2AgzlPR7WXZCAGzvWbd9j0+7Akje6Lvjtv2Sq
O9tm6FoPxJ9MBSL9SW5gfNLB8Y7/Sf/pqdPBzQpt4as0c+hT4+o=
=/jof
-----END PGP SIGNATURE-----

--aMbWj/kSYVzrzPWY--
