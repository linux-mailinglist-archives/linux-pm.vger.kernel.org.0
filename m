Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EFF6716C3
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjARI7o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 03:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjARI6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 03:58:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2CC46172
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:16:10 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso1562616pjg.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn3GGCQC7Lq3SjAD0sxaBFxcbnbqZOohuV+R+jjZOJo=;
        b=ykKlwt/MKf9r1oA+04Qe2lbveRmL590iNsfp3mTwuWkNDRU6QHrPrC87Vj8YNqgKwU
         /KoGBYyEHufmakGpK7ZbzviMX3L6zc7tJs+wjJ8sKs7O+T+i6F/FG7NT6q2rKcFNMSYI
         BYDArkhjK+8q4g74fvtqympfujvYcLc7noIMSnOv6ug58QNP9KXJFLqnCKYM27hmxARA
         KHArh+f0NzPYeOBiTOXRT+XG9JHR/riEKMV/u8BWJ+sejnLBK0kf+9KTLUIWUYpJK+dG
         GP6Tpdhvn75Wr+UYmnbJyYETfKbGftNE30SpNsnCU4w02EWUghelaBLSeSjqKD8mVf0p
         rqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn3GGCQC7Lq3SjAD0sxaBFxcbnbqZOohuV+R+jjZOJo=;
        b=GngfO9j78t/5VZu1flew9zY/q6axDK8zz4Vf9uECLlZTt1qzKCODggciQsNM2Etd9I
         nl5OWeskn3w88h4VxBITTtZ8zM1z782ijEwFW1y6JWnkd57isI4BMgzVk/FAJgv4GDib
         cgfK4w+b0NOu8HEgFd+3w//zcny0aO4t2p65JZ9TR1BvQyDXz/lFdoT+kbTWxPivOTgD
         tXY8XumR9deDZt0j+p3WsmNJWDwPApIi+zH4KGLhRc1qjJD0HGJYrUsYuzcDD4iWEyHZ
         0Em5jx0uKu7IUp6Kun2yeyzMi51pvFp/ptx2nt3GHdmSJb+CBNwZ/F2wNWvNLtbI3MWm
         sw/w==
X-Gm-Message-State: AFqh2kpp6yRWfXcwM+ocm3Xcca1Gfs9RLEIy3yZXGQL1qt0Q2EQqEf1v
        zZpKMrdC9/EkzpDRp7H5OvWY703NiB7LJKCoR7+h5g==
X-Google-Smtp-Source: AMrXdXv6CK17QdCPdMdtnEp20WR3c/rupdsnOPIK42WM7fiMBH4nhVv4NQDYQVYEzVNBJV4dZ6CJp2a0RFajEA6+eL0=
X-Received: by 2002:a17:90a:30d:b0:215:f80c:18e6 with SMTP id
 13-20020a17090a030d00b00215f80c18e6mr676658pje.45.1674029769810; Wed, 18 Jan
 2023 00:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <78bf2d91-0076-f748-7c6a-530dad466787@arm.com> <CAKfTPtCAAOvFak2FqkKv2AwnoBZ3cwbMwfnAAGqDx+Wq4Ng+zw@mail.gmail.com>
 <7a6182dd-89f5-69c5-4331-2f102dc0418d@arm.com>
In-Reply-To: <7a6182dd-89f5-69c5-4331-2f102dc0418d@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 18 Jan 2023 09:15:58 +0100
Message-ID: <CAKfTPtCfbVgwPGYgw4vuO3UgEFM9GbMzyrzkgCoeL7onZXQXBg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@kernel.org, peterz@infradead.org, qyousef@layalina.io,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
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

On Mon, 16 Jan 2023 at 15:56, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 16/01/2023 12:23, Vincent Guittot wrote:
> > On Mon, 16 Jan 2023 at 10:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 13/01/2023 14:40, Vincent Guittot wrote:
>
> [...]
>
> >>> @@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
> >>>       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> >>>       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> >>>
> >>> +     /* Return true only if the utlization doesn't fit its capacity */
> >>
> >> s/utlization/utilization
> >> s/its/CPU ?
> >>
> >>>       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> >>>  }
> >>
> >> cpu_overutilized() is the only place where we now only test for
> >> !util_fits_cpu(). The new comment says we only care about utilization
> >> not fitting CPU capacity.
> >>
> >> Does this mean the rq uclamp values are not important here and we could
> >> go back to use fits_capacity()?
> >>
> >> Not sure since util_fits_cpu() is still coded differently:
> >
> > uclamp_min is not important but uclamp_max still cap the utilization
>
> OK, makes sense.
>
> I.e. we could pass in `rq_util_min = 0` to avoid fetching it
> unnecessary? In case `fits == 1` before the uclamp_min condition in
> util_fits_cpu() it doesn't matter if we switch to return `-1` when
> called from cpu_overutilized(). Detail though ...

One comment from Qais was to minimize knowledge outside
util_fits_cpu() that's why I pass both uclamp_min and uclamp_max.

>
> [...]
>
> >>> @@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >>>
> >>>               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> >>>                       continue;
> >>> -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> >>> +
> >>> +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> >>> +
> >>> +             /* This CPU fits with all capacity and performance requirements */
> >>
> >> In task_fits_cpu() `utilization and performance (better uclamp)
> >> requirements` term was used. I assume it's the same thing here?
> >>
> >>> +             if (fits > 0)
> >>>                       return cpu;
> >>> +             /*
> >>> +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
> >>> +              * for the CPU with highest performance capacity.
> >>                                             ^^^^^^^^^^^^^^^^^^^^
> >>
> >> Do we use a new CPU capacity value `performance capacity (1)` here?
> >>
> >> Which I guess is `capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu)`.
> >>
> >> I'm asking since util_fits_cpu() still uses: `capacity_orig_thermal (2)
> >> = capacity_orig - arch_scale_thermal_pressure()` when checking whether
> >> to return -1. Shouldn't (1) and (2) be the same?
> >
> > I'm all in favor of both being capacity_orig_of(cpu) -
> > thermal_load_avg(cpu_rq(cpu) like the capacity inversion detection
>
> I think we need a handy name for this new capacity value, which seems to
> be `capacity_orig - capacity reduced by thermal`. And we should either
> use `thermal_load_avg` or `thermal pressure` for the latter part. And
> then we should use this consistently in all these places:
> util_fits_cpu(), feec(), sic().

Ok, let me change this everywhere

>
> [...]
