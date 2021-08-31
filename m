Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5D3FC72D
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbhHaMQp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 08:16:45 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:37666 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhHaMQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 08:16:40 -0400
Received: by mail-vs1-f51.google.com with SMTP id i23so13043246vsj.4;
        Tue, 31 Aug 2021 05:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnku0FFHfkBfdTCD06jvZHLPwNXL6nx4uAdXOIMz+aw=;
        b=d3vkWumSN/7okZZwqUxwChaxiIC3WG/Y+MkDbiq2zjWLQVKD1D22zvclUPGoyoaS33
         MbKRXTDpGRWN1tb20G7T0GVJvYcfDLPXcTJ9g41+8ZCLmOm6EhyM7SNYXOpd44qbIL3t
         U7eYCJtbDvonscnx/xv/0vcOA/h+OGpYSgjLblA/dTfmRPsKpMN9QKcMhcBd1bYzeIUT
         ohz9GvKmShdZeAVjjkNAQ7AbzY38nXxkka6iFV07oHrefYdzfzCr/IYw6QN5e1ty6seA
         Xt5gMtMTTPH7Dzx81UoKEoNeyH0Uy1VyoFwfIa7V1eAZw0zcnErjTPqtn4h+5DJxZwuH
         PsqQ==
X-Gm-Message-State: AOAM533o/xgGqts2DSl7UrE6fDAo4iDy8b0cze/1knfs71CKThvcVGyO
        38TCxWk0oIxvQZ3GJae+RTnC8mx3S5Ps4yrubbs=
X-Google-Smtp-Source: ABdhPJwDYKJvKetBta1+JjjLOvO7qKHnmkgrzd/T0qifBWKYm5DYsHohpk/PwO3kQ8r8y0SRqMJ0OXCmoTLMUtrPg38=
X-Received: by 2002:a05:6102:3e92:: with SMTP id m18mr17878737vsv.53.1630412141822;
 Tue, 31 Aug 2021 05:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210731195034.979084-1-dmitry.baryshkov@linaro.org> <20210731195034.979084-3-dmitry.baryshkov@linaro.org>
In-Reply-To: <20210731195034.979084-3-dmitry.baryshkov@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Aug 2021 14:15:30 +0200
Message-ID: <CAMuHMdXmJ-s42NgB9HboudGh3M+_HwfmfFEcBuWNNKoFke8a0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PM: runtime: add devm_pm_clk_create helper
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

Thanks for your patch!

On Sat, Jul 31, 2021 at 9:51 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> A typical code pattern for pm_clk_create() call is to call it in the
> _probe function and to call pm_clk_destroy() both from _probe error path
> and from _remove function. For some drivers the whole remove function
> would consist of the call to pm_remove_disable().

Is it? I could find only one (drivers/clk/mmp/clk-audio.c).
All other users call it from their PM Domain .attach_dev() callback,
which cannot become managed.

> Add helper function to replace this bolierplate piece of code. Calling
> devm_pm_clk_create() removes the need for calling pm_clk_destroy() both
> in the probe()'s error path and in the remove() function.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
