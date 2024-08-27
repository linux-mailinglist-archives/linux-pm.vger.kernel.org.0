Return-Path: <linux-pm+bounces-12943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE996053E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F278F2836BA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59626199EAB;
	Tue, 27 Aug 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYsDWP2P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4792199E98;
	Tue, 27 Aug 2024 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749946; cv=none; b=ckGv0e4Ee680NG1UwyZHnpmhVKiHcN61GOPKkzATMUSju2CUtbgHoLdUHQbzE9BOyiMOMTO+xG+M+KV+PrtSl4uZvBTDzVu4kAT84FmuT3Lq+6u2F1oS3RsTXgAhrvA14BZhCgVITWGpf1IvZ/LEcwMOQWk6J8Nu9oEv1Bv389c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749946; c=relaxed/simple;
	bh=PZl2vCFO1281eoFnU2BPuzcAFcsLYdAlE5TlB6KUs7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9jeL8PwZ4tXngZ7aHeAwqNy77bg+ChtTjJay62qFw0oNh+wO2ftDQrWaxUlGXdYv2AEJf0P2Maap0O11zAgWluIPYo8vn2crruZLpR6UnkYDidwnEumBGSjIC0zytpQntBqV4nNR51G+1Kv8jxFLGQQFqNkyayXNdTsnHVYN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYsDWP2P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so44609005e9.3;
        Tue, 27 Aug 2024 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724749943; x=1725354743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZl2vCFO1281eoFnU2BPuzcAFcsLYdAlE5TlB6KUs7A=;
        b=jYsDWP2PS3EyZCmVT6uK6aHhEYDuvfwjfXyGdwFwjfoXRsahAB6TNPh2GYMkVrEIq1
         zmt8Gl2GoYoi+n1Q6U2hdOafR57Tq2a6qCGy9ebIKiGg0k0ncZ/1iVLf9vPvtaN++dg8
         K/LUy2xskGfHKM/zGyTNYC0smnHW8zQbB9zu91BK3VH5tJN9YLTDZpTnb47wxDwfKahN
         jWt4rOUjSAhKwvhi4uSNrMntRvqxaHwqchX8SLGa0gajHPtPH3pPC7LC7Tn0BZR2BU+5
         se3M9n5spd8DmwMm4gC47WAV8h5LuXBnOyEJ3uqxC+gHZBmy+LBDXtQkECnoUCFt5nJR
         0e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724749943; x=1725354743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZl2vCFO1281eoFnU2BPuzcAFcsLYdAlE5TlB6KUs7A=;
        b=bw5lk133kuDt1Fd6nScHEKVTak+CsPIAYc8wr1wKqczGiMsCxMJRpllQ6CR3pp8lP0
         76QMsag+jBqx3LsdczNudm3fKDI64NQeZnB9dhW3kPaBX2zcFcXrNh3L4xK7TshxaD4N
         eT3Aw+cclCa5FewLcMHg0kihP7VhEAvkJMoBG4a274g8FigjBBd9rM8K7MAFF4oLSIul
         doSq5cvB9buqQeUp2zifQK9Nqa4HFDxlNry2+4SSZtwoLMG2g7+QhvKHS2cv7VmO/Drr
         /qFyUXGZE8PyLp6FLAzhBjrvGV6CPPyWtIeuCOChjkkQ50GZinziWy+KiPHpdlc8cW6m
         nveg==
X-Forwarded-Encrypted: i=1; AJvYcCVEEp/WlytcXJ2TspNmVRjaw8jq7PWiKAhUX1tiwZ3qxzmn3Fl+WE1H7CDf1M3J2zLU72BT8nt0uRToaZI=@vger.kernel.org, AJvYcCWNdUTE3K2ppG1ANVRHTAVLYmBvL3Qu36GCW9GD7wdXDO20L9Sok1MKO08ybBOS8KZALmQkltNQEBA=@vger.kernel.org, AJvYcCXMvKMSIwO3gYku/zipAXLl5Hq8xh/joi7INRPI6n5rf4bb7mtQyJ4UCAiZHbnuEKiHQUCLjshgXWQoJP0sSbNN32A=@vger.kernel.org, AJvYcCXor3ON6TdMYYI2ON287jAwu9Ujgnrfb8MXPQR7n82G7cXN0wIj5waq37dPVbQPVl8DvvtN63oi9uPe4kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLseJLR5UeeGuyXN502eXxr0bDFzCSrX//82BZTiyA65O9EnT
	9VF0iXURTMOnfLMYxw7DqFQv0fFZHZR8Y30u8rrCQY/1CW4jp7AV
X-Google-Smtp-Source: AGHT+IFrH1pE6tC+TQJPd5XlVKe0OED8mLEGfHKVZm18+ThOAIlLOC9xj1SU4ZgwBYz9RdlGvzKzUA==
X-Received: by 2002:a7b:c40a:0:b0:428:e820:37ae with SMTP id 5b1f17b1804b1-42b8a0516b1mr69014115e9.1.1724749942211;
        Tue, 27 Aug 2024 02:12:22 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158485sm178380545e9.13.2024.08.27.02.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:12:21 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:12:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Lukasz Luba <lukasz.luba@arm.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/13] memory: simplify with scoped/cleanup.h for
 device nodes
Message-ID: <qqdysgpkbfwfnelu6epeb2gwqgdo7xgc6x3yhkuahlaswy5lyo@gh5vfwnigbpa>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
 <641cf75c-3b6f-4913-ab49-5d0ee821780e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n64k4hkfi6aufqrw"
Content-Disposition: inline
In-Reply-To: <641cf75c-3b6f-4913-ab49-5d0ee821780e@kernel.org>


--n64k4hkfi6aufqrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 01:41:54PM GMT, Krzysztof Kozlowski wrote:
> On 16/08/2024 12:54, Krzysztof Kozlowski wrote:
> > Changes in v2:
> > - Add tags
> > - Wrap lines before of_parse_phandle() (Jonathan)
> > - Few new patches (see individual changelogs)
> > - Link to v1: https://lore.kernel.org/r/20240812-cleanup-h-of-node-put-=
memory-v1-0-5065a8f361d2@linaro.org
> >=20
> > Make code a bit simpler and smaller by using cleanup.h when handling
> > device nodes.
> >=20
> > Best regards,
>=20
> Rebased (some changes around ti-aemif) and applied.

Oh heh... nevermind those Acked-bys that I just sent out then. =3D)

Thierry

--n64k4hkfi6aufqrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbNmHMACgkQ3SOs138+
s6EojA//YW130a8HBrEqedkHaXwnQAIP7qPmM2Evewmi9wcBVZNgz1GVGpjhOQUX
XBXltrFkOsbOYojaRZKrXcl2bmgvuEAwrq0qaYqC4YWST4KyMKuXj8W/3QEroxBF
a76eC9KwmBUawTg3hrMk+b8kryDem56xMx66AxPPpCXxL89JayAjAe0AahXquHNI
b+Jow1N6uapZMudoQugWsMC/huRcJ+/BA4FAJgi5QgLV3IovkipCnqgTlnRFGuLs
FViWpdSAAmCuAxsjBzbQTRc0LnfwrEQPOwuJDiJ6E3OpA6cg5pAgN5ahJqZLdagt
pT7UNzdwG1LnwVa6lg12rMeIENhhQpUUoRkKRGl9kuUYWPr4idTPQLFsB/5Q36BI
sNSLCXzzxSk5c+9Zxr+k13Yf5DLjp+sgdBdUeFOwQQnqLjhvgnpULlsiXBZNC4A5
NTLropv5Bh0pBaKaolxtjQ190QNDrtmCA1ZhF+mf9MkDE+ZdAK/XnTIIdfDDD6Hd
l90kYTSvscD9W2WqzO7f2UqmZABIAyvqZ/j49JKFQLhiOi4iYp4KQzWdQgDKaFyW
+GBloBNtOQflVimd5yt3LeXffkm8jfrGYY4U+yRTmcHgWKrT5tikjO5t7YwrpJjX
8ttg2+qAQ1m9vldrAVju+MoF+9gQEJZGxtJy+a6xgjshhPU5zhc=
=V649
-----END PGP SIGNATURE-----

--n64k4hkfi6aufqrw--

