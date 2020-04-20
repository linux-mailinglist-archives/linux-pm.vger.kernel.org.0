Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B5F1B1381
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDTRsn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 13:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgDTRsn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 13:48:43 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72969218AC;
        Mon, 20 Apr 2020 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587404922;
        bh=xUzIDhLrcbNY8MK4u4nZct1kwq2cE8o8IntAJsSwdpk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CFydE2rknr/Ms+qSihKc279Hhku/sxlE27vkOz7Ljm6u7pPYtYYm+HirqYmVg4kG8
         jZTLjLpS6NVw08JzOZYidmIl5sFGJv9tL37F64PGrz+2cl9ItjfypjPruwRbHTMo8B
         ccaWuhEWqwz3a67Z7TNBRt7J04CPt081UgDiTo8o=
Received: by mail-qt1-f172.google.com with SMTP id z90so9232647qtd.10;
        Mon, 20 Apr 2020 10:48:42 -0700 (PDT)
X-Gm-Message-State: AGi0PuYoOGsCijC7BUPuVbSH+sUecdxBL472I+7Vea+TQzgYWhzcq0gG
        w0tUa4sWsUujUJ2BCmszjq32hUizP5j+5L6c4g==
X-Google-Smtp-Source: APiQypLsmqqa6tPO6Vd26Z8hr0a4fVqisr+0rvULo+LKFuzNKUPn9rWtoTexXEtJsn8bhiB8U87ufUvE1XRG0ZXm9r0=
X-Received: by 2002:ac8:39e5:: with SMTP id v92mr17459679qte.224.1587404921554;
 Mon, 20 Apr 2020 10:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-7-robh@kernel.org>
 <CAK8P3a2cxU3UYSj19Rt6pcUAtA1uTiQx46MF=92q_asmMOXMnA@mail.gmail.com>
In-Reply-To: <CAK8P3a2cxU3UYSj19Rt6pcUAtA1uTiQx46MF=92q_asmMOXMnA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Apr 2020 12:48:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJS5o7_Ep50vfhNBOQ2sczgD+dNuiF8+GwjHUu7tN9j7Q@mail.gmail.com>
Message-ID: <CAL_JsqJS5o7_Ep50vfhNBOQ2sczgD+dNuiF8+GwjHUu7tN9j7Q@mail.gmail.com>
Subject: Re: [PATCH 06/17] clk: versatile: Only enable SP810 on 32-bit by default
To:     Arnd Bergmann <arnd@arndb.de>
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 20, 2020 at 10:26 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> >
> > While 64-bit Arm reference platforms have SP810 for clocks for SP804
> > timers, they are not needed since the arch timers are used instead.
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> >
> >  config CLK_SP810
> >         bool "Clock driver for ARM SP810 System Controller"
> > -       default y if ARCH_VEXPRESS
> > +       default y if (ARCH_VEXPRESS && ARM)
>
> But maybe add "|| (COMPILE_TEST && OF)" for extra points.

On a 'default y'? Not necessary.

Rob
