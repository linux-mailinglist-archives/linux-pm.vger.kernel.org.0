Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39F20E125
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgF2Uwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgF2TNZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:13:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FCFC0086FC
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 02:54:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j1so7685788pfe.4
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 02:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2kLr087vpWjllgx/KYMx6tnrO2tWFANhTk3V4cT/Svo=;
        b=YhfDNHRMqFuzWrnPjQ9rBaXsw5HDnbdEuijrsSmywsHNvjtTM9aFZKNYJ9axm0HbWu
         l9+/IckX+M8YwUH0cfQ+JzCsHj4QrojLtdOunR8w8aDrIZFt2zzK2dWrA13t30dvlJXN
         NFz2GllpDmdKMlPLpmb/TJq8yGsHPSm4xYNy0+UFHqvv0Za5ThS8hBteOMLlUiAwvhCU
         J9cf6teRuB/wa5ZXktg+HqwDpebyxHbSR/2bFQIMb58WaRG16IdiJzFJFP2J42eDG0ZU
         rv00hAUgNGChzBobnwHqPSE1stt1ug7aDB+jO/egrCI1ZhALGpIX3kSVcIN8eiA1TrB2
         mKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2kLr087vpWjllgx/KYMx6tnrO2tWFANhTk3V4cT/Svo=;
        b=QneVHcuEndcjtAA6V4o7U7bLJ24ZuTbxpekfpjMBzrF416XKC/E5d6mnyta2tsfY+5
         OkIcixf/IpZ/el3yBetnsifChn7TKkvzngUKu0/3qrmUDpZbmxEKd7Iiy0jXhc3Pbuex
         LpWH9LAi7cRQNSHPJTsyqkEnqIEEdhkhXLs5SPhtVthB0ChcKK0utBZlycK1Y1Cq9AuC
         ncdWGDFT5JfeGkbziQ/6kk/QXw7gS/rQXKsMzhgddvk3CPzFAVGMwRT9SHse8EkCP4dI
         47W2ANHgsScA7RcK79b26fHlA6j61AMcwoKIp4muzk48XbbI4WZObLtIUicpuvnByynY
         ICjA==
X-Gm-Message-State: AOAM533e3WYjaVznPARekanyKVn/8SrNq/Flm5khePcdZlJAC5rMJF28
        5f5DiNTQntJFejWooSBaDqe+Cg==
X-Google-Smtp-Source: ABdhPJzG1KpLwB59RuAqc4SxPdxhhopdNYwzvg1+Z42qaoaRMDi0NTXCD80FRPdJWNgrr3/zYLIJVQ==
X-Received: by 2002:a63:5619:: with SMTP id k25mr9499007pgb.139.1593424466206;
        Mon, 29 Jun 2020 02:54:26 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id o1sm18553906pjp.37.2020.06.29.02.54.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 02:54:25 -0700 (PDT)
Date:   Mon, 29 Jun 2020 15:24:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] cpufreq: Specify default governor on command line
Message-ID: <20200629095423.xengjk5z2ezshrdb@vireshk-i7>
References: <cover.1593418662.git.viresh.kumar@linaro.org>
 <96b6e6ca02b664194ff3e57e1ec768fbc597bf38.1593418662.git.viresh.kumar@linaro.org>
 <20200629094452.GB1228312@google.com>
 <20200629094627.jh7pwhftcdqj6nhm@vireshk-i7>
 <20200629094825.GA1231692@google.com>
 <20200629095038.GB1231692@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629095038.GB1231692@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-06-20, 10:50, Quentin Perret wrote:
> On Monday 29 Jun 2020 at 10:48:25 (+0100), Quentin Perret wrote:
> > On Monday 29 Jun 2020 at 15:16:27 (+0530), Viresh Kumar wrote:
> > > On 29-06-20, 10:44, Quentin Perret wrote:
> > > > On Monday 29 Jun 2020 at 13:55:00 (+0530), Viresh Kumar wrote:
> > > > >  static int __init cpufreq_core_init(void)
> > > > >  {
> > > > > +	struct cpufreq_governor *gov = cpufreq_default_governor();
> > > > > +
> > > > >  	if (cpufreq_disabled())
> > > > >  		return -ENODEV;
> > > > >  
> > > > >  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> > > > >  	BUG_ON(!cpufreq_global_kobject);
> > > > >  
> > > > > +	if (!strlen(default_governor))
> > > > 
> > > > Should we test '!strlen(default_governor) && gov' here actually?
> > > > We check the return value of cpufreq_default_governor() in
> > > > cpufreq_init_policy(), so I'm guessing we should do the same here to be
> > > > on the safe side.
> > > 
> > > With the current setup (the Kconfig option being a choice which
> > > selects one governor at least), it is not possible for gov to be NULL
> > > here. And so I didn't worry about it :)
> > 
> > Right, so should we remove the check in cpufreq_init_policy() then?
> > I don't mind either way as long as we are consitent :)
> 
> And actually maybe we should remove the weakly defined
> cpufreq_default_governor() implementation too? That'd make sure we get a
> link-time error if for some reason things change in the Kconfig options.

That would be fine I believe. I will do all that in a separate patch
then and let this series go through with no more changes :)

-- 
viresh
