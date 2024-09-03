Return-Path: <linux-pm+bounces-13444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B442196A43C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 18:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5471C231AA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F518BB99;
	Tue,  3 Sep 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AwUgJiYZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FCB2868D
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380796; cv=none; b=qSnnJiz3W+KV5TUTUdLKt4xpY9Zb5eZGAfBbIYsLPX5kNmJjHV/Dk8oh4dayxDCzUO97B/a2gfWulsvx4/6/ZBfI/DxMkfQXMX3huLF0MReYXFlVkz+S1Xj/+Fwbczv0QtrWdpy0BBvXEB91kFtCIaLvLvCuZPkSXWujx996lqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380796; c=relaxed/simple;
	bh=UOv3nGBodylOb27x6wUuPaSgFW/EFvgkUlcBYJybAeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHQ9I9H/QjkZmRHZJ365AlEv8dfDSsjwgbmDumiSrj4pvScp3HXeeTcooBKfx7nMOguPl9SPJ63UmZiBOPt+5A4ZZB4YuVO9LhCcCYno5m7D11tly48Vl0Vyyw9Vin83F7uCd6Vgxgeca+s6Slo1t5PPyuUo8hHG+zXPx6Ejr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AwUgJiYZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so64540401fa.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2024 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725380792; x=1725985592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOv3nGBodylOb27x6wUuPaSgFW/EFvgkUlcBYJybAeI=;
        b=AwUgJiYZ1EeVDGftjtVWoncVC088GLV/2IT15SWEdFtPKD3ATFCJ8rwJCo5rjNakMI
         60iBc3gzJnbRdZgrAI+isSlBpjWY3rfyANtSokh6OM6Lp4l7aPWFJG+7dRu8t7dkdwgP
         8TginZJSqeD5dOzSts8tLEpRyJpJyNoQPGz+xWfsIqW39WjkuUrMxuHa1h+O9b0ul342
         8/VLbv0lO8Q6NJBJYiOTUXYCfiCyxdWGKZSHW4zizJEoMdJq+NEj7Jc48dSqL3MeJLUQ
         ZB30z+CBgmKLH3t5hC/yvrFupvg7fUySKwAE9gzyiFp4E8mMsgv5kd7r9Xiev89scubA
         Z47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380792; x=1725985592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOv3nGBodylOb27x6wUuPaSgFW/EFvgkUlcBYJybAeI=;
        b=C0C4L1opkc94C+76Fq9V3bpjZNpu7J1++lfJwQQwe68iIKbtKEizls7/oicXOXdAU4
         ahsKUx24D/7aFkUJcXD5NwXQAV4IzxaT50Dhx3lvs7D3VTjZrkGsbs1Iw+hCY75CQ4M/
         pUH8w9KQ2baUJDQ1xyPjsUdT3ANBQsOHcUQvGfYkPwTh5kBVm9j+/hlQqt9/Zgbk9Dk7
         +yBsLYCQ6qioZyYxrQrSagTjA3oSG6RFl9uHej7j5q5Iz1QtX3IfarKOupc8H6VBj5/F
         6f2/TovRvV1uWf+f28lgRuueoB6x4GXSO3q2TXxI0TCCa4GqAntMzqDxv8CmXSpzeGv8
         wVYw==
X-Forwarded-Encrypted: i=1; AJvYcCV8VOwJOjaW99radaDZX6Ai1+kwD7+HPU8HEpuLZ6+5ELvgM9Q1eAp7aX0BAJAtQ++fpfn5albjRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4xBmtR7cf0UHDWg8B7iEYZnq2e+nYVvS8QZRWJc9cy8ATtcY
	hKtgSVhQeZRNPLAwdVLJ/5A1mdn+BwD/1LijK/XWF2AD7YxB+Vmm1BwnWdkFhmk=
X-Google-Smtp-Source: AGHT+IFCPzPWsIsRmfp2poLwXGcq+zOJurAsgdC/lf6de+f8XfxHhQkaO8lDI8J140bhx3OvbcsO8A==
X-Received: by 2002:a2e:a586:0:b0:2f1:929b:af03 with SMTP id 38308e7fff4ca-2f6104f2590mr118378621fa.30.1725380791999;
        Tue, 03 Sep 2024 09:26:31 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24733a74bsm4511685a12.86.2024.09.03.09.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:26:31 -0700 (PDT)
Date: Tue, 3 Sep 2024 18:26:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pmdomain: imx93-pd: replace dev_err() with
 dev_err_probe()
Message-ID: <zdxpskhxcxujlk7tjch7p5opsflwchkq7b5m6ctjrsxm2tpnkm@wbnp6l7hkfuf>
References: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u6lwchy2mevlhl22"
Content-Disposition: inline
In-Reply-To: <20240825143428.556439-1-dario.binacchi@amarulasolutions.com>


--u6lwchy2mevlhl22
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Aug 25, 2024 at 04:34:00PM +0200, Dario Binacchi wrote:
> This way, the code becomes more compact, and dev_err_probe() is used in
> every error path of the probe() function.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Another improvement worth mentioning is that the new output mentions the
error code returned by clk_bulk_prepare_enable(). If you respin this
series you might want to consider adding that to the commit log. Even
without that added:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--u6lwchy2mevlhl22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbXOLMACgkQj4D7WH0S
/k4MTwf8CKDh6NgmbHBsY9tSR6bBFLp6nyZQQ27Ac4ud4PT+VOlbzn8OqxthvyB1
Zsx0kL2Dgw63ODu3M5WaDWzeUgMdfcTEs9GMm7xdA7oGwlnGp/mRfVaUaxXBxve1
xtbuBzWP3fcJD5eUojO/CU2gu2V0N+s5E2X12sXbxqdY3BnScEvayCcKG949DM9r
05rUBLycEh3aSEF4eDUkkUGR6qsGo0KmCh540xHH+NVZ1Zo3GBX68eIiynGvAmAE
WDEHTNrBz0exPXIUTeYpKLNMpgjaaR6WcZMIVlMDu4EK8WEvW3YUnEbDEUmVADNL
E+u6u/HzJYmeRrVIOXsczn1ow78WqQ==
=1sbS
-----END PGP SIGNATURE-----

--u6lwchy2mevlhl22--

