Return-Path: <linux-pm+bounces-22810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B320FA421B9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F7F188D3F7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605924888F;
	Mon, 24 Feb 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxSzvoWC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CF157A48;
	Mon, 24 Feb 2025 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404796; cv=none; b=YGPrXffdydsHOiCZ/Fta9EDzA+ZZc5pqhoz39GLysr0/TrsubmXvyYF6jklCoukROWziKIH3UYpaCX1wyeYy19M1i4L5qWJAmWirzhsAlojuTsZRytrFW1Ph6PtsqCsDPgC6yUJ/P9bn8yisr09cQPg8gWBQ1l+cr2TNj8BfuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404796; c=relaxed/simple;
	bh=GhSf3n9clDXFTWmYTdpg1IkSzgVc80lXwe20AXbLTcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUpQgbRQfyga8HeSSN36TfTZB0iAIK9XansTxxdE4e8I+9yIhkJiVnU9fYBAPffyjDeLgf51bA5cTtgocf0L3eqTphfX1ECsojAMymdrlKrssK7eB6YqbdKNVp468cePWbCXH9c4lwl8mimNTp658ShfjBybbAcoUI4/isp6ems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxSzvoWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146F4C4CED6;
	Mon, 24 Feb 2025 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740404795;
	bh=GhSf3n9clDXFTWmYTdpg1IkSzgVc80lXwe20AXbLTcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxSzvoWCrxdpqOdBn2NA1QWKabhD124xoFC1Yl0TIz2RbPgligt/ZxNjw6E1FkuSR
	 wMH2iqforUVtdO/Ot6cE8hQsMstuyGoN6RpcTphA20ppw1zxFHGV4LLuCLSsrGIuyC
	 smwT9aEOR1+tRpRhvrAwkQa3w5rOJSpUS/6a/Ffz0kZjXOOuZa4MZ+rwWYGvT8+QiD
	 Cg1wHJAW0gwIpcmcqBXNw27cTPAOywyQzSzgAp7U4/0cMSlYxRan87WRPxTIDE6FE7
	 3McHVaLEC+6Y1V1aQ7/QHa884TJuMJHKQfAZQUa+y7sm6NOgzSkSiKELz/afBuTb4K
	 874hbazc2erhA==
Date: Mon, 24 Feb 2025 13:46:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, deller@gmx.de,
	andriy.shevchenko@linux.intel.com, sre@kernel.org,
	sakari.ailus@linux.intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, jdmason@kudzu.us, fancer.lancer@gmail.com,
	linux-sound@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/13] Convert to use devm_kmemdup_array()
Message-ID: <31f8302b-96be-41f1-9e58-c9f8cb2a9524@sirena.org.uk>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="55NteQvh/2EFKMVB"
Content-Disposition: inline
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>
X-Cookie: Phone call for chucky-pooh.


--55NteQvh/2EFKMVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:23:20PM +0530, Raag Jadav wrote:
> This series is the second wave of patches to add users of newly introduced
> devm_kmemdup_array() helper. Original series on [1].
>=20
> This depends on changes available on immutable tag[2]. Feel free to pick
> your subsystem patches with it, or share your preferred way to route them.

Please don't combine patches for multiple subsystems into a single patch
series, it just makes everything more complex to deal with - it creates
cross tree issues that wouldn't otherwise exist.

--55NteQvh/2EFKMVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8eDQACgkQJNaLcl1U
h9DFYQf+POnj8ermDn0Tw9XG/X8r7XNhLSk5wb0yK1OyIN1hYGZUP2qcnBFxH+ms
dGEvY44PF4R2Imam49wf7QGqhfidWrrVDp7+U9HxGI70TLYVtCRNV06ZmWvUiKkZ
KGiGaiY1hmADDRc4Xz78QPBDRpOp12Admq5fFAxMrtRaeW64E4QzWX8AoHUWW8LQ
53Q+JH0Y4zO4JW8wXAGQnFgvF2HJ1z0at63H+XJK56p/pE+qO+Dy9Cg51nimGKA8
Wa+MXvcB7/lsdwMx/bDk/SU+bM287BI4q//RWXwK6Tlzs4DUoe2cmZuzuZC+u4aj
E1alazYzvMrO1nm1Tl8FT6F9s7+wQQ==
=XiDk
-----END PGP SIGNATURE-----

--55NteQvh/2EFKMVB--

