Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9202CF1CA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 17:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgLDQUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 11:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgLDQUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 11:20:53 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8A8C061A51;
        Fri,  4 Dec 2020 08:20:13 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ga15so9502528ejb.4;
        Fri, 04 Dec 2020 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=035wWkNcQ1j/nClUbKgpC4qFMyacZpddWNDtASSt8zk=;
        b=RVwC7rXLNVM/WW+lIEXEvod+oQJMf3BbR8yKrYlPT9p6jZKxLIBADh0Vt8mUyr/s+0
         eT6twdK3TzOp6LNSd+cQFUhHWgUtxmxfQmuQ8GUUite4935p0D8QSgnhqQuuhVAk5j4m
         Nh9j45XXUjatvNABsebWxHoc1MnG2G8xDCQbibGqz9uozsJQizhaxU/T4ZypYhWqr6xN
         T2lGddZbFgxUDKVa+Z0SCzmVTiu8JBEq/oWad/1+q9+DKIq0PeohU0WbQL55Cj+uMT3R
         aKJBoyrR9sJTi12xBw9yO4OwDl2cq2WRro8qEjAvA+bJw5PRgbgy80WVSj426YCTZy9s
         Vjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=035wWkNcQ1j/nClUbKgpC4qFMyacZpddWNDtASSt8zk=;
        b=XCRhSkKCCVj+Qlq7Ln6H2J9eIa0wwPAbNDm42uwO2jUtyEnLBgGkgqAaNX2oo6cYuI
         gJOZWgySawH/bWcOFar46whBDkX/WrDI0GBIm9jAoizaXxI24VsBaC77etkdxjfAjOpQ
         ImMU8959pbcU0dMMn6Q/p30PlLiVuek64Bz0Hd09unilwvFT/+Q/6IF7eIkWN5set2UN
         VzlOIS8DTGmGFpLT/h383ykNyjtcUYIXXPXu7Y3Y7ud0rP62jcpXNKsw7Y6/CsI/4y28
         zz/2AEQK+0M9yCbuW3iLrjPddNjXLCLEpp5+UrJWicIchrIkIQloeaPJ9L2kPEbs57nt
         6nKQ==
X-Gm-Message-State: AOAM532t0JUtDdNE4c9Mplr+AZirRIUwp903L4uNZxizimMFqLXvsoL8
        B2rR1KSEa9OfvEQSc7+nEDY=
X-Google-Smtp-Source: ABdhPJwBwoR6getHAK2tH0Nrb/IrJb+AU/KJjtdwJouNJ/xJKA6T1sMLaeAZQXXerBfC8gKVBvp5CA==
X-Received: by 2002:a17:907:60a:: with SMTP id wp10mr7967611ejb.205.1607098812155;
        Fri, 04 Dec 2020 08:20:12 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 65sm3780181edj.83.2020.12.04.08.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:20:10 -0800 (PST)
Date:   Fri, 4 Dec 2020 17:20:09 +0100
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
Subject: Re: [PATCH v11 02/10] memory: tegra20: Support hardware versioning
 and clean up OPP table initialization
Message-ID: <X8phuUGCBrp5JGMv@ulmo>
References: <20201203192439.16177-1-digetx@gmail.com>
 <20201203192439.16177-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CqLZrd1Ou7JwelE5"
Content-Disposition: inline
In-Reply-To: <20201203192439.16177-3-digetx@gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--CqLZrd1Ou7JwelE5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 10:24:31PM +0300, Dmitry Osipenko wrote:
> Support hardware versioning, which is now required for Tegra20 EMC OPP.
> Clean up OPP table initialization by using a error code returned by OPP
> API for judging about the OPP table presence in a device-tree and remove
> OPP regulator initialization because we're now going to use power domain
> instead of a raw regulator. This puts Tegra20 EMC OPP preparation on par
> with the Tegra30/124 EMC drivers.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 48 +++++++++++++-----------------
>  1 file changed, 20 insertions(+), 28 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--CqLZrd1Ou7JwelE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KYbYACgkQ3SOs138+
s6E9YhAAnOW3eb6mWSwXsc8ATDZpYmZzCt5wUz/tcuNcBgmEuAEVp2nrgpLPnTUt
Z0RZg4fL9ZotBwu4tVStVGgIZpO0gzJo9DSYGiNWT52+ra3MWsuFiK7BYkkHAuwL
wu+P6UOOYFNO8MZVxNlitgTILStuH5M+Jc0wRf1AGLMKtmdSe7AU9uw+sL5YmVXB
HJEQPxKEOtTCiZYRkooNuX7+mGyIYUiejglm9Zrcv11dHRY393QokuQTlTHn6sbW
rIU4MpcArmq+8QN29f7fmztCgCvWesZFfIyZjZooKEYE9gGeUKXAqmi/zvQ/2JZp
Hlycx3udPsV21QQW+scftfWJm7s3lPw04X60FPrYzPm+DN2PpZc7HIlbC/g4gcUD
p4Pa27/kvn89RKDBNtfVAgk821zgeXmTSKI97ydjfKtibefTChay5jGDpqh979r8
3cKMU38k/ogdRprC6Z8Quv6u6b53uz0wjXBpmlEPRRmzNck1egsx9prQ8eiKIG9o
a93VcDOFRRG3eeiWjv8JmHFGNIGq9QILlMDNWh6jxbJt/WJ5ZGJ+1vbORrk4JbBA
RIUvhzkzxt9UD0PS9/pFoAyaec0CjQL8X1u/6U9JW2vENqYCoxCiUDVxJ2t4hVUK
RHEQDUzlURczgksNpLikJ4H1MIQ7Cb1a9mGst3BiGX/7LOEUt60=
=LWwG
-----END PGP SIGNATURE-----

--CqLZrd1Ou7JwelE5--
