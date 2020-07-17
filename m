Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437FB223956
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgGQKdL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 06:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQKdK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 06:33:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE6C061755
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 03:33:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so14114118wme.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zi8jnewWWqGBDaiGUwotaO11fwfV4C/fWvx82bCaiGs=;
        b=qAfNIv/1PD9HZtu5z/b7L4wjsmN4Hj3cSHg07fnUfCsnzNroj/Z3PLeA/TEbWAm7I2
         qgLmmD+DRIAoIDp5bIozb9OiMhtsCrGLyiOhrk2DieUmK+ZSj4BzuiOShQ9+J2snHNDQ
         ELx620+7CuVezF/5UxkHQNws4RNlg+aB1fn1nHd+LaH5c3xt8i+yX65cjGXC9yjKX7at
         mDKp6f5bqExeA48g3h0YCtFuG4XPjiTptoqjJHz/fOOkfN/1w9ZM4XXzd9DgCb4tX54O
         kakfv2F4F3fS4rkCGTYe2D7pOblKyO10gTdolj6BkmxFnRCb+To7yKxggGas1xtWVFS9
         /itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zi8jnewWWqGBDaiGUwotaO11fwfV4C/fWvx82bCaiGs=;
        b=AOmzrtrVPy7VW/Z7pXHdyH1l5BbzSAfvDjt838nKkXd2oWdZBrFFYNRAb1XoF4Y3zG
         PG83MHUr9EvZvGJ62wdPIp44TFGbnM+xUaNSV44aqHdrFAytxu2m0GxNP5hV/yyGeLeU
         3jRIvA/mrnTLTPnSBt4QFfGnB4ep9FxKpSZ3s8udtstAkH0h/BsIbnRv38cJIFBM+mH2
         JGmOu/pQxAl3uWGZYtf7Ok7799NvO9VUDxWerRwhx59nHSRD68OyxqR0V3wsG50Uc/bp
         7b8JYenxSDiph5VDR4FpR13QYMCX3Q/Md5IG9lGNOKYIExE4Rooshx/90bU+kUbgaMSD
         Ythw==
X-Gm-Message-State: AOAM533zJA4a+mWwjZc6v31CWejCOl6BFW1JFw1C/6yFNaKQp38+FqvJ
        v6VKf5zsxmbs2PkKHsrfLFSeuw==
X-Google-Smtp-Source: ABdhPJxqyLRZnxEq1KDZDv0rSrpib/c6MB25cE43V84SI6vmZm32XKilMzpv08RxpslWOrFBpNzoGA==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr9028334wml.183.1594981988862;
        Fri, 17 Jul 2020 03:33:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id m9sm12396277wml.45.2020.07.17.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:33:08 -0700 (PDT)
Date:   Fri, 17 Jul 2020 11:33:05 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200717103305.GA2385870@google.com>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200717101438.GA2366103@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717101438.GA2366103@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 17 Jul 2020 at 11:14:38 (+0100), Quentin Perret wrote:
> On Tuesday 14 Jul 2020 at 12:06:53 (+0530), Viresh Kumar wrote:
> >  /**
> > - * get_load() - get load for a cpu since last updated
> > + * get_load() - get current load for a cpu
> >   * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
> >   * @cpu:	cpu number
> > - * @cpu_idx:	index of the cpu in time_in_idle*
> > + * @cpu_idx:	index of the cpu
> >   *
> > - * Return: The average load of cpu @cpu in percentage since this
> > - * function was last called.
> > + * Return: The current load of cpu @cpu in percentage.
> >   */
> >  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> >  		    int cpu_idx)
> >  {
> > -	u32 load;
> > -	u64 now, now_idle, delta_time, delta_idle;
> > -	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> > -
> > -	now_idle = get_cpu_idle_time(cpu, &now, 0);
> > -	delta_idle = now_idle - idle_time->time;
> > -	delta_time = now - idle_time->timestamp;
> > +	unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> > +	unsigned long max = arch_scale_cpu_capacity(cpu);
> 
> Should we subtract the thermal PELT signal from max?

Actually, that or add it the ENERGY_UTIL case in effective_cpu_util() as
this appears to be missing for EAS too ...
