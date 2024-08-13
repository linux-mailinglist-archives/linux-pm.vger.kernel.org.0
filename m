Return-Path: <linux-pm+bounces-12180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6C950D72
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 21:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F1EB2117D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 19:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5BC1A3BD6;
	Tue, 13 Aug 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DEvn8vRB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C055898
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579061; cv=none; b=kF4ea7I9/iVeGYGD8bVtpmYzCialNLZGMIiRUlTBumMa9J6teMWikp9WP4kw8sjsDbgL0dCzZTZUTmoNvq+e3iwX5n8WAGRd9ZC+/JZKY9a4+2np/5sVGI/FxaIS5TnK12pZBtgs41FG1cPEDCxxOt8PF/CzsNDtJzI3V40aQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579061; c=relaxed/simple;
	bh=HY47OI6qgPGV0/QE09FI/k+0tj+UYHuJ+dL5B1JuDSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsMdxmkG9RuUWQuU5ypiXPtTGgkzK2dZL6vrWBmDftn3n7rjnEzL+Fiwq1PXRAQebxJGzGeTVg0FhaAJxIHPCgnm2a/YcpyNpAYb747ad/0ju/rDtPlSvKmLQSdCDSK95h5GXv3y0pFZJGqD05eVSVPei8MgIZS/CjZn9Xf85pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DEvn8vRB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so40625866b.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723579055; x=1724183855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY47OI6qgPGV0/QE09FI/k+0tj+UYHuJ+dL5B1JuDSE=;
        b=DEvn8vRBq1+zgNVfiNgS5palLgjurmWj5RAC/VWvcA9J1+b0nqV7W4JuZzLoF/atUZ
         yqz+2BvCFTcwMCg4w4aSz1ySLVcEduL2rtaFbajAIJid42FTxRg9kKgXgWlia/YM7xNo
         67HUqYcNEDggvUSh9JBytkoMDMDNeP7Aclrg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723579055; x=1724183855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY47OI6qgPGV0/QE09FI/k+0tj+UYHuJ+dL5B1JuDSE=;
        b=htDY5fTR5oe0c5Uae1DOrSbKEAcr1bA7wE305sFxEzbvjm8QIf+GvGTBIGH9cPux7a
         3faHfCFsngrdrY9tsX7wn3cuRiv77+/d/IUNU2D95rkHBytN7VhO06pPIaaWWG1q/lai
         RikQNmYCZkYiq9T6cbGtckA+J0/7i4Bg2DyQIYYtUr4lryI+mq1addkFJJTdjDZuEP7d
         6eT02ML41cLi2o+jpjz8QY914aP3A4siikIJBjRe4kbEq0iUEIVpS6Mxmy+gIHrGU+a/
         Uon/lksJsAJOdx0PVFe6ET3Z0gOsVm67ecfmvH1Ug5k9aTBYxucr2e4NGJwU5NsIIGLc
         uHzA==
X-Forwarded-Encrypted: i=1; AJvYcCULFmuZ2FkfypsiqUHvC5tWAajRKlUDiuJmObyf5mxWcosb4MWGQU3vBeXlYFrQWXVYSaflw4Xb59uFpMyJUBDBamP8W8WatyM=
X-Gm-Message-State: AOJu0YyT0D4DcRccJqcOkSmhRDCS2A1Tfpx5pIc+ev+R6WnOdxETpIDF
	YQD2v5x/Pxy6pxcohk+0vFxLj7P0L3l2BFldx2YPkdh/s6OufeCa5rmYJY74u/5lIrXzgFSWlp8
	vAA==
X-Google-Smtp-Source: AGHT+IGIfazKdUFrvqvpf55zxarcA8Qrdnp+IWjIuT+MkPPivgXdZyvveqdy+2MxrxsaIcyuncVjuA==
X-Received: by 2002:a17:907:e207:b0:a6f:996f:23ea with SMTP id a640c23a62f3a-a8362788086mr70840566b.15.1723579055022;
        Tue, 13 Aug 2024 12:57:35 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa13desm92558066b.48.2024.08.13.12.57.33
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 12:57:33 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368440b073bso154181f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 12:57:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrnKPG9JpDBCYKIt/lBzoZ1g9C/q/3lZu3pLtxTX+0qEk5RJFwvgA+kDuMrJv9bDpH328RXDDXOXtYgIYaXHMpiLVgm533CKM=
X-Received: by 2002:a05:6000:1e98:b0:367:8f89:f7c9 with SMTP id
 ffacd0b85a97d-371775d5820mr524329f8f.33.1723579053293; Tue, 13 Aug 2024
 12:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728130029.78279-1-wahrenst@gmx.net>
 <20240728130029.78279-6-wahrenst@gmx.net> <65de7db8-4f81-4c31-be8d-3a03c9aee989@gmx.net>
In-Reply-To: <65de7db8-4f81-4c31-be8d-3a03c9aee989@gmx.net>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Aug 2024 12:57:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7sdi1+SHfhY6RrjK32r8iAGe4w+O_u5Sp982vgBU6EQ@mail.gmail.com>
Message-ID: <CAD=FV=W7sdi1+SHfhY6RrjK32r8iAGe4w+O_u5Sp982vgBU6EQ@mail.gmail.com>
Subject: Re: [PATCH V2 14/16] WIP: usb: dwc2: Implement recovery after PM
 domain off
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
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

On Mon, Aug 12, 2024 at 4:48=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> Hi Doug,
>
> Am 28.07.24 um 15:00 schrieb Stefan Wahren:
> > DO NOT MERGE
> >
> > According to the dt-bindings there are some platforms, which have a
> > dedicated USB power domain for DWC2 IP core supply. If the power domain
> > is switched off during system suspend then all USB register will lose
> > their settings.
> >
> > So use the power on/off notifier in order to save & restore the USB
> > registers during system suspend.
> sorry for bothering you with this DWC2 stuff, but it would great if you
> can gave some feedback about this patch.

Boy, it's been _ages_ since I looked at anything to do with dwc2, but
I still have some fondness in my heart for the crufty old driver :-P I
know I was involved with some of the patches to get
wakeup-from-suspend working on dwc2 host controllers in the past but,
if I remember correctly, I mostly shepherded / fixed patches from
Rockchip. Not sure I can spend the days trawling through the driver
and testing things with printk that really answering properly would
need, but let's see...


> I was working a lot to get
> suspend to idle working on Raspberry Pi. And this patch is the most
> complex part of the series.
>
> Would you agree with this approach or did i miss something?
>
> The problem is that the power domain driver acts independent from dwc2,
> so we cannot prevent the USB domain power down except declaring a USB
> device as wakeup source. So i decided to use the notifier approach. This
> has been successful tested on some older Raspberry Pi boards.

My genpd knowledge is probably not as good as it should be. Don't tell
anyone (aside from all the people and lists CCed here). ;-)

...so I guess you're relying on the fact that
dev_pm_genpd_add_notifier() will return an error if a power-domain
wasn't specified for dwc2 in the device tree, then you ignore that
error and your callback will never happen. You assume that the power
domain isn't specified then the dwc2 registers will be saved?

I guess one thing is that I'd wonder if that's really reliable. Maybe
some dwc2 controllers lose their registers over system suspend but
_don't_ specify a power domain? Maybe the USB controller just gets its
power yanked as part of system suspend. Maybe that's why the functions
for saving / restoring registers are already there? It looks like
there are ways for various platforms to specify that registers are
lost in some cases...

...but I guess you can't use the existing ways to say that registers
are lost because you're trying to be dynamic. You're saying that your
registers get saved _unless_ the power domain gets turned off, right?
...and the device core keeps power domains on for suspended devices if
they are wakeup sources, which makes sense.

So with that, your patch sounds like a plausible way to do it. I guess
one other way to do it would be some sort of "canary" approach. You
could _always_ save registers and then, at resume time, you could
detect if some "canary" register had reset to its power-on default. If
you see this then you can assume power was lost and re-init all the
registers. This could be pretty much any register that you know won't
be its power on default. In some ways a "canary" approach is uglier
but it also might be more reliable across more configurations?

I guess those would be my main thoughts on the topic. Is that roughly
the feedback you were looking for?

-Doug

