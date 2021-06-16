Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E223A90DB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 06:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhFPE7S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 00:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhFPE7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 00:59:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE30CC061760
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 21:57:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t17so972294pga.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v8hbVhD6RJ1rCqy3ceV7Ta+sxe8bF6UYG1xbjeCTyLE=;
        b=CXo9noL0vjRA3eeSlrkRI4PbOiCjOgKwZSSX7sptD1zNOPIDuOns5q7fTqxi8EXrvz
         CwQn8gk0w7d9LOIVVzZFz1S/3FWWvYUDRj3ioS5YpD5PqVQfZXKjBNtBT7QjeOT1fhaW
         0u1eLGHz1ULmMf8SjwAdaQrWF58qTQSTwj+wocPYBf5/7bi8DCrBI7janw5BuXb9Ogfe
         0OnY7pcvtPgVoKDiN9K9t+fkNm/0aO2gb0L+o3nXxUQz0nL1ejLIgJ7J2dsIvylBherd
         XC8Wb95OFk7HGH0cY0/gmpmjv368PedwsBTOz6IVkxkt797CuekKMKKmItugq66s2COS
         wdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v8hbVhD6RJ1rCqy3ceV7Ta+sxe8bF6UYG1xbjeCTyLE=;
        b=U9kHjHn5pT/HxEZwWvd6gsYpm7JcJfTkFL33Nf/Yfwd5HdX/sqqEDV9mf0Ztb0hTve
         QI1I/bUvV651XA/yAMqQpHNFhvnschDE3htt0ioxV3tBAYC4mEMP2hKSbZsO/hCS2nkS
         vvT/juNx7hyz14bClpfQlMjV0v5ZFTGjMQ/eEiK9c/vlSddF8LzqFGAnd29Vm9ftp0Pl
         QNunNwQXXNMM0q2VmKUg81uMveAiA6MsYVfgIO9huQvDepuUZo1piFxeAXZDb66k+F8t
         92WXgeRfGnNiBBu+QaMpNDGm/wemSGLiSDHK+7PLt1r6+crpjJwmUD6E9u0GtujzkS/X
         il9g==
X-Gm-Message-State: AOAM531Tkw8c4T4ehAO3qvNRHShL60RoY41/n+u0dwikQ73KWRlsi5re
        QQ20yoSidIJUVnBvuqJf085Rktc++z++4A==
X-Google-Smtp-Source: ABdhPJy6cJ+XpDDStFqxCkawcrPEQQtViQgXyRYzGNQoRG7cyDxZksnDqZhoXVXH0sv3RUuihDLqxw==
X-Received: by 2002:a63:fa51:: with SMTP id g17mr3156940pgk.340.1623819432365;
        Tue, 15 Jun 2021 21:57:12 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id t143sm870957pgb.93.2021.06.15.21.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:57:11 -0700 (PDT)
Date:   Wed, 16 Jun 2021 10:27:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5] cpufreq: cppc: Fix suspend/resume specific races
 with FIE code
Message-ID: <20210616045709.nudm3ndbipp5nfnv@vireshk-i7>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
 <eaaaf171-5937-e0f2-8447-c1b20b474c62@quicinc.com>
 <20210615075056.dfkbiftuoihtrfpo@vireshk-i7>
 <19527d26-526e-6c6f-431d-7b78ed92bb34@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19527d26-526e-6c6f-431d-7b78ed92bb34@quicinc.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-06-21, 08:17, Qian Cai wrote:
> On 6/15/2021 3:50 AM, Viresh Kumar wrote:
> > This is a strange place to get the issue from. And this is a new
> > issue.
> 
> Well, it was still the same exercises with CPU online/offline.
> 
> > 
> >> [  488.151939][  T670]  kthread+0x3ac/0x460
> >> [  488.155854][  T670]  ret_from_fork+0x10/0x18
> >> [  488.160120][  T670] Code: 911e8000 aa1303e1 910a0000 941b595b (d4210000)
> >> [  488.166901][  T670] ---[ end trace e637e2d38b2cc087 ]---
> >> [  488.172206][  T670] Kernel panic - not syncing: Oops - BUG: Fatal exception
> >> [  488.179182][  T670] SMP: stopping secondary CPUs
> >> [  489.209347][  T670] SMP: failed to stop secondary CPUs 0-1,10-11,16-17,31
> >> [  489.216128][  T][  T670] Memoryn ]---
> > 
> > Can you give details on what exactly did you try to do, to get this ?
> > Normal boot or something more ?
> 
> Basically, it has the cpufreq driver as CPPC and the governor as
> schedutil. Running a few workloads to get CPU scaling up and down.
> Later, try to offline all CPUs until the last one and then online
> all CPUs.

Hmm, okay.

So I basically have very similar setup with 8 cores (1-policy
per-cpu), the only difference is I don't end up reading the
performance counters, everything else remains same. So I should see
issues now just like you, in case there are any.

Since the insmod/rmmod setup is a bit different, this is what I tried
today for around an hour with CONFIG_DEBUG_LIST and RCU debugging
options.

while true; do
    for i in `seq 1 7`;
    do
        echo 0 > /sys/devices/system/cpu/cpu$i/online;
    done;

    for i in `seq 1 7`;
    do
        echo 1 > /sys/devices/system/cpu/cpu$i/online;
    done;
done

I don't see any crashes, oops or warnings with latest stuff.

> I am hesitate to try this at the moment because this all feel like
> shooting in the dark.

I understand your point and you aren't completely wrong here. It
wasn't completely in dark but since I am unable to reproduce the issue
at my end, I asked for help.

FWIW, I think one of the possible cause of corruption of kthread thing
could have been because of the race in the topology related code. I
already fixed that in my tree yesterday.

> Ideally, you will be able to get access to one
> of those arm64 servers (Huawei, Ampere, TX2, FJ etc) eventually and
> really try the same exercises yourself with those debugging options
> like list debugging and KASAN on. That way you could fix things way
> efficiently.

Yeah, I thought of this work being over and I am not a user of it
normally. I had to enable it for ARM servers and I took help of my
colleagues (Vincent Guittot and Ionela) for testing the same.

I have also asked Vincent to give it a try again.

> I could share you the .config once you are there. Last
> but not least, once you get better narrow down of the issues, I'd
> hope to see someone else familiar with the code there to get review
> of those patches first (feel free to Cc me once you are ready to
> post) before I'll rerun the whole things again. That way we don't
> waste time on each other backing and forth chasing the shadow.

I did send the stuff up for review and this last thing (you reported)
was a different race altogether, so asked for testing without reviews.

Anyway, I am quite sure my tests have covered such issues now. I will
send out patches again soon.

Thanks Qian.

-- 
viresh
