Return-Path: <linux-pm+bounces-10342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9511E923F04
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 15:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9EB28982
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9715B143;
	Tue,  2 Jul 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWHD15Fx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A3D266;
	Tue,  2 Jul 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927031; cv=none; b=okOOeoDnM0JrdhXQIG6ZZeAjJ3kqLegEdf25quY30lRyfNJQ71VYEra6Xs5ktOOI7N+8ymTBC3yFg5MTvGD2myU33cMg/X3GEj3g9X7Qy9XgnnhU86G5xbnz4TjaKgOgbIR8NB/5J9MHlo2m/2KkOCLgCS92QnT8IAIBLVFSo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927031; c=relaxed/simple;
	bh=t2KXCJRTucXLmExvaxj+W9qhzMExTacZzdR6CL7asoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCvi5zDCQb82VRrc2mUs5M7YPhBNSAcoomsz87yZdkPRefXrDRD+6IiNnj6x+zHb6qKzPGMhV+RS01sMKUZXeFZ14ew+e+iXMMVzih3fLX9lZ2C+Fzvhab2oPySVJv5s6IsfhpKsM4v8zseoeToh3mSkNmD1LFEAK+pw1X6qfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWHD15Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21209C116B1;
	Tue,  2 Jul 2024 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927030;
	bh=t2KXCJRTucXLmExvaxj+W9qhzMExTacZzdR6CL7asoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWHD15FxDSR37FAIvCPTapgLRvz6bUhIdTvjSuyRN2Lwuco9tByxg4HBd9cYO5r9g
	 dGQd+ymEgZCkOb/efvSggkuP6FgFqVlCHC5vXAnyqXh/GxQNPEgstKshIXKGGFwupn
	 Av+KztcHfPdx5823XrMnw0GyyiS+Qgx2KGQgFr5/7JJuzYfd66tLO3G8YXsg4VWSQh
	 AsGznf4fX9iT4+2xPohAj+y+/Z7beta6/MxOJXpmKuKdYMO+xD619ehPhaKdZ0Wuui
	 2gQBsPPtvLKyEHO+vrxfFteYhPqAV+9XSvRPBJlWSslyyUDWAsH+XuZmdR5RWqkdRt
	 eR9ZwSfLAtlPA==
Date: Tue, 2 Jul 2024 14:30:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/6] regulator: core: Add helper for allow HW access
 to enable/disable regulator
Message-ID: <988df019-00d4-4209-8716-39e82c565bf1@sirena.org.uk>
References: <20240616105402.45211-1-biju.das.jz@bp.renesas.com>
 <20240616105402.45211-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IlacYp8TanbdEVDM"
Content-Disposition: inline
In-Reply-To: <20240616105402.45211-4-biju.das.jz@bp.renesas.com>
X-Cookie: Phasers locked on target, Captain.


--IlacYp8TanbdEVDM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 16, 2024 at 11:53:55AM +0100, Biju Das wrote:
> Add a helper function that allow regulator consumers to allow low-level
> HW access, in order to enable/disable regulator in atomic context.

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-hw-enable-helper

for you to fetch changes up to 1cb7d29157603561af4c38535e936850ceb99f0f:

  regulator: core: Add helper for allow HW access to enable/disable regulator (2024-06-26 18:17:05 +0100)

----------------------------------------------------------------
regulator: Add helper to allow enable/disable in interrupt context

Add a helper function that enables exclusive consumers to bypass locking
and do an enable/disable from within interrupt context.

----------------------------------------------------------------
Biju Das (1):
      regulator: core: Add helper for allow HW access to enable/disable regulator

 Documentation/power/regulator/consumer.rst |  6 ++++++
 drivers/regulator/core.c                   | 28 ++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h         |  7 +++++++
 3 files changed, 41 insertions(+)

--IlacYp8TanbdEVDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaEAO8ACgkQJNaLcl1U
h9Bewgf+OWjnlHCrOEnp2tHnOwAfOZV2h87DgiM2wyj09j/nTuAG5n4pRqMcHzn5
cZ1xW5LilEcD6P/MceRyFQ691SazgItdhjPMuonnESk3EfQekcU+gqhEkXdj33TH
UN0qvwEc/gg4gW6BYSOOa6YK85x0NnaWeYsGTR7rrFA5sE+bnLv0u8/Qt5GIYUn+
dXw53pKra6VlK3LvQKsDW62mJzjNNLlvGWcZ6bxcwZDA1b4hUGY6oC6etk5Z44HQ
/RKZpTNgEXAxp24fikixTcFy79swpdBahJrcbRWtO/rlJ06OywlxaKU1RuiqkBfC
1YTlpGYI8Rzwx7+EMAMczXSpVP7lxQ==
=uFPQ
-----END PGP SIGNATURE-----

--IlacYp8TanbdEVDM--

