Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9028E04F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 14:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgJNMLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 08:11:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42932 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgJNMLB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 08:11:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id 16so2952925oix.9
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 05:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vy+CIRKYFspt23vbrjzY62Tg4wgtsK2yuASr3nBZy2I=;
        b=T1QL0HT18GCCPMfUr0lkmfzpgbpA9OLyNVP/QLfdF6Q7QPkk7jTmmDt0XItHAv58Jl
         YNcd3Bk+cHxqUasEYChyDY8fa9YIocpsjN6t4IJtXpcBspritBLB1jLlisx7ift1wyY6
         y3O33wTDdwPj8/L1p0p6HCkuXPnrvAxuqxLtoYQLHMbq5Jvd3tmRLXUdnx0f9xBjfJuo
         NFPyJfQIuPt3E3z2cbg6Lbm/vUFBj628/XA8rKydXbwn8w2+MGF98HWO2lq0rAlw/Xbn
         rSH7eTT6w5ODdi3gLjhRRjfp8dulF0qmWGJGAQ7A7XF9TXw1TxOJLxNJHqR2994/4YBo
         YRaA==
X-Gm-Message-State: AOAM530eJoXawHpOeNVLQAbjunkVhZH/aSuq+/ZtIjioDxCQrn2eQBEz
        kPbuaYfMjRYMaYfSMAB03M7BYZq2uaJJonbw9g0=
X-Google-Smtp-Source: ABdhPJzI6fyRSpjirjbpoWkc96upTOmICEPSblETcOibfej8uK0g3JaYoT3Wc9hz/GOH3Fgex5ijvoYqy5v+XyHiWaQ=
X-Received: by 2002:aca:f203:: with SMTP id q3mr1846253oih.148.1602677460311;
 Wed, 14 Oct 2020 05:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201013141459.28599-1-geert+renesas@glider.be> <CAPDyKFo6Owf92RmP5cofuz97WNWJ--iwYgNw-3svvRsWt=Fc-A@mail.gmail.com>
In-Reply-To: <CAPDyKFo6Owf92RmP5cofuz97WNWJ--iwYgNw-3svvRsWt=Fc-A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Oct 2020 14:10:48 +0200
Message-ID: <CAMuHMdU3FDVbWdj5NFAeP9sUrK2K74uHex7tQUmodOfyg_4X0A@mail.gmail.com>
Subject: Re: [PATCH] PM: Domains: Add curly braces to delimit comment +
 statement block
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On Wed, Oct 14, 2020 at 11:39 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Tue, 13 Oct 2020 at 16:15, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > There is not strict need to group a comment and a single statement in an
> > if block, as comments are stripped by the pre-processor.  However,
> > adding curly braces does make the code easier to read, and may avoid
> > mistakes when changing the code later.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I assume that this is the only place of this pattern in this file?
> Else, it seems like we should fix them all in one go.

Yes, only one.

> Nevertheless:
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
