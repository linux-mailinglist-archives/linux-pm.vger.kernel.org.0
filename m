Return-Path: <linux-pm+bounces-36889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D2C0D052
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88C354E522A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856B2E8DFC;
	Mon, 27 Oct 2025 10:50:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B12D5C68
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562233; cv=none; b=FCRYxXgcMQJvlEkNXhXrxBCjhf24BUfCvYkiED4Ir1VfGg6RdGI5bsfyed6pJhHHyY29TqQCrCclrf3J7oA9C87kSHRGa95fOZGZQwisB5f8WybXZz+QZf3qvSIQFgc0AzE/BfUFwq0HGr1b86leyKAwVjHwJnf+Q85Z7AUk0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562233; c=relaxed/simple;
	bh=WASv8vPf9FPyquyQDbPoOdROvffB+ReSLfQNpiWjqIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiX0MYHsomaale135aZ6PignXOGudkTXAxQ9mh+fdCULFXPneazkAkHxOpa4o/RebGjyA83hOWZ2HuRi1BnnHcC+3pdcSa+CqMZK6cuz0Y9KuRpApilmSMGLXZ83+QXyXR1FAHIAT9VEjm1l7CP3ezErww6K77Rje2eEDxxoy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-44588e94decso2223342b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 03:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761562231; x=1762167031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFi78x1MtIeYqpVCKC1DBSPNonZlJu7dJLYb6jM72vk=;
        b=qk2TVSGCq4fA8jpWzpHKtJvdkYrX9RaGASZi5+Z9kKNqb/q0YnsUf1+3PXTjqbUFdp
         nSOoZhttqnONgoBEKiClqn0BSNuahtcFtA/PyqnDm0trQdtPxkzZCApQ17etAY+PSGCt
         u+93oxYxHgKyG37GBaELmBeKwiNn8CUtcrAIP/+It1L7KHraGbtmzlKtVnNZTxTQ3clV
         2V/0mr6tV5zscbsYCpKIyUfniQ/nmAAj1EwceranNyo6l7N3lZ5iu+MTZ/zJ4MUC1HX2
         XWpWCd0vlkWygftF5cqLYEtyT+tMfyI0ogmGHatg7jrgXuXm6GMiWi5qB2O7Va7LOMUS
         1DPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoQY4JkJTwq2TcmI7ZIFND1rAQvFvJNIyRlMkMHJP7SnUU0JIiR6HPNBx/819/r2Sx4Fa7SfRKDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/hjwQuLysnJHd6OzXyp0GXx5KML07AkobPQRmMhgYq+8c59/
	5oqLem1Bv41OxrZh62ZXAA6Sdgt9KSGLGZwIZg7dQeu53iPV7NakBdhoUMuuDw/7
X-Gm-Gg: ASbGncus4UFqvjk5r9UBv4s3Al6HPrpC5kuQxXA17HwxHRy4/CsBlWbpHcIcXNMtVKL
	t5vbAgo0MRv/LzyXQK83WcHzQPQ9GDuXsR6LQy0LHPboSt/mkWJWirww4oPZ7QI6FlKFiTjv+dj
	TTJumsWcp56vTtrpH5y+cdIy8xkGGmLEzSrsVQ8rz+e/YtdCKtAmRV904P2+cApnfhx2pgIEtLw
	WpICtTyS5OP64GewylVK4Rglu2Gm/YokoLi7F28HtjBra5eLJnBNwOhq/CY5f8PRa3Gz8XzjeDY
	6fSU6VdUYTST7UyNhLiAhrs2LDNv/jgLEIIxDHxWdAcF9jwO0v4Q8YRTYN0a7dyKtYz7k2r1e0N
	urI/GiLTVM9GfeYiUfdMS8x+cJTHNvkBHzqZHREvBDXhb7mDZls1Srys0wkBxM0scfbxQ876659
	7z+Cqkj7/usXmpfBPvrjgMBWqAKOkQeTa/0QDgtrlg5gWqKLoP
X-Google-Smtp-Source: AGHT+IEo/cY5vGVyGplINpKJ46Ka3bFd+4uhCCdfMxVLwWsEyKmxT9rOoFlMFf6ATHG6iz21FoLsRw==
X-Received: by 2002:a05:6808:a612:20b0:44d:c2fb:c0c with SMTP id 5614622812f47-44dc2fb1035mr505106b6e.31.1761562230901;
        Mon, 27 Oct 2025 03:50:30 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44da3e765a9sm1672078b6e.12.2025.10.27.03.50.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 03:50:30 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c53a8d1e42so1181633a34.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 03:50:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWljmCUFDzmd1GCgH/XjYYGGSp+LzYl4F8cKYPuXU4TpTUVkgKZgF1oUUYIXEPwDq5f2RFe02AKQ==@vger.kernel.org
X-Received: by 2002:a05:6102:30d2:20b0:5d5:f6ae:3905 with SMTP id
 ada2fe7eead31-5db3e25962bmr2803354137.22.1761561924836; Mon, 27 Oct 2025
 03:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251023081925.2412325-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Oct 2025 11:45:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnom39_Rj+6Jc2g69i+Z4V7UkfXT791buK3h9cpOFpsQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnn-hFWk4Ur68Qi3gdEa85bXZjpybdjIi4iorAZW0HIZJSSUE0PNnuk68o
Message-ID: <CAMuHMdUnom39_Rj+6Jc2g69i+Z4V7UkfXT791buK3h9cpOFpsQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: renesas: r9a09g077: add TSU module clock
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 10:20, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a TSU
> peripheral with controlled by a module clock.
>
> The TSU module clock is enabled in register MSTPCRG (0x30c), at bit 7,

MSTPCRD

I will fix that while applying.

> resulting in a (0x30c - 0x300) / 4 * 100 + 7 = 307 index.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

