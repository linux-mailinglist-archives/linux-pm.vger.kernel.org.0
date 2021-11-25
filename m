Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0B45DB29
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 14:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353754AbhKYNhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 08:37:07 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:3253 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbhKYNfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 08:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637847116; x=1669383116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M+sAp6FDBHNbmy+1ZLQA8pXhg95S6T7aLbPwagstLOM=;
  b=F22MrwzAnm9wc2mhBnc5sRKP+9F7XDrq8sFTeqcdvWTzl+aAuPGzZmA+
   AdlN48M3zgabCVWY6l2RPZMshbVcSh6hW79B47seCE9/8bZF9c3yHO4sS
   K1I4R/j0NymLyimRg1ETS3k0qTMGISDEFfo+3b3HYFwf1QMvyONu0R5tR
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Nov 2021 05:31:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 05:31:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 05:31:55 -0800
Received: from [10.216.32.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 25 Nov
 2021 05:31:49 -0800
Message-ID: <f7a1c6de-ae1d-1615-1212-bdb9bdcdbcbc@quicinc.com>
Date:   Thu, 25 Nov 2021 19:01:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/4] sched/core: Export symbols used by cpuidle governors
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <bjorn.andersson@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <quic_lsrao@quicinc.com>,
        <rnayak@codeaurora.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
 <1637830481-21709-3-git-send-email-quic_mkshah@quicinc.com>
 <YZ9Y2w2xIrw39B/K@hirez.programming.kicks-ass.net>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <YZ9Y2w2xIrw39B/K@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On 11/25/2021 3:05 PM, Peter Zijlstra wrote:
> On Thu, Nov 25, 2021 at 02:24:39PM +0530, Maulik Shah wrote:
>> Export symbols that are used by cpuidle menu governor in preparation
>> to allow cpuidle governors to be compiled as modules.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
>> ---
>>   kernel/sched/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 8cffe31..1d031e0 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5047,6 +5047,7 @@ unsigned int nr_iowait_cpu(int cpu)
>>   {
>>   	return atomic_read(&cpu_rq(cpu)->nr_iowait);
>>   }
>> +EXPORT_SYMBOL(nr_iowait_cpu);
> NACK, that function is batshit insane, exporting it serves nobody.
Thanks for the review.
Exporting is to serve cpuidle menu governor when its compiled as module 
(last patch in this series).

otherwise we get below error during compilation,
ERROR: modpost: "nr_iowait_cpu" [drivers/cpuidle/governors/menu.ko] 
undefined!

Do you suggest to use something else instead of this?
I think making this function inline and moving to linux/sched/stat.h 
(along with dependent data structures) may help but yet to try.

Thanks,
Maulik
