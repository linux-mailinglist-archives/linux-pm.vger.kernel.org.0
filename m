Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9245B050
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhKWXis (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 18:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbhKWXiq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 18:38:46 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA6C061758
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 15:35:36 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso1349074otr.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 15:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fmou/wuLUJUD4zJclGcPIdJu1KVjJ7yuzM0jDRLa/jU=;
        b=M1kOjxYtgXgq09yG/Tpxoql00WqAEf+/obBrTLesDBofwRUa7GWFazzYfDKZsB30ME
         LP42xJGdAe5cnwer5SKD8Etmug0Nt6ulXzhr/sIoE9xx2sYU5ALDWZXfWHpEvjhc83X4
         /EddGPPSnA96tKQr0ixoO9Iif78PSZQtfyiC4pLlvI90GT05IGmxb/4bv7ckDscOFVa0
         j8mh7s4sgr6HP2CGrSy/5EINAIynCtUbqRAKwELOEpj3OmmDipt7FyRZkcV3y0yyaOqi
         RMMwVrDE6PwHAX73yXnvFMVjk1xx32TWcnMG5ytYScelO405R1gRZUvoyiVzX+mFaqbl
         +gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fmou/wuLUJUD4zJclGcPIdJu1KVjJ7yuzM0jDRLa/jU=;
        b=XS710mbamE/B7b4WUiTalUr3VBx20+EDynSOohHu1J54sA2Az7M6ZCDuJeYRBjUqV5
         oHucb9UxqgFBb5A+Ko0F0a1KKS+fgDvfIQ13fRiiDbTwbn5Fz5Rv43xxUCzmzgh5BeJk
         u+vFODRryZGL7kb/OdW+v9kaOjYaWVdxpveKx69Z/BYJ+Pv2H1tCqQ0XKiJxpUiQ4aKV
         VrnjeYecvo5Ou1LGExrb/jgV5kDiniLEy4HrqHgojf2Ncfqn7e79gZ1ugZwXLawbvKQZ
         5IgMdvTTl+KTRecpzE6yrDq91VLh/By7X+sJ2JaRVIovVw1RR6/q+oIAehKq0euUsUT1
         Cbyw==
X-Gm-Message-State: AOAM533gre/1DOFQYx33OEZKwVl4Z9eAPJTkxZVch1Zs9xCh7mBuTn6g
        BdfJXaSHZozo4Zt4F477wXuHqpwKgmToDOK7B+zV0A==
X-Google-Smtp-Source: ABdhPJzM/xqGhHncEHhl2AIgExbTLI27yZdnho4Z+I5VLuYNi5uSlNeNxRyIKiu1OCuHPC8HqiuPUo4+VogT8mYjGlE=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr8027979otl.237.1637710535722;
 Tue, 23 Nov 2021 15:35:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637592133.git.geert+renesas@glider.be> <afb895b597037a635acc4a1dc44b88598268a19b.1637592133.git.geert+renesas@glider.be>
In-Reply-To: <afb895b597037a635acc4a1dc44b88598268a19b.1637592133.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 24 Nov 2021 00:35:23 +0100
Message-ID: <CACRpkdZAA_XZQ7KXOsod8r5EZ0F9f1qaz3+FLsuyPfeD_mO5Dw@mail.gmail.com>
Subject: Re: [PATCH/RFC 07/17] iio: st_sensors: Use bitfield helpers
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Paul Walmsley <paul@pwsan.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tero Kristo <kristo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 22, 2021 at 4:55 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Use the field_prep() helper, instead of open-coding the same operation.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Clever!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
