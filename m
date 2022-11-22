Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A204634997
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 22:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiKVVpT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Nov 2022 16:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiKVVpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2022 16:45:17 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5A1FAC4
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 13:45:13 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id xb4oo3s4a8oPgxb4oo5u6P; Tue, 22 Nov 2022 22:45:11 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 22 Nov 2022 22:45:11 +0100
X-ME-IP: 86.243.100.34
Message-ID: <253d4aac-62af-15af-90e7-a3cd4bacba92@wanadoo.fr>
Date:   Tue, 22 Nov 2022 22:45:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] interconnect: qcom: icc-rpmh: Fix an error handling path
 in qcom_icc_rpmh_probe()
Content-Language: fr, en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <ec929c37c655ede7bb42e426354093c8a1377a0b.1668947686.git.christophe.jaillet@wanadoo.fr>
 <COHSZZ9A5570.1P4NTXRE9IRZR@otso>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <COHSZZ9A5570.1P4NTXRE9IRZR@otso>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le 21/11/2022 à 08:42, Luca Weiss a écrit :
> Hi Christophe,
> 
> On Sun Nov 20, 2022 at 1:35 PM CET, Christophe JAILLET wrote:
>> If of_platform_populate() fails, some resources need to be freed as already
>> done in the other error handling paths.
>>
>> Fixes: 57eb14779dfd ("interconnect: qcom: icc-rpmh: Support child NoC device probe")
> 
> I believe the same needs to be applied to icc-rpm.c.

Their are other issues in the error handling path of this file.

1)	if (desc->has_bus_pd) {
		ret = dev_pm_domain_attach(dev, true);
is unbalanced, both in the error handling path and in the remove function.


2)	clk_bulk_prepare_enable()
is not balanced in all error handling paths.


3) the same issue about error handling if of_platform_populate() fails.


These issues have been introduced in different commits.


Would you prefer several patches, each related to a given Fixes: tag, or 
one bigger "fix all error handling paths"?


Anyway, fixing the points above would require moving some code around. 
Usually I try to avoid it, because it is not always easy to see 
associated side effects.

CJ

> 
> Also there shouldn't be an empty line here between Fixes: and Signed-off-by:
> 
> Regards
> Luca
> 
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/interconnect/qcom/icc-rpmh.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
>> index fd17291c61eb..5168bbf3d92f 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.c
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -235,8 +235,11 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, qp);
>>   
>>   	/* Populate child NoC devices if any */
>> -	if (of_get_child_count(dev->of_node) > 0)
>> -		return of_platform_populate(dev->of_node, NULL, NULL, dev);
>> +	if (of_get_child_count(dev->of_node) > 0) {
>> +		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
>> +		if (ret)
>> +			goto err;
>> +	}
>>   
>>   	return 0;
>>   err:
>> -- 
>> 2.34.1
> 
> 

