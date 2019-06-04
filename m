Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906263455C
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfFDLX2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:23:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43491 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfFDLX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:23:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id r18so6389398wrm.10;
        Tue, 04 Jun 2019 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SNoBriGtulWIAhYyBf9pqGm79aHeYpTMVOEVBbSHuPw=;
        b=sjEVYk3tV6q/9PrJhe+JWVJG5CU9SMnUADd3wwof9scQ4osSL5yQ/T/DJNNlAHi3Lk
         Y7pWkJ3/nFUI6/qYs6PRDHFHOJXLoLhuaI7IuNbBdQr/6ZeGq2j8AzwogEza758ej8Hg
         hHV7l+Cf/fBo+953TyvAWnSCX9eSeS1YS2q4fvDran8jelJM5iqKAaByHbxA/cW+XfwW
         dh17Gi9Y1Dliq1AMZXYFlNltAAN6g4aiY33H2k/40b2z24An2S2sFm6/mD3NtEYSisFJ
         nmV5cdTmCavZy5OdbsdMKbkGzrVytUvG1KXgqQH9CEVRsNOxMF1itcNiUf+1Kx7F+/mV
         Mj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNoBriGtulWIAhYyBf9pqGm79aHeYpTMVOEVBbSHuPw=;
        b=gPNtowyF30RADM9B0Xehnkm3tfOiqu0MNzTR1JYmmH4H7jxUaHpC5x6gGJHIEkdR4y
         xcBycIHFcVW61JjOEMsgFFqNLdPmC1yOuRyaBDU67cumvgGjVbQ1iCGd7BTNHng6tJbM
         Z9w2J7exK28IeJKH3z4qZC+pUv1fFxua69VeqW3gToPq6QbD6MiyVnHoow4XU6o6xRGJ
         DlRqFmV+/IaPF6DjA9MRwR1Qm4NcsR8Neq2JgVp3aZtSl9FKImWlelRHdJHgde9DO4bK
         fpBuxHHejF//rOHkK+U/P5JEI6oTISu/p2UxLcqdc9SeZNODOAISQ99M5EeRuRwqr+YI
         PrnQ==
X-Gm-Message-State: APjAAAVqGCm9mh/iDBbFGZj5PdD0GV/nobPrd72+ObylXyljErlfhIFn
        PLRITC+ElrsrZugbanoPfnI=
X-Google-Smtp-Source: APXvYqyGA1ZeAR8qsKs7moX5AVbkC3MVoEY7Rjn0+Qu4aoxzJn7DyVRnSqBK9FoDpQHtfvALcy5rjw==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr5999121wrw.10.1559647405521;
        Tue, 04 Jun 2019 04:23:25 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z65sm23650387wme.37.2019.06.04.04.23.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:23:24 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:23:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/16] PM / devfreq: tegra: Rename tegra-devfreq.c to
 tegra30-devfreq.c
Message-ID: <20190604112323.GO16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-16-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctUzwJm0i+kwMBIK"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-16-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ctUzwJm0i+kwMBIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:14AM +0300, Dmitry Osipenko wrote:
> In order to reflect that driver serves NVIDIA Tegra30 and later SoC
> generations, let's rename the driver's source file to "tegra30-devfreq.c".
> This will make driver files to look more consistent after addition of a
> driver for Tegra20.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Makefile                               | 2 +-
>  drivers/devfreq/{tegra-devfreq.c =3D> tegra30-devfreq.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/devfreq/{tegra-devfreq.c =3D> tegra30-devfreq.c} (100%)
>=20
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d3f12c..47e5aeeebfd1 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive=
=2Eo
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+=3D rk3399_dmc.o
> -obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra-devfreq.o
> +obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra30-devfreq.o

Technically this changes the name of the driver. Sometimes boot or other
scripts rely on those names. Perhaps a better way of keeping backwards-
compatibility would be to do:

	obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra-devfreq.o
	tegra-devfreq-y				+=3D tegra30-devfreq.o

That way you can later on just add the tegra20-devfreq.o to that driver
as well and have them both ship in one .ko.

Thierry
> =20
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+=3D event/
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra30-de=
vfreq.c
> similarity index 100%
> rename from drivers/devfreq/tegra-devfreq.c
> rename to drivers/devfreq/tegra30-devfreq.c
> --=20
> 2.21.0
>=20

--ctUzwJm0i+kwMBIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2VKsACgkQ3SOs138+
s6Es9A/9Gi8I2G20qIVMJQ9sSA/3ZNS2aM3O4x2G2qQQFvuY81Q1MrPZ4OcGxElj
3I453R13AX/9UUzhKx4AxhjG+C22ZorezLuYM7AEZ6zDQB9vdJydreXBjOc+bpCP
mcUnFTFKzKJxCmyLxRtvGyh4RYwvRLmXHhbt7vOdlXv2wIGr+QanMCCTmEb4IIZF
ORe+lcro244KgDezZKj2L2ejTTVY3BVa2H5afLwxjnNr/mmv7sl2TVA97lOlrKjV
DFXET0ygtakT3UusMXM1dlGMaoG/Kf4iFaKwrNeA2nd4vli01P5ljiNVNZVK01mz
30BrBRZWywxaVwb4K1WJkkErFjjn+vTkIxzj0sVpTEW3Kp3pSjxqBrPULkLFCtxw
ldbvjbNBfVYy00rKffQqpZf+qajSM25n+jePFRWHBcn+VYtkRobpx1xv8jGehQco
I/woAOT7pqmf7bil2dbppIYXLWdFNpIZblLXPsfvDoCsqa0XlUqU91uoi/D7KAF+
ZsK3ypaajkXtaauOD+i4faDsSZ5m6fPBpQ6NAWriDGLHhyS69UNGEBPZxwuIGIa/
5xWn1tSS3jXlWYP4IrMUA+HGw7btVGden1mAZ24rmHT7PeL6qwId5wUjcXGo4kW1
JAQytoZkhY9UOEhkxJFjz8Khy88potwE9rPDs9fvS4T6jVoL4rY=
=bEO/
-----END PGP SIGNATURE-----

--ctUzwJm0i+kwMBIK--
