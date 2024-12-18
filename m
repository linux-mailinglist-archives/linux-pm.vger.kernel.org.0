Return-Path: <linux-pm+bounces-19424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF249F64D2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 12:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D4318839A9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40919D891;
	Wed, 18 Dec 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFOnld0f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022911F931;
	Wed, 18 Dec 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521144; cv=none; b=EjyEkGrrXWJd5rVf8Uypy9UTkJ7dVE0hSDIoHOh0rZVdkEpuaFOK/9FDrcmJIKHBqYi2x7MbxfCRQMjmxCgq07he5bTppCY/wNXvrZAThFEChyHdQLHP8tf5qkiI0mSOOuOfteeLM+LEo6EtYvReK74H83xaK2f+lqA1A3wyFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521144; c=relaxed/simple;
	bh=UslFVnAXYTNmYba4GmZIVfm/Vw3mM195bpmKAqG3o7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2dOFNppXMF7ZWdB2D6qA0vAP2gO7cngxCwDJ7/8ez5AT+uV22TYQdUhNfztu6puSZadrc4spb2AkR/hvDtIgb7CQE+M7l4BKJIuJWLrD0WOPL51sCDiT03jhbdejFP6+C2ixnB/H8rNT+jh7kNnyX8EucS8ZGeNaF7ODYnO+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFOnld0f; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85ba92b3acfso2787195241.1;
        Wed, 18 Dec 2024 03:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734521142; x=1735125942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7u6v8jjnFSq06Hoi63m+bpSt3SS1bJxGP2Hu10qTWg=;
        b=eFOnld0f2sAsHmgHfC26DoDTI/yOfjPDt4aK167gFF3D5DIP/6vHBdjibUqSu3PJHH
         LdelqGH4JIUPegJiEf0lDjPuPsllrvmj3QBk0qowTH+dSRhV1TiaSY49IdNmltzoztWH
         jwswe8rgfaV7XyyRspquNGyZI65W3K6ytAM9S8iPQAvNT90Bz9++Mirj9Hr5RY7nPWUm
         KxsQeaNfcUnBI79bIBzvUH/EyZHIsyldLNYhlOPZ63B2SGEra2gOJTjoa0vIwl6284Ql
         nz4OtD+L/6vaWQZcuw5r982xwE6yNiyZGWS8PQJ+1O30yXcMCokAMAQz/D1fFqa4TelB
         Vnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734521142; x=1735125942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7u6v8jjnFSq06Hoi63m+bpSt3SS1bJxGP2Hu10qTWg=;
        b=Wir97j48Fr24m39rJlEMcbYDXNdHCOtwBAcmnar5xp2kQ19KG18ufW90Snbzu+M8U+
         vG4dGqBHl4V+NXOtcIhitKE+zkVX9uK88g6/HjeLoSFwMl/pA54zwENmcaL7HBS/4MH9
         0ld5lVIzCwWgMoX93xBxMom1KmEGquNr0tF7QRXegVffT0sYhWTncEfs2U9gGMJrkdI/
         3rX6PYXY4jYfDdEdB95GW9rwRwnCz5OJ8kaGom2m0FtPivDrRyDG/RH57Ivoi0JUWm80
         bsqJ3XylqBy1oVEZ9PRfHrS+CxNcggXQg0AK2R8r1ybjxf9fZRcVPIfqYdvOzDXFcvar
         Hxrw==
X-Forwarded-Encrypted: i=1; AJvYcCU07zvLmTCNZptoiKMeuXcPFxwjN5r3YcqxiWr8ievGlSfaeYKvbQdvTx/g3pPDDqwcRRDIMhF0lHI9NQ==@vger.kernel.org, AJvYcCU9v0R4DgdaMoa9v4lNwYdIT5aJkugXszvJvuSb2+54KCqLmlMpAqVcQ49OP6Qf9TFpRZILzOJxju6iuGyn@vger.kernel.org, AJvYcCUSZpeSCvqZeq+Cs2xKSSt1zLhlarwcqG73J9T8CCZwdz5VqyS0iFFCeATcy8NT6ZOHxpvEk/JnojvwVuk=@vger.kernel.org, AJvYcCW1xx3n/XVmRkFNMnSNepj6BrWvjviqNbqP3QrxDWmFKQyHHhr2CYMaSyDp1pBxRlwHBJYLVodRRWWp@vger.kernel.org, AJvYcCXBgA7QA6V87ml9JgXULNdsjaUKeNCW9lR6Ml+eLPA4EuxeeG3hK6BVSFnOTLzSOseQnzGPlGHcT/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YJm4dcSaDHgfbBnPLFboIiJy7Bq4rsZRTKSF/FTfyVpEof18
	DPKHVVg9LOI+vBbGsOgyUG8Xi7xUoct3tnMA9Xh9MZXxHGiDBjs5RcmzW1GW0pRrKWkRvgSv5HQ
	h/P3nkNqlheFmwmAh88Sj3/VhVVU=
X-Gm-Gg: ASbGnctwZZTw2Jxxsu/azOLebkm7iE0sllLrE0/PexMFKTmjORifQb8wVHQ4ykkNkfK
	jsb11MuevrgiHyTO96NmXDSoQU0Z0Z/4+c2j+
X-Google-Smtp-Source: AGHT+IFxPPO8fZNjKeble7gWv/BLUtUUuRcuafyOUoO4UxcYC7hAY8TAjLwTyAKAea36XjgGJ6feWcBfEUYn0S34Puw=
X-Received: by 2002:a05:6102:c0a:b0:4b0:a67c:5817 with SMTP id
 ada2fe7eead31-4b2ae711c43mr1539235137.5.1734521141796; Wed, 18 Dec 2024
 03:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
 <20241217-starqltechn_integration_upstream-v12-2-ed840944f948@gmail.com> <vunx3s4wqw5fqtwuuuuofjtja7buh5zpxi3iznzgfl4iz7fm4d@wlxbzrnlu7fr>
In-Reply-To: <vunx3s4wqw5fqtwuuuuofjtja7buh5zpxi3iznzgfl4iz7fm4d@wlxbzrnlu7fr>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 18 Dec 2024 14:25:31 +0300
Message-ID: <CABTCjFBO6RYwf5GiExPFEyBAfCF7vUnbYFRePdSVPdXNfwZwrA@mail.gmail.com>
Subject: Re: [PATCH v12 02/11] dt-bindings: power: supply: max17042: split on
 2 files
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 18 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 11:28, Krz=
ysztof Kozlowski <krzk@kernel.org>:
>
> On Tue, Dec 17, 2024 at 08:30:00PM +0300, Dzmitry Sankouski wrote:
> > Move max17042 common binding part to separate file, to
> > reuse it for MFDs with platform driver version.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> >
> > Changes on v12:
>
> Malformed patch.
>
> > - add addtionalProperties: true on common file
> > - rename *-base file to *-common
> > - remove compatibles from shared shema
> > - move required properties to final schema
> > - remove max77705 compatible from binding - it will be used in
> >   mfd77705 binding
>
> Sorry, all this is somehow complicated effort of not calling the fuel
> gauge what it really is: separate device with its own I2C address, just
> like all previous designs in that family from Maxim.
>
> I keep repeating this and you keep going that way, maybe because it fits
> your drivers, but that's not the way.
>
> Best regards,
> Krzysztof

Fuel gauge ICs designed to sit between battery and charger, or even in the
battery pack itself, with a goal to track and protect the battery.
Given powering diagram:

----------              ---------      ------------      --------------
|usb port|<--[input]--> |charger| <--> |fuel gauge| <--> |battery pack|
----------              ---------      ------------      --------------
                            |
                            |
                            |---> [system bus]

There's no fuel gauge ICs with input and system bus measurements on the mar=
ket.

This device indeed has its own I2C address, but that's not enough to
say it should be
a separate device, because we have MFD's with its goal to share
resources like a single
i2c address for devices with separate functions.

To me it's more like Maxim put its fuel gauge together with some hwmon
solution on the
single i2c client logic.

--=20
Best regards and thanks for review,
Dzmitry

