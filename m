Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF6C4276
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfJAVPZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 17:15:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41515 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfJAVPY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 17:15:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so11007706lfn.8;
        Tue, 01 Oct 2019 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yxZFs0hmpUFTXOHLKZcZcTzW9UH9/9EifO1XS/Bk2nY=;
        b=RNS0zneZcYi3Mv6liyNh1YlygF54pmVxpS4rz9O1A21pkXzooOgJ8mfY9xnrMFkfc1
         Wu8sDm8+URglX7egX51NdZO03pmam0HldK6Td/ngfBPmhjsufhUFAfE+Es8bX34NMo+L
         FP1Ezkgv8pWNUjX8HRfUsfXtQ2/iXyfAbt3Nd5ezzVx+OP+HHLmOQ0FI31Mg5eYlbauq
         2qyDHLFn+vwnTyXpi5tkw4G4ZMTkMQNZQ6AUMPtIKh8M4jNHcZfpS1yP0scU9WUE/9u2
         dfPgQhcOUpkNV0MZXEetfRABcOAICbExtyk0EReai3INxT6wkf84eCExV7Q9sOSswwUW
         97Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yxZFs0hmpUFTXOHLKZcZcTzW9UH9/9EifO1XS/Bk2nY=;
        b=GVpRlCbCD55fSw6PMZuz1NzNuU6cgvFQ3QsRGb6erp0PyMu6S9FjqcDy9PYNHrOtR3
         UUGYDaEcR8XtpyvgQmMRpzKzPohgrGror7eXi2Es5yum2E6h6bC1CVaLhtfmMuliRgIh
         nAux9aiCKhoqQO1m0jtb4OUWvI8zXunyp/TSzkuxNq0Sf+CtDT3TE70IdUPvGd2wneib
         FZKpANDM7hUTwy8rt7cufp5mWwYDPNUjQHibIV41NgGlt2CsWtwM34Nu3XelXuMUlU4o
         eQYHRmocYcS3QMtBY++BZfxPr6yqSICw+o8/YHPcai42bmrwurZOwt7rs5qtp9Xbmvna
         gYzw==
X-Gm-Message-State: APjAAAVTgDadJ+SHFZQqA51XSCIkeNWeX5YnSriGE7UiKzNz2+OJAcxF
        7y2RulkTP/qXCMnt/yBQpT856t9e
X-Google-Smtp-Source: APXvYqy5XEdS+PhV5rxzeq89HVYUE+AoJopRPL9kBY4MTjRgge7eZuRKMow5afZKNI0V1/OJEfZB0A==
X-Received: by 2002:ac2:50c5:: with SMTP id h5mr16103984lfm.105.1569964521622;
        Tue, 01 Oct 2019 14:15:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id b19sm4387549lji.41.2019.10.01.14.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 14:15:20 -0700 (PDT)
Subject: Re: [PATCH v6 00/19] More improvements for Tegra30 devfreq driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811212315.12689-1-digetx@gmail.com>
Message-ID: <17dabcfc-3351-13a1-b3de-81af88f64d84@gmail.com>
Date:   Wed, 2 Oct 2019 00:15:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.08.2019 00:22, Dmitry Osipenko пишет:
> Hello,
> 
> This series addresses some additional review comments that were made by
> Thierry Reding to [1], makes several important changes to the driver,
> fixing excessive interrupts activity, and adds new features. In the end
> I'm proposing myself as a maintainer for the Tegra devfreq drivers.
> 
> [1] https://lore.kernel.org/lkml/0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com/T/
> 
> Changelog:
> 
> v6:  Addressed review comment that was made by Chanwoo Choi to v5 by
>      squashing "Define ACTMON_DEV_CTRL_STOP" patch into the "Use CPUFreq
>      notifier" patch.
> 
> v5:  Addressed review comments that were made by Chanwoo Choi to v4 by
>      squashing few patches, dropping some questionable patches, rewording
>      comments to the code, restructuring the code and etc.
> 
>      These patches are now dropped from the series:
> 
>        PM / devfreq: tegra30: Use tracepoints for debugging
>        PM / devfreq: tegra30: Inline all one-line functions
> 
>      The interrupt-optimization patches are squashed into a single patch:
> 
>        PM / devfreq: tegra30: Reduce unnecessary interrupts activity
> 
>      because it's better to keep the optimizations as a separate change and
>      this also helps to reduce code churning, since the code changes depend
>      on a previous patch in order to stay cleaner.
> 
>      Fixed a lockup bug that I spotted recently, which is caused by a
>      clk-notifier->cpufreq_get()->clk_set_rate() sequence. Now a non-blocking
>      variant of CPU's frequency retrieving is used, i.e. cpufreq_quick_get().
> 
>      Further optimized the CPUFreq notifier by postponing the delayed
>      updating in accordance to the polling interval, this actually uncovered
>      the above lockup bug.
> 
>      Implemented new minor driver feature in the new patch:
> 
>        PM / devfreq: tegra30: Support variable polling interval
> 
> v4:  Added two new patches to the series:
> 
>        PM / devfreq: tegra30: Synchronize average count on target's update
>        PM / devfreq: tegra30: Increase sampling period to 16ms
> 
>      The first patch addresses problem where governor could get stuck due
>      to outdated "average count" value which is snapshoted by ISR and there
>      are cases where manual update of the value is required.
> 
>      The second patch is just a minor optimization.
> 
> v3:  Added support for tracepoints, replacing the debug messages.
>      Fixed few more bugs with the help of tracepoints.
> 
>      New patches in this version:
> 
>        PM / devfreq: tegra30: Use tracepoints for debugging
>        PM / devfreq: tegra30: Optimize CPUFreq notifier
>        PM / devfreq: tegra30: Optimize upper consecutive watermark selection
>        PM / devfreq: tegra30: Optimize upper average watermark selection
>        PM / devfreq: tegra30: Include appropriate header
> 
>      Some of older patches of this series also got some extra minor polish.
> 
> v2:  Added more patches that are cleaning driver's code further and
>      squashing another kHz conversion bug.
> 
>      The patch "Rework frequency management logic" of the v1 series is now
>      converted to "Set up watermarks properly" because I found some problems
>      in the original patch and then realized that there is no need to change
>      the logic much. So the logic mostly preserved and only got improvements.
> 
>      The series is based on the today's linux-next (25 Jun) and takes into
>      account minor changes that MyungJoo Ham made to the already queued
>      patches from the first batch [1].
> 
> Dmitry Osipenko (19):
>   PM / devfreq: tegra30: Change irq type to unsigned int
>   PM / devfreq: tegra30: Keep interrupt disabled while governor is
>     stopped
>   PM / devfreq: tegra30: Handle possible round-rate error
>   PM / devfreq: tegra30: Drop write-barrier
>   PM / devfreq: tegra30: Set up watermarks properly
>   PM / devfreq: tegra30: Tune up boosting thresholds
>   PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
>   PM / devfreq: tegra30: Ensure that target freq won't overflow
>   PM / devfreq: tegra30: Use kHz units uniformly in the code
>   PM / devfreq: tegra30: Reduce unnecessary interrupts activity
>   PM / devfreq: tegra30: Use CPUFreq notifier
>   PM / devfreq: tegra30: Move clk-notifier's registration to governor's
>     start
>   PM / devfreq: tegra30: Reset boosting on startup
>   PM / devfreq: tegra30: Don't enable consecutive-down interrupt on
>     startup
>   PM / devfreq: tegra30: Constify structs
>   PM / devfreq: tegra30: Include appropriate header
>   PM / devfreq: tegra30: Increase sampling period to 16ms
>   PM / devfreq: tegra30: Support variable polling interval
>   PM / devfreq: tegra20/30: Add Dmitry as a maintainer
> 
>  MAINTAINERS                       |   9 +
>  drivers/devfreq/tegra30-devfreq.c | 706 +++++++++++++++++++++++-------
>  2 files changed, 555 insertions(+), 160 deletions(-)
> 

Hello Chanwoo,

I don't have any more updates in regards to this series, everything is
working flawlessly for now. Will be awesome if we could continue the
reviewing and then get the patches into linux-next to get some more testing.
