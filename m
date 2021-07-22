Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C313D2DA5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhGVTrf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhGVTrf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jul 2021 15:47:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AF4C061575
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 13:28:09 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id c204so6530744ybb.4
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JShzBsE1gslUcj6DK5RqtL+x9Drx5IU2YuOFiHBfDHw=;
        b=IRLteODQGte94LrMcF8c6DvMU7ZpPp+nfht8VwL5H+Msw9FsWAt2ml94EZfghfSv28
         U0IoQu7i35gxNE6BG1lGutxLT+Nt1aZGCZQ4VXzbjjE0poS7Geq/72XLhwJEYPvlQ499
         sUee252QaP8wAZj7qZzW+4Euk3W6gGjBoTS6M46PB6PRuuP/tTpQHdjcVRRWhKKlnVKg
         A/f25qcxsUfeHoOBuCOLN+BQbyRGqAY06URrRck/SlVSv0ls/AC6U6ZREzRY82q6PGXj
         y3aSuy5EC8SCX/9BebCa92Z7Qx1Ly1ozMZEI0aVr/MLgI2HlHrz9aeGynJUg9Y4qCjla
         3pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JShzBsE1gslUcj6DK5RqtL+x9Drx5IU2YuOFiHBfDHw=;
        b=eOQN/81tIZ5gj3ttGcOaKpOdGejs69HsocBS+3axg1LIZwymnoGurjOzvA2cA1B4FB
         JGfeTcUsbchbVkJjkOts/SraapnixRGWQPJ4IT4omf8t4CsIM+baUDhEd4KLvzqqCOn6
         1Cz+odBSYEc3fBrJt7bIiAuU17hdfucuK5q02/61vazggm0rWlRU2HdfIKKevYKN+1/k
         OBP111Y+WOKyFl11Q8LmBTqcSCvFHd382CmfikGVZ2aEkWc/eywOswSrCfSKNP/v3MVh
         wF9aGuQpVnDC5D/ryBagteD+DOZjXQyEU4As4jS1ySfhKkNk+Ny/YLWLzkTTnzdLKX4W
         KkEg==
X-Gm-Message-State: AOAM530w8QlaOqE8jzFHbMJLiQiRXjoAYlDqjfflZ5VU51Z9TrCNIZRE
        EjGcCrarq0ish0BehvV/kDYSrYsIVLcCpDpqgWw=
X-Google-Smtp-Source: ABdhPJwWOfW0irKxoybP4rg4Plpb/H2/VmYLX+xlDoqLALk8hNOKmcJ40S5hZXcreYjK5mns0JSKeOyV3z3LsStAMac=
X-Received: by 2002:a25:ad62:: with SMTP id l34mr1810562ybe.457.1626985688015;
 Thu, 22 Jul 2021 13:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210722191430.28203-1-macroalpha82@gmail.com>
In-Reply-To: <20210722191430.28203-1-macroalpha82@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 22 Jul 2021 16:27:53 -0400
Message-ID: <CAMdYzYp3W2NGN+VHZAC__hutmtGcUTHeQ=tDo+OAeygUQ5kXTw@mail.gmail.com>
Subject: Re: [RFC 0/4] power: supply: Add Support for RK817 Charger
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-pm@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        maccraft123mc@gmail.com, sre@kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 22, 2021 at 3:15 PM Chris Morgan <macroalpha82@gmail.com> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> As this is my first charger driver, I'm submitting it as an RFC so I
> can get input from the community on what else is needed to make the
> driver consistent with the quality upstream expects.
>
> This series is to add support for the Rockchip rk817 battery charger
> which is present in all Rockchip RK817 PMICs. The driver was written
> as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
> myself Chris Morgan <macromorgan@hotmail.com>.
>
> The driver requires some basic parameters be described about the
> battery in the devicetree such as the maximum capacity, the minimum
> and maximum voltage for the battery, the maximum charge current, the
> maximum charge voltage, and the value of sample resistors and sleep
> currents.

Excellent work!
A quick test on the quartz64 model a shows expected values.
I'll do some long term testing as well.

>
> Chris Morgan (4):
>   dt-bindings: Add Rockchip rk817 battery charger support
>   mfd: Add Rockchip rk817 battery charger support
>   power: supply: Add charger driver for Rockchip RK817
>   arm64: dts: rockchip: add rk817 charger to Odroid Go Advance
>
>  .../devicetree/bindings/mfd/rk808.txt         |  35 +-
>  .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  26 +
>  drivers/mfd/rk808.c                           |  16 +-
>  drivers/power/supply/Kconfig                  |   6 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/rk817_charger.c          | 927 ++++++++++++++++++
>  include/linux/mfd/rk808.h                     |  87 ++
>  7 files changed, 1095 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/power/supply/rk817_charger.c
>
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
