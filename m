Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878034317AD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhJRLqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:46:42 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49690 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhJRLql (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:46:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 723EF1C0B77; Mon, 18 Oct 2021 13:44:29 +0200 (CEST)
Date:   Mon, 18 Oct 2021 13:44:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rafael@kernel.org,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        sfr@canb.auug.org.au, gor@linux.ibm.com
Subject: Re: next-20211015: suspend to ram on x86-32 broken
Message-ID: <20211018114429.GA13693@duo.ucw.cz>
References: <20211017093905.GA3069@amd>
 <20211017102547.GA3818@amd>
 <20211018071349.GA16631@duo.ucw.cz>
 <20211018081300.GA18193@duo.ucw.cz>
 <YW07O8ZPLVnbGLR7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <YW07O8ZPLVnbGLR7@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit 8850cb663b5cda04d33f9cfbc38889d73d3c8e24 (HEAD)
> > > Author: Peter Zijlstra <peterz@infradead.org>
> > > Date:   Tue Sep 21 22:16:02 2021 +0200
> > >=20
> > >     sched: Simplify wake_up_*idle*()
> > >=20
> > > is first bad commit.
> >=20
> > And reverting that one on the top of -next indeed fixes resume on
> > thinkpad x60.
>=20
> Can you try with just reverting the smp.c hunk and leaving the sched
> hunk in place? I've got a hotplug lock related splat in my inbox from
> late last week that I didn't get around to yet, I suspect they're
> related.

Reverting smp.c hunk is enough to get suspend/resume to work.

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYW1eHQAKCRAw5/Bqldv6
8qLUAJ44hC68Ns4ZdtainJrvmg3ns95K2gCaAuQ9wYGpx9EmdhQb4+COhERMKdU=
=ocHJ
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
