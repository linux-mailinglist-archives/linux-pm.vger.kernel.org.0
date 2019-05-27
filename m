Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C44A2B2C2
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 13:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE0LIU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 07:08:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33778 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfE0LIT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 07:08:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so3899079lfe.0;
        Mon, 27 May 2019 04:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Amea0yxkLSVnpaE1taY7uaOdM5gfTzcYzLxuO6OKCas=;
        b=BKs52VrGHojs+UDliJtM01DfUgVVHdsVVD5nzpm0ePBH9WsHF4xQhIyZCjdFlX9kvs
         FD9qyFI7iZBjboRFl5Bl8uFNTTibGtV6bbBqF+L8/nqI4KWZla1bXFeB/JXayox5Fo7F
         HrYumraLrj9FN3OK1AwuMZsFEgw84cK6wvRTBNtuY5OMvNd8biBtGqpCugtISBAe3nj/
         mlgNFp+R8J4ve/Vc4uj8InYRrH16hg+GIl7O1yXTNBLaz7xPkr8txyRfYFogwU2mrb5w
         A3wUlTFkWLsewA5h4zEvJTE6gnaFEkUmhmjpzV50zF13PcSKB+gi0Jpzf6ftC3eAYh+O
         ax1g==
X-Gm-Message-State: APjAAAUeXTNDE0xSOAiSALUTpYYSXqsrLsXQHulUthnOCkmduoYzQHP5
        dnQsBa28ly4aemdAFlucVLeDx5iMi8hytC46y97JlYqS
X-Google-Smtp-Source: APXvYqwcDy3XDaO0BzfXYp7vMfly1veQPO3ujWmlKLecl2HkSq5qfBAdcdVmkJpkAvRKefsRCQFJTTLWQ/j2c66om+Y=
X-Received: by 2002:ac2:546a:: with SMTP id e10mr3644980lfn.75.1558955298038;
 Mon, 27 May 2019 04:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190525120155.108948-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20190525120155.108948-1-wangkefeng.wang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 May 2019 13:08:05 +0200
Message-ID: <CAMuHMdX=o+gT6fbpZcj8jQbHi9LJci9CX72DG5j+DKYxuSkYvQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: power: Use of_clk_get_parent_count()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kefeng,

On Sat, May 25, 2019 at 1:54 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Use of_clk_get_parent_count() instead of open coding.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thanks for your patch!

> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -195,8 +195,7 @@ int of_pm_clk_add_clks(struct device *dev)
>         if (!dev || !dev->of_node)
>                 return -EINVAL;
>
> -       count = of_count_phandle_with_args(dev->of_node, "clocks",
> -                                          "#clock-cells");
> +       count = of_clk_get_parent_count(dev->of_node);
>         if (count <= 0)
>                 return -ENODEV;


Given of_clk_get_parent_count() is provided by <linux/of_clk.h>, I think
you should add an include for that.

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
