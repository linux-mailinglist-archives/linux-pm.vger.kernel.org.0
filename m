Return-Path: <linux-pm+bounces-23046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766CA47AD7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6170116D265
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C94222A4D5;
	Thu, 27 Feb 2025 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OikCg0M0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA522839A;
	Thu, 27 Feb 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653749; cv=none; b=nxafIUsd80v5B856Q9WMMHQHvPslf5hBQH2XUjZ8/JNVfen5WFr8AZ+rIisIc8AcCod9NMxlaC8gY2Sltw/OSaxHmKpg8Ucl1VDmpy1xMp5q5AKbUYVxEYLI8zNOjUFTHXdMRU1IH0zEsIMxQnJdtJ6LuTlUX+7V4YBVPR/Uw0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653749; c=relaxed/simple;
	bh=bujcDTjDuNoNm0eQaVr1K6IxX1QIkdithn2Pa9n1gzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FR3tgl02gZEeb/monF2vs/Wg2OuxcfnOqkK7yNN0hEjn/WhziRxIGc2HXHNOIInaEg/bI8bI/QkXYK7+I9QrKFIbBp3aw+A1a9HrGN80nMz27TUNYxd4zrSp7l2QsKMbG22MgVA3PZcSmXjbT9x3lDJ5ezNr2ER08oDEI/pOZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OikCg0M0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so5086785e9.2;
        Thu, 27 Feb 2025 02:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740653744; x=1741258544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKHlnE2Y0JEmifPa1wLht7Bfh/WgS8pXlFyMCfBvkuI=;
        b=OikCg0M0mYOxL7rkRgVCX+ye0qGYZdYO9GacuZop/EgYmYdCW4NOgnaQ717SAsNSCa
         RHID9vIC927rIM8ArAKhtw67O4ZefX5bXD4iUYRmlofkf2sGh7eWmo14hals1/qAWJ5r
         fu/Vr8BrsO1UsYQPYSkd2UhTg9pa1vDZMvyzzC8PgRjBm68DN5xsAdoSJJA/j9pgL6J8
         PMdpd+bJPNsblTgysELGaFTZyWi3Tvrq7Egq093XBrloLuPqjB+FYFom5EGw/kjqxSZk
         X13UFcWHZaOb+qy0AOOG/C0TKhhGrZP4GaU0+HVAfmfdRaF7iS0DXdFKtyUnfAqQQXjd
         1WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653744; x=1741258544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKHlnE2Y0JEmifPa1wLht7Bfh/WgS8pXlFyMCfBvkuI=;
        b=QFpBZsTidq4RkoPlzhI6V5FSYL/ewtFqLzNsb1iL21Tv0CBFGXERLal6hifHHvePle
         a23yUuZ83OE6HYmkByZMgSfnuHQ/qFQJ7UI243c5EgqZXG1btkDrZPCFnYgE6DUTLOhm
         nTpei3I44+I/VjzUmIgZ2d+45PoFqUh+zE2pCz7QsXRaRlS6dD2PSUzVgk6/vECgk7DN
         5V/Bg0HfGcRSHTwSCje8/Jli2Afj9CbTiNQXrcAMamoWWxN2kkanyrg/tBT9aLG6lJjY
         MpCKw4ZR1pULxtfknL8mq5DfyhL8y3MfGiCTLMmQOuAq0S9NYkaHI/IHiP9bF8BxOGHy
         JbBw==
X-Forwarded-Encrypted: i=1; AJvYcCV/5C/RGQSXppJOV9RhKa9eu718wcd5zG3x2uKs/0udmq7uaLmoJBt5OeUE0YRSl4usHWEi4Qi4hMk=@vger.kernel.org, AJvYcCVnyV3sIPT1fMEQRbv0TdFkfJUu4DaXWonVngh/CFbyjeFOtmSNCltgrZgm/Yrn4Xa7C7dVPnPwg5P1OzQh@vger.kernel.org, AJvYcCWyVoWG66qEPKsW2TFRV+A8SbfbLJnssaoy+i9zE88dg0mcLvfbn47x1M66D2AjFpUz1sE4/aJpRWNn@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOPCDLfNwr6VSbgRhOQR8eW1HxdftPedJ4AZbGKxvOWKLgG+q
	QopC/h02klSo4aH7Kr/YyKgNf9tMDvbkNrPlQCwW+cM4KlZ2ilEECBAconUeS9hhz4MlaZvCIe5
	TNGhw3Yel2ENYqvKfb93iVGvwJvIfP7m4
X-Gm-Gg: ASbGnctdzQEy+/YfJ/sfWoPk1PRQobdymfF8cZwrkNkcnMyu5RVQRkrM1FUZ1k16AH4
	JKY2Yk/ckxmI7QnnK8OcpOMpcjdSiAvaPFSL37s/NPUeh6SQ+7VBSVP9yWQt4NPfswSW4m1HeE4
	uWktt1w3pq
X-Google-Smtp-Source: AGHT+IHncl9PPc5r6yl0Lv/rKdriH90hESG8/kfSD1bpGd1N2IZOKBThPFywTVAV/1AmDlyV3Kd8xNhZaexKbVPqAbg=
X-Received: by 2002:a05:600c:3150:b0:439:955d:7adb with SMTP id
 5b1f17b1804b1-439ae222a7amr256138625e9.30.1740653743598; Thu, 27 Feb 2025
 02:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226093700.44726-1-clamor95@gmail.com> <20250226093700.44726-2-clamor95@gmail.com>
 <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
In-Reply-To: <20250227-cherubic-mantis-from-betelgeuse-86f5ff@krzk-bin>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 27 Feb 2025 12:55:32 +0200
X-Gm-Features: AQ5f1JpNBw7exSIzTK2Fu0RwPSOnttGQs3PoxMmfrYBIGnMEtbjoE5q05f9ovHc
Message-ID: <CAPVz0n0ygR=ygsvG2+z-zST7kmJ_P3nxf29tqdgHpRs_Nw6D5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 27 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 12:45 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 26, 2025 at 11:36:59AM +0200, Svyatoslav Ryhel wrote:
> > +  maxim,fcharge-current-limit-microamp:
> > +    description:
> > +      Fast-Charge current limit
> > +    minimum: 250000
> > +    default: 500000
> > +    maximum: 1550000
> > +
> > +  maxim,fcharge-timer-hours:
> > +    description:
> > +      Fast-Charge timer in hours. Setting this value 3 and lower or 11=
 and higher
> > +      will disable Fast-Charge timer.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 5
>
> You still did not answer why this is board specific. This was rejected
> in the past because of that reason and nothing here changed. Nothing
> will change without detailed explanation, so use other interfaces if you
> need user-space to configure it (see other drivers, e.g. maxim)
>
> > +
> > +  maxim,fcharge-rst-threshold-high:
> > +    description:
> > +      Set Fast-Charge reset threshold to -100 mV
> > +    type: boolean
> > +
> > +  maxim,in-current-limit-microamp:
> > +    description:
> > +      Input current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
> > +
> > +  maxim,topoff-timer-minutes:
> > +    description:
> > +      Top-Off timer minutes
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 10, 20, 30, 40, 50, 60, 70]
> > +    default: 30
>
> Same.
>
> > +
> > +  maxim,topoff-current-threshold-microamp:
> > +    description:
> > +      Top-Off current threshold
> > +    enum: [50000, 100000, 150000, 200000]
> > +    default: 50000
> > +
> > +  maxim,fcharge-usb-current-limit-microamp:
> > +    description:
> > +      Fast-Charge USB current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
> > +
> > +  maxim,fcharge-ac-current-limit-microamp:
> > +    description:
> > +      Fast-Charge AC current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
> > +
> > +  maxim,usb-in-current-limit-microamp:
> > +    description:
> > +      USB Input current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
> > +
> > +  maxim,ac-in-current-limit-microamp:
> > +    description:
> > +      AC Input current limit
> > +    minimum: 100000
> > +    default: 500000
> > +    maximum: 1500000
>
> Half of these properties as well are not suitable and duplicate existing
> sysfs interface.
>

All these properties allow configure the charger to suit the device on
which it is used. None of them are required but are a nice addition.
Why you are denying me an ability to fully utilize hardware I have and
tune it to the device? All those values represent hardware registers
which can be customized for the device, not for the end user to mess
with.

> And for remaining, still no battery.
>

reference to power-supply IS included, hence the battery option is
there as well.

> Best regards,
> Krzysztof
>

