Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF263D3AA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Nov 2022 11:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiK3Kmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Nov 2022 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiK3Kmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2022 05:42:35 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F3BB1
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 02:42:32 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d14so5393718ilq.11
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2022 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJLkT7UJgdz9DbjtRID1Ehj3joyySjkZxkwxrfsCaVE=;
        b=hxQWQWHB1MfR6QvYlK0kOcOu8nIcceTFo7sWaaSq0mp2yBsphoiSrRC3li6pHxRXw0
         Go2QQj8rffhY/e/hLL6gKwwOnT/dz4oxoH/CpDYt+KZMbHF9fcH63EA8mbbx52L/WoND
         Z4MS5wEaNEU1LngpSFd4WHzk0ucaD+8qgVYX1HqJolFJoM2uYw/qMw+hvqCWmRg11y9f
         q5lgGS0b8f8saSvo7gAgVNrFCOfuD7FCsblMDi10ey+IJb/wnjn5Ma+wQNxKA8TpTjSY
         If1dUuzuxZAO0NxZvzVO4lEc1W1aO2aeYiC2wsJtQQtFb8NRYi3pHAFCS/dltFt+w8w8
         Ah5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJLkT7UJgdz9DbjtRID1Ehj3joyySjkZxkwxrfsCaVE=;
        b=3Hcg1eiSCvyn9SIYao7hbMfsI1Tz9vqz7CKIQBnWm7BiH/sETDJICoX91vzvf1thU6
         g326T0rq/5sad4bQSEq/35jnpmCpfW9ODikYqdqgP3ROIYi5Saaj8y0bTcSREZKqCfOq
         D1zhuzeYBMfMXJddP4KUwc/7rISvBzgIPy/QByheRCvnapsYgjblrGEuYTeGCv0c6IEZ
         SMncp6tmtMGnNk2eP3MqICA43NBozE1+4HSGE/q9e7jJQayUdOR0gqs7u/pYFCkuizEc
         4XMcwF12KnTaFZ4IGZvgdSKX4E4DjMxRLwKKt18kGb+ib2pSOV7VXIkxnVsKlQmWYWfy
         rwPw==
X-Gm-Message-State: ANoB5pkgnSLaIwc9EWIXVx6CewreG7Z/oP4+gZk4V6HvkEnfanlj1Vpu
        1cG37QVAngO85fX9v01RjIMpwfoOASCVAFbzEDFA4g==
X-Google-Smtp-Source: AA0mqf677IjGVXXt7NQM3NdWCedqdc8aEXe0zNXEuJOT6eTrU0cAzlxaj8EOQWWoRpGMtpu4fxKNqNisQLM8p0MyymI=
X-Received: by 2002:a92:7c0c:0:b0:302:efa3:6230 with SMTP id
 x12-20020a927c0c000000b00302efa36230mr13856885ilc.232.1669804951940; Wed, 30
 Nov 2022 02:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20221110195732.1382314-1-wusamuel@google.com> <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
 <880b7332-562c-4934-4e92-493b112568c9@arm.com> <CAG2Kctp_VwryYTYMoqe6EBKFs-FZuNcB94e_MzLgBN9jJ5tpQA@mail.gmail.com>
 <CAJZ5v0iNjPAAn0-uygpJe0ya_LW7pfF4C8OHd+8EMLg+Ws=02Q@mail.gmail.com> <97af1300-541d-a79c-404c-92886f10b220@arm.com>
In-Reply-To: <97af1300-541d-a79c-404c-92886f10b220@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Nov 2022 11:42:20 +0100
Message-ID: <CAKfTPtAPniqQyDzh=Yu8Z9R9+H2PzBKkHT0SJgHZiUOdNdw3Mg@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Wu <wusamuel@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All

Just for the log and because it took me a while to figure out the root
cause of the problem: This patch also creates a regression for
snapdragon845 based systems and probably on any QC chipsets that use a
LUT to update the OPP table at boot. The behavior is the same as
described by Sam with a staled value in sugov_policy.max field.

Regards,
Vincent

On Tue, 22 Nov 2022 at 09:58, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael and Sam
>
> On 11/21/22 19:18, Rafael J. Wysocki wrote:
> > On Fri, Nov 18, 2022 at 2:00 AM Sam Wu <wusamuel@google.com> wrote:
> >>
> >> On Wed, Nov 16, 2022 at 3:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>> Which mainline kernel version you use in pixel6?
> >> I am using kernel version 6.1-rc5.
> >>>
> >>> Could you elaborate a bit how is it possible?
> >>> Do you have the sg_policy setup properly (and at right time)?
> >>> Do you have the cpu capacity from arch_scale_cpu_capacity()
> >>> set correctly and at the right time during this cpufreq
> >>> governor setup?
> >>>
> >>> IIRC in Android there is a different code for setting up the
> >>> cpufreq sched governor clones. In mainline we don't have to do
> >>> those tricks, so this might be the main difference.
> >> This behavior is seen on the mainline kernel. There isn't any vendor code
> >> modifying the behavior, and the schedutil governor is being used.
> >>>
> >>> Could you trace the value that is read from
> >>> arch_scale_cpu_capacity() and share it with us?
> >>> I suspect this value changes in time in your kernel.
> >> There's an additional CPU capacity normalization step during
> >> init_cpu_capacity_callback() that does not happen until all the CPUs come
> >> online. However, the sugov_start() function can be called for a subset of
> >> CPUs before all the CPUs are brought up and before the normalization of
> >> the CPU capacity values, so there could be a stale value stored
> >> in sugov_policy.max field.
> >
> > OK, the revert has been applied as 6.1-rc material, thanks!
>
> I was on a business trip last week so couldn't check this.
> Now I'm back and I've checked the booting sequence.
> Yes, there is some race condition and the mechanism
> using blocking_notifier_call_chain() in the cpufreq_online()
> doesn't help while we are registering that schedutil
> new policy.
>
> I will have to go through those mechanisms and check them.
> I agree, for now the best option is to revert the patch.
>
> My apologies for introducing this issues.
> Thanks Sam for capturing it.
>
> Regards,
> Lukasz
