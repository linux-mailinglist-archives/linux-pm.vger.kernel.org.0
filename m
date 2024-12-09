Return-Path: <linux-pm+bounces-18873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CB9EA2B4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 00:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A33A18839FC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 23:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC31F63F2;
	Mon,  9 Dec 2024 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3X04ygD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808719E804;
	Mon,  9 Dec 2024 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786723; cv=none; b=jvPhbyiOvyixSFLrIKQWDL1bm/HypTCcIyvmDRUL+V6uPOxCOq6BHtKBD2xnTsfPbV3MmbVzc4zfawhQ04qx5y9pYh9qdy1dXf8BZ2P9ebU4UnE5y1Jr446ngVaqDvRT/+5eb/MUizvTEBHrCV0U35l4RZDcGCAHCr4GAPzY0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786723; c=relaxed/simple;
	bh=kJNgiFXfK4rIzmA+1NNPZuX53UL/CYVfm0B3Cd1GvdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idCptwEZXAad8S4JDS6Ko5/fAzlwj80aGsQgBoV2j58Ye15EMjqA3HrgYZmA2nTg/glv/eNVZ+H0H4boHeuNqkN9bGzhZyYtxSssbJqYQbKhvqcEkcO9TLgiMHhoLvZpNAfmIyYygoO5J6Jod3/o/LaOkJ35PVW6ONrcvudWGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3X04ygD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B9DC4CED1;
	Mon,  9 Dec 2024 23:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733786723;
	bh=kJNgiFXfK4rIzmA+1NNPZuX53UL/CYVfm0B3Cd1GvdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3X04ygD3C6tbztLB8WvAE7Al4ecqnW451e9yYTDiYIy5ATVRu/hYHE5Kzj49oCt3
	 i9zKvjFJLnpv3MSJrAG6DF/azUwANuVYN+h2YHh1Vl9V8xu5sLfehF2P41ORdgJzHu
	 heMgcF9ssNLwmumz6uKJbpdTWt+E2yuWzfT4FrLsGWafNdwOhDyyjpaLmMuQE3swQ4
	 5DQl0d9wtYe82pR4/963wpjOxxBY+5xjUrXNxrUSwH4mnR+47xHVNyvXfGsslhdMMh
	 6RQ8tFKwIaEUlXOB9iy+608ioi6+yo1uG6Qv1hjDMqNpq/xImWoFsD0McHMVMXTpt+
	 +twzies+WDWVQ==
Received: by mercury (Postfix, from userid 1000)
	id F182A10604B1; Tue, 10 Dec 2024 00:25:19 +0100 (CET)
Date: Tue, 10 Dec 2024 00:25:19 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [6.13] Power Supply regression on bootup
Message-ID: <zcee6jxypyq6uumftgu43rbqt2v6bwdvdu7nriw3iaschjaitu@gevwwgvwdbgj>
References: <93978193-1273-4954-893a-f27528ed1d0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s7kzjnmdhru77gv7"
Content-Disposition: inline
In-Reply-To: <93978193-1273-4954-893a-f27528ed1d0e@kernel.org>


--s7kzjnmdhru77gv7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [6.13] Power Supply regression on bootup
MIME-Version: 1.0

Hello Mario,

On Mon, Dec 09, 2024 at 04:16:00PM -0600, Mario Limonciello wrote:
> I have a laptop here that upgrading from 6.11 to 6.13-rc1/6.13-rc2
> is causing a kernel panic at startup.
>
> I caught it with a crash kernel and it starts with what looks like a race
> condition of some sort to me.  I didn't see something obvious on the list
> about this so I figured I'd raise it now in case it jumps out to anyone
> before I have any progress on a bisect.  I'll come back with more details as
> I have them.

My guess is, that you ran into this:

https://lore.kernel.org/linux-usb/20241203200010.2821132-1-lucas.demarchi@intel.com/

Greetings,

-- Sebastian

--s7kzjnmdhru77gv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdXfFwACgkQ2O7X88g7
+ppj5hAAoAjFh+vTz+txmTNojlCpqUTliFKEnMoChBFM4BoxfDWvfR+Y0KpDQn59
flQJWwpoasdHdfTQ1UE9rN4lekSrqD9tSOO7e3M7VI4blbDw3Ji7BgH8Imv4vMEH
TKXe/yiZnehc8rO/ZB4GhBEw/SLY3dbPEIQVyA37IUf8XxVzzmQBPBlSMsrrXZen
TeD5W0PC2tUtK/QiqduUM16s//2o1ay9zMny3ODlgDp3/w2/qDRL34GwrJqZXtv5
SCqku1vhbDTDC8TohaCBrK32GMinKE9mBe+BfqunG4OVDIgUf7IVrVyLJqr/C020
ebR0eXYV87Ec3G/VO5DUOL/7XWYqz2SobqaRXziRvsA2x7MLHCxHHesIx3LjahKY
66Xo2TFydx5ATSP2+4ooAA2vpnCIUVvb1bsHmYlx7rEuPOmnnlQ7J9ZDgS8d6RTb
4Xw3GralYInQEA7FPbG9UgXAlRSNbe2hz9Kn087ESLXRnzbT5X4zeboxTkA3KSbq
MDO0Df7pkRrmF/Ya6z7RftuuuPzEy8t8AmtQMEBwQOHULj56983tI3LdlcTy6qYD
u8Oa5VJhZq0Mx18FTx3Z0qHpJDg3FDVJoY2IUmMjMb4xD6dLcwHb1GKVbTf64VRY
gLUrKEerIR47Fr/rYk6SWPZvShWQKXtkmFEjiUqu4kMv75WZ5sw=
=JudV
-----END PGP SIGNATURE-----

--s7kzjnmdhru77gv7--

