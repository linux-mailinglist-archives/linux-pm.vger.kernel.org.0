Return-Path: <linux-pm+bounces-14809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D49870D1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C42288001
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FEF1A7AD0;
	Thu, 26 Sep 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ7ET9lU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4191A42C7;
	Thu, 26 Sep 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344583; cv=none; b=FeIcvgfVfk7braXgIwr2zoi85pq9t+Q6Vut5lgGmEjJ3GywEQwDf3/73DhkyTC5TcDXc2H992pfm04353Gl97kcpup+fH+CTBs7GOrx3WXc0VE0545LdnGGmgdRSc18J6DUyTRySdjLFGEDU7OnMU3sMXLO4XuR2zhwg265R5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344583; c=relaxed/simple;
	bh=yg+Cqck74RmfUcynhbDGVfOig5DLOxtYiWBIllwYwqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npr6sRyhoMXKIiMR9UIERSvr6KirjVP2BapRt1wDvg5bX8BIO3Ra7gQcuNdj4Rl5AQRokxltgiDZnThVrI7+SUKc+Caxkxh5mBaJFmAx6q/6CL47QUZ9joaapOVAFsZzr8x4gdTYy/oQC6z2sMmftMG5Fx5t2nQSFQ7/q54axK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ7ET9lU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067F2C4CEC5;
	Thu, 26 Sep 2024 09:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727344582;
	bh=yg+Cqck74RmfUcynhbDGVfOig5DLOxtYiWBIllwYwqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZ7ET9lUGmnWLtzGBDxSKl9HmFYvC4VNO/VHGzXDauQkDRrqbWjm68KfiiwpAy0um
	 7wwf86O4cPEtAxVdKEujAt724qqwVEZYcb9Qs7IuUrzLZvr5QdneKlTSclrCySavJw
	 Pq6nXctf5SGGSEmuL9XLWqAMzJ82UY/BQ6H2jTMc4XycIfhDMZmPt9+2Y1na8OnBBr
	 KIuPuDNqa0URbqne9UMmblUQCz4LJhdm6RY5IUeyFqVLifE9LRCa7eGhcLjxvizyBh
	 J9oMtHU+DF6XBC502YWbttnFEw1shL1R1s33HfI1+JVZAEsFAJ8UX67WCMAhD/ljVx
	 8xo87lkH03PMw==
Date: Thu, 26 Sep 2024 11:56:19 +0200
From: Mark Brown <broonie@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: gregkh@linuxfoundation.org, johannes@sipsolutions.net,
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com,
	pavel@ucw.cz, len.brown@intel.com, rafael@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers: base: Fix typo in the comment
Message-ID: <ZvUvw9xn94fULxwq@finisterre.sirena.org.uk>
Mail-Followup-To: Yan Zhen <yanzhen@vivo.com>, gregkh@linuxfoundation.org,
	johannes@sipsolutions.net, mcgrof@kernel.org, russ.weight@linux.dev,
	dakr@redhat.com, pavel@ucw.cz, len.brown@intel.com,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, opensource.kernel@vivo.com
References: <20240926094122.3984018-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vUsKRndD3F00NBrB"
Content-Disposition: inline
In-Reply-To: <20240926094122.3984018-1-yanzhen@vivo.com>
X-Cookie: Editing is a rewording activity.


--vUsKRndD3F00NBrB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2024 at 05:41:22PM +0800, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.

Please split this up per subsystem.

--vUsKRndD3F00NBrB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb1L8IACgkQJNaLcl1U
h9AdiQf/YqQelVNFgUzMzjjzuHcRqdydkkqXjY4aAKhq4oB+Gicl3WPJqwbLj6T1
WDGCLNW7wb4xluz+pyiZjzWsnyIqrX1vhnEQAHx0n+hHLpT4hLtYw2N2bHyFiYNq
YJZeaHGbl7EwWBGRoqg1Lpw+lnqp1T6yPomlPgAftLxTmAJP7ZrL7QuwJ6cOFiSl
fTlL6UJXOiYbFosgf109EX6S2f1dS40t+2kQ2rGNOmQfdGHR4MnAEOBQ0FSl7u31
fxfhmOI4K+AyA1u7n56cql9zK6HNuTFpQ/wYPIjzOahWli8pPNQsoaBDAYdChmKM
GBoZudoCq19jOXOkhCUTekascYy8UQ==
=P+e8
-----END PGP SIGNATURE-----

--vUsKRndD3F00NBrB--

