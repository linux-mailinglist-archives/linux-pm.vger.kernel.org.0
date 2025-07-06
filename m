Return-Path: <linux-pm+bounces-30220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E02AFA6BE
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D172F1775B7
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03459293C49;
	Sun,  6 Jul 2025 17:13:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFB293C41;
	Sun,  6 Jul 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822032; cv=none; b=YzBFUOD+P/FD6gmL3eKVGPDvHZZ5XRaq3GL60UXLI5Slb9M+O+PG6TqjbyB+c1VDLR3mthC+MCTyNdDeQ5OY4YsRC0pJmSpXhvsOEsXqZq8UuItbgi3EcxQu28CK0X02qALPITlACVemFbHKOr67KIrxLucv3RgIjv2SxDEqxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822032; c=relaxed/simple;
	bh=xntmh5L/t1M0BbaxBvySuQJ4cfMmgjmGufu3g9VVg/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d89lhHHe+9kjQv/0kwXH4kBV4oblY0hCbCs1C/pZT1Rn2njAgEonMqdQleyPbf7FR9u+DJJfLrxHyGSLo4Vy3tpiAnHxGv1VPy+3+ao2rHi7SJhKHgjwgpEObNnK4rWdlsup00DawTrUlEB/eeY0fFgBvtS0hZ7D3XhcJtFDEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b5931037eso19341071fa.2;
        Sun, 06 Jul 2025 10:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751822027; x=1752426827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xntmh5L/t1M0BbaxBvySuQJ4cfMmgjmGufu3g9VVg/I=;
        b=sUaALF3YbJMqS3ItYKZ0/IM2CJJw8HPv/1smBARD2erFLz1BaMBVCkjDyfmqZ0EvHA
         KGdfkaiuFbfj2oIfl9DG01RNYJRwJ3HwTMxjbW3X0ueANd5RFA7lSlD5+KBkb7UDCA8C
         mMdCOZNBQcS348X7X1W4vLYPTXlSM3S8bU7Zz5cIT3BQpJTacs5typ8eSZoIhPXAC/Dj
         o83um6NmhCaf9KEjdddgjZ59tS2Rr1G4d4wOva9TDfph8ZjbADZA7GvAh4vIoLJ+6tGm
         V6qZMpq6gZyJu9OAvKJb6jPjU1jTFKVyu0SzyKtt6ick0Fa3Qm2lGc6uxrQunE8emC+Y
         dIEA==
X-Forwarded-Encrypted: i=1; AJvYcCXWQMwBp1M4MwxZ1WSDUx6ewb+UOh81PDxeySjA1gSNTRW1JXEXm1KsTaogCxbgQXy/VSWv4IfyiW7uwyrC@vger.kernel.org, AJvYcCXuVtEKOPkwmcAYq+vq32oep0zyeIASQjemWvNNdJJS4dxuWCm7rHUktYA+Wg7Rk1bJF0iebjoiA+o1@vger.kernel.org, AJvYcCXzz/otEHRH4muZip+2BJ7L2TvetNAJTjysHUJ2DqZNuSmlGR0+UhB3vg6kgmVYB9ct6BnsuSK18pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fj1z4m7cYSAGET5ZTRzV3Oyr98rUvdY4PlIkmXv8RjWJlgot
	3a0vDns42t0FX7DuOn5wpu2uMWrEcZYmV4HmQp0btEedZ6oTE3R49/TBJDL7EuP7LMk=
X-Gm-Gg: ASbGncsZyz6bVpF7xsjbfijm2OUf59YFJdu9V7rTh1B5/nFuRX6BcW3Ev4XAe9Rbbpp
	Ko/VpOiJb/h6OWe8KJG6na8TnQPNqNA85uGZRlFSYX215bBLyZ0H569HR7ZWrq0T7zSShvBYdmW
	x0OSznn16O+DuIcB2DF+eveJ+4OMyrTd56KX45nkIyBTBCvV0IZrMIrdHXE2tA8skPvdekSvt8J
	jfaNkXEM3kpU3a/1zOD0PRzt9s4YVcucL6u47oSssaoMyxNfQ/tlRIWhkZw8j81jVB6tEdK9gPV
	sqUrToP93znVqRXleNjNgRlksk966hq719eheou1z3eIeucyoNtPlO3u2KqyBhse2wnfeqs8SQp
	5GlSTerRc/VSj1eTjzKc=
X-Google-Smtp-Source: AGHT+IHICAyUSGDzBu/0egFiheyvtXM0+BZxNqcVM9Rzskwguj+wcc2S2Gq4CbZSVAsxyPsbHm8jGw==
X-Received: by 2002:a2e:bc06:0:b0:32c:bc69:e918 with SMTP id 38308e7fff4ca-32f19a348a5mr15522991fa.1.1751822026587;
        Sun, 06 Jul 2025 10:13:46 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1b121ce7sm8926921fa.64.2025.07.06.10.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 10:13:46 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32f1df5703aso7642081fa.3;
        Sun, 06 Jul 2025 10:13:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+wEmJqX2XNY7NKCC2pkbTNHMd7PO+bni7jj9RmKgkykiRYf2EcR73MVJejG+BojGiJXLuOTIkHQg4@vger.kernel.org, AJvYcCW3ijdcngaCDqAj3YF21aDos0pG8Yj+zIbnNT21ZuWDoA98PXP/YauA5cGi6JHu1e/obRtNohMMfv8=@vger.kernel.org, AJvYcCXhKM2kujtcLrg+87XzaONJrF8mwnJdq78qexp2kb8XMGedTET2dWs1IXPOZfEk54YXjVQnj99zF+bQtGu2@vger.kernel.org
X-Received: by 2002:a05:6512:4006:b0:553:25b2:357d with SMTP id
 2adb3069b0e04-557e55a492fmr1336495e87.52.1751822025791; Sun, 06 Jul 2025
 10:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703151132.2642378-1-iuncuim@gmail.com> <20250703151132.2642378-5-iuncuim@gmail.com>
In-Reply-To: <20250703151132.2642378-5-iuncuim@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 7 Jul 2025 01:13:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v64_Qib8ZOJAV4YM0i+iWZUdNiKyMCjXPB-MkgFJ3T3qYA@mail.gmail.com>
X-Gm-Features: Ac12FXyldBjty2mm-UwbDbRGBw3sjMptAz34h6GSxjv76j_NWWYkZYXpbLYbm4U
Message-ID: <CAGb2v64_Qib8ZOJAV4YM0i+iWZUdNiKyMCjXPB-MkgFJ3T3qYA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] thermal/drivers/sun8i: replace devm_reset_control_get
 to devm_reset_control_get_shared_deasserted
To: iuncuim <iuncuim@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 11:13=E2=80=AFPM iuncuim <iuncuim@gmail.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> The A523 processor has two temperature controllers, but they share a comm=
on
> reset line. We can to use devm_reset_control_get_shared_deasserted() inst=
ead
> of devm_reset_control_get(). This will simplify the driver.

Nit: I'd probably write:

Make it shared with the shared variant of devm_reset_control_get(), and als=
o
simplify the driver by switching to devm_reset_control_get_shared_deasserte=
d().

> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

