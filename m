Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842AC2C034F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgKWK3j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 05:29:39 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39040 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgKWK3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 05:29:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id f11so19163621oij.6;
        Mon, 23 Nov 2020 02:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcVbJeViwjjngoPcvsp+G36iPtj3YiLKTqOwNHU7Q8A=;
        b=VvE5RCLQKwedoSOjL6X1hGJq/1xkL28ggqZTF85aRs4nj0AaVzE2ynuhmQ5z9m3bbt
         fzy3ulpufY+/deePYrDaREDflotraTnrqnjtoj8UcS5uQLysX3+kaqUJRsEcNUg5gvJs
         4tpu07kitDn3w4tQZ/jUtbZo4jJR+1hUfnCEfNdrlWJWU0+X9reYWyGphF68IwZfZBCi
         F1IuTuTz/FL5gRrUGgAoYZrYkoILJO28va4Lv50WqHTc5uOUF7vj7HJP4Pl4YdaVzuU8
         O0pMmCnd6ffN23U74+JaUraR8E1rs6QAEGYG1x9IZ8mcJMGc6lGyYiz9uNJUl6yI2nGT
         BGjw==
X-Gm-Message-State: AOAM532IiVvnW5AOd4Z7D05unnImU5hyqMl7LebYoTcBgTPlI/oBtmA8
        9Y06mn+X+Zs8ITH+efrM1CMVDn6I2pMczfiDFQU=
X-Google-Smtp-Source: ABdhPJwCEzumdWzXpdWdcv7sOWeMlusEI6Tw9t/k9j5O5PQGadD7Jsv4C/7J9P81xS20ZaCTTJ8KTJqt1mPHAUbCZpc=
X-Received: by 2002:aca:f15:: with SMTP id 21mr3245999oip.71.1606127377753;
 Mon, 23 Nov 2020 02:29:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605770951.git.viresh.kumar@linaro.org> <a04646d277f1c93b248346db61c369cb8e7c2d02.1605770951.git.viresh.kumar@linaro.org>
 <CAJZ5v0jViXY56t5LZ-UzTuzA=tq306P0YHwGheoUk+YyTri1xg@mail.gmail.com> <20201123100455.ulpoje32hhrmskou@vireshk-i7>
In-Reply-To: <20201123100455.ulpoje32hhrmskou@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 11:29:26 +0100
Message-ID: <CAJZ5v0gXOfTrEeu=HEeC6=JowbcaC+cdDsDyc40s1SdQJas2LQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 23, 2020 at 11:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-11-20, 13:30, Rafael J. Wysocki wrote:
> > On Thu, Nov 19, 2020 at 8:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > There is nothing schedutil specific in schedutil_cpu_util(), move it to
> > > core.c and rename it to sched_cpu_util(), so it can be used from other
> > > parts of the kernel as well.
> >
> > The patch does more than this, though.
> >
> > I would do that in two patches: (1) move the function as is and (2)
> > rename it and rearrange the users.
>
> Sure.
>
> > >  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> > >  {
> > > -       struct rq *rq = cpu_rq(sg_cpu->cpu);
> > > -       unsigned long util = cpu_util_cfs(rq);
> > > -       unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> > > -
> > > -       sg_cpu->max = max;
> > > -       sg_cpu->bw_dl = cpu_bw_dl(rq);
> > > +       sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
> > > +       sg_cpu->bw_dl = cpu_bw_dl(cpu_rq(sg_cpu->cpu));
> > >
> > > -       return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
> > > +       return sched_cpu_util(sg_cpu->cpu, FREQUENCY_UTIL, sg_cpu->max);
> >
> > I don't see much value in using this wrapper here TBH and it
> > introduces an otherwise redundant cpu_rq() computation.
>
> You want to call effective_cpu_util() here instead, right ?

Right.
