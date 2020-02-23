Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47114169AA7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 00:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgBWXRA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Feb 2020 18:17:00 -0500
Received: from ozlabs.org ([203.11.71.1]:51165 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgBWXRA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Feb 2020 18:17:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Qh0l2zmzz9sPK;
        Mon, 24 Feb 2020 10:16:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1582499816;
        bh=ZDsuoOV08OG4rWiKXytPH30q7PC/XrARg94GbSYzkBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AKp3byLjUgGeWJ48kznETWc0Q3R5R+v1q1teBHVmawsNupD3Pe0ucEI5ezfd7pOAy
         PW/mL8pfaMHcX16KOvg6I71vLR4Bieg2nsmUWXZItzr0DqnsomYD7lx/lHov0Ft8fQ
         Hf9+mEEH7uRY8xZKIUCj0bEH679ZzqORtM5yx8UTUHzGIBFxluhGQUmhq4N54emir2
         DaqzTzxbhB0bQqArroPfI+p1d3N/FF3ywJHRFrTAM8fouTZOkblsC/wk0kpn1xMWFG
         BG9VEhQqMOam6UjEzDAKYuuUNUCRK7y1rY9DM21KuhEbv+hcA0Ck6cutVtrQKqe0bu
         jN215DYPbaD8g==
Date:   Mon, 24 Feb 2020 10:16:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH] soc: amlogic: fix compile failure with
 MESON_SECURE_PM_DOMAINS & !MESON_SM
Message-ID: <20200224101654.530f1837@canb.auug.org.au>
In-Reply-To: <20200218092229.0448d266@canb.auug.org.au>
References: <1581955933-69832-1-git-send-email-jianxin.pan@amlogic.com>
        <20200218080743.07e58c6e@canb.auug.org.au>
        <20200218092229.0448d266@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HRS=wqj=EXtghxVG08E8STH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/HRS=wqj=EXtghxVG08E8STH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 18 Feb 2020 09:22:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 18 Feb 2020 08:07:43 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Tue, 18 Feb 2020 00:12:13 +0800 Jianxin Pan <jianxin.pan@amlogic.com=
> wrote: =20
> > >
> > > When MESON_SECURE_PM_DOMAINS & !MESON_SM, there will be compile failu=
re:
> > > .../meson-secure-pwrc.o: In function `meson_secure_pwrc_on':
> > > .../meson-secure-pwrc.c:76: undefined reference to `meson_sm_call'
> > >=20
> > > Fix this by adding depends on MESON_SM for MESON_SECURE_PM_DOMAINS.
> > >=20
> > > Fixes: b3dde5013e13 ("soc: amlogic: Add support for Secure power doma=
ins controller")
> > >=20
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reported-by: patchwork-bot+linux-amlogic<patchwork-bot+linux-amlogic@=
kernel.org>
> > > Reported-by: Stephen Rothwell<sfr@canb.auug.org.au>
> > > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> > > ---
> > >  drivers/soc/amlogic/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)   =20
> >=20
> > I will apply that patch to linux-next today. =20
>=20
> This fixes the build for me.
>=20
> Tested-by: Stephen Rothwell<sfr@canb.auug.org.au>
>=20
> Also, please keep the commit message tags together at the end of the
> commit message i.e. remove the blank line after the Fixes: tag above.
> (see "git interpret-trailers ")

I am still applying this patch ...
--=20
Cheers,
Stephen Rothwell

--Sig_/HRS=wqj=EXtghxVG08E8STH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5TB+YACgkQAVBC80lX
0Gw1Ygf9FYA4QbsYVulSaeKZSzIU8INOux2IozBcABlP9zBBHobUJpQC28V80fti
ImqOIwDNv+r67DnCKDg64+X5PfPyOySRYssr9sRSWcjwoud1qt2ln0iez9tDMG0t
B7ntUEWmRAFZ0GtBYqSGZw73lldQRod4lD7B1RrxVK36xIVMUo+X/ZWAEbvlQGn1
oWkoVMxhbDK6crqYBKgTfAVSa2QbpNQV++y0fmmfJUMl/8txhSYEhMIrKr+pr4i6
xHLq3w3J4HJXTo/07+1RjlhgVHdO+e3JyLunOA5MA+aW215AjiCXGcSLHX7PD1QM
mtWa7KCNYCHULAxJs6JOuzD+gOMLLg==
=gH3w
-----END PGP SIGNATURE-----

--Sig_/HRS=wqj=EXtghxVG08E8STH--
