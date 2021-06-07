Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A502239DE84
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFGOUK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFGOUK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 10:20:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54162C061766;
        Mon,  7 Jun 2021 07:18:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso12854123wmh.4;
        Mon, 07 Jun 2021 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mP6aWH2JsVa1KbPO8ptw+xPekYdfORcg07rO19MO1nI=;
        b=iWwqA2UiiOytGSvgxV4BsphhYNrSbsS0zszvUB9s5j0NSax9HYzjumozJX5WGn8k4P
         KWkZ7GTvswNLDHEYOZ61FY75YsE6JJsfv+ESIQGRQQz7x7MbYKP3TGWC/jzHqIafPtNp
         KO8Dywn/x5VwmE57Z1nfFmol7mQzb1tr68GLoAKEPFDAowq7J2tYAQfuGRHnGMrpw9N3
         ZGHBF0G3p/fjxYAlso57pzWNi02xXQ4f9y79KTp7bSw1J2w39S7vNj5isD1QAAD6MkOv
         R0hL/dRy3n/qyArMsHynBWNvN6cOeug80cBY2Qt8m6rPXY5DTrz9VeYH8ib05e+2j9o0
         MegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mP6aWH2JsVa1KbPO8ptw+xPekYdfORcg07rO19MO1nI=;
        b=B0dNaFBgHL8nlRC2ng3OYOrILiqjKaTdF4lScxxtN2mQPoytT3gz2OCGTa7iaP6iUG
         dRPwffD25Sz9v2seC4XWfZHmbojigGgZFm2LifjRp3AUTg++8S8tChDOFawcT9OYysZe
         z4GUqYoSB86ldeMKmTXzpBH0su/BpNJc36Jhvl+EE8SyDhymRH5jmuxKk+opy8xqBi00
         kP4AQGqOJQ1FKK+ItE9kj6b8k8M0h9uqXIrdxXyXWGR3kd4TUg/IFtDBwpeHpRUPC45D
         epIcn2ZV6tNBXdTbR2zfAG+goF1vlF7NQgz6nSVyrAvxXZK7dxpokQasMS6VoVlMEYOX
         o8xw==
X-Gm-Message-State: AOAM530IN+fvy2+f8s0/bs2sWOmWBNs+BRpZ01Cn806XVHoQIPcBVpuC
        TgLa2wKFOJoKjRKoRCISfx0=
X-Google-Smtp-Source: ABdhPJxxHpTEw550CvQ0yBAx+uTU4KURTY7SABRasg2WbIBriTFGz4abTv+C8v8dtGyfuCSRKIwMYA==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr16894362wme.40.1623075490904;
        Mon, 07 Jun 2021 07:18:10 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f12sm582862wru.81.2021.06.07.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:18:09 -0700 (PDT)
Date:   Mon, 7 Jun 2021 16:19:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
Message-ID: <YL4rBYkWHpeit66m@orome.fritz.box>
References: <20210601023119.22044-1-digetx@gmail.com>
 <20210601023119.22044-9-digetx@gmail.com>
 <41899ef4-bb16-6c3a-035c-1e840a993bec@canonical.com>
 <YL4gwxWopKT7LomG@orome.fritz.box>
 <a1f20257-f041-966e-c37e-5c81c4cf94d9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d9Zh+1lS8Af2vnFR"
Content-Disposition: inline
In-Reply-To: <a1f20257-f041-966e-c37e-5c81c4cf94d9@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--d9Zh+1lS8Af2vnFR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2021 at 05:01:02PM +0300, Dmitry Osipenko wrote:
> 07.06.2021 16:36, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> /bin/ld: warning: orphan section `__reservedmem_of_table' from `driver=
s/memory/tegra/tegra210-emc-table.o' being placed in section `__reservedmem=
_of_table'
> >> /bin/ld: drivers/memory/tegra/mc.o: in function `tegra_mc_probe':
> >> mc.c:(.text+0x87a): undefined reference to `reset_controller_register'
> >> make[1]: *** [/home/buildbot/worker/builddir/build/Makefile:1191: vmli=
nux] Error 1
> ...
>=20
> > Not sure what to do about that orphaned __reservedmem_of_table section.
> > Maybe all we need to do is to select OF_RESERVED_MEM from
> > TEGRA210_EMC_TABLE?
>=20
> Select won't work easily, but the dependency for TEGRA210_EMC should.

Select works if I also select OF_EARLY_FLATTREE. That's slightly odd
because typically that's something that the platform would select, but
there's precedent for doing this in drivers/clk/x86/Kconfig, so I think
it'd be fine.

The attached patch resolves both of the above issues for me.

Krzysztof: do you want to squash that into the problematic patch or do
you want me to send this as a follow-up patch for you to apply? I guess
the latter since you've already sent out the PR for Will and ARM SoC?

Thierry

--- >8 ---
diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index f9bae36c03a3..ae8c57b921e6 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -4,6 +4,7 @@ config TEGRA_MC
 	default y
 	depends on ARCH_TEGRA || (COMPILE_TEST && COMMON_CLK)
 	select INTERCONNECT
+	select RESET_CONTROLLER
 	help
 	  This driver supports the Memory Controller (MC) hardware found on
 	  NVIDIA Tegra SoCs.
@@ -48,6 +49,8 @@ config TEGRA124_EMC
 config TEGRA210_EMC_TABLE
 	bool
 	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
+	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
=20
 config TEGRA210_EMC
 	tristate "NVIDIA Tegra210 External Memory Controller driver"
--- >8 ---

--d9Zh+1lS8Af2vnFR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC+KwMACgkQ3SOs138+
s6GzBg//RConUScfmllWbC3RRw9aeJFxXHvtCSPDMWkFY4sn90LjxMo3Es5noyKr
rFb8YNtCTs6nGvD6ShITplTVfCOnTLwiezOUymN5R5+Wlm7gjWefHp3AaPEWAF74
oKVjhBxUID15IpgPyJein5EUFbNh9+Napbtm1CmOKvZELa4EW0rYji3ypYunjdvt
kRVnSdGSq302YvlEVilkcczDeaq9TnkpRHf/V8iV6UG+HAN0YOJjHGag5U4lS/L3
2KphggZb0la3tudDo/IbYYVL++B4deLZapifKd0TTTh53yDWX1aafgI6wCGAwaIs
4MMDD/fGA9XZIQi7GpCgm8iEwKeubg+b+p4VdBssvWxpziT6MnzvVtiqTPY3e0nN
rnj0MrW8GOL3tjA4IASNvW5i11cCLJBeZALhNc0cOdwE+/2nqEnqWoZVia5ECNCp
odVA+MRQj5Hawh0juKyba82UB9hVYatcDzW+EIohErHPp0HpUg98WclOH3lNooJm
o8RW/yV74toyi24b3aTDeaznn/QEJM9BBpa5Bq5mtuVMtK3WBurSDUqT9GPFDGFY
T+YFmVAXe1fTx8OREgedCibMqTqD4s9FRKSrv8q7AHE64hr7ZoofEty3MVVdNZ9x
nNmUbQaS3jUHQgQq8OgZkPY1ngBmjkRJbIsFYr2LlsBhHU4OQMc=
=ygu6
-----END PGP SIGNATURE-----

--d9Zh+1lS8Af2vnFR--
