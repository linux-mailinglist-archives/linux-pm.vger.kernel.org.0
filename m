Return-Path: <linux-pm+bounces-12942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960C96053B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3FD1F22C54
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D360199EB4;
	Tue, 27 Aug 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw1Ti1YP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2813B293;
	Tue, 27 Aug 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749913; cv=none; b=mrdKGeoY+qjMdccc99wChZxxOAweGZNZ2qIPYcF9OY07skH0sp2tr8ydDFhUFopheNBFfjhifh3pGujFwDwTEy5gtajvSqGt9NvKvz8oTnHRI13qGX9QBnDr9po+wqrf4bRMi0J1Vj3Wh86QU3faqAiFL/MU74aGA6bkm7A63WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749913; c=relaxed/simple;
	bh=gR3mpCnl2P1KBUnMuhy2g8PbPtLaH9aA27hRZPln4ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3LDYQnSyFcojcaak2omBL/ivnQHOG18pHcdjegb2JIvl3gxdQNzJx2BRUFjzM0COBwt9YjnQx50ILWJALbhmM2K5rQrZ/KRr5a2TWJ4FGbnttKO35MoNyGl/kMk88JY1Bz3HjUfyb6U4hDibfum9ifK31/R+iaRjRmFXOwgTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw1Ti1YP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371941bbfb0so2953718f8f.0;
        Tue, 27 Aug 2024 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724749910; x=1725354710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Rxz/g5Udp2ISvezkDRJmTgXbSVsaowIQmp3KwcELt0=;
        b=aw1Ti1YPUy6Q0671Y1eR4DuwI7AS2RXZCarN5rztT8fn+Cgr1sDRL9+rOkiPP8fEvX
         i9KwjX0vNY3c6ppVJlBaoQ2eWpQ35+WQ8WwRawuHfx3s8x+LxEQsJIlGuithRdwqmAal
         //Xv//RdlbEQSCX4nzWvcELkbCSwUxV3xBJZa5u5sma6S7mak05mnaxt7FOWEqzn/wzT
         s2qW1n9arHiIF6hQGF2oIQcb+cZTodiR1gqGqtqMdMQ0WaDPNMuwN2B7oYTMYHb8wJVi
         SMPf89e67ss8zIhhETdtiGXqvjeBlPbwPS1xFb9Uu3SIyyw4oweg7Gn0ecReddAhYTdr
         6k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724749910; x=1725354710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Rxz/g5Udp2ISvezkDRJmTgXbSVsaowIQmp3KwcELt0=;
        b=RbSVantzDa54cixGCdyJA0pR3OeVb3h286txIjbZ3EvLS7EEMU5FC1Gs8C6g4htWkQ
         ax43YkR6H4d9gVmANvoXOMYz5/nW3UlTW31/SsMWSjnSnCvEDpLbwhXoYgsPbe4wkut9
         qO0QFbKn9oPJVeBU9IUe3a/vWo/3bmSCi6ozeLCyCQijGxaCP3SfJGrCcJgMds62dwgZ
         lQ9XKC9VBAqNJrCTd7ObZd6YzOU4JDbusMrRPZCegQvllvkyFAZgLT6Qwa3Y2p4yV6bK
         sBCy1+kYzwhc9QKRUIcKxg6gCkuWgYp3daO4zRWz/uLSAdDZl2YRSWhmWEmOkGuwc5aC
         Ibrg==
X-Forwarded-Encrypted: i=1; AJvYcCUuDgEqoYpXnRF8hhwScYtjpuBTwkug7DY8eGmmoILf5NaTyOQtiLxMuV+Bs1kway3f7Xo+fNPjQOBrwjE=@vger.kernel.org, AJvYcCW16kKCUbm/2MecJ8VH38TiuAYgivJv0g3k/I+C30kwFGLKGHjLx1LDqJlzaTLpFFLOYgRkw6JMhJo=@vger.kernel.org, AJvYcCWktzpK6euu5dOo/2gDKzU9ddCha7CQmOw5S3bnFnsOUYPvaVtB+QeVnbbmdrx47MElWA2Qz3K0dUTsrAX7n6faFtQ=@vger.kernel.org, AJvYcCX2FbHGfWfmixT+8beOQYAM3mUAU9jMy9FFs5wPPJx3SgX8tcGVeWshEFj443i9j8JDIYaL020Zb8pcvAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBxvHJSQsb7gnpchlgl8TKXIMz55AA6RA40Xhw+uYEasfmqR2
	JRT8oi+pxgyRBzCp3p0dixIYp935EAINJlwzT2TXR8QLgg97nS4n
X-Google-Smtp-Source: AGHT+IH3gY0tZL9/MUxL78mjhBtGph009hNLuaNSVh3LSVf/dDBE7UBi2zVopRKHMDZ+B1HvKipI4w==
X-Received: by 2002:adf:fc8e:0:b0:368:12ef:92cf with SMTP id ffacd0b85a97d-3748c817d8fmr1533232f8f.48.1724749909408;
        Tue, 27 Aug 2024 02:11:49 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815b7eesm12514046f8f.54.2024.08.27.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:11:49 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:11:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Lukasz Luba <lukasz.luba@arm.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 10/13] memory: tegra30-emc: simplify with scoped for
 each OF child loop
Message-ID: <6tiwlvikgfwp46dy6jufoxskxp3ndcsjfvjqpqu3j7ktjm7zfr@jd7rjcsfexbf>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
 <20240816-cleanup-h-of-node-put-memory-v2-10-9eed0ee16b78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="npgtoufzpxnz3e6o"
Content-Disposition: inline
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-10-9eed0ee16b78@linaro.org>


--npgtoufzpxnz3e6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:54:34PM GMT, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/memory/tegra/tegra30-emc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--npgtoufzpxnz3e6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbNmFMACgkQ3SOs138+
s6HZKBAAweJ23g0Fgjxik4RTRQirppSjP+1/HUTFqkM+1Wup7yNmgLutgDnHlyzw
U8Cs3CK104JEX4gYdN5KutBlaCM+ADq04RW5sYf2D2RGdyu2HEcTswlwqUbcOTps
QB+IIekuf3xrMaOgyL9j/9Q3ghWUXaEf2EKxrg3F67BmifqfCSPIFV6ZgrS27x1O
WGVsPjuRYMSKNmwAtT5thCWT6Ujr8QGg6RgBU7WqqqMHdhWBuZDSgZtaYh2nwAtf
BHUAIaCid9Y/McKi/FboEgv+b+tvLS+Ujxet1TfzaKklC6e0blujbX4Dest+DVSj
ydabhmn9BkC/yEH10EnSPIM+8EyzDGAyF7HLr7dcrmm0S7EqBklOc3jxCzcx8Kl/
Yb/Lea+tOERjM51xtklh5yaPocs7CjOy9fSKGIcTOrurMH9rH4y8VEKuqhTkvRbX
Z0e0g676EgAELmhF1Ky6wSqm4cRMyXzdn983y/JCskuxHAzi/3L2fHRl7X+/VnJu
8Qn7+eXQMJNBHWtJcvCMUGvSFcDv73WBQ/kp3Yydbs3lCZCzftuhWWYUmvqnpBgk
HNrC+c5AW41evENmQrz15UVgiI8FyxXZB0GiiClU2c2VKoIQ+C6+LgWlFLtDCqh/
ljBi8YicXk1zDiVrMt7OSzuDNmEIe2A9TnU1O8b6OOIgmWRtJ/w=
=N5M7
-----END PGP SIGNATURE-----

--npgtoufzpxnz3e6o--

