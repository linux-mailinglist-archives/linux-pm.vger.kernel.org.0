Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4100B29E0E4
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 02:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgJ2Bna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 21:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgJ2Bn1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 21:43:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ECCC0613D3;
        Wed, 28 Oct 2020 18:43:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so980616pfn.12;
        Wed, 28 Oct 2020 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=zm+BBylRASVa9dMtNh5bPgNNd17WHbXMVEpNBzpq3mQ=;
        b=dVhSYE45jQtWD2ThQ3ZLSJ8XraGdzSA0MBYZouwfUw6+V+rRhYHHOWUbF8/FCp2Ooa
         wOnW7VbVMAmNRe4oyvUu4gb6YjetNDGaxB4i4gXUGi8Yf/WCkldqEkFIIUjLFMpT35lr
         zim5pch0+zBeQEvvwoUkDGtiwnASLIAdEvsFJDuR/QYWX1fQG3jhTxZJws3RDucqyZnb
         7xr1L+xquAqpSIXoZiVNhz1uvNrqqxi8OF9Bqi6RV+Y6bBZkvMvnVUaV1P+rwINfujlg
         OJfi6FS0mdUYO51eG7zdWvBLAv1VacoYSb+2GtPB+6xU3VBvSBveKGzSnLaU7r80XZXM
         w2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=zm+BBylRASVa9dMtNh5bPgNNd17WHbXMVEpNBzpq3mQ=;
        b=jtUTsxHzM2du0ONi1akcp21afXY0w0TjX5q6m2w0Kw3lXWmq3SzYrr1vI0S/qk98b5
         b3AurFL8Z2sr53KmGiPnBI2RkD538ati530QEk2pZbhRt3ZtJp4J1ee9JV6WlgyxWz9b
         fEQtDmNrSUN02Gof4tYOo6b3weyCOD971lie1++PexjZpzydto/Bu7/qSYCI0UOnL51O
         Ltm9It4Nd9On0uMo7lpyaR21ZFQ2HhudNvqXWck/JvfvNFVTEMFWEQF4UG3zxFvIabVD
         4HkDzr7qqSmZsU8TtUjXTcsqnl3rMowuXZSLkn6PVO7SVBDfPFZ1kN5MyCFzRcwsaWzi
         3Grg==
X-Gm-Message-State: AOAM532ZjSI/7G4SNkoE0a1kgggDzFoicD10rvrHeX5VjdJheQsgXoca
        1Ps63tBISt/7rHgDiDqOQPE=
X-Google-Smtp-Source: ABdhPJw5L3vrpj7lO/plBSqLyF9BU3NXhOgTDHuD7jdlMk01oH68tI9UT3j6pUlwEtPqRAzrtcdcfQ==
X-Received: by 2002:a17:90a:ec11:: with SMTP id l17mr1767038pjy.104.1603935806802;
        Wed, 28 Oct 2020 18:43:26 -0700 (PDT)
Received: from DESKTOPIUKEMQD ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id c187sm848372pfc.153.2020.10.28.18.43.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 18:43:26 -0700 (PDT)
From:   "zhuguangqing83" <zhuguangqing83@gmail.com>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <rjw@rjwysocki.net>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'zhuguangqing'" <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the final cpufreq
Date:   Thu, 29 Oct 2020 09:43:20 +0800
Message-ID: <095901d6ad94$e48d5140$ada7f3c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AdatlJoMZJNjnRtVR/qzDDJYqq4NUw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> On 28-10-20, 19:03, zhuguangqing83 wrote:
> > Thanks for your comments. Maybe my description was not clear before.
> >
> > If I understand correctly, when policy->min/max get changed in the time
> > Window between get_next_freq() and sugov_fast_switch(), to be more
> > precise between cpufreq_driver_resolve_freq() and
> > cpufreq_driver_fast_switch(), the issue may happen.
> >
> > For example, the first time schedutil callback gets called from the
> > scheduler, we reached get_next_freq() and calculate the next_freq,
> > suppose next_freq is 1.0 GHz, then sg_policy->next_freq is updated
> > to 1.0 GHz in sugov_update_next_freq(). If policy->min/max get
> > change right now, suppose policy->min is changed to 1.2 GHz,
> > then the final next_freq is 1.2 GHz for there is another clamp
> > between policy->min and policy->max in cpufreq_driver_fast_switch().
> > Then sg_policy->next_freq(1.0 GHz) is not the final next_freq(1.2 GHz).
> >
> > The second time schedutil callback gets called from the scheduler, there
> > are two issues:
> > (1) Suppose policy->min is still 1.2 GHz, we reached get_next_freq() and
> > calculate the next_freq, because sg_policy->limits_changed gets set to
> > true by sugov_limits() and there is a clamp between policy->min and
> > policy->max, so this time next_freq will be greater than or equal to 1.2
> > GHz, suppose next_freq is also 1.2 GHz. Now next_freq is 1.2 GHz and
> > sg_policy->next_freq is 1.0 GHz,  then we find
> > "if (sg_policy->next_freq == next_freq)" is not satisfied and we call
> > cpufreq driver to change the cpufreq to 1.2 GHz. Actually it's already
> > 1.2 GHz, it's not necessary to change this time.
> 
> This isn't that bad, but ...
> 
> > (2) Suppose policy->min was changed again to 1.0 GHz before, we reached
> > get_next_freq() and calculate the next_freq, suppose next_freq is also
> > 1.0 GHz. Now next_freq is 1.0 GHz and sg_policy->next_freq is also 1.0 GHz,
> > then we find "if (sg_policy->next_freq == next_freq)" is satisfied and we
> > don't change the cpufreq. Actually we should change the cpufreq to 1.0 GHz
> > this time.
> 
> This is a real problem we can get into. What about this diff instead ?
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 0c5c61a095f6..bf7800e853d3 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -105,7 +105,6 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>         if (sg_policy->next_freq == next_freq)
>                 return false;
> 
> -       sg_policy->next_freq = next_freq;
>         sg_policy->last_freq_update_time = time;
> 
>         return true;

It's a little strange that sg_policy->next_freq and 
sg_policy->last_freq_update_time are not updated at the same time.

> @@ -115,7 +114,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
>                               unsigned int next_freq)
>  {
>         if (sugov_update_next_freq(sg_policy, time, next_freq))
> -               cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> +               sg_policy->next_freq = cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
>  }
> 

Great, it also takes into account the issue that 0 is returned by the
driver's ->fast_switch() callback to indicate an error condition.

For policy->min/max may be not the real CPU frequency in OPPs, so
next_freq got from get_next_freq() which is after clamping between
policy->min and policy->max may be not the real CPU frequency in OPPs.
In that case, if we use a real CPU frequency in OPPs returned from
cpufreq_driver_fast_switch() to compare with next_freq,
"if (sg_policy->next_freq == next_freq)" will never be satisfied, so we
change the CPU frequency every time schedutil callback gets called from
the scheduler. I see the current code in get_next_freq() as following,
the issue mentioned above should not happen. Maybe it's just one of my
unnecessary worries.

static unsigned int get_next_freq(struct sugov_policy *sg_policy,
				  unsigned long util, unsigned long max)
{
......
	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
		return sg_policy->next_freq;
......
}

>  static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> @@ -124,6 +123,7 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
>         if (!sugov_update_next_freq(sg_policy, time, next_freq))
>                 return;
> 
> +       sg_policy->next_freq = next_freq;
>         if (!sg_policy->work_in_progress) {
>                 sg_policy->work_in_progress = true;
>                 irq_work_queue(&sg_policy->irq_work);
> 
> --
> viresh

