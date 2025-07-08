Return-Path: <linux-pm+bounces-30333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18750AFC2A7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90E27A9F78
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBB21D3EE;
	Tue,  8 Jul 2025 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZvKQPOrY"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13702192EA;
	Tue,  8 Jul 2025 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955958; cv=none; b=VSfBxms8bZjEyFq0BoEMY+v8uvU5/HsBJiDCAglT8o7S0ybAVjV4QnyA47qPwaF6s4YIPPKTErEFqm5XBzNEsVQ+445GYvXfMZ6B80TMtOzzcJtp+uROEGHFql2zNM3+rVcJqIRwxuiVWQ7gNE1Gsumb6ljOHs0goE0DJpwwIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955958; c=relaxed/simple;
	bh=TyqNWs6DVQJpk7zLSRfCnT+tviEDR6p9PGXaZd1Oao8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iypje3i/a1YulYUV2O67Ihqkv9gPX9rUGSlIcrUfbnMUdRqy8a8wPUuT+x5UZxffHDzIjQBYViSVg0OJ+0ByYtcdgsorjLjAwp4YeDKtCkQMLEq9YL3aMZtP0zTCm0prtA+x3aC/YOdh1A9Zhq5a39ylHAjj8FCmh38M1hlYsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZvKQPOrY; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 19C051C00B2; Tue,  8 Jul 2025 08:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1751955947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGgcpchThyaS8l2Hc36HS7Y6M+lQ4b+fg61q8zxLeOE=;
	b=ZvKQPOrYin5rORTW8dGaSBJMLir7d8ooEWy9ttIcBuJyB46y+OScXquCr3SMX+IJOP50RY
	oBNFdZrqqEJNeRsXuJ0Vo1PHHh3ULHGqJW8dMeKBSOWlTlUX6UIZViM4dqfcd6vFe44yyj
	zoVmoyYZxTLY1Zd/ZwoJo+drceiC/Lg=
Date: Tue, 8 Jul 2025 08:25:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, ebiederm@xmission.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aGy56l2BPsD0xf2+@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2tzhd9hOi4+BcZdQ"
Content-Disposition: inline
In-Reply-To: <20250708000215.793090-6-sashal@kernel.org>


--2tzhd9hOi4+BcZdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2025-07-07 20:02:13, Sasha Levin wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> [ Upstream commit 12ffc3b1513ebc1f11ae77d053948504a94a68a6 ]
>=20
> Currently swap is restricted before drivers have had a chance to do
> their prepare() PM callbacks. Restricting swap this early means that if
> a driver needs to evict some content from memory into sawp in it's
> prepare callback, it won't be able to.
>=20
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
>=20
> Move the swap restriction to right after all devices have had a chance
> to do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
>=20
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Nat Wittstock <nat@fardog.io>
> Tested-by: Lucian Langa <lucilanga@7pot.org>
> Link: https://patch.msgid.link/20250613214413.4127087-1-superm1@kernel.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>=20
> **YES**
>=20
> This commit should be backported to stable kernel trees for the
> following reasons:
>=20
> ## Critical Bug Fix for Real User Issues
>=20
> 1. **Fixes Actual Suspend Failures**: The commit addresses real-world
>    suspend failures under memory pressure on systems with AMD discrete
>    GPUs. The linked issues (ROCm/ROCK-Kernel-Driver#174 and
>    freedesktop.org/drm/amd#2362) indicate this affects actual users.
>=20
> 2. **Regression Fix**: This is effectively a regression fix. The PM
>    subsystem's early swap restriction prevents AMD GPU drivers from
>    properly evicting VRAM during their prepare() callbacks, which is a
>    requirement that has become more critical as GPU VRAM sizes have
>    increased.

Stop copying AI generated nonsense to your emails while making it look
you wrote that. When did this regress?

								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--2tzhd9hOi4+BcZdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGy56gAKCRAw5/Bqldv6
8nU4AJ48cp7MxsYXIM3PB6GjjjOtV38NtwCeMtGtDDVKEWDjWn+LFSykRx1TfbU=
=alWM
-----END PGP SIGNATURE-----

--2tzhd9hOi4+BcZdQ--

