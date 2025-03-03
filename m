Return-Path: <linux-pm+bounces-23254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2392FA4B8E3
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD293AC944
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F931EE7BB;
	Mon,  3 Mar 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Olb1wiAx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0A1EE021;
	Mon,  3 Mar 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989617; cv=none; b=tC7nZV0C7bdcScltt+Yp5pl4JEl4Jd4Yk0eF8pMTIwmhQ0ajJoA+UNADMj8AvLeIq/d41qopzInAw7dcsp390tLoj5WgV6JLChCRV6pxTrWdo9UFXcWwnP3oR3YffHTNZuP2Zxw4gTj8c/J33xs3B16G3iLHCqnH4xHN5tRegGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989617; c=relaxed/simple;
	bh=1cx/0Wzqkw1bPwi1Nc7TApw4S/0gkdh/tF36qjNrxRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRuYA1lDjMg3pwJ06oMZcMRRqBNkizd2Ms+t2TF3wdAUB8INNqGf9D/v9ZwA/6NPZUdfAcdiID8Ke1bionrWBEjbN/0R4DYLVTcKYPW3sRPbzumRebKvvtC2Ta2xu+ebRFIJTtnwB7iuqGejMawXpSG6Od2s86tqVDWwzAAIVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Olb1wiAx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390f69e71c8so1280682f8f.0;
        Mon, 03 Mar 2025 00:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740989614; x=1741594414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO1v/4//gvyFQ/LwPDpZULEvaHUaoZV84N10PlIJhxE=;
        b=Olb1wiAxyRG8oI2TvSI6saD3hgMboq9We2F+pub/Bp1T3cV9AGFTNve0rpWcw+Hya7
         JWObC5lYj+/HqAApnlm5DQNATJ9JSZ2DOcakk49MrC0frvYgQuyFlvBq54CPf5DKrmU8
         FLvHDRR1+bAbhsOtepA7jnZ8I1bfyH18HIiUKkaCSWG0gBY4uVeIbORzLE6YLeTBegu9
         09Igxv+zIDqdpSYis485ZP372Sa0YRyqAAEquidxG2UQt41vra3vc+abHXv9QtzhYuRA
         tYlo72A4X+96zJxhiW781QD/4VMSKkbswlSdcdgNESyMSzZkdkvb8uY6SpgoBAfBBWJx
         KFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740989614; x=1741594414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO1v/4//gvyFQ/LwPDpZULEvaHUaoZV84N10PlIJhxE=;
        b=AWF5a6AhzkeGCSej/EZd0YtkgZi7ojgKUxSAioY4Exsks/SOpntzeDZ0u03QiUZR/J
         LlZTq/stCEcUUBsQd5k0iGdl5ZkDeCpfbVnA3UBWuzTTq7tv+zlYQDPTGiDPgX0i4NOF
         OFvqZ5GE5Fsee3mWbOT8cVM/KRMTbuC/q+tqhFLAeF8OhGbQVqJMC7CTGvLdEwvvDclI
         sB/hGxsZ2fZprYTepkY9aDK+Llh5hU2QpOYWA18X5sGjVwBqg/LDeCQwYBlG28vnjhPf
         f1T2z7RCSEbZ3gFS1ZHt6+fbr5zBLl6qF9KptLTHlbuULOV9Q5cD8JLrsLhUpLDkXpsJ
         jGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbZy7nJDRFAtNoi6+SWURAr0neM6aOUkDGfRS8EB+k3qg1FVU22i3JJycfugZEuGKj7VZQrpVRhh9lBShd@vger.kernel.org, AJvYcCV8ysw2QLmUxeAGDRLgyrM47P1yKrrOEMdpupuip1uHGFuHrMpLPU7zefO1UKVhATJ5d7ZIsiKIDT4=@vger.kernel.org, AJvYcCXl57sFAwIdCbQj+kjLwM8UxtjPhviXRaAnw+Nol+ouseabwib+/0edoBM4/Lcmk2PR7wpZty9Q3hkb@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4LdYN935ZSbGm0aQsYb42XdAMt5ZJ1AJ1tf4wnJ6fy9NCFpo
	ZwNr1epw9bXrlTF41X0KcJK/9btF/3PfVjB3KSoH3yH5uSLvlgEhI5Iym9FSVtzMYiPeqkfBK1D
	rCmR2+m+oI/NLQH6puSBZF23cdys=
X-Gm-Gg: ASbGncsR0XlrXl+4W2ZzaXRKgIgEZumTNBuoNc+/NKBd5bO+hUPHpxi5HK2zDEr4uQG
	e55QPzxvL59ZtCeWESi80WNQF7Y7a1zqbQJWPR+LOA0ISzbIvxC+qsJN43TJrCEyRvQToTFt7QH
	NXs+MnDrvxlKVG303li9E6jHGmRQ4=
X-Google-Smtp-Source: AGHT+IHN4d7tj/PC9NVTUt0kupriXH4ceWCVyv3rFMZI63Nugtn9+ocm1pMIq1wtSB4Gyj3nEOeMQ/HimavDU4Q5zHQ=
X-Received: by 2002:a05:6000:1787:b0:390:df83:1f22 with SMTP id
 ffacd0b85a97d-390e18d20ddmr13286509f8f.25.1740989613726; Mon, 03 Mar 2025
 00:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226093700.44726-1-clamor95@gmail.com> <20250226093700.44726-2-clamor95@gmail.com>
 <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
 <CAPVz0n2kfxTJUkqrtLia6xBJ8t+fwjujjsc9k=mOk-P06bJH7A@mail.gmail.com> <f83b2a95-e8f6-4e16-bd7f-f7dc96264c04@kernel.org>
In-Reply-To: <f83b2a95-e8f6-4e16-bd7f-f7dc96264c04@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 3 Mar 2025 10:13:22 +0200
X-Gm-Features: AQ5f1JrIM7kZn8l7qiVGIYKIf4ikK-8B_L2nEzqbqEsyYLvp2ITmzJ2q2S2pYpE
Message-ID: <CAPVz0n0KVE8baFyGSgM+0rNfY8+Y2LFZbAhHHzPWTV358gc+Bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 3 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:52 Krzys=
ztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 27/02/2025 12:03, Svyatoslav Ryhel wrote:
> > =D1=87=D1=82, 27 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 12:45 =
Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On Wed, Feb 26, 2025 at 11:36:59AM +0200, Svyatoslav Ryhel wrote:
> >>> +  maxim,fcharge-current-limit-microamp:
> >>> +    description:
> >>> +      Fast-Charge current limit
> >>> +    minimum: 250000
> >>> +    default: 500000
> >>> +    maximum: 1550000
> >>> +
> >>> +  maxim,fcharge-timer-hours:
> >>> +    description:
> >>> +      Fast-Charge timer in hours. Setting this value 3 and lower or =
11 and higher
> >>> +      will disable Fast-Charge timer.
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    default: 5
> >>
> >> You still did not answer why this is board specific. This was rejected
> >> in the past because of that reason and nothing here changed. Nothing
> >> will change without detailed explanation, so use other interfaces if y=
ou
> >> need user-space to configure it (see other drivers, e.g. maxim)
> >>
> >
> > Btw, I have used this awesome example you have provided. Take a look
>
> Where did I provide this example?
>

Its presence in the docs is an example on its no? You have explicitly
told to check other maxim devices, I did so, they all have similar set
of convifurations.

> >
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml?h=
=3Dv6.14-rc4
>
> I opened it and I do not see anything about time. Please point to
> specific line.
>
> But regardless, how did I propose to use 12 year old binding? Where did
> I suggest that one?
>
> >
> > Oh, I wonder why it uses so much values which duplicate battery? I
> > know, it lacks battery, I assume that is why?
>
> No. You added to DT something which is not a hardware property, but
> user-space choice or policy.
>

It is NOT a user-space choice or policy!

>
>
> Best regards,
> Krzysztof

