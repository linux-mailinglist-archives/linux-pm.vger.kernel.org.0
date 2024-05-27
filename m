Return-Path: <linux-pm+bounces-8163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB28D0063
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195A61C222AA
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F915E5BE;
	Mon, 27 May 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1IaD3ke"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501484D5A2;
	Mon, 27 May 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814190; cv=none; b=lAvBW5Nkalq+dHCoKMbe54Yc6fRY9hDm1ER3RGG575FJbGevmw4O4wjp8DwEj1ov0BsSbAfYRpd/nZIoDSQ6htkEjhDyOOnglowDm6x/xOyr+p4ozWtFgaD0uRAOnAODDDdo23NaJa183qMegUxQygUHLr8YbjR24A3bEMTWR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814190; c=relaxed/simple;
	bh=kO9wIg+CtwT+6heTucB0udl6EgeL1JvmQsaJlESS0TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgAeHwrk6jKtNV6ESFbki9+OcEweBiH00U7qY7jflVgLQB6c7YggvcJsAtN68lce7s1IEhEgwSqkU83fZo+DfY3lc8OR8ZClfnOyojUdYFMf++aaiA/NBN/0vdKwuN8Z8fJ3SmQ8x54hF1lYkfxU251/OIIsX0anGRYgBJ6AshQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1IaD3ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58186C2BBFC;
	Mon, 27 May 2024 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716814189;
	bh=kO9wIg+CtwT+6heTucB0udl6EgeL1JvmQsaJlESS0TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1IaD3ke/1U9fQO7YdI8TsMSLanSmv+uyhSacUc/+ri475UKL25Jb4wR+C+JenB/y
	 5q8RbYOz9pjYTFAg1cb7pjjEAbNbCP4g2ddLMf6XxckbIqVkYymyAcPkmHtPJp0v1s
	 AVOMAFuTUF8jDJKVwo5Fmx+ymbynbXx9QnYqB2d4AQ9Ji+ixTTAarLwRbVmgh9vzgI
	 1B4v7cWarbmPVk9+6pV8ITgfRXjRetwVte51AChQ97U1OIvN1ttJ1+4Q9HIcFyPhZ2
	 HBeNfEZ+gs8qBIKoagkIVNWwNf5BNCM8Jkp/LBm8MVPFikQ63Ur9Ht3XHyV1MoXSb9
	 WZqxGOZ6gBjbA==
Date: Mon, 27 May 2024 13:49:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, heiko@sntech.de,
	u.kleine-koenig@pengutronix.de, geert+renesas@glider.be,
	rafael@kernel.org, linux-pm@vger.kernel.org, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, shengjiu.wang@gmail.com,
	frank.li@nxp.com, mkl@pengutronix.de, linus.walleij@linaro.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Add delay after power up
 handshake
Message-ID: <a04b3939-081a-49e0-a063-5b50d3321ca7@sirena.org.uk>
References: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>
 <CAPDyKFp4V8f0iyeRASSEu4YaCSz0m56=8ssBJ9ogSvqG1dzMZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oj5O7UC7qaae2W5K"
Content-Disposition: inline
In-Reply-To: <CAPDyKFp4V8f0iyeRASSEu4YaCSz0m56=8ssBJ9ogSvqG1dzMZA@mail.gmail.com>
X-Cookie: The Moral Majority is neither.


--Oj5O7UC7qaae2W5K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2024 at 12:22:41PM +0200, Ulf Hansson wrote:
> On Sat, 11 May 2024 at 05:15, Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> > The BLK-CTL module needs to add delay to wait for a handshake request finished.
> > For some BLK-CTL module (eg. AudioMix on i.MX8MP) doesn't have BUS clk-en
> > bit, it is better to add delay in this driver, as the BLK-CTL module doesn't
> > need to care about how it is powered up.

> Sorry for the delay!

> Applied for fixes, thanks!

I see this is in -next but mainline is currently broken for i.MX8
platforms - could we get it in for -rc2?

--Oj5O7UC7qaae2W5K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZUgWUACgkQJNaLcl1U
h9CSQQf+Mt9Bm1J3SOUbg3E3YrGKe269u9XMPX2/8mjaeJaQ4JKJOwfRqxjeiayG
zthEIjLn5LqjBsaPDa7CgLfYSxfXOdpUmJ/DkebqpiUag367dyoxubuz8AizQass
E4jD+KxnfFQR0KIo3WbQsgCJSiEmAVuwZvba8BA/DCLFe4QKXwv0g4j3J0zyqIWO
PqWekRXAONlr0LF42HC9+dj+Y4hQvxaWCNL95ipKvTKKSJTPo6MIH/5Jt5S7OUQ9
QqTMceS9gH90lhFt37utufxqQKEGPYR4qeceIlymtl2Ce0GqL/Nzd17VO7kCU13i
6E9s7rzLOTFU9/eH1N87gf4Z0XnDfw==
=u0Mu
-----END PGP SIGNATURE-----

--Oj5O7UC7qaae2W5K--

