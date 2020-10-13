Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7DF28CF8A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgJMNxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 09:53:51 -0400
Received: from foss.arm.com ([217.140.110.172]:60298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgJMNxv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 09:53:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37A6B31B;
        Tue, 13 Oct 2020 06:53:50 -0700 (PDT)
Received: from [10.57.51.141] (unknown [10.57.51.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EF83F66B;
        Tue, 13 Oct 2020 06:53:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sudeep.holla@arm.com, chris.redpath@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7> <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6a739b1b-e345-fa09-d815-6e9601aff5f6@arm.com>
Date:   Tue, 13 Oct 2020 14:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 10/9/20 6:39 AM, Viresh Kumar wrote:

<snip>

> 
> Oh yes, I get it now. Finally. Thanks for helping me out :)
> 
> So if I can say all this stuff in simple terms, this is what it will
> be like:
> 
> - We don't want software aggregation of frequencies and so we need to
>    have per-cpu policies even when they share their clock lines.
> 
> - But we still need a way for other frameworks to know which CPUs
>    share the clock lines (that's what the perf-dependency is all about,
>    right ?).
> 
> - We can't get it from SCMI, but need a DT based solution.
> 
> - Currently for the cpufreq-case we relied for this on the way OPP
>    tables for the CPUs were described. i.e. the opp-table is marked as
>    "shared" and multiple CPUs point to it.


I've started wondering based on the OPP code if this is a good solution.
We would end up with one (?) instance of opp_table and list of devices
pinned to it, in: opp_table->dev_list
It can be seen e.g. in function dev_pm_opp_get_sharing_cpus(),
where we retrieve the cpumask simply looping through the devices:

list_for_each_entry(opp_dev, &opp_table->dev_list, node)
	cpumask_set_cpu(opp_dev->dev->id, cpumask);


This means we have a single OPP table for all pinned CPUs.
I wonder if this is not too strong assumption for still being compliant
with SCMI spec, when in theory performance levels might differ...
(please correct me here it that would never happen)

There is also 2nd function dev_pm_opp_of_get_sharing_cpus() which looks
more promising. But I still don't know if the framework will allow us
to have private OPP tables when we use 'shared' in DT.

Could you clarify if we would get 'private' opp table for each CPU,
which could be then populated independently, but still 2nd function will
work?

Regards,
Lukasz
