Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675E245DC23
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350338AbhKYOTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 09:19:04 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6050 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239002AbhKYORD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 09:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637849632; x=1669385632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9B1kagCGofhMafAlXRiDA3X0zfmqJUebEtDe625FPrc=;
  b=FnP5F9nhO6KVaQL1aSUsoPwLmx0SOC0NHuZgBdjrTMpRwUfMSWjFqO2c
   YbHep6FhUenwDPyu5S8P4XyHuFKVGyjYAP6iNn2CAd4YF2VikRO9LLzQA
   fKBp+E0Vao1M42dpAoX2gCVPeQBhZ8LV0uSNxBbMq53qfCYPFPzyKCfnu
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Nov 2021 06:13:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 06:13:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 06:13:51 -0800
Received: from [10.216.32.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 25 Nov
 2021 06:13:45 -0800
Message-ID: <687d97b6-347a-92c0-34ba-00331dfb6c82@quicinc.com>
Date:   Thu, 25 Nov 2021 19:43:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] sched/idle: Export cpu_idle_poll_ctrl() symbol
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <quic_lsrao@quicinc.com>,
        <rnayak@codeaurora.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>
References: <1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com>
 <YZ9ctgCBYJEEjuwt@hirez.programming.kicks-ass.net>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <YZ9ctgCBYJEEjuwt@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On 11/25/2021 3:21 PM, Peter Zijlstra wrote:
> On Thu, Nov 25, 2021 at 02:44:36PM +0530, Maulik Shah wrote:
>> Export cpu_idle_poll_ctrl() so that module drivers can use same.
> This does not seem like a really safe interface to expose to the
> world.

Thanks for the review.

Keeping the cpuidle enabled from boot up may delay/increase the boot up 
time.
Below is our use case to force cpuidle to stay in cpu_idle_poll().

We keep cpuidle disabled from boot up using "nohlt" option of kernel 
command line which internally sets cpu_idle_force_poll = 1;
and once the device bootup reaches till certain point (for example the 
android homescreen is up) userspace may notify a
vendor module driver which can invoke cpu_idle_poll_ctrl(false); to come 
out of poll mode.
So vendor module driver needs cpu_idle_poll_ctrl() exported symbol.

We can not take PM-QoS from driver to prevent deep cpuidle since all the 
vendor modules are kept in a separate partition and will be loaded only 
after kernel boot up is done
and by this time kernel already starts executing deep cpuidle modes.
>
> Surely the better solution is to rework things to not rely on this. I'm
> fairly sure it's not hard to write a cpuidle driver that does much the
> same.
The other option i think is to pass cpuidle.off=1 in kernel command line 
and then add enable_cpuidle() in drivers/cpuidle/cpuidle.c
something similar as below which can be called by vendor module.

void enable_cpuidle(void)
{
         off = 0;
}
EXPORT_SYMBOL_GPL(enable_cpuidle);

This may be a good option since we have already disable_cpuidle() but 
not enable_cpuidle().

void disable_cpuidle(void)
{
         off = 1;
}

Hi Rafael/Daniel, can you please let me know your suggestion on 
this/similar implementation?

Thanks,
Maulik
