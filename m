Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8AF669069
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 09:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbjAMIQK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 03:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbjAMIPj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 03:15:39 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1305792C
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 00:14:26 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 200so9464756pfx.7
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 00:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0FsBVBmfB/H+Y5/KzKaDMSTPpmYjsoB85VM4zL2yMS8=;
        b=rMfGJ68HJK8Jlqj7h7DVh+ltD81hJdwaDe30H4cTCaZLj6bHu72iDeKWdqgiNwsjj8
         H5gufzfCvmWKlKgrt3j33rBli2JnptlH6v/gCsNSD8X/QLOfZVaIoYhwuHtzv9bi0C1u
         nQbYxoKYfQ1qdtRBYbB2YGkL3i+rBITOrL/Ct+R0hwei/RBrIoWFSx8VjLOfCJgyT69y
         m8/7tHhknyTdEQJmzGIceHncp48LF91yrOgKGc0KQp5tesFI2cHn4w9aqNptJlT808E/
         vBNXAxFthhvYdPrdBcIspcBeUzV7sfp5T/ZoDKaVzaZCKOQT2L/UnOLnw5dNRjt7KsgG
         TUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FsBVBmfB/H+Y5/KzKaDMSTPpmYjsoB85VM4zL2yMS8=;
        b=ge2Xjnf0Vk17KQGB5s2PB8kRX0Qb5Pg3U6IZDdQe05NGz5JCtWzqRf3R8EXztCiZGX
         h0Ie3rK1bnHjj2Ddzs5FKZ7x0vbiU1q5Uyqlrq1A9XT0h0jydpShLfh2QypE4P2W1ABd
         Edhbj/6KgO0UbkryNkfjLqnrN96CgfeA1AYzLlTBzGC9zGgOdNihSGeKUYRuhq0x3/Aa
         P83hg9oBgtjg7SL6PMmlq1j3LiGjX2jBv5VQyZgtYQWzpmc4TKoV7RPnzwXX0kAk6YP9
         rWrVrxEt1Q0JuJpBH9CsPP1jy+6zUX2hsKjzMac2yF2Z1aCDAQm20WZ3BkXIG5nSNFDx
         Uhvw==
X-Gm-Message-State: AFqh2kr8nLmOI9/mJf0kI9G2VOyf7mwcfhJb7afkjhKRTIfuGlUfUwFw
        uxP3Z/tfs27DgL8vHfKGbXqTWAKmA3JybD9GDviS7w==
X-Google-Smtp-Source: AMrXdXs4bWSVsmmRf9cfAoDNEQqEJWJ9TSanmNzWQpNea6UnN8+GIDHATGBbv4A/sJ/Ql2N2eurHpgAmaQsWrrxDA20=
X-Received: by 2002:a62:506:0:b0:57f:ccb0:8ddf with SMTP id
 6-20020a620506000000b0057fccb08ddfmr5455626pff.36.1673597666199; Fri, 13 Jan
 2023 00:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20230112122708.330667-1-qyousef@layalina.io> <20230112122708.330667-3-qyousef@layalina.io>
In-Reply-To: <20230112122708.330667-3-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Jan 2023 09:14:15 +0100
Message-ID: <CAKfTPtD2kHJUc_my21Wu2c4jZhb0z3vFceF1QfiPMKN6mWQgbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] sched/fair: Fixes for capacity inversion detection
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 12 Jan 2023 at 13:27, Qais Yousef <qyousef@layalina.io> wrote:
>
> Traversing the Perf Domains requires rcu_read_lock() to be held and is
> conditional on sched_energy_enabled(). Ensure right protections applied.
>
> Also skip capacity inversion detection for our own pd; which was an
> error.
>
> Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5a8e75d4a17b..34239d3118f0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8992,16 +8992,23 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>          *   * Thermal pressure will impact all cpus in this perf domain
>          *     equally.
>          */
> -       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> +       if (sched_energy_enabled()) {
>                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> +               struct perf_domain *pd;
> +
> +               rcu_read_lock();
>
> +               pd = rcu_dereference(rq->rd->pd);
>                 rq->cpu_capacity_inverted = 0;
>
>                 for (; pd; pd = pd->next) {
>                         struct cpumask *pd_span = perf_domain_span(pd);
>                         unsigned long pd_cap_orig, pd_cap;
>
> +                       /* We can't be inverted against our own pd */
> +                       if (cpumask_test_cpu(cpu_of(rq), pd_span))
> +                               continue;
> +
>                         cpu = cpumask_any(pd_span);
>                         pd_cap_orig = arch_scale_cpu_capacity(cpu);
>
> @@ -9026,6 +9033,8 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>                                 break;
>                         }
>                 }
> +
> +               rcu_read_unlock();
>         }
>
>         trace_sched_cpu_capacity_tp(rq);
> --
> 2.25.1
>
