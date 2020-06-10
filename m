Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D021F5A3E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 19:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFJRYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 13:24:19 -0400
Received: from smtp1.axis.com ([195.60.68.17]:31654 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgFJRYS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jun 2020 13:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=6795; q=dns/txt; s=axis-central1;
  t=1591809856; x=1623345856;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QhfchX38xgAnXL6YkkqFVKRFP45193wWKkT36io4Fjs=;
  b=I4s/OOE0/8OVHIQe5IIRZoxfGYcFJtWJeBt7lCZS3aqfAVf57Ip23JgD
   BcpUjlEa9H0qiIRZCp7SaoocloPsbXJuwb+AFekTUjbUaBDYKIcpY/BdZ
   deMnPr406Cl05PpGpdkMbMPsOEq1pLRCKSqbR6Us/InUMAEVqtub+Dw0J
   EPBsEh+ZiuamJWIbscvCieHH06V74cjj+9+/5h7+7S4OP82wkZLVG0iSP
   hi/4OcvA8Y9lMQTjrrtw9Ef9eIexKwOyeqM6l3ZXPMYQle1/GDhXBIcwz
   dAkomgVEBtUJcxebX0C1omTk2ruSQE5FRg3wVHDhQOA540yUaaYih5jKU
   g==;
IronPort-SDR: 5rJ6PUyekyWCPGMNVGNAa2rob0bW6pvJAyR4Zm4YiKV7ADvyE0SNlYEqFknintvRbE+DHdDLNd
 PrFqq2jwYkIHNjUrgvlbtLnV7t/+8X5lcti4dMvK0xukaNDv3+jYdZzkY7PsGZ8k63E2lQmgT9
 xcRxuTKUKawQaDJOLjz8UAwHI2JmMXRGomIJSiai8WRqFhCZq7IU92W3idSDpsuKVMbS8xtpz2
 OCt99u7cHt5nwCPd6EF+KiPV9XJolBUvMeSjmz6+lq6q8WoB/oHsrCCNqnmS6zA2Lhu0nSQfCA
 ts0=
X-IronPort-AV: E=Sophos;i="5.73,496,1583190000"; 
   d="scan'208";a="9673221"
Subject: Re: [PATCH] PM / Domains: Add module ref count for each consumer
To:     Greg KH <gregkh@linuxfoundation.org>,
        Gustav Wiklander <Gustav.Wiklander@axis.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, kernel <kernel@axis.com>
References: <20200610143943.12548-1-gustav.wiklander@axis.com>
 <20200610145229.GA2101163@kroah.com>
From:   Gustav Wiklander <gustavwi@axis.com>
Message-ID: <a6f1fbad-b753-db30-bf95-c314e9eea508@axis.com>
Date:   Wed, 10 Jun 2020 19:24:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610145229.GA2101163@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX01.axis.com (10.0.5.15) To XBOX01.axis.com (10.0.5.15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/10/20 4:52 PM, Greg KH wrote:
> On Wed, Jun 10, 2020 at 04:39:43PM +0200, Gustav Wiklander wrote:
>> From: Gustav Wiklander <gustavwi@axis.com>
>> 
>> Currently a pm_domain can be unloaded without regard for consumers.
>> This patch adds a module dependecy for every registered consumer.
>> Now a power domain driver can only be unloaded if no consumers are
>> registered.
> 
> What is the problem with doing this?  Shouldn't when a power domain is
> unregistered, the consumers are properly torn down?  Some subsystems
> allow you to unload a module at any point in time, and properly clean
> things up.  What is the problem today that you are trying to solve with
> this (remember, removing modules only happens by developers, no
> real-world system ever automatically onloads a module.)
> 
> 
Hi Greg and Rafael,

Thanks for the quick reply.

PM domains shall call pm_genpd_remove at removal. As described in the 
definition pm_genpd_remove will fail if any device is still associated 
to it. *However*, at module removal the kernel ignores device removal 
failure and still unloads the powerdomain module.

I am currently working on a PM driver and a couple of PM consumers. For 
quick development I load and unload them.

If I unload the PM provider before the PM consumers the kernel will 
crash when unloading the PM consumer because callbacks trigger accesses
to struct generic_pm_domain *genpd which was allocated by the PM 
provider driver.

Secondly after unloading the PM domain the PM consumers are in an 
undefined state and could very well crash because they assume power is 
ON and do not handle unresponsive hardware.

Best regards
Gustav Wiklander


[  710.239233][  T267] Unable to handle kernel paging request at virtual 
address ffffff8000bb8048
[  710.239265][  T267] Mem abort info:
[  710.239291][  T267]   ESR = 0x86000007
[  710.239318][  T267]   Exception class = IABT (current EL), IL = 32 bits
[  710.239348][  T267]   SET = 0, FnV = 0
[  710.239375][  T267]   EA = 0, S1PTW = 0
[  710.239404][  T267] swapper pgtable: 4k pages, 39-bit VAs, pgdp = 
ffffff800915d000
[  710.239436][  T267] [ffffff8000bb8048] pgd=00000000bfffe003, 
pud=00000000bfffe003, pmd=0000000088d58003, pte=0000000000000000
[  710.239492][  T267] Internal error: Oops: 86000007 [#1] PREEMPT SMP
[  710.239515][  T267] Modules linked in: test_power_consumer(O-) [last 
unloaded: test_power_provider]
[  710.239571][  T267] Process rmmod (pid: 267, stack limit = 
0xffffffc008fcc000)
[  710.239600][  T267] CPU: 0 PID: 267 Comm: rmmod Kdump: loaded 
Tainted: G           O      4.19.110-axis8-devel #1
[  710.239629][  T267] Hardware name: AXIS Wombat Virtual Machine (DT)
[  710.239655][  T267] pstate: 60400005 (nZCv daif +PAN -UAO)
[  710.239678][  T267] pc : 0xffffff8000bb8048
[  710.239704][  T267] lr : genpd_power_on.part.0+0xd0/0x290
[  710.239726][  T267] sp : ffffffc008fcfb60
[  710.239747][  T267] x29: ffffffc008fcfb60 x28: ffffffc03fbce040
[  710.239776][  T267] x27: ffffffc0091eabb0 x26: ffffffc0091ea7b0
[  710.239804][  T267] x25: ffffffc0091ea880 x24: 0000000000000000
[  710.239832][  T267] x23: 000000a55d7d66d0 x22: ffffffc0091eaca8
[  710.239861][  T267] x21: ffffffc0091ea880 x20: ffffffc0091eac88
[  710.239889][  T267] x19: 0000000000000000 x18: 0000000000000000
[  710.239917][  T267] x17: 0000000000000000 x16: 0000000000000000
[  710.239945][  T267] x15: ffffffc03f8d1510 x14: ffffffc03f37bcb0
[  710.239973][  T267] x13: 0000000000000000 x12: 0000000000000025
[  710.240002][  T267] x11: ffffffc03f37bb60 x10: 0000000000000040
[  710.240030][  T267] x9 : ffffffc03f8d1510 x8 : 0000000000000001
[  710.240058][  T267] x7 : 0000000000000000 x6 : 0000000a56772fe6
[  710.240086][  T267] x5 : 00ffffffffffffff x4 : 0006dac2c0000000
[  710.240114][  T267] x3 : 0000000000000017 x2 : 0000000000001c1c
[  710.240142][  T267] x1 : ffffff8000bb8048 x0 : ffffffc0091ea880
[  710.240169][  T267] Call trace:
[  710.240190][  T267]  0xffffff8000bb8048
[  710.240216][  T267]  genpd_runtime_resume+0xc8/0x288
[  710.240242][  T267]  __rpm_callback+0xe4/0x230
[  710.240266][  T267]  rpm_callback+0x34/0x98
[  710.240291][  T267]  rpm_resume+0x5e0/0x7e8
[  710.240315][  T267]  __pm_runtime_resume+0x64/0xa8
[  710.240340][  T267]  device_release_driver_internal+0x158/0x238
[  710.240366][  T267]  driver_detach+0x8c/0xc8
[  710.240389][  T267]  bus_remove_driver+0x78/0xe0
[  710.240414][  T267]  driver_unregister+0x34/0x60
[  710.240439][  T267]  platform_driver_unregister+0x20/0x30
[  710.240467][  T267]  modexit+0x24/0xd14 [test_power_consumer]
[  710.240494][  T267]  __arm64_sys_delete_module+0x168/0x218


>> 
>> Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
>> ---
>>  drivers/base/power/domain.c | 11 ++++++++++-
>>  include/linux/pm_domain.h   |  2 ++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 0a01df608849..80723f6d5e6b 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1499,11 +1499,18 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>>        if (IS_ERR(gpd_data))
>>                return PTR_ERR(gpd_data);
>>  
>> +     if (!try_module_get(genpd->owner)) {
>> +             ret = -ENODEV;
>> +             goto out;
>> +     }
>> +
>>        gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
>>  
>>        ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
>> -     if (ret)
>> +     if (ret) {
>> +             module_put(genpd->owner);
>>                goto out;
>> +     }
>>  
>>        genpd_lock(genpd);
>>  
>> @@ -1579,6 +1586,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>>  
>>        genpd_free_dev_data(dev, gpd_data);
>>  
>> +     module_put(genpd->owner);
>> +
>>        return 0;
>>  
>>   out:
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 9ec78ee53652..777c1b30e5af 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -9,6 +9,7 @@
>>  #define _LINUX_PM_DOMAIN_H
>>  
>>  #include <linux/device.h>
>> +#include <linux/module.h>
>>  #include <linux/mutex.h>
>>  #include <linux/pm.h>
>>  #include <linux/err.h>
>> @@ -93,6 +94,7 @@ struct opp_table;
>>  
>>  struct generic_pm_domain {
>>        struct device dev;
>> +     struct module *owner;           /* Module owner of the PM domain */
> 
> But you did not actually set the owner field anywhere :(
> 
> Make this an automatic thing, look how functions like
> usb_register_driver() and friends to it so that you do not have to go
> around and try to add it by hand to every driver.  And then go back in a
> year and fix up the remaining ones you missed.  And then in another
> year...
> 
> thanks,
> 
> greg k-h

