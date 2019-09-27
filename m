Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED39C0C16
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfI0T3v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 15:29:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfI0T3v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 15:29:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E21F33082137;
        Fri, 27 Sep 2019 19:29:50 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-20.rdu2.redhat.com [10.10.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 318826061E;
        Fri, 27 Sep 2019 19:29:50 +0000 (UTC)
Message-ID: <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
From:   Doug Ledford <dledford@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Fri, 27 Sep 2019 15:29:47 -0400
In-Reply-To: <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
         <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8QpI9/NYV64F34cjfsuA"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 27 Sep 2019 19:29:50 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-8QpI9/NYV64F34cjfsuA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-27 at 11:34 -0700, Linus Torvalds wrote:
> On Fri, Sep 27, 2019 at 6:08 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > One thing to mention is that, all the patches have been tested in
> > linux-next for weeks, but there is a conflict detected, because
> > upstream has took commit eaf7b46083a7e34 ("docs: thermal: add it to
> > the
> > driver API") from jc-docs tree while I'm keeping a wrong version of
> > the
> > patch, so I just rebased my tree to fix this.
>=20
> Why do I have to say this EVERY single release?

Because there are literally thousands of developers working on kernel
bits here and there, and you're swatting this particular fly one
developer at a time.

I might suggest that you need to speak with the git people and politely
ask them to add a warning to the rebase command itself so that it prints
out something like:

----

If you are doing linux kernel development, and you are doing a rebase,
please read Documentation/When_Not_To_Rebase.rst before rebasing your
code and sending it to Linus.  You've been warned.

Acknowledge receipt of warning and proceed with rebase? (y/N)

----

You would have free reign to put one of your more monumental yet funny
rants in place in the documentation.

You could also have a global git config to turn off the "Don't annoy
Linus with rebases" warning.  But only mention that global config at the
end of the kernel documentation so you know people have read it before
they turn the warning off.

Maybe that would help.

> A conflict is not a reason to rebase. Conflicts happen. They happen a
> lot. I deal with them, and it's usually trivial.
>=20
> If you feel it's not trivial, just describe what the resolution is,
> rather than rebasing. Really.
>=20
> Rebasing for a random conflict (particularly in documentation, for
> chrissake!) is like using an atomic bomb to swat a fly.  You have all
> those downsides, and there are basically _no_ upsides. It only makes
> for more work for me because I have to re-write this email for the
> millionth time, and that takes longer and is more aggravating than the
> conflict would have taken to just sort out.
>=20
>                    Linus
--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-8QpI9/NYV64F34cjfsuA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2OYysACgkQuCajMw5X
L90VIhAAk4jcZJRijjuESGrODGMdq/AM+xnSTztebqGgWciuhlh2Z/WU30wi0kbF
XT18gkS8YSPm1bmvBwYy9a0daQu41XLegvOyj+LoeoEbUCmhyxnZpA/SQysfau5v
eyXhCBZYi36nOtBiOuhncTSyQqP/QpF0ck6Ygs4WYgj04CVGIURg8PTDqR9/nu9L
u+j3qhtxUGU5VfcAK1CVss2Zm+zZWb7FQIqZDYvpOee6S2AKo793Y0pIykeMScrr
Xv8qqrOXmC8aPqQBpzwnEtMgN19LgabPpGhFkO4nsiXFBRqK/t1heHNdyZRWqVcv
Ac6o9+OmNJ7YaVpL61kobwk3v6cZuJlFsGdjD7AMpcLtFYZslRlxA11+OUlreAFV
A8uWKLtNAvhYmm8GFTKCXJ00DZGj/5/eHoGOaBhFN1bZ43CuDkSyxmM/Q/XM02Ab
q6ThGcX0/XOj+Ccb4a0Kl5hdG1w8UW8+dwVb1yBVKbDEwFHNx1ntMHLgw+s9eTGT
7xKtL8tXFEh2Di7L8YS9XeTGciooa8yHo0nhXrh1Awu4MKbWIgf3GkoSat2RiyO2
NoubaPBUEJaeM3FfgO38aU1cQU8OLnOcUWjMfQlOrVKaivp1os6c8lsDt9OvOWhf
/t61QnNxiJIkBobNERwBEsUF5LkLX59H5cA4bTD++6ymvHR3VLE=
=tHNu
-----END PGP SIGNATURE-----

--=-8QpI9/NYV64F34cjfsuA--

