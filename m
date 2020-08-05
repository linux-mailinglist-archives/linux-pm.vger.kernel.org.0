Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801A323C99E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHEJzP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 05:55:15 -0400
Received: from foss.arm.com ([217.140.110.172]:56942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgHEJxu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 05:53:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3109AD6E;
        Wed,  5 Aug 2020 02:53:46 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF4B23F93E;
        Wed,  5 Aug 2020 02:53:43 -0700 (PDT)
Date:   Wed, 5 Aug 2020 10:53:41 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "yangdongdong@xiaomi.com" <yangdongdong@xiaomi.com>,
        "yanziily@xiaomi.com" <yanziily@xiaomi.com>,
        "rocking@linux.alibaba.com" <rocking@linux.alibaba.com>
Subject: Re: [PATCH v4] sched: Provide USF for the portable equipment.
Message-ID: <20200805095341.cmoxmy47ts3ntxee@e107158-lin.cambridge.arm.com>
References: <cover.1596526941.git.yangdongdong@xiaomi.com>
 <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
 <20200804104331.6vphb2iclwz3buig@e107158-lin.cambridge.arm.com>
 <CADhdXfpxWqYEL_cWVtEAxg-3OWgVZuZ5sLzNm6G+k484kG3HRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADhdXfpxWqYEL_cWVtEAxg-3OWgVZuZ5sLzNm6G+k484kG3HRw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/05/20 03:33, Dongdong Yang wrote:
> Appreciate Qais for your above comments. I believe the clamp is very good for
> terminal devices per pid or cgroup setting. I really hope it works for the
> extended scenario, "screen off", although it has a potential side effect on
> "screen on" response because it needs to be recovered  at high level with
> latency. I set  "512" to sched_util_clamp_min and max on screen off for our
> developing device with android kernel5.4. However, it still could not
> replace sched_usf_non_ux_r from the test result as attachment. The cpufreq
> could not go down in time. 
> Screenshot at 2020-08-05 09:56:38.png

Please fix your email client so that it doesn't send in HTML. LKML will reject
HTML emails.

I can't interpret the numbers in the pictures. Can you help explain what am
I looking at?

I did see an issue with frequency not capped immediately when the system was
busy. I am still trying to debug that. I already fixed one problem related to
iowait boost not honouring uclamp requests, I will be posting a patch for this
soon. If you have IO heavy workload, then iowait boost will cause schedutil to
run at high frequency, and uclamp capping is not applied in that path.

Can you trace what happens inside uclamp_rq_util_with() when it's called from
sched_cpu_util()? The clamp should be applied quickly, so it's a bug we need to
fix. In my case I noticed if I ctrl+Z then `fg`, the cap is applied. My hands
are full to look at this soon. So if you can trace it, that'd be great.

Can you expand more on your worry for "screen on"? The only latency I see is
userspace not being able to set uclamp values quickly. But since it seems you
already can set sched_usf_non_ux_r from userspace with acceptable results, then
uclamp should be able to cover the same functionality. What am I missing?

Thanks

--
Qais Yousef
