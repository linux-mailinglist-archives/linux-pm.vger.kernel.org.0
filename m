Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8979110DD
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 03:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEBBY3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 21:24:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:37876 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfEBBY2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 21:24:28 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190502012424epoutp035048c2ec1ff5eab1669b483939234fd2~auTZrrKBt0203302033epoutp03s
        for <linux-pm@vger.kernel.org>; Thu,  2 May 2019 01:24:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190502012424epoutp035048c2ec1ff5eab1669b483939234fd2~auTZrrKBt0203302033epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556760264;
        bh=6nfIGdA6w7n42K9IIXPtNX56DF/R5vBrEnaJftPPfiM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UtS647wJjDHweeVpH58e9DZlRuqO3BC9+lJ6wiYCHVYDs4YrW4Jw4kPsQ6KD6yq1B
         dX1WV1gJ/q0PebCZ5tYYfR3m7wWsyMxCwesdKsisratBeTtil2+/45OPjF5UU4uDUM
         CETTmfJvfiPXG5fWkiXOBEViBgnmVbKMW4HoirxA=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190502012422epcas1p1c2b04b47b751d3cc6125a8024d266b89~auTXXhhWD2253222532epcas1p1G;
        Thu,  2 May 2019 01:24:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.9D.04143.3C64ACC5; Thu,  2 May 2019 10:24:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190502012418epcas1p33373b35f6cee3a1485b63176f87f3deb~auTT5ZCa70846908469epcas1p3e;
        Thu,  2 May 2019 01:24:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190502012418epsmtrp19b80e8d941c7acc35a5863b4e2b58119~auTT4B03P1006910069epsmtrp1b;
        Thu,  2 May 2019 01:24:18 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-51-5cca46c3333b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.F1.03662.2C64ACC5; Thu,  2 May 2019 10:24:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190502012418epsmtip129f04d09e011152d960fe02d7863fa99~auTTpaaXa0879608796epsmtip1b;
        Thu,  2 May 2019 01:24:18 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] drivers: devfreq: events: extend events by type
 of counted data
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <be9dfa71-b6fd-ebe3-e8be-a7ea28765225@samsung.com>
Date:   Thu, 2 May 2019 10:25:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <adb6e86a-880e-f9b7-76b2-777a531895d2@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmvu5ht1MxBlMXK1psnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlaLbyceMToIeKyZt4bRY+esu+wem1Z1snlsXlLvcfDdHiaPvi2rGD0+
        b5ILYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB
        ul1JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBk
        ClSYkJ2x4Pdi1oJzDhUbFlxhbGDs1e9i5OSQEDCRuHbgOksXIxeHkMAORolJfw6wQjifGCVu
        zO1nhnC+MUqcOb6UEablQv8dJhBbSGAvo8SDYzYQRe8ZJd7ceA+WEBaIlbg1YRrYKBGBs0BF
        TdvYQBxmgc+MEicfXGMFqWIT0JLY/+IGG4jNL6AocfXHY7AVvAJ2Er/WfmMHsVkEVCRuvNwE
        Vi8qECFx/9gGVogaQYmTM5+wgNicAu4Se/fsBJvDLCAucevJfCYIW16ieetssB8kBI6xS1z9
        fw1oAQeQ4yLRddkT4h1hiVfHt7BD2FISL/vboOxqiZUnj7BB9HYwSmzZf4EVImEssX/pZCaQ
        OcwCmhLrd+lD7OKTePe1hxViPK9ER5sQRLWyxOUHd5kgbEmJxe2dbBC2h8Ss00uYJjAqzkLy
        zSwkH8xC8sEshGULGFlWMYqlFhTnpqcWGxYYI0f3JkZwwtYy38G44ZzPIUYBDkYlHt4fU0/G
        CLEmlhVX5h5ilOBgVhLhvbUHKMSbklhZlVqUH19UmpNafIjRFBjYE5mlRJPzgdkkryTe0NTI
        2NjYwsTQzNTQUEmcd72Dc4yQQHpiSWp2ampBahFMHxMHp1QDo8q9v4vM88/6C/WVi05YKz1H
        7VZz1fz9TYkXM1b+7fd8P8Vw4z8Or9hzjta1EtPe3Pr4UslM71QvJ+uby22Pv35IVXmf4nz0
        nMQlnqrT+s9n6qSnqVheS962QUh848T2w7c9a376XJATf7D8u2G7gt4W9+jgXRskbERbVzSW
        2s/z/x3QwKoepMRSnJFoqMVcVJwIAB9M4mbuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSnO4ht1MxBq/WC1lsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlaLbyceMToIeKyZt4bRY+esu+wem1Z1snlsXlLvcfDdHiaPvi2rGD0+
        b5ILYI/isklJzcksSy3St0vgyljwezFrwTmHig0LrjA2MPbqdzFyckgImEhc6L/D1MXIxSEk
        sJtRYsblA4wQCUmJaRePMncxcgDZwhKHDxdD1LxllPh2cCMzSI2wQKzE/MX7GEESIgJnGSUW
        TVrADuIwC3xmlJi+5jIzRMtFJol762aygrSwCWhJ7H9xgw3E5hdQlLj64zHYOl4BO4lfa7+x
        g9gsAioSN15uAqsXFYiQOPN+BQtEjaDEyZlPwGxOAXeJvXt2gs1hFlCX+DPvEjOELS5x68l8
        JghbXqJ562zmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl
        5+duYgRHr5bWDsYTJ+IPMQpwMCrx8P6YejJGiDWxrLgy9xCjBAezkgjvrT1AId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYwrftcuWZGnxPfWcc7Hv5uU
        9yQ/rrika/m2w2rigbIpTWKhRde0JPveP9K7m6N1NUv1AJ+2wqUauUTlgEfv+bSlNfp8HonP
        ++7qfuTX+tMzHgbm/hMpmHxvzoKnx1sepatOaFU0Ez60Z26R5/RnwRu9Tj1t/ORTc9j/5Osl
        8yRDThRrXJPoPM6sxFKckWioxVxUnAgAPm5M9toCAAA=
X-CMS-MailID: 20190502012418epcas1p33373b35f6cee3a1485b63176f87f3deb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0@eucas1p2.samsung.com>
        <1555681688-19643-3-git-send-email-l.luba@partner.samsung.com>
        <3557d507-0463-89de-4025-fbeaaef78bed@samsung.com>
        <adb6e86a-880e-f9b7-76b2-777a531895d2@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 5. 1. 오전 6:19, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 4/30/19 9:34 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
>>> This patch adds posibility to choose what type of data should be counted
>>> by the PPMU counter. Now the type comes from DT where the event has been
>>> defined. When there is no 'event-data-type' the default value is used,
>>> which is 'read data in bytes'.
>>> It is needed when you want to know not only read+write data bytes but
>>> i.e. only write data in byte, or number of read requests, etc.
>>>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   drivers/devfreq/event/exynos-ppmu.c | 61 +++++++++++++++++++++++++------------
>>>   include/linux/devfreq-event.h       |  6 ++++
>>>   2 files changed, 48 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>>> index c61de0b..073bf2c 100644
>>> --- a/drivers/devfreq/event/exynos-ppmu.c
>>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>>> @@ -154,9 +154,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>>>   	if (ret < 0)
>>>   		return ret;
>>>   
>>> -	/* Set the event of Read/Write data count  */
>>> +	/* Set the event of proper data type monitoring */
>>>   	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
>>> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
>>> +			   edev->desc->data_type);
>>>   	if (ret < 0)
>>>   		return ret;
>>>   
>>> @@ -368,23 +368,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>>   	if (ret < 0)
>>>   		return ret;
>>>   
>>> -	/* Set the event of Read/Write data count  */
>>> -	switch (id) {
>>> -	case PPMU_PMNCNT0:
>>> -	case PPMU_PMNCNT1:
>>> -	case PPMU_PMNCNT2:
>>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>>> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
>>> -		if (ret < 0)
>>> -			return ret;
>>> -		break;
>>> -	case PPMU_PMNCNT3:
>>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>>> -				PPMU_V2_EVT3_RW_DATA_CNT);
>>> -		if (ret < 0)
>>> -			return ret;
>>> -		break;
>>> -	}
>>> +	/* Set the event of proper data type monitoring */
>>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>>> +			   edev->desc->data_type);
>>> +	if (ret < 0)
>>> +		return ret;
>>>   
>>>   	/* Reset cycle counter/performance counter and enable PPMU */
>>>   	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>>> @@ -508,6 +496,7 @@ static int of_get_devfreq_events(struct device_node *np,
>>>   	struct device *dev = info->dev;
>>>   	struct device_node *events_np, *node;
>>>   	int i, j, count;
>>> +	int ret;
>>>   
>>>   	events_np = of_get_child_by_name(np, "events");
>>>   	if (!events_np) {
>>> @@ -544,6 +533,40 @@ static int of_get_devfreq_events(struct device_node *np,
>>>   		desc[j].driver_data = info;
>>>   
>>>   		of_property_read_string(node, "event-name", &desc[j].name);
>>> +		ret = of_property_read_u32(node, "event-data-type",
>>> +					   &desc[j].data_type);
>>> +		if (ret) {
>>> +			/* Set the event of proper data type counting.
>>> +			 * Check if the data type has been defined in DT,
>>> +			 * use default if not.
>>> +			 */
>>> +			if (of_device_is_compatible(np,
>>> +					"samsung,exynos-ppmu-v2")) {
>>
>> It is not proper to compare the compatible string again
>> in the device driver. Instead, you can define the ppmu device type
>> as following and then use 'struct of_device_id' in order to
>> identify the device type.
> I have been thinking about modifying the code in similar fashion as you
> did. Good to see similar approach. I'll take your changes with a small
> additional code, which sets the 'info->ppmu_type' before the for
> loop, as an additional patch. Would it be OK if I add you as an author
> and add Sign-off-by: Chanwoo Choi <cw00.choi@samsung.com>?

If you agree, just add the my signed-off-by on second line.

> 
> Regards,
> Lukasz
>>
>> 	enum exynos_ppmu_type {
>> 		EXYNOS_TYPE_PPMU,
>> 		EXYNOS_TYPE_PPMU_V2,
>> 	};
>>
>>   static const struct of_device_id exynos_ppmu_id_match[] = {
>>          {
>>                  .compatible = "samsung,exynos-ppmu",
>> -               .data = (void *)&exynos_ppmu_ops,
>> +               .data = (void *)EXYNOS_TYPE_PPMU,
>>          }, {
>>                  .compatible = "samsung,exynos-ppmu-v2",
>> -               .data = (void *)&exynos_ppmu_v2_ops,
>> +               .data = (void *)EXYNOS_TYPE_PPMU_V2,
>>          },
>>
>>
>> The many device drivers in the mainline uses this code
>> in order to get the device type. You can refer the example
>> in the drivers/mfd/max14577.c.
>>
>> (snip)
>>
>>
>> Example, I add the example. but it is not tested.
>>
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of_address.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>>   #include <linux/suspend.h>
>> @@ -23,6 +24,11 @@
>>   
>>   #include "exynos-ppmu.h"
>>   
>> +enum exynos_ppmu_type {
>> +       EXYNOS_TYPE_PPMU,
>> +       EXYNOS_TYPE_PPMU_V2,
>> +};
>> +
>>   struct exynos_ppmu_data {
>>          struct clk *clk;
>>   };
>> @@ -36,6 +42,7 @@ struct exynos_ppmu {
>>          struct regmap *regmap;
>>   
>>          struct exynos_ppmu_data ppmu;
>> +       enum exynos_ppmu_type ppmu_type;
>>   };
>>   
>>   #define PPMU_EVENT(name)                       \
>>   
>>          /* Reset cycle counter/performance counter and enable PPMU */
>>          ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>> @@ -483,31 +476,23 @@ static const struct devfreq_event_ops exynos_ppmu_v2_ops = {
>>   static const struct of_device_id exynos_ppmu_id_match[] = {
>>          {
>>                  .compatible = "samsung,exynos-ppmu",
>> -               .data = (void *)&exynos_ppmu_ops,
>> +               .data = (void *)EXYNOS_TYPE_PPMU,
>>          }, {
>>                  .compatible = "samsung,exynos-ppmu-v2",
>> -               .data = (void *)&exynos_ppmu_v2_ops,
>> +               .data = (void *)EXYNOS_TYPE_PPMU_V2,
>>          },
>>          { /* sentinel */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, exynos_ppmu_id_match);
>>   
>> -static struct devfreq_event_ops *exynos_bus_get_ops(struct device_node *np)
>> -{
>> -       const struct of_device_id *match;
>> -
>> -       match = of_match_node(exynos_ppmu_id_match, np);
>> -       return (struct devfreq_event_ops *)match->data;
>> -}
>> -
>>   static int of_get_devfreq_events(struct device_node *np,
>>                                   struct exynos_ppmu *info)
>>   {
>>          struct devfreq_event_desc *desc;
>> -       struct devfreq_event_ops *event_ops;
>>          struct device *dev = info->dev;
>>          struct device_node *events_np, *node;
>>          int i, j, count;
>>   
>>          events_np = of_get_child_by_name(np, "events");
>>          if (!events_np) {
>> @@ -515,7 +500,6 @@ static int of_get_devfreq_events(struct device_node *np,
>>                          "failed to get child node of devfreq-event devices\n");
>>                  return -EINVAL;
>>          }
>> -       event_ops = exynos_bus_get_ops(np);
>>   
>>          count = of_get_child_count(events_np);
>>          desc = devm_kcalloc(dev, count, sizeof(*desc), GFP_KERNEL);
>> @@ -540,11 +524,38 @@ static int of_get_devfreq_events(struct device_node *np,
>>                          continue;
>>                  }
>>   
>> -               desc[j].ops = event_ops;
>> +               switch (info->ppmu_type) {
>> +               case EXYNOS_TYPE_PPMU:
>> +                       desc[j].ops = &exynos_ppmu_ops;
>> +                       break;
>> +               case EXYNOS_TYPE_PPMU_V2:
>> +                       desc[j].ops = &exynos_ppmu_v2_ops;
>> +                       break;
>> +               }
>> +
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
