Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2D3EB417
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbhHMKe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbhHMKe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 06:34:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06598C061756;
        Fri, 13 Aug 2021 03:34:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l10-20020a05600c4f0a00b002e6be174c29so2564437wmq.0;
        Fri, 13 Aug 2021 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=drW2s19rJYY7O+/Nya4xV6OqunsSjSmEFOmQUF4SWn0=;
        b=oL1NrgoJyE6uPktlm9mvl/Hvw/tIOrg/EZ08olU3Xg+JsAoV2Y4ydt0DoD5BD8KE1U
         tJqRuK3m9cMFnp9WclHDAZrVUFsee6nzpZnYMafiRQg9PMYTfFm83TZZOdX8wfrI2GL8
         WQUVJiNEy1TKLjwSBjh2di9eBIepMmvanFrKIHuCIM/7EhN63B9hPYwOLeGuXoUPog0M
         PB9Utd323wHVPK4pndDILTiNaVeup2+o5Nu46YYMb9Lhr6TQ5sEqPrTZLbYoxj39Rv/f
         yE4Yz/2ZSdKCpAeCYY/mJTbi9XP0A/ZfY9xVnGthbted7Mkc3pZVte/7pBgHE3+/jkXN
         hM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=drW2s19rJYY7O+/Nya4xV6OqunsSjSmEFOmQUF4SWn0=;
        b=ONHJryEePZh75VYgAUnrtKvpziYg6PitJn7yLuie85Tdp+kw2pVtL8lhwFTY31wC9/
         4d5YnxkJ9+v1P8inRBNblb4/7plTBfNuCuWvMx51KQW03LQbHumxQVYIESZYQPshHo0p
         aPA7psHMugzbIcHGdCWH6k3gyKm5tukHUTVYja/0CrLoMSoL996Xa63eakNc9GXA/brF
         c2uZ/g8tVuvdyMdIXWTfWou7Kp6F4fvHWI5lajML1UrFM/QfRA7mGah2zV//xGR3MiO/
         9I+9tn/h0QpoRYhtvAb3QoQHjxNQmkFY+dGamtXIq7oRyiXu1Vu3NvsPjmpTHhnpXZ+x
         8EXg==
X-Gm-Message-State: AOAM532sULBDxZ8d4p7Yxn0bdkRnovjdNq+ffWqdQYS4jnFvJOyhsDZt
        pDRJea+IsF6+dz/h4X0A8cA=
X-Google-Smtp-Source: ABdhPJxmxhsijAM34+CEGEwXblQ+l9BM4uTixQ7AV2powo98NdVrFoPPbQnDhY1n2OXBGlt5HfMSjQ==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr2010883wmi.46.1628850839619;
        Fri, 13 Aug 2021 03:33:59 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id z13sm1151315wrs.71.2021.08.13.03.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 03:33:58 -0700 (PDT)
Date:   Fri, 13 Aug 2021 12:33:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Matt Merhar <mattmerhar@protonmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v18 0/2] Add memory bandwidth management to NVIDIA Tegra
 DRM driver
Message-ID: <YRZKlYg5YQlbmqFg@orome.fritz.box>
References: <20210601042108.1942-1-digetx@gmail.com>
 <8accfe1e-fc48-21ca-f7c6-bd2d60162e6d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jrvKOVFBTGi4etd5"
Content-Disposition: inline
In-Reply-To: <8accfe1e-fc48-21ca-f7c6-bd2d60162e6d@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jrvKOVFBTGi4etd5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2021 at 01:40:06AM +0300, Dmitry Osipenko wrote:
> 01.06.2021 07:21, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > This series adds memory bandwidth management to the NVIDIA Tegra DRM dr=
iver,
> > which is done using interconnect framework. It fixes display corruption=
 that
> > happens due to insufficient memory bandwidth.
> >=20
> > Changelog:
> >=20
> > v18: - Moved total peak bandwidth from CRTC state to plane state and re=
moved
> >        dummy plane bandwidth state initialization from T186+ plane hub.=
 This
> >        was suggested by Thierry Reding to v17.
> >=20
> >      - I haven't done anything about the cursor's plane bandwidth which
> >        doesn't contribute to overlapping bandwidths for a small sized
> >        window because it works okay as-is.
>=20
> Thierry, will you take these patches for 5.14?

As discussed offline, I've picked these up for v5.15 with a small patch
squashed in to unbreak the Tegra186 and later support.

Thanks,
Thierry

--jrvKOVFBTGi4etd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEWSpUACgkQ3SOs138+
s6EO5g/6Asf0AlKgNnrGVq250gnG5jSscO5GxTFzO9VNbuIHOOLJlKqBkx2fLXl3
TwKAtaQDfNzRiBVgCMk6xsxAas49cESh82NXgZSvsdU0O9+7PcMaK2IfPtZNHLSI
ClDiIi/WSdy9BsfUllfq4o1WkkzNQGUSiD+mAc/GaL/PxSEk7gc70vyg5cHl2Haa
yIrvXGZu9SlQ8b5MY9vdUK22xBvjd8+dRmmYDpm/wHFUfQC0Q/OpaPpxBi64OEuh
f+L25WJNJHimkXgrokDcDqtu9dVfS5k00qN6tG44jjDpLHn1rDmwU6P7lHgvr08G
+3tNJCLSAToYLKu8m0GYkYuB9gXyeb/YbRISJfm5pFkl1lWJ+4oM3ic+GWLaUlLe
2VwStFgoYK+um7AWuUYXGItLbU+w/x/U13ScGSABCGhQwu9y2KCKHtkOjCF3S1Nr
54hnTr1dmJx/sJvkU62txM5xiLMmjN/5bGUfvmMZoahbUSDumcPF4tgiEPBwZVRx
5LfVRCOih6+U0SIN52c1bVQ4ujwGF4wpHpFYP6IFEf+bHGV7J8ht5qgwdeWrBS3K
WdJ4XOkRugfXjUmspnry7kCsn5bR358Pj9qdXZvgOnrUWMyx8UH/2GugoMedTxJ0
QbCpolRbjR0Ief0B1CZcgDlonGaGOCJWA9fxaecjokALpIm3sm0=
=K59I
-----END PGP SIGNATURE-----

--jrvKOVFBTGi4etd5--
