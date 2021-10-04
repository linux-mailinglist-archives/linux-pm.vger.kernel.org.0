Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C504217A1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbhJDTfw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 15:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbhJDTfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 15:35:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C38C061745;
        Mon,  4 Oct 2021 12:34:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o20so14733817wro.3;
        Mon, 04 Oct 2021 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AB8Fd9J5nhvmXnlzY+kN5c+dkvcRYSKSOLXBLG59XyI=;
        b=XeFwqG7tdttVUpvyAEa0+o4v1npEufRCff1blIOfzsQrFELlHPSGUoFCgz24eHt1gf
         QdncUEuE1qkGT5cMueFNKq+xM+/VfB7RvxF8SZ4L/JE4h88vZ1Tl2WlWSU+j0zTn7Lah
         vFPNs29D/7TeImyOP4yryWP/fbEBIn2nZg7hKXqH5REUTo4RI9m+310PeIPOSzhZFkC3
         +1TlgzKIhH5h6DQ7d4JYPumJv4rGUD6cr6FjNBi/+8UXGfrYZx9AchG9mD10zDZcibdL
         BplKzZbskj/dYOQ9Yd0Xo8QvXxeujUHzIrHdg3DhT+zSxNb1230oHwRt3BK3YHYZqhjw
         2AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AB8Fd9J5nhvmXnlzY+kN5c+dkvcRYSKSOLXBLG59XyI=;
        b=X+TilvxpTjeUCGJFAYeZOuL7TrEps1lghg++SQPNsoUQ1Bwo/7g2dckPlDQzFNbPNI
         o37Bkw68K9qiINP0+rvikhwF+fMthohNhlKmMOg7myuOEhFbU1oHziVHB43V3LPcnYXV
         kXnhQBECXiNERYSvju75nbuJ27fi9rjNkXccV4N86U0wcZnTKA6GoQ0cqm/cdudoSAWY
         rHHycNFJT2qY6XPNcps6hJXzsPs6JPkPgttZxNAw+wR5ce7JUp/unyg4S9ltMkRWNf//
         ARsVk5G8sVfxQY5OVeHYDmRNOeJPzsekzyA38sAJqjTsQ6ptzG8VTKExE8c8Iki5ewin
         9o7Q==
X-Gm-Message-State: AOAM530yL2xkpzIwtC/DK99eYY7KZ64LtlG1t7eSc2C5zzdSSLqO0yle
        MdBEhO+TCAm6qtyltvvz2Wg=
X-Google-Smtp-Source: ABdhPJw/putw+bmJUdvmmoLAQe6MqLM63VHbTKG2urlYRxiL22Rj2ibW6zx/tWGkt9CGdjOJ+5qxKA==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr16666691wri.338.1633376039737;
        Mon, 04 Oct 2021 12:33:59 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id v13sm12377769wrp.64.2021.10.04.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:33:58 -0700 (PDT)
Date:   Mon, 4 Oct 2021 21:33:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/6] clk: tegra: Add stubs needed for compile testing
Message-ID: <YVtXJVeK2qdy8E1q@orome.fritz.box>
References: <20210912202907.28471-1-digetx@gmail.com>
 <20210912202907.28471-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GQheADiyYuC4Rye0"
Content-Disposition: inline
In-Reply-To: <20210912202907.28471-5-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--GQheADiyYuC4Rye0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2021 at 11:29:05PM +0300, Dmitry Osipenko wrote:
> Add stubs needed for compile-testing of tegra-cpuidle driver.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/linux/clk/tegra.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
> index d128ad1570aa..9bd06d8a5436 100644
> --- a/include/linux/clk/tegra.h
> +++ b/include/linux/clk/tegra.h
> @@ -42,7 +42,11 @@ struct tegra_cpu_car_ops {
>  #endif
>  };
> =20
> +#ifdef CONFIG_ARCH_TEGRA
>  extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
> +#else
> +static struct tegra_cpu_car_ops *tegra_cpu_car_ops __maybe_unused;
> +#endif

Ugh... this one seems a bit over the top, to be honest. The only place
where this seems to be used is in arch/arm/mach-tegra/pm.c, but that
already uses one of the stubs from include/linux/clk/tegra.h, so I'm
wondering if we can't define that latter stub in a way to make it
unnecessary to declare this bogus pointer.

I'll play around with this a little bit.

Thierry

--GQheADiyYuC4Rye0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFbVyMACgkQ3SOs138+
s6GkhxAAtIARHiYgA2/pVU45dG9aJo+1WHokbkY3gjuqUUg5EwVeJ4pIs2mwuZDx
UnvdoMLP58u5pQUzrEP9j4eaH9QeFdS4TnAFX036ooD36l8xDqseDFL0Y+wEd/JD
FBzJiBYZKBfKJcK+1+jZjpo1k1BiQE9Okv5NtxGxRQv6T3YMXoVAYTDUXTNX1zNO
Ufiy7iOZT8CfdNi3S1QwKSD/RqO9c9ZR9gnFTfXuPfLrDN8nSduu0QO8tZDaBYsT
Qo1oC/x9ZMLglNE36B8wdIW685UUjjP+prLJD0IZEV6hrEHaE6tMNnhB08GtrnIn
FvHZPNXJyvoI7V7h/3PKX7g587KOvcVVWXMSMN8ZIbhOgen9VUi7vd4wAD960Qgl
4BIOu6J7JVVB9xZF9tvYh4U4oNmIs0Y2U2zRyZ08HjxTiS1UQjVu4M8AtS2AxTGl
OJDmoggAzQJIR/tiDSLG2fN0dMfqUo7j47VHFu2+MlJFa2qCBvuq1S4aRljWHlUu
F9uKfKoItxyB8eq+Agno2dRIiYNdBv3wvucTyR8eu9dyH5LzTdXx/zR2OX4rI57y
dU88jvymbXmaNplJP5qS+PgXq3p8VP9nVkGuMhhN1lW8o7agJDLpWFxgxzgSapxL
fcmYQlIdcjd2QDjvMbrvmBOVNDeV1kdK3GpZwAuaTwhQ5n6vp44=
=O9GU
-----END PGP SIGNATURE-----

--GQheADiyYuC4Rye0--
