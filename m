Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4C31D1A2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 21:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBPUec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 15:34:32 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:43729 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPUeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 15:34:31 -0500
Received: by mail-oi1-f180.google.com with SMTP id d20so12569066oiw.10;
        Tue, 16 Feb 2021 12:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SckgAh/+jPmp0yNvSHKEdHbO4vysHXL5ojv3MhSdbzc=;
        b=KKSElomRTJrzBrrearbunv+rOCe8JYuNEkuRFqhf1o57Szxqkm3ICrf2x4s4S7fsh0
         f54YqVqO2kyp1fSfX7/ftqYm8tMUZTPeStYobutmBrEIW6iZT4HmWnbLWKT49yZ+caav
         VK7SmZXWC8+yyqpL5853Nwo9+5RM7u0GOnTon//J7v8GPQO47UBclRjJiLBmXcilYSNw
         YEue3hwK2/JW0OF4VrOl0RV2ZMnjTsXDis/GS+OjSsZ2maddRf/+fOZkUUOheagELMaj
         zeHVI5RtUnOkb2RUnropzFuDSnYyrpJkwkgCneoU3vAIQ4sLqZE8BO3Dihe5LrXRTdFt
         vlMA==
X-Gm-Message-State: AOAM530dejuPIGnJKGm+qsdXXtVEAt/6fqXFTEY+Q36HEHBHiSC+Keb5
        OqXcxUiC+VhfgV4+nDQ0Ih5NidkXNZhs3R/TxQ8=
X-Google-Smtp-Source: ABdhPJyZE1MGdELiCoijLBBkIxYpdSgDMV2rBV4TNuua1VMGf1JhbvfJO90pNBvSJf7k9MB6wKFpdqGlgCvODv6w1Ws=
X-Received: by 2002:aca:d8c6:: with SMTP id p189mr3784710oig.54.1613507630086;
 Tue, 16 Feb 2021 12:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20210216123958.3180014-1-geert+renesas@glider.be> <CAGETcx_YeiNAMkSxtbTSZcsQugxK4=CwhR6UfbSLLHzQ2EfguA@mail.gmail.com>
In-Reply-To: <CAGETcx_YeiNAMkSxtbTSZcsQugxK4=CwhR6UfbSLLHzQ2EfguA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Feb 2021 21:33:39 +0100
Message-ID: <CAMuHMdXeR5UkEOjNNHscQX+vCxMFEW-r6FXn14s+mtKDXsbm_Q@mail.gmail.com>
Subject: Re: [PATCH v2] soc: renesas: rmobile-sysc: Mark fwnode when PM domain
 is added
To:     Saravana Kannan <saravanak@google.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On Tue, Feb 16, 2021 at 7:26 PM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 16, 2021 at 4:40 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Currently, there are two drivers binding to the R-Mobile System
> > Controller (SYSC):
> >   - The rmobile-sysc driver registers PM domains from a core_initcall(),
> >     and does not use a platform driver,
> >   - The optional rmobile-reset driver registers a reset handler, and
> >     does use a platform driver.
> >
> > As fw_devlink only considers devices, commit bab2d712eeaf9d60 ("PM:
> > domains: Mark fwnodes when their powerdomain is added/removed") works
> > only for PM Domain drivers where the DT node is a real device node, and
> > not for PM Domain drivers using a hierarchical representation inside a
> > subnode.  Hence if fw_devlink is enabled, probing of on-chip devices
> > that are part of the SYSC PM domain is deferred until the optional
> > rmobile-reset driver has been bound.   If the rmobile-reset driver is
> > not available, this will never happen, and thus lead to complete system
> > boot failures.
> >
> > Fix this by explicitly marking the fwnode initialized.
> >
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This is v2 of "soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
> > reset handling".
> > To be queued in renesas-devel as a fix for v5.12 if v5.12-rc1 will have
> > fw_devlink enabled.

> Acked-by: Saravana Kannan <saravanak@google.com>

Thanks!

> Keep in mind that this might have to land in driver-core-next since
> that API is currently only in driver-core-next.

That will be resolved once driver-core-next has been merged in v5.12-rc1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
