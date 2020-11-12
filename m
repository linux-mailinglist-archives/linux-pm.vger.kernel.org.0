Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651742B0221
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 10:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKLJl2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 04:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgKLJl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 04:41:28 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C84C0613D1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 01:41:27 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c66so4020388pfa.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 01:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wVL/s/yrlnPufi8DrUfp2Umli3Q6ESCeDHBpTl7tchw=;
        b=hm/piCDTZaros+BuKuNZ5YkivpyT666h9e7P2HpzoNzlwuMA3PEmv5/G0yLhA8LRaS
         1fEgPT9sLbfJWS1+KGjhOK2XLK5Ig789bR3VstJLhhcIos2eGjt0IqIQOV2Sfs6VH1CD
         rs17zrt3qxVbepVAHaT7wWHLuhr4ZQVKEtn4sJ1qiO4nP8sz8KDNQcxgj9XX2LjzQO2B
         rdKtm/GMNqofASVPKM8325R/lVT8I1fCbjy+bW03P5IOP3RgC4x5B0qWnlNahSHOCbIZ
         lyYdGC82hQKHyv8T6ebPotjDTyDVNdYnf2WOQlzZJ2JP9043Q6vWVi3uz874TwbOpStQ
         E+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wVL/s/yrlnPufi8DrUfp2Umli3Q6ESCeDHBpTl7tchw=;
        b=ShAKoIXh2c9IugaaPHW0hbkxWxO5eKNajus5dMDvuIHrJThIIXZLw0gZjDuGHMYbj3
         SuxRAmQt7xGmTCrCAD8TUrLMP3cgJTkhICbNiqbyJnFe7rxe1XbARoxnYU17DVIscT7d
         gOlMIqMTHZhDfG80k1cfcyT2QQBXp0o2dTaE6ww66CFO4iQuXSkyqmov9QJ1CHYjZR6m
         l9ulPnyKrJMzaH2jWLeEg2C24g+07g1WOuPNulCu+iJuk/oMALu+Juj2nE/SuUXE38MA
         wm6UKKpy+jPewOUofxMnQ8GrT9yxFqNNT4+F2JxfDiunGWtAB5XdU2pUz6WEiqWbhEAP
         aaiA==
X-Gm-Message-State: AOAM533C86FEUidkYQh69T46UrwewG9IdI494gWDtTqgpwtMKP0l3VPN
        QeMRZijD9S+zLcLd9PA/Pq1Mpg==
X-Google-Smtp-Source: ABdhPJwxrITs8pIGkWSW4BQAIwd1XdN02tcgPX0pu26Rfnd+/UZX3j7JPfj4pUdC1Cuvb1gfrO2gHQ==
X-Received: by 2002:a17:90a:1d09:: with SMTP id c9mr8601165pjd.80.1605174087438;
        Thu, 12 Nov 2020 01:41:27 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id x30sm5414261pgc.86.2020.11.12.01.41.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 01:41:26 -0800 (PST)
Date:   Thu, 12 Nov 2020 15:11:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
Message-ID: <20201112094123.zgua2wq6iochrv2e@vireshk-i7>
References: <cover.1603448113.git.viresh.kumar@linaro.org>
 <11e7c7dcb07ae258fa02e187c9697252f3835466.1603448113.git.viresh.kumar@linaro.org>
 <20201023103712.GL2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023103712.GL2594@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 12:37, Peter Zijlstra wrote:
> Actual numbers that show the goodness would be nice ;-) Because clearly
> we're doing this make it better.

Hi Peter,

I tried the patchset with hackbench, sysbench and schbench. None of them showed
any regression or significant improvements. schbench was the one I was most
hopeful with as it creates the scenario where the utilization numbers provide a
better estimate of the future.

Scenario 1: The CPUs were mostly idle in the previous polling window of the IPA
governor as the tasks were sleeping and here are the details from traces (load
is in %):

   thermal_power_cpu_get_power: Old: cpus=00000000,000000ff freq=1200000 total_load=203 load={{0x35,0x1,0x0,0x31,0x0,0x0,0x64,0x0}} dynamic_power=1339
   thermal_power_cpu_get_power: New: cpus=00000000,000000ff freq=1200000 total_load=600 load={{0x60,0x46,0x45,0x45,0x48,0x3b,0x61,0x44}} dynamic_power=3960

Here, the "Old" line gives the load and requested_power (dynamic_power here)
numbers calculated using the idle time based implementation. And "New" is based
on CPU utilization from this patchset.

As can be clearly seen, the load and requested_power numbers are simply
incorrect in the idle time based approach and the numbers collected from CPU's
utilization are much better and will also match the expectations of the
schedutil governor.

Scenario 2: The CPUs were busy in the previous polling window of the IPA
governor:

   thermal_power_cpu_get_power: Old: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
   thermal_power_cpu_get_power: New: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672

As can be seen, the idle time based load is 100% for all the CPUs as it took
only the last window into account, but in reality the CPUs aren't that loaded as
shown by the utilazation numbers.

Though this patchset improves the power estimation done by the cpufreq_cooling
driver (which matches with the freq scaling governor, schedutil, as well), the
IPA governor doesn't necessarily appreciate the correctness of it as it takes
the decision to choose the next cooling state based on multiple factors, like
current temperature, target temperature, requested_power, all power players (who
request power from it), etc. The algorithm is complex there and I am afraid the
improved numbers here don't necessarily translate to better numbers for the
benchmarks like schbench. Another factor can be IPAs tuning for my platform
(Hikey6220).

Irrespective of the IPA governor, the estimate provided by the cpufreq cooling
driver does improve a lot with this patchset and are better aligned with the
schedutil governor and I believe it would be better to merge this nevertheless.

I have already prepared the next version which takes care of !SMP case, was just
holding it off until I was trying to get some numbers out.

-- 
viresh
