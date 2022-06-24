Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8A55A3AD
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jun 2022 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiFXVgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jun 2022 17:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiFXVgT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2022 17:36:19 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5843C848BA
        for <linux-pm@vger.kernel.org>; Fri, 24 Jun 2022 14:36:18 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31780ad7535so36576897b3.8
        for <linux-pm@vger.kernel.org>; Fri, 24 Jun 2022 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cGTylEOWtLkcLIsxYVoGzfL+q0nSap9+8NoSlXBuXe4=;
        b=cmDy8lsyV2rPNiNRuYkEb5rHWD8XZVHKqJZAeKf3TnWZFLlj+/DTdLUMbXEmtTuv9s
         4KLbNJHfJqFtWZDtoSIB0jA5BkjqsNets6Rbr/qrINRnJTlQirI2k20GLR/Ql3zSe9Wq
         Pb5aXUq1NZ5lDKQQMD7a39HTujZM62LjFsQtIqhJoX7pGAoQGMqpg1+inV2FswApITO2
         CmT3BH618Yqgt62CZsqxQ5e1jZosKUxMbd0fExcTgjLrAxPBxkG7CVcmjw/O8dvTmdbG
         l6UouC6UHf0T16KEM/mMUtmMtJOh0vyJl540PkTEmkGnFr3Ic8OHzXavkS9AsevSsxDH
         c7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cGTylEOWtLkcLIsxYVoGzfL+q0nSap9+8NoSlXBuXe4=;
        b=P8D1Bl98TfuDqPHmyT9FoPxFU4W0afLzX+t75pw2MgB/UaPSBkkZu9SEoaFIy3ehrM
         T2BF8J/OpUSr4x1JpSJQZmXbWznzkgBsibY2OzAfmHEGpt7kkR9WVDFqqeoN2MFmbG6g
         UQJ0abc20XHeeuIOnnQwaGMG6Sj52baAmwhyBnG2X9IV3bcSWKxohIXDdYvmjZVuS4jj
         Z1O4i8HUF0GQBrMrarDVkUHfSS9cTemLKhSuCj0M4yBcl/zZfwPiv1fh0q0BklyZNFUJ
         fgIpvKpccbRW5CyIfZcrbnCdUd1cywimAU1ysjvjEbnx0zBkRf6a+JkKfurMLMUD1IrH
         Wp1Q==
X-Gm-Message-State: AJIora9gsy3lT9SpEVGpAVPF4fC8LHIWM0b6hOKgli8xtqHM8TTSE9pw
        ROwrMg45zFM0yO9wlRkVMtJaqdhiTUizqaYx3+O9Aw==
X-Google-Smtp-Source: AGRyM1v7bTPADut4sgzebmriq1YeKB4PBfCCubvcMefuaUSK78eOKMtZqJdaXmsewcrgPAHhOp3HhKhV310/qVQEQyc=
X-Received: by 2002:a0d:cc54:0:b0:317:752c:bcf3 with SMTP id
 o81-20020a0dcc54000000b00317752cbcf3mr1068283ywd.437.1656106577632; Fri, 24
 Jun 2022 14:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-13-peterwu.pub@gmail.com>
 <CACRpkdZatfOFmeGXepTrjAk1or4W6KNUEaXnP+srRebfM=52AA@mail.gmail.com>
 <CACRpkdbzZqerE_2PeGMUWRbtjK=9P8V763cj83ZqjP4n6AVHAg@mail.gmail.com> <CA+hk2fZEG0TxMGhGJY21w=MmXgKsH5mYCYynQV1jbhpOCyf3qg@mail.gmail.com>
In-Reply-To: <CA+hk2fZEG0TxMGhGJY21w=MmXgKsH5mYCYynQV1jbhpOCyf3qg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Jun 2022 23:36:06 +0200
Message-ID: <CACRpkdYoR9SGQdxJQmUReP7SLk_BxG0yuTWAL__o90PuO8sCqA@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] leds: mt6370: Add Mediatek MT6370 current sink
 type LED Indicator support
To:     szuni chen <szunichen@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        alice_chen@richtek.com, Linux PM <linux-pm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ChiYuan Huang <cy_huang@richtek.com>, chiaen_wu@richtek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 24, 2022 at 9:20 AM szuni chen <szunichen@gmail.com> wrote:

> > I meant this one. Move that into drivers/leds/flash
> >  drivers/leds/flash/leds-mt6370-flash.c             |  657 ++++++++++++
>
> In next version, I'll use "leds: flash: ......" instead of "leds:
> flashlight: ......" in subject.
> May I confirm that the driver has already in the drivers/leds/flash,
> so I don=E2=80=99t have to move it in next version?

Yeah you're right, I am just writing wrong comments today, it is already
correct. Sorry!

Yours,
Linus Walleij
