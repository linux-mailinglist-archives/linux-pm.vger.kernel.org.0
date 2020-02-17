Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DC161C97
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 22:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgBQVHw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 16:07:52 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41879 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgBQVHw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Feb 2020 16:07:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48LxQX2r8Sz9sPK;
        Tue, 18 Feb 2020 08:07:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581973670;
        bh=nxdEeK3aKrGZjzXa1VSBkCfAzQbvnzVXLQPM5aG4gSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjGC7LXOH47DzIYa/wTx9kck7ihEqEtd35QbvysyleLDJEjQ5TjidZYlw4EvotXPT
         CNdW/Ie+nISOjpVQNkI/tAX84t1nI3NLRA87JI2qdzjhr/wqKoazjF/aZDzBdoFHJ/
         VKiMfeoHd21dajc8qvIXzamrO96hG4HVMc0cB+y1K2ZNaauNI5b4V8fczSfEFssmom
         bcxJ8tjrXKbUDNK3b4mJe6iMy1s4xLX80MhbQkSmuBoirvX2wJ5CXGnIT7SwXB6bhW
         Fk+hqPBEet1lc8QjqYiICsTwtN/z5HT49IFmL0HxvrL1iF1yUiIqKGhg72zcBccGxi
         ehRzhNhxUdaFw==
Date:   Tue, 18 Feb 2020 08:07:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
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
Message-ID: <20200218080743.07e58c6e@canb.auug.org.au>
In-Reply-To: <1581955933-69832-1-git-send-email-jianxin.pan@amlogic.com>
References: <1581955933-69832-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PmPWq+6iWpnXtLvAov9NhcT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/PmPWq+6iWpnXtLvAov9NhcT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jianxin,

On Tue, 18 Feb 2020 00:12:13 +0800 Jianxin Pan <jianxin.pan@amlogic.com> wr=
ote:
>
> When MESON_SECURE_PM_DOMAINS & !MESON_SM, there will be compile failure:
> .../meson-secure-pwrc.o: In function `meson_secure_pwrc_on':
> .../meson-secure-pwrc.c:76: undefined reference to `meson_sm_call'
>=20
> Fix this by adding depends on MESON_SM for MESON_SECURE_PM_DOMAINS.
>=20
> Fixes: b3dde5013e13 ("soc: amlogic: Add support for Secure power domains =
controller")
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: patchwork-bot+linux-amlogic<patchwork-bot+linux-amlogic@kern=
el.org>
> Reported-by: Stephen Rothwell<sfr@canb.auug.org.au>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/soc/amlogic/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I will apply that patch to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/PmPWq+6iWpnXtLvAov9NhcT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5LAJ8ACgkQAVBC80lX
0Gzg7Af/boLJ+i4JAZ3psBMn+NTk5UrWqeD9jIY6ZyGmw/9xma882M/tR21D0KEI
S+5mkEFT7PKNvhjUlHhshMB/nYmrPpW/EhlHou1cuNmIGDx9zotA9PJyVGAQ8LW6
J7ajzSnF/aB77dQY4r99qm+FxFZARbrqMC41P+1raM/cz2LjoK+dVW62P9qh7tce
OajY/Qs83loC/fMzdibvV4RAXHAqMThSsEKF5GOswo/d+ySN9LFn0ekSExOklBzE
K/QiBlqMU1leEM2nSgbOXdLjQzsJ87ZOLb9J0PUbP15VKgJ9IX+mTyaYwZblEsDY
k4roNmnelsEhMiyNoFhrdO0rqFWV1Q==
=2huF
-----END PGP SIGNATURE-----

--Sig_/PmPWq+6iWpnXtLvAov9NhcT--
