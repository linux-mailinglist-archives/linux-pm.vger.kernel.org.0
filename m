Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84A3EBB20
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhHMROQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHMROB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 13:14:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7E0C061756;
        Fri, 13 Aug 2021 10:11:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 469431F4132B
Received: by earth.universe (Postfix, from userid 1000)
        id 41AF23C0C99; Fri, 13 Aug 2021 19:11:06 +0200 (CEST)
Date:   Fri, 13 Aug 2021 19:11:06 +0200
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
Message-ID: <20210813171106.entpro4b6dstho4s@earth.universe>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
 <20210813155438.4ssph6deqksob2uv@earth.universe>
 <20210813155858.GD5209@sirena.org.uk>
 <20210813162029.q5slrkubelfy3mvh@earth.universe>
 <20210813163254.GF5209@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="till3xkqoa2uchbj"
Content-Disposition: inline
In-Reply-To: <20210813163254.GF5209@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--till3xkqoa2uchbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 13, 2021 at 05:32:54PM +0100, Mark Brown wrote:
> On Fri, Aug 13, 2021 at 06:20:29PM +0200, Sebastian Reichel wrote:
> > On Fri, Aug 13, 2021 at 04:58:58PM +0100, Mark Brown wrote:
>=20
> > > We're still waiting for review from Matti on the linear ranges bit -
> > > normally that goes through the regulator tree, do you have a tag to p=
ull
> > > in case of merge conflicts?
>=20
> > He actually already provided his Rb in v5, Gene did not carry it
> > over properly (I added it) and the patch looks simple enough, that
> > Linus will know what to do in case of a conflict. But if you insist
> > I can unroll my tree and create a topic branch for this.
>=20
> It would be better, the issues I'm worrying about are more general
> refactorings or whatever that create actual dependencies rather than
> just trivial add/add type issues - it can make doing some kinds of work
> really painful if things go via a different tree.

There you go:

-- Sebastian

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/ib-mt6360-for-5.15-signed

for you to fetch changes up to 0402e8ebb8b869e375e8af7243044df21b5ff378:

  power: supply: mt6360_charger: add MT6360 charger support (2021-08-13 18:=
37:49 +0200)

----------------------------------------------------------------
Immutable branch between regulator and power-supply for for 5.15

This immutable branch introduces the MT6360 charger driver,
which requires a new linear range helper.

Signed-off-by: Sebastian Reichel <sre@kernel.org>

----------------------------------------------------------------
Gene Chen (3):
      lib: add linear range get selector within
      dt-bindings: power: Add bindings document for Charger support on MT63=
60 PMIC
      power: supply: mt6360_charger: add MT6360 charger support

 .../bindings/power/supply/mt6360_charger.yaml      |  48 ++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/mt6360_charger.c              | 867 +++++++++++++++++=
++++
 include/linux/linear_range.h                       |   2 +
 lib/linear_ranges.c                                |  31 +
 6 files changed, 960 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mt6360_c=
harger.yaml
 create mode 100644 drivers/power/supply/mt6360_charger.c

--till3xkqoa2uchbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWp6UACgkQ2O7X88g7
+ppLYw//Tmxqf+UT+LcdCta9hrvT6tKxd9T2vw6MSJIbp0C77IhaXfKoITwr28Rj
Cq+GI026tp2b9Q8EtZVuKw/44AOWlefD1JusL2AVLV11lrQpt65ULD9YiaXr2Wuq
XbIxE6Q97jVTVcGRtvgOKiG2+IYdS445BtLlVWlljvCl0UnC1Kie30JSlLjNwJ1a
BbpQb8QOmfL9EMByiq8lrBG3TyiCh4gnQ2N8JeOsWBJFzVX5Xw6AFTJfiyKGTEQ+
jOUm7yAcbAP8JoAdjVeYt5h+UX5RvBIlXY0AL10fvFXo+3hCnhvbXVWhWdfXZCXU
CcaTDLZUyLsIM9k9fRwxvYxUs9FIo3+UD+EwZMbDF4TwUQ0Y57uvh3gfhOOw/ZL5
1whGny7xLTFN3jv1UhuKX5+0fUuVtN7jzX4mtWWbtWlReH655LBdVpApq3GkiY3Z
BFnFSEPoQnbzCT1qnFWApaN2NjybgK5xlJVyJ7zhGxlYKDPolBTData35IF0ZdQz
u6hG5atJj1KJYNaQ4yFG54GcU5hzw+/63VONGDfAckuUNletGEC2Lrzb/mCYBDWz
C52e6afwwH0rkmZ9mTdkiKTm/ksxxwiySlKMBAvwOf7dGNULBeUUvIQUVAyiKrDm
Z3b4m1O0WNWXoTjqJoxQUDQUo2QhkRA+ZPO1zzalUDeHmzxG91Y=
=D8wa
-----END PGP SIGNATURE-----

--till3xkqoa2uchbj--
