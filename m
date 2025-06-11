Return-Path: <linux-pm+bounces-28471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231B9AD5228
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 12:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1F918938AF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122526A1C7;
	Wed, 11 Jun 2025 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfrCpak0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D217326A1AA;
	Wed, 11 Jun 2025 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638306; cv=none; b=tPhHwOsO6UQcHln+wYk1mZpGyXpRQX2xFLygbb6u9Iq3tV1qEnxpbJOqhv7TgScOXFahxVufDJE/1yNbUzDEEqmtMrY3r4qSWkqXxBqZlCBtrJCfrHWwXNcNN5VO136Nr2hBQ4J7In1dHohzbrb6aiYH2hSNdmGZ9K/Y+m+jTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638306; c=relaxed/simple;
	bh=lzGBck/xezU6Hf5rxjKTBDz0lcJwARtKGRpfid2YOZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEMgkroLEXvhI+iztLxJyCE1Zhu9ktZMRRKAYeyIJNjp/UHRgKj/8QApzw2EFV1rhnugEtevCNWVRiPtHIz+NYNl5DfVnWkFD9WBN1AYGPFEFpuCEXI6He7fG+Qsa9jLKssHVTIU6kL0ZzKOsqWBqgU8eLaFIpKl0FIRUTdwdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfrCpak0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48939C4CEEE;
	Wed, 11 Jun 2025 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638305;
	bh=lzGBck/xezU6Hf5rxjKTBDz0lcJwARtKGRpfid2YOZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfrCpak0sH8hQQ+tSvYdX7fSSRbsgGpRv9VbBMh0Dinlc1Toa2bTDOcvL+9MNrMvF
	 S2ear4eV9ML5UM9RzDk64YUpwcIYcYvJvbitJuWwSMNk1J6WBG14SufhTnbknN8nPn
	 6ROid72kbnfNukDj4857CVD7AIoRogYhioUbXA1/4rDjqngbtssmP5Up+HOHeDK2ug
	 Qzk8HB/afLsR5lfIKX7jCdrwHxuGDp0y6gVuM++7zD1Ix7e1EFJu6O7VYpuG19R/1A
	 vIuW/Iq/OEMveHnIN85HeJ83lMz12mFq2ABYr4QbI/4KD2JCWKu2bWYUB3TgwXynkm
	 8OhEQ2QssKWEA==
Date: Wed, 11 Jun 2025 11:38:19 +0100
From: Mark Brown <broonie@kernel.org>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v5 3/6] regulator: pf1550: add support for regulator
Message-ID: <a3091d48-8a69-458a-a787-5117c1e8cce6@sirena.org.uk>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
 <20250610-pf1550-v5-3-ed0d9e3aaac7@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rPW3dFZBtrdJaB94"
Content-Disposition: inline
In-Reply-To: <20250610-pf1550-v5-3-ed0d9e3aaac7@savoirfairelinux.com>
X-Cookie: No skis take rocks like rental skis!


--rPW3dFZBtrdJaB94
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 03:47:31PM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>=20
> Add regulator support for the pf1550 PMIC.

Reviewed-by: Mark Brown <broonie@kernel.org>

--rPW3dFZBtrdJaB94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhJXJoACgkQJNaLcl1U
h9DEcAf9ERaavIte118cJiCyIMjV5ez61DDk7UQGhJTnjOYaUbUJLOVq8crmaZbl
RroD0kU8BczOsSgPorfAAlqAo0urkNO4D+/DF20wl+pHinQGc+eb8LoSGuR1JRGe
A8xNzZ4T6lkrlr6CRRlp1QZwsNbsbW8D8I2wohsOlSvXQmnEkrf0loKsPGGupocD
0wqBIPUMY7xTkaRg4aHLDSSX/STM0CDuaHEe2Ix1NOuW5C+EkS/z5pHRs/wKb87b
3ri36lKch8P/6PPCV0t8tuJ1fi0RVTEQG4bMw6MiZ3qF2+PvBRRskWF1ROBlGYNs
CqZ1hWPJ3u2n+ig/CJLJ/2jCGvhBng==
=qXD+
-----END PGP SIGNATURE-----

--rPW3dFZBtrdJaB94--

