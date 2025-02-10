Return-Path: <linux-pm+bounces-21734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBB2A2FB22
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 21:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031E81888ACB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 20:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C664A1BCA0F;
	Mon, 10 Feb 2025 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeWyZeah"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D4264609;
	Mon, 10 Feb 2025 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220907; cv=none; b=lfWAX51nbTtQr6DSlFE7oI80vDggsSyrqryTlJq6roz/gnkkRBhwShZKmk96ebCab8Hk3EqhKX+X9I85ECRw+H0Es7ORHmpkgCVwJuUOIH3z36TAojCqbdJApkJmmUJwXJqFHO2F6y89cFTj4UiCPVy6sMJD+VhPaKv0VeAqOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220907; c=relaxed/simple;
	bh=WpjZBk1tco5NPGp1mA5Zogy2Y/Xj4BgJWgEyk1N9n9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SdnWOwqORhFkxbURubeU5n3mxONvelJjlwT5xMStJc9G+8S1svawT5Abv/mVyBU/d0Qc1ABiHxwn+VHemtBG3YE/4mGklWlvXDPIWfZMw38dtrMO1botOTTQAUEcQtKayz5Rtbi1+ARWJgHxYJQDRAL5OmSk0Yav2TDrxHpWO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeWyZeah; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso197276266b.0;
        Mon, 10 Feb 2025 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739220904; x=1739825704; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WpjZBk1tco5NPGp1mA5Zogy2Y/Xj4BgJWgEyk1N9n9c=;
        b=DeWyZeahiQnq3SjicNfM+GaYquN5oZKdC+IQWFlC5rw0U3VRpIG1aQYfGzD+RfuTnC
         3pt4uFkkrnASiiZGKqEzGB7payV8wk6wpcUUAWw7xJJ7zehhCEEazcWdjeHo5/BX5aMU
         y7EDEp+/WfWBjbemzhD3Wf9QjDSuCJzGIVgsZ9p6FPJUfyaQl2tDmXi9aeGpEcbiNTbq
         TW/w/rCllZnfXvFFEynyDNy8xHkxL4JqBuUcg+RPIQekSaE4rDdCpLR3ZsRltAOTu4zV
         hFPOrj6eNbd+AxqZTbt0zhmb3UohFrp/6uQH1uJQZ9uEFJJcxSu9Gft7JbhWbIO49IHO
         2hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220904; x=1739825704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpjZBk1tco5NPGp1mA5Zogy2Y/Xj4BgJWgEyk1N9n9c=;
        b=RQJYgcIzjf9fJIqx1H/Q1sSVKhSUoCSjgdaBa8xzMw/MBIHRCpCwJYuwsg89i572li
         Ss3P9B2K2LxK94NJqlL0cllyfH5hyWZhLVksxETA9VedFeJB2724IjD00na0Pf7uuKNy
         tA5dh1B8PrbcQi/DYVgwsIabjoLvztNw8+1bLVmQyZ4okruYIueIWEiLWTQVfZONki1t
         Xjy8tXcJ7//XswTGZs/OVf84VEXqs8oCDdGcsKMgc4cwKbbTn/A0FMEQcvyvmaq5nYsc
         wE4q9teo+NdizzQk5Cm6HSLCAOl91C1fpw53OfHOuAmbG/Eh1VItZ0LfjBLweNWr+m2l
         JMPg==
X-Forwarded-Encrypted: i=1; AJvYcCWN+tl2ZZAKazuKIRIyzAtv7k0v/PUhiDbSK7youXy/s9W3yKkJpiec1sy4W5IOTjGNGosfJx0VdRBp@vger.kernel.org, AJvYcCXmB41shyZ2hitCHSwgQgBwOSyv8bAqRErUmheEsPmq1lo12acAuwFPM/pIjcdRIb8R1AIhnEtNkhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyktsTutesbH0GJfuhuRc3yT4MLycqv5dJtMxg6jGSsaLTB5vCn
	p6FqJ/GbvyQKonlUcrfbYLUTMHBAWni6BTk2v77y5zpZ+zeT/WBO
X-Gm-Gg: ASbGncvUpsawrVgKTxgZXp32YgdhrY20qnN8vuEIrVY/rEnb6xb84o9a/IVLeN4Tg4M
	Wr7yMccLCbGFEAjad6UVg9Z0n1LaUjuaCJzRwza8uZIoaauxmSFs8r3kA8po+dX7fZA+oILGlty
	53YyasPRt7CA76SdkXm+9bxCAGS2i7FVTuOpv9iXglkSrQzAZeE02AibFr5FMNgPVc6BV8ezk0j
	MJQlEfud/34nWNt/AeTQzJ/XYQY2tfFNj5b6t6YmE+LlpHLZ6RRYIo3PjphjQi7p01HJ4VeO5NW
	hUduVD4gMemqXue847j1DkRwUhz/SjgQ
X-Google-Smtp-Source: AGHT+IFJYUVYcZgeTbbOIf2IE2QjryPq2pdJRg1RIOBNc7TQaHZymLDKrGCSZgTlknghtW+yN9uTHw==
X-Received: by 2002:a17:906:c109:b0:ab7:b9b5:60ff with SMTP id a640c23a62f3a-ab7daf01893mr82813066b.2.1739220903984;
        Mon, 10 Feb 2025 12:55:03 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7cc737d81sm179019066b.176.2025.02.10.12.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:55:03 -0800 (PST)
Message-ID: <77c0db160bcaa7c2a68c04a0d33a561b2834f764.camel@gmail.com>
Subject: Re: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Yixun Lan <dlan@gentoo.org>
Cc: soc@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
	 <inochiama@outlook.com>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel	 <p.zabel@pengutronix.de>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sebastian
 Reichel <sre@kernel.org>, 	devicetree@vger.kernel.org, Haylen Chu
 <heylenay@outlook.com>, 	linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, 	linux-pm@vger.kernel.org
Date: Mon, 10 Feb 2025 21:55:01 +0100
In-Reply-To: <eoeyutuu4mrpsu7snkk5ll6kmm4344qsgbnncss6gerlcvvea7@usuf5v7w5ffp>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
	 <eoeyutuu4mrpsu7snkk5ll6kmm4344qsgbnncss6gerlcvvea7@usuf5v7w5ffp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Inochi!

On Mon, 2025-02-10 at 13:33 +0800, Inochi Amaoto wrote:
> > It would probably make sense that the whole series would go into SOC tr=
ee,
> > even though technically nothing prevents the reboot/reset driver to com=
e
> > in PM/reset tree. If everything would come together, `reboot` command w=
ould
> > work out of the box.
> >=20
> > [1] https://milkv.io/docs/duo/getting-started/duo-module-01
> > [2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
> > [3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v=
1.01/sg2000_trm_en.pdf
> >=20
>=20
> This reboot implentment across the RTC and 8051 domain, which is
> still a big problem to be upstreamed. This should be designed=20

Now I've got it. The problem is not in the reboot procedure, but
rather how to model this thing in the DT, because of all these
unrelated functions brought into two HW address spaces...

> carefully and needs further discussion. Adding these two syscon
> compatiable may be not a good idea and cause some problem. I invite
> Yixun to this talk and he may give some useful suggestions.
>=20
> At last, I prefer this goes to an separate patch series, and
> implement with rtc device.

--=20
Alexander Sverdlin.


