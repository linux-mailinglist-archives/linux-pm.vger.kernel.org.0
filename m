Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9755497F
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jun 2022 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350246AbiFVK1e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jun 2022 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349872AbiFVK1b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2022 06:27:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F13B55C
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2022 03:27:29 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id h65so20129202oia.11
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2022 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2CMwg5s/2ebjoMZ8nHOuL1j6j+g8aWqCkVHVcRkW+M=;
        b=SjRF5jshmpVR3+ucMQJ8U+rPW3OTKpMH8d+Tp5DfOddk6oC+P1iJbtvVJ2kmSPCRPU
         1rIxNDSGSlD8xO1YmAz+ouh1DxdHvF8ABjfAl5XytP2/MklEKnr5OX0+ii9tDMo6oxM4
         8YMvNhXr3B2r6YIThwMyIS1OzgjpXQA7916Xih6I+HCw9udG2u52MY0sD+V/3uFjIzAm
         UwQH72jiu8CqakofSAHk6fXBRU1+LySbhFLzWXl9keZooIclggNMLbvpHABMZXrBmS5n
         TZyIc1Ep0Q0Hw6Vbxxvlo3R2ngR+iQugZbUv1e6/UdpqGaJMxEqCalypmoh1hGuCV6SO
         1keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2CMwg5s/2ebjoMZ8nHOuL1j6j+g8aWqCkVHVcRkW+M=;
        b=0hcZiX3WMDg9ZovFaWyUcVuMnmt1AdIXikdKjgvfkz5uMfuo8lRTpKCrp7h6G7DdVw
         aPqhXwpgfWL54gsKzs2HKGlo3StVDFrp4wudPLg0XUlOqrbUFQ3GkVnBpTJfCy4/fCcz
         VE6NaEizCVKDIUy0eVhh2R7NHyxUw2FDdcnTRher+8ndbuEQGPKwTiuiveRnEvLp5UlA
         OMP4KE4Yt3ZUHKRFUR97GasfQT9D/GQCMd6n+D3u1mxwc8Ek2avYjg0XSqN5BPL6oDNZ
         kvgDAjn2Y+awt8WJG9ahYKuUuSpO/qwtsixG1dlOGjl3XQ4u4mNqLPBKAC3dskANfmr7
         qNdA==
X-Gm-Message-State: AJIora+S0r4DRsWl7lFLOjm4P00bk1I/aWk3oNzfrJG5DCwnqvRJDd0/
        P3cM51zY/UUcNwaNmMRsZBmwxqyWG0pkzXOG/a9SVQ==
X-Google-Smtp-Source: AGRyM1vizStKPON2pJWsbdZOujcFDx9C/jbvv39p7DYlWRkFtXmxmqouu7NnPAWQJrD6OdrbbmirUtI/ButALwzwtBM=
X-Received: by 2002:a05:6808:120a:b0:333:54f1:351 with SMTP id
 a10-20020a056808120a00b0033354f10351mr1474130oil.70.1655893649157; Wed, 22
 Jun 2022 03:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com>
In-Reply-To: <CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Jun 2022 12:26:52 +0200
Message-ID: <CAPDyKFpay0w6n6rtv+bsdcTvL4ijtEPBODo1=XJpUFNdaooTcg@mail.gmail.com>
Subject: Re: clk: qcom: genpd lockdep warning in gdsc
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-arm-msm@vger.kernel.org
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

On Fri, 17 Jun 2022 at 21:58, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Hi Bjorn and Dmitry,
>
> Yu reported a lockdep warning coming from the gdsc driver. It looks like
> the runtime PM usage in gdsc.c is causing lockdep to see an AA deadlock
> possibility with 'genpd->mlock'. I suspect this is because we have
> commit 1b771839de05 ("clk: qcom: gdsc: enable optional power domain
> support"), and that is now calling runtime PM code from within the genpd
> code. I think genpd already has nested lock support, so the only
> solution is to not use runtime PM from within genpd code and start
> expressing genpd parent relationships in genpd itself?

Not sure exactly what you mean here, but yes, expressing the
parent/child domain relationship is always needed.

Having gdsc_disable() to do runtime PM calls (gdsc_pm_runtime_put())
seems awkward to me. Why is that needed, more exactly?

> Or maybe genpd
> needs to drop locks while calling down into gdsc_disable() and reacquire
> them after that?

Nope, that doesn't work. This internals of genpd relies on this
behaviour, as it allows it to properly deal with power-on|off for
parent/child domains, for example.

>
> ============================================
> WARNING: possible recursive locking detected
> 5.19.0-rc2-lockdep+ #7 Not tainted
> --------------------------------------------
> kworker/2:1/49 is trying to acquire lock:
> ffffffeea0370788 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
>
> but task is already holding lock:
> ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&genpd->mlock);
>   lock(&genpd->mlock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 3 locks held by kworker/2:1/49:
>  #0: 74ffff80811a5748 ((wq_completion)pm){+.+.}-{0:0}, at:
> process_one_work+0x320/0x5fc
>  #1: ffffffc008537cf8
> ((work_completion)(&genpd->power_off_work)){+.+.}-{0:0}, at:
> process_one_work+0x354/0x5fc
>  #2: ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30
>
> stack backtrace:
> CPU: 2 PID: 49 Comm: kworker/2:1 Not tainted 5.19.0-rc2-lockdep+ #7
> Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
> Workqueue: pm genpd_power_off_work_fn
> Call trace:
>  dump_backtrace+0x1a0/0x200
>  show_stack+0x24/0x30
>  dump_stack_lvl+0x7c/0xa0
>  dump_stack+0x18/0x44
>  __lock_acquire+0xb38/0x3634
>  lock_acquire+0x180/0x2d4
>  __mutex_lock_common+0x118/0xe30
>  mutex_lock_nested+0x70/0x7c
>  genpd_lock_mtx+0x24/0x30
>  genpd_runtime_suspend+0x2f0/0x414
>  __rpm_callback+0xdc/0x1b8
>  rpm_callback+0x4c/0xcc
>  rpm_suspend+0x21c/0x5f0
>  rpm_idle+0x17c/0x1e0
>  __pm_runtime_idle+0x78/0xcc
>  gdsc_disable+0x24c/0x26c
>  _genpd_power_off+0xd4/0x1c4
>  genpd_power_off+0x2d8/0x41c
>  genpd_power_off_work_fn+0x60/0x94
>  process_one_work+0x398/0x5fc
>  worker_thread+0x42c/0x6c4
>  kthread+0x194/0x1b4
>  ret_from_fork+0x10/0x20

Kind regards
Uffe
