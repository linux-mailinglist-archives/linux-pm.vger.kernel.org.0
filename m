Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8311C8BBB
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 15:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGNE6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 09:04:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbgEGNE5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 09:04:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 59812306F6222C6274D5;
        Thu,  7 May 2020 21:04:52 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 21:04:44 +0800
Subject: Re: [RFC PATCH] cpufreq: add support for HiSilicon SoC HIP09
To:     Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
CC:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <1588227599-46438-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200430095559.GB28579@bogus>
 <3ba950dd-4065-e4a5-d406-dc5c6c1781a7@huawei.com>
 <20200506124932.GA20426@bogus> <028166CD-55C8-4FC6-AEBB-C190D20290D5@arm.com>
 <DBBPR08MB4790CF20D2CA65BC314C937882A40@DBBPR08MB4790.eurprd08.prod.outlook.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e94f4d3e-a420-c27a-b70f-8029e2113f3c@huawei.com>
Date:   Thu, 7 May 2020 21:04:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DBBPR08MB4790CF20D2CA65BC314C937882A40@DBBPR08MB4790.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thanu, Souvik, Sudeep,

Thanks a lot for the prompt reply, and it clarify a lot for
us, comment inline below.

On 2020/5/6 22:57, Souvik Chakravarty wrote:
> Hi,
> 
>> From: Thanu Rangarajan <Thanu.Rangarajan@arm.com>
>> Sent: Wednesday, May 6, 2020 1:58 PM
>>
>> Hi,
>> ACPI CPPC already supports the notion of boost. Not sure we need any
>> enhancements there.
>>
>> Regards,
>> Thanu
>>
>> ﻿On 06/05/2020, 18:19, "Sudeep Holla" <sudeep.holla@arm.com> wrote:
>>
>>      + Thanu, Souvik who work with ASWG
>>
>>      On Wed, May 06, 2020 at 05:36:51PM +0800, Hanjun Guo wrote:
>>      > Hi Sudeep,
>>      >
>>      > On 2020/4/30 17:55, Sudeep Holla wrote:
>>      > > On Thu, Apr 30, 2020 at 02:19:59PM +0800, Xiongfeng Wang wrote:
>>      > > > HiSilicon SoC has a separate System Control Processor(SCP)
>> dedicated for
>>      > > > clock frequency adjustment and has been using the cpufreq driver
>>      > > > 'cppc-cpufreq'. New HiSilicon SoC HIP09 add support for CPU Boost,
>> but
>>      > > > ACPI CPPC doesn't support this. In HiSilicon SoC HIP09, each core has
>>      > > > its own clock domain. It is better for the core itself to adjust its
>>      > > > frequency when we require fast response. In this patch, we add a
>>      > > > separate cpufreq driver for HiSilicon SoC HIP09.
>>      > > >
>>      > >
>>      > > I disagree with this approach unless you have tried to extend the CPPC
>>      > > in ACPI to accommodate this boost feature you need. Until you show
>> those
>>      > > efforts and disagreement to do that from ASWG, I am NACKing this
>> approach.
>>      >
>>      > Unfortunately we are not in ASWG at now, could you please give some
>>      > help about extending CPPC in ACPI to support boost feature?
>>      >
>>
>>      You may have to provide more details than the commit log for sure as I
>>      haven't understood the boost feature and what is missing in ACPI CPPC.
> 
> I would agree with Thanu here regarding the ACPI spec part - everything is already there.

I take another detail read of the spec and as you said,
everything is already there,thanks!. I was misleading by the
CPPC code which it's using the 'Highest Performance' as
the max performance not the 'Nominal Performance', so seems
that 'Highest Performance' is the normal max performance but
not the boost performance.

> 
> It seems to me that the .set_boost is today not handled in cppc_cpufreq.c. In fact if a platform provides a value for Highest Performance which is different than Nominal Performance, then the entire range of performance is always requested, which works well for platforms which do boost enable/disable selection at hardware/firmware level.

Yes, so for now, the CPPC code will enable the boost feature in
default if the firmware provides a value for Highest Performance
which is different than Nominal Performance.

> 
> .boost hook could potentially be useful in cppc_cpufreq.c for platforms which would manage the boost selection in software. But it would be good to keep a common implementation which can choose between "software-triggered or auto-boost" selection for different platforms.

Thanks for the clarify, it helps a lot, Xiongfeng prepared
some patches to enable .boost hook, but needs to set the
'Nominal Performance' as the max performance, and
'Highest Performance' is the max boost performance, will
send out for comments.

Best Regards,
Hanjun

