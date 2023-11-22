Return-Path: <linux-pm+bounces-76-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DEB7F461B
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98A4B20AFD
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254A4B5AC;
	Wed, 22 Nov 2023 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhTOfsuJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A867C1A58E;
	Wed, 22 Nov 2023 12:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F08AC433C7;
	Wed, 22 Nov 2023 12:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700656015;
	bh=7C94KGgqCbAA+PUlPyfufke9xGPCyJuKoPOwMFmpILc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhTOfsuJH4uNL1dxrl8w5XllqdE/f5P54GaWxyRB4RLrlVOx4OyzJwbd6Gc4C0qoc
	 2Xzg/stYnSjW+1yxZNxWDcAYThqfSNZGkvn072cy+9S7PCy1DxLfO5WnFrM4sglE4g
	 EuZC1EWJwysoGdyUFGg5RLFi86qdKMxadsVE7CU1Jjc8qMWIzG4yHLhIuuE0rKZSQ7
	 NqT314x2NNAPQt/bksxbzuhb5k9BmoxRKLTBS+b69yrPvvHLfymaaDCmqGBTY0NX4f
	 cDXxKth36fatyNGSrEVz8QGzuXhCd95sNhXtTb/LABHPfeC2qDN6Jz2bV0b8GEMhAr
	 ESh4d4/F0DKAg==
Date: Wed, 22 Nov 2023 12:26:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org, kernel@pengutronix.de,
	Ye Bin <yebin10@huawei.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>,
	zev@bewilderbeest.net, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: mmc: handling of Under-Voltage Events in eMMC
Message-ID: <ZV3zi7jgkBa2W/Fc@finisterre.sirena.org.uk>
References: <20230929130028.GB2825985@pengutronix.de>
 <CAPDyKFqUtNEbK2tzD+qOK+dFcDyBxvcNwOHWPJDLhTWGGkoHQw@mail.gmail.com>
 <20231122112212.GA783262@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GytIA0m4jn6r4+oY"
Content-Disposition: inline
In-Reply-To: <20231122112212.GA783262@pengutronix.de>
X-Cookie: Slow day.  Practice crawling.


--GytIA0m4jn6r4+oY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 22, 2023 at 12:22:12PM +0100, Oleksij Rempel wrote:

> Some puzzle parts are now mainline, for example regulator framework
> can be configured to detect under-voltage events and execute
> hw_protection_shutdown(). So far it worked good enough to complete
> mmc_poweroff_notify() withing 100ms window. The problem is, the chance to
> execute mmc_poweroff_notify() depends on kernel configuration. If there are too
> many drivers and devices, mmc_poweroff_notify() will be not executed in time.

> For now, I workaround it by registering a reboot notifier for mmc shutdown.
> It works, because kernel_power_off() is executing all registered reboot
> notifiers at first place and there are no other slow reboot notifiers.
> But, it seems to be not reliable enough. Probably notifier prioritization
> is needed to make it more predictable.

> So far, I have two variants to implement it in more predictable way:
> variant 1 - forward the under-voltage notification to the mmc framework and
>   execute mmc_poweroff_notify() or bus shutdown.
> variant 2 - use reboot notifier and introduce reboot notifier prioritization.

> Are there other options? What are your preferences?

My instinct is that we want to have prioritisation scheme rather than
something MMC specific, I'd guess that this issue applies in some way to
at least most storage.  It's not a super strongly held opinion though.

--GytIA0m4jn6r4+oY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVd84sACgkQJNaLcl1U
h9Bf8wf/R6d4p2XKeuQW+1xTu9FLSsr7+z0oM/onpGR9JY0w2ky0IFjZjmbxN9U8
YMxvuqD/mgLNzjJe7arFUiIpbNe7VNVSM56znjxHg8UadfPHYW9ImNUO14OwkCZN
qXzMYsNpQhrc5/kNxs2pNso4Cg0Emm/8Hnk97vqFpR1d5AV9hlxsd7xjUlJ5Ah67
3n+VSty5DszMvSQfxW93Xihv4V3BwQ8dRyCIYac+BUG+sXCrDp/VV3t+2EorXL76
JLZizRhRKta002htsgAlqRNRZZL1NwI6JGlHD6Rm2WSSAEMDjudiPjJn5KNsEjuP
bhqR/YN5SXZsTjHC3y/qmZJrkoYWsw==
=WFJZ
-----END PGP SIGNATURE-----

--GytIA0m4jn6r4+oY--

