Return-Path: <linux-pm+bounces-19182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6661A9F096B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 11:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7489E16530F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205B1B87CA;
	Fri, 13 Dec 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpRcZmyr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BA1AF0BA;
	Fri, 13 Dec 2024 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085710; cv=none; b=XXfWhyMtcUltnyV/S/BqdHHImCqUQrK5/inFSZ8hEF8bLV/+sOeI41a3VOAfJ4mxaZMStrKBCmcnfJwa5/j86QlpiqIgT9X8LJnc7yMryhmO7SIyHs5LYcj3IehXJojxCljq3T4crFP0u1oGZJm6DOokrbIIIrRWcWMEyRoaSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085710; c=relaxed/simple;
	bh=XsrY83B2NDr3SjOMmv0QjTOwRJyParKulTQwwFd1QK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aozxqN+JAnREyRF4/GBfACEKOhjfvh53vLyKjeem9GbwvjQT+eS2Ryoc2RRpv8Axb0Ltm2OkKUESA6QBnL5V+W7CVDNFzmtaWb0JWhCo4k6Ag6DQ4GhCEx20AYr7iBsXOiD2AaMZ/f0zEy0bUKxuIe9J8sib30KlOucA7IxbHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpRcZmyr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so2792571a12.1;
        Fri, 13 Dec 2024 02:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734085707; x=1734690507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pB3X14PXp5zWzZdZYfYtvpoLg+Uk1L/28oXElwNGNQM=;
        b=fpRcZmyrr0BomZrWzlAIZwRzpi/KRANbQy6ZqepwQinyxGwxb2ddc3yuWpnanpodZn
         yVF9EsLQDYEIlcdXTgAcw90oqEiohiu/n9jDZqhU5iGmMqWakHgtTBET898+M44RyNQB
         E3eSl0Yhsc2m2y+R5WSNez3oRiPnswCUuT7o7NoRJKUfKurpBRl8Hb1xxuCmBMnr0rZh
         iRc7v7N+c27Z/3ttuBP5/eyWQZ5JwMRA0lDpFipuhmv5UZIvaI7PnOSA92B/3WXA/IRS
         UrjX2Wc2GQEWIN6tsFbjYU5/ZllcwgD1mWfd+jUKrUq/3PhZs/0B+IWS+9veDM+BxYuq
         ctuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734085707; x=1734690507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pB3X14PXp5zWzZdZYfYtvpoLg+Uk1L/28oXElwNGNQM=;
        b=L+kTnEEXeGf0fZLrn+nmnp+VVRmwYTlHbOLtY+VAyI9yAdgSckfnKqxYttQU7XC18e
         F9xYIj/2zSkm9Wplc3M4MIycBwAn8bziHfHjn2RFKqDF5YzZC1BkK/cnKpWfweLO6boU
         oV8c53EOVHiJznJTEsjGzPFQfrKwbB+Y1+4xCU5/RZDzfXI/5QDJVpxeDgXx9p9h8Rwm
         TvTRiiujBJlzN+u00ynwZeAN4kYHtYAv+Zm93n32oOf9foZx3TYMMS+3XWbi6NQCBbOs
         SSGe6mR+IYiKpReLZF03IKe3KZJuqfOf0/pH8NvS2Zco/6P9ajk+ygUDYA2QANl9EWv+
         4Wxw==
X-Forwarded-Encrypted: i=1; AJvYcCV2lfXUwAM7Kiua+FUdnYYRxJTXpEtnfCiBjuMHS8ZDIbdUh1WTE2i6gjXH74ZVTBNuCTRnFRexi1WqPz9o@vger.kernel.org, AJvYcCV7UnCA5ra9B/gjVD57cY52kOnbdBTIOX3e7whRM/Zrz5xpnVpFwwkVwtat+EKwMoJ96+irRLb7NO1m@vger.kernel.org, AJvYcCXwQSlNl9Kr60D36A8T68AprNCUXP8Diy9PeTgnbK+eYwyUC+jH7vsmd5mJSg82ccjLMoZDcK+ozq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/mM7/FUwwT0szswGv4AQD15euk4BFLN0uof+LO2DBJNZdG0f
	mGM83DGFvI/4eMRFbmFgR4tX/F3A5s4m67HEeS74bDOUursj8Mml
X-Gm-Gg: ASbGncvQPcGkwILqDV81z1mIaTLMWx4k60fW3xwarEgUyUrOZx/YZm16xBP7z7kLICX
	Nz4yN7hMfolm9Des0aWjQS04c0judt+OF+v/QkVyslNXOA+HRhVtcSpaerxld6FdJQGU3MA5zI7
	tpnufavdJrtAYbAZ6kBk7oDfGyFofd7TRkOnaKmgXjjcOuDEgrcHq3r+qojZj4OaAn1HTXOFlKi
	E6rIvXGzioADYLKESWAaVDGNN8AYy+A2vIZFCy1fq9w0TmyOR8tQsk1Tt0Eojb9Js7ZR0K+cC4k
	g1As7866BWLqLrq2NywertU43VmnyoQzymm/KL41vPr76JBUz9qL7Q==
X-Google-Smtp-Source: AGHT+IFZxQE+krq/M7jh1dybVLmfsf1m5lOU0V/p6tDh7RuYI2DGId9Qv0f5pkVlUGjsOIut2AxuSg==
X-Received: by 2002:a05:6402:5292:b0:5d3:ce7f:abe4 with SMTP id 4fb4d7f45d1cf-5d63c3ac7a8mr1613831a12.25.1734085707300;
        Fri, 13 Dec 2024 02:28:27 -0800 (PST)
Received: from stefan.beckhoff.com (dyndsl-082-149-178-025.ewe-ip-backbone.de. [82.149.178.25])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d3eb109bc9sm7957184a12.42.2024.12.13.02.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:28:26 -0800 (PST)
From: Stefan Raufhake <raufhakestefan@gmail.com>
To: krzk@kernel.org
Cc: sre@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s.raufhake@beckhoff.com,
	s.dirkwinkel@beckhoff.com,
	s.raufhake@beckhoff.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 1/1] power: supply: gpio-charger: Support to disable charger
Date: Fri, 13 Dec 2024 10:28:25 +0000
Message-Id: <20241213102825.5509-1-raufhakestefan@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4tvn5k6zbsbyc2n3r2jnkrasyfhzfua4cap6ql65yjfmwzu3xw@lx6jmqvzypqv>
References: <4tvn5k6zbsbyc2n3r2jnkrasyfhzfua4cap6ql65yjfmwzu3xw@lx6jmqvzypqv>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hallo Krzysztof,

>
> On Tue, Dec 10, 2024 at 09:23:43AM +0000, Stefan Raufhake wrote:
> > From: Stefan Raufhake <s.raufhake@beckhoff.de>
> >
> > Some GPIO-controlled power supplies can be turned off (charging disabled).
> > Support changing the charging state by setting charge_type to
> > POWER_SUPPLY_CHARGE_TYPE_STANDARD and disabling charging by setting
> > charge_type to POWER_SUPPLY_CHARGE_TYPE_NONE. One potential use case for
> > this is disabling battery backup on a UPS.
> >
> > Signed-off-by: Stefan Raufhake <s.raufhake@beckhoff.de>
> > ---
> >  .../bindings/power/supply/gpio-charger.yaml   |  6 +++
> >  drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> >
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
> </form letter>

Sorry, it seems I made a mistake during the patch review process. 
Should I reply to your email about version 1 of the patch or only about
version 2? I don't want to make another mistake and open two discussions 
at the same time. 
I hope to do better in the future.

>
> > diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > index 89f8e2bcb2d7..084520bfc040 100644
> > --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> > @@ -44,6 +44,10 @@ properties:
> >      maxItems: 32
> >      description: GPIOs used for current limiting
> >
> > +  enable-gpios:
> > +    maxItems: 1
> > +    description: GPIO is used to enable/disable the charger
> > +
>
> You did not respond to my comments, nothing improved. Without
> explanation based on hardware - which I asked - this is still a no.
>
> Implement and respond fully to previous feedback.
>
> Best regards,
> Krzysztof
>


Sorry, I'm new to this and don't really know what exactly you want for the
hardware description and how best to represent our hardware in dts.
For the gpio power supply, it can basically be any circuit that implements
a "fully charged" GPIO and a "disable ups" GPIO.

We're using a circuit built around the LTC3350 (super capacitor ups chip):
We use this pin to indicate that our UPS is fully charged (once the input
is gone, it's not fully charged anymore):
PFO (pin 38): Power-Fail Status Output. This open-drain output is pulled
low when a power failure has occurred.
 
For the "disable ups" GPIO, we have some external circuitry around the 
LTC3350. I can't share the schematic, but it boils down to "disable usage
of ups" so that the device shuts down immediately when power is lost.
 
We've implemented this in many of our devices, but first we're looking 
at [1] and [2], which we also want to upstream the device trees for.
[1] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9240-arm-r-cortex-r-a53/cx9240.html
[2] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-r-cortex-r-a53/cx8200.html

For the LTC3350, there is a separate driver posted to the Linux kernel
mail list [3] by another devolper that we would like to use in the future,
but without this gpio, our circuit won't work.
[3] https://lore.kernel.org/all/?q=power%3A+supply%3A+ltc3350-charger

Best regards, 

Stefan 

