Return-Path: <linux-pm+bounces-29627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B88AEAA9D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 01:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0E1C407C8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 23:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C81C84DF;
	Thu, 26 Jun 2025 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3X9ADeT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8112DDA1
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980711; cv=none; b=oQry+p3B/W8plMz61gJIriQcLxW28wz4oknDLuTJJ0GRG1sMiP045Liemn0lif01g3SWi5B86bPaH57vGjyktgzv2+4q10N/WOSORGGPcXjyPlwkDxZVoSLuLnXYnopvxfk/+OQlZk6USlUleEYnOZ4rmBBtN3qEH5tq4AdvV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980711; c=relaxed/simple;
	bh=JCHkfms0zVduEDP/lAPDMPe5gcSskA3haLtn6iC/4qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoWcRItoSosjaHmUtGHptzPuO3EkFoVf9gW8TmPWAFQgwmYSJh5J7JhoikWt3Zbh07hEnoKMhMjfMrgXvvk2MB1rINEvf6eaB2Y36eGDLDioqlsLFWOQkTwzG7u+2RHHr4NTk3c249lRIm5Q6uq3GRMkyaVAxd6m3KLVkox3Qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3X9ADeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0050C4CEEB;
	Thu, 26 Jun 2025 23:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750980710;
	bh=JCHkfms0zVduEDP/lAPDMPe5gcSskA3haLtn6iC/4qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3X9ADeT1wiqkM0GE8vYUlBCX9nuCbNaprARra20OjFCnEyeZGThl6KbrohhDFPt9
	 4KxrG/PZPqqZMZIDnXluJXOYBb+zZ+TPlf6E4j0agLH5lrpd32ayV+tPM5DOUjv++h
	 b2yOD8ehQndlEdoBz80EBvaQ0JS9V+rQI0BWMWZOVqxvGGx3MFIjF2MGOyki4oKeIl
	 nq0gYoBpBkgEToqmfEezRp3lugIs16PDg/djHgcT9pvyPY25DjuFcK15VFwjCuTTyG
	 UNXuX9paHZZQmnl9HVFdzViv8eQZFxUkMOvRJ67pWlY7Vwe6ulbx5SoRfFFxW5Cko9
	 sOr/STVdUiM8Q==
Date: Fri, 27 Jun 2025 00:31:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Hans de Goede <hansg@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 00/10] power: supply: ug3105_battery: Switch to
 power_supply_batinfo_ocv2cap()
Message-ID: <aF3YYgw-GHpjepSs@finisterre.sirena.org.uk>
References: <20250608204010.37482-1-hansg@kernel.org>
 <175055104892.226297.388983002573981633.b4-ty@collabora.com>
 <cql7vri3yyk3fl6y4rrmfbj6ca75gv3y2hap5as4ulcefjenwg@jlebnndhe65x>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1YXl2z6WYRY+VBXf"
Content-Disposition: inline
In-Reply-To: <cql7vri3yyk3fl6y4rrmfbj6ca75gv3y2hap5as4ulcefjenwg@jlebnndhe65x>
X-Cookie: Do not cut switchbacks.


--1YXl2z6WYRY+VBXf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 22, 2025 at 03:09:05AM +0200, Sebastian Reichel wrote:

> I obviously also applied 1-7, but without b4 as that required some
> manual work to prepare the immutable branch for regulator and
> squashing the fixup patches :)

> Here is the pull information for regulator:

Uh, JFTR I hadn't actually reviewed this - there was a !fixup in the
middle of the series so it looked like an obvious missend and I just
binned it.

--1YXl2z6WYRY+VBXf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhd2GEACgkQJNaLcl1U
h9ABIwf+Jooot+GwmHIQ1bISXoGEIfxoVk+BZAkx8fpuGddKMZ8LoYlPTY5rBjcg
B6Ce1b42rFsGAMfMs3YsNcOsK+fUtRDtW5AwzFmhAYZIUOCkpR/ixSGFexUAH2OT
lP/xgoUTt6hHjzZMfQ6PKyjerzKUOJ1FOj92QGU61wUszn75121z7q7yC1ELq78R
lZJFYaWjmuU2FeGHAxgoGIty11EQUwYnw+9KkoY0MTaM8ReYlZdYE91adYdBhZB7
IcLLCSI+2RZsxtUf3QsjHszzgbEF3eiR9ExlQ2LiZZipS5BSs2GSccgCm+b477g3
AKOKAFuCXXF6fGmkKQd1MuOj8GNTFA==
=nQvu
-----END PGP SIGNATURE-----

--1YXl2z6WYRY+VBXf--

