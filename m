Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A542A2222D3
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGPMtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgGPMts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 08:49:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306E9C08C5CE
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 05:49:48 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so6935544ljg.13
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMUqbM/2tAa8/paafO1/gccjmbEp76TZl0DYAO5Htac=;
        b=vuSLav+Cii51LYAbUmO1o2Rs7yss7EnlSKUR20VVaxbbxAYlCtWHJRMDU2Py8c8JTY
         WKhP3yKme72urB8ucBIKLAPShsPH9qJuaUcriEuBK9Wjv8FMrcnFMZbgbhNpHDLpfeb1
         2ZUxDC9TUvSLcWYF1QnnLlRGGq+l5vEZ5VQHiE2Ik+JiWFkWFqZ86Wsve2eOzvhGL+9K
         ihffOk/HZOePmw9cpO/AebqqXNtNfd7wNPftBpKcRDP4/lSsTY8DAa+BNuR8dIOnpM5y
         thFQEosZBhaeERRBEgpmtYGFLXBddwyP7XPHXPSRBypnXeSA/gggCvyS+NkEQJv0Cvb7
         IUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMUqbM/2tAa8/paafO1/gccjmbEp76TZl0DYAO5Htac=;
        b=o2bB88ZIF3zugs+63/guVlJslVzewVMtKnVcG74WdhLiDG1l0e53oglSS0ORyaUCls
         2UU509EzyiUgim14lA2VYgEd2pPFJR4E5C9Gq0mKd0U2SbOZrlOYIo/ehGj5B/7NspM0
         /rb00xBosdsdJafYryd5w/laeFLQnrsmq9VSeQ+WOgAsBYNcaRf7yFUI55PPry9Zj4rl
         x4DpKojqwlJODX74YuwCbswuJ5pE2nQcnQOte19VuMVYbNlJqATXy2E9xUzBfjznqVnh
         Z//AN+K5v7QC3U7uBUL+jtT57JVGPNfq+zQ91zyi0BatZjkwSqablFFkUUHtF6x4dtE7
         4L/g==
X-Gm-Message-State: AOAM5317FIpTGaCAw9Zb3V572GqWSra39/3QqnEPb/Be9nBjTcpoG4RY
        Ehmqa/K0TCthnYma7u83/DyiCGX3Pik1KnoEeCitiw==
X-Google-Smtp-Source: ABdhPJzZjvVBo25Dqxum0154FLbEBUp91nFV11Hp0xSDYrsQ5aSM1HddHJViEwuAP/BPFZwNurh2InaBi7wl7mxu/zE=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr1887718ljc.104.1594903786614;
 Thu, 16 Jul 2020 05:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com>
In-Reply-To: <cover.1593243079.git.syednwaris@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 14:49:35 +0200
Message-ID: <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Syed,

sorry for taking so long. I was on vacation and a bit snowed
under by work.

On Sat, Jun 27, 2020 at 10:10 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?

I have applied the patches to an immutable branch and pushed
to kernelorg for testing (autobuilders will play with it I hope).

If all works fine I will merge this into my devel branch for v5.9.

It would be desirable if Andrew gave his explicit ACK on it too.

Yours,
Linus Walleij
