Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144633AC192
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 05:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFRDsB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 23:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFRDsB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 23:48:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BD0C061574
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 20:45:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u190so2842802pgd.8
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D3gfKDAObxcZS4gWY0UN6lYsR+wBujiRgEXvE08JM/k=;
        b=w6pQpx38ffbNxQxqffZYOJWP8IocJze1Hw2LnlGTADR4yQYBGEzpWlUGLmvUOvD6EP
         0VoWFrZy2++m9UH4rvkPtJpiqjgK7c60fxkUZqV3sqAM7+Zhg+hiHARBg2nKjLpeC0gv
         9eaE3iRMAelIHjBkpit1Alu11R2dFsPm4oo95+IlxlpDVqXQiNIvgCoBNJJItqWwX8FP
         bkanzCt9M6TGtWH3+QyU1iF2zyU5QmhwASREQXXK2NGMmlQw2NBUc3vnp+J2bis7QUJ7
         yPViUaI1Xj+Wdqy/oeVSH4nLrtSA5FlgN6iQq6wRDK0nlh8I14FADTCVUirtdbQx7c5L
         I5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D3gfKDAObxcZS4gWY0UN6lYsR+wBujiRgEXvE08JM/k=;
        b=bw4CR3zPpeBIzenTkNz5YSAXKugjUoVkU6uyPT4JOHfPAgg7rJJR2WXDr7wwVXPO6S
         2nyp9plWXzkP7OvmqzVR11oh8ySHlpc/alC+igJULUWf7nresnJ1gxPET2CEsS2Zabvd
         fEvwx54HnUxM6Oaf23JSRaf59hkp/ZBhQUXdYixVrtZTJmscwSHetxiV+KdDwY6IvXSH
         ed4wXuWHtbNdCZPoqwF00h7Vc8L9jJ3+ZMT8hoPiIuIVepzxWYaFaOKvbMOuj0oFa3lM
         lrxJC+LkcWDnxA6Gtu4DHAd2AXubAw/oAlTC1oOx+LfwCMZfCZrN742pFPrJsA/CZQtj
         5zSw==
X-Gm-Message-State: AOAM530R776806VFBwMmr/Ea4R5KzyGjUlWgiksM4UyXDgnFs7Gvub8T
        ZiloinA6Oq/tUfF2+Cpes6SjEg==
X-Google-Smtp-Source: ABdhPJzRWmiQooLbv5uZ+44+FIxqwu3Clpnkep9PA7KGuWsZ6OfDbHJ1VpuW0h4g20cCCqSwuWuWGA==
X-Received: by 2002:a65:5206:: with SMTP id o6mr8038475pgp.129.1623987951683;
        Thu, 17 Jun 2021 20:45:51 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id u73sm6652292pfc.169.2021.06.17.20.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 20:45:50 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:15:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] cpufreq: CPPC: Add support for frequency
 invariance
Message-ID: <20210618034549.wfz24gx4zr2jyfec@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
 <20210616124806.GA6495@arm.com>
 <20210617032416.r2gfp25xxvhc5t4x@vireshk-i7>
 <20210617103415.GA29877@arm.com>
 <20210617111936.cfjzoh6g5zvolaf5@vireshk-i7>
 <YMs+hOKafJMu7Sfu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMs+hOKafJMu7Sfu@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-06-21, 14:22, Peter Zijlstra wrote:
> On Thu, Jun 17, 2021 at 04:49:36PM +0530, Viresh Kumar wrote:
> > Peter: Can you help here on this ? Lemme try to explain a bit here:
> > 
> > We are starting an irq-work (in cppc cpufreq driver) from
> > scheduler_tick()->arch_scale_freq_tick(). What will happen if the driver doesn't
> > take care of CPU hotplug explicitly and make sure this work isn't queued again
> > from the next tick.
> > 
> > Is it important for user to make sure it gets rid of the irq-work during hotplug
> > here ?
> 
> irq-work is flushed on hotplug, see smpcfd_dying_cpu().

Thanks Peter.

-- 
viresh
