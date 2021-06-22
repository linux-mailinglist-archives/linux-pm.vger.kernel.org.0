Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8579B3B0026
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 11:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhFVJ2O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 05:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJ2M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 05:28:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D30DC061760
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 02:25:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c15so10054713pls.13
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EMQe0faSiwTMFSGn4R6wpvkhrkxl7fkQnJW3T2oiy2s=;
        b=AyjneWry81bxuXh2uC5nLKZAiGFjcGwmCNez4f+Jg8TSEZsuzp6Hey5BRlpDtpCE0b
         D905F2a0kiW0yAIs5bCJinE4/5j+sv6ewvj24+GzUSWmqHcCsRdj7DKY2Q/v+PYF6FWv
         T1NhJf966pMGoq/5Sy6l/6uxXwXGUM3X4wUAwfbGTgyUWD4UDA1nlE8ZSnk4r7ClFqRw
         AO6LWIG5+Or9wc+LtSToKJgORYOHDHOocwGUc0TKpk0kav8xdd/VtQZ9A/cM0FpEbPu+
         7EuBS/socPwxWKI+aGUR4SGkK2O5W2wYl6SUoz4SlcvIrFCA6RM/OP77KZ87wguywSQF
         PkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMQe0faSiwTMFSGn4R6wpvkhrkxl7fkQnJW3T2oiy2s=;
        b=nS1sgi5yUHUi8u2m3pfbP8tXqoBENlkYDbPPX/LVo0zPTMlWwo1yfdDKQkjGFWFze8
         xIKZVLQLbNqWmYYiMNt5Fkm8DyAsjZ35IqD9TRRGt0v4OH6kZE4kRXR59Q6yIHuinMUG
         uLJLHyVINiaZ+NxHhxf5hR4S76z3NOvZwZnpNSNt4nkMO5h4AVrp/aRaX5pPISHV+VEI
         6MT9D36kZIXF0wdDi+MNkEAhVSP54qB57RrZLRnDRLWVtmtFcW+0LAt5NDs5q6LbE2Vv
         NUqft7E2BMBSdIr+KtMZsXoLNrBSaRTZaZJVhVN1yZABnLj3gbmvDpnqOD0K0kRUAjwf
         xd6A==
X-Gm-Message-State: AOAM532QQCmXknCx0Tb9rN2EpWGl/parSpewwtGm3U6CP4MXhDBq/Saa
        HChSWQav2CfQTSPl18N0bwCyhuaXCG6OYw==
X-Google-Smtp-Source: ABdhPJwUMgP0+H9RZWTv3u7OcHwogqRMM29IW+ds96rMcLgMt1BLBfO14lW1fUi3klbInNsbk/X7jQ==
X-Received: by 2002:a17:903:228e:b029:101:af04:4e24 with SMTP id b14-20020a170903228eb0290101af044e24mr21867030plh.3.1624353953873;
        Tue, 22 Jun 2021 02:25:53 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id d13sm17468386pfn.136.2021.06.22.02.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 02:25:53 -0700 (PDT)
Date:   Tue, 22 Jun 2021 14:55:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, linux-pm@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210622092551.zauoukpakpxdxso7@vireshk-i7>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
 <YNGm+W/BBQnvfPe/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNGm+W/BBQnvfPe/@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-06-21, 09:01, Quentin Perret wrote:
> On Tuesday 15 Jun 2021 at 15:47:06 (+0530), Viresh Kumar wrote:
> > The point is that I don't want cpufreq to carry this for users, we
> > have EM today, tomorrow we may want to mark a frequency as inefficient
> > from somewhere else. The call need to initiate from EM core.
> > 
> > And this isn't a cpufreq only thing, but is going to be generic along
> > with other device types.
> >
> > This is exactly why I asked you earlier to play with OPP core for
> > this. That is the central place for data for all such users.
> 
> The thing is, the very reason for the existence of PM_EM in the first
> place is to NOT depend on PM_OPP which was deemed too Arm-specific. So
> let's not create those dependencies now please.

I am not asking to create one here.

What I am saying is that users of EM, which eventually call
em_dev_register_perf_domain() have the necessary details about about
the performance states (like voltage/freq pairs, or power) and the EM
core should talk to those users directly.

The struct em_data_callback is already there for this reason so we can
keep EM core independent of its users. I suggested to add another
callback there to mark a frequency inefficient, that's all.

In the case of ARM platforms, that would automatically mean OPP core,
and for others it can be anything that has this knowledge.

> > If this information is present at the OPP table (somehow), then we can
> > just fix dev_pm_opp_init_cpufreq_table() to set this for cpufreq core
> > as well.
> 
> Honnestly, I don't think PM_OPP should have anything to do with this,
> for the reason mentionned above.
> 
> I don't really see the problem with cpufreq core querying the EM data
> directly, we already have core subsystems doing that (the scheduler) so
> why would that be a problem?

If EM core is going to be the only entity ever which can provide this
information, then maybe we can get add some core support for this. But
if it is just another driver/layer which can add this information,
then it is always better to provide APIs which such users can call.
And so I was looking for cpufreq to provide an API, which can be
called from such users.

The problem here happened because we registered with the EM core from
policy's ->init() and we couldn't get back to cpufreq core from there
as the policy is only half initialized.

> If the only concern is for non-CPU devices,
> all we'd need is a matching feature in devfreq core and everything
> should be good no?

-- 
viresh
