Return-Path: <linux-pm+bounces-19435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E871B9F6D35
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368ED169904
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A431FA831;
	Wed, 18 Dec 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czwgqNCE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0043597C;
	Wed, 18 Dec 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546286; cv=none; b=erLAdNKpcwBFhTllAdg7rvF7TRk8tg3nvcmIuHdOtqVvEjWPava3zLDSRgPhI35qf5MgfiIu863nFQ5o8Ki35YiRZRJuYaqw3zAPVzc88KKhCCmlsmAZVhpayU5MeEwfenkfjH372BX8RwFdTBbDwKfFOK7qUJCxvHJ2yCDA9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546286; c=relaxed/simple;
	bh=3XiLF1Wf+pk+itwpr2VAHqM0hK4GGkizwkWAckNZb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krTnwjLmTKILbOkhAQoj/NSrz7YV2VCo7PLYrAAW+PRHfntlfXIx1cwgqHw7VWIcwyfNnqbRhJJDpzfENa62kDplrqsMhHocE+FfulkrmxAEdydfK24+xqBW8hN1CcZgGbPHU1zNHc1dWPuxvBm5PZJ/JkGJuvdciXANcRATQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czwgqNCE; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4afeb79b52fso1908324137.0;
        Wed, 18 Dec 2024 10:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546283; x=1735151083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E700w9QuffQfIy0SrxiIOo8P0TGVoGXhxkdZEo5QdQI=;
        b=czwgqNCEf/FVfafEQpU0q3LnnWb8zY4z9gMC1qRAuQNyDdHnHtLT3QDx3QcywI8slI
         JwqDp45u5LgtPg8stdlXthCuQo0CCHZndF4WTcFClb7UeRI5pX33JAJ2xyRHix6KUNpS
         rSnyxFcWGmZoUFpJ2yhzy6XReKHS1By08MTjbk8vJWm5or34yiGPbsTsVx/Z21nGE9mL
         /7oVtQd1zNUmIQXgr+Jb2Tkcv+/bIW44Z6qpoH1kY7coMMGwo9R8fFWK3c2XH7H+kKrk
         mYITXMsF5Lhh7b0jipfUZr7VjFTMGJtkpRPd6h/opi9VJFMrYiKhQZZOOWNGH9k5KZhJ
         XOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546283; x=1735151083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E700w9QuffQfIy0SrxiIOo8P0TGVoGXhxkdZEo5QdQI=;
        b=lKqSXetb0gDvYLwmhSE9myNuXUjM8ITCs0kJe54/ETVHfAYH3UC3YcgOMs+NKqWNQz
         N0bect4ltJjC+bizbqoNq+juotvxQVGyAnkJj+UfhyhwBqGBHTj08hUokLrbD8yxliX9
         /YtocuVt8Am+Tv4XAK3H64LmdHI5wFMce8EcumfO15Nsyzjy/+ZrU+SYS/q5HfezPwew
         fPLWUTGM26aCeTouQ+Uv3tS3WZ7UNSmMtcQFfiWXAuqZIMJ4QAjvZix+4CCf7bNrOjYG
         bew5wCd2/4FgVRWqGwA94YZS+nAElSKw7OON5C6nyozuwKdhsAOFmBDSqpQ99TO3pJuo
         jpZg==
X-Forwarded-Encrypted: i=1; AJvYcCVOPf+q9HcMlo64Ma/+EPsvjduojw9WVMin9gt/0DkV0MfLcIKZt4K+OfcSprDFe/NYOiOBOFo9lrU=@vger.kernel.org, AJvYcCXB7LqbKW25quJC5dXdG7bpIPDGMs/odfSH4fM/6aTcGWNDSPdIc3hWrVp8Pe8YQN0bj3E2QWgNwBzB@vger.kernel.org, AJvYcCXTb78sBbKJRVYyAwPXdFPpIFQCl+YY54q05dYERkkRIsY+toE3TydSohV1I5u6fNUhelPKhVAPY/R1ZfI=@vger.kernel.org, AJvYcCXhg+GiPZHRc9/fNKxIEtYbmKb5SCCEoGsRTKVW1xHf6tMJrexyoEOI3BPxvDFo5xhPYdcvo8gVwlFESg==@vger.kernel.org, AJvYcCXoxGekYGuzJ3nDnp+VWk7ULg0vHWapPzt16mkJJa6xrFT7E5/GxN25/dtGoN30LCQRIOPZo44yDCZNMq46@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxGSFYuMiHdIDT4/iuf6LMRuict2ElFoEPYPKxFgkkah4vL09
	yu3yPh5USOyDWzZrpG0FJ/KhModQx1IKFWtKrakqzJmkc8vzYspyTUY0Scqxix0J85jbkz81HYg
	YtMD4yDDB5jPnnX3FNyLYbwMVIUY=
X-Gm-Gg: ASbGncskfp0zWghE+TBJj+/AVYz5SQRTQioZe6TY6x4PeaC1KFFMGFkApYvfxx7WETm
	LdAeFxnvRJwS3Bhr4z0XsaRJjcUXuieSdwP4s
X-Google-Smtp-Source: AGHT+IEWseURIL7DnIOmJjE4mPvK+8SSRYUDTmrHrrfemRfNvar05kmLHNZ5hGEiXCCqG+/v10kkV9suRecozL8LHQ8=
X-Received: by 2002:a05:6102:508a:b0:4af:eccf:e3ca with SMTP id
 ada2fe7eead31-4b2bbdc46b8mr635155137.10.1734546283475; Wed, 18 Dec 2024
 10:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
 <20241217-starqltechn_integration_upstream-v12-2-ed840944f948@gmail.com>
 <vunx3s4wqw5fqtwuuuuofjtja7buh5zpxi3iznzgfl4iz7fm4d@wlxbzrnlu7fr>
 <CABTCjFBO6RYwf5GiExPFEyBAfCF7vUnbYFRePdSVPdXNfwZwrA@mail.gmail.com> <igvefqqns4k2tbau56nvu6uorhvr4k4j4hiv5asgohviydvlbg@6c2zhgcgdkth>
In-Reply-To: <igvefqqns4k2tbau56nvu6uorhvr4k4j4hiv5asgohviydvlbg@6c2zhgcgdkth>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 18 Dec 2024 21:24:32 +0300
Message-ID: <CABTCjFBv7shGvXZPKTdk0XJzOUcD8W195ZNQVGjZrMMsVNNZRA@mail.gmail.com>
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

=D1=81=D1=80, 18 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 14:34, Krz=
ysztof Kozlowski <krzk@kernel.org>:
>
> On Wed, Dec 18, 2024 at 02:25:31PM +0300, Dzmitry Sankouski wrote:
> > =D1=81=D1=80, 18 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 11:28,=
 Krzysztof Kozlowski <krzk@kernel.org>:
> > >
> > > On Tue, Dec 17, 2024 at 08:30:00PM +0300, Dzmitry Sankouski wrote:
> > > > Move max17042 common binding part to separate file, to
> > > > reuse it for MFDs with platform driver version.
> > > >
> > > > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > > >
> > > > Changes on v12:
> > >
> > > Malformed patch.
> > >
> > > > - add addtionalProperties: true on common file
> > > > - rename *-base file to *-common
> > > > - remove compatibles from shared shema
> > > > - move required properties to final schema
> > > > - remove max77705 compatible from binding - it will be used in
> > > >   mfd77705 binding
> > >
> > > Sorry, all this is somehow complicated effort of not calling the fuel
> > > gauge what it really is: separate device with its own I2C address, ju=
st
> > > like all previous designs in that family from Maxim.
> > >
> > > I keep repeating this and you keep going that way, maybe because it f=
its
> > > your drivers, but that's not the way.
> > >
> > > Best regards,
> > > Krzysztof
> >
> > Fuel gauge ICs designed to sit between battery and charger, or even in =
the
> > battery pack itself, with a goal to track and protect the battery.
> > Given powering diagram:
> >
> > ----------              ---------      ------------      --------------
> > |usb port|<--[input]--> |charger| <--> |fuel gauge| <--> |battery pack|
> > ----------              ---------      ------------      --------------
> >                             |
> >                             |
> >                             |---> [system bus]
> >
> > There's no fuel gauge ICs with input and system bus measurements on the=
 market.
>
> OK, good point, assuming that this is the input not for example the
> charge on battery. But even if the diagram is correct, we represent here
> programming model exposed by device, not physical components of entire
> PMIC. Therefore you could have more components there yet still it is
> one device: fuel gauge with its I2C addres.
>
>
> >
> > This device indeed has its own I2C address, but that's not enough to
> > say it should be
> > a separate device, because we have MFD's with its goal to share
> > resources like a single
>
> There is no such thing as "MFD" device in terms of hardware. MFD is a
> Linux construct.
>
> > i2c address for devices with separate functions.
>
> >
> > To me it's more like Maxim put its fuel gauge together with some hwmon
> > solution on the
> > single i2c client logic.
>
> Which still makes it one device, unless you are capable of re-using this
> other sensor-part on its own or in other devices.

I think I get it. There's no need for an MFD device node, because it's
just empty.
So in the device tree we'll only have a max17042 fuel gauge node. It'll get
matched with simple-mfd-i2c driver, which will create 2 sub devices -
fuel gauge and hwmon. Fuel gauge platform driver version will
get matched by platform id, and will take of_node from pdev dev parent
for setup.

Is that what you are thinking of?

--=20
Best regards and thanks for review,
Dzmitry

