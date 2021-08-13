Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3413EB9F0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhHMQU7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhHMQU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 12:20:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B55C061756;
        Fri, 13 Aug 2021 09:20:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7D8C11F44AAA
Received: by earth.universe (Postfix, from userid 1000)
        id 6F3823C0C99; Fri, 13 Aug 2021 18:20:29 +0200 (CEST)
Date:   Fri, 13 Aug 2021 18:20:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH resend v6 0/3] power: supply: mt6360_charger: add MT6360
 charger support
Message-ID: <20210813162029.q5slrkubelfy3mvh@earth.universe>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
 <20210813155438.4ssph6deqksob2uv@earth.universe>
 <20210813155858.GD5209@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdfyujkmpuwincfd"
Content-Disposition: inline
In-Reply-To: <20210813155858.GD5209@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gdfyujkmpuwincfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Aug 13, 2021 at 04:58:58PM +0100, Mark Brown wrote:
> On Fri, Aug 13, 2021 at 05:54:38PM +0200, Sebastian Reichel wrote:
> > On Mon, Jul 19, 2021 at 11:39:11AM +0800, Gene Chen wrote:
> > > This patch series add MT6360 Charger support contains driver and bind=
ing
> > > document
>=20
> > Thanks, queued.
>=20
> We're still waiting for review from Matti on the linear ranges bit -
> normally that goes through the regulator tree, do you have a tag to pull
> in case of merge conflicts?

He actually already provided his Rb in v5, Gene did not carry it
over properly (I added it) and the patch looks simple enough, that
Linus will know what to do in case of a conflict. But if you insist
I can unroll my tree and create a topic branch for this.

-- Sebastian

--gdfyujkmpuwincfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWm80ACgkQ2O7X88g7
+ppouw/+MI2zSWoohv5esyfj7NAMNCDyaDrbHkrd4z1MhbA/awpyh8lTnGUwu8kk
caD03Omd6l/Pnsx+F4w6/SApqn3HxUrK5ge+6EqVczzWFGRtOHNhuksVEwa+EFxJ
w+iHtH0TABaKcbOXiwrGiRFu6VnOiODF2tn9EhVOS9LC5Rph01ixBxw9djbqZiKX
fToqLHwu4aEwScM1HRbp93ce5p1Iocx2AZBTT3cUk8DWSheIwW3UZVbh8jIE6amA
0DhakGzOSM62RFRq2rL0ZOsYxr74cpjt8e/onPTCmhFaFFeYVKs+x4sx15G7LAGV
hffKGf1yuxf7E0AshZDO1c1bk1qvwfdO7x+YoTNCoyoRH/xrcYgvZtQolzDk8AJM
b3jc6Y9y+mqSDCEStt7SyBxiK/YYjAonoS8zoA7BuMD/WgLiqCdZ+d+RUXZJ3OZQ
GWavHPZN3IafKG2B8pwHeP0ZftUStGUgozseGKxUc/AzwGE99toVYTb9UNOaGFkJ
pS2/077on37yQJy3OW6LWtd3v9DINSut/nra8IdC+Wz7ZqkEqGUmNvf72Y4g8KsF
ubMRl9ojT2KfLiwizAFuIHs7zuKzuBHMZ6VuDo9HSy4baXjsqM73b5NQKfLJY6U1
uPQYdGYY54Pkty/dzHwxK2PHFtHGtwsvWqkdTdEwqnDeD66/tPQ=
=fs0n
-----END PGP SIGNATURE-----

--gdfyujkmpuwincfd--
