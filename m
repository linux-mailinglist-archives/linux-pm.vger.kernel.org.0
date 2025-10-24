Return-Path: <linux-pm+bounces-36772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4FC0589D
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 12:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AE73AC5C5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBBB30F550;
	Fri, 24 Oct 2025 10:16:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE83054E4
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301013; cv=none; b=nVy9RBRwzfZQHLBEJMQqzDK8/nvJK69nADtMXVtuP8L0H4MRQDrKg+80/P/So9ULCgkb42a4oHV3nA5No15b0ulLxG25f1woUeRQSOa7p5hBxk0pYA8oqRybVTYpIHXNA4JTBie1QH7dXInua8GodlYm2W9XQBE5dbSNMWA/iWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301013; c=relaxed/simple;
	bh=AqiWd9FcEXBjGqvYmjKezWFbcC8LX/8ccSI0CzYf7rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jnd4oLU8Apmx8BUWLEBQJWATldrs1fL/piSDte43LL9qbgvUYZum8juqTtEO40fXTexecENFux6F5hCIRoQH3vkFW+X5/wOEgo7dk5jzD3Yc9AYsA2fLJFOiu1Dno69VWGYTv/97Pl/6RGzKNMMF5M4mSKlv8ptWuhTp9AWN40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d6266f1a33so1189477137.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 03:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301011; x=1761905811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSTLk7b49rZYTSOotXXLR+fnDfbehF6NQgF/VSyM9XA=;
        b=r5+ceSgYcJ+TxBAEPy99yHEA4aj5YdQ/p5rdFkhW6nDCi3P0V7H/oajZ+78xjldbI8
         zLDbORv1lyXujB6g2nKwE52+YUxVB2TD/0eSm7OCtgfuZQBk4877jBwc5sywrtOdSfso
         FWmqEV9tq2G+sJI+PYzVCNephar/lehLxaWErrtWHss+c8MRZ+mlRkC0e+DH6Pdo1U9L
         rRZ/t3+WAqEwJeAmXmTPY0PU03mz2fHVVzbOabkrufSeG2+kZdhCJIiMGxEDAmSQQOk3
         ShzsqYYULZYiTbHE6uSlMQhumLh5MuRX7scBdGmVNp+8RW0LFwfO05vstRFK0VhYh7FD
         IoQg==
X-Forwarded-Encrypted: i=1; AJvYcCX6JxcDqPyABmx6mqtTrrE3NYuKA2UT4E2Q/NT9nPgrwCljxbCCVwBRAFkrKuQHYWcIU7l7q7A6zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQOCtlzaz2oaa5IwoO4ViYbc2qgSD6Z5ADwkgKiz81LUBYFYG
	FEGwu5Y3kzAEz/FggPdyGykE/IeXWgZnvoy0LEInNhfx7Mf8FCxdABGrRnUyJg+l
X-Gm-Gg: ASbGncv0M/axoMaVwlvupL1P+Qkir8qWeDdEznc+WU7wgI2wAAO0JpHvi8pn0qf6aGq
	M0gJODlRrf6Uq9HcA/YRyK/1jXNsGZMMTvECaUGYN+nSrVZo4w264uFdiUoVBkAU3oF3Rc6yNdh
	h8POBY4xVVFWDxw16+8+NJHjGEHYNsWYSfe8mtRNdcSNvsHPyUdLM2Bp7f0JLqtKPQ+DTFc6uBQ
	mpLkUdTU7w+wQLN72uMlxzsQFvtCOgJKIHIimV+zkbNya/x1RPkm9WdZXI8hJcPoOKIA8x216ha
	7kbtioBif0wNq1sMIX9Bj1wMA3UCh26+6FpWSV1KaWlDi7hfnPqVKECwAJK9dwcNDRbU14nOolM
	ba+ZgYgVU4MsobxRm6ImdC4KdWPX5KgTvCET7s/iCxnAAgH3g0YeettYoOnuZFFwyKrySragmbL
	pwVweZklN4pASk6B7S8+S7hU9HwFqIqKeX07cvMd2cFYNyuCzi
X-Google-Smtp-Source: AGHT+IHqXW6jwKdBREhngPxeFtkrsLfYl3NllXBbvzBbzJkZyB62exNtolT+a0Y1StG+3hAIHThmvw==
X-Received: by 2002:a05:6102:3f15:b0:5b1:15:1986 with SMTP id ada2fe7eead31-5d7dd538738mr7953296137.15.1761301011106;
        Fri, 24 Oct 2025 03:16:51 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934abba3746sm1948988241.15.2025.10.24.03.16.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 03:16:51 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5d980e08e06so1164685137.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 03:16:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmtBR1cNPchgNNNPQ5pUXnLS5qEaKn2pKKBg4upqytrYsJSeJdaRYJN+8lU7SBjFsa6igNEGltAw==@vger.kernel.org
X-Received: by 2002:a05:6102:5111:b0:4f7:d553:3cfa with SMTP id
 ada2fe7eead31-5d7dd53dda7mr7539658137.12.1761301010775; Fri, 24 Oct 2025
 03:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 12:16:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU9jkZ16rw90qY-y1JwReVuh9GcoU9590Qj+fnAOBKcEA@mail.gmail.com>
X-Gm-Features: AS18NWAl-mnooV2yE2ZHT2YePMkrfHPFCcWPI_7IIu3f_WOQ-qTqZQdZwGQjyhs
Message-ID: <CAMuHMdU9jkZ16rw90qY-y1JwReVuh9GcoU9590Qj+fnAOBKcEA@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: renesas: r9a09g077: add TSU module clock
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 10:20, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a TSU
> peripheral with controlled by a module clock.
>
> The TSU module clock is enabled in register MSTPCRG (0x30c), at bit 7,
> resulting in a (0x30c - 0x300) / 4 * 100 + 7 = 307 index.
>
> Add it to the list of module clocks.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

