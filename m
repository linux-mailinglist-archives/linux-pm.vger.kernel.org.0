Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE41C9DFF
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 23:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGV6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 17:58:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38116 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGV6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 17:58:05 -0400
Received: by mail-il1-f194.google.com with SMTP id c18so6804683ile.5;
        Thu, 07 May 2020 14:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GI7tbDeUUOEa56ks8zKfYc4C3uORKh3Rq+YHa4B8fIs=;
        b=lp5r0bNPyWv3GAesA97nDseDd3FliLrzwb/rNcOECzveb5UExPmBt7/cVbULtfoaln
         ucmtdQG/+jF4pLZc+T77beljpmyvFQo7bkXmh/pVWQMM7KX7mUbuEfTcSgJOtCD9T9jp
         +qAjSj7F4tEKvNG4KFUQ8QXeNH3+4AoKQviQNVBTzrlRFa/llrJvY65EjmOCz3mvyQom
         dYEFe2Jt6yy4VhinChDTi1TyRcRixL2sPMHX4/9Hz0PirI54f4RtYvyLwjYNDjRt+cmv
         twaZjeYLmD0ETkpah+IxWNz1dM51QXKEL4Ybvuzs5rxgPE2OsLR9ORLuL20t0KCLdlLn
         JiFg==
X-Gm-Message-State: AGi0PubJ2vc4y+Jkl2ZdWcAueoVF0hbld2VIxB06VTpakXOwgbEnLNLE
        QA8OoVcU+4jnvSMFD2qydNc5EMvPO1I=
X-Google-Smtp-Source: APiQypI+iDElsr2p1ZHpOctO/W21HEtkb++o96IuKTURr/XhzdkfhcqL3CM10Waq1sixCES6+TeJTg==
X-Received: by 2002:a92:1d4e:: with SMTP id d75mr10484005ild.235.1588888683969;
        Thu, 07 May 2020 14:58:03 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id 7sm847683ion.52.2020.05.07.14.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 14:58:03 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id j8so2243161iog.13;
        Thu, 07 May 2020 14:58:03 -0700 (PDT)
X-Received: by 2002:a02:cebb:: with SMTP id z27mr16202135jaq.32.1588888683009;
 Thu, 07 May 2020 14:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200507112955.23520-1-geert+renesas@glider.be>
In-Reply-To: <20200507112955.23520-1-geert+renesas@glider.be>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 7 May 2020 16:57:51 -0500
X-Gmail-Original-Message-ID: <CADRPPNTdv3R4t7JsjGuPP5h5APA7vcSMNK1vJMjzPtGw=Uw9-w@mail.gmail.com>
Message-ID: <CADRPPNTdv3R4t7JsjGuPP5h5APA7vcSMNK1vJMjzPtGw=Uw9-w@mail.gmail.com>
Subject: Re: [PATCH 0/4] qoriq: Add platform dependencies
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Shawn Guo <shawnguo@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 7, 2020 at 6:31 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> Several QorIQ blocks are only present on Freescale or NXP SoCs.
> This series adds platform dependencies to the corresponding config
> ymbols, to avoid asking the user about them when configuring a kernel
> without support for these SoCs.
>
> Most patches in this series are independent, but the third patch may
> cause some Kconfig warnings when applied before the second patch, and
> enabling the QorIQ CPU frequency scaling driver in a non-Layerscape
> kernel.
>
> Thanks for your comments!

Thanks.  The series looks good to me.

Are we trying to merge them through the various driver subsystems or I
can also pull them in through the fsl-soc tree.  If we want to go
through driver subsystems:

Acked-by: Li Yang <leoyang.li@nxp.com>

>
> Geert Uytterhoeven (4):
>   ahci: qoriq: Add platform dependencies
>   cpufreq: qoriq: Add platform dependencies
>   clk: qoriq: Add platform dependencies
>   thermal: qoriq: Add platform dependencies
>
>  drivers/ata/Kconfig     | 1 +
>  drivers/clk/Kconfig     | 3 ++-
>  drivers/cpufreq/Kconfig | 3 ++-
>  drivers/thermal/Kconfig | 4 ++--
>  4 files changed, 7 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
