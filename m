Return-Path: <linux-pm+bounces-21857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D410AA3157F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E26168BB7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF1626E629;
	Tue, 11 Feb 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6M4WqTa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7CF26E622;
	Tue, 11 Feb 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302628; cv=none; b=tOPxvs9HUhkfW/FlbYDsPk0HMUv/xX8YYzCAhz91TnjaqkyRkmMM95gSbME0kzOj2VcWwXkinLw/2gpzN00+NazuCDcovtP4hUEV43J+/se5knMUWN3ANdcdvsvn+4x4aV408mwzETZICR3E2IrUOy7m7hZd28bXpfALD6Uauk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302628; c=relaxed/simple;
	bh=9e/sGwyL68UNjItnpSAp9MDvTFErGvwXM2lfdp/wyfc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GLiM+DTE/sgVGC9FodM0c8/VfWRSRhWuG/7DO39Vi2n6Hal1jC4y4LS/x4qXgxbV/dtFPw+ZXNWg/te1TT6UQVfC3r/+4iW4wVbOj3DU09vt8siU7It04VLpRsYmFBFETRTOif7nyqOW/rbW/dSS4NLLfyL3yW+/TOhR6NxQ8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6M4WqTa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso159571066b.3;
        Tue, 11 Feb 2025 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302625; x=1739907425; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9e/sGwyL68UNjItnpSAp9MDvTFErGvwXM2lfdp/wyfc=;
        b=T6M4WqTaQZCDH4dGFhscMfFilIs3MyED+VWmNdbwhna/lE+TRkaLpHBguRgV+O3il4
         nLWFu74ZfbamwLH3oeoWNA22jPLcWSfONx4z6C6Yd7fIGvA0qWX4N+MQlVuIMEPen2uK
         aoaKJLngSJ/b65a77EbEIoqy3NHFBPFsEcAoYF6owwxFbTc7umBVh/bai7ibbRKdVtaR
         gnQ7zXYxJZIMccbRbX/O0fu1/YQ/gPnmalSkGK3xvSzFRwkwb+OFSm3PEns5iTr+Xkxt
         kaaRbHFQfSpsy1rN8gV5dVjd23cR63Kj+44YsgN2CR6nV9VolbFH+OzR+5DzLOzLJr6A
         S+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302625; x=1739907425;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9e/sGwyL68UNjItnpSAp9MDvTFErGvwXM2lfdp/wyfc=;
        b=pE3SRRbkwJLW/YzeBQiYICzOyI+lVTJUk0mdh0RzZe6cIqzeG1yEF7XNFnX68U1uwh
         PYJ2mf21V/nB+x9zicpOkRRcfXt5AllAsIFbC7ku0qOgDBHnBkwPYwf7R8xmu7ui9I63
         Od7qJPbVjXSr/FK/hDl/Y6bu8Y3aTwrU7wHAwa3dPGYCgY9wI0D8bAppWlXVxNQi0WPK
         WA2Dx5LSdIBIJRBFQtkA/nVkOfof+BKIoKbLFuOXobZUek3D7odwU8VOZndgSyy8QR43
         kqnVrLdbGPlS0T6ivdpw6xFu87NQgugd9JQTK9INU9ZrkQ77tB39t1ivbAvDYHq5NtgC
         uEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+FMJSLom7SUOEfYPpcVg4XNyEfwfKMQf7+GFuZ1VkzWVUx7ZZrFmz57BnjJ2SDExOy45IsKFE5xo=@vger.kernel.org, AJvYcCXSSwbJJ3jd70nCuSpgHIw6isBxVuDC9U6lOkzVgh2xOhvcGiOXqEPHM65Wh6Bc/I/wMKQ6rHMwL3BT@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQ5tC6B+nnBjkIZ5C3W7eJkMLvCGDD3lWSvVRVQ9Cv+Rvi/J4
	Y0DVnLk0ZGSonjOUnhqmTO8Fo54MK6Fd63yHHyb3gC67uFQ49B6BvT1LSFrn
X-Gm-Gg: ASbGnct5SL3q2kiKXRG32Yiw7U3JWP6sAIngRjkxE6B3EbWn+p6Gp3Mml9n0tZ3VJKy
	nPnwUftM6yyn89OS5ALjJ+Vju75dQi9usWN0132s7VI1EUAuP9k+6NsmWtrEnvTQaSvcOYbhita
	J/3Yc43vNkW7iEKFIa2XBEpPJcVfB2G/6xmFXgisamdSlEFXXeYlX/itiYExI8oFjYaKOXCtlbF
	kpSelwuCxVvuFvO0NpIFKo/Nurgbl40sWUSx2bxG6YzHwE6XNzzuJClDXffogw3XjyVuMiprxCe
	CpaQm5WlDv2px2BhuyB0eXd+oFPGmB3S
X-Google-Smtp-Source: AGHT+IEQ/slzGtIIDpKNl/JqYbFTtsrceMpYlWtOML0fOzvbP4uW4Jm2p4lFLsInfuuv0UWM2bB/xg==
X-Received: by 2002:a17:907:1c17:b0:ab7:d7fd:6250 with SMTP id a640c23a62f3a-ab7f347a6a1mr18121866b.43.1739302624828;
        Tue, 11 Feb 2025 11:37:04 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7cbc313c5sm364663666b.150.2025.02.11.11.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:37:04 -0800 (PST)
Message-ID: <ccadcdf720d6b1055165f1404fafca9b1c6c54f7.camel@gmail.com>
Subject: Re: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Yixun Lan <dlan@gentoo.org>
Cc: soc@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
	 <inochiama@outlook.com>, Lee Jones <lee@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, devicetree@vger.kernel.org, Haylen Chu
	 <heylenay@outlook.com>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Date: Tue, 11 Feb 2025 20:37:01 +0100
In-Reply-To: <77c0db160bcaa7c2a68c04a0d33a561b2834f764.camel@gmail.com>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
		 <eoeyutuu4mrpsu7snkk5ll6kmm4344qsgbnncss6gerlcvvea7@usuf5v7w5ffp>
	 <77c0db160bcaa7c2a68c04a0d33a561b2834f764.camel@gmail.com>
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

On Mon, 2025-02-10 at 21:55 +0100, Alexander Sverdlin wrote:
> > > It would probably make sense that the whole series would go into SOC =
tree,
> > > even though technically nothing prevents the reboot/reset driver to c=
ome
> > > in PM/reset tree. If everything would come together, `reboot` command=
 would
> > > work out of the box.
> > >=20
> > > [1] https://milkv.io/docs/duo/getting-started/duo-module-01
> > > [2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
> > > [3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm=
-v1.01/sg2000_trm_en.pdf
> > >=20
> >=20
> > This reboot implentment across the RTC and 8051 domain, which is
> > still a big problem to be upstreamed. This should be designed=20
>=20
> Now I've got it. The problem is not in the reboot procedure, but
> rather how to model this thing in the DT, because of all these
> unrelated functions brought into two HW address spaces...
>=20
> > carefully and needs further discussion. Adding these two syscon
> > compatiable may be not a good idea and cause some problem. I invite
> > Yixun to this talk and he may give some useful suggestions.
> >=20
> > At last, I prefer this goes to an separate patch series, and
> > implement with rtc device.

Thanks for your hints!
I've completely missed the RTC driver in progress [1].
I will provide a patch registering the reboot handler on top of the driver
as soon as it's accepted.

[1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20240428060848.706=
573-3-qiujingbao.dlmu@gmail.com/

--=20
Alexander Sverdlin.


