Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB82CF0F6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 16:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgLDPqv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 10:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbgLDPqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 10:46:50 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD18C061A4F;
        Fri,  4 Dec 2020 07:46:10 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ce23so5541258ejb.8;
        Fri, 04 Dec 2020 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DbuAyN4iS3jE4U8EbiNHXJ2azbl7Kvh289+qu9c177I=;
        b=qo2LjP/5aSlrSTKxBszJVbRALYQEyunOrGSTat7HnEImAsVNH/dsiqnnc/oSJug0o2
         CUpls6t4Di/qckyok9rz0J7q1HJzRJZp25u9MUEKDc1UwjZfpOaB/oCUOoQkcTSa0yOd
         kD98xdt+C5yB2eM+hpCaJh2BhCA6Unikuon6GD9Ro2dY/3KBhXSx63YzuM+SFtVDUurV
         34CcQI1gQQiW9abg14HoZhCnX+jGW1jtzU829y/BZn4zsnvtL3YvC00TEQfD1KJ0p5B5
         IAUir0Mr3BW6R63WqaTlBkilwaM/1U/ZujJtKlIgBJSH8ooB0qJcroLVBioT+7JcrvP9
         sjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbuAyN4iS3jE4U8EbiNHXJ2azbl7Kvh289+qu9c177I=;
        b=QOq2jTgalSGbnt8HtlnNUJPFV4UCgNvadG9VWnRR4wlaPLuH7Ij4YvSecP0uVje1vJ
         0t8RHq04BGbo1wTzan1opecnFUft9jCMs5Gpics8jg+tukaihE+TveQ5PmXgnf8zX4V/
         Fbu5qzFeBSdUxFWo9H8Cxb8V67tHIWDHiBvdihXsyrdvuvUVlk4w343XAyMGGdJQcylj
         gIdh3miSmcMusqOksYiODptDtGzuljtpnEhiJ4oD5lAG7FQwR9csXdZuXMZ994F35WuC
         Gq7M+2RyMJ2cZe9O+mngeQPH0aBaEiAF7oFjD2i2uemxUqJ1mnJEJ04PXGU715e05CR7
         9wUw==
X-Gm-Message-State: AOAM531USjGMWUA/2a4TSyKhRAmYwOTh8/Q+7wNNh6E2HfTtAp5M9Rey
        H5WKCPMEwGlBzRzVJTzU7Y4=
X-Google-Smtp-Source: ABdhPJzK6eXffhjqFGkcAWdUBfAlJi9OXl7yvUZWgm9NnuvukHyyyS6UAK2lT0tx6lcjkCDWIy/LvA==
X-Received: by 2002:a17:906:2581:: with SMTP id m1mr7556254ejb.28.1607096769272;
        Fri, 04 Dec 2020 07:46:09 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id mb22sm3310243ejb.35.2020.12.04.07.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:46:07 -0800 (PST)
Date:   Fri, 4 Dec 2020 16:46:06 +0100
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
Subject: Re: [PATCH v11 01/10] dt-bindings: memory: tegra20: emc: Document
 opp-supported-hw property
Message-ID: <X8pZviQW2BHSMlg6@ulmo>
References: <20201203192439.16177-1-digetx@gmail.com>
 <20201203192439.16177-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ldeiUs9kZMXTziz"
Content-Disposition: inline
In-Reply-To: <20201203192439.16177-2-digetx@gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6ldeiUs9kZMXTziz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 10:24:30PM +0300, Dmitry Osipenko wrote:
> Document opp-supported-hw property, which is not strictly necessary to
> have on Tegra20, but it's very convenient to have because all other SoC
> core devices will use hardware versioning, and thus, it's good to maintain
> the consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt      | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--6ldeiUs9kZMXTziz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KWb0ACgkQ3SOs138+
s6FH1w//dN0K/ARFuRyDWigwOrKReFJQh4EOwjQKryEpjjTg8Uvrc7Y/OWrIo/qB
yja+Mk9p9mxkYJXxn6IY2mW2Seph8nmzG35zy0JBL+N+eZ/XiPvqt85W518oHxaa
asyYw335HlTappz23Kdx9IIfeHQXX76H96+gUyUughgMA+7y4G2n2G4xTP916EFd
fZ53xB5EUYyp37nROQASYoPCmCnIgZBAQchJoOvRPqDeSc2ce+/kdU+faoo0ltGz
gX5OF6zTkC+6NVVS3aBy1gIZg/wqQMo1Yiz1kslAf2n8Pk4JOgDKobzUDL9NZX7F
HQhmjBwV9yBsjnWEydVEz+hHf+UG1QRbYHCyURDMnNw4qK6/b1tUpz9paE40l2BP
RQCNEDMb+AhhOx8gyeqtIQJd6XErNR5vJi/kMZV0bWaxjdzaFKSnvNKTZ92VoZvN
UCsn0kFSmheUTE6xlOW/k2YXnD3Qcoo7pOc0LWqIuSUizqBAbSJen6VFWyKngZ+4
hkgZW2w0sHoOE9Fut2HxuGc7mg/2da37r+NxI66fzcR4DU0igQeeDJoMVmC9B7gj
EIqwOMy2hrRUrK64rDJ1fxKeRplINR7LZL9yBKEGsLwACi5wdFYNZwZr9xcP4TCy
yiEcJJH8F80dhvV8e/AuZyBPfrVhz4qDeWXr/EcuAenYLZnQ9sg=
=JFZn
-----END PGP SIGNATURE-----

--6ldeiUs9kZMXTziz--
