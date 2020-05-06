Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357581C6538
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 02:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEFAwZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 20:52:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728356AbgEFAwY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 May 2020 20:52:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5D39615143F7A3B9D882;
        Wed,  6 May 2020 08:52:18 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.180) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 08:52:15 +0800
Subject: Re: [PATCH -next] cpupower: Remove unneeded semicolon
To:     shuah <shuah@kernel.org>, <trenn@suse.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1588066995-71840-1-git-send-email-zou_wei@huawei.com>
 <a51e2f2b-3381-bd5d-9599-0f291520b272@kernel.org>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <1d1333ae-6d7f-a456-567b-34852270000b@huawei.com>
Date:   Wed, 6 May 2020 08:52:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a51e2f2b-3381-bd5d-9599-0f291520b272@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.212.180]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shuah,

I run with the below command, and get the output report.

[local-host linux-next]# make coccicheck MODE=report 
M=tools/power/cpupower/utils

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:175:2-3: 
Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:56:2-3: Unneeded 
semicolon
tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:75:2-3: Unneeded 
semicolon
tools/power/cpupower/utils/idle_monitor/snb_idle.c:80:2-3: Unneeded 
semicolon
tools/power/cpupower/utils/cpupower-set.c:75:2-3: Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c:82:2-3: Unneeded 
semicolon
tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c:120:2-3: 
Unneeded semicolon
tools/power/cpupower/utils/idle_monitor/nhm_idle.c:94:2-3: Unneeded 
semicolon
tools/power/cpupower/utils/cpupower-info.c:65:2-3: Unneeded semicolon

On 2020/5/2 1:07, shuah wrote:
> Hi Zou Wei,
> 
> On 4/28/20 3:43 AM, Zou Wei wrote:
>> Fixes coccicheck warnings:
> 
> I am not finding these in my coccicheck run. Can you send me the options
> you are using?
> 
>>
>> tools/power/cpupower/utils/cpupower-info.c:65:2-3: Unneeded semicolon
>> tools/power/cpupower/utils/cpupower-set.c:75:2-3: Unneeded semicolon
>> tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c:120:2-3: 
>> Unneeded semicolon
>> tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:175:2-3: 
>> Unneeded semicolon
>> tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:56:2-3: 
>> Unneeded semicolon
>> tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:75:2-3: 
>> Unneeded semicolon
>> tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c:82:2-3: 
>> Unneeded semicolon
>> tools/power/cpupower/utils/idle_monitor/nhm_idle.c:94:2-3: Unneeded 
>> semicolon
>> tools/power/cpupower/utils/idle_monitor/snb_idle.c:80:2-3: Unneeded 
>> semicolon
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>> ---
>>   tools/power/cpupower/utils/cpupower-info.c                | 2 +-
>>   tools/power/cpupower/utils/cpupower-set.c                 | 2 +-
>>   tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c | 2 +-
>>   tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c   | 6 +++---
>>   tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c    | 2 +-
>>   tools/power/cpupower/utils/idle_monitor/nhm_idle.c        | 2 +-
>>   tools/power/cpupower/utils/idle_monitor/snb_idle.c        | 2 +-
>>   7 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/power/cpupower/utils/cpupower-info.c 
>> b/tools/power/cpupower/utils/cpupower-info.c
>> index d3755ea..0ba61a2 100644
>> --- a/tools/power/cpupower/utils/cpupower-info.c
>> +++ b/tools/power/cpupower/utils/cpupower-info.c
>> @@ -62,7 +62,7 @@ int cmd_info(int argc, char **argv)
>>           default:
>>               print_wrong_arg_exit();
>>           }
>> -    };
>> +    }
> 
> The patch itself is fine.
> 
> thanks,
> -- Shuah
> 
> .

