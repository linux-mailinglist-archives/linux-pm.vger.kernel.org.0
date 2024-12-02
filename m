Return-Path: <linux-pm+bounces-18346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2F9E03D0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 14:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93980B3A2AF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24813C8E8;
	Mon,  2 Dec 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TCZtvObd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395E1FCFF5
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142033; cv=none; b=qZZpyDbwemlAnezzAAz+PHR1Bq5jBW3L/Fm6EKDyjEM9wFJMdwPAVSPWFzYMPVbJu3PQjrZsgO8DnxenrK+kzU+sfz4XVaN9vMjZTO0G7o72i29zpPxVo0NGEiZn0BIMGTXfLLReK32LAY7xSXkoLvTfD8s6faDr5aFh6OH/Jo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142033; c=relaxed/simple;
	bh=u378XDx4WG4IL/2dCVgpOQRG8DFhsOKnAQ0gTpFbO7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkaM5mTZPXiyg7+oGyLC8uKPfiRp/2orYtxG9WgK5G6GPECGsoBa1IGQxPIvTD4vkkUuWGfydrMC2yzCTzInwJTymdj2giWYGqPrtvjBb9wyi9KJLcfwi0n1sELdHBDZpHqS0M7AZZVEjm9mQl08O1RTlqx24J+KIUdXQGpqUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TCZtvObd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e1f12c82so2495409f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 04:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733142029; x=1733746829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u378XDx4WG4IL/2dCVgpOQRG8DFhsOKnAQ0gTpFbO7I=;
        b=TCZtvObd7KHmihuMpK5vNskKjhKS3w2wJUT25u4flN/bNv5CVBuFwNIhddZzvrc4kt
         jtQId+lWmc6aRDpT5Q+FkN8tU6k1XNtW4E5qWn1fx4N0yCoNP5maGWAT8LhEDGpBmHYr
         u9oOlqTC8tOHU4IG5vIOnr5XEZDNky0R80xgJ/DiZuf4ITArB5SQ93wDdYw8F6KtIxTw
         AKloK9WPaKL0l+kdvgDO9XOIdmRtVcQbEtUdfYanmIKTY+btB9OoG0insJGlA64C7AQq
         OUPSyuyTwfTucbDjyi+2mwN+xudRAylcq130G4661NSDBLYmnKzbqHnChmUpdT6ziK64
         y3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733142029; x=1733746829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u378XDx4WG4IL/2dCVgpOQRG8DFhsOKnAQ0gTpFbO7I=;
        b=luxQwS+mTR08nW5WubDqfaFAvmLN1aj/11+EWSR+8Z1GA39FOKpPHDKTzL0z0KCivc
         DH2lqV5nWZB+ex/szPlbxP10+wNMEUnUY7Gku2ECFN4ZubXI9dxaNvjRjhaDVD1314Ib
         1CCz96idtbYPWvw0e/DJf+uoq0ePd6rV/6pyYJhK1Zv79ytAnET3jmso0cZT7chAca7h
         zvJ95UCpeMm2/eMZlzYLVAkiucKrQdiOUTIqV+Jb0mlkkhZZ/B4vP9LUnqYHa68qMKg8
         pnczv+ZOkU/SAm52FkoiAh2XIhOCpqIyi32vBb1GsuOwONSzyQuFVeThCcomxvl1HvNv
         cEBw==
X-Gm-Message-State: AOJu0YzN/z0tsoOpvvEeGNVrZpkrGUnf6WgHUeKMIl/pCyDm7cjF8X7J
	LAW9391h8cGKtYQHBwSh0cvqyzOgzK1T41uUX5wRk0VqeloIobIsXTKEx7/3KLQ=
X-Gm-Gg: ASbGnctjZ9oE/OPIs3SjXxj/e+/5SeWs8LDntE4w2afCN5xLx0OFL68WoJaryUOh1OT
	WMCFtavFMqXHiF/PuABOzw4koiIJFj+ZRjWH01TTBvr1PSmmaVlKaFFxJaN3MP7waPeTkrI1BgV
	lHGsAB+g+dRwGGr7bqMOnTTm/AXNcYKmoZ7sbZidRsu0Ox3mFZfUrufvmVwcPWY/6OBuQekc+Sz
	0xjFmxNnqpygkQMPvigD13/0En3MKTaJHcvHZlzmC9tUnCtS96t5q6gDsdJqxkC9T3xCvfXdOZu
	G9Xm
X-Google-Smtp-Source: AGHT+IGf+OvmTZwKTtzXYs9qne71qztg+HmqmaDV8f4rBxZC85P7ds5jnT+F6OPKkt5tMs8EWORR8A==
X-Received: by 2002:a5d:64cc:0:b0:385:ebaf:3824 with SMTP id ffacd0b85a97d-385ebaf3c1bmr6637399f8f.27.1733142028900;
        Mon, 02 Dec 2024 04:20:28 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd368easm12329689f8f.25.2024.12.02.04.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:20:28 -0800 (PST)
Date: Mon, 2 Dec 2024 13:20:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] PM / devfreq: sun8i-a33-mbus: Simplify by using more
 devm functions
Message-ID: <7taeakaeqyfu4x5h3r6z6lkdorxav4ox2sgjikw7zqkmnfmffs@2n2lpk4uqe4l>
References: <20241111112237.336310-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npsbh5lctdjw63a2"
Content-Disposition: inline
In-Reply-To: <20241111112237.336310-2-u.kleine-koenig@baylibre.com>


--npsbh5lctdjw63a2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] PM / devfreq: sun8i-a33-mbus: Simplify by using more
 devm functions
MIME-Version: 1.0

Hello,

On Mon, Nov 11, 2024 at 12:22:36PM +0100, Uwe Kleine-K=F6nig wrote:
> Use devm allocators for enabling the bus clock and
> clk_rate_exclusive_get(). This simplifies error handling and the remove
> callback.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Is this patch still on someones radar for review (or application even)?

Best regards
Uwe

--npsbh5lctdjw63a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdNpggACgkQj4D7WH0S
/k67GAf+P1XZfxK/FMwYqAbTJVZUiZwlfGN74ndrhxFPbHPThdAPRaVOh0IRAYua
nNRvgUgKYgvOKLADNuGv/G8+SbN6Znh9b+kW0BXye3Xb93OIMPJgSzoURb3DyXp9
LsFA4cuWBBUg6dUv6WT67/7HV08jK46kQ0xaUIsadtoZpqCTlSsZulNGmI1FUFd6
wsrbhwPKyO3c4s9lLNmKpfskNaEJcbiwf15UxBwtylwYS9ZujFbRyc0781JIWef5
NCNISsYYWdjX81tLApo3S7HWo7qLQLjMZnkhY8wuAE+TfYKB8usuz/d8gHJWrX+s
l3pwP9dao9owYBPAIPPnfTgv6L3Diw==
=0LW+
-----END PGP SIGNATURE-----

--npsbh5lctdjw63a2--

