Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4920421F71F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGNQU5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 12:20:57 -0400
Received: from foss.arm.com ([217.140.110.172]:46150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNQU5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 12:20:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D781730E;
        Tue, 14 Jul 2020 09:20:56 -0700 (PDT)
Received: from [10.57.32.45] (unknown [10.57.32.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9C53F7BB;
        Tue, 14 Jul 2020 09:20:55 -0700 (PDT)
Subject: Re: [PATCH 08/13] cpufreq: acpi-cpufreq: Take 'dummy' principle one
 stage further
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Denis Sadykov <denis.m.sadykov@intel.com>,
        Andy Grover <andrew.grover@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dominik Brodowski <linux@brodo.de>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-9-lee.jones@linaro.org>
 <CAJZ5v0igiz-VmmDC2qsZ3AhqjGhM54LHMLeLdZ7Dr=h5Dm9Rrg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8b2f7674-9e33-e09c-cf99-84c59edb9779@arm.com>
Date:   Tue, 14 Jul 2020 17:20:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0igiz-VmmDC2qsZ3AhqjGhM54LHMLeLdZ7Dr=h5Dm9Rrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-07-14 17:03, Rafael J. Wysocki wrote:
> On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
>>
>> If we fail to use a variable, even a 'dummy' one, then the compiler
>> complains that it is set but not used.  We know this is fine, so we
>> set it to its own value here.
> 
> Which is kind of ugly in my personal view.  I hope that the compiler
> will actually optimize the extra code away ...
> 
>> Fixes the following W=1 kernel build warning(s):
> 
> Well, "Makes the following ... warning(s) go away:" rather ...

Isn't that what we have __maybe_unused and __always_unused for?

Robin.

>>   drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_intel’:
>>   drivers/cpufreq/acpi-cpufreq.c:247:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
>>   drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_amd’:
>>   drivers/cpufreq/acpi-cpufreq.c:265:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
>>
>> Cc: Andy Grover <andrew.grover@intel.com>
>> Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>> Cc: Dominik Brodowski <linux@brodo.de>
>> Cc: Denis Sadykov <denis.m.sadykov@intel.com>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/cpufreq/acpi-cpufreq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 429e5a36c08a9..d38a693b48e03 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -247,6 +247,7 @@ static u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
>>          u32 val, dummy;
>>
>>          rdmsr(MSR_IA32_PERF_CTL, val, dummy);
>> +       dummy &= dummy; /* Silence set but not used warning */
>>          return val;
>>   }
>>
>> @@ -264,6 +265,7 @@ static u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
>>          u32 val, dummy;
>>
>>          rdmsr(MSR_AMD_PERF_CTL, val, dummy);
>> +       dummy &= dummy; /* Silence set but not used warning */
>>          return val;
>>   }
>>
>> --
>> 2.25.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
