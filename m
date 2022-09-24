Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F111A5E86E6
	for <lists+linux-pm@lfdr.de>; Sat, 24 Sep 2022 03:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiIXBDj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Sep 2022 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiIXBD3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2022 21:03:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790AF124C15;
        Fri, 23 Sep 2022 18:03:27 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZ9dp3KhhzWgp2;
        Sat, 24 Sep 2022 08:59:26 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 09:03:25 +0800
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemm600008.china.huawei.com (7.193.23.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 09:03:25 +0800
Message-ID: <6427434e-9740-c329-5efc-86d800d57c1e@huawei.com>
Date:   Sat, 24 Sep 2022 09:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH -next] interconnect: qcom: icc-rpm: Remove redundant
 dev_err call
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20220923100529.17107-1-shangxiaojing@huawei.com>
 <984929bf-8dfd-d6d4-2e23-f7d9a1f87a18@linaro.org>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <984929bf-8dfd-d6d4-2e23-f7d9a1f87a18@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2022/9/24 3:20, Krzysztof Kozlowski wrote:
> On 23/09/2022 12:05, Shang XiaoJing wrote:
>> devm_ioremap_resource() prints error message in itself. Remove the
>> dev_err call to avoid redundant error message.
>>
>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 39e43b957599..b808805557f1 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -478,10 +478,8 @@ int qnoc_probe(struct platform_device *pdev)
>>   
>>   		mmio = devm_ioremap_resource(dev, res);
>>   
> Drop this empty line as well, please.

thanks for the review, will fix in v2.


Thanks,

Shang XiaoJing

