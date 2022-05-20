Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB152F529
	for <lists+linux-pm@lfdr.de>; Fri, 20 May 2022 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353678AbiETVgm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 May 2022 17:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiETVgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 17:36:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644FAEE04
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 14:36:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i187so13974118ybg.6
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDX195aHGIYmy6gEbjE7UDvqnT5GPc2uuUkDu28Rr58=;
        b=fyJA21rMecS9DuD2aYNIXEK6mvae/3XgOJ0ToKUfWexd4Rde8/8a05HCDwOJ3AB03o
         ogRUSzuMiSFCint27HWZx+sgP23saMjBECOAAg4aHe+IIOgAiDRi/jb47s//iVBmNhBX
         Z19FIw8/twp7G5WUvJL38H+wz0dbjDVy6MuPLfQ01itbk4+C/KiudCI8gWj/2f0r4ucQ
         gmZfIolxCl0AgpvPRKZ0f4wmzSuM/IVvS/jSIrPQQdBcHnQdNb/WR6wYamzpJZBt+RRx
         QArHn5nFreKzNtbwug5bmCNg1JIkpgjWU5hOlLA5df7g1V6171U2/Ndv5gWYgxqGTWf+
         xCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDX195aHGIYmy6gEbjE7UDvqnT5GPc2uuUkDu28Rr58=;
        b=AIEyAvW6PBK5s+AvKuXOnkbeC+KOVSB1idxRoev7JWdwTbWwvgfxjalz4uDP5X2jOB
         33kQrjaJ5lXtYWoX8oEUu+1cuvAI6Kg63xOtQgEYhTqfsXnVJt8jeCBMqQN3AHSokzvn
         W9n3bCFiE/Tw7Iuqpyv+ALltEcSAGJSz1YGuJqb659wOhAWvmR/igmvfNaJMWSPRabfW
         sXWTAvpTuaiV1x/AMGk3C8JirSxUUUB247lA44V0WKnJIYyKr55ePApcMaDzvvjQUrpr
         LS4yJNh7XtT6IMbP1HaT8f/4q6uK2B7qkymm3oyC3UoRmRKOBn/hD7dakFmrAhfBw4ii
         2BVg==
X-Gm-Message-State: AOAM532QWxNKebpQ7oU+SG+Q9lBBOiPo+6tSqddTjBET+5qWSksJzz5Z
        JmmRi6wM8/T64u+Ib4PK7VVTMLSYgsWzFboDVZ/d5A==
X-Google-Smtp-Source: ABdhPJwnJr5rejBeFmyR1Hs8ESRxfRQNNj9tcHT34omajQr7Uc1/jCT5BFrbKOZ0ZpZ23WvK60GbSagkGmoQ96xmtrk=
X-Received: by 2002:a05:6902:704:b0:64d:f270:22b0 with SMTP id
 k4-20020a056902070400b0064df27022b0mr11459029ybt.626.1653082600508; Fri, 20
 May 2022 14:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220415203638.361074-1-linus.walleij@linaro.org>
In-Reply-To: <20220415203638.361074-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 May 2022 23:36:29 +0200
Message-ID: <CACRpkdayC3ptQJnAKHGhCtGonYr7M_UythAKRYQsZibrZ9kmNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: supply: ab8500: Respect charge_restart_voltage_uv
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 15, 2022 at 10:38 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> The battery info contains a voltage indicating when the voltage
> is so low that it is time to restart the CC/CV charging.
> Make the AB8500 respect and prioritize this setting over the
> hardcoded 95% threshold.
>
> Break out the check into its own function and add some safeguards
> so we do not run into unpredictable side effects.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Sebastian could you merge this patch (and patch 2/2) now that I
convinced Matti it's safe?

Thanks,
Linus Walleij
