Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75162AE1C8
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJVar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 16:30:47 -0500
Received: from ozlabs.org ([203.11.71.1]:60323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJVar (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 16:30:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CW1Hj6KSpz9s1l;
        Wed, 11 Nov 2020 08:30:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1605043844;
        bh=TJeJa2tzl/LdHql1YVlaGWX2j/CQDqQ6INQTnj8ggfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZbUzZQG5JxqA4YV2SZahiUdI30dQMP46KvpEnPXtnZuHo7c3Wmkj9UxrqV+O0dnT7
         cQ0+a8HzLl4dfnEszsH88S5ZHS/K+rLjiHLq123sZjNSopUXTKkabrwhVwPh9ds+fS
         BnRBnR/KVURwzmnZuGyDARkPM+ayvTsijevOQtdZ2lZVT03DHZ7biZbQb5mHTbUqvm
         LPAitB4Q3+UaTUW/xAbbsGuGcR2MrXOEoePekFqZ+ZxBdDsdRZl9k/5KG+X6ljgbqv
         SwrUhJeusEjFAWaMUcltq019Izb3B3eRgg+5EjJvqmn+WUI7rQpnbnzu7b36BFO4RG
         ZYMJxwcwP6L6A==
Date:   Wed, 11 Nov 2020 08:30:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next v2] clk: pm_clock: provide stubs for
 pm_clk_runtime_suspend/_resume
Message-ID: <20201111083041.698a561c@canb.auug.org.au>
In-Reply-To: <CAJZ5v0jhJcL6uJw_Cm02SeUMff_s1L-mKzX3haAyejcCkKihNg@mail.gmail.com>
References: <20201109032115.10610-1-rdunlap@infradead.org>
        <CAJZ5v0jhJcL6uJw_Cm02SeUMff_s1L-mKzX3haAyejcCkKihNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NNkr73WnZd2Rjkw1MfDcr59";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/NNkr73WnZd2Rjkw1MfDcr59
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Tue, 10 Nov 2020 18:43:04 +0100 "Rafael J. Wysocki" <rafael@kernel.org> =
wrote:
>
> > Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller dri=
ver for SC7180")
>
> Applied to the PM tree as 5.10-rc material, thanks!

The problem is that the commit that this one fixes is in the clk tree
not the pm tree, so this patch needs to (also) be in the clk tree to
reduced bisect problems.

--=20
Cheers,
Stephen Rothwell

--Sig_/NNkr73WnZd2Rjkw1MfDcr59
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+rBoEACgkQAVBC80lX
0GwywQf9EPeARXiMnQ41GV1QHYfOW3ZwJizOxCI/b26sjpnk/cfkaeiA5TXMezh/
zkM/7hdYitLquso9XO4M+ODlgSuiHEwSOwmw+yVb5RlFwezkg07J1xbSnm5kyNyz
bm/72cvGjhP3R3GWTV7a7OI+i92efj7Hlpcml9Qu91tMxQNEkM++ABPlDa5eP2uF
BatuzT6k0dSj5VmwH+HmPSZTPK+TEVFs9hKC2oq70Yk0CO5G8YGwlpdnnZ/urd1o
8UpRQOjggfx6WjJ/5oZtV2kXf5GiPB0/Zdwvgrfvd124xWZbxgufCK0oc0BRfHqn
Gm/tC8bKMwzRprhfWiteI2/3OdkvSw==
=2ZHS
-----END PGP SIGNATURE-----

--Sig_/NNkr73WnZd2Rjkw1MfDcr59--
