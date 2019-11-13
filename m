Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B269FFB707
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 19:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfKMSJk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 13:09:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36893 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKMSJj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 13:09:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so3091456wmj.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M+vh+JtPBA/nELsdW8FXtsVseJ/XSaHzYgPaZO1dM+k=;
        b=ymS1XAraf98PBmkpZgbandG8SepionTVitSyVJ3HE5CT9CgRmGSWPljQ6pHaDOT6bv
         SOwwIVal93txZ45NRyKqlavEHJdQeYEIFJDldelwfpokq0npZ8qcGOtCfuZsoHSa+A6Z
         Lg2dE1YIwma3+snkOjhYe/tIQmdVpniaY4LTjoQMaj8QQkwvGhnPUlbtpHFolHPM3o9k
         tpILFP4wXYDOeOUMte7X5iNidAeSth6TwP5BF/3Gk1HtyOK6J4mNl8/MBi4jEwIpxaXq
         LLQgtUCymMMlVeelxIBEk/WA6CPrPQh4uDoASJncvwUTNOVUTUNtfWN6ENVOUmTtzwD+
         cy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M+vh+JtPBA/nELsdW8FXtsVseJ/XSaHzYgPaZO1dM+k=;
        b=hDBBqQSygx2peGDa7+d7tAgmuMtm+4nVt85wjhPmJhPAUm6PucradTKXPl933zmCgl
         atuZYnu57mVWuXRW/bNiMGUYMbaZyg9WeArq20Q5vokRZ5oPpV3vyvAd4Q89R1bBSCCy
         aLsW5tssEaG6RKISvKopkCdGjZ/Yrz5J6wB1sfKDzHMU122pVeudFdq3UWVJ0iNv4bT1
         SD4ldwjT6qUuyZLCHs0DqL7zwiECIufJDD3pcrXNPBcEHvzvwqzo+czle8+/A6W01B4k
         crrAA/WTJmXfKRfbv6vW6weTu/+aIbgi03cvfduSLhv14ANyh576naie4vt7Rd8DmgJS
         GOZw==
X-Gm-Message-State: APjAAAXeY0xvqMpHIEtuu/XoC2+2BcTmfeosEDfXcgs8GyC7w8sixUIp
        Wmy3NgYlPWTz8T8IUAx5q21KcA==
X-Google-Smtp-Source: APXvYqx1692n6c6jZamqQWXLIh1PjQUnanC8Gmv1QQBmTl6/FzG1v9T/32/TTnlGT7giZXO7b4hBtA==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr4117921wmb.96.1573668575773;
        Wed, 13 Nov 2019 10:09:35 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:bdd0:28e6:f0d9:a18c])
        by smtp.gmail.com with ESMTPSA id z8sm3605501wrp.49.2019.11.13.10.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 10:09:34 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:09:32 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] sched/freq: move call to cpufreq_update_util
Message-ID: <20191113180932.GA24352@linaro.org>
References: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
 <20191112150544.GA3664@linaro.org>
 <3b8cafb7-894d-c302-e6c6-b5844b1298b5@arm.com>
 <CAKfTPtBMNnM2tTfb72VtufDpwBvqu6Ttj3dnLgoNOZ--Q6qo+Q@mail.gmail.com>
 <bcba52bc-6780-1efc-6ef4-1a75f1cef33d@arm.com>
 <20191113175035.GA8553@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191113175035.GA8553@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le Wednesday 13 Nov 2019 à 18:50:35 (+0100), Vincent Guittot a écrit :
> Le Wednesday 13 Nov 2019 à 15:09:47 (+0100), Dietmar Eggemann a écrit :
> > On 13.11.19 14:30, Vincent Guittot wrote:
> > > On Wed, 13 Nov 2019 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >>
> > >> On 12.11.19 16:05, Vincent Guittot wrote:
> > >>> Le Tuesday 12 Nov 2019 à 15:48:13 (+0100), Vincent Guittot a écrit :
> > 
> > [...]
> > 
> > >>>> @@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
> > >>>>       * that RT, DL and IRQ signals have been updated before updating CFS.
> > >>>>       */
> > >>>>      curr_class = rq->curr->sched_class;
> > >>>> -    update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> > >>>> -    update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> > >>>> -    update_irq_load_avg(rq, 0);
> > >>>> +    decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> > >>>> +    decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> > >>>> +    decayed |= update_irq_load_avg(rq, 0);
> > >>
> > >> Why not 'decayed  = update_cfs_rq_load_avg()' like in the
> > >> !CONFIG_FAIR_GROUP_SCHED case?
> > > 
> > > Because it is handled by the update_load_avg() in
> > > for_each_leaf_cfs_rq_safe() loop
> > > 
> > > This means that we can have 2 calls to cpufreq_update_util in
> > > update_blocked_average() but at least the values will be up to date in
> > > both calls unlike previously.
> > > 
> > > I'm going to prepare an additional patch to remove this useless call.
> > > I have also seen some possible further optimization that i need to
> > > study a bit more before preparing a patch
> > 
> > I see. The update_load_avg() call for the taskgroup skeleton se
> > (cfs_rq->tg->se[cpu]). But what happens to the cpu which only has the
> > root cfs_rq i the list? It doesn't have a skeleton se.
> 
> you're right. I have to add the following to make sure it will be called
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2eb1aa8..9fc077c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7604,9 +7604,13 @@ static void update_blocked_averages(int cpu)
>                         cpu,
>                         cfs_rq == &rq->cfs ? 0 : (long)cfs_rq->tg );
>  
> -               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> +               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
>                         update_tg_load_avg(cfs_rq, 0);
>  
> +                       if (cfs_rq == &rq->cfs)
> +                               decayed = 1;
> +               }
> +
>                 trace_sched_load_contrib_blocked(cpu,
>                         &cfs_rq->avg,
>                         cfs_rq == &rq->cfs ? 0 : (long)cfs_rq->tg );

the proper fix without some debug trace events :-)

@@ -7567,9 +7569,13 @@ static void update_blocked_averages(int cpu)
 	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
 		struct sched_entity *se;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq, 0);
 
+			if (cfs_rq == &rq->cfs)
+				decayed = 1;
+		}
+
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))



> 
> 
