Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002C926B0B1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgIOWRn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 18:17:43 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34280 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgIOWRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 18:17:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BF29D1C0B76; Wed, 16 Sep 2020 00:17:08 +0200 (CEST)
Date:   Wed, 16 Sep 2020 00:17:08 +0200
From:   Pavel Machek <pavel@denx.de>
To:     rkir@google.com
Cc:     rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, ndesaulniers@google.com,
        adelva@google.com, Haitao Shan <hshan@google.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200915221708.GA26453@duo.ucw.cz>
References: <20200915172658.1432732-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20200915172658.1432732-1-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Haitao Shan <hshan@google.com>
>=20
> This is a workaround which fixes triple fault
> in __restore_processor_state on clang when
> built with LTO.
>=20
> When load_TR_desc and load_mm_ldt are inlined into
> fix_processor_context due to LTO, they cause
> fix_processor_context (or in this case __restore_processor_state,
> as fix_processor_context was inlined into __restore_processor_state)
> to access the stack canary through %gs, but before
> __restore_processor_state has restored the previous value
> of %gs properly. LLVM appears to be inlining functions with stack
> protectors into functions compiled with -fno-stack-protector,
> which is likely a bug in LLVM's inliner that needs to be fixed.

That's rather ugly.

Would it be easier to simply mark those functions as noinline or
something like that?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2E9ZAAKCRAw5/Bqldv6
8veRAKC2hGsrYPDP5OFAonBor0AIsn8EYQCdE67psrFL/QvNy3nROUmdaSHaoIY=
=xRPX
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
