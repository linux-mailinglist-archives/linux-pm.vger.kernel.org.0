Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8FA1B1006
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDTP2B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:28:01 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDTP2B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:28:01 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M734j-1jJ5wf3d2V-008ZSI; Mon, 20 Apr 2020 17:27:59 +0200
Received: by mail-qk1-f182.google.com with SMTP id n143so4212967qkn.8;
        Mon, 20 Apr 2020 08:27:58 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ3NjxTMMZbK3nWWi2ZpaXKqSWAawQCTP8Y566k6eyQUjQKxFbV
        sSa13GOAg9trAZ1//d57/+xkcHd+4tH3lS/yWuI=
X-Google-Smtp-Source: APiQypJ9pD41SHA4YqZ26+ywa4U01IE4ciwAkSIgNt47fRb1f2l+iHjSl7wCJvDBcQZG4zXYvL9DrNYc/cuTbzBQw4M=
X-Received: by 2002:a37:63d0:: with SMTP id x199mr16095453qkb.3.1587396477662;
 Mon, 20 Apr 2020 08:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-9-robh@kernel.org>
In-Reply-To: <20200419170810.5738-9-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:27:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0YmD6Ay6t=Wxmugvg=YM0fCtetgnqz1vTYs1rFD-9TFg@mail.gmail.com>
Message-ID: <CAK8P3a0YmD6Ay6t=Wxmugvg=YM0fCtetgnqz1vTYs1rFD-9TFg@mail.gmail.com>
Subject: Re: [PATCH 08/17] clk: vexpress-osc: Support building as a module
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
        Linux PM list <linux-pm@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9cChum/rz+BP5UaqnZCmNn4Hz94N9mgTG7kVMHM8MWFSXqBgprL
 WOtIk8NJDKQp0ruXLhuYPyy/EPdwgzoI688cxs2q9/lnyDWq9WcAuqLfo0mv70yw2ANG7f/
 mvIfwoNGL25ztSXOGKsRgXAqDoVZNQrCk4P/EvPVDOFaruHzCTbFRbVQ/7kYhGCpONAThyR
 NcR0jmve6gh3a10k78N4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qVso3vvuvOY=:9sPBB6AzauULEKvfa+pe/Z
 3nqUT3PbfIMjDt3JDaJWCSXtE4vQ3wRwRsJgHWTf6TPcK5vfGE+kUPHh1yX4E1wjFCJc4mK9E
 zfTIkHc165qYg7E0hboPZbcckU7Qtt3Lg1MYoTlmfc0tSS4KiA8639PChpbhyyjZKffz8kKLw
 Ajyq+ps07T17V47nbildrUnwIwinuH5xGETJF5TyB26fyemv1Zt2a+geruRS0hS0/J8rs5vHi
 LFeovlqxUleQcK6vvQ5flKgqjZSliy3cMf7pDRVxbMBNXsDJ5A2M0JvsrzP89W3PQpr/Pn9zN
 RJI82IxV9HRUHqo/0o1UL/S1zcowDK/lx6qRCGNWhfZJpvep8FgDvd8xTFOtbZxSNon0WYrt1
 XXoz6vzkwfsFKLbg26R6coh/An+uQCHb5onanI7VYRo8mdoGqCqXaHjomJD5YO+4UJ0yO/vU3
 Ig2tbJMcKdCROZ2FmeQo+N9JhvK7aAz/rYdhhw5K5WiaQe/KP5Bnr5lIj9U0pTB8rSqxejtDy
 zX/B77vXpG3Z9VspqLyZxPEtHFRKfwLKs4QsiXkvXxABNUCFhwFD7LU7sNSLjtv4PdYTxp3Ce
 1qXlcmRhBZrX/sHCo86jf9+nyhL77S8oTv4A54zldYfsmwSqYpcla4fTm/bi7H9dPVkAeyLdd
 xH/M1k0TQLZXC6UIrw8Oxx0rEOk39Ybv56qZFUnzPjBVafJqmtY3ayp9pYfLw7aDOO1mLHBYT
 RqQvErE7YOTsz46UlGVt1dAOM4+GWMZ+Tizc5zor3zEBN/BXysOmwx5WhMx4aEbZJSyUxlMmk
 kGbgQmlX8k64VjuNAsIFr2RrR54Xd0A0gyABPFzl8QCpnpBO/c=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> Enable building the vexpress-osc clock driver as a module.

>
>  config CLK_VEXPRESS_OSC
> -       bool "Clock driver for Versatile Express OSC clock generators"
> -       depends on VEXPRESS_CONFIG || COMPILE_TEST
> +       tristate "Clock driver for Versatile Express OSC clock generators"
> +       depends on VEXPRESS_CONFIG

Why do you remove the "|| COMPILE_TEST" here?

       Arnd
