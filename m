Return-Path: <linux-pm+bounces-24247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F533A673B9
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 13:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625691891E53
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 12:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3320B817;
	Tue, 18 Mar 2025 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZGp3Cd1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08C1F5E6;
	Tue, 18 Mar 2025 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300438; cv=none; b=gPToYJm9h8yL4IndQq+hYN0DJx7RMrMkD4WwjwRiCEGsQdbOE9LjANL9+lUf6rhKxW9b2D4zkkIxWEk1k8IVZ7UueMtfdTJh0PPknSVsV3xJZ0UfTom6nLLdELtqtWD43t97Hi5OiFzP1Qqqtas9AIedOM1pfLmljZG92w9rwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300438; c=relaxed/simple;
	bh=D5QUi1pWlnGEv6disQyh3R5CzW27ucioVI2XfpILFRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OW53BneottuMwlEsRDLLe4hsoq0agtpFAmC+k9TP97CUgI9ZLcEmKf/veWHMABs7ecURQWGaimBLqwJDXHQ1NV9T1zLQcPXv0+ikOXU2qQey1hHByoU7iraK/YTX1jbPSzivwOE03sQrnXAFNv1fjuHdOy3XSps1b9YSwqeYRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZGp3Cd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C804C4CEDD;
	Tue, 18 Mar 2025 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742300437;
	bh=D5QUi1pWlnGEv6disQyh3R5CzW27ucioVI2XfpILFRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZGp3Cd1T+o1JsYGw/e58my0LxzyBGapQzt0sfO26lVJdWTTv87shYxxR8yA7D5Gx
	 zonOp1NWaQ7NnRcVQAYxbSeTYDv38Cml1ZBjJBCS5E7ql+b1oQX7smvL/y7WlQ1jlO
	 DDwJAnvoXG8IM6TEumNm5cCSJRJR82pOmNV4JJZZYF/0kryROsOoLFxMG1Cr5BZXpe
	 JVX6IfFjdfcUK8w0syy+UlSktzMw/utoG4S7Y3yYjnDDkGZqfLu0reQCHxi/EZw/qc
	 MeD+CbRiFd1GdxtmrwU3JVDSZo8ZApXs2zyhhQdqqIxdPashncZacNNewcWfyyx3ha
	 ZgSBZq2xaalrA==
Date: Tue, 18 Mar 2025 12:20:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v7 2/7] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
Message-ID: <371ae28b-8efe-455a-838f-5e83979a9f1b@sirena.org.uk>
References: <20250318094716.3053546-1-o.rempel@pengutronix.de>
 <20250318094716.3053546-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uGVe6NFPdRoUDrfM"
Content-Disposition: inline
In-Reply-To: <20250318094716.3053546-3-o.rempel@pengutronix.de>
X-Cookie: Swim at your own risk.


--uGVe6NFPdRoUDrfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 10:47:11AM +0100, Oleksij Rempel wrote:
> Prepares the kernel for the Power State Change Reason (PSCR) recorder,
> which will store shutdown and reboot reasons in persistent storage.

Acked-by: Mark Brown <broonie@kernel.org>

--uGVe6NFPdRoUDrfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZZQ4ACgkQJNaLcl1U
h9Bzbgf+MLRi55KTU6TTeTVhe+bDgw23yrcRGPGwp/ktm3nzNkq+GVDFLsE8BI/x
dGmlGJgLRqLaS/2AfbM/ODghgxGLHOGgJ1eTh3UdRuTSLfzM8sSD6Jr0pajjQOyq
R+JrkR3Mlnn5/8uoMeeGAC9/pWPF9EbkLKVW02IAR1fpxCQuQ6TKyeuk9jw1R3iJ
bOSsGI9pvWf7b97lI0I4kt/otU7+9z0zS7PlYar9Pz40qJCPLaei+u5TS4Ed9Cvf
TY03AmnqcscR+kmdi2Ut6eMS/rgf3pXZSvZFp0yIn2gdHkDVvhJm/dx6+PVlc3CM
ihG+nHuvbBM/37gUcFMf1n1EkbNKSg==
=XxAG
-----END PGP SIGNATURE-----

--uGVe6NFPdRoUDrfM--

