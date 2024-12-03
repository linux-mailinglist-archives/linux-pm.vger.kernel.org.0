Return-Path: <linux-pm+bounces-18449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 567759E1C91
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67325B2B905
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245A1E3DD7;
	Tue,  3 Dec 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxThEjep"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A81DAC9B;
	Tue,  3 Dec 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225317; cv=none; b=Aa9Txo2lvRe6fir4oRVwsjgRII8fHveSrnPsNgRNzAgwRd/JZZZ5IGqrWLmv5qjR+Dc02gliiZ3D6s52tt0k5yaypp2YiT3oyoLV+CbjfavVGlFV2aUL+w70RF4bdIRBoXSRHnPCnI4Rfa0Rz0P95XUxQzZ72dgFpFedXGPJaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225317; c=relaxed/simple;
	bh=uFD82lfUaqmFa0SW4A8CIE2jSQ+uLoNYrWt+ytTiGEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+aavC3YwOP1H7celER24GZegovqwGPbwypXNOecNTByLnsaGW3gVmHgRrtxq2Omm6iXh4e5+QTxUwibKRN5EcNgSZtrB1+FbKIJrgJ8phOCXrF/UpJIfiHJeZof9S34D+tyuejWzICBmlVLy2q79X4rsMAdwctFRYovqfiw+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxThEjep; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4addd900de1so1462073137.3;
        Tue, 03 Dec 2024 03:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733225315; x=1733830115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUDXNZCYWiCK45PJREl6+pbiOaktV/BGz0W3ktyqkZw=;
        b=SxThEjepaqe1p7GbqKjYDtTHCpXms/js7EhShIJShXDx4uRseKEQBsFDY/GGXzW4kE
         ttdC4EvpAmgk73sh8uys6JhmqIaBhogU4ck6Ou+wLOrQlgguMtXC2dHuGF0ayhfHdnyP
         dLVc3cg8nQJvt3XwcJxMyUZAsjPlcErlx3M78phb7wYeJzDugmeUDq0WTkvsMl5zEEKz
         ISbBg3E2t1O3YOnJ3pLXATbrrBRj8zPNkiMSJ+O/A8JVuplElVrqAUmqQcYWl5ysNm7b
         ValbOq2ktlaMlCJRMUYNisYf+M1Xb/Y91lmbdRadyvBcgzFupMkb+9a3UFB+gMPBxD2u
         k5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225315; x=1733830115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUDXNZCYWiCK45PJREl6+pbiOaktV/BGz0W3ktyqkZw=;
        b=pYwp+BdzWC1MeOcMGMWt93G7bt0iiQFIK4OslmU351oXxpY1IXlHQS5ICz+EvmxpXt
         Ux6pAQdNHeGwISHn7Lhbk3t/til6TUW2Rte9SB8mcvRbZgQydGaZIqeipKbUASmaaQGV
         hm3Jckvsl0LEKfhlj6Didgo/PQFe7b/uPeRXlHg+hMu791qa2S8AF8lwCx0wA6Ioao5v
         UUKrgjGhlp3FZ72vH68C4z1RwiY6o5TGBn2ezuxwk+cEgijA/iqXGSxdrmXMUsP5v/K/
         sOTUsS8SJOLqNpaWnslbTr13K2n0Xcm7j+MX9upDxQGZOs9bFQygYScAs7fpipOQlQdX
         Y0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUA2/+7bbP72+OarfLKHe1BYRiFLm81ma3JKkqWpsKdfFHtrCTn3WpP8dU+qEc3ivyTO+fDGG+7f8c=@vger.kernel.org, AJvYcCUH89m9cq2NGACvkspIGcyp4NiEXlRPlj1Bsj4wO93LiplU+VUEdqGY8MWXYO9KDhuABzRLAmd2m2gc@vger.kernel.org, AJvYcCWHgBXvjciJG/F1rU6L0AXkz2Jhb2e021HD7yk00P7HOP/S4pH0dLtWw/wsmJ4Gp2H6n6RuNTQXVeUIvwCI@vger.kernel.org, AJvYcCWtIKMSb48f2rDycB1ZmoafsOBGqasVodzxN/idYKWlG02+YaInKGruh+75Uuhb3v/OBfX3SgBDM+0sHg==@vger.kernel.org, AJvYcCX40/0ZerdDkDG6/4xMG5cIKspX84c88zVrjQ+UO7bwHLpdc7590OZjewzmbCc3hTAoLpoLuHYD3/tKH8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNeLxX4Tak2SyNUtPpSQqEFyExgl+rtPHiVDL5+gbcqOT81Rx
	aFaxKLxEiVHxQto92vrwW3Wr8moewSa8dItrfCz9LAGbnbAmB8KJ7aTCvoeEAB8PBCB6PMi+ZlH
	WUvZQ52JsTp0eUmD2MyKbK4wpZFS7LJYChh0=
X-Gm-Gg: ASbGncvqni7ZzwFnRlraevRb9OlBAYcp8JEkgkxNoLhQuecyLSY9Zpy0uYYbtb2rgEa
	YyVU2JmV003IB6YOMxCswT86h+brHJg==
X-Google-Smtp-Source: AGHT+IEndB6pk/DzcTZzUouHlgRe2f2qscDGcabSOetf6OTGTegcOdRoEnEqf+PSGTcaKHi5p2+xjS8N2TF9s4FkRT4=
X-Received: by 2002:a67:e893:0:b0:4af:983f:6f0e with SMTP id
 ada2fe7eead31-4af983f6f8amr1871709137.20.1733225315019; Tue, 03 Dec 2024
 03:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
 <20241202-starqltechn_integration_upstream-v9-6-a1adc3bae2b8@gmail.com> <59c27c5d-3db7-44da-b3ac-7b8e7c8b6f16@kernel.org>
In-Reply-To: <59c27c5d-3db7-44da-b3ac-7b8e7c8b6f16@kernel.org>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 3 Dec 2024 14:28:24 +0300
Message-ID: <CABTCjFAZn5g_1ZR0+pN5JgpsikhhajsX0hdaDSvuT2Z-0Um71g@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] mfd: Add new driver for MAX77705 PMIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 2 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 13:23, Krzy=
sztof Kozlowski <krzk@kernel.org>:
>
> On 02/12/2024 10:47, Dzmitry Sankouski wrote:
> > Add the core MFD driver for max77705 PMIC. We define five sub-devices
> > for which the drivers will be added in subsequent patches.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> >
(...)
> > +     /* Unmask interrupts from all blocks in interrupt source register=
 */
> > +     ret =3D regmap_update_bits(max77705->regmap,
> > +                              MAX77705_PMIC_REG_INTSRC_MASK,
> > +                              MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX=
77705_SRC_IRQ_ALL);
>
>
> The need for cast comes from some compiler warning?
>

BIT macro creates a 64 bit constant value. When inverted,
it overruns 32 bit value, causing compiler to warn on conversion like
`warning: conversion from =E2=80=98long unsigned int=E2=80=99 to =E2=80=98u=
nsigned int=E2=80=99`.

--=20

Best regards and thanks for review,
Dzmitry

