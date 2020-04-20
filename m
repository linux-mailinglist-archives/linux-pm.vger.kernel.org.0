Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D304A1B0FF7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDTP0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:26:23 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDTP0W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:26:22 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MplPf-1irye93rfJ-00q7k1; Mon, 20 Apr 2020 17:26:21 +0200
Received: by mail-qv1-f42.google.com with SMTP id h6so1328804qvz.8;
        Mon, 20 Apr 2020 08:26:20 -0700 (PDT)
X-Gm-Message-State: AGi0PubZcE35yq1DF5oySJFcJtRxYr/qNEaeAYdwtkxYYB9c8WXPxfCm
        ZbZgMJ9WnN4WzSV1z6qgvCriQH9HY7EyB8n+6tM=
X-Google-Smtp-Source: APiQypJv5lK+3PbfI3zap38BiUd40Fgpk/tqlJevSMUnFeFtj8JD1Hr7NFYfNentqq7/tvrPz6zsYwzBa30IvpR9xJ4=
X-Received: by 2002:ad4:4a8b:: with SMTP id h11mr9578757qvx.210.1587396379754;
 Mon, 20 Apr 2020 08:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-7-robh@kernel.org>
In-Reply-To: <20200419170810.5738-7-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:26:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2cxU3UYSj19Rt6pcUAtA1uTiQx46MF=92q_asmMOXMnA@mail.gmail.com>
Message-ID: <CAK8P3a2cxU3UYSj19Rt6pcUAtA1uTiQx46MF=92q_asmMOXMnA@mail.gmail.com>
Subject: Re: [PATCH 06/17] clk: versatile: Only enable SP810 on 32-bit by default
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
X-Provags-ID: V03:K1:bBz6GYGP8aR+k3ek8N0TRzxBYP6+RqOopCXP2Dopyn4tdlnQAB3
 8peXjpz5RcMpvKR5fgil52r3204gUTu90GnX5YEloj55bKgSKyV7ANjIQcReLxVWhMIOKOr
 XjYluBoCHDfYm+pP7bLkz9bmuXCqJRfqrX1KOweO7B2jKo6VI5+LYy/4i4YjL4ncHACq83l
 vzg6OfOnb+OpDgCen7Byw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sX7ICOpxPMw=:FMFGpCnrA0P+w9NGoCO6Bk
 aMGZNEMH/7pV7eH9whEn8zLR728gJjPiBywcC37MBmb0Nn+or+0EBPGKohxyMogSoVhxAG5O2
 linzMbGkfiWsa099a4D4c+9CBpiYwRfbUaW15QPkeg2N1wOEpT5q/QL68qJ/nnV5o3VNA95EK
 1IyHtC3811ulhtPCpSR4E89Cs8w27AQDW2CCVk534YtHVWKZkVX+TeE08vsGqTUI6hqSWS7ks
 h1WZPx/b82yCKzBaevvn8Ssm9TKyWun1yemQgJr/9oUwNsZL8iJZd6zX3yrHe4qYSBDUhvypf
 OZ1lmG+TL6eCAPzHVngKRFykECiZT67zq63/6HxqANLWWdY26Kt4lKW0Vprc/nljpcbF9bg2c
 B7FcfOFnO7zLc7VIc3WexPeYTwkSFWnCwA4E8prbISaJU6b2qY2S0qGIUej9evrby/zMJGmro
 p+9qYcV/2xuZArtySvJ6oH2Ju+QNC8Nf0wL9/qxg1NneDYaxjCwcS3eGk/soehideeTmdtCQu
 pDNGX+99Zf3Ph7diq95ahorrI9XBhyG0+9QgUYXXCiMq3GhwRq+GDnQTVVvzk30a9LskHw3eL
 XP+Aa5J1dfr0nmWljzKLLnHfApKHiKO7sEECBCENm/gHPvNVJpAexk7OqDYfTkclTqMyrxjwz
 JFmSURYCpCA+SJkm2MZaLeXBk19ktxyYyUNMhDXA4qxkpgvzh/eSysH/3Z/4pRFeey8u9lY7e
 g6XGepufU0lWHudYJGF0uyaM0MjG8FVo8yxv/W0UV2J84NQSzIe5saCY+mm0yGRs6zxZaUfUC
 IbW1+IedAzQK0sUlRugJ7EY+AEQN/CQxPACcAywx8aFrUKuSz4=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> While 64-bit Arm reference platforms have SP810 for clocks for SP804
> timers, they are not needed since the arch timers are used instead.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

>
>  config CLK_SP810
>         bool "Clock driver for ARM SP810 System Controller"
> -       default y if ARCH_VEXPRESS
> +       default y if (ARCH_VEXPRESS && ARM)

But maybe add "|| (COMPILE_TEST && OF)" for extra points.

       Arnd
