Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD20229DD14
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 01:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgJ1WTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgJ1WTI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:19:08 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B0C0613CF;
        Wed, 28 Oct 2020 15:19:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 9so1220518oir.5;
        Wed, 28 Oct 2020 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=8gD3IH+hSkcxH7JoFBlZOoX1Uk//wUlm/rCuVf3b+ZY=;
        b=t4eDpGE8fOJ2x7pHsHI1Lwb6CoP15JbT4+6J9JLPYBHT213DQLdXwfJJAByDnWHKmU
         eLz8ofY8VjbD8KOhkA6shUlJRwUTEildECKqGZqfUrYNNwH6tvPLiWfnlEFSfEseHLnQ
         XqFVpxVY7iZiSWH6hipf0DGfUVRZHPuyVvgn0u42Lv2PqJoqU6oBzNA+whfYCIQib2jR
         La+kAPRKwReRWRLU7z76U/DSjBj6orjRCVCInYOWMw8gnUYlrSHpO99qrCqWE8K+/hcN
         fAqoHaHugjPZKUHoAVOh3rEpNNZ+PtqHq0l+zn1bgfcHNvU9FxJVXlPI/icLqgqvCWWy
         yIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=8gD3IH+hSkcxH7JoFBlZOoX1Uk//wUlm/rCuVf3b+ZY=;
        b=EGG1FMkV6s4sKBp0vrFJkBge8Z8X2QoINpkCdiFQX4wPP55kn0NQoJaeSwLbxYGdi1
         KutCOxuIvNdHEtVflgQmHlg9rxqCqqjl4Px913/g//zphmvVvAs0DjUJr4Vww8Ddg1ye
         XMM7YPS3XT1Gshwh4Zv5TE+j9a+CCcacMQKzPuRx1XdRLJyJ5d2mnTENtiKrNLvuFYRU
         NJxjLRHJcbAnI8gZlcphq6UfvGH1E/wxFXyr/beMl/jkC6Vs9tM1qJmPsvNTeXmXQvqd
         wnIPgGMxkEPzJaRZZ2bT7d/6PWHQ+yjTeUIE3MYDZIi84UXaSCrHOVlEa3hz8qPvJCLO
         /s5g==
X-Gm-Message-State: AOAM5311/2iQ9J4OHxx7N+GtuatPBOcmYN908ecxpoUvnnO/zrK3oqV+
        MKiSWyGotiy5JeYvStibpXyKembiVZrwzA==
X-Google-Smtp-Source: ABdhPJyfaUZjoPdWS2g6YX+5xrIC6bs+XolLYXJRtUogH9yuc6bDOJdNQogE6nBk+8p835EwKdP8bA==
X-Received: by 2002:a17:90b:58e:: with SMTP id t14mr6400791pjz.53.1603883017573;
        Wed, 28 Oct 2020 04:03:37 -0700 (PDT)
Received: from DESKTOPIUKEMQD ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id h10sm5011813pgj.69.2020.10.28.04.03.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 04:03:36 -0700 (PDT)
From:   "zhuguangqing83" <zhuguangqing83@gmail.com>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <rjw@rjwysocki.net>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'zhuguangqing'" <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the final cpufreq
Date:   Wed, 28 Oct 2020 19:03:31 +0800
Message-ID: <083a01d6ad19$fbdfbca0$f39f35e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AdatGYlWbcNW7k9ySme9xhkhSbUCiw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

 
> On 27-10-20, 19:54, zhuguangqing83@gmail.com wrote:
> > From: zhuguangqing <zhuguangqing@xiaomi.com>
> >
> > In the following code path, next_freq is clamped between policy->min
> > and policy->max twice in functions cpufreq_driver_resolve_freq() and
> > cpufreq_driver_fast_switch(). For there is no update_lock in the code
> > path, policy->min and policy->max may be modified (one or more times),
> > so sg_policy->next_freq updated in function sugov_update_next_freq()
> > may be not the final cpufreq.
> 
> Understood until here, but not sure I followed everything after that.
> 
> > Next time when we use
> > "if (sg_policy->next_freq == next_freq)" to judge whether to update
> > next_freq, we may get a wrong result.
> >
> > -> sugov_update_single()
> >   -> get_next_freq()
> >     -> cpufreq_driver_resolve_freq()
> >   -> sugov_fast_switch()
> >     -> sugov_update_next_freq()
> >     -> cpufreq_driver_fast_switch()
> >
> > For example, at first sg_policy->next_freq is 1 GHz, but the final
> > cpufreq is 1.2 GHz because policy->min is modified to 1.2 GHz when
> > we reached cpufreq_driver_fast_switch(). Then next time, policy->min
> > is changed before we reached cpufreq_driver_resolve_freq() and (assume)
> > next_freq is 1 GHz, we find "if (sg_policy->next_freq == next_freq)" is
> > satisfied so we don't change the cpufreq. Actually we should change
> > the cpufreq to 1.0 GHz this time.
> 
> FWIW, whenever policy->min/max gets changed, sg_policy->limits_changed
> gets set to true by sugov_limits() and the next time schedutil
> callback gets called from the scheduler, we will fix the frequency.
> 
> And so there shouldn't be any issue here, unless I am missing
> something.

Thanks for your comments. Maybe my description was not clear before.

If I understand correctly, when policy->min/max get changed in the time
Window between get_next_freq() and sugov_fast_switch(), to be more
precise between cpufreq_driver_resolve_freq() and
cpufreq_driver_fast_switch(), the issue may happen.

For example, the first time schedutil callback gets called from the
scheduler, we reached get_next_freq() and calculate the next_freq,
suppose next_freq is 1.0 GHz, then sg_policy->next_freq is updated
to 1.0 GHz in sugov_update_next_freq(). If policy->min/max get
change right now, suppose policy->min is changed to 1.2 GHz, 
then the final next_freq is 1.2 GHz for there is another clamp
between policy->min and policy->max in cpufreq_driver_fast_switch().
Then sg_policy->next_freq(1.0 GHz) is not the final next_freq(1.2 GHz).

The second time schedutil callback gets called from the scheduler, there
are two issues:
(1) Suppose policy->min is still 1.2 GHz, we reached get_next_freq() and
calculate the next_freq, because sg_policy->limits_changed gets set to
true by sugov_limits() and there is a clamp between policy->min and
policy->max, so this time next_freq will be greater than or equal to 1.2
GHz, suppose next_freq is also 1.2 GHz. Now next_freq is 1.2 GHz and
sg_policy->next_freq is 1.0 GHz,  then we find
"if (sg_policy->next_freq == next_freq)" is not satisfied and we call
cpufreq driver to change the cpufreq to 1.2 GHz. Actually it's already
1.2 GHz, it's not necessary to change this time.

(2) Suppose policy->min was changed again to 1.0 GHz before, we reached
get_next_freq() and calculate the next_freq, suppose next_freq is also
1.0 GHz. Now next_freq is 1.0 GHz and sg_policy->next_freq is also 1.0 GHz,
then we find "if (sg_policy->next_freq == next_freq)" is satisfied and we
don't change the cpufreq. Actually we should change the cpufreq to 1.0 GHz
this time.

> 
> --
> viresh

