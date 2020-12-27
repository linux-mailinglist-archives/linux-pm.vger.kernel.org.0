Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE92E32FD
	for <lists+linux-pm@lfdr.de>; Sun, 27 Dec 2020 22:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgL0Vab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Dec 2020 16:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgL0Vab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2020 16:30:31 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C5C061799
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2020 13:29:50 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o17so20098609lfg.4
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2020 13:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTYaA/nk5rfxrjXMV9Zf6ReLTziBhlVMG7XuAP4a5t8=;
        b=J5P/Mg6E+/zhNhboLMKs7TkvDI8fqb3RuPdLB32RXXdwcNDIxDI4ZMJOSn9kRMH9lW
         ATXSxQ/SO/FjGNfp0QsladSzDjqr3DQNInBQVPqZS425ZN3oUKTQ9q81JC9myq8QwDjC
         VtGxnyk1K3UWqL/6404Pwzfo63D2GgFwveeSVLJDGM0JOLFsevJ+RxyCR7d3PG4+1jW1
         sEIRYVN7tF1MrzwdqMAIDjxjjIer4iGJRe2e64tX9thJGwq/ON7x3wZworJjitibqlhF
         8zamHCdpNihGp/GuPEnBR18p4qV7DhcDJ0Zz1a0W5av7mMR1X4itMiaHF2iHkdADS1jM
         vHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTYaA/nk5rfxrjXMV9Zf6ReLTziBhlVMG7XuAP4a5t8=;
        b=JBbOVtzXWoelVllzKb5YzDlgtqLZ0XrpumKiR66TUOCOQ51o+OMCV/fvdady4RPDeR
         IZD4Ei5Sluy2QBoRX+YtaY+yVnuy1RDTph9tMKMmOuZD2wFSvUt3nSLVzOQW7iwi+Np5
         ZOK6KJ6YwJ+Y6wySisQXl+eRhWLjIg+bsdzz2BsaHBZJl66PIPpJfY8H1QkMyZAtzWmT
         VM+hiOtG8sTUirm+HI8pjPh9hxsFVKgALZcUoGs0tCe7uRlU84iJxRNXA3YW9+DP/WiH
         VZ/aSMdJfx3rvIfijWVPaoZ4hUITUdQFWBtX0xZ7YOQZD72wcH6rSib08rrr1BCK35Jh
         Wz4g==
X-Gm-Message-State: AOAM533euSzCu/VxHyVjmMfF+/wE4AWZG/9kF+smH0hzQRKy9BiMTqIj
        WgIywl2jnpR+y6w9EBxnnZ4XfplS1KaCuRioLS0n5A==
X-Google-Smtp-Source: ABdhPJzfNx7tIi9SglDZF+Sx/celS+gTLPOTG/bEsMRx3N0BRYld6DtNve2/EtSdisYCC1sdSk4eVBjU0GqHRFyReNM=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr19629137ljl.467.1609104589062;
 Sun, 27 Dec 2020 13:29:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608963094.git.syednwaris@gmail.com> <5041c8cfc423f046ca9cf4f8f0a8bd03552ab6ea.1608963095.git.syednwaris@gmail.com>
In-Reply-To: <5041c8cfc423f046ca9cf4f8f0a8bd03552ab6ea.1608963095.git.syednwaris@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 22:29:38 +0100
Message-ID: <CACRpkdYmoEjTzWv7wdrHhc8VFxFB+=QQwKA6YY+prydjgUB2aw@mail.gmail.com>
Subject: Re: [PATCH 4/5] gpio: xilinx: Utilize generic bitmap_get_value and _set_value
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 26, 2020 at 7:44 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> This patch reimplements the xgpio_set_multiple() function in
> drivers/gpio/gpio-xilinx.c to use the new generic functions:
> bitmap_get_value() and bitmap_set_value(). The code is now simpler
> to read and understand. Moreover, instead of looping for each bit
> in xgpio_set_multiple() function, now we can check each channel at
> a time and save cycles.
>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

(...)

> +#include <../drivers/gpio/clump_bits.h>

What is this?

Isn't a simple

#include "clump_bits.h"

enough?

We need an ACK from the Xilinx people that they think this
actually improves the readability and maintainability of their
driver.

Yours,
Linus Walleij
