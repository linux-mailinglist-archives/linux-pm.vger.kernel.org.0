Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE7734549
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfFDLUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:20:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38607 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfFDLUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:20:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so15389510wrs.5;
        Tue, 04 Jun 2019 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3tUtjfLhbYiyXntb/3Ods4ivrBXswZB5toMPB77+VDk=;
        b=cJ7xH7EqPcxzkggsSnyNm/GhMn+l4djlTZEfYna6R9ODrkBvcss6zWeNV1vZnE5kF6
         pnJUOXGP8C69tSvxvs0bc/dmH3lGKlvuB9eUQCvlX+z3Sx4j+Fl2X8LYF3998SV9PiqS
         WYnO7xB10SNjC4yO4//Wen/wL50dI8wPj4FkOT8cO5Oqzt3+ub1o49FKLz7+B0uDzJEL
         +L4LZx9LiYG9cwwxMtfxx+H/A+Z6Q6926XAnlVvB/algbC3MJ2FDWEbFfHt5TjmfX0iv
         Nd7Ih6VhdwDdQRuTukIxkIytG1aQ3T7xuRE6vntdkmq9dcal2bKc9n2dyviKO75c8unf
         /pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tUtjfLhbYiyXntb/3Ods4ivrBXswZB5toMPB77+VDk=;
        b=Q8nRBATniRZ7t/+Zom94NpEAI9eMgAwvxj1EfTNs5M0LIz9JUCUSH2Sg9mBmRA15Zi
         /V/57XSSVtzD5zIQhMpKCCjDDPx7hOXRng4jRUZMYnX7nuGqVo01xDKmOv4SuOVHtrJj
         Yu5b9jHI1MoK0isDxlM9qgI0ESpEsIRO2cn4JLZ6dBmz7loAjBO1bxo6TDx5l2EWObEl
         ohVArTEd8/Qf1X5dTiQJYmytFczFnDn36KOyan2mdmaRCUwHNYcF0cFyOIUtAHgruFV1
         oMERQAzDlXSCO1fPUo9/h3W0LEq1eYmjVUW9P+C2ZJ0SnQkzGk+etQMAqWBV+IvEMMCk
         sksw==
X-Gm-Message-State: APjAAAUmXeCs5f+aZfHNL1YPYPYhzW9zEtMjMmwJhxIITXN4J8xdV637
        7uqnGk4Rs05kilT4k9aSWWk=
X-Google-Smtp-Source: APXvYqwenSyNT/QU8/NRwNmKlIHPGw4s+w5yMpF1pckaLKGi1eJlxgyLfh7BlhjMnVmjPi4soLuziA==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr6168872wru.35.1559647228499;
        Tue, 04 Jun 2019 04:20:28 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y184sm11165178wmg.14.2019.06.04.04.20.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:20:27 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:20:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/16] PM / devfreq: tegra: Enable COMPILE_TEST for
 the driver
Message-ID: <20190604112026.GN16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-15-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U6leaJ20qZQc29iB"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-15-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--U6leaJ20qZQc29iB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:13AM +0300, Dmitry Osipenko wrote:
> The driver's compilation doesn't have any specific dependencies, hence
> the COMPILE_TEST option can be supported in Kconfig.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 56db9dc05edb..a6bba6e1e7d9 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
> =20
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> -	depends on ARCH_TEGRA
> +	depends on ARCH_TEGRA || COMPILE_TEST
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.

You need to be careful with these. You're using I/O register accessors,
which are not supported on the UM architecture, for example.

This may end up getting flagged during build testing.

Thierry

--U6leaJ20qZQc29iB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2U/oACgkQ3SOs138+
s6FAvw//dyUsGtKs5mTTMtrTOsyA/yTph5TFbQxj6Ldz0Qe+yvt8q9UhJQrZ8Otr
fGKRedThgT/kV3BsBtgyy1KaPNRncN4unwk5X3maqZAL11pHfTTt8gKqWvEa3qvt
WdaZNZRzL6ltGvazChtYHgnJy/+U0CNEVpb2JdXKsns0WapnLfABvjS2nYzcNmYm
F6AqZjwSXF4uFyXUfzDiRLC6he8Ttgmrwrsz2OLdVNTRiGc1AMxd7NclevjxyHPA
NkjEjSIEI95DjCTqTzXynnFAPUPQmXoUo38Fa0eM/hBe02YzESE1W+MFXGYxWx7o
SGgRqvNPa3bH/bVs1o7izQtvAfNbIDqMEJGU/DXu058xy3ChZ/v9ANI/E3Yf0O8y
Kg0ux0lbTfx9B/Lju2nXYAQF1edjpdfSYKDvwRARZsWlsOsfjjc678S1jHRZ8P1u
8giEjfWwFRFgpZfq5cWBeO0i70Z/zBnl7osKKkMGRkaaWSepdR1gX+49vFXmCwjs
UAvcKMGYIr5OK3zi+WS5eZ3YtYQKmOzzSvgCMQn5W5nCi3T5k5pQ/hspX4ibu9w4
75BYN5E0NV0dVadCdNxI+C/v/5z3rsKUzf5oMxz4VTW/esqR8UZ/wS8T47LpAFIG
GFOoUzbeumE50C6Vch4QI90MqJiKr3CYhcmQe6r4Mbqhg787rtw=
=Fb77
-----END PGP SIGNATURE-----

--U6leaJ20qZQc29iB--
