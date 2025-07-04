Return-Path: <linux-pm+bounces-30136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1EAAF9226
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 14:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0623189AB1E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8D2D780E;
	Fri,  4 Jul 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk6qiSpR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0802D46B4;
	Fri,  4 Jul 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751630696; cv=none; b=ifOPuIgtNYddII6WPsmYjgemAjbUuijheHqKJ2zhMnU39XDVxkaSFnCnEFgE2+zzPt+hXX7ySehZ1Fsr5wqsNdoRunu/uH+9ZcboTb9mbe2IXdFBcPGs6iaBczPlIx+ZoJOCdURYip+0oWO1sEMIdYtQH2Eyy/nmFmCJNhQEmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751630696; c=relaxed/simple;
	bh=QqBB9/WPBycoCsZ1LeccFyX758STAMMdbqXsnXycT4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkCafDWJcmKVOJKqxFSMo4HGacbzl2OJDWqJZWdGKfSi14+EOCW5l9Q/ed0S/H0RlvqJZn00AIC2Sx2y7rZmZntjFDl5/4fkfE6VZQKR7XLHNNtXvOc9BE6ZNLchqAUbKU0VfA2L5AK3v/xbQtPjk2jZ9qeZRwh5ZAIgSrmQ7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk6qiSpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7CAC4CEE3;
	Fri,  4 Jul 2025 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751630695;
	bh=QqBB9/WPBycoCsZ1LeccFyX758STAMMdbqXsnXycT4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qk6qiSpR1boNUKTJ8Ib4wPiEYZtI31z2Fn0G5w8OKqV0LA0zxzf+UKA//kho6qBM5
	 4MoRjaskxNHn7s3mukBUSGA76rhP1X3Y0/Mlg4cpMttU4UODWFqj86OZtjvaCFTJte
	 1jGg+9JoDZSlqtgjdt6nbx0bolTZoQL9c/V130aTmo4ICRo1ZaP0T1kSMVQXy1MtJq
	 cS7vvMttpj+04qIgOs7Mq5H1uXr5JZfH5CzfxJaBPnqPSV99EL8AKXTE8LZ/pR54SA
	 5LxwJjRVZos45JexFZyLf2yQZI3BjpUVAt5RgAhUTVBEfD0zE65c1pOOL/886Px3QR
	 M8qgvH+LUuAYA==
Date: Fri, 4 Jul 2025 13:04:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 00/80] treewide: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <00203f87-f90d-4a19-998d-1a6b015ea515@sirena.org.uk>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yv8W9SzLoK7c+4Bb"
Content-Disposition: inline
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
X-Cookie: Most of your faults are not your fault.


--Yv8W9SzLoK7c+4Bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 04, 2025 at 10:52:25AM +0300, Sakari Ailus wrote:

> 	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> 		pm-runtime-6.17-rc1

> So before merging these, please pull Rafael's tag. My thinking is indeed
> these would be best merged via the respective trees as there's some
> potential for conflicts (there are around 920 call sites modified here).

Please if you're doing things like this in future could you send
individual serieses to each subsystem - it just makes everything
clearer, for those of us with multiple subsystems it makes life easier
and a series this big causes scaling issues with the tooling (it took
several minutes for b4 to figure out a base...).

--Yv8W9SzLoK7c+4Bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhnw2IACgkQJNaLcl1U
h9Ap+gf+JWy6Fnfx8XgyE5CYZ/M9U+MTDxhjZTr4/R84VZJvubhrPOT9B28px3ZU
Q5BtGPf/4yDZgi7iatt+AWjcJ/lKfIO6LbwiTMke99VBD3h9tQ3T62Wtb5y0eIpz
gC3NwhVSW6LOLhNQbTtHTTukTaSME24dfoOk5sX9mBbhzI61olNY9+lxiPyia7uB
UyQ5Cmjb205kehKvtyR130P/C5knhtzNkJAybCpv45viL2kT8ZvQ7jiQA08wDNtm
bhVA7yLdvmBxYcDoLP5BUfpVmyWmxArO2E5Ioz7JK9THSsjwqib/dCfI8dmaigvD
vAaUvU3rC+Z99iipEp49x7lKsGRChg==
=Hn38
-----END PGP SIGNATURE-----

--Yv8W9SzLoK7c+4Bb--

