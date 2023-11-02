Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737507DF306
	for <lists+linux-pm@lfdr.de>; Thu,  2 Nov 2023 13:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjKBM7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Nov 2023 08:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBM7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2023 08:59:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CBC125
        for <linux-pm@vger.kernel.org>; Thu,  2 Nov 2023 05:58:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so944647b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2023 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698929938; x=1699534738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nda+509MTdCcAVWnvqFmQxdRWuc9tM4Iop32+RA3uJI=;
        b=RmcStXAWix7qlknAkqx5yQFYCAJVukqqHWjujWeya71mEuNsb5KxZRSS6wnLFy6QYr
         OGEfTOjvyjOISMhyd1Qa1nBUrt4q3M6UzSHcvMEjuMEQAG5QS2g1NXJlTetEX22Uh1+q
         s5q9q/WweykMqTJGu6dsFii1SpCkY32z0d35A5YVXtYcWG8TjSn/YX99GAiUixIb/lhj
         BN/1ibxP0K7yCzQRmNyQzCoJycAz0Eah6NqwTYzU9JQYzHy+GTf4dVfQ7+SN3hFcnQEP
         qpY34sqA0E2rw5HUHRf6hhGa5RoXBv9bM2dkSndKvV4NvMXp5b1FKc2sTWQXHUYa1FBJ
         u1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929938; x=1699534738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nda+509MTdCcAVWnvqFmQxdRWuc9tM4Iop32+RA3uJI=;
        b=KMwdp1v69PNCJOBml12kxcDIWn0X3DMl54orlI26aAo6AC8+Z+P9pSVORo9GII36dk
         yFiV9jy86/7RyWBBU88wo5Qe9L4C0pgVXbZ8n8HF28TI/+/iHtxW0gNZ6DDTO0+Fih+H
         Y552QEMQjDXYMWcxAS9Gjo/XjrLt3ZDsZhIT1PGLvaNo4BKFDBA8b3/AyYDRMn6RR0Y+
         VYE8vEvmc+VJZ/XCY+9Qves47HLMd/MvNHWP0yXYcRdjjTAY7Ovy+Mp0v6E5Qj4Xui4U
         EzjgisUYIT+OAVQaMw9LW14+t0CgVKBvBFLS1LLuVU9iZ+JfqFQHaKzTEp5m1aI18Gzj
         E4TQ==
X-Gm-Message-State: AOJu0Yw6WM7uP0DpqT7K2hdun8zdHRdXX+oDKgFRnXb8PVcvOcv+B4sx
        15zPqhKeRg/ORhKT4XxtZ8xR0UVccquw5pNnqPM0CQ==
X-Google-Smtp-Source: AGHT+IGcERc9A5+LQJd0yCaWrk5coa9BWF3xAQl9PA2emohs1RVO0PyRtm3wTujla4WbJcSj/gYbaELHViLae3BeBtU=
X-Received: by 2002:a05:6a20:7d88:b0:16b:8067:23a7 with SMTP id
 v8-20020a056a207d8800b0016b806723a7mr23055795pzj.24.1698929937710; Thu, 02
 Nov 2023 05:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231026170913.32605-1-vincent.guittot@linaro.org>
 <20231026170913.32605-2-vincent.guittot@linaro.org> <c9e89355-9503-4623-9320-e4a4f57dcd98@arm.com>
In-Reply-To: <c9e89355-9503-4623-9320-e4a4f57dcd98@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Nov 2023 13:58:46 +0100
Message-ID: <CAKfTPtDB50ytNap_XhiNtopZ8KLMVvJEspaEfsTOXS_TPKtkaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/schedutil: rework performance estimation
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org,
        viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2 Nov 2023 at 13:03, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 26/10/2023 19:09, Vincent Guittot wrote:
>
> [...]
>
> > @@ -153,14 +152,38 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >       return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> >
> > +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > +                              unsigned long min,
> > +                              unsigned long max)
> > +{
> > +     unsigned long target;
> > +     struct rq *rq = cpu_rq(cpu);
> > +
> > +     if (rt_rq_is_runnable(&rq->rt))
> > +             return max;
> > +
> > +     /* Provide at least enough capacity for DL + IRQ */
> > +     target = min;
> > +
> > +     actual = map_util_perf(actual);
> > +     /* Actually we don't need to target the max performance */
> > +     if (actual < max)
> > +             max = actual;
> > +
> > +     /*
> > +      * Ensure at least minimum performance while providing more compute
> > +      * capacity when possible.
> > +      */
> > +     return max(target, max);
>
> The superfluous `unsigned long target` is still there?

Yeah, I forgot to add the change in this version but it's in the next one

>
>   return max(min, max) is much cleaer.
>
> [...]
