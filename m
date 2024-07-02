Return-Path: <linux-pm+bounces-10383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FCB9248C4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 22:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9D2855F1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1431D47DF;
	Tue,  2 Jul 2024 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPKH+kZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8641D3638;
	Tue,  2 Jul 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950929; cv=none; b=XUiuwaGFNE4Fer2wLHRuL8055+4Ko3Aeh/U64G81h77MsrZYpX2lzVG80qZ3ymCudveV8y5OQGSXqv0O/pg6EbbVieb3eByGz9d27B7U22llRVZPqyCpDAxeMFdkQLihZw5/ApYZzPsf/oKfR4BrU6+a2g0S53WpJwHYtFkf+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950929; c=relaxed/simple;
	bh=ErTJG4vcHSq470As+25tvh1RBupFrLsM68ruJgI+uy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUVX+bGIhYDlO9HHWH3/Ffx9AgyzZMeS0RDLGTB9J3EczCt3zlkFCQ5m+6cAA54abbR2f7SE+fwaXntTzS4CcUT2zL/G02jSOkUkjQZrjKZHmmvCMAdxXcP/VyxIsfjsn1RsWLnGCCy90n7RBxP+6rWE+/svEfWSuy64VUDf9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPKH+kZI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso49044511fa.2;
        Tue, 02 Jul 2024 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719950926; x=1720555726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzH64RTqn+FaUcV18/HlgJMuVfUQPdBgy9ejrE2KEAw=;
        b=JPKH+kZIgPHkJLVwKfRrzdDv0b4fo9N3eS6c6YGuiulitUnTMGQhZc7441F94uWU52
         w/vBnYu+q6z35aBh2o5wJTbZWr4eGnFmVFEX3w+C405GkG4tl0fpD2VXJ+Ed3+CEWnOR
         S+aXH5UM1y29zLv2k+iOH/tvP/Ow993FOG83fufDoDCLYmYcMgB5Dx+PJQM3WEx8dKnm
         i1pVsY/etb4GA+yD99uLRhPVolmOBO5Nlb6bcUg4tyPoEFygRW6hhLG6VhQHuiIxypT9
         oTKFax8usEPsRXaKrB3Uu77ZAxTSIJaGuGZVpgBdDjpyF+PvgcgvBKHlwXrA08+3q4Ex
         drGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719950926; x=1720555726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzH64RTqn+FaUcV18/HlgJMuVfUQPdBgy9ejrE2KEAw=;
        b=bbsHxId/JWZAmjqg61MVXYMMfMSWqiRQYEp5tB5gdn5fvkJCQJn+euOBykk1K5WPgA
         G01ajwmHdUH2KMNXLYKDTrpRdfHiMykZ6ZUnDdDDRs8vpRwRnMnTbpAyMssgzJ4F4pAk
         qWRrs2dR1vA4cC7n6tTpjRI22V99ThNpEsb+fJ4dVZ97+bcv4RMmAReqv7uJx/ULLTp/
         4aLbL0lPZIIGIl7TY3N1eWiVtAUYs3tcUbqkBIUxymzSYvqbp1IZN+L/7lOSahAYzf5E
         STF4uK+KW6ttgN3E4FT5B2mltPl1XsDkSIQPuT4wNMqBtRAXCuTwj+2+WuXDXZxxpkz+
         gAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIVNm+VB7aFgg9tlOIyiTcXXF+MrhtpMxXMWSlU3W3ACOJfS0Uyv9RI+cuPuPM0TzWHgoVUtzJUnK/l1E7Z449p2WK+V+F+CxyIDlLYZ6qr+e5A+uqMxwRSIfhZZwFMIsigqv+EDGtKwJ4NjzRKJrcb5qoj4+YqmVNWsJZ+KolEb0=
X-Gm-Message-State: AOJu0YwI0s+0gHrsrWwxwCG1DLDYaS6FzGMUD02wkjBKogvI03mZZtvB
	JRK89+pqyElOrAslgRHrIv5frnWva2id79EU1LlafU/DCn3s+kKas2cYSfLwYZxteOzfCAtfiA8
	V8vqBDKbXcYDy88xMX5WLom30ElE=
X-Google-Smtp-Source: AGHT+IEbnNwEICAmy8lZBda4cz1ZJA7iuStARN+4cLloZVt3cvlyN0vsRezK8xmrP3tIgonfEjrZvr0zWEcZ2HWVKkg=
X-Received: by 2002:a05:651c:86:b0:2ec:588d:7eb8 with SMTP id
 38308e7fff4ca-2ee5e36eb67mr61061881fa.21.1719950925725; Tue, 02 Jul 2024
 13:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630153652.318882-1-wahrenst@gmx.net>
In-Reply-To: <20240630153652.318882-1-wahrenst@gmx.net>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 2 Jul 2024 21:08:34 +0100
Message-ID: <CALeDE9OFKS_g3KU=AuN-o_jLRyDG1eiJhXs0rLRQx-1GyA+dcA@mail.gmail.com>
Subject: Re: [PATCH 00/11] ARM: bcm2835: Implement initial S2Idle for
 Raspberry Pi
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Minas Harutyunyan <hminas@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"

Hi Stefan,

> This series implement the initial Suspend-To-Idle support for
> the Raspberry Pi, which was a long time on my TODO list [1]. The
> changes allow to suspend and resume the Raspberry Pi via debug UART.
> The focus is on the BCM2835 SoC, because it's less complex than its
> successors and have enough documentation.

Firstly a big thank you for this work!

> The series is a loose collection of fixes and improvements.
> So cherry-picking should be fine.
>
> Test steps:
> - configure debug console (pl011 or mini UART) as wakeup source
> - send system to idle state
>
>   echo freeze > /sys/power/state
>
> - wakeup system by console traffic
>
> The implementation isn't perfect and contains workarounds like
> patch 4 and 9. So there is still room for improvements, but
> at least the system won't freeze forever as before [2].

I've got a test kernel for Fedora that I'm going to test on
RPi3/Zero2W so let me know if you want me to test anything in
particular, I will do my best to give review/test on each individual
test over the next few days.

Cheer,
Peter

> Here are some figures for the Raspberry Pi 1 (without any
> devices connected except of a debug UART):
>
> running but CPU idle = 1.67 W
> suspend to idle      = 1.33 W
>
> The series has been tested on the following platforms:
> Raspberry Pi 1 B
> Raspberry Pi 3 A+
> Raspberry Pi 3 B+
>
> Known issues:
> - currently it's not possible to power down the USB domain [3]
> - there seems to be an issue with the DWC2 suspend handling [4]
>
> [1] - https://github.com/lategoodbye/rpi-zero/issues/9
> [2] - https://bugzilla.redhat.com/show_bug.cgi?id=2283978
> [3] - https://github.com/raspberrypi/firmware/issues/1894
> [4] - https://lore.kernel.org/linux-usb/3fd0c2fb-4752-45b3-94eb-42352703e1fd@gmx.net/T/
>
> Stefan Wahren (11):
>   firmware: raspberrypi: Improve timeout warning
>   mailbox: bcm2835: Fix timeout during suspend mode
>   pmdomain: raspberrypi-power: Adjust packet definition
>   pmdomain: raspberrypi-power: Avoid powering down USB
>   irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
>   drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get
>   drm/vc4: hdmi: Disable connector status polling during suspend
>   usb: dwc2: debugfs: Print parameter no_clock_gating
>   usb: dwc2: Skip clock gating on Broadcom SoCs
>   serial: 8250_bcm2835aux: add PM suspend/resume support
>   ARM: bcm2835_defconfig: Enable SUSPEND
>
>  arch/arm/configs/bcm2835_defconfig        |  2 --
>  drivers/firmware/raspberrypi.c            |  3 ++-
>  drivers/gpu/drm/vc4/vc4_hdmi.c            | 18 +++++++++++++++++-
>  drivers/irqchip/irq-bcm2835.c             |  4 +++-
>  drivers/mailbox/bcm2835-mailbox.c         |  3 ++-
>  drivers/pmdomain/bcm/raspberrypi-power.c  | 17 ++++++++++++-----
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 23 +++++++++++++++++++++++
>  drivers/usb/dwc2/debugfs.c                |  1 +
>  drivers/usb/dwc2/params.c                 |  1 +
>  9 files changed, 61 insertions(+), 11 deletions(-)
>
> --
> 2.34.1
>

