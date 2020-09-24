Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F183227712C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgIXMjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 08:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgIXMjg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 08:39:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67DC0613D3
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 05:39:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so1849069pgi.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wGzZiYBPJE4cQ+YRmGtp/CWBBsveyvA8iRp2wwUff/E=;
        b=DNKKUODG6HPoT3PUyAB80GXXRwbumYHowFZ+ox/2YuanlxUjv0e26yT2Fzf8CgfF7O
         Jsmc+z4qNkXKmFyrppwQjwBeIhfHWV+71DnbZdWHQz5dHFgzS2xxoQJfbOOOdsZQcC9L
         bqUY1SL7sIX4g8VIQ2uCpGPDnv7iLRy+sOwSH5uEqe1UobatMdq9so7Y57KpPIy6tMzW
         U4fLcSkrHNjjjBBQkUt3GXTd53WiHmpzfHcyJ4egcatanHpN+MBk4AgsFTxPbrdpY11r
         a6oNFtRQnuQaz3pW255zx9MmCCN4DSDadzduUdGsvD+ea6pz6+y0w208k3f74I0mH4cw
         8ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wGzZiYBPJE4cQ+YRmGtp/CWBBsveyvA8iRp2wwUff/E=;
        b=JpzR7wwVAxKYgnVdasHoLDwkESreB6LdV/5r9PVsFBX+CTRY6VGPYOcYzJa3Rky91I
         mJcdQqd4PXJBj3FwrZr2lRWRZpf6K2ZTu9ogOGpvotcYNNAAafAclXCuuijI88iLeomt
         jMzbsScS70TcxsErp4LXapIiNT0uBLl5QzRHtvvYM43shxrwOornZEIqRIhg4rHcB1+o
         8KOKpKrgBhjZHBdj98kJAYDzo7OADDBetiGFxSc1IeqZAo9HNlzwBTpMkTo2x1lBNnNH
         DxXFTqNxjmhUcncLLCKCYtTvhYBZ2M4xpupf1OHLMYOgJP4TNkoRI1jL7Asb8OfMozCw
         AUZg==
X-Gm-Message-State: AOAM533SM1VUxxbRZviQMFbWcmMeLv27vM3WrAdk5KR3hn2FVCpoEBLM
        gd84/rTg5xDHv+j7qm6qq5Wt6A==
X-Google-Smtp-Source: ABdhPJyJpFmOSbzCDLbyX/k1tfFG8tIz1hLeysz8FvA26p5V683V/7JM99KH5U10QgS+SnFVAK9cVA==
X-Received: by 2002:a62:4e8a:0:b029:13c:1611:653b with SMTP id c132-20020a624e8a0000b029013c1611653bmr4420557pfb.13.1600951176069;
        Thu, 24 Sep 2020 05:39:36 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id r16sm2407148pjo.19.2020.09.24.05.39.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 05:39:34 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:09:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200924123921.iiaqw2ufe2utnjtg@vireshk-i7>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
 <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com>
 <a4c5a6b9-10f8-34f8-f01d-8b373214d173@arm.com>
 <CAJZ5v0iFjzqTKTPFF5hB5C0TYSQn2rxL_6099gqUwoTARKRnZA@mail.gmail.com>
 <ae5771c8-6297-e447-4449-e39ae2ea5a0e@arm.com>
 <CAJZ5v0hkBnU_W-ZXHTfppu9pVWnQcJHho7DQPi7N7yeLOt5cgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hkBnU_W-ZXHTfppu9pVWnQcJHho7DQPi7N7yeLOt5cgg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-09-20, 13:07, Rafael J. Wysocki wrote:
> On Thu, Sep 24, 2020 at 1:00 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > On 9/24/20 11:24 AM, Rafael J. Wysocki wrote:
> > > On Thu, Sep 24, 2020 at 11:25 AM Lukasz Luba <lukasz.luba@arm.com> wrote:

> > >> I wonder if we could just drop the reset feature. Is there a tool
> > >> which uses this file? The 'reset' sysfs would probably have to stay
> > >> forever, but an empty implementation is not an option?
> > >
> > > Well, having an empty sysfs attr would be a bit ugly, but the
> > > implementation of it could be simplified.
> > >
> > >> The documentation states:
> > >> 'This can be useful for evaluating system behaviour under different
> > >> governors without the need for a reboot.'
> > >> With the scenario of fast-switch this resetting complicates the
> > >> implementation and the justification of having it just for experiments
> > >> avoiding reboot is IMO weak. The real production code would have to pay
> > >> extra cycles every time. Also, we would probably not experiment with
> > >> cpufreq different governors, since the SchedUtil is considered the best
> > >> option.
> > >
> > > It would still be good to have a way to test it against the other
> > > available options, though.
> > >
> >
> > Experimenting with different governors would still be possible, just
> > the user-space would have to take a snapshot of the stats when switching
> > to a new governor. Then the values presented in the stats would just
> > need to be calculated in this user tool against the snapshot.
> >
> > The resetting is also not that bad, since nowadays more components
> > maintain some kind of local statistics/history (scheduler, thermal).
> > I would recommend to reset the whole system and repeat the same tests
> > with different governor, just to be sure that everything starts from
> > similar state (utilization, temperature, other devfreq devices
> > frequencies etc).
> 
> Well, if everyone agrees on removing the reset feature, let's drop the
> sysfs attr too, as it would be useless going forward.
> 
> Admittedly, I don't have a strong opinion and since intel_pstate
> doesn't use a frequency table, this is not relevant for systems using
> that driver anyway.

I added this file sometime back as it made my life a lot easier while testing
some scheduler related changes and see how they affect cpufreq updates. IMO this
is a useful feature and we don't really need to get rid of it.

Lets see where the discussion goes about the feedback you gave.

-- 
viresh
