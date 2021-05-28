Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837D3394422
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhE1OYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 May 2021 10:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbhE1OYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 May 2021 10:24:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C62C061761
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 07:23:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i4so5774294ybe.2
        for <linux-pm@vger.kernel.org>; Fri, 28 May 2021 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syysfoCLQhlZX4I15Hdgek+czZDdAMbqNxcJPk1EsOQ=;
        b=Bi4g/rtry3daF+gwc3vRtRNefr36ib+72ReLa3GeeD9O3ybgsW5H+StLvG598fcTA2
         MxJCazJmuhXChu6NvwkTut4KABCZtDklevvhSdJrjzkGSFpjSB9y1qKrfSy/NJ2F9zqa
         SZ1tZs0U6q14X/bQF2A24cWdOm+OoG6tGIOcgxXj07e6xNBC4d2gkVJuryB4N0qhMpSv
         vjosCTpmqAA7DzXW5J9O4/xo9afKZ9gPBnxKBSRuGMrT6i6aZSDO3XwKpRv4Txh494Db
         xnpj5063UpPa68aZM8xfll+N3FUZukP1ajAbSd7u4yzb1znukr81z6bLt4hdid2Qss8i
         6bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syysfoCLQhlZX4I15Hdgek+czZDdAMbqNxcJPk1EsOQ=;
        b=NWR/UvkM6uxWi0TAdzCshXIpOmDKUTscnerQ+ZSWGryYFIfs64h6xuga2PEsZ51zeb
         BvLcpz7f2fdDa4jlUvXK3SyY1LH9AwOLK80BFJruKBsqjuU6+v/9RNln+An3dJlTOgON
         yMtJUzq96Z77jzL+T6/reHbOFULdreVJlN/ZRRjlhDbidwhDu5lg1HQqCblTQM8hvtfK
         IEwDsvZDYtCv2AVzibVg8pYIz04cXwInpe/Wbmqpswv4qiKvonTAyte9x/oeOWB572uj
         rnUc8ncsNbRYe/7b5xPPpqdT2q7pkg7Ii0C44RGCZPaWnPjwlXG4GdXYSUxmwAcE2ydL
         dQlQ==
X-Gm-Message-State: AOAM530LIVNc1px3dJzQ6Zye6bilwXBf1Up6wUNdzouKrjvG+9+f8+UU
        N+4z3dKxu1GivjryVG26NxzvPeJXr/0J3xbWXUGMig==
X-Google-Smtp-Source: ABdhPJx8mHtOAu17ADz6J7AwfAXA/YIRldt+oDMdzuZLRNE9q/0fTWnkdiCMlbQ3GUS+scmZ1tLW01HbzK50dqSraow=
X-Received: by 2002:a25:420c:: with SMTP id p12mr9823321yba.25.1622211792670;
 Fri, 28 May 2021 07:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com> <dba3927a575645e5bf1ff35edea5ad74ea86885e.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <dba3927a575645e5bf1ff35edea5ad74ea86885e.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 28 May 2021 16:23:02 +0200
Message-ID: <CAMpxmJU8GY568LwEyKnxiN3vPgOreyCYYJF_sD2dFKuMOm6A4A@mail.gmail.com>
Subject: Re: [PATCH 6/9] gpio: bd70528 Drop BD70528 support
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>, linux-rtc@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 25, 2021 at 12:15 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> The only known BD70528 use-cases are such that the PMIC is controlled
> from separate MCU which is not running Linux. I am not aware of
> any Linux driver users. Furthermore, it seems there is no demand for
> this IC. Let's ease the maintenance burden and drop the driver. We can
> always add it back if there is sudden need for it.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>
> ---

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
