Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BA27E524
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgI3J3v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgI3J3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 05:29:51 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C9C061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 02:29:50 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z19so1303416lfr.4
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nt40XuawGIMRcY63tlPUjuXidTwwmmBOZZvJmZ1LX2Q=;
        b=bf4NU12b3N473SZmKQIxU3GCoKztiyNSsQTMp3TbU6A+9NE02UH1rF77dBv0GlTs+j
         jbHMPUiOejGLeb6g8VD+ocqbYBVZb8KTJPKrrw2Fl5Vdasd1ZJbyf/8+FdygYeyer4ax
         nb5B0mEW/r4vofeX+G34TPMcyPGidSeKnYJTc41tqN72X5oV728x1+OnDHcYlrkdk2lg
         elZNTxoVe9pYcELTSe4AKkwz9eFhsVIw4IwY48Tts1vKnTIsrcBjotFynilITBxrpBwx
         6AKzGibQKjiZu95XaKz4seSqN/MAbwADdRuLxWSyoZk7JRrlQdiG1JREz+0aFDEWtRdQ
         alFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nt40XuawGIMRcY63tlPUjuXidTwwmmBOZZvJmZ1LX2Q=;
        b=kEotnfqVdHrRHQgTPwZqzYX/MbSGZGKUBU/fY0XVAtNzX47fQ+MdleIGE0DyhVbS1f
         SW46Po/IOAJoU/kYIAPUEgbMh5EPPmFoH5nxckS363umY23r3xSjyZjGWucM4Egy1QL5
         UtJfANyoaPUuTnIFqB59eDj64k0z3xnK7laxZ+vgv9/6R5HDG183nULmXFPSyUVSBuG1
         j3DNVc7bndze3LF7iS7tja6EpQFl3Hn5CxvejsGh/lTwKcil8cyCjw3xk/KiaVmPEEhS
         R8CcnoBZ2kbBqmKYG2WIKwr+fqKFJOLXjoyIjAVJZxp/RsxDvi4vnLeNA0ccFoAH3ZZw
         gqMA==
X-Gm-Message-State: AOAM531Hfbr4uO6DczQsIqnTIgRV40EjPgQkPF8Jw+r02yYmPBhV8xFO
        6Lmd3aSrr54KH7Ix0/YiN60vjQ1zAYUUbuI/GpG/Kw==
X-Google-Smtp-Source: ABdhPJydiZObahpdH7vb9u5yuvddV6XbKHWHV7bX5NbThwH/zdH7E/sNA6cVQIaf6JMJfyGvwxbSlE0D/R0ap9XDQhE=
X-Received: by 2002:a19:6419:: with SMTP id y25mr526157lfb.333.1601458189195;
 Wed, 30 Sep 2020 02:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com> <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
 <20200911225417.GA5286@shinobu> <CACRpkdah+k-EyhF8bNRkvw4bFDiai9dYo3ph9wsumo_v3U-U0g@mail.gmail.com>
 <20200929130743.GB4458@shinobu> <CAHp75VdtUr1KHD5bng4sHZqsR888gN_TJ-bN8oLsX8GpsM8wYw@mail.gmail.com>
In-Reply-To: <CAHp75VdtUr1KHD5bng4sHZqsR888gN_TJ-bN8oLsX8GpsM8wYw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 11:29:38 +0200
Message-ID: <CACRpkdY-SwOx9tGyvrZy_VZJgHyG4ipo27bPnTe==o8_b_CTfg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 29, 2020 at 3:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Linus, are you referencing to [3]? It was fixed in GENMASK()
> implementation some time ago.
> [3]: https://lore.kernel.org/lkml/202006171559.JSbGJXNw%25lkp@intel.com/

Yup.

I tried to apply the patches again now to test it but now patch 2
needs to be rebased.

Sorry for all the trouble!

Syed can you rebase the patch set on v5.9-rc1 and resend as v10?

Yours,
Linus Walleij
