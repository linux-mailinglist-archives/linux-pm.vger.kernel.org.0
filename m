Return-Path: <linux-pm+bounces-29505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84DAAE8315
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5761C230DD
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF0A262D0C;
	Wed, 25 Jun 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci3Vkzq0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF772620CA;
	Wed, 25 Jun 2025 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855558; cv=none; b=FQypVWddUvZkFdJOWrL/LlE+IG7mrtPTaP96kQ+mNaaeHuSMA9rf3GJHS7gO4Gt0s1aZh76aSJxK4V6Iqbzlyjvqkisrr5pTVLQPuqIk70ATU4l+AOAEkds1kMc8hfZOH+/Yw0eFvkji3GbwlnLOioiLZBswico3gSs5+gIlISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855558; c=relaxed/simple;
	bh=MxSwS/c3MkpoOIQEtE7TxBLZiOkUfz/dz5gbPMFBRss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvvuh2GCBPPjN0bpV6H+R9OUmeQ1Qlb7T6CEmR7G6sPhV87WqoCt/y1fvD7IyOb8hoJ80+AKGSTI92cw2p9UwcUqCS7GOOSg/QSf9uxU6yi6AV+4j+HfDljS+2UNvc0uTkBBiPWhAyqL3Pb5SrrGFJi0B/q0yd7IRkfTW0wncNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci3Vkzq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC7DC4CEEA;
	Wed, 25 Jun 2025 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750855558;
	bh=MxSwS/c3MkpoOIQEtE7TxBLZiOkUfz/dz5gbPMFBRss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ci3Vkzq0CO/B5RaEvCVERNHN2k8J15szNfNrx/Jz2ujCSJhooPBnw1WOOukIYPY9g
	 3XBwQaAUNNYHZEgXEMOwedAmTYNoPNdgzY/VyQJ0lcNWI/+CRGL2/w4tL30wW9b3Bz
	 bemwwwf4UZaXZd0YXQ+0bL3NAhBWQJkbgcH8qhZzxyaduRF0dFriBmoMuGIAwObRvE
	 nk0fq+h9jErAMT6szw37AYFWO7Sn+C6zz+fwfG5yZqMag39CMA7b37LlrG00RD3fO+
	 LL6N+r9o3sta8a7X24ORYMCVHPvk0jn9221AJkctZFW/a/gGAZHgCFH+CHsAgGIzun
	 ANOlVo8fLCt5A==
Date: Wed, 25 Jun 2025 13:45:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, lgirdwood@gmail.com, sre@kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 4/5] regulator: bq257xx: Add bq257xx boost regulator
 driver
Message-ID: <92fc643b-3ef4-40f5-93e4-cc7c16e461fb@sirena.org.uk>
References: <20250623162223.184304-1-macroalpha82@gmail.com>
 <20250623162223.184304-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XfbLf5ezv7/iStxc"
Content-Disposition: inline
In-Reply-To: <20250623162223.184304-5-macroalpha82@gmail.com>
X-Cookie: He who hates vices hates mankind.


--XfbLf5ezv7/iStxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:22:22AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add support for the boost regulator found in the Texas Instruments
> BQ25703. The boost regulator is capable of outputting between 4.48
> and 20.8 volts and between 0 and 6.35 amps.

Reviewed-by: Mark Brown <broonie@kernel.org>

--XfbLf5ezv7/iStxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhb74AACgkQJNaLcl1U
h9C9yQf/UDpz47ltA1sKs2voaIQHw0rC3X6BnaMmd4FZypOTbU0om42KvCrdnXDJ
GHVARVAWEMDJ3Nd6AyGE3z3mqkg3ojjiVFYOVCR3OpvaFIU27Qr/lPN0+JrChNgD
DSsib9j7vIv3s00zqtsafqdxDZqZ491/i4KhGKWg9Ss6KxBBGrMnMV/MpSgq2u+c
BmNRa9nbYOONjWV3SfytuLGVZ3DkbPlfrNHZwyx1+ZjFZrie78ZwvaXfmy8j9kMV
9mHs7/LUBj4UlnWNal28u19IlI8eJX3Pzae+TYdKkIi0ahBms8CBgEzN7lF8rG7p
xB850eF10a7ySgMa0L2apcoNkzryDQ==
=M2Wi
-----END PGP SIGNATURE-----

--XfbLf5ezv7/iStxc--

