Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB2C267990
	for <lists+linux-pm@lfdr.de>; Sat, 12 Sep 2020 12:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgILKgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Sep 2020 06:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgILKgg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Sep 2020 06:36:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF7BC061795
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2020 03:36:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u8so8421831lff.1
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2020 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF8m2xC4JB4qyW3nCqkmJE2v3IVbH777DHP9r98chVU=;
        b=ZdAifYhj2ckBuaqC7gwZR7Hupf7v18XeH6Ksh6kg+yA5O8P0Qnbfx9ZEFfkqW0fTOy
         lNszaKVc2NrsIDl1Egk7zLIrGNG0Ldo9UZJUcVS9IZVJkzXjn8CU8VVFivI17aeYfd+T
         Jw9pNYWslgFu/FSgrEuYYb4RkkkzEPjBhUexfGTSPM0KnPb3qZxqBmZdq/2k3u04i6Qs
         4Kst372V4IhEqb/0UqRTctNzZNV3duEfTaf7tKIlJl1AgMGryVizSQvmm6QuyWqLotes
         ToifTRd3uH4Bz/BY28YZp5rWMeB9KXGmdnWQn1rhIugm5IKnafz7O0t1dTBhevtbIr6X
         wZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF8m2xC4JB4qyW3nCqkmJE2v3IVbH777DHP9r98chVU=;
        b=sF7PRSHOWtixSZllmaaHfT7QIWydsCCk/MzyyntqW6GBPJK516Zp2OYKNFK3qF8lgj
         mdUYpQUi7wGq1JrWdaC8b0cwIPoukGXRA8Ux4z/KEgI8lvX/y5TqGzUXoG0FrUYml/YI
         y5O7WV2bPXVIFxAmj4UXQjMBRKY9xPD2qOmpK8QrsibhWnbi3VISdFEc5BK/KMZn5fK8
         qa0XWJa0zDNWMZ9gHM7LtsuK7084100gf24TJI7RzVvflOrAnI82gWApm0l17zXdGYqw
         ffDh55Jxq0ByNN5qzBNgAfrnaqQTK9+fiXTpwHvt35LZdpy1/s+s77UUby156DCRxpfD
         52Eg==
X-Gm-Message-State: AOAM530OnGqa6eq0ZxwkHsJM7oXO23tqvEHEFKbE9CK5juQXgWDh5Agd
        NA3mK56LAwST7ZcKgW6cEeUsOAfgUSE++txwNPSJiw==
X-Google-Smtp-Source: ABdhPJyoD2XPyfxM3troBciEM2Mczg6M+QUgoHKVC37fUndkhJdOxvWEyjUmNDBgtw0N6y9hRBKROUhaDN/qwicI9KA=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1453851lfr.571.1599906993330;
 Sat, 12 Sep 2020 03:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595572867.git.frank@allwinnertech.com>
In-Reply-To: <cover.1595572867.git.frank@allwinnertech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 12:36:22 +0200
Message-ID: <CACRpkdZqNSGkDCm6HGpS63iWp5b4WrZpdqz8QEeu4CVzkhGQ=Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Allwinner A100 Initial support
To:     Frank Lee <frank@allwinnertech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Frank Lee <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Ondrej Jirman <megous@megous.com>,
        Corentin Labbe <clabbe@baylibre.com>, bage@linutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 8:53 AM Frank Lee <frank@allwinnertech.com> wrote:

>   dt-bindings: pinctrl: sunxi: Get rid of continual nesting
>   dt-bindings: pinctrl: sunxi: Add A100 pinctrl bindings
>   pinctrl: sunxi: add support for the Allwinner A100 pin controller

These three patches (3,4,5) are now applied to the pinctrl tree.

Yours,
Linus Walleij
