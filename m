Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE61401EE0
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbhIFRGZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 13:06:25 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39877 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhIFRGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 13:06:22 -0400
Received: by mail-ot1-f46.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so9463200otf.6;
        Mon, 06 Sep 2021 10:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWSkQkSt0bxIWZikjyNv1yc6a2mBNyIggcCEjOgf7nk=;
        b=h8jegpGdYZGD22NG/QMUwQ947lZ7fXcYLoflwSGc8VkEz1oLstIrsONdFLBi6NkZZ/
         dRmzkjds4F4GSu69leGD4/onRNXK/PJJX0KaNV+8R/ommh8Kz9qxiQpbB3JlwYqiJVml
         YDfYKtMEhFAnNvJmks7l+EmxQUHGPiwmJaNk6oNxnPr1bLIC5oeHTKS0g6IQSVeV28Gd
         Brp8v38dtZPuknaRGpDeeeAgwkVcpIFIdjDfBPryb1p/GF8u4e6ePuxD1LcfLeJxuPI1
         OUZLBHv+fKru6wFFUhLc/7QIEYjeqOGcnBEd8vEi/20B2a19wP7ScIleY6ommeWMhywq
         yuVg==
X-Gm-Message-State: AOAM532RuPH/GgS6tS/+ERoKWW8bPEyvEK4hRl4X+aT53InkQY/FeNv0
        iImwnILtRd7E3WA693R6o07RhfQx1xXx4CnmzYA=
X-Google-Smtp-Source: ABdhPJyX4pJ82lhruFxtVqo76a/SKXbQN1Ot4TUHTDaQfC+AMjsTShGS3vOfZirkAgS56YQITo1F5aLqKIHvTkr7q0M=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr11983974oto.301.1630947917061;
 Mon, 06 Sep 2021 10:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210904151628.6618-1-len.baker@gmx.com>
In-Reply-To: <20210904151628.6618-1-len.baker@gmx.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Sep 2021 19:05:06 +0200
Message-ID: <CAJZ5v0inR2Sj3cRXYa3ip3hG1-1Gbv3QHExQmGO12AJmUjYB5w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernow: Prefer kcalloc over open coded arithmetic
To:     Len Baker <len.baker@gmx.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Sep 4, 2021 at 5:16 PM Len Baker <len.baker@gmx.com> wrote:
>
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
>
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>
> Signed-off-by: Len Baker <len.baker@gmx.com>

I'm assuming that this patch will be picked up by the powerpc arch maintainers.

> ---
>  drivers/cpufreq/powernow-k7.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index 5d515fc34836..a9d2c7bae235 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -174,8 +174,8 @@ static int get_ranges(unsigned char *pst)
>         unsigned int speed;
>         u8 fid, vid;
>
> -       powernow_table = kzalloc((sizeof(*powernow_table) *
> -                               (number_scales + 1)), GFP_KERNEL);
> +       powernow_table = kcalloc(number_scales + 1, sizeof(*powernow_table),
> +                                GFP_KERNEL);
>         if (!powernow_table)
>                 return -ENOMEM;
>
> --
> 2.25.1
>
