Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE465A5D93
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 10:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiH3IBO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 04:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiH3IBI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 04:01:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86760C56;
        Tue, 30 Aug 2022 01:01:03 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MH05b0yHkz1N7cK;
        Tue, 30 Aug 2022 15:57:23 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 16:01:00 +0800
Message-ID: <954cdab4-62d3-b413-f615-9c7b1563c1b1@huawei.com>
Date:   Tue, 30 Aug 2022 16:01:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] cpufreq: bmips-cpufreq: Use module_init and add
 module_exit
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <mmayer@broadcom.com>, <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220826021845.2283648-1-chris.zjh@huawei.com>
 <20220830052922.aedexy7ovdus5pzk@vireshk-i7>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <20220830052922.aedexy7ovdus5pzk@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


在 2022/8/30 13:29, Viresh Kumar 写道:
> On 26-08-22, 10:18, Zhang Jianhua wrote:
>> - Use module_init instead of device_initcall.
>> - Add a function for module_exit to unregister driver.
>>
>> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
>> ---
>>   drivers/cpufreq/bmips-cpufreq.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
>> index f7c23fa468f0..21c0417c95e1 100644
>> --- a/drivers/cpufreq/bmips-cpufreq.c
>> +++ b/drivers/cpufreq/bmips-cpufreq.c
>> @@ -156,7 +156,7 @@ static struct cpufreq_driver bmips_cpufreq_driver = {
>>   	.name		= BMIPS_CPUFREQ_PREFIX,
>>   };
>>   
>> -static int __init bmips_cpufreq_probe(void)
>> +static int __init bmips_cpufreq_driver_init(void)
>>   {
>>   	struct cpufreq_compat *cc;
>>   	struct device_node *np;
>> @@ -176,7 +176,13 @@ static int __init bmips_cpufreq_probe(void)
>>   
>>   	return cpufreq_register_driver(&bmips_cpufreq_driver);
>>   }
>> -device_initcall(bmips_cpufreq_probe);
>> +module_init(bmips_cpufreq_driver_init);
>> +
>> +static void __exit bmips_cpufreq_driver_exit(void)
>> +{
>> +	cpufreq_unregister_driver(&bmips_cpufreq_driver);
>> +}
>> +module_exit(bmips_cpufreq_driver_exit)
> Semicolon ? Did you even compile this ? :)

Semicolon is not necessary for module_exit, and it can be compiled. I will send v2 patch to keep the format consistent, thanks.

>>   
>>   MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
>>   MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");
>> -- 
>> 2.31.0
