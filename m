Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F51E0AB7
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgEYJgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389591AbgEYJgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 05:36:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE2C08C5C0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 02:36:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v4so13409621qte.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RrCJYv2CMkjmXgxh4luY1jGTleOro3sZ8PAwMM7JZE8=;
        b=fuRxqLaU5g8a+KV52JfO8iIc6Dpzv7xH8zEcUSQ/EPvQBP7xuZujlB1Zqe487JQ3Kq
         07LoVBHsy1UXVK+h1466jj5fLf4k0US9SOPw/xkahZeYDz6NXGm5hSOhNSrUBtmqhLWK
         KpGTM4RgelTirb7PDz/hSax3IAD2wQczpkOEfKXlM0XO/X+ySXMhXr8sWjHil9VXwp4a
         gjc6rD/Jhv2tYnFrfXg8taOWar/FQPrbAQeQRe+RXkie2tW8wVIJTOK74bsrPbGDoPrG
         lezjk7vKK6+6lpnEOFAUY+wGVeHzj2KdWfnZ/xg9pSOhTX2lpNrlKoV/wVcAJES3+lOl
         9t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RrCJYv2CMkjmXgxh4luY1jGTleOro3sZ8PAwMM7JZE8=;
        b=Mzhf1QyxcNKruVOj0mI+JbIrmjR4qOBZ+5IwNVJWcjOJwrGKwOtBdkMknwYH6Rm28w
         Kd5sOevVM3ceeSXM/deBlQGMxo0Zd8CAPl/B2tqvZNhWTtKe6ySHjM+20gpGpalN4Sil
         tmtGplZv8IiqLBJiWhqocxPXgzOkn8pzGWs9qJcIJEqqEMoNMtT6kgInyurNiAgXquge
         H9BHwECgdImBo/lWILtujhCbiwqEZiUnAZynG+MSbS6mkLcXk1QmmqVENFOyQv0q1sPm
         6nBiqnEd3EofFCbp23Ypg5VOfUNBjYKfKIHQSoRB6kveKN+dkQ7WMijn4LBlgDjcNA1Q
         p3lw==
X-Gm-Message-State: AOAM531PvMOxsdU49GajxeslNuJW/9fXARXN5s/HtnklWpINPoUFL0N7
        zRoMmUPrYoicBrRcwgfo+rMBJJtuftfl0HaFfySXlg==
X-Google-Smtp-Source: ABdhPJxH6RRcuaHYqO3WxxeIfwE81GyLqMO/ChAPMvFcbjmN7sgsVd4B4nKXJegt6FTlMqeYNykQPLynPcScd/lVDDo=
X-Received: by 2002:aed:257c:: with SMTP id w57mr26966940qtc.208.1590399406112;
 Mon, 25 May 2020 02:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590017578.git.syednwaris@gmail.com>
In-Reply-To: <cover.1590017578.git.syednwaris@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 May 2020 11:36:35 +0200
Message-ID: <CAMpxmJUrC270rgWcADYruqA_qVeh9-N8mCVPWgJkL-8kU2bO1A@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

niedz., 24 maj 2020 o 07:00 Syed Nayyar Waris <syednwaris@gmail.com> napisa=
=C5=82(a):
>
> Hello Linus,
>
> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?
>
> This patchset introduces a new generic version of for_each_set_clump.
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro
> in several GPIO drivers.
>
> The earlier 8-bit for_each_set_clump8 facilitated a
> for-loop syntax that iterates over a memory region entire groups of set
> bits at a time.
>

The GPIO part looks good to me. Linus: how do we go about merging it
given the bitops dependency?

Bart
