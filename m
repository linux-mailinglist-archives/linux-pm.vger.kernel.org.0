Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2838333362
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 03:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhCJCzY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 21:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhCJCyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 21:54:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B3C061760
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 18:54:53 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s21so115223pfm.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F7L2rfwUmYIB7S+xDvEKqrJHTr/uik/Q3th44+Fbt0s=;
        b=CzYw2jEQodgFUJkFkDCkjqeMhkZ/maXPSsR6uL5nluiwEGymjIwN6FaDnhBr6C8qZX
         QnnK1649X6ZSZEjfjSM096wR1FImuJXXS0L0LpF/kViYWtWBHPrKsWb5p/b9iVB91TQX
         /1PZQh5T/WjCzTDF4QmHBVP+Ch6cLXz6dcC9P3dMitAXW9POtDU/eR/MrcjpGsNmPESp
         8S6UUzmZLu9xJdMztduwcTIeZrTUAYOC6puynMFFQO/vDRQXFWbsQfoFYqHevvDQEHLD
         IqHuULYzeBYvJ1O3KoapWQ2Mzd6P563s4SM+HCJ2DoFduuwRVaNU3ZB0EkUhsdF9OLth
         MsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F7L2rfwUmYIB7S+xDvEKqrJHTr/uik/Q3th44+Fbt0s=;
        b=GyFS6wypXwJI8sxa90VSvD1JdqPV/yVHTwJ4X8dnF2Ad+ZLybX0s/OALTlHXtxjnrt
         S4vi0X8SQW8t0YoiKAJgg9151lgnb7j2HtztDLwuL4sMUDulfM6Cdh119+TQvYIV28hs
         o8YdAAVGy67TK6fZJ07b+mPnv+2SLvG9Mf8vvrHhyO6hkLixoF7C/rCTkZvp6z4UT97V
         YOaNmpxq8k6H5aNLpLiHyhrC4XyFtuOIZIfPXzx7JfXcrn2Jfs2LKc9U+bZeGWgx/j83
         V1NkDFMmzlC2k7bPdOw+No9BhulhI8bhXTf3jgP3zoxh4Sibjtdm5ND2A34jla7oeMg3
         fBMw==
X-Gm-Message-State: AOAM532FJ016M+Iwx5qH/0sRL+bSU8TEjxWd3XBoj4gwFsnux1cFGtet
        RDaxhwwOREi/4vaDmTfq9qhA8g==
X-Google-Smtp-Source: ABdhPJxy3zQnKdDxFnFa4MAF0F/2s0x0egEHF+1b/xyt2pTLAUFBzQ5G1nVeO1qogvOJVDwEg+/8WA==
X-Received: by 2002:a62:1911:0:b029:1ed:b722:3b50 with SMTP id 17-20020a6219110000b02901edb7223b50mr1094613pfz.70.1615344893238;
        Tue, 09 Mar 2021 18:54:53 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id fa21sm4034926pjb.25.2021.03.09.18.54.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 18:54:52 -0800 (PST)
Date:   Wed, 10 Mar 2021 08:24:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210310025450.plggnrhbsrpycteq@vireshk-i7>
References: <cover.1614580695.git.viresh.kumar@linaro.org>
 <a34f549bc75eecd4804aebb7b7794b45769eccf0.1614580695.git.viresh.kumar@linaro.org>
 <20210309151157.GB25243@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309151157.GB25243@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-03-21, 15:11, Ionela Voinescu wrote:
> On Monday 01 Mar 2021 at 12:21:17 (+0530), Viresh Kumar wrote:
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index 0f6cd6b73a61..3bcfba5c21a7 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -34,7 +34,19 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
> >  			     unsigned long max_freq);
> >  bool topology_scale_freq_invariant(void);

We don't normally add blank lines between declarations (variables or
function), like what's done here.

> >  
> > -bool arch_freq_counters_available(const struct cpumask *cpus);
> > +enum scale_freq_source {
> > +	SCALE_FREQ_SOURCE_CPUFREQ = 0,
> > +	SCALE_FREQ_SOURCE_ARCH,
> > +};
> > +
> > +struct scale_freq_data {
> > +	enum scale_freq_source source;
> > +	void (*set_freq_scale)(void);
> > +};
> > +
> > +void topology_scale_freq_tick(void);
> > +void topology_set_scale_freq_source(struct scale_freq_data *data, const struct cpumask *cpus);
> > +void topology_clear_scale_freq_source(enum scale_freq_source source, const struct cpumask *cpus);
> 
> Nit: can you split these lines?

And so in order to be consistent across the file, I haven't added one
here.

-- 
viresh
