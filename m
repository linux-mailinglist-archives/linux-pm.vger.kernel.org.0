Return-Path: <linux-pm+bounces-31889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159C1B1A155
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331F816287E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1252E257459;
	Mon,  4 Aug 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfybmt22"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33623817D;
	Mon,  4 Aug 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310267; cv=none; b=IgZ73GF4898gPcKgd/SyzYLDsvK+tGfRyO/ZsbRo80UFInyGHW8qjTi6eY5DeSIbE1/n1upHVr9HGR26Iexh3e8t56dIBr9I2w7vTuVKq5p6ALIRiOYIohb/zfsjmSrwfVdIjJ4GdRTdqSJxEVWlCj6VJWllT9WakSn6sVCTMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310267; c=relaxed/simple;
	bh=bkwZgyJhQDmHzonI+LQ1V7J2vFMO9gc7MkhZX5tyXMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2KWE/G7fv6YnFXGibcslB4MYCgCF9/nsFfNtD/N9QpUeZakRTCP8NXlAOP5h3gj5kp86wQ+GvN3XNNCp5vUP019W2TjL1aXZIQMWnGoE4ViNKFXYXg3PylVwMC9iywRDE9OiNC8sGZfleI/0zSEDvSCKZY33i2yo62eOAEqrd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfybmt22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BCFC4CEE7;
	Mon,  4 Aug 2025 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754310266;
	bh=bkwZgyJhQDmHzonI+LQ1V7J2vFMO9gc7MkhZX5tyXMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tfybmt22jKHdfyRIKUevHxxBDRWk6mGh7Z2yGNPtcNyRcX65OLSLQMBYVRM1e6Kqq
	 BtuviDfu/KqvYKp6VQEQgCIqw5GBeWsAQ4FqI3XNbTFQrQH3CKw71tl495dF3qBWz8
	 OuBHUfhCdMSZWmmmifuYzlHBjhY0ty/5mEqBTE3r2oOzd2kh57SaubiGtsGygsAFbQ
	 W3tSv0ta5vjhK2nugqpk3QWAxapBx9JJhfFUuM0JsAOiSGJoxtNAcvReajQOOPOFxv
	 /oHGbMoZInw43o2I6GX5ByrYr10Wj3I0CmkGbvZEOj+eEpO4QlF1N8N3nIUoORzO4a
	 3Wat6twnEyyow==
Date: Mon, 4 Aug 2025 13:24:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ry111@xry111.site, Dave.Martin@arm.com, ahmed.genidi@arm.com,
	kevin.brodsky@arm.com, scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 01/11] arm64/sysreg: add system registers SCTLR2_EL2
Message-ID: <8451ed4b-7881-44b5-84a8-51cdfefff464@sirena.org.uk>
References: <20250804121724.3681531-1-yeoreum.yun@arm.com>
 <20250804121724.3681531-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QXyWowRG1xuUZNLB"
Content-Disposition: inline
In-Reply-To: <20250804121724.3681531-2-yeoreum.yun@arm.com>
X-Cookie: Shading within a garment may occur.


--QXyWowRG1xuUZNLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2025 at 01:17:14PM +0100, Yeoreum Yun wrote:
> Add definitions of SCTLR2_EL2.

When adding registers it's useful to quote the revision of the spec
you're referencing, this helps people doing updates in future (eg,
DDI0601 2025-06).  The update looks good:

Reviewed-by: Mark Brown <broonie@kernel.org>

--QXyWowRG1xuUZNLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiQpnEACgkQJNaLcl1U
h9CcBwf9GiP4bpNbz/SUgAbK7e4d1KY3dHM9fA/NoEjouAyr3z4GGftmo0j+u+3l
f+F3EdQYM8DAzRw1pn++ykB92zaa4SYpdk/cWpzHI8KY2R76m9odebfutA84O/qA
ixu7DHD03Bjd0ZRjpb9SXMu36HT2rpnuP4qpZ1msZjunX5jmWPHblZ8cI91go/VJ
GSHSrFn8dCzf2rTYuJWWVhicxorOZDU2/d075LBvOTwMGV1dvPVbl6wiCm88qx3b
JfbIPlNgjvnGe0fIkzX5QbciX3m7zJg1/DlI4VT/DXzW5Bss10Pe8YIjfPDfzoyI
8XlJablGPqi24NGkLmS8euCOqArX/Q==
=m8fU
-----END PGP SIGNATURE-----

--QXyWowRG1xuUZNLB--

