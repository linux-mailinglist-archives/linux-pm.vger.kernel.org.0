Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991F51A3063
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDIHoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 03:44:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36432 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgDIHoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 03:44:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id n10so3759451pff.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2020 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4xKuTMpvub44uC+2VePDHC2aHUHahAepDBHwFjnk3U=;
        b=BRdTs+aUrBtkDH3qvrVnSv17R/XI4bmx3i/sUL+WIVC1VN4nUGqRW5P2DPokR8Pox4
         Jty0vLGz8xpjnzIArbd/y1S9HKzmdEkIdu9W4GOJTfwKOpiZhOqxOzouv8wtRXDiTVKA
         H/ktGuX7DMh5izjF8whaDS/SOYuiDuTxVPUagdnP0URZMl8Cuxm/4Iy9x7uepkxNoix2
         3CK8gk7FLxV6hSNKJKLoLh4gJ4/b06x5uLe1Cff4Yd2rdscP3gAZuYZAf3XoXSX+oBvA
         fHtPSef1lmA5xyTN1GH/OnUNoXFgIktEnp+S6Hb3v0DipiT2x4Q6w99rvOXqdzALSXcI
         q42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4xKuTMpvub44uC+2VePDHC2aHUHahAepDBHwFjnk3U=;
        b=nwPxhkLYvlU3TP3yzvPMn/qluMCwADJpI1e1PBBVtd2gRPQniUUOD0hwaZDPkptIZB
         topQXKJzMbg7rvH1HEhP3PFJ4YeVqjiNJWkuoJHQtQJdrm4L3K2DiaSNBNt8IfWvgpuN
         eDCpYcEPLtmkIqCfTbLJA6EFkAcw0WtJusxOxz+zlYWkrHNbcekJFywekKiLYrH4/o/J
         OovdnOGNYzeGm3kZlWtgjeAssmCujrSsrgOfg/soYYqbRJ2srKwX6f8XEVvoDWPPo0Bn
         Sk6VD7KeT2SgmVd2RZ/LLq3Osh/jFbxIQuEkRRu0f4wyjLl2lsYDDMEm6rkVnemhCpEb
         CLQQ==
X-Gm-Message-State: AGi0PuajCeOOkVb0sUFelUuyBKvCNZugOMRBRWjKJyegliBM2jwHj0pl
        gN9srTBmX000wReHuf+guXcZoQ==
X-Google-Smtp-Source: APiQypLfvzycvtY7B0F9LPaaNExw8KdQUsdLORxwe+vO7XdvZD2yR56LW38fhQ7je8aXybIQeolseA==
X-Received: by 2002:a62:d10b:: with SMTP id z11mr11675504pfg.205.1586418258201;
        Thu, 09 Apr 2020 00:44:18 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id k20sm17128358pgn.62.2020.04.09.00.44.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 00:44:17 -0700 (PDT)
Date:   Thu, 9 Apr 2020 13:14:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     sumitg <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
Message-ID: <20200409074415.twpzu2n4frqlde7b@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20200326115023.xy3n5bl7uetuw7mx@vireshk-i7>
 <d233b26b-6b50-7d41-9f33-a5dc151e0e7d@nvidia.com>
 <20200406025549.qfwzlk3745y3r274@vireshk-i7>
 <3ab4136c-8cca-c2f9-d286-b82dac23e720@nvidia.com>
 <20200408055301.jhvu5bc2luu3b5qr@vireshk-i7>
 <08307e54-0e14-14a3-7d6a-d59e1e04a683@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08307e54-0e14-14a3-7d6a-d59e1e04a683@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-04-20, 16:54, sumitg wrote:
> 
> 
> On 08/04/20 11:23 AM, Viresh Kumar wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 07-04-20, 23:48, sumitg wrote:
> > > On 06/04/20 8:25 AM, Viresh Kumar wrote:
> > > > On 05-04-20, 00:08, sumitg wrote:
> > > > > On 26/03/20 5:20 PM, Viresh Kumar wrote:
> > > > > > On 03-12-19, 23:02, Sumit Gupta wrote:
> > > > > > > diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> > > > > > > +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
> > > > > > > +{
> > > > > > > +     struct read_counters_work read_counters_work;
> > > > > > > +     struct tegra_cpu_ctr c;
> > > > > > > +     u32 delta_refcnt;
> > > > > > > +     u32 delta_ccnt;
> > > > > > > +     u32 rate_mhz;
> > > > > > > +
> > > > > > > +     read_counters_work.c.cpu = cpu;
> > > > > > > +     read_counters_work.c.delay = delay;
> > > > > > > +     INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);

Initialize the work only once from init routine.

> > > > > > > +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
> > > > > > > +     flush_work(&read_counters_work.work);
> > > > > > 
> > > > > > Why can't this be done in current context ?
> > > > > > 
> > > > > We used work queue instead of smp_call_function_single() to have long delay.
> > > > 
> > > > Please explain completely, you have raised more questions than you
> > > > answered :)
> > > > 
> > > > Why do you want to have long delays ?
> > > > 
> > > Long delay value is used to have the observation window long enough for
> > > correctly reconstructing the CPU frequency considering noise.
> > > In next patch version, changed delay value to 500us which in our tests is
> > > considered reliable.
> > 
> > I understand that you need to put a udelay() while reading the freq from
> > hardware, that is fine, but why do you need a workqueue for that? Why can't you
> > just read the values directly from the same context ?
> > 
> The register to read frequency is per core and not accessible to other
> cores. So, we have to execute the function remotely as the target core to
> read frequency might be different from current.
> The functions for that are smp_call_function_single or queue_work_on.
> We used queue_work_on() to avoid long delay inside ipi interrupt context
> with interrupts disabled.

Okay, I understand this now, finally :)

But if the interrupts are disabled during some call, won't workqueues face the
same problem ?

-- 
viresh
