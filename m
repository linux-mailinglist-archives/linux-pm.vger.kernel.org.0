Return-Path: <linux-pm+bounces-32280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E46B2491D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 14:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6157BCB62
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3C2FDC5C;
	Wed, 13 Aug 2025 12:04:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CFE2D73AE;
	Wed, 13 Aug 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086668; cv=none; b=eibaFJ4+NfIF6zA1kClMXDLyEcnjJHQSag4KxB5Y6j5gTeUVwvImSokHjmSVtKaspXA+KXwLiOYchs49ewZpfmNRWCHw2YFKW3lHwYGVFDT+MaZKpVa7iRIdwpEzgGk7hVgoFpWLFiwW/dZ/Q83R9WQJIW3s0Ajxi27UUN6K+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086668; c=relaxed/simple;
	bh=uXBhJPRZMN9HfjHxtBD9GnZwhXecEMvUfijwCzpCQjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeoWmx/VBXb1/338j/5WqQF5r8Y/kz2NVa8ZxLcddNyFGrjP2sVWQ3X/VuIuOtISGPbuMyyuNZSo88MrQlEDPhgRxoUL9DQfLanzg34kPGaeYADu4SL1Nh3aE874S/RpGz6YuZghSXC0+UDaIsm62VTfgPLJjBHqvRRut2wTEiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4fec0d6fd90so2299238137.3;
        Wed, 13 Aug 2025 05:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086665; x=1755691465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnlFfu7fx2zDGb6puNkcBG8WEMDnuOsjkStSJt7ZaHo=;
        b=Cq8mcKqpTGd7yNkrvI/5IrN/tt3mR+UsAlhtwQJ8fIjUHXmMGkZ4QRV8BlwyvYZL2M
         x6LoN8hogh0dfF2HvgRbYIzEaDyM/GsXaLSYvNBebkLEBCdti0U+YNS97OfGnnpk8Od3
         DaorfmZuPT2K7yMdlayXxrp9ZuD9y3SkdnLiPgWylyDzCEpQkphPbZXTCUP6GCU9W83Q
         KHKyc/x7LP3327bw7xXh/O0Slb/qhyvvd7yIcBnHhMyVwW/J5Fgm136goY1IwRl7Vnuu
         fB6tuubkOlAVi1YPpPHABOEMU1/KWH5GN792R63odVJxQvDZGRdQU1NSlyMF2dD7h80F
         yN/g==
X-Forwarded-Encrypted: i=1; AJvYcCVUqMsu30NWyMAOZ/9aizEUMAKm4TOx8AVmEEPk7HNP5tQn/bo3TJ05KAeBcYJYT3gOarDE3+TPY6LEDqo=@vger.kernel.org, AJvYcCXT8G0/zAtU95JPHPAzF9fRbmQ/V1YkfhyUTkl35R61EsjsdoEFYU7SOPZlh28eVaGUkO9qniWr2Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Dd77JzmJd8NOKDnVpNybZd7vIcvpODmhgASwVV5yCncDP1yx
	LF7V4h0ONIGQF7mSr/cV21oy/cXZtkFDjkdThDteytZxRgAVlEBhz7rXHotB9ikJ
X-Gm-Gg: ASbGnctIXzwB7lrPGwcvyPpfj29jAv2JuID2nHGJqMQP6YQVJRBsxA0OU69AOOMoCY8
	UPb4DpH546eOdG77OoV8MXCJS0B6uxvHNjA7AIJt9LozuHeRfyuQCrPq7BmJNYecBb+8OVHx4qJ
	a23Q4cWxl2gBBeKVtEHGtuesewxRrgCRV1LkqUl4/MSb8RY4r5nKd+diyL9FvJYpdlZpKHllrCn
	f+3Is8Ys84mjHG/3SNMNJ3QgVoAYjExdMUhEHWQF0if1hAq4h/68ZvSUOgVq2ezRtSzzDYcrO9n
	4BmJKlJXf+qPbtHb9ByvTr/H/rZsnvoO5or66Gyc2Vaxhifg7sLiXvM8O5itUDGw0H28e1M3JUB
	swKsCkdiM7X9K5GEYvBUq9yOy8n0BM5ZBs+Jt9yznvuTFtzakbYEIY+xxduRu
X-Google-Smtp-Source: AGHT+IHU4/Oa/1zco/N5zGr/62xEseQqpIDPLhcPpp7KNWQgx7TFRbf0oHmVb/N6LhGy9giCtaV7xQ==
X-Received: by 2002:a05:6102:5a97:b0:4f9:6a91:133a with SMTP id ada2fe7eead31-50e51bc6dc2mr922095137.27.1755086665232;
        Wed, 13 Aug 2025 05:04:25 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-506290ef371sm2605442137.5.2025.08.13.05.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:04:24 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4fec0d6fd90so2299236137.3;
        Wed, 13 Aug 2025 05:04:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGfusF/3gYdUCKRhzp1Vhni1NnPZWB0FNuYVCNdhYj+fJ60u3TgvtHGyN35VJA0h2u5dwhUE3P1ks=@vger.kernel.org, AJvYcCXu5J8MWuEYeXg/zgKKCheCRrcUtAG3XxWkAwkd+urX661A4n3bor13rru35mZss0xw3W5xgIRq6ludEGE=@vger.kernel.org
X-Received: by 2002:a05:6102:e0e:b0:4e7:bf03:cd79 with SMTP id
 ada2fe7eead31-50e4e5d2141mr911079137.5.1755086663571; Wed, 13 Aug 2025
 05:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org> <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
In-Reply-To: <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Aug 2025 14:04:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHZZByTDhKUW4=vX45h7AJNXNzjHQSXMfEV=mdc8NCVw@mail.gmail.com>
X-Gm-Features: Ac12FXy-RTF6MSiz3MwhGjbIrkTvy8VuSBzBu0kMtbvvXbrItd-2qk19ZqkwC4Y
Message-ID: <CAMuHMdUHZZByTDhKUW4=vX45h7AJNXNzjHQSXMfEV=mdc8NCVw@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Lubomir Rintel <lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > Changes in v3:
> >         - Added a couple of patches to adress problems on some Renesas
> >         platforms. Thanks Geert and Tomi for helping out!
> >         - Adressed a few comments from Saravanna and Konrad.
> >         - Added some tested-by tags.
>
> I decided it was time to give this a try, so I have queued this up for
> v6.17 via the next branch at my pmdomain tree.
>
> If you encounter any issues, please let me know so I can help to fix them.

FTR, I discovered two more issues with clock drivers registering a
genpd OF provider from CLK_OF_DECLARE(), which is now too early:
  1. drivers/clk/mmp/clk-of-mmp2.c,
  2. drivers/clk/renesas/clk-mstp.c.

I have submitted a fix for the second driver: "[PATCH] clk: renesas:
mstp: Add genpd OF provider at postcore_initcall()"
https://lore.kernel.org/all/81ef5f8d5d31374b7852b05453c52d2f735062a2.1755073087.git.geert+renesas@glider.be

I don't have MMP2 hardware, I guess it needs a similar fix.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

