Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4B3E8D79
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhHKJrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbhHKJry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 05:47:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EDFC061765;
        Wed, 11 Aug 2021 02:47:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m36-20020a05600c3b24b02902e67543e17aso3449060wms.0;
        Wed, 11 Aug 2021 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/50RZhI1+HYZXoTkYGUW7jpTP3tDgMGWDF5nGMrgbE=;
        b=boKFJXAcnB/f2IhrphvG693kYgN3xOKCpq7l+H22gOLKtyBknfg5kGaly1k6u0xIXb
         BFkfbM10WfK1nK5GG6YOXpfnt7WmaYIxSDjekvU0j9H+AJbKQk2Lvg2o65hoLq5X5/gN
         UUz4KayTVlVR0k0I0D3QbJTd2njWZQhqb0mQmRbe8wwMQvG6z2xkT9GVqSv+UKnV4bDP
         511c96jaDh11dnS4SNYV3etxN8Vcd5yEJsuINEcWPIFbmUAYpe5aNRJ5Ta9cRigsm1rl
         t1mGJoCPTVFO2y5SWIgnLKEAA7h4tyVmJi4hkns52wqYoT0XHqA3GI18Hk7+40K9lyw1
         6Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/50RZhI1+HYZXoTkYGUW7jpTP3tDgMGWDF5nGMrgbE=;
        b=b6F363udYXZd+GpFBFFgsI30ychsIrHYimglpLN5ieTHBwjwh8xuF9P1O0LKo4fAP/
         0GJD4lBORljVqKZbHxBkxR6TmH0DCUQzDemBVdazNxfGOqKb2EMFXVGR6rwM2zySSqzf
         ZaF7n/hogx9v37M+dkwLJSz4FHq89hX56L72VHlfJpKRTMQ96N5ldcsroXleiG3rsSmU
         lADNZa6a1DmLCtp6bTFxtdUHjTmBx6vV83n6M22+RS3ZfsDX40TuDWNRjIwQgbo0PeBs
         ecnAX1gWsaZx/Z8vaTIB5pNX1PHzj7YDRdcWIupJxnCQhMcCwc5gnDuiudkOtiXJ8LS/
         JviA==
X-Gm-Message-State: AOAM532uux3aUfb+6dzygSjQ9+8mAZCTNXphvVLaomLnh11sKiZ3ZyEh
        aUQVzePCLRvjWpP1PjoipFg=
X-Google-Smtp-Source: ABdhPJwsPC6MQc/AIkHMzaTLik34/rJmcUUmAgL+QcxYllVVjnX7CwcgpitkBoJgoeDV6L60Y+hBdw==
X-Received: by 2002:a1c:7214:: with SMTP id n20mr13556931wmc.181.1628675249813;
        Wed, 11 Aug 2021 02:47:29 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id o17sm25849916wrw.17.2021.08.11.02.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 02:47:28 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:49:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] cpuidle: tegra: Check whether PMC is ready
Message-ID: <YROdQXO4aVLQ8DkP@orome.fritz.box>
References: <20210718212706.21659-1-digetx@gmail.com>
 <20210718212706.21659-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zif2I7f2WOnASNh"
Content-Disposition: inline
In-Reply-To: <20210718212706.21659-3-digetx@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2zif2I7f2WOnASNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 12:27:06AM +0300, Dmitry Osipenko wrote:
> Check whether PMC is ready before proceeding with the cpuidle registratio=
n.
> This fixes racing with the PMC driver probe order, which results in a
> disabled deepest CC6 idling state if cpuidle driver is probed before the
> PMC.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 3 +++
>  1 file changed, 3 insertions(+)

Rafael, Daniel,

would you mind if I took this into the Tegra tree? It's got a dependency
on the PMC driver, which usually goes via the Tegra tree already, and
there's nothing cpuidle-specific in here, it's all Tegra-specific
integration quirks.

Thierry

>=20
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-te=
gra.c
> index 508bd9f23792..9845629aeb6d 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -337,6 +337,9 @@ static void tegra_cpuidle_setup_tegra114_c7_state(voi=
d)
> =20
>  static int tegra_cpuidle_probe(struct platform_device *pdev)
>  {
> +	if (tegra_pmc_get_suspend_mode() =3D=3D TEGRA_SUSPEND_NOT_READY)
> +		return -EPROBE_DEFER;
> +
>  	/* LP2 could be disabled in device-tree */
>  	if (tegra_pmc_get_suspend_mode() < TEGRA_SUSPEND_LP2)
>  		tegra_cpuidle_disable_state(TEGRA_CC6);
> --=20
> 2.32.0
>=20

--2zif2I7f2WOnASNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmETnT4ACgkQ3SOs138+
s6GfmRAAtIjuR58BgpKR9AFQHqWiKRZkr0hImMiksmT3JDKPG8pQqNoSwta1c35m
M9/4OQvR38jsc6egWNF3Ed/t8egKsyDvbbkJdCEQQEUT0fL5mQNFAkDnXBxjbQ27
twRa5sG5QH77LUP26Tb+J79lf92fRux0pYuSkeZU3viroSmtBGsH78OSi3TYhPE8
OVWr/PHxllWllnB5YJXXOJ3n22JQpmvuUVhPT0Eipn1PArLsyv+joLBveLss+dsF
IAcwtI69bich207WwIiCkTQAFjv71WnL9b1hEpTkQpNiPgWd7EcS1mOv6vEL5FGT
Nj0b8EVcW/8CnFXz67TVZmABUr79Sf2OCiNUKoCtJpUhdYlzwUkFxmetz+acXnr5
R3bW11Vsgo34iAJ9SthyqKC76/9TsJJaL8QcPGWKeQ5LIS91zWs/JFfhhzvT3hVx
zYuqWtCHqAEh+LG8gqjorFqcQkuFeC5HFe2yun4JebZLfNtH/o1t5jly1Up2oNe6
6/tP2H6Cuod5F/gHaTOCDzNjGnKqWvXNldabttnV4zo53maWYVB5FID2jgucHixl
FCv/Gmy5P51s+lNBUZpHnjgM3RWmZ2CfTOjJUqZW0nE0zfzoFwQlI3pAAVJGQDDq
jpnrynyZD8LPvVVjlxRM/RrxFYQVR5KWCfhJHLc4j7A1vdZme+k=
=cB82
-----END PGP SIGNATURE-----

--2zif2I7f2WOnASNh--
