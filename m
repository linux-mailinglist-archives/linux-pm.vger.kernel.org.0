Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6CA3EC227
	for <lists+linux-pm@lfdr.de>; Sat, 14 Aug 2021 12:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhHNK4S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Aug 2021 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHNK4S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Aug 2021 06:56:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8A8C061764;
        Sat, 14 Aug 2021 03:55:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 503971F4479D
Received: by earth.universe (Postfix, from userid 1000)
        id C192F3C0C9B; Sat, 14 Aug 2021 12:55:44 +0200 (CEST)
Date:   Sat, 14 Aug 2021 12:55:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] dt-bindings: power: Extend battery bindings with
 type
Message-ID: <20210814105544.subnntwn377fyp2f@earth.universe>
References: <20210805085828.3451909-1-linus.walleij@linaro.org>
 <YRa5UnBcmW1KBIEd@robh.at.kernel.org>
 <CACRpkdbcVJbMnCQ3P1nPmFUsJSw2jgpr2BEzz6GBUQLhBVuO_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdlnqgaczxryuhlc"
Content-Disposition: inline
In-Reply-To: <CACRpkdbcVJbMnCQ3P1nPmFUsJSw2jgpr2BEzz6GBUQLhBVuO_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sdlnqgaczxryuhlc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 13, 2021 at 11:46:52PM +0200, Linus Walleij wrote:
> On Fri, Aug 13, 2021 at 8:26 PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Aug 05, 2021 at 10:58:27AM +0200, Linus Walleij wrote:
> > > This adds a battery-type property and bindings for the different
> >
> > s/battery-type/"device-chemistry"/
> >
> > Otherwise,
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> Thanks Rob, Sebastian tell me if you can fix this when applying
> or if you want me to respin the patch.

No, that's fine. I queued both patches with type changed to
chemistry in the commit messages.

-- Sebastian

--sdlnqgaczxryuhlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEXoSkACgkQ2O7X88g7
+prhuBAApTKrYaOOk4VHbDIBsQZjGyuCOPRtWBC32CFSy+rrhpooaFzkEFxc9LY1
hcXeQgPUotGhfFg2FJUjT7bhrZ/777fV+Lg/Y4dkV2mMvIyndbhwnXJtEKTDg30p
8dRZgjNns83/3YiHbRlW7EPQ60wqxdbLVFFmjK2bxYpdXe3rufn3CyEBVBoRxkCR
A9FHWBuMwUZBABcmUHdCpMeiFynXqfIK5cJq0MUfdPP24aA7NS7d80kz0u2AhmA6
zlV46h/7cNuKJ7hXSpxZ9TShVs6y7Jovz/m+U59dsMj4TrODwFkn+DDHv2DKaB6u
M6lB5wwVj8GAvTlCacFliNmh7Zjthc3hJ/a3nqR/NVA7MoWJsVqpZZa6rF09UqO2
g5kprV5FwhQfnKQVOG8kz5orMgzkYVKkr0tEd+AbFFz7WsYXVOmexq3+4jfHqxKt
aaN0xOz9XmYZlQ17G7oHGU/jfB77/qPHMNN6/huZolRQxHQd9Uy7TX2pd6I6pA9o
SOKApc8f1phJlSZi2TJSRKGAyI0RQnjaNbk8RdSdK3Q6ZDtsdZljWUNR0otvjx0U
Hz6PF0HzxazdQROemrX7t8hs5PYVF7wKc50WsxkF7KzBMss4UsHGKheO4LwGmEGI
odqPVrrsJc4QF1ljTWnsnmDhgNg/hnF0jtn5RxKKctNTKC63Av4=
=49vp
-----END PGP SIGNATURE-----

--sdlnqgaczxryuhlc--
