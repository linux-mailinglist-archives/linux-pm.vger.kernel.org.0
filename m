Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C107368BBFE
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 12:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBFLsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 06:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjBFLrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 06:47:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679522DDE
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 03:47:43 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P9PZz671cznW2Q;
        Mon,  6 Feb 2023 19:45:31 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 19:47:41 +0800
Subject: Re: [PATCH -next] power: supply: rt9471: fix using wrong ce_gpio in
 rt9471_probe()
To:     ChiYuan Huang <u0084500@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <sre@kernel.org>,
        <alina_yu@richtek.com>, <cy_huang@richtek.com>
References: <20230206082025.1992331-1-yangyingliang@huawei.com>
 <20230206091329.GA30724@cyhuang-hp-elitebook-840-g3.rt>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <97bce9a7-581b-4980-0df6-26c2cb6afa86@huawei.com>
Date:   Mon, 6 Feb 2023 19:47:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230206091329.GA30724@cyhuang-hp-elitebook-840-g3.rt>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2023/2/6 17:13, ChiYuan Huang wrote:
> Due to the Richtek email rule, YingLiang's mailbox could be blocked.
> Resend by my personal gmail.
>
> Hi, YingLiang:
>
> Many thanks for the fix.
>
> My original thought is to remove ce_gpio in chip data and make it
> all by SW control only, not to control by HW pin.
>
> Could you help to send v2 patch to remove 'ce_gpio' in chip data?
> And for the macro IS_ERR(chip->ce_gpio), just change to IS_ERR(ce_gpio).
Did you mean to change the code like this:

diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index 5d3cf375ad5c..1ea40876494b 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -141,7 +141,6 @@ enum {

  struct rt9471_chip {
         struct device *dev;
-       struct gpio_desc *ce_gpio;
         struct regmap *regmap;
         struct regmap_field *rm_fields[F_MAX_FIELDS];
         struct regmap_irq_chip_data *irq_chip_data;
@@ -851,7 +850,7 @@ static int rt9471_probe(struct i2c_client *i2c)

         /* Default pull charge enable gpio to make 'CHG_EN' by SW 
control only */
         ce_gpio = devm_gpiod_get_optional(dev, "charge-enable", 
GPIOD_OUT_HIGH);
-       if (IS_ERR(chip->ce_gpio))
+       if (IS_ERR(ce_gpio))
                 return dev_err_probe(dev, PTR_ERR(ce_gpio),
                                      "Failed to config charge enable 
gpio\n");

Thanks,
Yang
>
> In patch v2, you can add my Reviewed-by tag.
> Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>
>
> On Mon, Feb 06, 2023 at 04:20:25PM +0800, Yang Yingliang wrote:
>> Pass the correct 'ce_gpio' to IS_ERR(), and assign it to
>> the 'chip->ce_gpio', if devm_gpiod_get_optional() succeed.
>>
>> Fixes: 4a1a5f6781d8 ("power: supply: rt9471: Add Richtek RT9471 charger driver")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/power/supply/rt9471.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
>> index 5d3cf375ad5c..de0bf484d313 100644
>> --- a/drivers/power/supply/rt9471.c
>> +++ b/drivers/power/supply/rt9471.c
>> @@ -851,10 +851,12 @@ static int rt9471_probe(struct i2c_client *i2c)
>>   
>>   	/* Default pull charge enable gpio to make 'CHG_EN' by SW control only */
>>   	ce_gpio = devm_gpiod_get_optional(dev, "charge-enable", GPIOD_OUT_HIGH);
>> -	if (IS_ERR(chip->ce_gpio))
>> +	if (IS_ERR(ce_gpio))
>>   		return dev_err_probe(dev, PTR_ERR(ce_gpio),
>>   				     "Failed to config charge enable gpio\n");
>>   
>> +	chip->ce_gpio = ce_gpio;
>> +
>>   	regmap = devm_regmap_init_i2c(i2c, &rt9471_regmap_config);
>>   	if (IS_ERR(regmap))
>>   		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
>> -- 
>> 2.25.1
>>
> .
