Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DE72708E2
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 00:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIRWUJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Sep 2020 18:20:09 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40836 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRWUJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2020 18:20:09 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4D1361C0B78; Sat, 19 Sep 2020 00:20:07 +0200 (CEST)
Date:   Sat, 19 Sep 2020 00:20:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Pavel Machek <pavel@denx.de>, Roman Kiryanov <rkir@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200918222006.GA9613@duo.ucw.cz>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915221708.GA26453@duo.ucw.cz>
 <CAKwvOdnuR9GF2tZuyS7Fe8i-S0W2YZ45qP8xJRm_gf+g+oF4=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <CAKwvOdnuR9GF2tZuyS7Fe8i-S0W2YZ45qP8xJRm_gf+g+oF4=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > When load_TR_desc and load_mm_ldt are inlined into
> > > fix_processor_context due to LTO, they cause
> > > fix_processor_context (or in this case __restore_processor_state,
> > > as fix_processor_context was inlined into __restore_processor_state)
> > > to access the stack canary through %gs, but before
> > > __restore_processor_state has restored the previous value
> > > of %gs properly. LLVM appears to be inlining functions with stack
> > > protectors into functions compiled with -fno-stack-protector,
> > > which is likely a bug in LLVM's inliner that needs to be fixed.
> >
> > That's rather ugly.
> >
> > Would it be easier to simply mark those functions as noinline or
> > something like that?
>=20
> It is possible, and a possible solution here.  We discussed that
> internally, and found it to not be great.  You only want to prevent
> inlining across TUs for LTO; currently there's no great way to
> express

You should really be doing such discussion publicly.

I believe this is not performance critical so just disabling inlining
(maybe conditional on clang) is best solution.

> compiler.  You could emulate that somewhat by wrapping the noinline
> attribute in CONFIG_LTO_CLANG, but that doesn't solve allowing
> inlining within the same TU.  If you've been following the thread,

Yep, just do that.

BR,
								Pavel
						=09

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2UylgAKCRAw5/Bqldv6
8rWCAJ9Fp0OpY6fGqTH6b2GhLDTwbMbekwCfds2FVCLJnzptO8yPH3xumtsCwOQ=
=qDxw
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
