Return-Path: <linux-pm+bounces-15626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820799D474
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14532B27D83
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF31AD3F6;
	Mon, 14 Oct 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hEWCJdsg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E81AC8AE
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922442; cv=none; b=TzLn22BDvc1CDYuucmEkePRgcUZqwgWs4UqKTlTBXWjLK3jRXo+t8JQrCUzQ6O3qyb5QUi5cBzG64AibsDY+I/YAb64ElRLU0Te+0voaAtP2kxYOEbQZjvobgyIGramrHD+zxwGWtiM06gGIWUSSYg8ctO/lmvpB6CtINeuFU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922442; c=relaxed/simple;
	bh=bPKOF9hLp1gLmish3JLHjV9xayYIgOc9dRCesRJ75gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oj2bVVhcDAQl4PMAY3P5yacbl1O9XpeHH+MXu6CGJREtVb1J05nbK7grHV7CEMs4ixRGjZe/sErz+5jvsGUEA/lotFJd/IFjaTxSFA4U5mRhY0jGGCovfqo/ku2gyw+nq2D3d5cykDKN+YbVKTLI9xNa1w5OLZTsSKUNLVzYDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hEWCJdsg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99f629a7aaso301686266b.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728922438; x=1729527238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPKOF9hLp1gLmish3JLHjV9xayYIgOc9dRCesRJ75gw=;
        b=hEWCJdsgZ3T9dNYjNVdVp+vbg429E9OaIER2h6MjYwo8CTs5CDTDoKGVPyQIieQbFN
         5wnseuG/rYl/gIwzwcVyXWxoeADFIKXUqTLt4t1kKgl5y0tx6fu6kn3X6N/J60mziFDF
         oq8OW0/Oz662DCilomFWBkY0ys+42+Qvwz8fLHAnZhTOVNB4rnO0ibhRrEYQF1OPaCGD
         CrZOXbCehQuXceJwZNbz8hteSapOXPOhVKRCHKrdybz+ghlMUC08jcy3yFt7jd8NxFit
         1gT8Ii6u32xs0zwpWm0mb6rqZX1Xe4pyT6zxjerCk0QuEQk544W8J9fe+Zvdz/8kbRA4
         lCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922438; x=1729527238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPKOF9hLp1gLmish3JLHjV9xayYIgOc9dRCesRJ75gw=;
        b=ND1aZXK75EkQmPeNj8m4eCXqUga7GzwJOa1K+pT9p7DIJcyukB/5tPn/lifp+Yz+lS
         r/bD0iQaXVtMGjVW+/XBtIZ8aPi6pCsOhVNycoULaU98nzcAPZdO960PWnxQGo/222RN
         bl8hQHa+ReYignI/D7m8N98Y868eB5PKJLHO1up7Bor6MK1SsDEtlKXGIk3jj6XOW6Xn
         vaHvYn55hWLK7jo7DIwA5gMWC2HttNhoukEBfEtcvGcOE0K2XQe3QHXm4YC1Hs0C2t2k
         d1ABGSowilSSQLhQirgy7ukkBicxfxPsLr5thxB8hdBP8fIaIeRuSsQkuM5CsAUC+2Ef
         6ggw==
X-Forwarded-Encrypted: i=1; AJvYcCVGUuR91ub6M9mFmHxa9/kIk08g3fsGifa1o54kZYOuel/x7N/2VbpEULM6jvAtrJ/xcXrd87o+cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3Z5NVlyLBywNFf10G+plfz0Cn1zb5bPnrSf7HG1VW1X6Vg1S
	MyMCNLRgY2Q1zts5xGhQ2lXakS3OI/eDyF1pzUjImEAEwqLEamJCK2A/FPwEv7M151N0pzj6zCD
	g
X-Google-Smtp-Source: AGHT+IEFuTZaIGMTYsWaft98HaU5lwquKpMe/kwiufftguLSaKzTtM+rH5m2/C/7LkYKed1FDU7iJw==
X-Received: by 2002:a17:906:c114:b0:a9a:cf0:8fd4 with SMTP id a640c23a62f3a-a9a0cf09147mr410208166b.18.1728922438063;
        Mon, 14 Oct 2024 09:13:58 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:c75a:6d73:cead:b69a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a06169946sm236846866b.204.2024.10.14.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:13:57 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:13:56 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Dhruva Gole <d-gole@ti.com>, Vishal Mahaveer <vishalm@ti.com>, srk@ti.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
Message-ID: <fl5znng7ed2cgqmtrigra5y4e7ozorffozjxsg2ipeayzfubxd@cijl65vuutxx>
References: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4nmdfp7tndyngpt"
Content-Disposition: inline
In-Reply-To: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>


--h4nmdfp7tndyngpt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 01:53:24PM GMT, Roger Quadros wrote:
> Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during i=
nit"),
> system suspend is broken on AM62 TI platforms.
>=20
> Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SU=
SPHY
> bits (hence forth called 2 SUSPHY bits) were being set during core
> initialization and even during core re-initialization after a system
> suspend/resume.
>=20
> These bits are required to be set for system suspend/resume to work corre=
ctly
> on AM62 platforms.
>=20
> Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if g=
adget
> driver is not loaded and started.
> For Host mode, the 2 SUSPHY bits are set before the first system suspend =
but
> get cleared at system resume during core re-init and are never set again.
>=20
> This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
> before system suspend and restored to the original state during system re=
sume.
>=20
> Cc: stable@vger.kernel.org # v6.9+
> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
> Link: https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@ke=
rnel.org/
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Tested-by: Markus Schneider-Pargmann <msp@baylibre.com>

Thanks for fixing!

Best
Markus

--h4nmdfp7tndyngpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZw1DPQAKCRAkjLTi1BWu
P/92AP9J1CFYQTr245Jv5ZxCyp/AAlTLgGGRp3SBiliOMn2cvAEA+vFrFVBosl4v
mTio+KqIdSttNo+JNteWPelEI0uGpQM=
=FbId
-----END PGP SIGNATURE-----

--h4nmdfp7tndyngpt--

