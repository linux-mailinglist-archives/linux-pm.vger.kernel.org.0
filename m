Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED01344DB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfFDKz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 06:55:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40563 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfFDKz6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 06:55:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so10470943wre.7;
        Tue, 04 Jun 2019 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vyxbHW00w/BGnkxIR9NeNgINEbwzVv+l8xg7qtHVhg=;
        b=TFn/A+314vn81aJfVxuAHSufWthkN3kRXPyFpGX7PRhiGx7/ERRkIgAvYMffy4rOOk
         qn/ZFVIGQq77HzKa5jSdc5tzLSw30uDKr9YbWJSlTv0BOFXSqJWnetsifyEHcQaVeQsU
         M8RznYADDw4Om86FPlt7x6EXm+QsKJ8ZmDjbOho3wVH73HM2u0UCJIN79S17lIrNcYd6
         w4hvV2MbwM66U79rnJlI0MOGewWUotrhVLJjeVc6ue/01c1h5jy7Sx1URAd+uNzZpHU3
         +ONPVPt8op/K2a4yOK67hJWYmD3lzARTTPZGDAvOtZcat2NHQ9namzpoGmYRZlZftwe8
         8iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vyxbHW00w/BGnkxIR9NeNgINEbwzVv+l8xg7qtHVhg=;
        b=lb8FOjDscr5jExiwwuik0/JeuK1DWoWLnLdDKyD0I7BvJbX8JSoGXPqLIiGtSFoIpq
         Pwmf9JZYAN3AVfP0OOqkuvun1OwsY9fTAz3gTksWfQkOnvfoLNrd58dGh47+Xy2w+XD/
         MGEic60vQqfzh2mfDXsiTJ7CLVIeSCs0cYBqrKwsQlf0DEcvhdk9uhCdQlYidUreGKBa
         hOlH0s0LG9DdEjpfN4KPs+0DIx36VlMwVY5f2/wMaR9VjzdLKBgxFXUKCD4/Z2JsOQYR
         rifQPPceqieDrLbT5qin+F4iCZw9mdRyeSroEgaUjMSI3OtttA5CfXaZ5dECVvGBmWWD
         H81w==
X-Gm-Message-State: APjAAAWB/uoTJvILJbZALVjfk+rRal93+EP2cFIkLME9AcXnXBkU159N
        XhR21urEkxzQoQXZVzMOEOA=
X-Google-Smtp-Source: APXvYqy/1qGnGiwqQyf3ci6g2uZH1Z6z5dJTezgiCpPWMAGcVylvNP/W/8l26RaL6IOJYWeSLNFjnw==
X-Received: by 2002:a5d:5586:: with SMTP id i6mr19804970wrv.299.1559645756327;
        Tue, 04 Jun 2019 03:55:56 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id l1sm6294463wmg.13.2019.06.04.03.55.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 03:55:55 -0700 (PDT)
Date:   Tue, 4 Jun 2019 12:55:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/16] PM / devfreq: tegra: Replace readl-writel with
 relaxed versions
Message-ID: <20190604105554.GB16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-3-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:01AM +0300, Dmitry Osipenko wrote:
> There is no need to insert memory barrier on each readl/writel
> invocation, hence use the relaxed versions.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2TjoACgkQ3SOs138+
s6HCig/+MYGm5lDlw7UEH/pX4xq0xSFTzfNLCvBD6nL3btL51CHXKvLRfsOJT1yy
mvGMSI7THp7XjAJkMWQfu3dyhdTFMsEKl+BAafPV4EhUtK0XkL4Jjttb7cP64ryf
l8OLys9nDOFLx3qHy1ZQ3HeWmWcxykzeVaX+ymvICq++6H6WR+hNYGO+bUuOA92y
588v7IjusMz4gxhiO0U6f8JhNJIvyco+TtND/KfeeNC1Svc3epWeijG25O/Zd1Yu
uYHo9F852kgM2ZVIPnVBQljZXX+5H5cOmCkP2L9iF3TcQRcCJwsTaIRpATBmWgJR
EcqM2XF+aJ2hlA8SlaJkLma0MP5EuZllYYrIO5+FpPfcDnEjOFNlK+2B1rN151pR
Zi35DCYQ0XZoK2ZKvw7ICQdPv56TZpW17u6GMS7qx+KbiCWHOFGMTg6KVNO4TeO6
Uk+nm9U4JzAhwdHdvkelGsIHIcer1QuAPCiT+v+JZNcdV0QE8nn30Np27EEVWdqK
EyNDxplwghjO8/PUaBHNwqjQs/fMemM/XCB6ffledqxi8SHLL4HZ/02KvYVI3rX7
wYyVs/HRaHaottLqKLGeaUFLz7XQkZ+eB4vmMuwSDjyRTcqAJDKf5eiN4TfTQvU/
up1EiOF/H31z8jGNyYfXZ4MK7s3+XKvouYN2ayy02N1ti9U/CjA=
=jArK
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
