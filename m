Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 025EE1A1BA0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 07:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDHFxG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 01:53:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44091 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgDHFxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 01:53:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id n13so1413391pgp.11
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5e4MJJn8a/rgtRLRcTfQ/Iwfbqly/Z6Qseq2BhNVXhs=;
        b=Buvyp94gdoyw/raDpF1YKbKaOV8H5YUTSwbYKlAKBdifSk24gF0L4UwqZp3RXq99dd
         sRdjTCdrxsdyE1HODCeUTL98tb5zF4E1JAMVkMfFWkyLXApJynqd/dprODX+DZmo7Bzz
         p0CkcsxnkwT6qh4SW5NIr12InVUfZ/K+KS+M80Ijd4O7ClNbKM9cFTk5YSeb+soqgXcE
         23+iEs5d4gEfdVMvUEIK8KwmBPZafE2iIShuoD2klQovIVxmOXrIJ0ELG5x3w4VwDPPQ
         zrkSFKTBQCGnPoVtv6M0xq2xZbSber/BMiLaZKHxCFVx3Qf/Znsu8QYtK6YOX8m5pdr2
         IZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5e4MJJn8a/rgtRLRcTfQ/Iwfbqly/Z6Qseq2BhNVXhs=;
        b=OFRRxwjXMJAKI486eE0Larq+3kuDbwZaMO/nsnPgD8E8hrcrMfr84LIVD/DVqRiCSD
         fIIZ42Pe4rEe8Cb/S4KUJw3QPbWUOyqOQqO2mWsRmxSaxqzdzBbO0UizgA9t+ST0R4m7
         I4zj2onEfIaA6XW/5CK9HarzDMPseh4e1jtRUOyBK2bgD+OAl1RXiZEcwp3j2BvpnZNW
         Yha6C5YuimBuT4/GUswbkZAbm0pNJz9LKKHv2hBeMgs+MawhKSm9niwfpNrqCeW927Vs
         6+8MqUwHTHb3xZxpzTUp2ikD4psRPi3Tz7bI6CS5PaUqQXpGMDfgzHr7eOPU4lcfreA8
         CU0A==
X-Gm-Message-State: AGi0PuY5PDMpU/thLTM5dK7Jz9P5D/ZODeSMOPCFDzfZ2vhuMqXYP/Wq
        5op7UdZ5TyiH60Ysc6VWmfX+Xw==
X-Google-Smtp-Source: APiQypLa1JacUHJ+QeokcMaEZM87v/v2o50a2V2iva/HH9LUehvg+Bz1b7fJMo2ykKancm0Rl5AMAA==
X-Received: by 2002:a63:2903:: with SMTP id p3mr5153192pgp.87.1586325183838;
        Tue, 07 Apr 2020 22:53:03 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id d26sm15488014pfo.37.2020.04.07.22.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 22:53:03 -0700 (PDT)
Date:   Wed, 8 Apr 2020 11:23:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     sumitg <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
Message-ID: <20200408055301.jhvu5bc2luu3b5qr@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20200326115023.xy3n5bl7uetuw7mx@vireshk-i7>
 <d233b26b-6b50-7d41-9f33-a5dc151e0e7d@nvidia.com>
 <20200406025549.qfwzlk3745y3r274@vireshk-i7>
 <3ab4136c-8cca-c2f9-d286-b82dac23e720@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab4136c-8cca-c2f9-d286-b82dac23e720@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-04-20, 23:48, sumitg wrote:
> On 06/04/20 8:25 AM, Viresh Kumar wrote:
> > On 05-04-20, 00:08, sumitg wrote:
> > > On 26/03/20 5:20 PM, Viresh Kumar wrote:
> > > > On 03-12-19, 23:02, Sumit Gupta wrote:
> > > > > diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> > > > > +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
> > > > > +{
> > > > > +     struct read_counters_work read_counters_work;
> > > > > +     struct tegra_cpu_ctr c;
> > > > > +     u32 delta_refcnt;
> > > > > +     u32 delta_ccnt;
> > > > > +     u32 rate_mhz;
> > > > > +
> > > > > +     read_counters_work.c.cpu = cpu;
> > > > > +     read_counters_work.c.delay = delay;
> > > > > +     INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
> > > > > +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
> > > > > +     flush_work(&read_counters_work.work);
> > > > 
> > > > Why can't this be done in current context ?
> > > > 
> > > We used work queue instead of smp_call_function_single() to have long delay.
> > 
> > Please explain completely, you have raised more questions than you
> > answered :)
> > 
> > Why do you want to have long delays ?
> > 
> Long delay value is used to have the observation window long enough for
> correctly reconstructing the CPU frequency considering noise.
> In next patch version, changed delay value to 500us which in our tests is
> considered reliable.

I understand that you need to put a udelay() while reading the freq from
hardware, that is fine, but why do you need a workqueue for that? Why can't you
just read the values directly from the same context ?

-- 
viresh
