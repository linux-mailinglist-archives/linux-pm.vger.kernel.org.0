Return-Path: <linux-pm+bounces-35153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990EDB915D8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531423AC1A0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155230ACF5;
	Mon, 22 Sep 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG/BtI+1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EC30AAAD;
	Mon, 22 Sep 2025 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547164; cv=none; b=UX+N9/c9dAmrILGTW1Wjj6edreW/5iSMwZC4yWKsYRRCCfko0FL1ehoyCW3IN2WK5aoYdBLwjt0jfesZfNHbrx3gcWebeWH9TtEFbkmpIQvUZiLqEk3yorq2VEGE9XEWozIYwH/U142eGbXgYIRx8gSXObCOhg5CAdoCkRb5JVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547164; c=relaxed/simple;
	bh=/2BPc+qmrsh2DgallaqxgQi03F/iwjA/IqFzKaKywSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpFCnU77Ps/J8wKbRMw/0pwRzgz2/oEuWz0mPJaH3FivLKkRCzxYrYiW8TI6+UI7k4cusSKUrPwXqcH6+Gy4nxgobzSC+60xh5eMbH3yrEBCbAp+Gv+Ob47WgolwYaCjtn4e2y9ZxouPSMHtRKKiB8TZDBfhpFX1XmW9C2XAseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG/BtI+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1236AC4CEF0;
	Mon, 22 Sep 2025 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758547162;
	bh=/2BPc+qmrsh2DgallaqxgQi03F/iwjA/IqFzKaKywSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LG/BtI+1o28ZEPga/55ETInxWu6RoXLXJhRGIZVOknyJhj1fvYNbUGyqjdViU14CO
	 4NIo1Jz6kugezCY7caieIF2+gm0DpIGu0imUPyECzH5W5gjFvs+rKgKtukthw/N8/Q
	 bx4CYhN1uy747NgWfTZfngQEIkc2GPyBY9J0mZY0HaOASfnHY5clIBprv22ChzIZj3
	 hKO4LsUXrEUbB0a/IvFsk22pJgFcLigRkGNYe1tlsXWnGf4ePzKGilQsBvmaFTdN2p
	 pmxKoTFv5oCMqFO4lxCEB6HHmgrRyqKU0WLl9jxgYm47kGQwuADxiJgjSfXq0IuDjP
	 fPKTXU7AI/kMQ==
Date: Mon, 22 Sep 2025 15:19:14 +0200
From: Mark Brown <broonie@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 05/10] mailbox: add MediaTek GPUEB IPI mailbox
Message-ID: <aNFM0oWk5S38KBRC@finisterre.sirena.org.uk>
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <20250917-mt8196-gpufreq-v3-5-c4ede4b4399e@collabora.com>
 <CABb+yY0_TZC0Dd3Rue=6Am4=Urs8hdkaa6RE=42t58SYUsLV0w@mail.gmail.com>
 <1933660.tdWV9SEqCh@workhorse>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hWOioVe/sP5fgiHB"
Content-Disposition: inline
In-Reply-To: <1933660.tdWV9SEqCh@workhorse>
X-Cookie: Filmed before a live audience.


--hWOioVe/sP5fgiHB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 22, 2025 at 02:59:43PM +0200, Nicolas Frattaroli wrote:
> On Sunday, 21 September 2025 07:00:59 Central European Summer Time Jassi Brar wrote:

> > > +#define MBOX_FULL              BIT(0) /* i.e. we've received data */
> > > +#define MBOX_CLOGGED           BIT(1) /* i.e. the channel is shutdown */

> > This is confusing. CLOGGED usually means malfunction, but it seems you
> > want to call it STOPPED or UNINIT?

> I don't agree that "CLOGGED usually means malfunction". To clog something
> is to impede its flow, which in this case is the correct terminology to
> refer to what's happened to the channel. "UNINIT" is wrong, it's initialised
> properly. "STOPPED" is also wrong, it's not stopped, it still sends, it just
> won't pass it on through.

As a native English speaker I'd say that clogged has heavy overtones of
broken and malfunction, like Jassi says it'd usually describe a fault
condition.  Something like "blocked" might be more neutral.

--hWOioVe/sP5fgiHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjRTMsACgkQJNaLcl1U
h9BSwgf/UbyytmfMXNaOBq0OXuzH3MlTUpvtouJsg45qiXcqEzcGY0k6+RBIUbc6
zI4fw9IG0Lv8B4Yrt1hanJqBJ/sKvd/eq065FqSbGMiG9Wyvivn0OGdw9IIP3Wxi
4TpYVqVul1GtYt3Gp5D4HJbNOaeEZeaOsEUqU0EFD1X5NCviWF7atKprxkvd/e9k
ZPOQdFVmh48Ln2hsCQ621I8Wemmu+gSVB1aSvD1awF36hp+cCvWz7vSus4z3nX5D
71oUm+zLms7LtKb9Voz3ReEEmIKjbhG7dUF/xHul+Qg8FQqMxwcBPAyjFzl3g92I
ZQuum9Wn2rVplW7pwOwJ5YvsRh8BdQ==
=0rmc
-----END PGP SIGNATURE-----

--hWOioVe/sP5fgiHB--

