Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7162EAAE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Nov 2022 02:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiKRBA4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 20:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbiKRBAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 20:00:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4804187A4D
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 17:00:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id io19so3210975plb.8
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 17:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSyjpoEZyYB7sc65RrNJJW9qvsOFSuR2P+GcFGf3J/U=;
        b=Y84B3WGLdvH4fmWPofyx680oHlFFLc+robIV5oy+HTKv4FeXfYjzPzoN2dDqAgS1Of
         +YvTfyCodl8LyRnTxhwL3pybk360gMJaw28xwCjx6l9We5pw6rLh1p3c1qyHzcyHP+ul
         ck2a/HWu6vaGI5kP2GWJH+F0U+2cGG9AONx0+GVEiuDcD5K46E+wlWsT4ZO71rraxJ8G
         q5VIC1vf+CX2nWsK2XfBM43up0ltTwfl1JmgVMVXvuJHagd10wXHy3aaeX/zpiZOWhnX
         KHz/U/+3J0U4i+lZgZJJEdHaZ3E3RZJ4yjWwH7+P0tOxO/Arl2hlVxvMd40BBIuLyP10
         wvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSyjpoEZyYB7sc65RrNJJW9qvsOFSuR2P+GcFGf3J/U=;
        b=zPBjWwLOj+MuBo4zoysOMYbkNNL0meO8q941y/7Zq7UnoPfr8SiLjR0EZ4dBibOTkq
         V7V6Iy6PlXlRtCRQ/XEAdBx8WIW5ZXQvgeZroGgZY8MeocqO8FNrfAxX3suON1kn9eXn
         xTkVVO2DlYxv1RbIMywqediH0XZNkavY2F4Alv8SGnQd3YQbHv5ICMs82lXIz3kSuGqH
         r7l3xeVWaP/qDFrq0q1CqQiZXrCprQFvC2psKIv14PkYJzT6Te/zsYUGAmEVmbAM6FRJ
         QCkw1//C4aPtUbg235yBnBeXvshmteFzZ7oMt6Xg75z0N26FiJUb9VSpKXpCAf+JP8ny
         LV7w==
X-Gm-Message-State: ANoB5pnY7k0cJzexL2YbzVjDzKqucaCY+m7X+bnr9cxJgHinsRplLCYc
        kh6J4dzODrGEoYgL6g04R/V+njqzEHcd9UwmgEydwg==
X-Google-Smtp-Source: AA0mqf7oG54d1cQuBTKgnNIM8vm0rE0ZL/PZXHhng8UxQZK0Ov+HCMVukcRBRxM5sgt+toKQ6Cct2WNFfXMpMn/mDcQ=
X-Received: by 2002:a17:902:b691:b0:188:4e75:7365 with SMTP id
 c17-20020a170902b69100b001884e757365mr5310036pls.102.1668733239520; Thu, 17
 Nov 2022 17:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20221110195732.1382314-1-wusamuel@google.com> <CAGETcx_aAynvykDSL4aue3zf5Pv7+hELUHQ=MWOzBbyZBPySDA@mail.gmail.com>
 <880b7332-562c-4934-4e92-493b112568c9@arm.com>
In-Reply-To: <880b7332-562c-4934-4e92-493b112568c9@arm.com>
From:   Sam Wu <wusamuel@google.com>
Date:   Thu, 17 Nov 2022 17:00:28 -0800
Message-ID: <CAG2Kctp_VwryYTYMoqe6EBKFs-FZuNcB94e_MzLgBN9jJ5tpQA@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to sugov_policy"
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 16, 2022 at 3:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> Which mainline kernel version you use in pixel6?
I am using kernel version 6.1-rc5.
>
> Could you elaborate a bit how is it possible?
> Do you have the sg_policy setup properly (and at right time)?
> Do you have the cpu capacity from arch_scale_cpu_capacity()
> set correctly and at the right time during this cpufreq
> governor setup?
>
> IIRC in Android there is a different code for setting up the
> cpufreq sched governor clones. In mainline we don't have to do
> those tricks, so this might be the main difference.
This behavior is seen on the mainline kernel. There isn't any vendor code
modifying the behavior, and the schedutil governor is being used.
>
> Could you trace the value that is read from
> arch_scale_cpu_capacity() and share it with us?
> I suspect this value changes in time in your kernel.
There's an additional CPU capacity normalization step during
init_cpu_capacity_callback() that does not happen until all the CPUs come
online. However, the sugov_start() function can be called for a subset of
CPUs before all the CPUs are brought up and before the normalization of
the CPU capacity values, so there could be a stale value stored
in sugov_policy.max field.

Best,
Sam
