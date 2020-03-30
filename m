Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E800B197C2C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 14:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgC3Mph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 08:45:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbgC3Mpg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 08:45:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD46330E;
        Mon, 30 Mar 2020 05:45:35 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D01383F71E;
        Mon, 30 Mar 2020 05:45:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] driver core: Replace open-coded list_last_entry()
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        fntoth@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
 <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
 <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com> <20200330095707.GA10432@bogus>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0a374eaa-92b3-0201-f357-4181542c98b6@arm.com>
Date:   Mon, 30 Mar 2020 13:45:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330095707.GA10432@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-30 11:13 am, Sudeep Holla wrote:
> On Fri, Mar 27, 2020 at 07:40:25PM +0000, Robin Murphy wrote:
>> On 2020-03-27 5:56 pm, Naresh Kamboju wrote:
>>> The kernel warning noticed on arm64 juno-r2 device running linux
>>> next-20200326 and next-20200327
>>
>> I suspect this is the correct expected behaviour manifesting. If you're
>> using the upstream juno-r2.dts, the power domain being waited for here is
>> provided by SCPI, however unless you're using an SCP firmware from at least
>> 3 years ago you won't actually have SCPI since they switched it to the newer
>> SCMI protocol, which is not yet supported upstream for Juno. See what
>> happened earlier in the log:
>>
>> [    2.741206] scpi_protocol scpi: incorrect or no SCP firmware found
>> [    2.747586] scpi_protocol: probe of scpi failed with error -110
>>
>> Thus this is the "waiting for a dependency which will never appear" case,
>> for which I assume the warning is intentional,
> 
> Is that the case ?
> 
> Previously we used to get the warning:
> "amba xx: ignoring dependency for device, assuming no driver"
> 
> Now we have the kernel warning in addition to the above.

AFAICS the difference is down to whether deferred_probe_timeout has 
expired or not - I'm not familiar enough with this code to know 
*exactly* what the difference is supposed to represent, nor which change 
has actually pushed the Juno case from one state to the other (other 
than it almost certainly can't be $SUBJECT - if this series is to blame 
at all I'd assume it would be down to patch #1/3, but there's a bunch of 
other rework previously queued in -next that is probably also interacting)

>> since the system is essentially broken (i.e. the hardware/firmware doesn't
>> actually match what the DT describes).
>>
> 
> Not sure if we can term it as "essentially broken". Definitely not 100%
> functional but not broken if the situation like on Juno where SCP firmware
> is fundamental for all OSPM but not essential for boot and other minimum
> set of functionality.

It's "broken" in the sense that the underlying system is *not* the 
system described in the DT. Yes, all the parts that still happen to line 
up will mostly still function OK, but those that don't will 
fundamentally not work as the kernel has been told to expect. I'm not 
sure what you prefer to call "not working as the kernel expects", but I 
call it "broken" ;)

Robin.
