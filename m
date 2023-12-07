Return-Path: <linux-pm+bounces-782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C3480840F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 10:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07F41C21BF4
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016432C65;
	Thu,  7 Dec 2023 09:16:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 280971AD;
	Thu,  7 Dec 2023 01:16:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B38012FC;
	Thu,  7 Dec 2023 01:17:07 -0800 (PST)
Received: from [10.57.6.119] (unknown [10.57.6.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 876463F6C4;
	Thu,  7 Dec 2023 01:16:19 -0800 (PST)
Message-ID: <ff5605ae-590d-44c9-a428-2f9adf65cb92@arm.com>
Date: Thu, 7 Dec 2023 09:17:20 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] thermal/debugfs: Add thermal debugfs information
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, rui.zhang@intel.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20231110181123.2389186-1-daniel.lezcano@linaro.org>
 <CAJZ5v0h8CTbDrq1wUOMpKpnKs6Ey7H1onkfKGRS15Gj_AnepAg@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0h8CTbDrq1wUOMpKpnKs6Ey7H1onkfKGRS15Gj_AnepAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/6/23 21:43, Rafael J. Wysocki wrote:
> On Fri, Nov 10, 2023 at 8:37 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>

[snip]

>> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
>> index 0a3b3ec5120b..809d37d0aa28 100644
>> --- a/drivers/thermal/thermal_core.h
>> +++ b/drivers/thermal/thermal_core.h
>> @@ -13,6 +13,7 @@
>>   #include <linux/thermal.h>
>>
>>   #include "thermal_netlink.h"
>> +#include "thermal_debugfs.h"
>>
>>   /* Default Thermal Governor */
>>   #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> 
> The change below is large and rather hard to grasp as a whole.
> 
> It would be easier to process if it is split into a few smaller
> changes building on top of each other IMO.
> 
> Personally, I would start with stubs of the functions that are called
> from the core and subsequently add more and more code to them.

I agree, for this approach for this patch. Also we implicitly agreed
that this CONFIG_THERMAL_DEBUG can fly upstream. What would be built
on top in the framework and in governors, could be developed in steps,
IMO.

Thanks for starting this debugfs support.

