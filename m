Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644D01A62FC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 08:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgDMGVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 02:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgDMGVp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 02:21:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26824C0A3BE0
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2020 23:21:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r4so4062469pgg.4
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2020 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=La50agcb/2KWA0YXVPyR15X/cVxbH5EFFNzow2CasCk=;
        b=U4AhDKmpTjiiQCZMx8qJ1pvV8qHN5/3QPa+VuBSFlJKps1DI9ITUMc5Vs0rjFqGEFk
         jnergkSEQGWU+5Kxd+rABuZrt2Uj2pIFjr97R4gXPKNC2B/tXBLXUEMn3jWZTCMxTC+d
         Y4KwetQ/ZEN+5oNXk8NX3XVPtMRJjfP50fHutrzSmg8Ifet9woNEzC0a/qi0yLFeVccx
         yRgkeliuuX2KAd5dT6IYcQ6e99JJXkCFk5kQixdxmzcrT9s3llqQkdUclDJTvA9sLQPS
         owAhwVjvH/loJKinZhJcY6sV48c57edrdQub9pYTPcZQAbuOoulrCTh1pW59H8Tz2tlK
         lW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=La50agcb/2KWA0YXVPyR15X/cVxbH5EFFNzow2CasCk=;
        b=lPaSc+jA2YA71uV7dB8uPHZsCK4SeTBPgBrpH7sW/WW5zki+t0TJTb8pSQB8an10XL
         TboQ0hq7ch9SB0kD/Iu1cYaWvPLgmwKRj9Uv87Wb7MuA/t81YoAuEYlJkl/3FL0niQs7
         hbFqzIj+KFM8YQDRBT/0GRhzu8umGn6yxV7bp7FRLLSg68JwVzjujavKpviXL7C4kZPZ
         Dpo2iBqwpPpE4nimRIkeA6g4QoFwyc3v6j9Vw+psRKoAmHise9e2Y159/BB88G4Hqnnl
         5rdgfUQpdkLYW24MZzJZO85cqraQjcNHKGTvtJV+mzCiVJXcu2w37s1lfKZlkyxdPIMC
         ZZ6Q==
X-Gm-Message-State: AGi0PuZ8yFtmlriM83nEHdvLxqox0OcXmbC7h1c7vQ+gxEFX0wFcAmC2
        VpSxv+u9OkSlXU2r1zCyFoIdcg==
X-Google-Smtp-Source: APiQypJQcvb09jM8vKcT10ou779L5BrE/iVeMVqorUgMs0rxNdmOzAZ2huH75ZLiRKpYDW7+F1nNsw==
X-Received: by 2002:a63:a50c:: with SMTP id n12mr16740745pgf.274.1586758905511;
        Sun, 12 Apr 2020 23:21:45 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id d203sm2351825pfd.79.2020.04.12.23.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 23:21:44 -0700 (PDT)
Date:   Mon, 13 Apr 2020 11:51:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
Message-ID: <20200413062141.a6hmwipexhv3sctq@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20200326115023.xy3n5bl7uetuw7mx@vireshk-i7>
 <d233b26b-6b50-7d41-9f33-a5dc151e0e7d@nvidia.com>
 <20200406025549.qfwzlk3745y3r274@vireshk-i7>
 <3ab4136c-8cca-c2f9-d286-b82dac23e720@nvidia.com>
 <20200408055301.jhvu5bc2luu3b5qr@vireshk-i7>
 <08307e54-0e14-14a3-7d6a-d59e1e04a683@nvidia.com>
 <20200409074415.twpzu2n4frqlde7b@vireshk-i7>
 <00390070-38a1-19aa-ca59-42c4658bee7e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00390070-38a1-19aa-ca59-42c4658bee7e@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-04-20, 16:51, Sumit Gupta wrote:
> We are using "read_counters_work" as local variable. So every invocation the
> function will have its own copy of counters for corresponding cpu. That's
> why are doing INIT_WORK_ONSTACK here.

Why? To support parallel calls to reading the freq ?

> > > > > > > > > +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
> > > > > > > > > +     flush_work(&read_counters_work.work);
> > > > > > > > 
> > > > > > > > Why can't this be done in current context ?
> > > > > > > > 
> > > > > > > We used work queue instead of smp_call_function_single() to have long delay.
> > > > > > 
> > > > > > Please explain completely, you have raised more questions than you
> > > > > > answered :)
> > > > > > 
> > > > > > Why do you want to have long delays ?
> > > > > > 
> > > > > Long delay value is used to have the observation window long enough for
> > > > > correctly reconstructing the CPU frequency considering noise.
> > > > > In next patch version, changed delay value to 500us which in our tests is
> > > > > considered reliable.
> > > > 
> > > > I understand that you need to put a udelay() while reading the freq from
> > > > hardware, that is fine, but why do you need a workqueue for that? Why can't you
> > > > just read the values directly from the same context ?
> > > > 
> > > The register to read frequency is per core and not accessible to other
> > > cores. So, we have to execute the function remotely as the target core to
> > > read frequency might be different from current.
> > > The functions for that are smp_call_function_single or queue_work_on.
> > > We used queue_work_on() to avoid long delay inside ipi interrupt context
> > > with interrupts disabled.
> > 
> > Okay, I understand this now, finally :)
> > 
> > But if the interrupts are disabled during some call, won't workqueues face the
> > same problem ?
> > 
> Yes, we are trying to minimize the case.

But how do you know workqueues will perform better than
smp_call_function_single() ? Just asking for clarity on this as normally
everyone tries to do smp_call_function_single().

-- 
viresh
