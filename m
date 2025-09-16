Return-Path: <linux-pm+bounces-34757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C4B5A16D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 21:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191FE3AEFDE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FA531E8B1;
	Tue, 16 Sep 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtJx2PG7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EA2036E9;
	Tue, 16 Sep 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050899; cv=none; b=b+aCI2x6nxHA2xKymS4dj6Mc3GTNUY8umTOHG6mU8htgKZMv3F4EBnbXA44WdxVUrMi4CSxctZOcrgEluPItvcdZbtzUCgQjsrXaw/gWZMNb67U3yAQzZLR12IqzUyua97+6JkoU5/jBLGGhLQlJF4Bd5aToHNy0hnLQwRF9Nrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050899; c=relaxed/simple;
	bh=C6yhdHJzoIbE+amyM5rD+e8WufqCd7DX2DUDM3fWED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUa1rY768e+OgInmO/qF59G/Gn4C86nxwiw5EXl1jkAXDTMZGwSrE14O/Kpj18bYHuCjpPU70C2FWo9dtnUBq4Gt5+nQpe+9jD449541JaF1QiRyV42B7YUhEYJTClQ2pU1jJ4y0YDgFiXTbH87Ec9H+UcNAuyPLmLJZDtrBLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtJx2PG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F287C4CEEB;
	Tue, 16 Sep 2025 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758050898;
	bh=C6yhdHJzoIbE+amyM5rD+e8WufqCd7DX2DUDM3fWED4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtJx2PG7p/FYTgU0MxA8nQCwNnd7XEJSsqHChi31gqzyMN6wMq6p5n9aHVKPBfUqZ
	 c1mVVWzDp/4NUayYABIr4tB4yD5YPB06S53aS2mlCF3FTTiOy0Mth0KKqQoqHS8ntK
	 rq43dhV9Kc36CD7byq4TIwddp5J7c5jj6z5LE2xd8Navnk+gMoX/euu7kwrHE0mMev
	 lbDlQ1JlgEsPk3DOgkQDi9NNvp3dmrKPfYB1XijVNJc5c8GlfFpdMK7CK1UXINwlBl
	 1KGK97GPQQ/9Aj13OCSKOoOdqJlSmvmFhd7oYJAYELo5tqB6CF5sJG8s3n4gDl1lsA
	 mBIF/45peswPQ==
Date: Tue, 16 Sep 2025 12:28:16 -0700
From: Drew Fustini <fustini@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Icenowy Zheng <uwu@icenowy.me>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] driver: reset: th1520-aon: add driver for
 poweroff/reboot via AON FW
Message-ID: <aMm6UIMTFOH0Z3Ug@x1>
References: <20250818074906.2907277-1-uwu@icenowy.me>
 <20250818074906.2907277-2-uwu@icenowy.me>
 <i6slr5csro54ys5g7diqyacq4deidwm6f2nhpm2uwmgjlu6tyn@otrbpij4vdya>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fu0knEafnJ273Dfx"
Content-Disposition: inline
In-Reply-To: <i6slr5csro54ys5g7diqyacq4deidwm6f2nhpm2uwmgjlu6tyn@otrbpij4vdya>


--fu0knEafnJ273Dfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 08:22:02PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Mon, Aug 18, 2025 at 03:49:05PM +0800, Icenowy Zheng wrote:
> > This driver implements poweroff/reboot support for T-Head TH1520 SoCs
> > running the AON firmware by sending a message to the AON firmware's WDG
> > part.
> >=20
> > This is a auxiliary device driver, and expects the AON channel to be
> > passed via the platform_data of the auxiliary device.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
>=20
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Greetings,
>=20
> -- Sebastian

Thanks for looking at this patch.

What tree do you think it should go through?

-Drew

--fu0knEafnJ273Dfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCaMm6UAAKCRDb7CzD2Six
DNWLAQCUT53BPhF35rw4W7EJqUmvuqrV8s9oiMp0hKK2821u2gD9HPELUCX8A6sY
6AzvOtfhRtzrVwGT2bbsTmqEEBrNXQs=
=mp9b
-----END PGP SIGNATURE-----

--fu0knEafnJ273Dfx--

