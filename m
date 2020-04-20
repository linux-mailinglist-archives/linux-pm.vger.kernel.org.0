Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C011B1011
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgDTP32 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:29:28 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45381 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTP31 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:29:27 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MNcYX-1jbroM3kBH-00P9CZ; Mon, 20 Apr 2020 17:29:26 +0200
Received: by mail-qk1-f181.google.com with SMTP id l25so11017255qkk.3;
        Mon, 20 Apr 2020 08:29:25 -0700 (PDT)
X-Gm-Message-State: AGi0PuZm9cQXyYsQACxxlC5TetX6iGNf1J47tllC627KVihBQYY4dki6
        uumxIMDfmBDwpdaNzWEr4CkggktH80FQsPwE9y8=
X-Google-Smtp-Source: APiQypJrsjj47rLO7etVcwIzpCXHKkPAXIea+LEbdmXIAe6seFlFpi5fTqEA4RCqERoRKbHJMRnMOJveoPM7mHMro0I=
X-Received: by 2002:a37:ba47:: with SMTP id k68mr16835085qkf.394.1587396564640;
 Mon, 20 Apr 2020 08:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-10-robh@kernel.org>
In-Reply-To: <20200419170810.5738-10-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:29:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1PFd4nb0twHsNkXJpecfWMqpyuGb+pJiMNBXwjtK+iTg@mail.gmail.com>
Message-ID: <CAK8P3a1PFd4nb0twHsNkXJpecfWMqpyuGb+pJiMNBXwjtK+iTg@mail.gmail.com>
Subject: Re: [PATCH 09/17] mfd: vexpress-sysreg: Drop selecting CONFIG_CLKSRC_MMIO
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LQ8xEfIo6TG64ypRlUq2RdlMsNrWBMdOKJIGBozJkMFSdZyhYAh
 dkOhuV4Dn0NVSfASmm7LcyXOjP/lKE0dL3hW4mBjIE1RVQj7SvlJgz8PK+RNxaG+Gd9w9pg
 CRXtrvu5KDyoAyiuIbg0zZSjjQjuwIrk+DjPMSccL7Sncn5dDH17hg3vs3Ia9tQi90+I+yS
 Li9/9CwtCZP0W/+13nBAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/2ARkDEC7ts=:D4ULrwIFpvSnVJJLKcabvX
 rE/1tKzaDQnU3H9RBtVsyFsaU+t4OwBTcl8CMN1cGS5Df8luGfSuIqJU/g6jy/5UO/ssL1uK1
 NdIymtJIgbyQ4Ow7JR63E/ucim7YljbEi4NthzVSvU1E8UOT1PMlMW6SsKK8kf8vI1nytZZGd
 wu+m/Kw2uyumFYmUrLj5amJZFVSx/BXkMuDPL8XNyJ+W+BpcL3fkRzvWE1bVWjwJbSfwNG3Ex
 lNjWGYQRzZfrZjtKAwILQ2xcV8RJdVQ2IhVp3wH0t2GttDY5d0b/gi5g0wParTBgmWjITKX8M
 xDJkwHvxK8dmRmm5WHemmgSqyEufH5gTGbtSLhNQ7MQ42cDI7WzEXWfe1/6HBPPvaimFQCn3Y
 oM6EJZc4SrSkuQCD0lNNadJ83Ms+GkbmgPrBrJ9TioUUlHda2XhzsTD0qfSbzQdjlz3cWyhLj
 n8X0O4BYYSw5yX5XJaWzTTmQeXD3PYR5IgsGyHktvu/8gkY2AS6SOve6b65XQwHS2D98dxDTO
 YuBG9UDfnfbGYgyeOhndXDQf33OtXCrd8wBolyerz+6otvsCyPZxFxvM3GMyiHaDKvSoIPgtt
 2oHQOC+WN6PnmvT7V5sQF397w6YclUstMH/FevSBcVOkrB38Wjyf/PtndFC79vjeedJwgMKee
 xlBuhO149hJ/KM6LaZKyvgfWS5E3xuWjP2+ybhwGE0QA3ND3deHj2bQoktIgZWfoETYYmY0tR
 YgGkObwMMaHBLu960jzgafPXhGYIdLs7j1euYoPYz8N15n/zOZe/DvPwHVJh5UH4jMKIRuYP4
 Ta6TYLBiak9C8G3tMnTS8yYrrb1nTzEKWVlhjE7KUoDHMdExkc=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> Nothing in the VExpress sysregs nor the MFD child drivers use
> CONFIG_CLKSRC_MMIO. There's the 24MHz counter, but that's handled by
> drivers/clocksource/timer-versatile.c which doesn't use
> CONFIG_CLKSRC_MMIO either. So let's just drop CONFIG_CLKSRC_MMIO.
>
> As the !ARCH_USES_GETTIMEOFFSET dependency was added for
> CONFIG_CLKSRC_MMIO, that can be dropped, too.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
