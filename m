Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63D5510B5
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 08:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbiFTGuc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 02:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiFTGub (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 02:50:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD49F6323
        for <linux-pm@vger.kernel.org>; Sun, 19 Jun 2022 23:50:27 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LRKwg4m89z1K9Lj;
        Mon, 20 Jun 2022 14:48:19 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 14:50:23 +0800
CC:     <andriy.shevchenko@linux.intel.com>, <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] PM / devfreq: passive: use HZ_PER_KHZ macro in units.h
To:     Chanwoo Choi <cwchoi00@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>, <linux-pm@vger.kernel.org>
References: <20220610075428.62268-1-yangyicong@hisilicon.com>
 <1b38d764-109f-0ed4-bf71-b96a71471280@gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <b36fbf3e-44b2-1cd2-3383-62b9425f6062@huawei.com>
Date:   Mon, 20 Jun 2022 14:50:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1b38d764-109f-0ed4-bf71-b96a71471280@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2022/6/18 3:36, Chanwoo Choi wrote:
> On 22. 6. 10. 16:54, Yicong Yang wrote:
>> HZ macros has been centralized in units.h since [1]. Use it to avoid
>> duplicated definition.
>>
>> [1] commit e2c77032fcbe ("units: add the HZ macros")
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/devfreq/governor_passive.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>> index 72c67979ebe1..a2cf6c6a1a39 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -14,10 +14,9 @@
>>  #include <linux/slab.h>
>>  #include <linux/device.h>
>>  #include <linux/devfreq.h>
>> +#include <linux/units.h>
>>  #include "governor.h"
>>  
>> -#define HZ_PER_KHZ	1000
>> -
>>  static struct devfreq_cpu_data *
>>  get_parent_cpu_data(struct devfreq_passive_data *p_data,
>>  		    struct cpufreq_policy *policy)
> 
> Thanks for the fixup. Just use capital letter for first character
> of patch title as following: 
> - PM / devfreq: passive: Use HZ_PER_KHZ macro in units.h
> 

Thanks! I checked `git log --oneline drivers/devfreq/governor_passive.c`
but might typed it wrong.. will take care.
