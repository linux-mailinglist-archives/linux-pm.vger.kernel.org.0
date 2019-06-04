Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905FD3453A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfFDLSM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:18:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44719 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfFDLSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:18:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so15345896wru.11;
        Tue, 04 Jun 2019 04:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n/J7DO2DO5aFROvncBpvYr7O3pit+Ij/S9CA3PoODrM=;
        b=LGkBuEZjy4RsgzBSCi87kEzoeO2TkfcbiDJz0oeI5qkR2haj8RRx+NGPbxv5xppKtM
         ORl+sWhFIZmas4ErPaTDEFMvRuAzBbDsdapGYaeyfds4ycq6Cysm69AXC6YBcziuB/4n
         PeWYhM1+JfKp5POE0jJHaDWOIGicRTyCVrTgMfxKIEydsFXotjjiQDK1JPWXj4JpNOB6
         Hm9QphoihX1FLMl+pKEXTSIiK9VQSkkt4PuG/xRlMHR3i5xLRbZuYOVLEjsGoxJKTQ65
         IBZ3f57pwTXvs5tQ4q3AZ+mZYU0KTuCKxeWq9BTg5WgRFCnIZ1SfzMkOnBXIyq9jHfYu
         Md8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n/J7DO2DO5aFROvncBpvYr7O3pit+Ij/S9CA3PoODrM=;
        b=q+oXJaQ0+7DkOD5ZUyvcyjtSmYJs91dC4h9NCl7bMjhoyaq0/6ZTVLIWcLj9+hQ5nz
         Zz8S4VkiU81yqHBOtWLWwp9/5IbEH7A0HX1rHk9HkkdclmrRWWPpnHMiZOCVaZopwbB0
         kZ3TiVhzgVGNqIe/+9oAnutZ8EY8k5HKants6ym6tcfEauy335A2eNR9i8yxwzlstNnD
         LB8iPQv2ejSCfkBi3nfH4mn3uRIcxnAMfERIApxfPr6TBUvi8iiQ4M6dUksdPmbLZzPj
         ILReiPCP88DGXyBQaqV+nAoPvFKOPxhF+4fJot8DcXu41osVIQEktsFDGzDv7tulBbVN
         tlbg==
X-Gm-Message-State: APjAAAUBEYz3MlrU/Al6Vf0N7/atl5StB8d2LpD0K06cP3BcCAEhijJs
        kEyxhVQVfu++a9ogEBCDJaw=
X-Google-Smtp-Source: APXvYqzSEIpGd9eAHDPXQtrjLlcstzFimgmEaFDwBmnWZyH/HJ30pYPye4GEBEnwa489QEaAQC75TA==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr5867405wrv.329.1559647090033;
        Tue, 04 Jun 2019 04:18:10 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id o12sm17621110wmh.12.2019.06.04.04.18.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:18:09 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:18:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
Message-ID: <20190604111808.GM16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8c07nsHwQobhlezh"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-14-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--8c07nsHwQobhlezh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:12AM +0300, Dmitry Osipenko wrote:
> The devfreq driver can be used on Tegra30 without any code change and
> it works perfectly fine, the default Tegra124 parameters are good enough
> for Tegra30.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig         | 4 ++--
>  drivers/devfreq/tegra-devfreq.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--8c07nsHwQobhlezh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2U3AACgkQ3SOs138+
s6EgCg//RWhW/x4dD2kG6xp3zwSVBovQVAQZakm4/20gtph1Ak6gBxzPVa9+8iIJ
9yYQF+yiAjfL3OCDSMJ9OOHVULKujR0KFrdV9Ui62DFXPT0TApvwf8jGu3rbsB2b
TvtL0iE4bEwzPMyQJWzWVqOiUbVb5Y9LrbslWnU2F6CeeV3Wp7Op7yscqwJtJ1Gb
IrvO7OohyV/1XlaZGrjQcNf8bWNADNiEF31nMZnTwRVd0H3nP5pMjPBTCBJcucFq
PmyNeL8AzNFGeAUYTFTQlxk2k7HoZcAVL0CWm28F32ln4Kt8phyj9qAx9An57hDc
2lUKTbph2r9SS2t0zkoqTLeHqspqepMwPpSuTc2pga/dOLC5OEnsadxDmgShG8E4
si9QOIf8sOUwYjQ2R1mVgQ9i7ytPhvoj/zHPz0LY2a/Zh9YBR6Omyas2OgRm3qC9
oedItj3W7Dlfkx7YDkZL4jlyBdUc2EdWgMQMFxKd3+38NWIdAJ1UUIl1rHopkg7y
F71vZp2r2ATKzKCp11pvLyrx1YA2505A+29tH4CEWuYA2yZHvnMuRD/0uaQz6GJP
8A1RYsU0lhVp86S/X8MD6Um1Ez29+p+E1j64rCd1uQbFqw4UoS4PwepXLJN9ln8v
4Nijuy1uktMhFtFouPdr7Sb8Tk1e0g2l9yn1U2RmRdmqA2rRSGU=
=mk8X
-----END PGP SIGNATURE-----

--8c07nsHwQobhlezh--
