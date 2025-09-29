Return-Path: <linux-pm+bounces-35553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D17BA9081
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A0F3A2B43
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799C2FFDC8;
	Mon, 29 Sep 2025 11:34:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9780604
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145672; cv=none; b=S/wJ+C7Ckdxk3ykXfI87S2Si1CoyvwBNLbAvVjOPBddjj+WeXc3JvdzXsstLgxLPuR4FPjqjf512jr5aKlBTcVT/zdlcQgNq6VUWbvMmKDCOg/t+QITfkFBTab+MVBlr/kfM4fSohiM/2vn1dSFokZ2T3TZ11TmE3u+FaBUjtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145672; c=relaxed/simple;
	bh=CyqsEr2YH2CBCrRlLUbTkQtjycgfh1uAGWvQeIO2INY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJGuuB3+6k+xVnlX10Wlk2ye45qCqi8a6ijjeV3AKX+BbTgf+0ny17Z46+b3DHIIDYir7Y44GUlQLSiuwWaNpXC9xZLLcOt1yNHziiz0o36yrDCb+9wbKoSrDbqzNkSC7QvNRMUzYEpB9LIoiqQmpELZWQ+CzD3dHfMUwcMhl1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5c7fda918feso1139783137.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145669; x=1759750469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxW5mXe/+NcsYxkIwV9fCeaWAATP0wBLi6jwkn7jUaI=;
        b=odDa7bM+WiuPuk/mGwY4Ih3X+ptuAq3OUK2hEIP1mzZOAaR7MESn/bQGSKYO+Ceoca
         ZzgBrluBpXgv9ER8f+WRq/3jj4YSweJPUzl7iIfjRBxhIgpQ7J1fl8pEREMGxpfeWTjt
         IXEFEOKf8JTbvlRX5iBxjXTtXQPMR8ex8ATUVF0wAUgHT2vqKxqhg70+y3vQKY2nwS3o
         GLJUy2/fCrRwAyKLIDerb+MadkV/+oxWO96l2k7lJtGJZm0BzLf+SEIiXnJbezYhVlb2
         gpavgXy2yeiaxhw2Yh5LT0k0dexLKoUA3gZsJghbmCWEqqHvo7BNrKQ5mlKiczzUk01F
         J3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXl1qKug542pBFPgKoIloY4UTGCZ8+22TF1EWjZiY58VwHhaLRQT9AaPYt9iNCqRgCxTZ2dXNnPlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJE9R0BhdzDNu+HR+Pliy1aOuXFZu/aG0ClvhP1s0XhLCWp7ag
	W9euBmxfDdX5176gKU39zqH1MXmKYvxg9rHsVEdmMYOA64iBziJrz2o95Rau8DU2
X-Gm-Gg: ASbGncvg/nWG5H4hvp+ZOkfcRawLCD+kOl8agdaKB0GxYNeE7qKd22+9ba2UuHyWGzt
	jFKSW5pI7RTVzhs6hXGC7BfduuYzm0U0+GizecgAOzkcKydcYlAU7CvfGp+UDMpjRiw0rihyhc+
	cITIqVBX93p/dn88ObhkR7+rp71S6Nwb9dCBrKtGX7AlcVk3adcz8oFfqRaQnCJw4swuqw5Yrm8
	hgfkHig2SF0RCC5+zuejI9It8IERM3cuAfrCUWQpjIGqTSq0tQTuY2LE/mJ6U7YaUTBwbtmySUE
	rSCKkTcHeIY3DTed8VV61ZyLpMAWrqkaSLsCojiwjIFzzSdo8v2PBR7WkTs7rhEdssEegs218IT
	yla2MpTCOynZDY4FhJJ5FGi3Uk9B1wnTOlesbtHbRnOAMSZ4KHD0LTcZ5fs90
X-Google-Smtp-Source: AGHT+IFpgO5JJXmraddYgJJodYQ6AaoFUSvv25r2+ZAqfEDG7wW5qK8b0EyzHl/MxDJ0NGeLTLNe4g==
X-Received: by 2002:a05:6102:292c:b0:51c:77b:297c with SMTP id ada2fe7eead31-5acd2643362mr4155109137.27.1759145669587;
        Mon, 29 Sep 2025 04:34:29 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae3b700a82sm3389231137.17.2025.09.29.04.34.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:34:28 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5a265e0ec25so3677366137.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:34:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2Oz4YzW0bohJ1daReyO2yX9FfV+XZ77r87LNMFn6AzCzhbzG/2ATFHTfErybFStJgea6lQk5LOw==@vger.kernel.org
X-Received: by 2002:a05:6102:3a11:b0:59e:a2d5:2945 with SMTP id
 ada2fe7eead31-5acc8e94d9fmr6861602137.8.1759145668352; Mon, 29 Sep 2025
 04:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com>
 <20250909113840.122785-4-john.madieu.xa@bp.renesas.com> <CAMuHMdXfN2qK-Yd=ZAaLek=UMkLK+NzdU5aFr0ET3o9m8RB4pA@mail.gmail.com>
In-Reply-To: <CAMuHMdXfN2qK-Yd=ZAaLek=UMkLK+NzdU5aFr0ET3o9m8RB4pA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:34:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUt86L1Pcui8LD=i6hyqPQYnx=Apse8_h=YyFHAeCta9Q@mail.gmail.com>
X-Gm-Features: AS18NWAfMK9KQyXLWhPAcgQzNt-Bd1yk2_D_oAV-tjfTbvXk5XD0wBN0Yq448N4
Message-ID: <CAMuHMdUt86L1Pcui8LD=i6hyqPQYnx=Apse8_h=YyFHAeCta9Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: renesas: r9a09g047: Add TSU node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: catalin.marinas@arm.com, conor+dt@kernel.org, daniel.lezcano@linaro.org, 
	krzk+dt@kernel.org, lukasz.luba@arm.com, magnus.damm@gmail.com, 
	mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org, 
	rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 16:04, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 9 Sept 2025 at 13:39, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> > Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

