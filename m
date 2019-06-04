Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF534516
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfFDLJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:09:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37314 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfFDLJP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:09:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id h1so15366280wro.4;
        Tue, 04 Jun 2019 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vm82ZfWeIRYZIr6OPNfUPy5E3KGnX2czvdF4ql6IfXI=;
        b=B3KL2urz1d3RB62j3WXOPupGHWOxaj2kpJdbdWLvakOFmQpg6OXM8aS/bWW3Z39BXO
         6peI/jowulLcAvHcAu8a+NxuMgTo9SRv6HpJgIB2Vt+sesusCJmvUyJVL2h11NNyc8kS
         MI6pjIm50TNkvJjdeqScQMxjKZR8zeMmNbkXIIB1JYJxz604I5BZJmDkASeqxExsOKHR
         TFbjjYw93aThCKilDlzzUj3HHHA49v9XPgeECEAmwnsd5DFxns6HFPQD8WKed0XAMAHy
         Cfv6Ae9fFD4e0RKVBrqJQQii7QJwT+YFVCseZzB74LeKkPeoBl478hO+P2TI9B+Sbiwf
         HfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vm82ZfWeIRYZIr6OPNfUPy5E3KGnX2czvdF4ql6IfXI=;
        b=fXYCnqwhwMWwwSzPR6PVXOQPFWq+n0nOu4y9zI8JhzWHD/+0gHB7nYJzx0n5i1YduH
         PKTh+gOEtWXVOVIv0FEW6nrRy44yO7F/jrv79Ur8lLrBpE4xH1rma0yo0xC5xzN4UAiv
         qm2DuEsaEl6klonm/QTUMMqA0WvxIQSu1NwxcR183PVOf1sv5fRZtLzaLiN9AK4DEOto
         btVRlnumKzt/m85YOZqgvkKsfWaH6gvl2oTkTioovoV8/Reo6pGMtZNbz8EMClpHY3V4
         JRLpPd/rl1wd033hNFCjMWOWzfbVFzUZYYpm6+pUQk+HehOBZXSmneIUFgCkvBBNTL1B
         8H9g==
X-Gm-Message-State: APjAAAVUCsKDxz6g+WTjMmdFDyOxKJV+5XigvLSalBGs1Ca6UL+86v3Y
        jk+tfXfOg0bLxGC0IW3697k=
X-Google-Smtp-Source: APXvYqwQaRqWY96LdLR77svmkp5IhfGvvgPt/l2uJEo27AWiEeIPXpJaPyRXWqMDTLNM1Iext3qcSw==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr20187570wrv.322.1559646553421;
        Tue, 04 Jun 2019 04:09:13 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id v13sm13586368wmj.46.2019.06.04.04.09.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:09:12 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:09:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] PM / devfreq: tegra: Clean up driver's probe /
 remove
Message-ID: <20190604110911.GH16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-9-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:07AM +0300, Dmitry Osipenko wrote:
> Reset hardware, disable ACTMON clock, release OPP's and handle all
> possible error cases correctly, maintaining the correct tear down
> order. Also use devm_platform_ioremap_resource() which is now available
> in the kernel.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 83 +++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 36 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2UVcACgkQ3SOs138+
s6Hgsg/+K4NiFub4c7Q/taEey+0URjvREsXfnRG4E66a6H0C4h5i1A/zjGOvexA6
XbF6ln87A0bDO1RSI61IdvnfYroYqgGYwhZVyRhAj9d3QJq5i1Tu19QBVlQPErj1
4pkBrax5sqjWzvqYXoDmZNlTlBAEV6oSe4IwBPlzA/MGff5o7QQWq8Ubu9FqV9DL
FORdeF0JR2tQDvNuVlP5Xi1oHi1iUZ6rBNQavAzUWobcuy+aI3BXt0tSqA9YKsMV
K02aylg+cTD2jlPkESgXzrSFKXEsKSAeqdD+iGl8PBp8PqKJfbDIwlqM3GPRWDov
o4kMQFIIpX8ZXBi0d7uxoFMRAs001rszaGNUEBk2CnG60wP/hTu6m0V0NiHavHz+
hpBSJ8DRAIyknkYn1SXDTY5QeTZfkPfjuDt6/QIJ4475LaNaKW8Fz/CXOt8XwCwX
W1kf61h9HHpqSAZ3eVvzOzZxL+8tecZ59aaw6uePxoW+zyUTD+tfZBUTiAflVkSM
/0M4OTU5LNYeJBBzKJIUX+gRhZQULERt70C4HwyMGsAGdPin3XI1LZI7MsHTHl6k
/uvSbJPPpf9Xt5Fh/1iYAK2C58KziUl8HUyopbfX69U0XTrPUnRZyMOqVlCkpL+Z
FXAbWpRz859ZhinVM089r/1M5C+CQn2+uj/Zfc1UATef4hny628=
=u80w
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
