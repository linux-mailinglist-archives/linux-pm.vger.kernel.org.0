Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B797E34523
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFDLOr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:14:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40809 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfFDLOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:14:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id u16so9037054wmc.5;
        Tue, 04 Jun 2019 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UHpoqEIPVFN73QVMG6iTW6d+vLyYK0k9FyU9x72I4nA=;
        b=PS0BosODzcinyT95mKwyWfLaMjlR61jQhTGGjikJdskCVpyAadUM0YKA1AXfpfZcV5
         hSxhANc9lRj4lbQxmjRGjFdsUejNzSIA/oRyDuGIBtV5WhQDiZSu7IjSDaFXSVVOr/sr
         138pZBHj53u4uxOfHbZ+538l2pBejoW4p1IqKzds6WlXWpV+3taAE3hiLD+KUvg7ti6y
         YJ7ML57l8UsWZaOjala4xnge3/d4V5vyGPq6lYiSXMXYMcz3F6tClwb7IhSQFtw4NeWY
         0eNb7g6IhTDHDZnwjmbIAjJCQaEQaZSESggZ6ayPcc6RAYSiFfLe6xDgwdAHkE6NtElJ
         0G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UHpoqEIPVFN73QVMG6iTW6d+vLyYK0k9FyU9x72I4nA=;
        b=tauKXzvpZrHUCtvi4YgxbLQipkpcdFY9X4hIqwa41DRHs+/woVQyuGQgmisVGdqJdl
         Dg8SqixpySztgV0FNnSQMkvpJVfH5sbCNfKr7BteFVloaAo2I9XYpPijbPN2J4fa7Af4
         PszvO5evzxUlwWHope4pIe7c9F/UhBvAYECz4O4kYQHsT+Rmk1N4PDGt5S6d4pXgI716
         eCDUPjPnK2wnPEckM5fX2/eRXhZrNVkLyVTixIStaXkpa/1LOiZHT7I3l3y94Zp4UVov
         2IlLLNItSe9tnqUzI/8QUbA2WqR9Tsr5F+KjwCddDjrN5tVn8ufdJ0q0BfxjLG8RkaAG
         lBwA==
X-Gm-Message-State: APjAAAWeo+tOPFTINTRa4By3h+F8f65445EBpM65gvQy+iytJAYlg5e9
        rFgSQGlSHY/6gB1oY7MoP/KQ6rdq
X-Google-Smtp-Source: APXvYqyhveJv6T9hqJK48nqD4r541Pl2b37S7gtRpqYDRmq1Uls9NPqAiqGLpp4QKeVW5yxTVDUzcA==
X-Received: by 2002:a1c:9eca:: with SMTP id h193mr17417147wme.125.1559646884741;
        Tue, 04 Jun 2019 04:14:44 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id e6sm9778196wrw.83.2019.06.04.04.14.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:14:44 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:14:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/16] PM / devfreq: tegra: Avoid inconsistency of
 current frequency value
Message-ID: <20190604111442.GI16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-10-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--X+nYw8KZ/oNxZ8JS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:08AM +0300, Dmitry Osipenko wrote:
> The frequency value potentially could change in-between. It doesn't
> cause any real problem at all right now, but that could change in the
> future. Hence let's avoid the inconsistency.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2UqIACgkQ3SOs138+
s6FdDw//XYp02JzFYTmM5pd+HyO9uQsHazV0k4wuxheR+J2EbT+HOp4DBtstdbNv
jEg35xHhbQ4xXgt67Uc6aJt74WQpSDOXX6SMLa7Mu9inUodKqFSoivMW+u0DsSRe
4Bz5uAcB7jX1e4vxA5toS5th+CKCi9oz1K4PJAQVBuRldO6Noo75hN6ojLx469As
Ary2EfGIQZ3fSutmmNJ6FC+HNx69MHy/pL30HIEEMqqi2xfQzDr8692zMPi3rZ/T
XJjVr6+MBs3Mn+z6QgQbvYeQPekSIOWIGj3RGvcXwKzi3jEGpG0s9sQPMaLDqsDk
BvhRa27hNvGUppGg8kx14UyYdxxahc0ZERwnerjEpyWzfsAa2EKvX9fyF/tOQ6PG
JXYy4E+vj8bkvxD9G6DdHwn7mugkqMD21PQVCrygfsSBfjyYvCdRUMIKzsoItVVB
08hJQeTBTZV9vAnfwvNwzjm38BDlZum+nO+SMewQtmtf1s7p+I1HO+kAmFhqhE+M
7cV/EeMhuGN8U7qWig2NxbcBNjmC650hthxgb2ntk5Q88NxpCfsay6+ESKIHGYzg
dEuaxVzAuU28snKN8KQgXWTIJpxy/Yt5XrGRaNqbChgyb6SHOydCOQW8hbexSuZm
eXgfZ+MJP2q/oc/a/f/b9iDoB3LrDKKSLtEUH2DJhjYdvoMW/e8=
=/qKL
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--
