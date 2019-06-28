Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093A759C0B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfF1MyK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 08:54:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33476 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfF1MyJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 08:54:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so3931782lfe.0;
        Fri, 28 Jun 2019 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2C3SFyETFeJmIRgSvmqt0/YbNtQXVxGJZ2Zoeef4sgo=;
        b=jrj6ELNQzTB2q0mnLeQreHBhUjyGx97Y6dIEMeJUjYJNh4a5z9QakHuXn3s2QLx5t1
         zfZDhqQaLZzdcfPmJOKQjT2Jyaq16KizriyJII30RS/yUw8eogniEegfKWliwApcl2yB
         iLJYmCT+MIkkoXmrbw2n8eazEPJPp6kzaliu+yplCW0WeiTpzx6TQPYgo1K0Xt1V50yx
         B8lXVLHykKEC4SzQEBzoQteKdchG0T7cv78OQ7w1KY+FiFV1dmZngdG2SphPK7Q96EYs
         gzi26aBU7fJM7OV7Rubn1lbsaRww/y1jBvKBcRIfX+cvJnbdlu/yfEFhpF2fZeMLAVrN
         juRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2C3SFyETFeJmIRgSvmqt0/YbNtQXVxGJZ2Zoeef4sgo=;
        b=M/O4vdbVa0Hs/lfS6QAgQLS8h37YUUAWZbb0qJDPvG3FyGZdPPkDDamoPqibgcZCEg
         iIughcWrD34a2LXuAgzgnIjFa6gxkStLUbfBXHse5TQ1sNMk1N5+IzteQXKfIhqI6d9u
         jhme910M7cxk7uuVajtU6lkojEICf04Eka0oy3mfTdheDNXjDtZNNc6mglbJfPzA1lNr
         YZ/lV54fGyMfjToVUu7eOM3vxfBa7GrV8DqnZ/RAPpVsYFX5Y7M6qNLrrjV/p6JaGa34
         m7LHVXKr1ROKi356Su/I83v2qd57w+p+Wgth69uj0xWT1h3lW3q/duOuiig7f+WKWXTY
         zK7g==
X-Gm-Message-State: APjAAAUQcRPGE3wNe4c6tB5GTOjvdVTjZ+/LEY4wLCzMafl8UTLH33ZD
        V5/C9iGNMQCFGPnG5XDMzxyRY7Pm
X-Google-Smtp-Source: APXvYqxck52xwjYdM9gKuitN3RJvvrlS63LBPAkC09wsqhfNM2JdIHkCn+6bJQ/blS6hQStU0Ogfdw==
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr5043207lfo.63.1561726447221;
        Fri, 28 Jun 2019 05:54:07 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id t4sm799359ljh.9.2019.06.28.05.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 05:54:06 -0700 (PDT)
Subject: Re: [PATCH] devfreq: tegra20: add COMMON_CLK dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190628103232.2467959-1-arnd@arndb.de>
 <c2701295-0fd6-c5ec-59d4-6e6b3b3bdb8e@gmail.com>
 <cbf6cff3-f5f5-66ea-9cca-86eb93f23c50@gmail.com>
 <CAK8P3a1HOOk48G+-wZGWrM_fg5cn3ytH66qaEU6c7e0BjW+SNw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5301c593-97e1-db4e-067b-0522537b55d9@gmail.com>
Date:   Fri, 28 Jun 2019 15:54:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1HOOk48G+-wZGWrM_fg5cn3ytH66qaEU6c7e0BjW+SNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.06.2019 15:27, Arnd Bergmann пишет:
> On Fri, Jun 28, 2019 at 1:05 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>> 28.06.2019 14:00, Dmitry Osipenko пишет:
> 
>>>
>>> How is it possible to happen? There is a stub for clk_set_min_rate() when COMMON_CLK
>>> is disabled .. Could you please show the kernel's config that causes the problem?
>>>
>>> Moreover that was me who added the missing stub for clk_set_min_rate() in [1] to fix [2].
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/clk.h?id=b88c9f4129dcec941e5a26508e991c08051ed1ac
>>>
>>> [2] https://lists.01.org/pipermail/kbuild-all/2019-April/060292.html
>>>
>>> So this patch looks wrong to me because apparently it fixes a non-existent problem.
>>>
>>
>> Oh, wait. That was "implicit declaration" and this one is "undefined reference"!
>> Still looks like something else need to be fixed..
> 
> The stub takes care of the case where there is no CLK support at all, i.e.
> CONFIG_HAVE_CLK is disabled. However, some older ARM platforms
> still have a custom implementation of the API and lack clk_set_min_rate().
> 
> $ git grep -l 'EXPORT_SYMBOL.*\<clk_set_rate\>'  | xargs grep -L
> clk_set_min_rate
> arch/arm/mach-ep93xx/clock.c
> arch/arm/mach-mmp/clock.c
> arch/arm/mach-omap1/clock.c
> arch/arm/mach-sa1100/clock.c
> arch/arm/mach-w90x900/clock.c
> arch/c6x/platforms/pll.c
> arch/m68k/coldfire/clk.c
> arch/mips/ar7/clock.c
> arch/mips/bcm63xx/clk.c
> arch/mips/lantiq/clk.c
> arch/mips/loongson64/lemote-2f/clock.c
> arch/mips/ralink/clk.c
> arch/unicore32/kernel/clock.c
> drivers/sh/clk/core.c
> 
> We could in theory convert all of those to COMMON_CLK, or simply add
> a dummy clk_set_min_rate() for each one, but since there is only one user,
> my fix was simpler.

Okay, thank you for the clarification. Looks like "Tegra30 DEVFREQ" should cause the
same trouble for you as well then.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
