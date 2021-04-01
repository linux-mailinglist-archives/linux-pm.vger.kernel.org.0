Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F8351E9B
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhDASoA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:44:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:63637 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239714AbhDASfo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 14:35:44 -0400
IronPort-SDR: ScP/eBa6io6Voj4bLvRaC3r0mVKp40YkJNIbJE7e+PMIhabI3mTNGZcnUFl7TstjhUWkCTuymw
 WJlaLKVwvVoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="277437470"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="277437470"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:13:20 -0700
IronPort-SDR: xEYD6l9IQmNGjYdKlOnUnpJ2zfYoO9IV0lxv2unD/ieccwFS8iTc2CxV4JGf05ieOF985KENll
 ibIGOmQN5xlw==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="610936606"
Received: from ybai4-mobl.amr.corp.intel.com (HELO [10.255.229.23]) ([10.255.229.23])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:13:19 -0700
Subject: Re: [PATCH 3/7] PM: runtime: remove kernel-doc warnings
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
 <20210331232614.304591-4-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0jS0Wfzq0M45ZbP2vNX4y=e+tvZjrmn4AiE+ycxij+CWg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <579db6b4-d6ed-2dcb-b633-fe7fb94cb3c9@linux.intel.com>
Date:   Thu, 1 Apr 2021 09:13:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jS0Wfzq0M45ZbP2vNX4y=e+tvZjrmn4AiE+ycxij+CWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/1/21 8:40 AM, Rafael J. Wysocki wrote:
> On Thu, Apr 1, 2021 at 1:26 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> remove make W=1 warnings
>>
>> drivers/base/power/runtime.c:926: warning: Function parameter or
>> member 'timer' not described in 'pm_suspend_timer_fn'
>>
>> drivers/base/power/runtime.c:926: warning: Excess function parameter
>> 'data' description in 'pm_suspend_timer_fn'
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/base/power/runtime.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index fe1dad68aee4..1fc1a992f90c 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -951,7 +951,7 @@ static void pm_runtime_work(struct work_struct *work)
>>
>>   /**
>>    * pm_suspend_timer_fn - Timer function for pm_schedule_suspend().
>> - * @data: Device pointer passed by pm_schedule_suspend().
>> + * @timer: hrtimer used by pm_schedule_suspend().
>>    *
>>    * Check if the time is right and queue a suspend request.
>>    */
>> --
> 
> I can apply this along with the [4-5/7].  Do you want me to do that?

Works for me. I wasn't sure by looking at the MAINTAINERS file which 
files in drivers/base/ are maintained by whom, so sent the patches as a 
single set.
