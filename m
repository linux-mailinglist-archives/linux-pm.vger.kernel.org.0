Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCB2284581
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 07:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgJFFjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 01:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgJFFjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 01:39:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635B2C0613A9
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 22:39:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 34so7337805pgo.13
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 22:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gBWELLsmWBMv8ZoFtgIaryCMYKRO2FKzn9voThfwCPI=;
        b=snIWuq1c3TXakk7Hma1bfFqf2z4tOEJJPhaRqtvF/ZSX8OiLBV+k8xSu3BWuMKzNAu
         8LkY9Cdb3AcN5u5wboYDtFT0UnzWePPfvBdIntnkJxTnc93h5fMRz6z/7PB8hTpNBaJ6
         N1oqZt+BaxC2ckhvYr5R9fXUbtkHJl1oj9DTJpDNEsbQ7ZDSgWUXnc6Mqm7hbrLSC0FK
         D96Wpdzk8tOPWv0Uvo7GpzA4MgF3AnEFEIGDKAZGki0cP3tEdYbB7+j8TFVa0D4Z93rQ
         8qHCz8uhuY2xfrUBllk/SKYoDaeh0JBm0A04PhvRxidzs2vpz3H/WyfzQYOw9SCmEYgj
         CzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gBWELLsmWBMv8ZoFtgIaryCMYKRO2FKzn9voThfwCPI=;
        b=UOPum5g/Hz3CyBDd2CSxUFYpkpQn7bR2OHbJp3BCawpr0H/n+fscL6ADwRM6iLuble
         g1g3boBiz+lHv/zGNsVaJk+OV4+Pfdz9nr9dFbfBXj7VdkKXyuj8573lolnYZAlwP6HN
         d73zMQGUboEVbUTT6Aq1iUsCK9s/MsfxIJnBmPgLmnOp+0SZUZfGBreOJCU4kMKsWFz1
         4Z9jzM4LOcPC6QSvnwtgTkSI7QDG0wS7XFR462IRr7+FSntMDI1d0Klsj4DD+2mtISlE
         XW5f0bXq1mkeRDahrdafXY2Q9AZ1vbhh4PASU80uyMA10Hlwj3I/xRVk9oosn5gGvjNc
         41aw==
X-Gm-Message-State: AOAM531Dh1XzmRScex3bEfQJ2fTlEhqRSuzO6tszFiQNdhubi7G7voLw
        6t09aonumfg1wtUnY6+0ncuqLA==
X-Google-Smtp-Source: ABdhPJxfzp9AsYat8J0BE7StwcX06U01GTLVwZugXMNpdisDHa+LCAXGIgg+BkW9OXIVAltgO9hILA==
X-Received: by 2002:a63:df42:: with SMTP id h2mr2750856pgj.239.1601962739632;
        Mon, 05 Oct 2020 22:38:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id g13sm1532465pgd.82.2020.10.05.22.38.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 22:38:58 -0700 (PDT)
Date:   Tue, 6 Oct 2020 11:08:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ksitaraman@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
Message-ID: <20201006053856.dth6ut22pvwpgfz5@vireshk-i7>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
 <20201005045414.fmntm7ejad7zxcrv@vireshk-i7>
 <2c0daaa5-4aec-925d-c1e3-0f15fb93cc20@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0daaa5-4aec-925d-c1e3-0f15fb93cc20@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-10-20, 00:24, Sumit Gupta wrote:
> 
> > > Warning coming during boot because the boot freq set by bootloader
> > > gets filtered out due to big freq steps while creating freq_table.
> > > Fixing this by setting closest ndiv value from freq_table.
> > > Warning:
> > >    cpufreq: cpufreq_online: CPU0: Running at unlisted freq
> > >    cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
> > > 
> > > Also, added change in init to wait till current frequency becomes
> > > equal or near to the previously requested frequency. This is done
> > > because it takes some time to restore the previous frequency while
> > > turning-on non-boot cores during exit from SC7(Suspend-to-RAM).
> > 
> > So you are trying to figure if the frequency is listed in freq-table or not,
> > otherwise setting the frequency to a value you think is appropriate. Right ?
> During boot, want to set the frequency from freq_table which is closest to
> the one set by bootloader.

Right.

> During resume from suspend-to-idle, want to restore the frequency which was
> set on non-boot cores before they were hotplug powered off.

Why exactly do you want to do that ? Rather you should provide
online/offline hooks for the cpufreq driver and do light-weight
suspend/resume as is done by cpufreq-dt.c as well.

> > 
> > This is what the cpufreq core already does when it printed these boot time
> > messages. Do we really need to add this much code in here ?
> We want to avoid the warning messages.

Hmm, okay.

> > 
> > If you really don't want to see the warning, how about fixing it the way cpufreq
> > core does ? i.e. with this call:
> > 
> > ret = __cpufreq_driver_target(policy, policy->cur - 1, CPUFREQ_RELATION_L);
> > 
> The cpufreq core change will help in bootup case but not during the case of
> resume.
> In this change, reading the previously stored value and restoring it will
> also fix the warning message during resume.

You were getting the message during resume as well ? Why ? The
firmware is updating the frequency to a previous value ? If that is
so, you should just set the frequency again to some other value during
resume to fix it.

-- 
viresh
