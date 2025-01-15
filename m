Return-Path: <linux-pm+bounces-20500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CECA12B43
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 19:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0623A5286
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 18:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A411D6199;
	Wed, 15 Jan 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFcyAqJ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FA24A7D5;
	Wed, 15 Jan 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967443; cv=none; b=rlNR5h5D9URdHy4zdYJfZ3dgOmPbzNv+XZ/XmAZeuSEogDJwF0gyPR2Dx3KXE972QpJTh50CQMcHvnxq+BKdaVldwxiRM2EPlIhlk90yPmttsbehHpfT2WP0s8xdQWeF3kTSn6WGbdTlgdwxgTIlKv2Do+dJza+n7In1+8cgnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967443; c=relaxed/simple;
	bh=IR2xwznE+4WYl7pQ3lGz85p+APkypmY6M5Cpe+lrRM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J880f+hqF7/ZWchjuZDJ0ZPsfe2rzyfxgETS2huZO7st7ALXJogO1BfsqGMYaBovt0ZXPEAEPSL7jxa0I5lS81Kp4Emw2azFENT25bqNgPDXVDhJYXcKLtgnEowSkOxAn39p6FhfmS8hDlGXhjlsJnmpFIESrNTvhA8oAbBdk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFcyAqJ2; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85b8c94a6b4so16752241.0;
        Wed, 15 Jan 2025 10:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736967441; x=1737572241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3rBHRWcLK//xf8QI8u0SxcahJkLNHxSKfdrX2ub8N8=;
        b=nFcyAqJ2T+uRK+Wfhw6eUFcmKuxtWpFgduNN0Jp+nfsVDSaW/cPjuAgpEJfSEV+78t
         /or42rqj2Z7lGPLvdIId5Mh90NabTkzzvFftAvax+teBDS6m4Yy7RS2QeiQbEbG2/Q6n
         nY7YFOsqIyn79Nqf1rXZ8Bd4Pbei7BL/QTZ5z9mL8Zshk1tXtCnz2+YWAMpp0qH7lVyg
         yuiRs19y2JLYe/E1mPZQXrRwLlh68tu0Q+YoPleOPsRbjpgIuHXOcwqvwhl0P5/bNdvA
         C8syvWGDDUAcRFCw1IalJfskV3FsiiCTERDAzyQzBqrs2qMxmtJ7O4Th9CD+zvMjbCFa
         NWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736967441; x=1737572241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3rBHRWcLK//xf8QI8u0SxcahJkLNHxSKfdrX2ub8N8=;
        b=jJn/iT7Yqp8QM2FmcFFqyxxxN76LmRDX/l1tHRzBFg33+rCOpj2E48+R/rVqkyQLsT
         bIJOSsewPadn955HIk43JuKN8fbwPsCcU2em9cgduiBU/oqaZwT76jAxQzfPgo+oQOpa
         DGbvYiRHGpqPw+W2UyPDWCRfMevZkB/rYH/jAMBwWp02e3VT+UpcKWALx4w5kmLin6Wq
         S5ZJd6JAKCXoDp2LtPIdqM74vH4Hj3ndavh1O2Hbr+1SBw9XGYNJs83wMlWdww678Nxs
         vfkhhze4uYsmJJJvL9X1bHXtbsJ/HSqaTV29P3qIInP599/GYIB+LDcRdbEr6JOyY/Pe
         ASOw==
X-Forwarded-Encrypted: i=1; AJvYcCUFmOJA6viX/pl4m7vXcj+jy2+Op9/lgy60PnQnE0k5GYX3sTg1b9FX24k/UcNcg/q3vOLOoANW/iQ=@vger.kernel.org, AJvYcCVEecKq03wMR6R7DGSEpaP+k56ny+wWef/U3SQR1RLmEWR+AGVx17EcvVadP/kvuKAlcerRzPyI0R5P@vger.kernel.org, AJvYcCWQzWhiOj7rbV9MTAjLaE86Vo54BeHNIM9qN0n0bolwNQmF/7t68oOGlJpYIfRsaEQsf5aSPvmJCmp47w==@vger.kernel.org, AJvYcCXRAqbwTceK9ZFGT2fq+qr0IeDS/LQLi/NEv3iVKALMerBR0yDnuNOnJ6WhN8lgonFO7hNF5XRy/OsaWpxu@vger.kernel.org, AJvYcCXw/rvpTTZusjWdw4xOybP3GbJvbqD2Cr+qKAjKNOdKZHTpR5R2phaskVOCUNiz2Cj00jVIsxZaUy/sE18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwq8ZLGhe3322nZ83hDKOA6WhEjR5Xu7LmZKYAh/p++Jjz7MN2
	bv8pdVK8C0jM0PDRGgA8olnjnYehJwTpE0dh735Em2nINggu7fgrKR0YwGXFfpKMOGjj1cGDSy8
	Yueu4mMeaY6PgubvfrybNxbbE4AI=
X-Gm-Gg: ASbGncttERD0ECZnSQIYKqAUwd1JoFXAHwRDNG+FbexVu65CbUZkcmP+j08Jq/C+hWQ
	ydpQ862+udrfZUqMhqT6DR0TT0J9S6bTaDE1DEQ==
X-Google-Smtp-Source: AGHT+IE55Rdnoo5jX5nfajWgoNNwUTnz6FOgcf+XznEOImYy05XNUfoQS5g6zQ6+0C00XjS1svK50Bh5JpBiykBUoAs=
X-Received: by 2002:a05:6102:578e:b0:4af:eccf:e3ca with SMTP id
 ada2fe7eead31-4b3d0da8a8cmr27249008137.10.1736967440942; Wed, 15 Jan 2025
 10:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-7-f6e84ec20d96@gmail.com> <20250109120158.GH6763@google.com>
In-Reply-To: <20250109120158.GH6763@google.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 15 Jan 2025 21:57:09 +0300
X-Gm-Features: AbW1kvaKlV8za9mZKmha3NIhIgfbbIci3s1GldX6Gil1h0TJ6PBMmhbBMhVV-SQ
Message-ID: <CABTCjFAky55btJz3B=K2kL5gSJD9BYi5t15jaA2ga5asVT=3NQ@mail.gmail.com>
Subject: Re: [PATCH v14 07/10] mfd: simple-mfd-i2c: Add MAX77705 support
To: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 9 =D1=8F=D0=BD=D0=B2. 2025=E2=80=AF=D0=B3. =D0=B2 15:02, Lee =
Jones <lee@kernel.org>:
>
> On Wed, 08 Jan 2025, Dzmitry Sankouski wrote:
>
> > Add MAX77705 support - fuel gauge and hwmon devices.
> > Hwmon provides charger input and system bus measurements.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
(...)
> >  static const struct of_device_id simple_mfd_i2c_of_match[] =3D {
> >       { .compatible =3D "kontron,sl28cpld" },
> >       { .compatible =3D "silergy,sy7636a", .data =3D &silergy_sy7636a},
> >       { .compatible =3D "maxim,max5970", .data =3D &maxim_max5970},
> >       { .compatible =3D "maxim,max5978", .data =3D &maxim_max5970},
> > +     { .compatible =3D "maxim,max77705-battery", .data =3D &maxim_mon_=
max77705},
>
> Drop the battery part from the MFD (group) name please.
>

It will then conflict with MAX77705 mfd driver compatible.

--=20
Best regards and thanks for review,
Dzmitry

