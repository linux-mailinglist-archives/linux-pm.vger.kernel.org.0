Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45C0AC6B7
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 15:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390138AbfIGNK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 09:10:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57860 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389683AbfIGNK2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Sep 2019 09:10:28 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8C93D8183B; Sat,  7 Sep 2019 15:10:11 +0200 (CEST)
Date:   Sat, 7 Sep 2019 15:10:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/asm/suspend: Get rid of bogus_64_magic
Message-ID: <20190907131024.GA4430@amd>
References: <20190906075550.23435-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20190906075550.23435-1-jslaby@suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-09-06 09:55:49, Jiri Slaby wrote:
> bogus_64_magic is only a dead-end loop. There is no need for an
> out-of-order function (and unannotated local label), so just handle it
> in-place and also store 0xbad-m-a-g-i-c to rcx beforehand.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  arch/x86/kernel/acpi/wakeup_64.S | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wake=
up_64.S
> index b0715c3ac18d..7f9ade13bbcf 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -18,8 +18,13 @@ ENTRY(wakeup_long64)
>  	movq	saved_magic, %rax
>  	movq	$0x123456789abcdef0, %rdx
>  	cmpq	%rdx, %rax
> -	jne	bogus_64_magic
> +	je	2f
> =20
> +	/* stop here on a saved_magic mismatch */
> +	movq $0xbad6d61676963, %rcx
> +1:
> +	jmp 1b
> +2:

btw I suspect you can simply do here

1b:  jne 1b

=2E.. if someone is looking with gdb, he'll understand what is going
on. no need to bother with special %rcx, %rdx is already rather magic.

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1zrEAACgkQMOfwapXb+vIeZACfcTkUyDEalzzN3zbqAS5xl2CF
HUwAn0YkpbYtbVUqojF84r5VTahwheAo
=lKXd
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
