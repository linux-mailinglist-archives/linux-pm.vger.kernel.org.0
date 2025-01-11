Return-Path: <linux-pm+bounces-20270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E13A0A3D3
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3677C16A709
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEEB1EB2F;
	Sat, 11 Jan 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="oNm44AWN"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB3BE46;
	Sat, 11 Jan 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601674; cv=none; b=mfsv5mSgRBwULZq7i5pfpldfbl/RwoBpLVq/2YL4ZnGzg6i8jtUPd/9kMFTlpJnl4/6QxV4rIICRsSRTaKIp2hlqV3ccQCt8oouzTD3D7+A2QX5FNxZUGhFu7Xml+srCDUIPVAJFGI8QxwHUfVKenV36r1qKiW+O6SaaK3o98WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601674; c=relaxed/simple;
	bh=1Hgf2jXU/hyQ+lyiaIHO9nDf0MzrNH4Jcx3DR8zLskU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8my1sAf+M6TZoGbo6yL13LhRO/XMBUO9Da7BAxUWA6wpoCnCF10XkjDCXbYvmw5oONRhf2NPYPVwllsJXhLnI5WUTaE8Q2H0Eqojx+lmTvNunIVjcGMbF8CtbLSWoi4NpcIZdaOksGfNHPe5DCOGKmJm28TWhmbm9Nrw09khUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=oNm44AWN; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 99F7E1C00A0; Sat, 11 Jan 2025 14:15:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1736601320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8v9Sfufka7EyksT/9xG01KdukKkzPd0yA1vhbaEgHfQ=;
	b=oNm44AWNvaV06Eui+KvKnWJwCWmU5wR6eS1L3e2JDZJ08tH/98l+BtU803oFClyFhuWht1
	ZuKiHpGQO4XXFxFfApEBvISjVM8H0KxwZha9ei1Z4EF3xHM1Z+c3toloOiv1dRTI2SVQJd
	uWGHTpODdjXz6NHXVKYKNGJRVH0db+I=
Date: Sat, 11 Jan 2025 14:15:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] kernel/power: convert comment from kernel-doc to plain
 comment
Message-ID: <Z4Ju6JqtDxMmmv8Q@duo.ucw.cz>
References: <20250111063107.910825-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5ZrSrRmWrhSBppqG"
Content-Disposition: inline
In-Reply-To: <20250111063107.910825-1-rdunlap@infradead.org>


--5ZrSrRmWrhSBppqG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2025-01-10 22:31:07, Randy Dunlap wrote:
> Modify a non-kernel-doc comment to begin with /* instead of /**
> so that it does not cause a kernel-doc warning.
>=20
> power.h:114: warning: This comment starts with '/**', but isn't a kernel-=
doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  *      Auxiliary structure used for reading the snapshot image data and
> power.h:114: warning: missing initial short description on line:
>  *      Auxiliary structure used for reading the snapshot image data and
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--5ZrSrRmWrhSBppqG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ4Ju6AAKCRAw5/Bqldv6
8pCGAKC/+4lXujGpa7wAHXaa5LFzTUaM7wCgiEm7pj+FAxEFrMKdskph9oPvzCE=
=7D5Q
-----END PGP SIGNATURE-----

--5ZrSrRmWrhSBppqG--

