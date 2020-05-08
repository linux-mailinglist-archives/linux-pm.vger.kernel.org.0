Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F591CA784
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 11:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEHJua (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 05:50:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34149 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgEHJua (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 05:50:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so1021262otu.1;
        Fri, 08 May 2020 02:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5uVoI0n1KNv3+qMlrWZ83amX0u3Zd89agbuvXvX3BQ=;
        b=qbPvHki/Wv18tvrl8EQOd1ZRDvlHWTq4ZDp+fUml6O95rT7/UaAiNlj7ZQzgLx8JoM
         y/90zprZl8FcPHEPvgC/1p+C49XjWmWqBfq8VwIcpNH6BBAYqU7lYxg6z513WEbl2JwV
         sJStmpQyVxCxHKl3JT9c34snsMNR+7peb8if8T0pazVFDEZAp5Ju/UhptyYqelBGSkOt
         SJudahLfv7aELCYLTYpg9A5BK3kY8HweEuo4Rd7xexc4TOk39uFBrEGFw/6Gtzkn2m9z
         fTA06fSO1uVrIpAd4klzfBqcRSOgE2tg1Ijnk1+Ia7OFuL5JZFqiGxlSqlwO3hPAvr+/
         KX0A==
X-Gm-Message-State: AGi0PuYrDlyaOPJEhk5+EqdepZFIsDIYYXE/FFgdKYXfB5dZDjUdPfJa
        uJFhXncywZKHpX8iwcfsBCXG/5GUXqWuqH9NIOc=
X-Google-Smtp-Source: APiQypJDV1otoOypylweOFXXW3dlZCPcQtNptWZUNfsC5d7jBL5atkxkLBTRUMF45BNs9jbOlY8aKBznw/nCmv1aAFM=
X-Received: by 2002:a9d:63da:: with SMTP id e26mr1325383otl.107.1588931429037;
 Fri, 08 May 2020 02:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200507112955.23520-1-geert+renesas@glider.be> <CADRPPNTdv3R4t7JsjGuPP5h5APA7vcSMNK1vJMjzPtGw=Uw9-w@mail.gmail.com>
In-Reply-To: <CADRPPNTdv3R4t7JsjGuPP5h5APA7vcSMNK1vJMjzPtGw=Uw9-w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 May 2020 11:50:17 +0200
Message-ID: <CAMuHMdXvHwZ88hhLzKcEW-tFCFiGdWBaABrirG3k1a9Y1=M_2w@mail.gmail.com>
Subject: Re: [PATCH 0/4] qoriq: Add platform dependencies
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Li,

On Thu, May 7, 2020 at 11:58 PM Li Yang <leoyang.li@nxp.com> wrote:
> On Thu, May 7, 2020 at 6:31 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Several QorIQ blocks are only present on Freescale or NXP SoCs.
> > This series adds platform dependencies to the corresponding config
> > ymbols, to avoid asking the user about them when configuring a kernel
> > without support for these SoCs.
> >
> > Most patches in this series are independent, but the third patch may
> > cause some Kconfig warnings when applied before the second patch, and
> > enabling the QorIQ CPU frequency scaling driver in a non-Layerscape
> > kernel.
> >
> > Thanks for your comments!
>
> Thanks.  The series looks good to me.
>
> Are we trying to merge them through the various driver subsystems or I
> can also pull them in through the fsl-soc tree.  If we want to go
> through driver subsystems:

"fsl-soc" is safest, if maintainers agree, due to the weak dependency the
randconfig people may notice.
Note that Viresh already applied the 2nd patch to the cpufreq tree.

> Acked-by: Li Yang <leoyang.li@nxp.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
