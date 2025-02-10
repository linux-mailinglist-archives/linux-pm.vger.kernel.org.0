Return-Path: <linux-pm+bounces-21667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73EBA2E95C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7793A2BE2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B11CAA6E;
	Mon, 10 Feb 2025 10:24:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED121C7002;
	Mon, 10 Feb 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183080; cv=none; b=HFP7QqG9Sdtg78vVhiUG6WCOEeeycfcMVdLxZ2oX6tKPnBHXhm0rX5VJCPGqSKKop3z0ZgOlqdKZJRpGCQWqM7lhSztBthe5OPIT/57H+jsNqiI80PsvEj3IE5skQ/7GN/ctMKtcXcmabeu635CGHMnCY+o8TynSFALw4VKH0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183080; c=relaxed/simple;
	bh=Igk6xtXbrahMVcZKV2Yc+1Z+1k1S6QWTlegc1q4Ge6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTMhpN03IDq+6NSAqds05rdWIvmtndTA8z1xdJjBqujHyTu4O5u7icq/+Bx3psk+yrZh2B2+Y7UN3mQVBrtLIjX8sQxD37vEbXsP0DvaaMmJyzB3KbKGqG8rXl6R4JjznMeXqdquNNgMoxUAdGebz4UKc90WLsykSs464BtCpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-866eb01bde9so2674500241.0;
        Mon, 10 Feb 2025 02:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739183077; x=1739787877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Osu1t2GS64Th/0gUGEEYmObr0x9HpZNyoD8PjbLrbIE=;
        b=KtVXQOxTJn01Ac5aQ58lQ4rYt9SnAgfM+971czMPfdK5nGVOUfm6DemEdklDyV8eUC
         694HUgqEmsqSkO8SQ8JiL5gO/89osNPdyZLMUiiTQHlAl5CiJkcTBlXTE5wHZh6QyDJh
         jYQE9hyBWzbO8HrfWC3B5smwbc13gDPJRuNGgtDTLS6WIreyVx6qbK5zm3GOqGa5Fvb4
         peJ0jNggm2udbKBsuPsbOaOqWGogmADFBwKt735WvA/fp4FqR+kqtOx6p4sk0XcGq2sA
         T/n2JiHQTw/ZQqexEsEnBMtxbF8IElbfx7mp1ovUzBqGCAgSTm6U9x25vWrRZMMzMRDO
         0q4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1pxRZhwINtX8Xj4wVLy4bQRVxEdT54fVYbYf9MEyoFdbhWYe9Yxyy+obo+vwP94Z/SK+FggxgBQ==@vger.kernel.org, AJvYcCUz7n1VlDbxwxaJb9x4etBnIghRKPftzbWMq1hNDKQfJlJgiQr/thMKAN/9f5zEddt+cmWgzRSU3nHNdj5oIc3oSIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHYKJBqyzsJQ8kw7us4AHp5N7/iISxttwNvtzLxI/yUuSXoNa
	r08Gj6MzcFciTx2PN9HyoQ3KotUUgIpwbITKe2k0iMmATKoP/o2+rbYCYYzk
X-Gm-Gg: ASbGncsDKiwT/lwZ1x76lSFnxeibChHmsqWbkb6Xszahex9kg824jTv90VhzT0eYN5n
	487bgqCbfZloQ1vdPSMP0B6DX4TW7sUHJpp9dENI3ECq5GGLRPIKc+BYdzcAzbCxnasV8l2CqPV
	34XCwUAst1ekWE1PDiz4dRs2dxUoRV+0Yp7BUeFLPCFF56MaaJRpPhFHF62hUWPohI3gvN+lP3Q
	VQrcVA+0qoka9ISqwbxrU4O9j3tZSDKsGwwu/tAYnBjmfNitHVCq79OHrg3WjGOWf73bRgeHjk8
	fbMUkaQujsFvAj/ajcAJHJzMqol+1TmbGDGi8OvcCXwoVurdfwJNSw==
X-Google-Smtp-Source: AGHT+IGx9NmOAnFCWR4XWbbKv8DJIX1lxMXZ+vrmrmTGJQIUXFQ9hdrpe7A3qpA/Eb6L2xJp9epCTw==
X-Received: by 2002:a05:6102:4414:b0:4af:e61d:e22f with SMTP id ada2fe7eead31-4ba85f90424mr9749778137.24.1739183076659;
        Mon, 10 Feb 2025 02:24:36 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bbc9b240e6sm352248137.2.2025.02.10.02.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 02:24:36 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4bbcbbd0bb9so509424137.0;
        Mon, 10 Feb 2025 02:24:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlulDT7Kz+r8DqiYMEXVBeDOVsGPRqI9em0VxYF0WJFj3vs19wyhGQhxtJBhFs6ck0VzgTiiIRAkhNYXMgeqfrY4Y=@vger.kernel.org, AJvYcCXqkAfImgY2Di3Z6Yeu777YHnlXmCkpFL0GhHxjO3QMuvryKING0m675W32hI2JDZAeRC6EbRDM0g==@vger.kernel.org
X-Received: by 2002:a05:6102:c8d:b0:4bb:c24b:b658 with SMTP id
 ada2fe7eead31-4bbc24bc2b9mr1984559137.18.1739183075757; Mon, 10 Feb 2025
 02:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2025 11:24:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
X-Gm-Features: AWEUYZnx72wgXq4Q4jI2ShOghylehJaPFyPhmbGhFTKZO9t2mpBK3dtnWdUiShw
Message-ID: <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: Saravana Kannan <saravanak@google.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Instrumenting all dev->power.completion accesses in
> drivers/base/power/main.c reveals that resume is blocked in dpm_wait()
> in the call to wait_for_completion() for regulator-1p2v, which is
> indeed a dependency for the SN65DSI86 DSI-DP bridge.  Comparing

[...]

> Looking at /sys/devices/virtual/devlink, the non-working case has the
> following extra entries:

Note that the SN65DSI86 DSI-DP bridge driver uses the auxiliary bus
to create four subdevices:
  - ti_sn65dsi86.aux.0,
  - ti_sn65dsi86.bridge.0,
  - ti_sn65dsi86.gpio.0,
  - ti_sn65dsi86.pwm.0.
None of them have supplier:* symlinks in sysfs, so perhaps that is
the root cause of the issue?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

