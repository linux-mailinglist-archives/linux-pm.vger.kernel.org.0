Return-Path: <linux-pm+bounces-23910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF29A5DA0D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 10:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08C43B4A6C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 09:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184EB23C8D0;
	Wed, 12 Mar 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X45fVYL8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9423C8AE;
	Wed, 12 Mar 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773440; cv=none; b=Prm0PWPTCR8/Z4TYn2mM6MTuBAvl6yp1feAaVT8EmLOlV+OjUK4VVBE6W1H8jSlzfH+ooz8qjf0p5ZoEi3eXTcnBMIEKyhoumwHPicEqxPSEnUSFAiJhG76PCikETkjHBYQGTQaQWOi/kqqflUzJqao513ajf29vvU3MRr5lB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773440; c=relaxed/simple;
	bh=MRFFW5+5MiGjJoDsl30p/S9DIYlDXxeob2SpJmgOj20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/fPiaVJj7fn2bUE5lPZFHAMxTFVQuJ++sYzHKUdilZETCZ+Jrl6vZ+q6ympEHlzo48Rttvjr1rjLuwimo78xKsm06n+OipHP2EacZFXM0w7JuvYJ+UjT3d+6vuxf71n0V8szokVVNCCp4dzq2s8GSKUBFwmTvcOfL/Tri+xM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X45fVYL8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3137961f8f.3;
        Wed, 12 Mar 2025 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741773436; x=1742378236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Bk0+6TyveDnhFSN4ubd8Ki6PyJoMe7ilhOG2b+TwmQ=;
        b=X45fVYL8XICL1l6ywaSE1eqgfpdcam5LDM7s68g8pWjQqLO8RuoezvG0YxjBhlokVh
         zmmi6KKi+/VxkqoyV5WNoaV57zhlJhyZbDKk3k4X/IHh1ud9qqk9KX/c3R3Eklay8+8+
         jTBcvA78NUYnEAoobiOqvrIHcxfLs5IeA8K1olnHqebwcNv/Ml2ltkWkLDNaaJd1hh6e
         GETl/xyK4gKbso282Wq+gzpT+qG77M5CkKp6AkCcuSZvomTZz7nVYhSPtuFS93QEAlJf
         qkpcE9w3G1BCNTQXYcoKR3DpBY9vTMTUkJDzwIZbsmvRTQSDostTGWFCNSfyBb/7ktjL
         PAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741773436; x=1742378236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Bk0+6TyveDnhFSN4ubd8Ki6PyJoMe7ilhOG2b+TwmQ=;
        b=BJ6Ha3SdH7i7Cf/oLOimmDhGQdBTyusUNea996JZ7h+VOig80EEW7lk3YiaLgQhCJ/
         DkNawpxgOn5d2qiYuUEcP3NCjmRt+dc/Qt6aUf8wGd34Y7QfecX8FjQYc385kJIub9I6
         vGj3d44FHXAlGY0xsJhBBscrzrSgWOrg/KWqrTFDTQcwcDDteEHF2isYx/sbrtAY8A2D
         Guczj2ZKG4CHy6NK4kSf2QDQ2QsUoHPS6ffJklhsC8GwIVslCbByy9qAMYhLA7QWvr+m
         UBxU3IgAk68qvDd+PkRv/OqJuqWBcqjTrXqRa47X6nT74WOFdw1H+XVOlt2HiBoRLUx3
         xJGA==
X-Forwarded-Encrypted: i=1; AJvYcCUjdIRt9LwRLJVy2B0N2ooDzXua+fopIwKQnMIC3XHYuOpL6yCYmwny5pmq1qKQy5WALhmSKoy+RNGD@vger.kernel.org, AJvYcCWLqQVTxInTLcS/DlBhxF6kpB/fDWHIiuWlnFdE7DypBatQFIekpmSyARMtrC4VS+CilD4ViadMj44=@vger.kernel.org, AJvYcCWtbTHWZrf2xBBfNQ++l/oXSa9lQ/higtrKnvHGD3uYQzCmZ7aO6uI4oyZrFzJYtReFC7kF4rZcHnOmnvnW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JisPx9XBjxnYIxUc0HknTCRa7wS4GVlx/7m0sAUNItpO32oM
	Dh9mOmnscSlTfTeczpVRHieUi1waY/Uo2M86B0Z3slxNFuFqGCxurV7mf6DxTRgNdQN+xJ3/EFv
	kZ54z7I5+sKpI43NdAK+pX9mX0Z0=
X-Gm-Gg: ASbGncs8LypCNKmcj9nUtLGDYHK3ezZdcVi90RBUxASe7W33m3aADLIH+eHFuruin34
	hXeBmPkaOR6jXa3w2f+dZFgCHHzxfXD06Rl2s/oMcIEuwYK9wcg9c7AwGMPDAulmHRHQIl6g08G
	xJWcwDJ4p0hrL3XBb9MCRjsaI4IN0=
X-Google-Smtp-Source: AGHT+IGRG52MpBzZ4/Ng/tlPI9MLq485xsY5jmMJ52FzXP3WMdFQYzendKxMCVxYqZZI46lbWuSnkeYAQUzI9fNbrlk=
X-Received: by 2002:a05:6000:1a8e:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-39132da9221mr16952047f8f.35.1741773436350; Wed, 12 Mar 2025
 02:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310080237.7400-1-clamor95@gmail.com> <20250310080237.7400-2-clamor95@gmail.com>
 <20250311193732.GA4183071-robh@kernel.org> <CAPVz0n09ZP1i2tasdTvnt8RvjhALvUYjv9u_EGRtnXPOYQtuqQ@mail.gmail.com>
 <4d1c3eb1-5c42-490f-83e5-60de05ffad06@kernel.org>
In-Reply-To: <4d1c3eb1-5c42-490f-83e5-60de05ffad06@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Mar 2025 11:57:05 +0200
X-Gm-Features: AQ5f1Jqlx7t3_cSR4R8CS335M--auL7SEwcqufZDylqnzlIg_zB0GKJZ2cFtMKg
Message-ID: <CAPVz0n2rxpk=KrsC2GOkBD=WZQSdVbd0tOYgow4miPz+3owsCA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 12 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:49 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 12/03/2025 07:02, Svyatoslav Ryhel wrote:
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  monitored-battery: true
> >>> +
> >>> +  maxim,usb-connector:
> >>
> >> Just 'connector', so when we have a 3rd case, we don't have a 3rd
> >> vendor.
> >>
> >
> > Please, please be explicit and specific, you could not tell me this in
>
> git grep -C 3 connector:
>
> > v3, you could but you decided to fuck up v4 as well. So wise.
>
> We got a lot to review thus we make reviews concise. I understand that
> it might lead to insufficient guidance, so more help in removing
> workload from maintainers is always appreciated.
>
> Instead of using vulgar words towards us, please put a bit more effort
> and look at other recent bindings how they do it.
>
> Review is provided in good faith and if it is by any chance incorrect,
> it is enough to disagree instead of throwing things like above. That's
> not acceptable.
>
> > Additionally, if you want a generic 'connector' which can be
> > referenced as 'connector: true' then add one, ATM this is classified
> > under your own terms as 'vendor property' and needs a vendor prefix.
>
> richtek,usb-connector is not the good example here. Your previous code he=
re:

Then what is a good example? This is the only example with binding Rob
requested,

> https://lore.kernel.org/all/20250225090014.59067-2-clamor95@gmail.com/
>
> looks correct - you have there port. So where does charger_input point?
>

It pointed to the port I have removed because Rob in v3 said it was
overkill and connector phandle was enough. May you resolve this inside
and not to contradict one another. Thank you.

>
> >
> >>> +    description:
> >>> +      Phandle to a USB connector according to usb-connector.yaml. Th=
e connector
> >>> +      should be a child of the extcon device.
> >>
> >> 'extcon' is a Linuxism. Is there an actual requirement here that's not
> >> *current* Linux requirements (which could change)? I assume the
> >> requirement is to have vbus or some supply?
> >>
> >
> > Pardon me, this schema is part of Linux kernel, no? I have no clue why
>
> Bindings are used by other projects as well and they live here because
> of possibility of review by skilled people and due to size of the
> community. It does not make them, in general, Linux specific.
>
> > you collectively decided to just ignore external connector detection
> > devices. Ignorance does not affect the fact that such devices exist.
>
> We didn't. They are described.
>
> >
> > And no, it does not need vbus not supply, it needs EXTCON
>
> There is no such thing as "extcon" from hardware point of view. Point us
> to any standard or even wikipedia article describing it.
>
>
> Best regards,
> Krzysztof

