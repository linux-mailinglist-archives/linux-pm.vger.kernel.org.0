Return-Path: <linux-pm+bounces-29942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9985AF0623
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 00:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054E21C080B1
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0822265CC8;
	Tue,  1 Jul 2025 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb6q70EP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62E7260F;
	Tue,  1 Jul 2025 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407341; cv=none; b=mEq94+nwEwEzYCowhcO4HI/AkLqb35T1HNNJMh0HKrG8v8Eh3NDK+MWZwW509KiU0mjx2Cv31e0TgLiUYBeieRcEj8qa5B8z3/iO5rCBV4Lt2buqT5rJkj5pQrVilnElsnga38wyYcrQrr1lHenqRQjQAVpb/5upgnLzvnKSHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407341; c=relaxed/simple;
	bh=/UEZb8NkTVMB0RuIfOdOOTMZsG9K+IXgRCinG9NNSXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iR9s8ShvVG+30BlAEQ4SJrp+1IjBvtwSLl+ugjm4LnSWmFd0GbKh2JmwlfDbBs0dSu9/wFxOGr9KF/F4OYZCefrReVJvKalUGTXMnnP31xQtUAVSatPek0O1JuQ01mEVgxuS4dnxWmrscEiqrk+Xg8/0ovPmkPy+CFn85BA+hn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb6q70EP; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so3133517276.1;
        Tue, 01 Jul 2025 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751407338; x=1752012138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+3A1kXTvGxPm2wKLJImng/HgBPkwj3/5xTfa5vLd9M=;
        b=Nb6q70EPN0pkXppjque2cH+WtCPP5r5Ykw0ry/PzhSF497qwEbgLICcEpxRK0qNrPx
         IWvo6JrMILw3rhIb4HSbtOIAZM+yDTSwDGgVGg2vmjhM1m7xHSxsK5li5sCytVvt1GGu
         dmfw51ZE5mjJjGjmVVDdyLYYX6LiNu/rXvDBXR54wXW6+flIrsYtVM5pY1WP7fgn2VFl
         QHziO2KKGNAnRvWP/gpQzI6ofgKVTpAQ2T7HtqSOuC0KM6en3t8Rdwni9snSj1UZHCbt
         4XecUtl11bC16Cqix8exunJQ61lwkev6W1eh4GJKOXc1Rf9OjUFkI3t2JCCsAEnZIW3y
         h4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751407338; x=1752012138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+3A1kXTvGxPm2wKLJImng/HgBPkwj3/5xTfa5vLd9M=;
        b=rTwx+NH6xFJ1aabo/FNsVX/4+nS/SEoPPEYXzIFFYubcS8risdvHWDGO4AEzKihqme
         /4y27PHK9tgl74aqXRb33KeOc0OSf3IniVSX6uRObEhXywZZap4en7Sgy6f2GlxToNn3
         ZoguuCjGL9IpiJgQ6E4QsIfDuA1BRER/PNiYRl8Jpl+b1lsFfjW78t8Ph5kVHSXNy+FC
         gJ7pgfxPsspQyxi6HmmFMsyI4PQLM6OKDWUUuv9CtlReMSDOFCa44x6g776X8mXwEtEn
         M7M3F7KRxomheG22WJB9XhUkFQBIByZCk6B9eujIEW80PnmMFl8KoADo6JVncMVmpMrv
         m6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6hcI/P/I2YuUUuP/wLodRzc/hID1bWWvvhrHRJ2i1mLh6q0LTQIMytnngOxwTwnYDUf2UQLdPBts=@vger.kernel.org, AJvYcCVwBtltbo2X1hzX2FxUTntpYEdQVFyLHwRzrneHxFdsVRRcVkykX6GIu69daf7BO0M+OSEUPI/ztyI2jRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwweZ/w9Fbyhv2Z5vE78rw6n0BNVNV2OMRRocHQ4VpQJ9aHons6
	EITKe0CEBe3XzeSZa+AOVRs1WnmAegDSK46qaDhb5vVTqhkGG47OWXbb0yRFqNzDIW6yEjJI1T+
	HXLbciBqsP9fLqHclzYJ51TL4UN/WlK4E3Siskk8=
X-Gm-Gg: ASbGncvRp5ZBX1DS4STzMspdv3mCwuf3qmyDIGyTkPMmatt5y+CwZsDwugK08Ssrlr6
	A+0S+zA5qvrctTKjQdXIedAkAeHWiXl6dmXjoU68xdp32PNTG2sr5gIEL3UqLjD3CFSGc2Edjxw
	JZdwLKnvgKyUFpI39RHLpxBlxdSJSbRuk1TKH571p4
X-Google-Smtp-Source: AGHT+IF2UwMzQTrU3c/1ff/h/O/X4HdiWRMl22fU7K+HHjqvTPMz+NeEM0BS0HZeGjnyecFyCDlnJtDG71RLt/iQtNg=
X-Received: by 2002:a05:690c:ec3:b0:70e:1771:c165 with SMTP id
 00721157ae682-7164d47332amr5473697b3.29.1751407338021; Tue, 01 Jul 2025
 15:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701215648.95912-1-sivany32@gmail.com>
In-Reply-To: <20250701215648.95912-1-sivany32@gmail.com>
From: Sivan Zohar Kotzer <sivany32@gmail.com>
Date: Wed, 2 Jul 2025 01:02:06 +0300
X-Gm-Features: Ac12FXyoix9dUSUaftAXwYQOV8H9M1SaO6QN7zS1MwNHDnFdaMqKkUFGl-8U9sU
Message-ID: <CAB_eDKbTzZh7Dp8E1LroEOb4zVA6Mo0guoRqh3p18ipaZuUAug@mail.gmail.com>
Subject: Re: [PATCH v1] Linux 6.16-rc2
To: Daniel Lezcano <daniel.lezcano@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: elazarl@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This email was sent by accident, my apologies.

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=D7=
=B3, 2 =D7=91=D7=99=D7=95=D7=9C=D7=99 2025 =D7=91-0:56 =D7=9E=D7=90=D7=AA =
=E2=80=AASivan Zohar-Kotzer=E2=80=AC=E2=80=8F
<=E2=80=AAsivany32@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 69c534982415..ba0827a1fccd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,7 +2,7 @@
>  VERSION =3D 6
>  PATCHLEVEL =3D 16
>  SUBLEVEL =3D 0
> -EXTRAVERSION =3D -rc1
> +EXTRAVERSION =3D -rc2
>  NAME =3D Baby Opossum Posse
>
>  # *DOCUMENTATION*
> --
> 2.45.2
>

