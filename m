Return-Path: <linux-pm+bounces-15340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A429950C1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0E91C25018
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DAA1DF978;
	Tue,  8 Oct 2024 13:54:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A911DF74E;
	Tue,  8 Oct 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395689; cv=none; b=kt50DEBEwPGgQDLEEA2sVr9AtY9ybeSk//ol6k93d/0yWsA8vaHVL8nsjFCsTu+Iix6IwQFvu7V2sLPbgPu+Kdxb0Ykv1mAMoHqp73mV5Xbn5VYILKiv3J45vE5L6gfLG7WIV7WfZiofBfObH1PFRtq4mHgJn9zuFgx3bxIPO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395689; c=relaxed/simple;
	bh=LO8a+sxjyviC62YLXvVJ3sekmoTsrJ17qcMmxdMKoGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjdVKurlN+8rIjcSJ/pOYIHh5XAhvYTovoiMmAvEHHfg3JhqL/QCNWB5kiWKnzPapf2dp6KwSf/MJPazH4NnioD5VC/zaZOU2vc+MboKJr6SLF/vL3s/swZhq6nRiyXz/QgPDce/z1DnSbYbBDITH4Uno5/UoKlR3FxhvRCksbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e25f3748e0so57073367b3.0;
        Tue, 08 Oct 2024 06:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728395686; x=1729000486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3uCZskBH2tXjyYuhmNFj34NCuiW42SvvJ2N3l6bLtk=;
        b=dhsCwCrXWFhQe5q72vZTUVYdVTTC4m/LIpg98PL1c+B/458IzGVMF5ghJsgbwnYc/l
         /lkx4ppZ8U9T11I1P261RLXrKl7BM8iSEbynD0Tiq6P9LwsUIkoR7CXKGYUaIhS5/yqu
         gNg0i/3Mkyidy7j+57WPhHSEVDwKokrodkgBvQ45aqj92DxDOMbPSpMqTTizwXNm5lCm
         nTe1iELkxtKjo/4LJtqId+/n6ckQ6F2SsVBjo4bm+kQriFur7z++N7JkC8XhrtiXwG9J
         iZwj2QAZ+3JqG300F938PsBx2iZKete5GyYHFlwXlktq4ivK2X/d2J9ELXbMUjzvEMpd
         Sr1A==
X-Forwarded-Encrypted: i=1; AJvYcCUmtC63cvYYW9ULbFy8Vbg97pQzCjr0iaFGAJuqfmuV347ee23TAscIO9cm73WT1U+glMMHBqPUfjk=@vger.kernel.org, AJvYcCVV1y/li12E9yXlftnPCXIORwREOZ4/40cWNPSo7iJt0NYmyKflHm3NZtKfLp8sFNCvh78NTwG2NHvb@vger.kernel.org, AJvYcCWK+a4ZOTc8WkXjzOJB9ikfKdKZH5ie39Ln33pWNh2kl3JkzGo+03JxaRL+BsvzhOc2pjmxARAM9ryu8iwVFI1wdCc=@vger.kernel.org, AJvYcCWZkVsUE7aJcuMJ/A2bxom8o89p1Xea12PFU8sveQWEYHZvppUrUeY/yLaJofHp1ZCxSSe2HfDAqA+X@vger.kernel.org, AJvYcCWn4gFLkWXZUq0EyCOyd5vuwwZToZ0tefo8Hu1aeESWC7KPsPi72nsvbZ4upQfhsmul0C2D6qQsOfFbFh96@vger.kernel.org, AJvYcCX+luNUrVoFUAUgbTldFLgs95jAyI+Y7SboqRuvMTrzGficVGtX5Ii0k4wKHo12m5zuI+ViYMwsMKw+@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgPPDHFnzBpwwqykHZ+5+Jy4+tyRRMeFB35rH/YmXjaCM8Wz5
	3d/u/dJhu3onBlSrMZDVRsQO2pQduiVPU6W89n7jqRO5WfK2Z4OkTQ/yMkrU
X-Google-Smtp-Source: AGHT+IE3dMwOza+AVSqH1LE/rEHn4F9GIOTC8H1byRwwn11XsFIJT227xStdSmI67pYeyiuzj8Cr9g==
X-Received: by 2002:a05:690c:700a:b0:6b1:2825:a3cd with SMTP id 00721157ae682-6e2c728aa03mr120194077b3.35.1728395686643;
        Tue, 08 Oct 2024 06:54:46 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d937c4d9sm14337007b3.56.2024.10.08.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:54:46 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2e424ab49so23420847b3.3;
        Tue, 08 Oct 2024 06:54:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURNkZhtyAHS52ACMW77Q6JjbJ2VhIJbZ/ipS1srnisTmEnEppfi+mfuH7rr2GOJl4jce2zcConKNvc@vger.kernel.org, AJvYcCUW5c8rXd5UQDeC1cbvMN/sm1OOi+g7Ffg90C4xF/sUes7n1FMrTTbbRDBHaNs5/VGEoz3BDIClNpuky/5L@vger.kernel.org, AJvYcCUgJOZsrl+gAZrOy02V6O8GOG6nfvjDrTaHeVkdk5uwQZouUnzMcF4gEgp3pN7UfHiryZ4G18Ve4boW@vger.kernel.org, AJvYcCUpKOf4yHncJwcVMOXCtL+YIH621e1/qIUM0zHQn4Lyk2WQtyucf8khqg4WztWQGD7sXMs+q2m0QpGYy3x/TE4z9cQ=@vger.kernel.org, AJvYcCVp2acOyRMm45Hycpv8bXaMU4iwilb6Mqgo6UqyjZ+D/xUDrMKQPlToiSW7frGOalYIxYhoswlMjQjV@vger.kernel.org, AJvYcCVpoOEzYcyugh1nrHUCcEcdqlnEVwHGbFn7nh4TLl7/PtGSr4WUmqaRI/zF3IzmM/PJ85Kjv3EwrRI=@vger.kernel.org
X-Received: by 2002:a05:690c:6ac8:b0:6de:a3:a7ca with SMTP id
 00721157ae682-6e2c728a25fmr119511907b3.32.1728395685683; Tue, 08 Oct 2024
 06:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVQsHx0nC3xwQWVRWyWMnbXd1=RokNn8rkJv3bfG_0p-A@mail.gmail.com> <23531a70-cf50-4b32-a9fd-81e6cfcbcf9d@tuxon.dev>
In-Reply-To: <23531a70-cf50-4b32-a9fd-81e6cfcbcf9d@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 15:54:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWakggcbrBetKht+JHB5F+fxoi9U-oJMMq=ythUOqtYkA@mail.gmail.com>
Message-ID: <CAMuHMdWakggcbrBetKht+JHB5F+fxoi9U-oJMMq=ythUOqtYkA@mail.gmail.com>
Subject: Re: [PATCH 04/16] soc: renesas: Add SYSC driver for Renesas RZ/G3S
To: claudiu beznea <claudiu.beznea@tuxon.dev>
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

On Wed, Sep 25, 2024 at 9:50=E2=80=AFAM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
> On 24.09.2024 14:32, Geert Uytterhoeven wrote:
> > On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.d=
ev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The RZ/G3S SYS Controller has 2 registers (one for PCIE one for USB) t=
hat
> >> need to be configured before/after powering off/on the PCI or USB
> >> ares. The bits in these registers control signals to PCIE and USB that
> >> need to be de-asserted/asserted after/before power on/off event. For t=
his
> >> add SYSC controller driver that registers a reset controller driver on
> >> auxiliary bus which allows USB, PCIE drivers to control these signals.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- /dev/null
> >> +++ b/drivers/reset/reset-rzg3s-sysc.c
> >> @@ -0,0 +1,140 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Renesas RZ/G3S SYSC reset driver
> >> + *
> >> + * Copyright (C) 2024 Renesas Electronics Corp.
> >> + */
> >> +
> >> +#include <linux/auxiliary_bus.h>
> >
> > Using the Auxiliary Bus requires selecting AUXILIARY_BUS.
>
> Thank you for pointing it. I'll adjust it in the next version, if it will
> be one.

Thanks, the rest LGTM.

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

