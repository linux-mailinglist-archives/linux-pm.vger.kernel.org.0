Return-Path: <linux-pm+bounces-7245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E598B4E09
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 23:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303E31F210D7
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 21:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4A17D2;
	Sun, 28 Apr 2024 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BLXW08p/"
X-Original-To: linux-pm@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F210F1
	for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341133; cv=none; b=T5vsgjLDHkMSAcO+AxFX+T/Vbt+ivOTJeoF2ua6j+M+88s9YysS2h2/jr0rwqU+0AXQ6liN6qvuEDQVlT/aIop/xdgO+uJqObhi9H2EkJyOvYEP1SxjNLcv1mysCXkCbv1ja2YV7GrF8/5zC1tuh+yCxdo+9CzxqoWxq5xNYXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341133; c=relaxed/simple;
	bh=Of2hrjEBej+wFL5DBz7y8FJ1CDB4cHgoH4+5UZjvMik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQFaw9VgS4YmoaEeuMooBBErgXqeLgHBsQOs2r3ldRAlGtZNtMBAAAUjqAuqzZ3EPr5Khtr7IgfekXKaXFR7ZR8MrTpDvvv2/7FmsYgQm0DyE1GGi8rwBtdepEFza+6lu39JKYg2b1xYz4IHANYL9LC5ECq7mtnwiDluIs8g+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BLXW08p/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714341129;
	bh=LjkGG/qJ3N0NE48xyXny3EMv0MKWKXE2gid2EJtYERU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BLXW08p/tLyuFbClQ3fWU6PtfXbz9ZCQHGaLkg8c88HAfxSKegETvFbIZ9JSgME53
	 ZRqWTmFXPrNGLrDBPhuzvDAwarX0vNQZBwogpOW1lUhD1eE5DvctEKWBAigCsqxxen
	 DIl12HKvkhZKGjSIuFSo1cBaC71ySlQ8ByzWrLIqqhICrFxI0/12u1vQmMrUBX/SMw
	 5I5+xf0TFADgw5P2WWJNSNWnzmNWx0eENNY8GmpV7SUZdtSUnqDQtFV98DrsewP8dq
	 3J9NtXs96sj6uQDJhgNBmW4KEOMLJ1RsbKorPyytb5evm2jB2uarS9uG0RFq+5fuX/
	 lIRkIuYnzxYcA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSKtd3tLhz4wcR;
	Mon, 29 Apr 2024 07:52:09 +1000 (AEST)
Date: Mon, 29 Apr 2024 07:52:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] turbostat 2024.04.27 for linux-next
Message-ID: <20240429075208.79fc86de@canb.auug.org.au>
In-Reply-To: <CAJvTdKmqJx5nnwfxehRRHrYi7mR=6Y8bbrwL083Ain=MhBQq6g@mail.gmail.com>
References: <CAJvTdKmqJx5nnwfxehRRHrYi7mR=6Y8bbrwL083Ain=MhBQq6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n4phAF0ClCC7193psQBeiUd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/n4phAF0ClCC7193psQBeiUd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Len,

On Sat, 27 Apr 2024 23:02:12 -0400 Len Brown <lenb@kernel.org> wrote:
>
> Please add this branch to linux-next:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git next
>=20
> Currently, and in the foreseeable future, I will stage some upstream-bound
> user-space power management utility work on this branch.
>=20
> I do not expect any other trees to touch these files,
> including Rafael's pm/linux-next branch,
> and so it should merge without conflicts.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/n4phAF0ClCC7193psQBeiUd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYuxQgACgkQAVBC80lX
0GwawQf9HtwUqThMlYwHmDK+p4NJod0+q+D/cz5oDZxtTxhw8VvN/6JhNG4gQ+A7
dt07n2PnadYXcr6us6MGu4zkoOtKrd20mKwqdadLZPDF8EzCIrMTqsB+ThDR7SeT
3eRKungWUyRP6SYQ+rs2018LaU/G770nAvZPInqN6OqxSMxRZJ+OEm73vlvQfk32
IQOy1VGl9T6BIlgI8bn5fFQuUqmitTvOePeFsxpcQ84/RbGwkPBW79mcU0+K2kps
1FzLDz+FEIw94/6tpSRrMR1o/6ZKxxDu4iaeooG11wikJ0vsO2AL2tPsEIrBHrO2
mgI2Da/KyaKvXpS0ZGli/0lYVVTydA==
=gfgP
-----END PGP SIGNATURE-----

--Sig_/n4phAF0ClCC7193psQBeiUd--

