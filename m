Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB83C433D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 06:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGLEoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 00:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhGLEoD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 00:44:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFEAC0613E8
        for <linux-pm@vger.kernel.org>; Sun, 11 Jul 2021 21:41:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n10so1326317plk.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Jul 2021 21:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZL0bec2agHsc0j6ce/Gb5bsSghII65P7kEsioPLg7/I=;
        b=WPci+XbTcvjEfOXEze65WR/kHiJj7UnotldAAu3YV5QxlaYIadepyymWghBbbGgVhR
         S9Lezk9hED0qIXMmE07/fHAeTk0Tu+2zzWJa38fGbKb1jvqBRxN26Nl4R8cmK9EO/NbE
         O7HFlaT8Vh2s0HQL0mutd3aGJcZW969KDbu7cVK84yZDtn+lQutF8Ap2xKeLMxmjiYkk
         SSR4D7i5jnaRKH6bwcidT5MLu7HqcW20j6GW7w/qG3Pba1DyV0zt14wq7xnpEbugEHvk
         Gx8kbYIY4/bOsIg7wfcutupfK46FJeJ38nH3mTO2r2SrSgfzBg/rjZdu2VCInk47K0k+
         Ma/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZL0bec2agHsc0j6ce/Gb5bsSghII65P7kEsioPLg7/I=;
        b=tXT9gpEXXK2t1dLC7tRaTgbbPVo1frpth63PFGB9c1edUCRLgXJjkqxoPyg8Fc3xkw
         KSwe3ZDgcDFy5JyMKMsYVhQaafnhC9E9QvB/K+CiH228NpX+1dD2Rz4SemvCa6n0fPSH
         pDXnN5qDeiQiUsuA2MJ9yqhwt69Mxbr3E3NCjLdQk8/fQS8wxv7F+9SMoibKGmlTmJt7
         eYSakRr1YHXREa0C9cCKgsSLhcCVmqvlxWfVNvYP6+cpkTHK4y5GWKXpgj7s4fw1tfAK
         //zrScyEEtaodWUWP9yZpKDCyf/UDcUYkndPkLxwQlQpXzp2XTm7jCffLynBgBnFkc+M
         HP+g==
X-Gm-Message-State: AOAM5320yMi1iMUKXQ2EJXHnzxb7dKSTYX3n8UU/zoIVcNw11UReIGqG
        0er/2DnbMY5K4ELLIvVw6w8NYw==
X-Google-Smtp-Source: ABdhPJwyJwbbVUxFVSM9rN48hfrK7Ghw5kZUYF+Hhou78UTmm5hOddVf9Ch77a6a3nYY5Vr3tBDR9w==
X-Received: by 2002:a17:90a:db98:: with SMTP id h24mr23092454pjv.156.1626064875097;
        Sun, 11 Jul 2021 21:41:15 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id s36sm6810167pgk.64.2021.07.11.21.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 21:41:14 -0700 (PDT)
Date:   Mon, 12 Jul 2021 10:11:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <20210712044112.svhlagrktcfvyj35@vireshk-i7>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-4-thara.gopinath@linaro.org>
 <20210709064646.7vjgiba2o7beudly@vireshk-i7>
 <5a98ef2a-d170-f52d-cc48-b838cddaa5c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a98ef2a-d170-f52d-cc48-b838cddaa5c2@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-07-21, 11:37, Thara Gopinath wrote:
> On 7/9/21 2:46 AM, Viresh Kumar wrote:
> > > @@ -389,6 +503,10 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> > >   	dev_pm_opp_remove_all_dynamic(cpu_dev);
> > >   	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> > > +	if (data->lmh_dcvs_irq > 0) {
> > > +		devm_free_irq(cpu_dev, data->lmh_dcvs_irq, data);
> > 
> > Why using devm variants here and while requesting the irq ?

Missed this one ?

> > 
> > > +		cancel_delayed_work_sync(&data->lmh_dcvs_poll_work);
> > > +	}
> > 
> > Please move this to qcom_cpufreq_hw_lmh_exit() or something.
> 
> Ok.
> 
> > 
> > Now with sequence of disabling interrupt, etc, I see a potential
> > problem.
> > 
> > CPU0                                    CPU1
> > 
> > qcom_cpufreq_hw_cpu_exit()
> > -> devm_free_irq();
> >                                          qcom_lmh_dcvs_poll()
> >                                          -> qcom_lmh_dcvs_notify()
> >                                            -> enable_irq()
> > 
> > -> cancel_delayed_work_sync();
> > 
> > 
> > What will happen if enable_irq() gets called after freeing the irq ?
> > Not sure, but it looks like you will hit this then from manage.c:
> > 
> > WARN(!desc->irq_data.chip, KERN_ERR "enable_irq before
> >                                       setup/request_irq: irq %u\n", irq))
> > 
> > ?
> > 
> > You got a chicken n egg problem :)
> 
> Yes indeed! But also it is a very rare chicken and egg problem.
> The scenario here is that the cpus are busy and running load causing a
> thermal overrun and lmh is engaged. At the same time for this issue to be
> hit the cpu is trying to exit/disable cpufreq.

Yes, it is a very specific case but it needs to be resolved anyway. You don't
want to get this ever :)

> Calling
> cancel_delayed_work_sync first could solve this issue, right ?
> cancel_delayed_work_sync guarantees the work not to be pending even if
> it requeues itself on return. So once the delayed work is cancelled, the
> interrupts can be safely disabled. Thoughts ?

I don't think even that would provide such guarantees to you here, as there is
a chance the work gets queued again because of an interrupt that triggers right
after you cancel the work.

The basic way of solving such issues is that once you cancel something, you need
to guarantee that it doesn't get triggered again, no matter what.

The problem here I see is with your design itself, both delayed work and irq can
enable each other, so no matter which one you disable first, won't be
sufficient. You need to fix that design somehow.

-- 
viresh
