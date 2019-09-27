Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E6CC0C4B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 21:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfI0T5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 15:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfI0T5b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 15:57:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88BE318C4270;
        Fri, 27 Sep 2019 19:57:31 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-20.rdu2.redhat.com [10.10.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96445600C6;
        Fri, 27 Sep 2019 19:57:30 +0000 (UTC)
Message-ID: <7689df508569921295851c83bbb6f5fcd2e3f90f.camel@redhat.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
From:   Doug Ledford <dledford@redhat.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Fri, 27 Sep 2019 15:57:28 -0400
In-Reply-To: <CAFLxGvxm77O7JnVeHjk8xMfAO2_5+PxV7QDkihL5q+86Q1xz6Q@mail.gmail.com>
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
         <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
         <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
         <CAFLxGvxm77O7JnVeHjk8xMfAO2_5+PxV7QDkihL5q+86Q1xz6Q@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+xwQn8O+V8Vnc687ssdT"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 27 Sep 2019 19:57:31 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-+xwQn8O+V8Vnc687ssdT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-27 at 21:52 +0200, Richard Weinberger wrote:
> On Fri, Sep 27, 2019 at 9:30 PM Doug Ledford <dledford@redhat.com>
> wrote:
> > Because there are literally thousands of developers working on
> > kernel
> > bits here and there, and you're swatting this particular fly one
> > developer at a time.
>=20
> I strongly disagree. One of the golden rules of kernel development is,
> read what Linus writes. Especially during the merge window.
>=20
> Thanks,
> //richard

Developers come and go.  Your argument is temporally flawed.  A
developer might start working on the tree, read everything during a
merge window, and not catch one of Linus' rebase rants prior to
committing a rebase felony of their own.

Besides, I don't think this rule of yours is all that universal.  If
Linus is off on a thread about arm64 device tree brokenness and someone
does a rebase and he rants about it, I'm very likely to miss that rant.=20
I read what I reasonably deem to be relevant to me and my work, or
sometimes additional stuff that just jumps out at me.  But I never
learned to speed read so I don't even try to read it all and wouldn't
agree to a rule that says I have to.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-+xwQn8O+V8Vnc687ssdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2OaagACgkQuCajMw5X
L93QUQ//TacqfC4HVxcoDM1NNCIENpLBhSu9mWsQWzUvr/srTywtJgQNj8z1HFPG
Z12DIZLWzFL29cPlNXfKglxxYox/sfEHNa6PDhnLkhfz2KrdDgs+Vj0cMxKQHQJa
GPZt2+aH5Zdn2zUFV/aSt9N3Cx02EwR/Ao+5jYBnoi4DHSN70VcRfXqXwocHkH0R
BzpqeiCaCyigg6zng4D42mICwNJnmRul7VBv6gEFvpNXCTzSbm2FIluAZHrB5Uho
CZVcRdb7Gv6uE8/6WJhmh2hYwRk6Nr0yjD9XXvEjt5yfyzeFQqaoELkuApAakSgb
zOCBbNL3+00ql6PT8f3IujJX0sh66PFbipyq9RB/eoye+8BQ5VH5YpzatMRZCHjE
mF0bV3DujtNR2WTGKBG52EDJQGVdA26qo4GQ5HrlzI6as7NWVaKw2qgj8M0wm6/5
W8XOFfwZ82+BDyP1msEARqCt1T0pkE0Qu84PtDyQEQf4XYw3Rc1eIsCxoS42olo4
uyPQIBx1I8tpz5VLx1DPr96DRUiCkOhoKVltWYVji+t76bRSoKT0BsqQV2kdCpmr
7hYw9fNifgVdYRFq8Sg69QXUoVv/mxae/HSdzEZ8c1K8AblymrdTOqauO1kwFsX9
ns3KcxWkGYuiJ4CVRVIHVJz6gVdLiwzIcW3MHQl1Z9ZBRxcDFHk=
=EL43
-----END PGP SIGNATURE-----

--=-+xwQn8O+V8Vnc687ssdT--

