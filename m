Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89413285F8D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgJGM45 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 08:56:57 -0400
Received: from foss.arm.com ([217.140.110.172]:43404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgJGM44 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 08:56:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C7121042;
        Wed,  7 Oct 2020 05:56:56 -0700 (PDT)
Received: from [10.57.14.1] (unknown [10.57.14.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33CD43F66B;
        Wed,  7 Oct 2020 05:56:54 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, daniel.lezcano@linaro.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
Date:   Wed, 7 Oct 2020 13:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

performance controls is what is exposed by the firmware through a protocol that
is not capable of describing hardware (say SCMI). For example, the firmware can
tell that the platform has N controls, but it can't say to which hardware they
are "wired" to. This is done in dt, where, for example, we map these controls
to cpus, gpus, etc.

Let's focus on cpus.

Normally we would have N of performance controls (what comes from f/w)
that that correspond to hardware clock/dvfs domains.

However, some firmware implementations might benefit from having finer
grained information about the performance requirements (e.g.
per-CPU) and therefore choose to present M performance controls to the
OS. DT would be adjusted accordingly to "wire" these controls to cpus
or set of cpus.
In this scenario, the f/w will make aggregation decisions based on the
requests it receives on these M controls.

Here we would have M cpufreq policies which do not necessarily reflect the
underlying clock domains, thus some s/w components will underperform
(EAS and thermal, for example).

A real example would be a platform in which the firmware describes the system
having M per-cpu control, and the cpufreq subsystem will have M policies while
in fact these cpus are "performance-dependent" each other (e.g. are in the same
clock domain). This performance dependency information is essential for some
components that take information from the cpufreq policy.

To restore functionality we can use the optional node
'cpu-performance-dependencies' in dt which will provide such dependency
information and we can add a new cpumask 'dependency_cpus' in policy.

Hope it gives some clarity.

Nicola

On 10/6/20 8:19 AM, Viresh Kumar wrote:
> On 24-09-20, 10:53, Nicola Mazzucato wrote:
>> I am seeking some feedback/comments on the following approach.
>>
>> Intro:
>> Info of performance depency for cpus will be beneficial for systems
>> where f/w description of the CPU performance control domain is different
>> from the clock domain, e.g. per-CPU control with multiple CPUs sharing
>> clock, and kernel OSPM s/w components need to take CPU performance
>> dependency into account.
>> Essentially these s/w components will have to be provided with
>> this information from dt and this RFC is presenting a possible way
>> to do so.
> 
> I am not sure I understand what performance control mean here. Can you please
> elaborate a bit more on that ? For example, with current code and understanding,
> a cpufreq policy belongs to a group of CPUs which change their frequency
> together, which also mean that they change their performance level together and
> so I am not able to understand what's going on here. Sorry about that.
> 
> What kind of hardware configuration doesn't work with this ?
> 
