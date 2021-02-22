Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C832198A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 14:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhBVN52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 08:57:28 -0500
Received: from m12-12.163.com ([220.181.12.12]:51883 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhBVN5O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Feb 2021 08:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=GvcCr
        CM141fUU/BWS1+ek65DoVTCnDSGKRfT0AdtWHI=; b=jP6Aaf3BaNJfyOQvobyyh
        WQjLtwks9fwzgolijAwtnHB5eqM7HGaSveOAgb+5uPbI9DNLELRNld4NE8JdoE68
        f4iF89IGBZf2NYtKsHg1YgNbVaLPFIm920l7VVvCFC9gmZEuOUU6xs0V9Azc+3tf
        fE9CrHmiqniCX1X2APShEA=
Received: from localhost (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowAAXvcGIczNgtAbiRg--.3363S2;
        Mon, 22 Feb 2021 17:04:10 +0800 (CST)
Date:   Mon, 22 Feb 2021 17:04:20 +0800
From:   Yue Hu <zbestahu@163.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yue Hu <zbestahu@gmail.com>, rjw@rjwysocki.net, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210222170420.000019a3.zbestahu@163.com>
In-Reply-To: <20210222053014.s45odi3qsfio2ahp@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
        <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
        <20210219113804.00004a7e.zbestahu@gmail.com>
        <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
        <20210219144140.00004de9.zbestahu@gmail.com>
        <20210219074249.2hcwcnakihor343h@vireshk-i7>
        <20210219162026.00002e2b.zbestahu@gmail.com>
        <20210219093551.bykqhjk6xvs4kszi@vireshk-i7>
        <20210219194509.00005884.zbestahu@gmail.com>
        <20210222053014.s45odi3qsfio2ahp@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DMCowAAXvcGIczNgtAbiRg--.3363S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF45Ary5ZFW5ArW5tF4fZrb_yoW8KF4xpF
        W5Ca9Yvw1DK34kXwn3tF15XFW5XanrA34FgF45Gwn5ZwnFg340grW0ga17CrW5CrnYkr1S
        yr1jqF9FyF1xZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0OJ5UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/1tbiTwpBEVsGXuC4XAAAsS
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 22 Feb 2021 11:00:14 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 19-02-21, 19:45, Yue Hu wrote:
> > We will set next_f to next_freq(previous freq) if next_f is
> > reduced for busy CPU. Then the next sugov_update_next_freq() will check
> > if next_freq matches next_f if need_freq_update is not set.
> > Obviously, we will do nothing for the case. And The related check to
> > fast_switch_enabled and raw_spin_{lock,unlock} operations are
> > unnecessary.  
> 
> Right, but we will still need sugov_update_next_freq() to have the
> same implementation regardless and so I am not sure if we should add

Yes, sugov_update_next_freq() should be keeping current logic for corner case.

> this change:
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 41e498b0008a..7289e1adab73 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -362,6 +362,9 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
>          * recently, as the reduction is likely to be premature then.
>          */
>         if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> +               if (!sg_policy->need_freq_update)

The initial purpose about code of `next_f = sg_policy->next_freq` here (for special CPU busy
case) should be skipping the freq update.

Since commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change"),
we add the check to busy CPU for not skipping the update, we need to update the freq using
computed one because limits change.

After commit 23a881852f3e ("cpufreq: schedutil: Don't skip freq update if need_freq_update
is set"), we removed the need_freq_update check(no issue of commit 600f5badb78c anymore?)
and introduce to always do an update in sugov_update_next_freq() if need_freq_update is set
even though current freq == sg_policy->next_freq because of corner case issue. But that is
conflict with original purpose of the freq skip code (next_f = sg_policy->next_freq) of
busy CPU. 

> +                       return;
> +

Yes, it's what i want ot add for unnecessary behaviors i mentioned above. Add return here
should just be for skipping update(different from corner case in commit23a881852f3e).

>                 next_f = sg_policy->next_freq;
>  
>                 /* Restore cached freq as next_freq has changed */
> 
> 


