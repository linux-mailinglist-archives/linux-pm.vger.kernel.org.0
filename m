Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4C32708EC
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 00:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRWZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Sep 2020 18:25:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41310 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgIRWZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2020 18:25:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C90C91C0B78; Sat, 19 Sep 2020 00:25:31 +0200 (CEST)
Date:   Sat, 19 Sep 2020 00:25:31 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Roman Kiryanov <rkir@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, rjw@rjwysocki.net,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200918222531.GD7443@duo.ucw.cz>
References: <20200915172658.1432732-1-rkir@google.com>
 <20200915174643.GT14436@zn.tnic>
 <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
 <20200915182730.GW14436@zn.tnic>
 <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <CAOGAQeqhKS48Kd8W4y13ATT3m+nJSksF_U1SJ=SBrOZFrDq9Nw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-09-15 11:36:13, Roman Kiryanov wrote:
> On Tue, Sep 15, 2020 at 11:27 AM Borislav Petkov <bp@alien8.de> wrote:
> > > I believe the kernel makes a questionable assumption on how clang
> > > uses registers (gs will not be used if stack protection is disabled).
> > > Both kernel and clang behaves unfortunate here.
> >
> > If the kernel is at fault here and this same thing happens with GCC,
> > sure, but this is a clang-specific fix.
>=20
> This is fair. Unfortunately I am not an x86 asm expert. I expect the prop=
er
> fix should land into arch/x86/kernel/acpi/wakeup_64.S to init %gs
> (maybe some more registers) before "jmp restore_processor_state".

That would certainly be nicer / more acceptable solution than patch
being proposed here.

Code was written with assumption compiler random C code would not use
%gs. If that's no longer true, fixing it in wakeup_64.S _with comments
explaining what goes on_ might be solution.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2Uz2wAKCRAw5/Bqldv6
8kNgAKCjTg2A11mig0JlRnhrDpMSV8Je1gCgu1Podyh1Zl2y7FFnMx3zbtS9RV0=
=9X7o
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
