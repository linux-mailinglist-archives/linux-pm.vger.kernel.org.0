Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB01B0FCD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 17:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDTPTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 11:19:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgDTPTE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 11:19:04 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MORR2-1jb2Zk1yYw-00Psst; Mon, 20 Apr 2020 17:19:02 +0200
Received: by mail-qt1-f178.google.com with SMTP id n20so2493156qtp.9;
        Mon, 20 Apr 2020 08:19:02 -0700 (PDT)
X-Gm-Message-State: AGi0PubSIRmZXHMNj+5MtkGKPem5/FWkLTGXfIz2FNsAyBueUc8G+rck
        65lvExUjrInTYgeqbrNae41NIt1cxx7mHZJatZs=
X-Google-Smtp-Source: APiQypKRQPodylxbd8chSbVFgKzdE7lNTya9nK+Z/s8JVlEEwwh1pZNKLYQ4UcTIU2WPOGLZm5LTvsBN53rY/0ul88E=
X-Received: by 2002:ac8:6757:: with SMTP id n23mr16431371qtp.304.1587395941298;
 Mon, 20 Apr 2020 08:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-4-robh@kernel.org>
In-Reply-To: <20200419170810.5738-4-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:18:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0x5+2mitmecfTeph_XYfUwcLeER_W5_n3iC=bEDdY+wA@mail.gmail.com>
Message-ID: <CAK8P3a0x5+2mitmecfTeph_XYfUwcLeER_W5_n3iC=bEDdY+wA@mail.gmail.com>
Subject: Re: [PATCH 03/17] arm64: vexpress: Don't select CONFIG_VEXPRESS_CONFIG
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
X-Provags-ID: V03:K1:e8vY7iePeX+FIhI3q0iHAD7WmSXun2FvDL9LPub/HMozO40wQ+n
 uefbnvLSEoFSgmtfXPp4hJNVo+sxj2MndBCfTOJOgk5HYd/9PqHxvLvq/JXDEmSWi800yOy
 NGBdMv8igBYCVDKnJYl+uGrQnqgYHDG7a94NiumuRoo4LECYLvNnXw5PidZq8mfMSdSoaR7
 Zod8EPLMpCR8VomGIecAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f11SmvnNras=:hDred+6yvval4NennpxZj1
 4GRpvxMYfKSP+s/lYnx3co3fnOd7BWuvH/ygX/UuTGYDj89ZAW41RiwJmpVtPTtvbLeR3fjJQ
 7pzUMoY4TnGId2ogcN8bgqOKV3MTaN+UXOPpAPhCGFgw15WzwXcHVYYBjS0w8iywxs994stWq
 p+z0mFZu2vkun7tehvqEh5t3gZZEjcrJzr07nUCD+mLdMusH4l9YkZmD0P7+jWnW0WRLoB9wg
 YxOQXR/nYxL7tlJs3LVgxuZePM3X3gPe6B4totjsg8wMq5D26eIcjUhpWxIRlRl5nHMAVh/GX
 0LOPTZvDyz/UDzZ3xankvgRTTlJ4rCV7C/5x46MUpKVIgv+5+LckM9FkncsdeJofhbYAZzoBp
 jG/6kg5+dfrEMGawC2B0tbbmigF5rHr3QmBqljlXxpC4sJqiCYX6sTpMpmgDxyCC9k4mp9A0n
 8q2k/JlIKrVyUvFFI48U6dCOOvz1z0x/roMvvIcLcfz9zffi2FgUzTfOdHeCdPc/SKlzgts9Y
 8bqo0BbZATl7IA59kN/yaXOvReANGWZyeQMKLThqtmmriE/4Bc+ghhy1Ba8v7pIBhbNldzJAn
 +6UxN7x5PPEn8lAnViBgarpCIiMsodQk33zrF8d3xdtV/jxrHp+IPQRAtzMLOPffeudjVYGIG
 cI3aMKCDlEyQkfkplrCpRXGTONC6PqoleQlAf720pFq4liFxID3uCWvauCTvgFnziPtKtYMTD
 N3VzSTIVCd59nMFcvjTq4LYSbXNryiEjSz4XBjgdsOlQxVCScjXmyL/9VF/ikNO1T9xiOAyLJ
 Z3djd0HMGhvN6IecALr3VL1p/3yjIWR5GKQl3mxZ1M7B1SiZ5Q=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> CONFIG_VEXPRESS_CONFIG has 'default y if ARCH_VEXPRESS', so selecting is
> unnecessary. It also prevents setting CONFIG_VEXPRESS_CONFIG to a module.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/Kconfig.platforms | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 9c084f995e0f..5c38dc56b808 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -278,7 +278,6 @@ config ARCH_VEXPRESS
>         select GPIOLIB
>         select PM
>         select PM_GENERIC_DOMAINS
> -       select VEXPRESS_CONFIG
>         help
>           This enables support for the ARMv8 software model (Versatile
>           Express).

Nothing wrong with this change, but I'd fold it into the previous patch,
as this 'select' was clearly meant to avoid a build failure on the
previous one.

      Arnd
