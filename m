Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3929AD0A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbgJ0NRz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:17:55 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42171 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441417AbgJ0NRz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:17:55 -0400
Received: by mail-ej1-f67.google.com with SMTP id h24so2155958ejg.9;
        Tue, 27 Oct 2020 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGpkeOfJT8udzeeIP4D/m8toDPn+ozlWLbY7PJ5zipc=;
        b=PsNia79cOr0HXyMjtoBqTMfRZXSgpo7wEbpHhVjyO9Twd9DSmEM3Hl84UaG/uw3sqc
         1LfAfh6BzFS8ZNmoFyerno7f+Lglr1jTDW3AkIyHWzXi5F5PvBQ8PD2cCAtmLLgZ8A2D
         MFaO5+AJ0NArVLX4FbzPMZVfm4Fx1WEw7j2pp513V6EWviR7Ipn4znFKJ0gVJTjjArQa
         PUmlExVC6tFALpenIG/SMKdmTivjOLUPgt1sVX4mqR9eSvSStAmKn6Cw7HaqGyuoTLkD
         smZ4CO5Vw5fWgli6tY6I6NPn2pILXadp/7LRXZZE89cgtmDsrIykazj9sJy5VoD/zoJw
         TjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGpkeOfJT8udzeeIP4D/m8toDPn+ozlWLbY7PJ5zipc=;
        b=eftGQEYudxuRCnwIjMmu+NNrjt2qZAZ0viSW2DdWYxvV730zM2w10GKKwrApTxvFkZ
         38JrBErjSq+wWEY08yMouTmmXM82UL5zKhWclioPiSvXHQ9rfy+mafZq9N7vsc3o4LVU
         AFHxdgWDVTrsU7A3vWvEnYI/OCvTOHe5aR0dCpMDtbEk/a14JVBSbRoZjU7aJh7amjOW
         nLo6XeBKiWKsVy7PaqaYNRwCbbamWaidvI5sisrDkbeG8fv/1kYNpdKkkAu9P3WguhpI
         1qHzbm32lLIEljjLVnCWhPdYpuXveoqlVuiK4H2N7dZaUQ1/iE8SbK1pmaOjkOU7Pacd
         MsVQ==
X-Gm-Message-State: AOAM5317Q5ZhmiXSXdW8EH+gZyUooxAeDhlTcm0/FA1PtN3T8EpbemQY
        qlKJ1LXOW7u789t4QqXFkOU=
X-Google-Smtp-Source: ABdhPJzjO83UYzZfmiS5gD2nhgDucOtcUmApVHzzYJnXM5u3pHlpkb4B+1kWphmu/QKhI+9fXCU/zA==
X-Received: by 2002:a17:906:cb82:: with SMTP id mf2mr2280977ejb.435.1603804672760;
        Tue, 27 Oct 2020 06:17:52 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id v1sm936585eds.47.2020.10.27.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:17:51 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:17:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 02/52] soc/tegra: fuse: Export tegra_read_ram_code()
Message-ID: <20201027131750.GE1822510@ulmo>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-3-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:16:45AM +0300, Dmitry Osipenko wrote:
> The tegra_read_ram_code() is used by EMC drivers and we're going to make
> these driver modular, hence this function needs to be exported.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
>  1 file changed, 2 insertions(+)

I'm not a big fan of exporting yet another of these tiny helpers, but I
don't have any better ideas, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+YHfsACgkQ3SOs138+
s6Ge8g/+K11Rea4lesG6yOqiV+tgr808eTB04GzTxW2YHYQXECxOM+h5veIlJO7A
MNYFWTnWUcUT3fG4FQUhXiy4w1h+1TpkZYiOHRxkmnCGkxhVXm7Tk9w//ndatBIo
TMSNpgcluGaAz+SZrn08yVu+0Xifrf2QC3SRXEBbYDvV2HjNvHeqSokDG4R8u4at
RM8krhnRarN612d5xkR09ffTFGdoAtfwrJ+0XS6JJpHQ/djZr2hJhY7h6oYUoz0D
pOFX1JyXcIeomkw5cKSdyE1KN+VhhsIL5emAdXDrsWdkUIjEvnprBRPDMXQmR57V
Y0OYvmldkVyDSCznhJtqinLMmXHuRWkD80KvB5sBcgk60AoIDZelvsQlHisSRYIL
jaMidBbtFkwoBxLPJ+3ReUyx8gWI7HY/bNNI2zpv1NSXdpPtdbAX1J78Fkp/xLKw
WsriAUbGiZ4WlDcNFVrJZuDSsVd6ZEroRgu1ksHU1tH0Fv8S9q2zNEL7gdR7WX6f
49mHeSGvNM9JZsVXspMdpqmnW1A8/906ZdxiZQVq6l+7UabjxQt/atWMONdDPtl4
BOEhsa3H55FM1pnAxhF32Cl98x4hjOqm/dpo0wSmnVKl7fU/dB7uY6UlC6wNbObz
XdVJigEdvPWZq83816gX5thEgB8Dt4rSzLGbtwoP09PQrjyBUM0=
=7Edt
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
