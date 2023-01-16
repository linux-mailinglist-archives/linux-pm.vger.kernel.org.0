Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC2C66BCD5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jan 2023 12:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjAPL0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Jan 2023 06:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAPL0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2023 06:26:00 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86B17158
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 03:25:59 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id b12so19449697pgj.6
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4sfoM8UexvDKPwVhCYShKN5KNRJoIP1y6Y9u4zfqss=;
        b=Fxw5+VsR4wh5G53dDEPsWOoOwWNJNUr7ABIUZ7aGZOywbTxntj7m/54G7UVMXafTnx
         sju5VWKoTvX9fMUpIm8Tg6KMO8sZm3cEQ/XpL8peykT0vK+7DNxxwua1P71jVBYpXNy/
         ha/xlik5XlmY51nm3LwhJc/9gtNoFrem40ZRl/0knwg+uYJkSuaC0/FRFTlULQ7LETGH
         uIWSB0Mq84qPFifVdxzVys2qHXh1y5PQd8eyF37lyEZxyagu6d2lS4a0gc7RL8YVfuxW
         7kGkpn3B0655Q/4/bXINACIpT2fiY9yy1dfMexHsaOm9ln0+mTwNidujDjRL0CUy3w1M
         8PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4sfoM8UexvDKPwVhCYShKN5KNRJoIP1y6Y9u4zfqss=;
        b=kk3RKN98U5ASjF+eVXiPHXV1WI4mWiTwM913wf2nT8JfZgTDJLOHnGYEZbEiI+cqrj
         Za3wLmjHO+jTmuia1YzIw5nT/v/O6uKDDhAWKBhZgEkVrgqxOrR1ncb5Sa1Zk3R2BUzB
         j12z5lCZql3Uu1ziKIvTRHQUgoZjP5xqxqgltGU0GCfDw93lC9wyXeTM0Nya1fqBUSmH
         6AjmJRiln1mIg6/GSaiAj2h+GMyG4JlsCqrKSvgO0TjU0oWQgW5XLfqLwtHEyVAn2vzF
         mSLttzSRV8bAWfFxxGyISir/Oh9rRj3Sa6SUpqJdf0LCtBVcROaIfQKhe8P3xqkFP9Jc
         MpaA==
X-Gm-Message-State: AFqh2kqzZ05FuWU1hGyJe6+DzfUojtO5wvf9TTZQSDpYiuf4qe6NFTc6
        PHLBXyrb0921OAICpuVMWFg+X8by08rNyIuARRZw7A==
X-Google-Smtp-Source: AMrXdXsWnIno0X1cLpYxA/Cb+xNkp0Fg8b6QQOt9rkkLir/H00hqkk49eqeqOWo6kWEif8CDXqhpCQ1mZhR00bcFlYw=
X-Received: by 2002:a63:e613:0:b0:4b1:e9a3:292a with SMTP id
 g19-20020a63e613000000b004b1e9a3292amr1622507pgh.545.1673868359263; Mon, 16
 Jan 2023 03:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20221228165415.3436-1-vincent.guittot@linaro.org>
 <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com> <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
 <20230114211854.nmvmhtd5yz5wgh2a@airbuntu> <487f0252-c697-eb62-989d-57ee731691a2@arm.com>
In-Reply-To: <487f0252-c697-eb62-989d-57ee731691a2@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 16 Jan 2023 12:25:48 +0100
Message-ID: <CAKfTPtCBp_HCnsZ-ebupKazyirMNz8NYqTPK0QAE0c6RU6WffQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        mingo@kernel.org, peterz@infradead.org, rafael@kernel.org,
        viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Jan 2023 at 10:21, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 14/01/2023 22:18, Qais Yousef wrote:
> > On 01/13/23 15:28, Vincent Guittot wrote:
> >> Hi Kajetan,
> >>
> >> On Fri, 13 Jan 2023 at 14:50, Kajetan Puchalski
> >> <kajetan.puchalski@arm.com> wrote:
>
> [...]
>
> >>> sched/uclamp: Fix a uninitialized variable warnings
> >>> (baseline_ufc) sched/fair: Check if prev_cpu has highest spare cap in feec()
> >>> sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition
> >>> sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
> >>> sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
> >>> sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
> >>> sched/uclamp: Fix fits_capacity() check in feec()
> >>> sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
> >>> sched/uclamp: Fix relationship between uclamp and migration margin
> >>> (previous 'baseline' was here)
> >>>
> >>> I omitted the 3 patches relating directly to capacity_inversion but in
> >
> > This could lead to confusion. Was there a specific reason for this omission?
> > Did you hit some problem?
>
> I thought Vincent's 'split MF from CPU OU' should replace 'CapInv'?

Current patch v3 applies on top of tip/sched/core which includes
'CapInv'. The end goal being that CapInv becomes useless and can be
removed

>
> https://lkml.kernel.org/r/20221209164739.GA24368@vingu-book
>
> ... I have reverted patches:
> Revert "sched/fair: Detect capacity inversion"
> Revert "sched/fair: Consider capacity inversion in util_fits_cpu()"
> Revert "sched/uclamp: Make cpu_overutilized() use util_fits_cpu()" ...
>
> You also mentioned this in
> https://lkml.kernel.org/r/<20230115001906.v7uq4ddodrbvye7d@airbuntu
>
> [...]
