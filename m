Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B533C26BC02
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 07:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIPF4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 01:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgIPF4r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 01:56:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B498C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 22:56:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so2598836plt.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PyJpRejCCxPh/nnkiT5lYQR6vzYVBlBqRRVevWzgDgs=;
        b=oQP/qoI9cm0wd9Lhiy/DNnRpKfa08CLU5u97M6Xsdt53si7+wRG+lDpjBpCjVLF7YA
         /qYHS1+zmPngFnWwdSnadxnb0btTE4D83lVCApQmTQcEufHkj884KNFFDJtMqwnRSbBe
         6amLunedN5FBNeWKn7mykbOz366IlZM+c9Ci+uH68GuPMlmaUpY45N2nvaXrdqKcET/e
         tQOcwvSHrflxwsVzrL6thF/dZlibhSfuRbhN93zzZ8Elb+cFL5WjWmlfkmck07od/oPL
         aqT0LFBQ2Feo91KWNe5YWx0Fp8DkbcDSfbeWXbO8UeqZjc8znfF4BwOShEt2vAw55J3j
         lQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PyJpRejCCxPh/nnkiT5lYQR6vzYVBlBqRRVevWzgDgs=;
        b=moBywBHQbff9UgzuTGso31LF+CsXmN6olXTw/zxktehyAXx8CdOkiL6Q4+ecYp56qh
         9QNEg6WUMG7Jx3UH4aaGegEzExJH9MjL80mWRV8VzTfjLbHUbFiPoh51raeb7g+p+/TC
         3l9wrogWhWU54sLmMa4z2omc7ExKzC9zmmr009424FZYKK9aznnMnkyYTACV0vMfQEwp
         Lr9LOR/OTUO46T9KHSZdt8dyZEyf19XPjgecVM5sDwBqluk+w2ML4ViOsCQPXRGcy1HS
         UWoqdDfzCEJrmcFHgRiKi2SkVaSsol86JYaJ5vG0137z8tfpVFQIrl+o0HSd17cWPwuW
         4k5Q==
X-Gm-Message-State: AOAM533gYMRlUfdSRnvjJGA0O3njdPusV/Xee8n3j2EZibv8qLQG+Od/
        ts/dkTQzIWnOWI9v0k7pknSWaeWdzgHCBg==
X-Google-Smtp-Source: ABdhPJytCYV1eL6dVOXXq/TtuS96mBhckOBdmELoYmq8WFkj/WAskbMrE/JW90tE0oUK/LQ+lMANXw==
X-Received: by 2002:a17:90a:8a04:: with SMTP id w4mr2542531pjn.72.1600235806982;
        Tue, 15 Sep 2020 22:56:46 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id g129sm3801342pfb.9.2020.09.15.22.56.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 22:56:45 -0700 (PDT)
Date:   Wed, 16 Sep 2020 11:26:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200916055641.g654zoukjeqpjmwz@vireshk-i7>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
 <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
 <bd6e6d93-7491-0971-3bed-27d1885c38cd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6e6d93-7491-0971-3bed-27d1885c38cd@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-09-20, 11:04, Lukasz Luba wrote:
> Hi Viresh,
> 
> On 9/2/20 8:24 AM, Viresh Kumar wrote:
> > In order to prepare for lock-less stats update, add support to defer any
> > updates to it until cpufreq_stats_record_transition() is called.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
> >   1 file changed, 56 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index 94d959a8e954..fdf9e8556a49 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -22,17 +22,22 @@ struct cpufreq_stats {
> 
> Would it be possible to move this structure in the
> linux/cpufreq.h header? Any subsystem could have access to it,
> like to the cpuidle stats.

Hmm, I am not sure why we should be doing it. In case of cpuidle many
parts of the kernel are playing with cpuidle code, like drivers/idle/,
drivers/cpuidle, etc.

Something should land in include/ only if you want others to use it,
but in case of cpufreq no one should be using cpufreq stats.

So unless you have a real case where that might be beneficial, I am
going to keep it as is.

> Apart from that (and the comment regarding the 'atomic_t' field)
> I don't see any issues.

Thanks.

-- 
viresh
