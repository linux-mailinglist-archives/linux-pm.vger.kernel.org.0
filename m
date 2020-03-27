Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070B5195EE9
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 20:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0Tk3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 15:40:29 -0400
Received: from foss.arm.com ([217.140.110.172]:52252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgC0Tk2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 15:40:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D3730E;
        Fri, 27 Mar 2020 12:40:27 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB60E3F71E;
        Fri, 27 Mar 2020 12:40:25 -0700 (PDT)
Subject: Re: Re: [PATCH v2 3/3] driver core: Replace open-coded
 list_last_entry()
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com>
Date:   Fri, 27 Mar 2020 19:40:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-27 5:56 pm, Naresh Kamboju wrote:
> The kernel warning noticed on arm64 juno-r2 device running linux
> next-20200326 and next-20200327

I suspect this is the correct expected behaviour manifesting. If you're 
using the upstream juno-r2.dts, the power domain being waited for here 
is provided by SCPI, however unless you're using an SCP firmware from at 
least 3 years ago you won't actually have SCPI since they switched it to 
the newer SCMI protocol, which is not yet supported upstream for Juno. 
See what happened earlier in the log:

[    2.741206] scpi_protocol scpi: incorrect or no SCP firmware found
[    2.747586] scpi_protocol: probe of scpi failed with error -110

Thus this is the "waiting for a dependency which will never appear" 
case, for which I assume the warning is intentional, since the system is 
essentially broken (i.e. the hardware/firmware doesn't actually match 
what the DT describes).

Robin.

> [   36.077086] ------------[ cut here ]------------
> [   36.081752] amba 20010000.etf: deferred probe timeout, ignoring dependency
> [   36.081859] WARNING: CPU: 1 PID: 42 at drivers/base/dd.c:270
> driver_deferred_probe_check_state+0x54/0x80
> [   36.098242] Modules linked in: fuse
> [   36.101753] CPU: 1 PID: 42 Comm: kworker/1:1 Not tainted
> 5.6.0-rc7-next-20200327 #1
> [   36.109427] Hardware name: ARM Juno development board (r2) (DT)
> [   36.115372] Workqueue: events amba_deferred_retry_func
> [   36.120526] pstate: 60000005 (nZCv daif -PAN -UAO)
> [   36.125334] pc : driver_deferred_probe_check_state+0x54/0x80
> [   36.131010] lr : driver_deferred_probe_check_state+0x54/0x80
> [   36.136680] sp : ffff000934e0fae0
> [   36.140001] x29: ffff000934e0fae0 x28: ffff000934db5608
> [   36.145337] x27: ffffa00013c63240 x26: ffff000934f2a800
> [   36.150668] x25: 0000000000000001 x24: fffffffffffffffe
> [   36.155996] x23: ffff000934c6ab80 x22: ffffa00011b39ea0
> [   36.161322] x21: ffff000934f2a800 x20: ffffa00011905fe0
> [   36.166649] x19: ffff000934f2a800 x18: 0000000000000000
> [   36.171974] x17: 0000000000000000 x16: 0000000000000000
> [   36.177299] x15: 0000000000000000 x14: 003d090000000000
> [   36.182625] x13: 00003d0900000000 x12: ffff9400027ef445
> [   36.187952] x11: 1ffff400027ef444 x10: ffff9400027ef444
> [   36.193278] x9 : dfffa00000000000 x8 : 0000000000000000
> [   36.198603] x7 : 0000000000000001 x6 : ffffa00013f7a220
> [   36.203929] x5 : 0000000000000004 x4 : dfffa00000000000
> [   36.209255] x3 : ffffa000101a74ec x2 : ffff8001269c1f26
> [   36.214581] x1 : da1107b7b6a8fb00 x0 : 0000000000000000
> [   36.219906] Call trace:
> [   36.222369]  driver_deferred_probe_check_state+0x54/0x80
> [   36.227698]  __genpd_dev_pm_attach+0x264/0x2a0
> [   36.232154]  genpd_dev_pm_attach+0x68/0x78
> [   36.236265]  dev_pm_domain_attach+0x6c/0x70
> [   36.240463]  amba_device_try_add+0xec/0x3f8
> [   36.244659]  amba_deferred_retry_func+0x84/0x158
> [   36.249301]  process_one_work+0x3f0/0x660
> [   36.253326]  worker_thread+0x74/0x698
> [   36.256997]  kthread+0x218/0x220
> [   36.260236]  ret_from_fork+0x10/0x1c
> [   36.263819] ---[ end trace c637c10e549bd716 ]---#
> 
> Full test log,
> https://lkft.validation.linaro.org/scheduler/job/1317079#L981
> 
> On Tue, 24 Mar 2020 at 18:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Tue, Mar 24, 2020 at 1:20 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> There is a place in the code where open-coded version of list entry accessors
>>> list_last_entry() is used.
>>>
>>> Replace that with the standard macro.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>>> ---
>>> v2: no change
>>>   drivers/base/dd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index efd0e4c16ba5..27a4d51b5bba 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -1226,7 +1226,7 @@ void driver_detach(struct device_driver *drv)
>>>                          spin_unlock(&drv->p->klist_devices.k_lock);
>>>                          break;
>>>                  }
>>> -               dev_prv = list_entry(drv->p->klist_devices.k_list.prev,
>>> +               dev_prv = list_last_entry(&drv->p->klist_devices.k_list,
>>>                                       struct device_private,
>>>                                       knode_driver.n_node);
>>>                  dev = dev_prv->device;
> 
> metadata:
>    git branch: master
>    git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>    git describe: next-20200327
>    kernel-config:
> https://builds.tuxbuild.com/nqmmxorUbC1qTWp42iEKjQ/kernel.config
> 
> 
