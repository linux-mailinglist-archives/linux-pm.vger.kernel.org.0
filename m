Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36886C0C41
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfI0Twv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 15:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfI0Twv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 15:52:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5621E300D219;
        Fri, 27 Sep 2019 19:52:50 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-20.rdu2.redhat.com [10.10.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83D8C5D6B0;
        Fri, 27 Sep 2019 19:52:49 +0000 (UTC)
Message-ID: <4ca02ad4e0c73f1ba2cbfd007f0d63421eaf5ba0.camel@redhat.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
From:   Doug Ledford <dledford@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Fri, 27 Sep 2019 15:52:47 -0400
In-Reply-To: <CAHk-=whwYbKX1AqnOvcdT7T2GofRQqnb6xEJJ6+==ZZN1eEYQA@mail.gmail.com>
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
         <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
         <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
         <CAHk-=whwYbKX1AqnOvcdT7T2GofRQqnb6xEJJ6+==ZZN1eEYQA@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Czlv1FtNDT63hg3iTf5p"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 27 Sep 2019 19:52:50 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-Czlv1FtNDT63hg3iTf5p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-27 at 12:41 -0700, Linus Torvalds wrote:
> On Fri, Sep 27, 2019 at 12:29 PM Doug Ledford <dledford@redhat.com>
> wrote:
> > Because there are literally thousands of developers working on
> > kernel
> > bits here and there, and you're swatting this particular fly one
> > developer at a time.
>=20
> Well, at least these days it's also very clearly spelled out in the
> Documentation directory.

Yeah, but let's be fair.  How many people read the documentation fully?=20
Or even if some new maintainer read it, did it really sink in?  Or will
they rebase a year later not thinking about it?

> And the "don't rebase" does get posted on the mailing lists each time,
> and I've mentioned it over the years in my release notes too.

Lots of people here and there miss those things.  You never know who
caught what.

> Besides, I actually only work with about a hundred top-level
> maintainers, not thousands. Yes, we have thousands of developers, but
> doing the stats over the 5.0 releases, there have been "only" 131
> people sending me pull requests. Sure, more than a couple, but at the
> same time it's not like this is a "every developer" kind of thing,
> this is literally subsystem maintainers. We've got a fair number of
> them, but it's definitely not about thousands.
>=20
> I feel like I've sent that email out way more than a hundred times
> over the last 15+ years.

I'm sure you probably have.  I think I got it two or three times before
I got all the nuances of which rebases were OK and which weren't :-).

> .. and I don't think having git warn is right, since rebasing is
> perfectly fine as you are doing development.
>=20
> It's really just that maintainers shouldn't do it for bad reasons and
> at bad times.
>=20
> And "there was a conflict" and "yesterday" is really one of the
> absolute worst reasons/times around.

I think you send it out a lot because it doesn't get driven home in
people's heads until they get yelled at.  And there's more to the
badness of a rebase than just annoying you when you want to see the
conflicts to judge things for yourself.  There are legitimate issues
such as a rebase wipes out history.  Or if you rebase a public tree it
blows up everyone that is tracking that branch.  These things apply even
to when you are doing your own development.  Or rebases might wipe out
merge commits from other trees, depending on options.

A git warning solely for you might not truly be appropriate, but I'm not
at all convinced that a git warning with a more general "Here are the
pros and cons of rebases, with a list of dos and donts if you are going
to do a rebase" document is a bad idea, and might actually help you out
too.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Czlv1FtNDT63hg3iTf5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2OaI8ACgkQuCajMw5X
L90esBAAgtqGxazxBRC1TCZ/MXobW0SNZNg1fMLwvkWjHjrNqDn9YeeYJFbKgjO8
G35kZK24+IuFL/PG0ztMhboU/0HjZNRwJFHEOSDIKbgx1L9kh2vZGPHeLuqtNWYh
sTh6Tzl8hTfeW9KuQxhc4PKOQkzNbn6tSKM/LoEgYlFWqlTXrpTR7CgRLrPTkny/
qUPqIMKBFmen5NOfGaGckGZ/28i9YEqvunooRmbk0ZHOjURpP/rn6ih7BhBLRVyw
i9IVcQGzQlUqt/kUyIZaljgC2H4lPZFdWxvyIMhKmAPnIhsaqgRyPnzBj+B69Wws
ddz+FEYSNQJ4abFQCS75sREsIPbA/o2GN7OfV2c0bT4skyOEQbqz6ZuJapc2NLi8
8SdLav6wwspFvMX/uanOBDMvsa/hSh6oZtX+HssDCF1RhQcaVLkTekpOFoGY1fcq
ABAq6sol6E80rJYwLbGQ9lnb2jnl3Rbd83/IejvbeTEO6IQ7R8htVzDAtdJ9tzIn
4V1nqq+AL7w5kuzI4UUpFT5BKrGTV83rdM3CS8GRUVXVPl7pQKuQ5+Olo+VKZvEA
U0tYohTIfL5PtxWrw16Fc97IWidCtXIR88ws95Rfn8O9Ut3sWsz1eI9B8YIW6IUD
fpKhAjONcj66cocr4MBALzmVjEz896cnL5dSDaG3JmkyTIYeZGQ=
=ltuJ
-----END PGP SIGNATURE-----

--=-Czlv1FtNDT63hg3iTf5p--

