Return-Path: <linux-pm+bounces-21690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB62A2EC56
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B4B16065A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5F621E094;
	Mon, 10 Feb 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzw9r0CW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFC1F3D41;
	Mon, 10 Feb 2025 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189436; cv=none; b=nubXStXXBYoq8pWo7A9e2btdJEhIQQLMGBPfC5majhepDKtDLdjsZAGVTeyv9WfEyFCR+W2OwbHQ0fC8h7myhgly56ZwLvhWTWArLMorklzyWapz8tESsNxf9IUtg2l3wriG+oRnmK31PyuPMIeDOi88WcwW0A/+zIbpnrPQa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189436; c=relaxed/simple;
	bh=iVV5fItADhSdmSptdzySm7drerIykRqZzWFXa7Bk090=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJCU1FXqWG2m1HteRu69TSrC/cP0X2gjr5GxSf828AJhAoEBjooWMQtZyJHP4S4fBbO/ejQg/ELTaORWprzMNdJ+Jg2oFD9sKDlWFvZ1RgvRYDyANXCkI6PjHQIij+xfQkFDoLmk/P7vLtIC/0D8xHJq00drpxgukQiPbih9N1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzw9r0CW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso102126366b.0;
        Mon, 10 Feb 2025 04:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739189433; x=1739794233; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iVV5fItADhSdmSptdzySm7drerIykRqZzWFXa7Bk090=;
        b=Dzw9r0CWwINAE0w8WWJZwcTIbk9xT1RhOVTDyKAVpH6iCQvZ8CsoG4/dEveJismE+V
         6DD11n3ZxwkMPhcjyO9BjNee/EncME9zAoHGx5NwpxBSv2alLUzEyqVu23OUp4aueoX1
         vvmL3USJdVFxQE2cI/C5Q6sJQ6HiWROp6tKsalgxz5nmbwUwmsi3b+qcETIIL38nqTak
         4hBH+pOw1WMWipTdMad9EldOYDaMleHRgacYI1h55QkLlicf0gkbJWRpCkcLEnYQnpEb
         116OOc2w5Mk0H2+M2u9o3Xk6rmTVIMpHPodhjyce9wV3kfO1igtmp+hAFokq9IGjeLmz
         u1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739189433; x=1739794233;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVV5fItADhSdmSptdzySm7drerIykRqZzWFXa7Bk090=;
        b=Y8wk38d48UzlZDpJIjnpk8DJMCO1kUDA5eDd7pegiPqAcW01bgYRL/HICH487r6etK
         zmkqU0AEKiCX8A0TRraSrReY/WbnpJAx1whBudvSRg36R/bzxVRngfk6KsrCB5OovSbf
         rXBZfJzS729wKrXAmJBMXpyJsVvtl5FRV9fFhEeSaa3rxPSVkBHz2sE72F2FVpN2NLxu
         NZK8Hvq5htJt0iHkXWqTq3N7riLx9deCn8P20vKVpnBnLyATvfrdmS4xEKWKakuexNbt
         a8SNc0aalY31J23x0yl+kcCpd/tnE2ScfbNy++bwi6IBfGNZWpxPTS5Z0QarAIu7X+na
         tBtw==
X-Forwarded-Encrypted: i=1; AJvYcCVUCL+J5XSl/LZml/TqotwWTNnZ99QI2lJFv3tIRwUFrdkRl0bW4aBhkownVBefmHkyjQYTSlfQjwAG@vger.kernel.org, AJvYcCWMAffUG5KrDOt7Iz8boHxTg7N2aTPGZnBfHELasyhqVON4gFFNzr4WEA8hYjErRvMQWk3TaKc41/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qOU6YsWDHdyjse0MhFUuPjiQyFGZ0APgej14CwHtsmT3OMg0
	3dJcg6Iv9f6uJVzA95AumOphQbjm+Zkg93CzXz0ZO+gnBE65oprT
X-Gm-Gg: ASbGncuMW2q5EdUKhJA8K91/J1BECIyNHYqPGykWQ3+oxcIQX4DoCdulYBU3+TY81xz
	wr19ahC1CLgAZJ2cVNPxTONHG7sWw1Vk1yosXx1dIu6TSWAowEWZ5WxiVNa7Nb4p0uSe9G/ohvv
	bqVis8FFP9CDJB2XEiTjJrKMfCf8X6tEYlfxjlBeJBznn23K2vfeNZzEj24pgYulOrwxTdQWWtg
	IQ5A4S1M0pQZ9AILaLBGlfooVxJNOw6X8/H8cpeKUEkgq+ZnEqfovWfLWoH/NbJW0Zi3bY8ZwEm
	AfDJsbygd1wWglQZOaW2CNUUOAx4+kKF
X-Google-Smtp-Source: AGHT+IG0r7IUI08jzz62jmBNjDxyMCWdSH4iEcWJL4NhmxdTXJTTGmJz9BnjUWRrDIT9Op9nqTWxqw==
X-Received: by 2002:a17:907:740e:b0:ab7:c41b:a25a with SMTP id a640c23a62f3a-ab7c41ba2e1mr201449966b.6.1739189432773;
        Mon, 10 Feb 2025 04:10:32 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b12d5f49sm364727266b.73.2025.02.10.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 04:10:32 -0800 (PST)
Message-ID: <783a005a5e81796d572558ec083ff08b5adb34df.camel@gmail.com>
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
Date: Mon, 10 Feb 2025 13:10:30 +0100
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

Thanks for quick feedback Inochi!

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

Could you please elaborate on the "big problem"?
Does the binary-distributed ATF perform some other type of reset in WARM ca=
se?
(COLD is just mirorred based on TRM).

> carefully and needs further discussion. Adding these two syscon
> compatiable may be not a good idea and cause some problem. I invite
> Yixun to this talk and he may give some useful suggestions.
>=20
> At last, I prefer this goes to an separate patch series, and
> implement with rtc device.

Sure, I can split the reboot story from the series...

--=20
Alexander Sverdlin.


