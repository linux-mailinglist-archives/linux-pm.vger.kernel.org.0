Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521212881C4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 07:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgJIFja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 01:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbgJIFjZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 01:39:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D3C0613D2
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 22:39:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d23so3921548pll.7
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5XFp/TQ+7hBTNX7tGRh5p9KVD5KnxYojfu0YjAHyWbA=;
        b=ACgWQtnMswGUmSv/Ok4YOviJF2RAEfH270R59qr1nPnGgznQMP/BnJFgEq94vJlVa4
         jz4B4TAswO8Ab+X5LCceQYtjctXC+Lb+T6VIb2LF3K1zi/tVaPJK2Pwbuy/cX0Wjxp0i
         AD5cenPUUbNDh+gSykieoeMbeTGMhssn/OJUhqxfr/QhgjRF44/8/EU2eraD8UUR/dCZ
         bBuesZLCp9Ms9p+HTHwEQSCBTpCXR3tgh6dxAuheomjXfNJ9/KwnFQXl5kD6PppD2kF1
         fq52zmTA/G09muSJ3DLos+/i49vOWT3/KC9t3zx4hGAHpac+J47ijl2IpCVYva9vli++
         BoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XFp/TQ+7hBTNX7tGRh5p9KVD5KnxYojfu0YjAHyWbA=;
        b=cnO98v7HtnOxafLv7FNG0pFO38gb9SpOoUyh9giMWGB2kfJmZIwrijydJRE9NVXC3e
         ysN9T0tkAGl4vEtbiglyZ20OZG2mWg5nUlhG3ZzhYWrUo0hHni4QTMubdEbmjdzGEPfj
         aF6uoZRih7krlm322TDQhIC64pcCcspeXREqGQxdEEpiBRKfLdhOsGqsg1pKft8gu4iC
         ys1vliIZHHFcxN7dMp7e0ED/sZt/DA+hlJQpT8fXo3KewqkwEy+/jJ25pbX9rvKAOhDw
         8LJg5CrJ/83LX1G5PFt1zFOtmN7GWxnMb1s6KShptnZOXL9T+saYPlWB9RHT3+8kCf1l
         UQyg==
X-Gm-Message-State: AOAM531+hGb1nPXAATOrRu8y9YCrgyCm3WiZ9F2uy2xqdbnBcJwa6kDl
        irVUbN1Rs0Qkk7g2vzCb+sKlC+CMWq2fZw==
X-Google-Smtp-Source: ABdhPJwWGpiL1tAy4MkYOeQAF6yCYFUaWb1xOOdzn2+cBDQUNoE7eXaHQruYvJyPrrggNWK55dfOVg==
X-Received: by 2002:a17:902:222:b029:d3:b4d2:105e with SMTP id 31-20020a1709020222b02900d3b4d2105emr10991661plc.32.1602221964915;
        Thu, 08 Oct 2020 22:39:24 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id c10sm9293316pfc.196.2020.10.08.22.39.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 22:39:23 -0700 (PDT)
Date:   Fri, 9 Oct 2020 11:09:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sudeep.holla@arm.com, chris.redpath@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-10-20, 17:00, Nicola Mazzucato wrote:
> On 10/8/20 4:03 PM, Ionela Voinescu wrote:
> > Hi Viresh,
> > 
> > On Thursday 08 Oct 2020 at 16:32:41 (+0530), Viresh Kumar wrote:
> >> On 07-10-20, 13:58, Nicola Mazzucato wrote:
> >>> Hi Viresh,
> >>>
> >>> performance controls is what is exposed by the firmware through a protocol that
> >>> is not capable of describing hardware (say SCMI). For example, the firmware can
> >>> tell that the platform has N controls, but it can't say to which hardware they
> >>> are "wired" to. This is done in dt, where, for example, we map these controls
> >>> to cpus, gpus, etc.
> >>>
> >>> Let's focus on cpus.
> >>>
> >>> Normally we would have N of performance controls (what comes from f/w)
> >>> that that correspond to hardware clock/dvfs domains.
> >>>
> >>> However, some firmware implementations might benefit from having finer
> >>> grained information about the performance requirements (e.g.
> >>> per-CPU) and therefore choose to present M performance controls to the
> >>> OS. DT would be adjusted accordingly to "wire" these controls to cpus
> >>> or set of cpus.
> >>> In this scenario, the f/w will make aggregation decisions based on the
> >>> requests it receives on these M controls.
> >>>
> >>> Here we would have M cpufreq policies which do not necessarily reflect the
> >>> underlying clock domains, thus some s/w components will underperform
> >>> (EAS and thermal, for example).
> >>>
> >>> A real example would be a platform in which the firmware describes the system
> >>> having M per-cpu control, and the cpufreq subsystem will have M policies while
> >>> in fact these cpus are "performance-dependent" each other (e.g. are in the same
> >>> clock domain).
> >>
> >> If the CPUs are in the same clock domain, they must be part of the
> >> same cpufreq policy.
> > 
> > But cpufreq does not currently support HW_ALL (I'm using the ACPI
> > coordination type to describe the generic scenario of using hardware
> > aggregation and coordination when establishing the clock rate of CPUs).
> > 
> > Adding support for HW_ALL* will involve either bypassing some
> > assumptions around cpufreq policies or making core cpufreq changes.
> > 
> > In the way I see it, support for HW_ALL involves either:
> > 
> >  - (a) Creating per-cpu policies in order to allow each of the CPUs to
> >    send their own frequency request to the hardware which will do
> >    aggregation and clock rate decision at the level of the clock
> >    domain. The PSD domains (ACPI) and the new DT binding will tell
> >    which CPUs are actually in the same clock domain for whomever is
> >    interested, despite those CPUs not being in the same policy.
> >    This requires the extra mask that Nicola introduced.
> > 
> >  - (b) Making deep changes to cpufreq (core/governors/drivers) to allow:
> >    - Governors to stop aggregating (usually max) the information
> >      for each of the CPUs in the policy and convey to the core
> >      information for each CPU.
> >    - Cpufreq core to be able to receive and pass this information
> >      down to the drivers.
> >    - Drivers to be able to have some per cpu structures to hold
> >      frequency control (let's say SCP fast channel addresses) for
> >      each of the CPUs in the policy. Or have these structures in the
> >      cpufreq core/policy, to avoid code duplication in drivers.
> > 
> > Therefore (a) is the least invasive but we'll be bypassing the rule
> > above. But to make that rule stick we'll have to make invasive cpufreq
> > changes (b).
> 
> Regarding the 'rule' above of one cpufreq policy per clock domain, I would like
> to share my understanding on it. Perhaps it's a good opportunity to shed some light.
> 
> Looking back in the history of CPUFreq, related_cpus was originally designed
> to hold the map of cpus within the same clock. Later on, the meaning of this
> cpumask changed [1].
> This led to the introduction of a new cpumask 'freqdomain_cpus'
> within acpi-cpufreq to keep the knowledge of hardware clock domains for
> sysfs consumers since related_cpus was not suitable anymore for this.
> Further on, this cpumask was assigned to online+offline cpus within the same clk
> domain when sw coordination is in use [2].
> 
> My interpretation is that there is no guarantee that related_cpus holds the
> 'real' hardware clock implementation. As a consequence, it is not true anymore
> that cpus that are in the same clock domain will be part of the same
> policy.
> 
> This guided me to think it would be better to have a cpumask which always holds
> the real hw clock domains in the policy.
> 
> > 
> > This is my current understanding and I'm leaning towards (a). What do
> > you think?
> > 
> > *in not so many words, this is what these patches are trying to propose,
> > while also making sure it's supported for both ACPI and DT.
> > 
> > BTW, thank you for your effort in making sense of this!
> > 
> > Regards,
> > Ionela.
> > 
> 
> This could be a platform where per-cpu and perf-dependencies will be used:
> 
> CPU:              0    1    2    3    4    5    6    7
> Type:             A    A    A    A    B    B    B    B
> Cluster:         [                                    ]
> perf-controls:   [  ] [  ] [  ] [ ]  [ ]  [ ]  [ ]  [ ]
> perf-dependency: [                ]  [                ]
> HW clock:        [                ]  [                ]
> 
> The firmware will present 8 controls to the OS and each control is mapped to a
> cpu device via the standard dt. This is done so we can achieve hw coordination.
> What is required in these systems is to present to OS the information of which
> cpus belong to which clock domain. In other words, when hw coordinates we don't
> have any way at present in dt to understand how these cpus are dependent
> each other, from performance perspective (as opposed to ACPI where we have
> _PSD). Hence my proposal for the new cpu-perf-dependencies.
> This is regardless whether we decide to go for either a policy per-cpu or a
> policy per-domain.
> 
> Hope it helps.

Oh yes, I get it now. Finally. Thanks for helping me out :)

So if I can say all this stuff in simple terms, this is what it will
be like:

- We don't want software aggregation of frequencies and so we need to
  have per-cpu policies even when they share their clock lines.

- But we still need a way for other frameworks to know which CPUs
  share the clock lines (that's what the perf-dependency is all about,
  right ?).

- We can't get it from SCMI, but need a DT based solution.

- Currently for the cpufreq-case we relied for this on the way OPP
  tables for the CPUs were described. i.e. the opp-table is marked as
  "shared" and multiple CPUs point to it.

- I wonder if we can keep using that instead of creating new bindings
  for exact same stuff ? Though the difference here would be that the
  OPP may not have any other entries.

-- 
viresh
