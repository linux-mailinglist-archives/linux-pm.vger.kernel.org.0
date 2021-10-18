Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7504F4311F0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhJRIPO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 04:15:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54860 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhJRIPM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 04:15:12 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 12BF61C0B82; Mon, 18 Oct 2021 10:13:01 +0200 (CEST)
Date:   Mon, 18 Oct 2021 10:13:00 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rafael@kernel.org,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        sfr@canb.auug.org.au, peterz@infradead.org, gor@linux.ibm.com
Subject: Re: next-20211015: suspend to ram on x86-32 broken
Message-ID: <20211018081300.GA18193@duo.ucw.cz>
References: <20211017093905.GA3069@amd>
 <20211017102547.GA3818@amd>
 <20211018071349.GA16631@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20211018071349.GA16631@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> It said
>=20
> commit 8850cb663b5cda04d33f9cfbc38889d73d3c8e24 (HEAD)
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Sep 21 22:16:02 2021 +0200
>=20
>     sched: Simplify wake_up_*idle*()
>=20
> is first bad commit.

And reverting that one on the top of -next indeed fixes resume on
thinkpad x60.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYW0sjAAKCRAw5/Bqldv6
8n4mAJ44IsbfwqL5y2oE3ZkykKdT9incOwCfR9d1DLDnnS9DOsYExUVe0fyXstQ=
=fxCZ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
