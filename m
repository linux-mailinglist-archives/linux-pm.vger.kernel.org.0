Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCC67AB92
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 09:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAYI0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 03:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjAYI0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 03:26:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D29C366BB
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 00:26:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso1273899pjp.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 00:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LgCyJ0JIbzlBz0P4o9IQnpeiV1wz86DjUPsFHIQ6zOw=;
        b=DwAcjuNFKn4Ga9kQ/yRFOKkH/baTYHVQDjyNI6X9oqNgYzKJ7bsFFyA58174bY1DAZ
         YsCjt4gMZELUKUwSo2WQWiWzLiID5o2atruMCJoytFJh5RAWwLWjcehvkLMekqgqy4qa
         y2h9h7rxay2yQOy5MGVeyYTEKRpv3axiUvyGt3R7fZ/IlKXNjeqkzMCzMyjJ8AfBKwfB
         UXqujQp2x7C4V0gfvfBtJ3gQ9zHi7DcPhikT95e/CVrh3+PAuKK5ieY7X8bPqEAxua8U
         UPYdDoUxUE1z1CPIDU/X1rG3+ApSCRNcbXNjBIyHtG+mGpv3Vfkq9hIj93kYHOS3Jwpp
         n7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgCyJ0JIbzlBz0P4o9IQnpeiV1wz86DjUPsFHIQ6zOw=;
        b=Q2EvAfLAc5tSOI5kzCozHVR1P34C7DIwSTPU3ap4z53n7Cp6OATswZnSLGGcB59Gt3
         FRuPpR1o/hIdXklzJcg1Yv64e/jkC0XQYi680xvjWo8HxOFXAeX3cj0nnzrTYyU77FLw
         CFUtN5pn94/209o2NP1MhFSksPzjdfO+OQfLZB7326YH5awM/sEu7Z8e9181gclNT6ih
         L1d2gf4HsfGfB3s9iHSWK/zrj3ZLoWvghYlhqPMXdgyusoYNvMM/sn9InNACvl2drCxW
         65xcUQNJLTS6q8IhVnK1va6uaFjpDGdKGxEbmWXrq1UdN7uFNjVSg1msrY0A06FzI0DZ
         /yfw==
X-Gm-Message-State: AFqh2kqifyfEbrA0zI5QURQ4elwvacmE1+vD4GzsOC25gbzlZnlkZfou
        qXaQ3Eu3602A2RS8uznSyVNXIGBSIZyYZswjrM/yUQ==
X-Google-Smtp-Source: AMrXdXti9F1jCy17OafGrNTn34a99NxlHzxJXktX0eBliMRumKhw54WdTj/3eGIDEMDGLeZkG3jaCWBdBRB0oyKy17E=
X-Received: by 2002:a17:90a:c004:b0:227:1f55:158d with SMTP id
 p4-20020a17090ac00400b002271f55158dmr3776265pjt.92.1674635191798; Wed, 25 Jan
 2023 00:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20230119174244.2059628-1-vincent.guittot@linaro.org> <Y855HxG8hK78+NtQ@e126311.manchester.arm.com>
In-Reply-To: <Y855HxG8hK78+NtQ@e126311.manchester.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 25 Jan 2023 09:26:20 +0100
Message-ID: <CAKfTPtAfu=VrDm++8GkD1wU0SEJYT24ACZfk2Ncn7RAqzAH9cA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 23 Jan 2023 at 13:10, Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg may
> > not fit a high capacity cpu because of uclamp_min constraint.
> >
> > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > a CPU except for the uclamp_min hint which is a performance requirement.
> >
> > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > can use this new value to take additional action to select the best CPU
> > that doesn't match uclamp_min hint.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > Change since v3:
> > - Keep current condition for uclamp_max_fits in util_fits_cpu()
> > - Update some comments
>
> That one condition change from v3 did fix the overutilization issues so
> good news on that front :)
>
> 1. GB5
>
> +-----------------+-------------------------+--------+-----------+
> |     metric      |         kernel          | value  | perc_diff |
> +-----------------+-------------------------+--------+-----------+
> | multicore_score |        baseline         | 2765.4 |   0.0%    |
> | multicore_score |      baseline_ufc       | 2704.3 |  -2.21%   | <-- current mainline regression
> | multicore_score |     ufc_patched_v4      | 2839.8 |   2.69%   | <-- new score improvement
> +-----------------+-------------------------+--------+-----------+
>
> +--------------+--------+-------------------------+--------+-----------+
> |  chan_name   | metric |         kernel          | value  | perc_diff |
> +--------------+--------+-------------------------+--------+-----------+
> | total_power  | gmean  |        baseline         | 2664.0 |   0.0%    |
> | total_power  | gmean  |      baseline_ufc       | 2621.5 |   -1.6%   |
> | total_power  | gmean  |     ufc_patched_v4      | 2729.0 |   2.44%   |
> +--------------+--------+-------------------------+--------+-----------+
>
> 2. Jankbench
>
> +--------+---------------+------------------------------+-------+-----------+
> | metric |   variable    |            kernel            | value | perc_diff |
> +--------+---------------+------------------------------+-------+-----------+
> | gmean  | mean_duration |        baseline_60hz         | 14.6  |   0.0%    |
> | gmean  | mean_duration |      baseline_ufc_60hz       | 15.2  |   3.83%   |
> | gmean  | mean_duration |     ufc_patched_v4_60hz      | 14.0  |  -3.98%   |
> +--------+---------------+------------------------------+-------+-----------+
>
> +--------+-----------+------------------------------+-------+-----------+
> | metric | variable  |            kernel            | value | perc_diff |
> +--------+-----------+------------------------------+-------+-----------+
> | gmean  | jank_perc |        baseline_60hz         |  1.9  |   0.0%    |
> | gmean  | jank_perc |      baseline_ufc_60hz       |  2.2  |  15.39%   |
> | gmean  | jank_perc |     ufc_patched_v4_60hz      |  1.8  |  -5.67%   |
> +--------+-----------+------------------------------+-------+-----------+
>
> +--------------+--------+------------------------------+-------+-----------+
> |  chan_name   | metric |            kernel            | value | perc_diff |
> +--------------+--------+------------------------------+-------+-----------+
> | total_power  | gmean  |        baseline_60hz         | 135.9 |   0.0%    |
> | total_power  | gmean  |      baseline_ufc_60hz       | 155.7 |  14.61%   | <-- current mainline regression
> | total_power  | gmean  |     ufc_patched_v4_60hz      | 131.4 |  -3.26%   | <-- new power saving
> +--------------+--------+------------------------------+-------+-----------+
>
> All in all this comes out better on every metric than the previous
> baseline and way better than current mainline. At least from an Android
> perspective as far as the impacts go I'd say it's probably fine to go
> ahead and apply this.

Thanks for your tests results

>
> Feel free to add this if you'd like:
> Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
>
> > --
> > 2.34.1
> >
> >
