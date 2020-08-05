Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A48423CD6C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHERaN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 13:30:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbgHER1g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 13:27:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE2281063;
        Wed,  5 Aug 2020 05:41:33 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A34A93FA1C;
        Wed,  5 Aug 2020 05:41:31 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:41:29 +0100
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
Message-ID: <20200805124128.kfx7uofqnrtk6kux@e107158-lin.cambridge.arm.com>
References: <cover.1596526941.git.yangdongdong@xiaomi.com>
 <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
 <20200804104331.6vphb2iclwz3buig@e107158-lin.cambridge.arm.com>
 <CADhdXfpxWqYEL_cWVtEAxg-3OWgVZuZ5sLzNm6G+k484kG3HRw@mail.gmail.com>
 <20200805095341.cmoxmy47ts3ntxee@e107158-lin.cambridge.arm.com>
 <CADhdXfqJhE6F9q2dhnRhZGQvgJ0GSWXG1AmgL9i+rYqAwxvZDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADhdXfqJhE6F9q2dhnRhZGQvgJ0GSWXG1AmgL9i+rYqAwxvZDw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/05/20 19:13, Dongdong Yang wrote:
> Appreciate Qais for your clamp implementation. I would like to add traces
> for uclamp_rq_util_with and feedback you if I run into any issues.

Thanks.

FYI, top posting in LKML is frowned upon. Please put your answer underneath the
quoted text.

> 
> The util would not be adjusted as soon as FB screen on notification be
> received by USF from kernel level if it is set by sched_usf_non_ux, no
> matter whether screen on or off. However, sched_util_clamp_min/max have not
> been recovered until user space screen on detection. The screen on response
> would not be in time for the sensitive user when many background tasks are
> running.  Whether the kernel module could also
> set sched_util_clamp_min/max?

For boosting, are you just changing the sysctl or are you actively using
sched_setattr() to boost tasks too?

Please have a look at the documentation for the sysctl interface.

	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/Documentation/admin-guide/sysctl/kernel.rst?h=sched/core#n1065

In summary, they just control the _allowed_ levels. So you can use it to
cap/throttle the maximum performance level the system is running at. But you
can't use it to boost the whole system. You must use the sched_setattr() to
boost important tasks individually or if all the tasks are in a cgroup you
can use that. For cgroup interface there's a caveat. If you want to use it
let me know so I can explain how boosting would work there.

I advise to use the sched_setattr() interface to target and boost those
important tasks only. You can as well be smart and target all the background
tasks to cap them via sched_setattr(). In this case you wouldn't have to modify
the sysctl_sched_util_clamp_min/max.

I don't see uclamp being a suitable interface for in-kernel users. PM_QOS is
more suitable in my opinion for in-kernel users if you want to impact the
overall system performance.

I might have misunderstood what you were saying above. If so, can you please
rephrase?

Thanks

--
Qais Yousef
