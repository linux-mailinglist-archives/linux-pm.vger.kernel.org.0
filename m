Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6BB1D8D6D
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgESB7j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 21:59:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgESB7j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 21:59:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B68D4676A0D867A67E0;
        Tue, 19 May 2020 09:59:37 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 09:59:33 +0800
Subject: Re: [RFC v2 PATCH 1/6] cpuidle: sysfs: Fix the overlap for showing
 available governors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
 <1588235987-12300-2-git-send-email-guohanjun@huawei.com>
 <3161e9ec-1bdc-bb51-ec6f-b3c7e2f6e907@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c837cf0a-cdac-707f-4763-008309047b59@huawei.com>
Date:   Tue, 19 May 2020 09:59:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3161e9ec-1bdc-bb51-ec6f-b3c7e2f6e907@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/5/18 22:20, Daniel Lezcano wrote:
> On 30/04/2020 10:39, Hanjun Guo wrote:
>> When showing the available governors, it's "%s " in scnprintf(),
>> not "%s", so if the governor name has 15 characters, it will
>> overlap with the later one, fix it by adding one more for the
>> size.
>>
>> While we are at it, fix the minor coding sytle as well.

I got a typo here, s/sytle/style...

>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>   drivers/cpuidle/sysfs.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
>> index d3ef1d7..3485210 100644
>> --- a/drivers/cpuidle/sysfs.c
>> +++ b/drivers/cpuidle/sysfs.c
>> @@ -35,10 +35,10 @@ static ssize_t show_available_governors(struct device *dev,
>>   
>>   	mutex_lock(&cpuidle_lock);
>>   	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
>> -		if (i >= (ssize_t) ((PAGE_SIZE/sizeof(char)) -
>> +		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char)) -
> 
> Is is possible to have a sizeof(char) != 1 ?

Not from my knowledge, I even didn't notice it, I'd happy to
update this patch set to remove the sizeof(char), and adding
ack and review/test tags from you and Doug.

Thanks
Hanjun

