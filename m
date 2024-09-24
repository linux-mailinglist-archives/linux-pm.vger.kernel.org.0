Return-Path: <linux-pm+bounces-14611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ABA9844DE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FDE1F26F7E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070B1A4F26;
	Tue, 24 Sep 2024 11:32:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247C86277;
	Tue, 24 Sep 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177542; cv=none; b=oPvfTIHXhCiJfsues6mcUDhexkzOS9wbRmEwhcnJhlYMDcDtdDXNzRDb6z2pZGlb3a1/QcPYRpRITlEeeCKvCR2+YtYJWAyp1iRr83mGSVeJXhg7+gktnQ4dhsu6SbaQXZ+CJD5H5oq8P9JaBD1gUQ7gPpJJYF1tMctlmMvKIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177542; c=relaxed/simple;
	bh=274mWF5yEg9y+wkgxhf4U9sHZqXg34pBvu3HEUVXSrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEPQvljxFpebMkMFcQpo9O8nDqVpIrewVK3fqO8iXPiStl80GXLysSub6I0tCgVz+hmZhYW5pQw904VpTsXn2tR9sxQCAWo34YNOlUTwqAYjy54gMr4JxHp/2nMS1Y8dbT6EHDnjE6zSRFkH7bnbl2/ZCj7P1/xTxUvsJYdMCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1a9463037cso4304698276.2;
        Tue, 24 Sep 2024 04:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727177539; x=1727782339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm6h96BED8DQTfet2QAIovV1CqCtWAjpatPZ7/UosWI=;
        b=O+FdUPxWG3BBt8tugF2UAreSMvSpqGm3qBzno0F/nxwd1e0810kPCFVNI721Dee6k0
         /kejpfHO6bN6qMZUOEoOGL6WAX3s7J3GOzWuihkbg872ePFfzg3fxJOWObWU+8WXDvDU
         5bRO9Izbpl3gS/1xjmSQ67wpvWovW9J4C/t7hkAxnLKcxkeFpbED44NLzGdgi2Op9Gyo
         Qp0KUwdGc6A1KuKzAP7fRlWcq7CMc9vLidelweyahE3xTGTbJ0OwR70IuZYOUrgnpWYe
         b6izvWhaSWTfmq1lYEjVOmhFu05kdaSBZAxkyjtL1jT+EJ6kEtvoQKJnY2oMgzEI9xqA
         RBEw==
X-Forwarded-Encrypted: i=1; AJvYcCU5P6ccXBzvGpHDE7MQHd0YrV2PvUZmFiRMszkplB1hzIg1WGXOGLtSyogf/0e4+UTMqCQnUM2vzCs=@vger.kernel.org, AJvYcCUMPNGoZorrpCJmLYbBYDhogP9IW4IGF+WMJpXQ3W2kQcJ2H5FbEeykrzSE5YtMF/1iHYFoXtKoexAy@vger.kernel.org, AJvYcCVGNliva32m4NIL3A8qRoUBKpB3MgX4c2T9vfHa8iBLXMwoxJZ47A6fmHUU01ZXuCxGKMCMH9tN7WPCrGREuRHltiE=@vger.kernel.org, AJvYcCVjizAiX2k1eUb9uRFmKnfrVdnzdG8UT5qCiWTwEkXYSnr6R4WY7pUZz+AbYSd4trMmTZ2Pyl7KuroJ@vger.kernel.org, AJvYcCX/84m2rNLWcyKJm5F9lRlq7WVa/bHtE/J8TsvnpEq9sJoJBxu0IqPbs0Aqh1XDPPVGfZ0bRoAqCaQK@vger.kernel.org, AJvYcCXwRd/1MEmNlP97mK/dXRYsJrxRddzQg03FuBycpibRSYWitdOkWL5Y4s8ox7KVgE0MVewKdSFr8q6BVYfl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1V+5qE++4ULbYMEDrqV2LzjuMNgiPetjWP4vfRo8qfMZ8ozJL
	9/RWpt90UVe+kJOQvCv1uCd3iX0XOwLFNm87ipseox1zgSWySRia27dDwie2
X-Google-Smtp-Source: AGHT+IGd1dnlMbgebNUguoCcxM9oWkJXb0wuXHGJaBip1RtFNA0UIc2YRhkqnwJTUIzowHL1bZkcCg==
X-Received: by 2002:a05:690c:2507:b0:647:7782:421a with SMTP id 00721157ae682-6dfef019bb1mr70492647b3.45.1727177538769;
        Tue, 24 Sep 2024 04:32:18 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d2a7b4asm2117897b3.143.2024.09.24.04.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 04:32:17 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6da395fb97aso40617217b3.0;
        Tue, 24 Sep 2024 04:32:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeckDrUJBOL1K0zfCMg/uLugj4l6mcROczcwmycRmFIcBibsXEneeObLw8GZT4Tjp9nzlSSrvOLxJxtqg0C+J/VeA=@vger.kernel.org, AJvYcCUm1yLINOEa2+aQnyN46koR6dLCw5WhdvzkpL3ZHf9JFvpFzw1OYdWMHAJwzDuMudslYo3Xij6e1jmO@vger.kernel.org, AJvYcCV5ef23bMFkoIIf9rfPquqml7hVw5DkEJ1B1QKQq+3B55eqtvfRDSEFX0NnTqc6golq+88vlXzywUfX@vger.kernel.org, AJvYcCVxnEAcO7i7cxzBdVLLGzpOuEnH2+Wlf0im4jWjEYX2S7rcj5MVfu3sZnosi3DdHNrMPXiki1RQ8iE=@vger.kernel.org, AJvYcCWk1ZnXAolXPZx5b0vIowIiOI7Rt+Ph2/UNceHvOUsVL6FRPXDpsAR7A12sftELdIi7BinoEYKq7RaP@vger.kernel.org, AJvYcCWwZI/P5NQvoQdOI55FVLfA48XhbIYpPtVJKiEtWDFjKQO9djJAwE3tLaVuVo+bcpMvSNTMhB79v43m4dV5@vger.kernel.org
X-Received: by 2002:a05:690c:48c1:b0:6af:eaaf:2527 with SMTP id
 00721157ae682-6dfeed87f8cmr127931067b3.18.1727177537112; Tue, 24 Sep 2024
 04:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Sep 2024 13:32:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQsHx0nC3xwQWVRWyWMnbXd1=RokNn8rkJv3bfG_0p-A@mail.gmail.com>
Message-ID: <CAMuHMdVQsHx0nC3xwQWVRWyWMnbXd1=RokNn8rkJv3bfG_0p-A@mail.gmail.com>
Subject: Re: [PATCH 04/16] soc: renesas: Add SYSC driver for Renesas RZ/G3S
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be, 
	magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, 
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com, 
	biju.das.jz@bp.renesas.com, ulf.hansson@linaro.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ/G3S SYS Controller has 2 registers (one for PCIE one for USB) that
> need to be configured before/after powering off/on the PCI or USB
> ares. The bits in these registers control signals to PCIE and USB that
> need to be de-asserted/asserted after/before power on/off event. For this
> add SYSC controller driver that registers a reset controller driver on
> auxiliary bus which allows USB, PCIE drivers to control these signals.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/reset/reset-rzg3s-sysc.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G3S SYSC reset driver
> + *
> + * Copyright (C) 2024 Renesas Electronics Corp.
> + */
> +
> +#include <linux/auxiliary_bus.h>

Using the Auxiliary Bus requires selecting AUXILIARY_BUS.
Elsse you might run into build failures:

aarch64-linux-gnu-ld: drivers/soc/renesas/rzg3s-sysc.o: in function
`rzg3s_sysc_probe':
rzg3s-sysc.c:(.text+0x21c): undefined reference to `auxiliary_device_init'
aarch64-linux-gnu-ld: rzg3s-sysc.c:(.text+0x264): undefined reference
to `__auxiliary_device_add'
aarch64-linux-gnu-ld: drivers/reset/reset-rzg3s-sysc.o: in function
`rzg3s_sysc_reset_driver_init':
reset-rzg3s-sysc.c:(.init.text+0x1c): undefined reference to
`__auxiliary_driver_register'
aarch64-linux-gnu-ld: drivers/reset/reset-rzg3s-sysc.o: in function
`rzg3s_sysc_reset_driver_exit':
reset-rzg3s-sysc.c:(.exit.text+0x10): undefined reference to
`auxiliary_driver_unregister'

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

