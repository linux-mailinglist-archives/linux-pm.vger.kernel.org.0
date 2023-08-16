Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5528277DB1A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbjHPH1n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 03:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjHPH12 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 03:27:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E0C1;
        Wed, 16 Aug 2023 00:27:25 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQfkn5RDNztS1S;
        Wed, 16 Aug 2023 15:23:45 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 15:27:21 +0800
Message-ID: <8fea501c-b950-17bd-c710-c923b9af6e62@huawei.com>
Date:   Wed, 16 Aug 2023 15:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] cpufreq: cppc: Add missing error pointer check
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230816030549.849824-1-liaochang1@huawei.com>
 <20230816034630.a4hvsj373q6aslk3@vireshk-i7>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20230816034630.a4hvsj373q6aslk3@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

在 2023/8/16 11:46, Viresh Kumar 写道:
> On 16-08-23, 03:05, Liao Chang wrote:
>> The function cppc_freq_invariance_init() may failed to create
>> kworker_fie, make it more robust by checking the return value to prevent
>> an invalid pointer dereference in kthread_destroy_worker(), which called
>> from cppc_freq_invariance_exit().
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> I think why it was designed this way was to make the driver work,
> without invariance support, in the worst case instead of just failing
> completely. The invariance thing is a good to have feature, but not
> really necessary and so failing probing the driver for that isn't
> worth it. We should print all error messages though.
> 
Thanks for pointing that out. I think you are right that the kworker created
in the cppc driver is not the only arch_freq_scale updater, the ARCH provided
updater has more priority than the driver, so the driver should still work even
without kworker_fie supports.

If that is the case, i think the best thing to do is checking the error pointer
and printing an error message before calling kthread_destroy() in cppc_freq_invariance_exit(),
this is because at that point, it is really necessary to ensure the kworker_fie has
been initialized as expected, otherwise it will raise a NULL pointer exception.

I hope this makes sense, thanks.

-- 
BR
Liao, Chang
