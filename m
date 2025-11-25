Return-Path: <linux-pm+bounces-38619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF63C85E4E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44B4335114A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A2725A2A2;
	Tue, 25 Nov 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwj3FjFX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3723C503
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087118; cv=none; b=vBTMn+WuotfRIxWVz/AS8rbqQbSnqU+6I/KsZaAe5JjaUX6kwPXgpriVOug57QzOlAJ0oEpDY+6uEdMQt4TX+iYBoI8tWimqM7Nyj0RzeEz4CoHXEJw182I2+/52b1G7NaUw8E71EHAtLBouKAUXk9GtKhBze//ld/f5/MaO+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087118; c=relaxed/simple;
	bh=BuZrTAyq8hriBu1hSQ7Fw+Kj5Pru8BEFikgqu5lpwuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7MkPHsqSPrRrb4BhaeAfRU3XiHLQJsv3BZUBQOCFKaCmk30NN+Nu7bHADyPPxwKtJXPujgPX4SKzAtJKERkf3fpcjPkuEbbJt068eNpPcbgzP2QsSK9LHr9ifrhaEwQCH6fHl1/6M1OPET6VNQlBp+2YV5qaK6K/BG+9Bx4SZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwj3FjFX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34585428e33so5663873a91.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764087116; x=1764691916; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BuZrTAyq8hriBu1hSQ7Fw+Kj5Pru8BEFikgqu5lpwuo=;
        b=Bwj3FjFXPs8a9wS4amr9YpCAspdsOrVG+yRJxZr2qr6loVDR6a3GJwV3TjG1K8ugjR
         vb5S+yxFAPW9Zvh0bJCcpUCMx5xrAICNUxgzAslfUCG8NtfxFr9nsLZOjTVIYCgGYgZo
         rflo4WKrMrdP8hxRbe1Zxu/c6+JkS5a2dcY/DXQePpvgEUIxNGObAKh3OzYb4SZRkHsj
         fmcQoA2cu7YcMftfOzTbsK/uPJzRYfI1r5V2nOApzvSWEnOmR6oVQ5vnx0Iqs37qvuGC
         /QjidajXjx81vY3bbI3KEsxuqnUS+NV4moyeLLXirYgr/FSVCHfJ6llaevGVx7cL19t5
         XOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087116; x=1764691916;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuZrTAyq8hriBu1hSQ7Fw+Kj5Pru8BEFikgqu5lpwuo=;
        b=q4yp+c+lni+5fomanPC+c2+9OkbmWKwfd7QcMRzAy9KL93GgHFbdFmKdUiZeLSsVZR
         PSgEFURGIKu7FvgqdoZ63uxY3KKA7XzNfHGXSMryU2h8e5nr+OScaQODl6Kx8cKplrBE
         GaGIh9Mez4hZ0PO4eOsiWUH5PsVep3BXnnjbCopFWhlSo+PY79068U9CkUqIMxHoIiXW
         IDUCyhYLtfRiPzmRPFiEVP31sF2saBytoTbQdsQwNbK8IZEZI8IghAX0i554zWdRKO/i
         UMTvtZYAtQhiovF002X+KRcpEkzY1ExkabFD6hhxjAugv+lHcmLVmdxWwrd4F+qSyQaQ
         kQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXajERyWoqZ34NSKulbgmb4i+BnIOTuLFfbJJ+ASyQw06npVqbTLzK2PizIg8cJ4Q8F0N3aH+2Pmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoW12FhHCIbsv9ufR4lHGFTx5USt3OvVF52KLaBMLd6oHiGbuF
	wH/MVIhAAvxv1F90xSm0WNYwJ0wKWYy3588WKzDht1fVK94dZ7XUMoP6
X-Gm-Gg: ASbGncvy6PPyvwtyEWhC6+/s+hU81po0EB/dzuH5xYaqsrzCgeJucx9V7tz11l4GzUi
	wKaZ9cU7poMQ6pgWLk3QUz9YYVyH0H9CIBSD2ovfbXBFT7bicrQoOXxX8leX74+ok8Uahw2UZyl
	Qqg3Vea7E9yoBPtdtxskCxd2JRmZdjTVgbDOVFN+gsbgwf8wFaakfNz3x3sHUxQyPWXZH9IMlLZ
	4o9Y90P90dT+rCnvrvqGiJwXqQVs44MJLwfP6QCLPE/B82w7+OHsw9nfu3+DeaQNPYv17aCF4MN
	IWkesg5h9z2wwaU3STHUc21DksnZpQDLASIoI2zyHgElyp1cJutMr1AaYarfI7xMVNXxuekEUN6
	/pAD73BaJNWRjq4Ss+PogZwvUFx1ZPjsYIq8+grwSdyr/q4m58kbWYNaPIfP4C9OLPHk9bv9IWh
	VVdu72dJs8i1BED+z0U0UI43aVEenKAyndgfFt4NwfXumNoT5z3+AdNNs34oJteasCRA==
X-Google-Smtp-Source: AGHT+IEWXlqC42ig+eSywfDNQtEHaCjz4s5p+M3v/+IuUcUyKtCw+yNJ/t4+Y0x5LwSh4SzxUB/PrQ==
X-Received: by 2002:a17:90b:384f:b0:340:ac7c:6387 with SMTP id 98e67ed59e1d1-34733e2d4a5mr19048369a91.7.1764087116050;
        Tue, 25 Nov 2025 08:11:56 -0800 (PST)
Received: from ?IPv6:2401:4900:8fce:eb65:99e9:53c:32e6:4996? ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ff9fed2sm1369564a91.6.2025.11.25.08.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:11:55 -0800 (PST)
Message-ID: <43f43063b81da41b693d5eb8178d5c55ebaaa168.camel@gmail.com>
Subject: Re: [PATCH RESEND v6] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dwaipayan Ray	
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe
 Perches	 <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Andy
 Whitcroft	 <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, Geert Uytterhoeven	
 <geert@linux-m68k.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>
Date: Tue, 25 Nov 2025 21:41:47 +0530
In-Reply-To: <58393a1f-272b-41be-9ebd-ae03678cb738@kernel.org>
References: 
	<20251125-aheev-checkpatch-uninitialized-free-v6-1-70e8bb1e9175@gmail.com>
	 <58393a1f-272b-41be-9ebd-ae03678cb738@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 16:09 +0100, Krzysztof Kozlowski wrote:
> On 25/11/2025 14:32, Ally Heev wrote:
> > uninitialized pointers with __free attribute can cause undefined
> > behavior as the memory randomly assigned to the pointer is freed
> > automatically when the pointer goes out of scope.
> > add check in checkpatch to detect such issues.
> >=20
> > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@=
suswa.mountain/
> > Link: https://lore.kernel.org/all/58fd478f408a34b578ee8d949c5c4b4da4d4f=
41d.camel@HansenPartnership.com/
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
>=20
>=20
> <form letter>
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.
>=20
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
> of patchset, under or above your Signed-off-by tag, unless patch changed
> significantly (e.g. new properties added to the DT bindings). Tag is
> "received", when provided in a message replied to you on the mailing
> list. Tools like b4 can help here. However, there's no need to repost
> patches *only* to add the tags. The upstream maintainer will do that for
> tags received on the version they apply.
>=20
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/s=
ubmitting-patches.rst#L577
>=20
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
>=20
>=20
> Best regards,
> Krzysztof

Oopsie. I should have sent a new version instead of resending a failed
one. I have updated the `UNINITIALIZED_PTR_WITH_FREE` error description
in the checkpatch doc as outlined in v6 changelog, so, didn't add a
Reviewed-by tag

For some reason gmail blocked me from sending v6 to everyone in the
patch except me. b4 thought it successfully sent the patch and
incremented the version number. So, I had to resend it

Thanks,
Ally



