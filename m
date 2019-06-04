Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B69344E9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfFDK5Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 06:57:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53314 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfFDK5Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 06:57:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id d17so6632538wmb.3;
        Tue, 04 Jun 2019 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/TBGnrvBO8R4YOzP+ioN3jhKnsDYr+XSV9wyo9XT2cM=;
        b=c1Y75DbJftmCFd1zZRhUFfJkVj+XCLI/AbLy0eVn3VlmhT3fhl3YPHwileG+OWqkff
         GeGVum2127pNQaA9zWtDLIGm+XOHUgG8a1XDj1ynCk2/0cO41J0AkZxkn++++mwMzGD7
         4b1cObVF5SenNCbirhNCSLGFGSsOwy0RybvU7i84iRLGquKO5PcGfP90bUwkHteTyKva
         gGLGSvB3YW/24VQB+4pIrTiPywfEyM2tYs4FOaai6D+/YjyIkVsDSM7tJUkPYVFnpomz
         vN7BN/0xVniXTdciQGw3lmcbuPsri1ImFtv057y7RiGN73C2zC08hIPbeBdIVMcbKfJH
         +uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/TBGnrvBO8R4YOzP+ioN3jhKnsDYr+XSV9wyo9XT2cM=;
        b=i2aAqTS1D2xO/U5X6x/edfK040uO6hcHl/LE1eo1jAvPTLIDk4WUe9JUNSD0sGdmn3
         yOfCPTcagwHmTc+zVd2Jop8vIneKgYjzRe4zDKizg/+UYyGdWirjw9ex8cJiMyOQQn0z
         JP73euLXsz8iqGRu9a0NPDKv7kFESpPyUQUjiZYl+hQBUXfu+I1LsiAL0FBAaXHmvw23
         HceKCuMKYoIdC75W1shl0bmKdPnLM/LGZxHEfvrllvnPUfCymxZkXuaB22DdrJ9WmAgj
         LMHhJTBCqAD9tedb007HbCmVBp8vI5zqFIm34dISn703XdvR6aKQQm+07yU9CPTFMlzK
         9GGw==
X-Gm-Message-State: APjAAAWylr/brovwx1HpYHFSR24oaLe4xJqK8HAfxwQpvQADn3Qel8DV
        FUB5iFZovGoGRNbyNjvedxE=
X-Google-Smtp-Source: APXvYqx2pvgQkaBCqfnCKIE4+7ZZdoGxY+UXLpi416N3pze9wYqpcaOrMc3qX0gCG9A+5GXwviBEmQ==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr5582881wmc.163.1559645834203;
        Tue, 04 Jun 2019 03:57:14 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n4sm10775630wmk.41.2019.06.04.03.57.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 03:57:13 -0700 (PDT)
Date:   Tue, 4 Jun 2019 12:57:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/16] PM / devfreq: tegra: Don't ignore clk errors
Message-ID: <20190604105712.GD16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-5-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:03AM +0300, Dmitry Osipenko wrote:
> The clk_set_min_rate() could fail and in this case clk_set_rate() sets
> rate to 0, which may drop EMC rate to minimum and make machine very
> difficult to use.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2TogACgkQ3SOs138+
s6HPQA/6AikYDFOqfBGBSOAYrjtU4L+1ThqX2wVgtvUgiyrO3yuj2hiGpLKHjlz1
klMtRdjUTW7TrfAyhH7G/LCui5PrLcHq8VdavnhvKokoHJXRMsmurAITlOl7l9E0
KPLObjGrUwBAUaU5Ktk4Ni/VK8FkBB8hkePiz1kJrZHBF0wPUGTq7c409CBoZ4Ug
dzNtGfBzW728QIoMOfIJ2RQN95QFULCt0jpablIHMyXFP5Lc4XvFI51Cl1/eq146
+9v6gJmUAXb1DMdAGHFclyLGR1eUCoxvfK2Ghb+FUTMJlLt6n/XhEFZAk3ulKTgF
iD+J5tUqmv2XgEeGl+GGObOQbiVWAUuYQziJIAsbFsSXQBhNHdYV1TdBPK7hb4tn
WNfm0s9XRo/6m60r8syUbaFOmSZWIF37XhLmw+ScnZJ0k3iHpo0FXuA338EWXkmU
NBPHkh32iRrUeYub4tuKeSbEi5taG2ZNO4boE73pdzCfHq/h3Ndfqxj09t6y7A9t
m/FMYsMZXDy7thSetWKAQ9tmYQnnU7PoCh5kE45QowkVQEl9pv/rh3rgl7VPCshq
v7wkFd3wzcMyoer/G26m5tFnetPDOsrSampkZrdCoCWrCA420e62E39tm1BsL/Js
Bmc9So5yijDScVtMA6ZQ/TTvpnwoiQjLgn+A0ATndNHDteYE4Cw=
=w8OB
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
