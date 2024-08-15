Return-Path: <linux-pm+bounces-12274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B7953AF8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 21:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694551C228A8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 19:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39DA13A884;
	Thu, 15 Aug 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fib1ygNd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5112C49B
	for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750670; cv=none; b=drdd2h388WILaXLeFzoj6qdhqhvEsWo6vK8hPAGInA0X40seEXp7OzD5r1mn2CUP1YIjdbcCu7SvOOxeoVrE0CWApm1dVQY4Du3/1AvAAMsF8NNX4v6sh/vwWxwBl/QT4gioqxZqYIiR1bXKd8+HVfG45IN272NsmiWg4IIaBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750670; c=relaxed/simple;
	bh=WgHv8qIghW/XGbfA3/inME7zpGlhOrWspJ9Qn/7HUik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARpP657pGg9ilpEkCy4T9bGJr5OX77CyJUvDAHUjykFgYcP2KLfTZwYQbPzCC4qC75ORWZHVrKaOSqAqUAkuc7pi7cBpRar3fwL3WS79EqdbeFjaKkamqXcpuYUqz/IroALbt5chMw5FcoHmv5CgsGNGC2GH5R2t73YMs11eO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fib1ygNd; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e04196b7603so1450962276.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723750665; x=1724355465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgHv8qIghW/XGbfA3/inME7zpGlhOrWspJ9Qn/7HUik=;
        b=fib1ygNdcNlcqyE5/pxU4VIXOa73igsPtMb3IIToqzOOP8JnStjihDo4emoI6MsQCl
         e0AKJx8j02nSf9rniJyLcCLy2WEr+FMu57hCwTbRcB0nojxEbIl5VL4F4AfSh10tuTUK
         qdYx2yc24dEa1jFRfhUCNsqdu12cXtfqmINow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750665; x=1724355465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgHv8qIghW/XGbfA3/inME7zpGlhOrWspJ9Qn/7HUik=;
        b=eSLBj7+dSreRdYQeMCnXtd+l5unZ8jwjVn0c+jWgzoC1BWETZa/SsOW4vI+2tDbVzS
         iQ6wB6YJtv/8Nn5d1rvignkeWSluZKR5HMGDYglTkBFABGPwIlU0GD6Y6ZnEo1DMy5CR
         BMB6Ba1ZUVWJjhoV4pNTRZH7Xq+v85dmzXR3PH+l8Gh7RwyxvzBCFnR0nDIzOHNRy2Cx
         9NnC9hhYREjBgrDJu2d8DpXB4ZWuYxRtNhy9bSGT41Aa+C/MuDcLHlV1K4q/fjt+N9hR
         AMSjAFn8l6OQaadi7u9xQkuC+9CDxs+nLN5PK2sdHVywZYsNhoeQYX3AlEDuGooZNOUM
         dhgA==
X-Forwarded-Encrypted: i=1; AJvYcCXhrGF+G327tGT7KmM73kUye9eajFYW5qG6+AxuItnvAEUcAKH6j7h/rN8EE/zFzCY1y4tuSpNwCqT1J2rsIOomKm89D6o5sS0=
X-Gm-Message-State: AOJu0Yw2d8Hc8Lv3pqMQjqAWw+eHt0m/Kd7MaoXGY9ruQ7NoYzUEtvnd
	ODeKYXX/WBdFczsKsS9u8SAr3j2KLJJNwcn2oDvi5V8NRbGZLCA34nH+fDUgQ7USc/boDIg2km0
	=
X-Google-Smtp-Source: AGHT+IEj6zPRGHHLxGzNN4SWxrGwgZmUdBK1Q5a1/Qcg6XxZMJUqQmq+LPRHatCVDiYHgGJ/ZEmC4g==
X-Received: by 2002:a05:6902:10ce:b0:e0b:c297:8a16 with SMTP id 3f1490d57ef6-e1181036066mr691498276.56.1723750665394;
        Thu, 15 Aug 2024 12:37:45 -0700 (PDT)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec7eaesm9234316d6.92.2024.08.15.12.37.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 12:37:43 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf6dedbfe1so7060246d6.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 12:37:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6MGpki48gn6CFBXJ7mf5MEC6mYlvqm7Se9JpZVY89pRImmiJ0IZW5d5Tnsv7/F+nDM83kRyyf6EVE9ZgWeGhU8ERg+lpiwuM=
X-Received: by 2002:a05:6214:3186:b0:6bf:66e6:4754 with SMTP id
 6a1803df08f44-6bf7ce7c3efmr5290586d6.48.1723750663162; Thu, 15 Aug 2024
 12:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728130029.78279-1-wahrenst@gmx.net>
 <20240728130029.78279-6-wahrenst@gmx.net> <65de7db8-4f81-4c31-be8d-3a03c9aee989@gmx.net>
 <CAD=FV=W7sdi1+SHfhY6RrjK32r8iAGe4w+O_u5Sp982vgBU6EQ@mail.gmail.com>
 <CAPDyKFpj0C1Bifmx=4zH3r8YooOrNfn_iDB+1sfRb0gTaKnT2Q@mail.gmail.com> <51b63ea5-808e-41e4-92a9-50e20afd155b@gmx.net>
In-Reply-To: <51b63ea5-808e-41e4-92a9-50e20afd155b@gmx.net>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 15 Aug 2024 12:37:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHnKJT4ubmV8EPRYi-qPFH21tNFzWEWMezY2PGEFEKrw@mail.gmail.com>
Message-ID: <CAD=FV=XHnKJT4ubmV8EPRYi-qPFH21tNFzWEWMezY2PGEFEKrw@mail.gmail.com>
Subject: Re: [PATCH V2 14/16] WIP: usb: dwc2: Implement recovery after PM
 domain off
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, Peter Robinson <pbrobinson@gmail.com>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 2:48=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> >> You're saying that your
> >> registers get saved _unless_ the power domain gets turned off, right?
> On BCM2835 there is no need to store the registers because there is no
> power management supported by USB core except of the power domain. So
> DWC2 don't expect a register loss.
> >> ...and the device core keeps power domains on for suspended devices if
> >> they are wakeup sources, which makes sense.
> >>
> >> So with that, your patch sounds like a plausible way to do it. I guess
> >> one other way to do it would be some sort of "canary" approach. You
> >> could _always_ save registers and then, at resume time, you could
> >> detect if some "canary" register had reset to its power-on default. If
> >> you see this then you can assume power was lost and re-init all the
> >> registers. This could be pretty much any register that you know won't
> >> be its power on default. In some ways a "canary" approach is uglier
> >> but it also might be more reliable across more configurations?
> I don't have enough knowledge about DWC2 and i also don't have the
> databook to figure out if there is a magic register which could be used
> for the canary approach. But all these different platforms, host vs
> gadget role, different low modes let me think the resulting solution
> would be also fragile and ugly.

I won't admit to having a DWC2 databook. ;-)

...but don't think it's too hard to find a good canary. What about
"GAHBCFG_GLBL_INTR_EN" ? From a quick glance it looks like the driver
seems to set that bit during driver startup and then it stays on until
driver shutdown. The databook that I definitely won't admit to having
almost certainly says that this register resets to 0 on all hardware
and it's applicable to both host and device. I think you could say
that if the register is 0 at resume time that registers must have been
lost and you can restore them.

I guess if that doesn't work then "GUSBCFG_TOUTCAL" could be used (I
think that resets to 0 but must be initted to non-0 by the driver).

Yet another register that could probably work as a canary would be
"GINTMSK". I believe that inits to all 0 (everything is masked) and
obviously to use the device we've got to unmask _some_ interrupts.

I can look for more, if need be.

-Doug

