Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BCE59AF6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 14:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF1M1h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 28 Jun 2019 08:27:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42742 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1M1h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 08:27:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so5976840qtk.9;
        Fri, 28 Jun 2019 05:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ppny6xJCt646j++LO33+1pCmnnu1zTgRuTHxRcFV+aw=;
        b=O1Cln50Z8oUEsXbFW8v/llz6aXYOONKfB8+d0PANixefiFwI0sSRV0QcOh6q7Rr+K8
         6Ak4kVdhgWGNO9cu+YpaRCbsKM8ogbsCkL9l+c25VMP/1JDcV3z34xGvCv0KAwW/WJkr
         iDicKCKoQ3lvlloUda+OAzEcQZdpNvJ4jI1/P96hdzBUMra/yLWbSw2rVwTelKmNxkJs
         cFpRHC9bg2lRSqbgAYbccn9vBpTRVC9+fopUEexJYj2So8hiPTrWAAZqnyI73kYPADfZ
         kKOeyq3KnSxwRRZ1TZfuvkl7UpftPxgwY4baxW9KNAvmi6UpRiNlFNSe/6PZoGDjuFRi
         k6lg==
X-Gm-Message-State: APjAAAXktbNL6KGIpG71zG+cYNWygLQbFK+h2JXZmdaJq6l82OcPyXUV
        MidGXvMRF3WbuFMe391DPpcLXaaMZMhTQgAe11E=
X-Google-Smtp-Source: APXvYqwr2vwCpn2kRP+1zPIHVxHuPOzGXcvzYVsZ/3G+jveBzmpxiR6DdGaj+anvfnaGuYZJ/nq41D/Hp5JMS6dP3HM=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr7600258qtb.142.1561724856279;
 Fri, 28 Jun 2019 05:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190628103232.2467959-1-arnd@arndb.de> <c2701295-0fd6-c5ec-59d4-6e6b3b3bdb8e@gmail.com>
 <cbf6cff3-f5f5-66ea-9cca-86eb93f23c50@gmail.com>
In-Reply-To: <cbf6cff3-f5f5-66ea-9cca-86eb93f23c50@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Jun 2019 14:27:19 +0200
Message-ID: <CAK8P3a1HOOk48G+-wZGWrM_fg5cn3ytH66qaEU6c7e0BjW+SNw@mail.gmail.com>
Subject: Re: [PATCH] devfreq: tegra20: add COMMON_CLK dependency
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 28, 2019 at 1:05 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 28.06.2019 14:00, Dmitry Osipenko пишет:

> >
> > How is it possible to happen? There is a stub for clk_set_min_rate() when COMMON_CLK
> > is disabled .. Could you please show the kernel's config that causes the problem?
> >
> > Moreover that was me who added the missing stub for clk_set_min_rate() in [1] to fix [2].
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/clk.h?id=b88c9f4129dcec941e5a26508e991c08051ed1ac
> >
> > [2] https://lists.01.org/pipermail/kbuild-all/2019-April/060292.html
> >
> > So this patch looks wrong to me because apparently it fixes a non-existent problem.
> >
>
> Oh, wait. That was "implicit declaration" and this one is "undefined reference"!
> Still looks like something else need to be fixed..

The stub takes care of the case where there is no CLK support at all, i.e.
CONFIG_HAVE_CLK is disabled. However, some older ARM platforms
still have a custom implementation of the API and lack clk_set_min_rate().

$ git grep -l 'EXPORT_SYMBOL.*\<clk_set_rate\>'  | xargs grep -L
clk_set_min_rate
arch/arm/mach-ep93xx/clock.c
arch/arm/mach-mmp/clock.c
arch/arm/mach-omap1/clock.c
arch/arm/mach-sa1100/clock.c
arch/arm/mach-w90x900/clock.c
arch/c6x/platforms/pll.c
arch/m68k/coldfire/clk.c
arch/mips/ar7/clock.c
arch/mips/bcm63xx/clk.c
arch/mips/lantiq/clk.c
arch/mips/loongson64/lemote-2f/clock.c
arch/mips/ralink/clk.c
arch/unicore32/kernel/clock.c
drivers/sh/clk/core.c

We could in theory convert all of those to COMMON_CLK, or simply add
a dummy clk_set_min_rate() for each one, but since there is only one user,
my fix was simpler.

       Arnd
