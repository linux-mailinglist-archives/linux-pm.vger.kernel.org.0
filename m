Return-Path: <linux-pm+bounces-14976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F022E98AEEB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 23:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FEC283B09
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 21:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6151A0BDC;
	Mon, 30 Sep 2024 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC/rlRHf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE217C7B6;
	Mon, 30 Sep 2024 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731072; cv=none; b=cpfWUm0h9Tio6mjmZ4/sOy+Nv6Kl+IicFjCn8VjvJ+KdVK0F5SefemiELjb6X5G0N8/zMAcoI/QwmGJswIBQqcSjzkLbZ5bfyjv/NYKvIzScYuxQxHO1sLTlsZQk4SJrv6NoOTUn3Jwu1PsUlZExw0MZBkQgl6GB6S4hvxzu0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731072; c=relaxed/simple;
	bh=WrSj9ZX1B9V/JIXDijhV3zCe+pdwc5wf2BlVfULS1Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss8aFZxlsltDbm5sP6fw3s0mcYp8seL8LpMm7b/DUAT+NSkN02bqg6DpLxK3m9oZoVLBxI44VD/FE/XIpTec502RxXWXlTh++5rz3aM9HCc4fimqxlGK6gGnalrT4kp5CDI77BHtNRDVlQIsp2y2S5yw8XpoSAJnwsPItf/hOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC/rlRHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D75C4CEC7;
	Mon, 30 Sep 2024 21:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731071;
	bh=WrSj9ZX1B9V/JIXDijhV3zCe+pdwc5wf2BlVfULS1Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JC/rlRHfg1dx2NVHc3sB43rF+KNlK58NjQoGSF8Meg87Sty/HLR2CC/UPffukU47F
	 fuMmtxsO0deqroK2QQNfxus1waaXd7FK+b/U/j8N85R2oDksfSabmB5GDty2vmyY5C
	 TvAtpfV3Cv7vJdgvJDtOn1fFGfH86GI8+ZE9v2YjVxpJegQD6unJGh5TYmZD+vmhnb
	 rNWtdqTM6oITJUqjSZGe6q4wCluFz8HZXsFQJt+Bql/n5nnQj9zBvFZKct5Q/CnBsv
	 zaupxRDPFDQ6T9vwG70PCTrxOELjIDtEUxEScK/p6DLNf8QAifgYSnOBvpDFY37SVx
	 dyo9g9lSdg7Tg==
Date: Mon, 30 Sep 2024 22:17:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v9 0/3] Add of_regulator_get_optional() and Fix MTK Power
 Domain Driver
Message-ID: <ZvsVfQ1fuSVZpF6A@finisterre.sirena.org.uk>
References: <20240930044525.2043884-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fps6D/pTHz3w7/40"
Content-Disposition: inline
In-Reply-To: <20240930044525.2043884-1-wenst@chromium.org>
X-Cookie: Editing is a rewording activity.


--Fps6D/pTHz3w7/40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 30, 2024 at 12:45:20PM +0800, Chen-Yu Tsai wrote:

> Patch 1 adds a new of_regulator_get_optional() function to look up
> regulator supplies using device tree nodes.

> Patch 2 adds a devres version of the aforementioned function at
> Sebastian's request for the two power domain drivers.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-of-get-optional

for you to fetch changes up to 36ec3f437227470568e5f460997f367f5446a34d:

  regulator: Add devres version of of_regulator_get_optional() (2024-09-30 01:11:41 +0200)

----------------------------------------------------------------
regulator: Add of_regulator_get_optional() APIs

Add of_regulator_get_optional() APIs, which can be used by generic code
to improve integration of regulator management helpers for their users.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      regulator: Add of_regulator_get_optional() for pure DT regulator lookup
      regulator: Add devres version of of_regulator_get_optional()

 drivers/regulator/core.c           |  4 +--
 drivers/regulator/devres.c         | 39 +++++++++++++++++++++++++++++
 drivers/regulator/internal.h       | 18 +++++++++-----
 drivers/regulator/of_regulator.c   | 51 +++++++++++++++++++++++++++++++++-----
 include/linux/regulator/consumer.h | 37 +++++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 14 deletions(-)

--Fps6D/pTHz3w7/40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb7FXwACgkQJNaLcl1U
h9DV0gf+PbBLTWiI3UueE2aB67kwX91wx/qmPQxjrWVV++hT8uZ9AnmUou6nd9xd
yRV87qVjzGK+5Qgrwku1B3I1lqkRwD//fkO9vs7bm32+JhQkhVc+nFe9DknkdZCy
vNHtjaiLQBA6d0ylVnVhGVZxi3OTfAgv++OABCc+o9GfIerkYE7zvg0xmi4ixcxz
DSdLDcpMcoW6L757WEZbuCEX4JPShLiO/MSo0z3ccGE2O73Lp/PqsyQaZhDmKDPA
dd8DsTJ+ciIUYoiYAcFi+YJ3MqAbLAPTf674zHXsWpF3wdvWieif/dXRic+K3cFG
sx/kycHc3xptypkZwFtZDCVgt/IJTQ==
=4qpn
-----END PGP SIGNATURE-----

--Fps6D/pTHz3w7/40--

