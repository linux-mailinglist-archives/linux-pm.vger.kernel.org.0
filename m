Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B8E2C02EE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 11:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgKWKFB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 05:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgKWKFA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 05:05:00 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3967C061A4D
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 02:04:58 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so14442320pfb.9
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/+kjgQ7kH0zqXXycSgIBAgENpr5HbW17/zbGmAo7mI=;
        b=JEC8wayAgl47tFcVPBt+eXaLIJtA+DJINSEFB69mq20FB5TAA2WmcDEmujU7zEpLid
         gk3GGwyT+vGRU42AmcT/FY96kWsdhzxfAH7YNisGMPSxEcWAUbIBU5Z70cqdV7VYfBlQ
         BSJiJo815NLHW8nAkTXBEU89LPgGEDrPNXBChV5opO+q2mEh+TZmjQ9Tt1IaM/+UUTP+
         Ek2s/vGrEMEcHzWg4+ILy47nAa/Gm/3Cd3LB14ROuBr38bmri/Xi5F+1bFIDUAw2ep43
         Y6ln50+/+6XQP0oCRnVKcbqgEknqiTrbUTkTRpycNwG/33lAJr9Ywe/5DpXFyDBNOlgK
         e1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/+kjgQ7kH0zqXXycSgIBAgENpr5HbW17/zbGmAo7mI=;
        b=JCVlOmbvnaWr31+G8Voz+XaSJl4dHzSGEOLbGAsTmkiHJAHMWUtwwzynaTUAIZ1T7C
         AGd+EIlFZjhpvnZY4IBJ9XYMNU9D/RLzJSO5D6VoqE/NkyPHMNlOMajM6DGjqjrOWLg9
         VVNzLIbf8NED9NA2ATnYSmpIXw59epcyEdPohLV5dyvnjcot4pfW0CLlzXDO3mZhpnib
         xM4GIM43Jsa5MHFkWFBlwzpLFBzp0gxr7XFln/kqg7P+xAgp64G0JvD/eZ6J1FVyuStr
         qr2+hrnOF9LEctCJAvgEZ/EouKqo7i4DwWLRWxxakq7Ly2jX1QvLuZ+u23mDqp63E3nd
         2RFA==
X-Gm-Message-State: AOAM533Vka8lgsNkSNouOgVkukZnY5msXVBG2K8u1RG9SfaUD7tUGLBR
        ecfOhmJzqhQkeebNhW1jGO6v3Q==
X-Google-Smtp-Source: ABdhPJwS9YUokyi/0QFidcR+WnFf11NCzM5Zxj+QmA+PUnzE40R/L0+PUueE+x78gHZrilgjVyh8IA==
X-Received: by 2002:a17:90a:2941:: with SMTP id x1mr8411812pjf.25.1606125898284;
        Mon, 23 Nov 2020 02:04:58 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id i26sm11437809pfq.148.2020.11.23.02.04.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 02:04:57 -0800 (PST)
Date:   Mon, 23 Nov 2020 15:34:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
Message-ID: <20201123100455.ulpoje32hhrmskou@vireshk-i7>
References: <cover.1605770951.git.viresh.kumar@linaro.org>
 <a04646d277f1c93b248346db61c369cb8e7c2d02.1605770951.git.viresh.kumar@linaro.org>
 <CAJZ5v0jViXY56t5LZ-UzTuzA=tq306P0YHwGheoUk+YyTri1xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jViXY56t5LZ-UzTuzA=tq306P0YHwGheoUk+YyTri1xg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-11-20, 13:30, Rafael J. Wysocki wrote:
> On Thu, Nov 19, 2020 at 8:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > There is nothing schedutil specific in schedutil_cpu_util(), move it to
> > core.c and rename it to sched_cpu_util(), so it can be used from other
> > parts of the kernel as well.
> 
> The patch does more than this, though.
> 
> I would do that in two patches: (1) move the function as is and (2)
> rename it and rearrange the users.

Sure.

> >  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> >  {
> > -       struct rq *rq = cpu_rq(sg_cpu->cpu);
> > -       unsigned long util = cpu_util_cfs(rq);
> > -       unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> > -
> > -       sg_cpu->max = max;
> > -       sg_cpu->bw_dl = cpu_bw_dl(rq);
> > +       sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
> > +       sg_cpu->bw_dl = cpu_bw_dl(cpu_rq(sg_cpu->cpu));
> >
> > -       return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
> > +       return sched_cpu_util(sg_cpu->cpu, FREQUENCY_UTIL, sg_cpu->max);
> 
> I don't see much value in using this wrapper here TBH and it
> introduces an otherwise redundant cpu_rq() computation.

You want to call effective_cpu_util() here instead, right ?

-- 
viresh
