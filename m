Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0CE23B8E4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 12:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHDKjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgHDKjB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 06:39:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214AC06174A
        for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2020 03:39:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so22580375pls.9
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2020 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BNGGP8nI26QQvsEtdjfefrmhKzpQ5Kf8DvxYjmO6N1s=;
        b=oN3IV5bZB9RdAEY0bOaOOp2T+d5/UxbxRkvHrrDySh0FyMAgmapRgFPBrbmz3kBrl3
         RjLXUUB09TekcAgaiuL7IhpYURnG5+ogt0T5d55cO5B3bxRQ+Haq0vcnjmA0cA1Du3EC
         VAiRThtJOmBJbcflkdN5ujxsX6OKjoc1VsD/eZs5Dm0OLV0C/CoprrYF94u6PP/uXQxN
         +Y6YRe98pTIl6+gjhgYyKUw28/HgNrZKLziwHC6jpFzjn9v73DL79pxYkSAbtt7tDpj3
         x+OY5KwvKlj4foIyD9AFeM0I/oqdPMkhDo8BHerWfZbrIRxGlMBNlJfuEM5nr9z/aCed
         HJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BNGGP8nI26QQvsEtdjfefrmhKzpQ5Kf8DvxYjmO6N1s=;
        b=XIf7RvcBFbpA1tpcWbKGNUC3U49ZPSpbW8pvi6nlE/N3jpznV+8jjepFE0/PlppIP/
         s8R7HCSUWcUVFhkbtbGVcne5JHHF7BqWxFecvb9obSGIFCRDt+NXNFyQeXPaV3rrAhk9
         YFlcOcuvcwUPQTVxzC7xxBlIw1EtdtYMGCUSSHHiei59oSmL/RcUF+0VrB4ZUT1JkyPl
         Vvh0Tg+QxGmM7G9dH2jNTfFrD2tLcWR6XW9PGzd2AMVc6sWOew2TnKJ4Ri7Co4EI6X0K
         IpOiKdSNCwO8MUAFzmTGWt5X226rAR4lnEDz7gM+B+WtCYUHPbSBkxQHdznFvRBZiVJG
         ATVw==
X-Gm-Message-State: AOAM531LwJxOCyfunUCBW/1vI8zY5QWeEf/JpqSbvCkbmOojuwnwUOln
        f313yte/xodIqWVD+aITV1goSA==
X-Google-Smtp-Source: ABdhPJyScsX2xR+pwN0T13dS1iijdQ58el2pg9EUEaeim5L9Peixs0Tx8EVJ5/wuCjT7xdedYbcYBg==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr851080plr.58.1596537540953;
        Tue, 04 Aug 2020 03:39:00 -0700 (PDT)
Received: from localhost ([122.162.173.150])
        by smtp.gmail.com with ESMTPSA id t19sm23230670pfq.179.2020.08.04.03.38.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 03:38:59 -0700 (PDT)
Date:   Tue, 4 Aug 2020 16:08:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        cristian.marussi@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200804103857.mxgkmt6qmmzejuzb@vireshk-mac-ubuntu>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
 <20200730091014.GA13158@bogus>
 <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
 <20200804053502.35d3x3vnb3mggtqs@vireshk-mac-ubuntu>
 <f784bf30-83a6-55ff-8fa6-f7bd2d4399b9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f784bf30-83a6-55ff-8fa6-f7bd2d4399b9@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-08-20, 11:29, Lukasz Luba wrote:
> On 8/4/20 6:35 AM, Viresh Kumar wrote:
> > IIUC, the only concern right now is to capture stats with fast switch ? Maybe we
> > can do something else in that case and brainstorm a bit..
> 
> Correct, the fast switch is the only concern right now and not tracked. We
> could fill in that information with statistics data from firmware
> with a cpufreq driver help.
> 
> I could make the if from patch 1/4 covering narrowed case, when
> fast switch is present, check for drivers stats.
> Something like:
> -----------8<------------------------------------------------------------
> if (policy->fast_switch_enabled)
> 	if (policy->has_driver_stats)
> 		return cpufreq_stats_present_driver_data(policy, buf);
> 	else
> 		return 0;
> -------------->8----------------------------------------------------------

I don't think doing it with help of firmware is the right thing to do
here then. For another platform we may not have a firmware which can
help us, we need something in the opp core itself for that. Lemme see
if I can do something about it.

> > Why is firmware the governor here ? Aren't you talking about the simple fast
> > switch case only ?
> 
> I used a term 'governor' for the firmware because it makes the final
> set for the frequency. It (FW) should respect the frequency value
> set using the fast switch. I don't know how other firmware (e.g. Intel)
> treats this fast switch value or if they even expose FW stats, though.

For Intel I think, Linux is one of the entities that vote for deciding
the frequency of the CPUs and the firmware (after taking all such
factors into account) chooses a frequency by its own, which must be >=
the frequency requested by Linux.

> You can read about this statistics region in [1] at:
> 4.5.5 Performance domain statistics shared memory region
> 
> > 
> > Over that, I think this cpufreq stats information isn't parsed by any tool right
> > now and tweaking it a bit won't hurt anyone (like if we start capturing things a
> > bit differently). So we may not want to worry about breaking userspace ABI here,
> > if what we are looking to do is the right thing to do.
> 
> So, there is some hope... IMHO it would be better to have this cpufreq
> stats in normal location, rather then in scmi debugfs.

I agree.

> > I am not sure what notifications are we talking about here.
> 
> There is a notification mechanism described in the SCMI spec [1] at
> 4.5.4 Notifications.
> We were referring to that mechanism.

Ahh, I see. All I was thinking was about the cpufreq specific
notifiers :)

-- 
viresh
