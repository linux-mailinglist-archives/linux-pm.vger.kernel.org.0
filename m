Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D828E34529
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfFDLPT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:15:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40863 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfFDLPT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:15:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id u16so9038646wmc.5;
        Tue, 04 Jun 2019 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zPFzmHYxVWGfcjIi5c7v3LhvCIeBieSiSPntUBB3SC4=;
        b=GY3nRNDL17ndRzjTCiW200nOhrbaIG+aE5U/UpONmeE1DwSQ/rgB+C76POxlEqOcPx
         W7RcA7H1Khz5dNylPal1q9VCNjGP5sAtiuUJim9oQe7hbNSImWIM6F5IwN8HzsnTXOGW
         F4A814XXhdD/uEaAYDdBkifOXamgRQLS6ekaeOTHvmiomE4imSsEGik4BxVL6FcuC2r+
         vLrEEyhGyDUNCK2HGinM6Lb75LQz2RW9Q5QrYN+1IPO8mUUwFycs7VXhOkrXcVcUpSPP
         7m1Yy/N3YPzw1lSP7GqQAvlu7aa6xzxtRHUvaqyWVPH09u41RIgrfZuuIZlp6+fQ+ZSv
         0f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zPFzmHYxVWGfcjIi5c7v3LhvCIeBieSiSPntUBB3SC4=;
        b=CVGFqDagqTY3Mo03BiHQcsI2DaaINKtykl7RZRfmSMoyzIncGqvYkqEW5HCYjc3SFD
         Vio/ofaAT9HgPCaJG2s8h+jMe2iVZz2ZlzO5oxCSMXgFSeYRvF0cg87Ffg446imE9Jx8
         JmlJVsZZ6SE4JVpTbUunR/WxJ2kFi8V691AVAI0j69DHcj2xrpFIdnH5k5CiRezCsvpN
         csG1uO8AmnU2sOBWgnoemfABNxiZ1bpA0H6Pj3hu7DVG+m+Q46hvk1bN5AkenbJiKdo6
         uUrnhCdeXHZqBAM/F6FaK2Qr3gSc+Ie3xlCMiO4puvPt/n9Aa/Y9j9BYJc8IsRtIhorB
         DhSw==
X-Gm-Message-State: APjAAAXltt/1Ac31OZzrHE515ue3FfHVsMOYQXm5BwNjx1I0sBhfaiCC
        sl0WH3VA3ET7d+Z7zvz5ynY=
X-Google-Smtp-Source: APXvYqxkiIujyS2MrCWkC3IBRS9ZRPIbwCIDm4A+1MI6Xw/H6pZf2eGYyVcAFLpqNXe/6SRNQe2lBA==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr17402289wma.118.1559646916831;
        Tue, 04 Jun 2019 04:15:16 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id b69sm13401811wme.44.2019.06.04.04.15.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:15:16 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:15:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/16] PM / devfreq: tegra: Mark ACTMON's governor as
 immutable
Message-ID: <20190604111515.GJ16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x0KprKst+ZOYEj2z"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-11-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--x0KprKst+ZOYEj2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:09AM +0300, Dmitry Osipenko wrote:
> The ACTMON's governor supports only the Tegra's devfreq device and there
> is no need to use any other governor, hence let's mark Tegra governor as
> immutable to permanently stick it with Tegra's devfreq device.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig         | 1 -
>  drivers/devfreq/tegra-devfreq.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--x0KprKst+ZOYEj2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2UsMACgkQ3SOs138+
s6FeHw/8DpennipWHJZs16Spe8PMpTRqUEUMRe1bA6x36n7C9dP3gYROw09b5ySi
a1Eea+j8bPt59BB3FRWjQbGVkiR4ckSWzbcfwNtAjk3ISpte8YzzQppnbgMaOkmt
SgAIhvFKKcC27260sSn0VSpWjU4I4ruXUO5Y52YcRrNdxBodObcV1AcTNrlZbrdd
S9rK9pQT7WAJfMjRAEeAbWQ5Vqg8PS4jvxPHygqUoZxmh3ZVTJLPsiASYfRt83TQ
7ynFRYWqi6JKyMw/S0dRUSKG38vZdeAQyeiPMdh3so31GItLD5Vwy3Hfpbrkiqg1
wFveOrtgQIonYmk487eWDu5EgqQUnlpDclU0XL5t0v0Y0lBpNm58G58mxptelK0I
cf8IwAtwucgEltpfFpxuOHOZfaKfS199gqlYAUlUVtZcrx/PDf1FNRDFDhAj5MZY
fnXevxW9x4nHx8DBoEsUufIfSbOIFUgff9I1VrqprtHY7X5f+t+S/5dT8oc+r8yF
03J7+unNywVR9y5I9tQMbgpnGn3Sb/vklqjU3Yik00cPyqaZG9khBftCJ4EpOe2W
c2rAosrAR19aiSoCNJN+Ttrwa8xvSXIj957e8+uocM0QNN9K/vU8HanC9iAFNCp2
Ea3NL3AhomKLeGF/gIEUX6FxFlWVqPZuISutPTHNujZQafevTXM=
=2pq8
-----END PGP SIGNATURE-----

--x0KprKst+ZOYEj2z--
