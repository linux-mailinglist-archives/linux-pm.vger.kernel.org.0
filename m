Return-Path: <linux-pm+bounces-23256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94610A4B902
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 09:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA75616819D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B51E51F2;
	Mon,  3 Mar 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh7g72hN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623723F36D;
	Mon,  3 Mar 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990060; cv=none; b=I9+2zd9aWqWWD7kHZAKGJ5WUtdEQd9FDEMLDODb4cvThEkWkhCDznT2yFO26h4SAUDok13y2pYq60zhwVJiQiSD8mUpRfydk0wr6XzJYfzJfj3LUoGZrrJwbzvkNFonKrZoGKjgxcRRcAbrhesfqwzYEyN8RV/P9w5YfTKzUT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990060; c=relaxed/simple;
	bh=VakzlJs/xcdEOWQWX9R14jQUbZP3sQXWRSAbUYNbi1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GChzxpNPi+SsUvpa+ANucR6mswDSMFILA3c5DMzCaQxEl6hW0lw/JxH6EBsxAGLWXyUFDsuN504Jrmc1bKhnwLMPzPgNpyR7ptFUdQti9OKq9VexgHucxB12Bq8DcUYEn8ot75lZih4h+58hRQsuns7lLjFP0ECa0kGaXV/Ty84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh7g72hN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso6950605e9.3;
        Mon, 03 Mar 2025 00:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740990057; x=1741594857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzxza1cfhmoiOmmh2gLoCOLOpzXx+3CsGqXrYLmlnQk=;
        b=dh7g72hNaGSaoZiy8xoaqPxOAzwtbPZGqEZ3wrqD6pATQ7SdvpgF0D1Kx2qOoSPiWY
         Q2Vlos+21ea/oOXAe9YapqAUa/eCm6ygc1347ABe/zOkZdx6Hei5pKlzOoUlevawd8nu
         dKMzv4yX549fS4+VgyKyiIEVHp5d1w7rZbNAYuHxpRvmxlBfPc153/jvh6KmqRVbwF+l
         aIfUSKBuuN7WZp1hXIhLPBdMSaB5qBp/Co4HfizLTTR+DVhlimzLFD3zPjZyg9/gNPCC
         ZQg1bw96rvdmm/CXF8eoqv1bkmyiiv0wgTNMaE3oX75TH/n9c+p5QBhKXx4kjg/yEbux
         RySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990057; x=1741594857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzxza1cfhmoiOmmh2gLoCOLOpzXx+3CsGqXrYLmlnQk=;
        b=JSjUuLW7ajoE89SAf1TZO8dskZrg/SCtcCNwtjSulZ4y/XJpLtAfdqtITAjkK+dEh8
         w67HgiUp5T/NI4EMktlkz9a/JqNZc6Ryu1m0EizSdbNq7/gbPDeguvYFksowVaN+T3tE
         aHceo7T8mMun5QhqOuGyxfOJh6JTCAJz9T87cpDvmUTEGHz2RWyKsw9mlcE/LSFitOnX
         y6g7+rhutmOgZt882i4ZOzwWGqgvym4aY13xj40Zup+z8U2G+LxjwFaQN9H0JSohzj/h
         +f0ehjh2Sjwi8FCbuPKvRp3M2XoosJtX1qZagE378CIILTX4yYIp16kCGSSufY38H759
         W9tg==
X-Forwarded-Encrypted: i=1; AJvYcCU0zMvmQH5xs1J9AV2j0iRue+e9S7W0Yf778LJOp8BMdNu9DPGTrVWscoWPE9RonCQPHZh1v/4Gfio=@vger.kernel.org, AJvYcCUk2LQ/LLsg+Srv74Zg3l4iW14AXLBmcaPqK4hEid2zrfh8ZyIcAmJoHZ9yWUYVxb4PillafCsFykFURI9d@vger.kernel.org, AJvYcCXc6y9two1bQgg2g4cTk7JuHKiyKml/xRgGiTFbnER1c3r491+VJVBC/APuhWZXrpfj9rHz6NB8OZZq@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQApoTcmredQP/M1jYCPstZxrGSdCNLbN1Qmx6DeMTUHZm/DJ
	Z4vB6qY5XzNz2NFbSJdtTFDWjquVpSA0778F+KG9eJG72SG0rfsF8bPx+OvhIqLZZliGv7CSlcB
	LIgqny8BbfcSmlV+LGRYZUl0VJ9E=
X-Gm-Gg: ASbGncu6sovMAIjomJ3cIBFujlTh8ogYE+c2fcvyP6nriJVBtz1t65ZzOHf/QwWxI5N
	GYF02wySGKG2zct3HFSIAp3Jd8HriW8EzeyXXsMZBjufP9+YGIQaedORMKM9xga3or/JrqF2oll
	v60BAga/Ad0tj/Yl32zBkfs8vD4Jc=
X-Google-Smtp-Source: AGHT+IEXhvSfvEIABzQmrugb/ZqRCzgrY8w3fvkcZFLDmGDRuTp7MZs43FMgZU1HNivmm4un/jEJjjncDDet5tyVoXM=
X-Received: by 2002:a5d:6da2:0:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-390ec9bcf2cmr8084690f8f.27.1740990057403; Mon, 03 Mar 2025
 00:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226093700.44726-1-clamor95@gmail.com> <20250226093700.44726-2-clamor95@gmail.com>
 <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
 <CAPVz0n0ygR=ygsvG2+z-zST7kmJ_P3nxf29tqdgHpRs_Nw6D5Q@mail.gmail.com>
 <fbd307ae-1dfa-497b-a597-d15b6baa30f4@kernel.org> <CAPVz0n2no1EJnf4GKSJWfYA_8h8x6BRk_ducufie90YPZR-k3g@mail.gmail.com>
 <0b2a76e6-ad64-4c98-b6ab-e1f41cb54684@kernel.org>
In-Reply-To: <0b2a76e6-ad64-4c98-b6ab-e1f41cb54684@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 3 Mar 2025 10:20:46 +0200
X-Gm-Features: AQ5f1JqGXOM8lR2BOmU1oL5ljAlnewK15hrd2z6vwtD7i3C8KZdGU-4Xk-9ZZN0
Message-ID: <CAPVz0n2+=m93MXNV-0Lvu5OQzquNSyV2EBRQPDEnpSw-AZFo+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 3 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:18 Krzys=
ztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 03/03/2025 09:11, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 3 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:54 K=
rzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On 27/02/2025 11:55, Svyatoslav Ryhel wrote:
> >>>>> +
> >>
> >> Please kindly trim the replies from unnecessary context. It makes it
> >> much easier to find new content.
> >>
> >>>>> +  maxim,usb-in-current-limit-microamp:
> >>>>> +    description:
> >>>>> +      USB Input current limit
> >>>>> +    minimum: 100000
> >>>>> +    default: 500000
> >>>>> +    maximum: 1500000
> >>>>> +
> >>>>> +  maxim,ac-in-current-limit-microamp:
> >>>>> +    description:
> >>>>> +      AC Input current limit
> >>>>> +    minimum: 100000
> >>>>> +    default: 500000
> >>>>> +    maximum: 1500000
> >>>>
> >>>> Half of these properties as well are not suitable and duplicate exis=
ting
> >>>> sysfs interface.
> >>>>
> >>>
> >>> All these properties allow configure the charger to suit the device o=
n
> >>> which it is used. None of them are required but are a nice addition.
> >>> Why you are denying me an ability to fully utilize hardware I have an=
d
> >>> tune it to the device? All those values represent hardware registers
> >>> which can be customized for the device, not for the end user to mess
> >>> with.
> >>
> >> Because you put user-space choice or OS policy into the DT and DT is n=
ot
> >> for that.
> >>
> >
> > Those are NOT user-space choice or OS policy those are vendor
> > configuration for a specific device and are NOT and NEVER were exposed
>
> Then look at existing devices. We had these discussions in the past and
> these are usually exposed to user-space.
>

Provide an example, where there is same or similar configuration.

> > to user configurations EVER. User messing with those may lead to
> > device breaking.
> >
> >>>
> >>>> And for remaining, still no battery.
> >>>>
> >>>
> >>> reference to power-supply IS included, hence the battery option is
> >>> there as well.
> >>
> >> I don't see it being used at all and you explicitly duplicated
> >> properties which means that reference is redundant and should be dropp=
ed
> >> with such binding. So how did you solve my request to add reference
> >> which then you make redundant? Add reference and use it.
> >>
> >
> > Which properties I have duplicated?
>
> All the current limits.
>

Those are blank works, show me an example of such duplication.

> >
> >> Best regards,
> >> Krzysztof
>
>
> Best regards,
> Krzysztof

