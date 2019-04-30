Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A861101AF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 23:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfD3VTN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 17:19:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50698 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfD3VTM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 17:19:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190430211910euoutp0259383d3768e21120fd7b21003d314c2c~aXUAHhmCV0828308283euoutp02g
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 21:19:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190430211910euoutp0259383d3768e21120fd7b21003d314c2c~aXUAHhmCV0828308283euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556659150;
        bh=4EI1v4CayMjzpl2T5dvi9jPEnNc2wJ+J/pfui+gzwWs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QdS5VXN0sy6P8Wx2hmvLPSX/KhVJbalxEpv8W8NWRXOwH+ZHrE6GJ/ZuUCZiZO5LR
         v0CcCHd1lE8Ut+Etdg6GvgkGy54kq26qVP56NFvyqRSmAzSUxyBm5mCBIendDd8fqP
         rWDALLtJT9ImTVzZkz8c8L82kCqXS6u6ekYtClO8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430211909eucas1p2e0749e479fff20c4265196e24bcb93d8~aXT-Hxq7L2561325613eucas1p2u;
        Tue, 30 Apr 2019 21:19:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CE.85.04325.DCBB8CC5; Tue, 30
        Apr 2019 22:19:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190430211907eucas1p24b3ebf45d318800450029f36634c2196~aXT9fEjMd2985729857eucas1p2N;
        Tue, 30 Apr 2019 21:19:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430211907eusmtrp2d3cd71e7687ee349645ca356e255f220~aXT9PZwjY1026210262eusmtrp2c;
        Tue, 30 Apr 2019 21:19:07 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-13-5cc8bbcdded2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.44.04146.BCBB8CC5; Tue, 30
        Apr 2019 22:19:07 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430211906eusmtip197ae411abadc6b6716615af2d6afb0fc~aXT8Um-a81212112121eusmtip1L;
        Tue, 30 Apr 2019 21:19:06 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] drivers: devfreq: events: extend events by type
 of counted data
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <adb6e86a-880e-f9b7-76b2-777a531895d2@partner.samsung.com>
Date:   Tue, 30 Apr 2019 23:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3557d507-0463-89de-4025-fbeaaef78bed@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djP87pnd5+IMXgxX8xi44z1rBbXvzxn
        tZh/5ByrRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz+Nx7hNFixvl9TBZrj9xlt1h6/SKT
        xe3GFWwWrXuPsFscftPOavHtxCNGBwGPNfPWMHrsnHWX3WPTqk42j81L6j36tqxi9Pi8SS6A
        LYrLJiU1J7MstUjfLoEr49mGI6wF220r7q5sZmxgXKXTxcjJISFgItH+tZm9i5GLQ0hgBaPE
        yWVHWSCcL4wSzQ/mM4FUCQl8ZpQ4viEFpuNl+0w2iKLljBJbn95ggSh6yyixfL4eiC0sECtx
        a8I0VpAiEYGTjBK9jXfBHGaQSScfXANyODjYBPQkdqwqBGngFXCT+DLrITNImEVAVeL1XjaQ
        sKhAhMT9YxtYIUoEJU7OfAK2i1PAXuL9uc1gNcwC4hK3nkAcyiwgL9G8dTYzyCoJgUYOielb
        J7NBXO0i8fFgByuELSzx6vgWdghbRuL/TohmCYFiiYbehYwQdo3E4/65UDXWEoePXwQ7mVlA
        U2L9Ln2IsKPE2/U/mEDCEgJ8EjfeCkKcwCcxadt0Zogwr0RHmxBEtYbElp4LUIvEJJavmcY+
        gVFpFpLHZiF5ZhaSZ2Yh7F3AyLKKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMMGd/nf8
        6w7GfX+SDjEKcDAq8fBqeJ6IEWJNLCuuzD3EKMHBrCTC63H8aIwQb0piZVVqUX58UWlOavEh
        RmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRgelpUqG2728uFwMyrW2+Ldd4ghzauWQ
        KnOzD1CVuWZ83ZRx2Z78Opaq7NYfHz9xNS2qPSXrEBA0tXTRx21GOlGuxvPysz9fD1uRcejE
        /LcuyxheXH8vM/FgM+dqCVHbFRtrkm5Kq0cKLEjlP7vNfWHboQnGRpfmaZkufZjnvd9WNc3T
        yVxHiaU4I9FQi7moOBEA5/7qHWwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7qnd5+IMdjYLWaxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8WzD
        EdaC7bYVd1c2MzYwrtLpYuTkkBAwkXjZPpOti5GLQ0hgKaPEre5NbBAJMYlJ+7azQ9jCEn+u
        dUEVvWaU2LHiOCNIQlggVmL+4n2MIAkRgZOMErMn/GUCcZgFPjNKTF9zmRmiZQqTxLY/c4HK
        ODjYBPQkdqwqBOnmFXCT+DLrITNImEVAVeL1XrDNogIREmfer2CBKBGUODnzCZjNKWAv8f7c
        ZrAaZgEziXmbQVpBbHGJW0/mM0HY8hLNW2czT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3
        PbfYUK84Mbe4NC9dLzk/dxMjMLK3Hfu5eQfjpY3BhxgFOBiVeHgvuJ2IEWJNLCuuzD3EKMHB
        rCTC63H8aIwQb0piZVVqUX58UWlOavEhRlOg3yYyS4km5wOTTl5JvKGpobmFpaG5sbmxmYWS
        OG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsZk21yDyV7/Zwl5H53TIyFSFla672Zsn8r9P6oW
        zN53bkz+eqN0f4SxyeGf874aK2x9XfbizNkDcirTX379fFQy0PlriQeHXps4Z9OJvdK5HJ6p
        3YwOPr9fL532Z/XFpzZXjzC6PVr0tn+61p07mcksuYlGHiVz5aMirrcuFd8QknJpr9qJFyeV
        WIozEg21mIuKEwE8Ie5bAgMAAA==
X-CMS-MailID: 20190430211907eucas1p24b3ebf45d318800450029f36634c2196
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0@eucas1p2.samsung.com>
        <1555681688-19643-3-git-send-email-l.luba@partner.samsung.com>
        <3557d507-0463-89de-4025-fbeaaef78bed@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 4/30/19 9:34 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
>> This patch adds posibility to choose what type of data should be counted
>> by the PPMU counter. Now the type comes from DT where the event has been
>> defined. When there is no 'event-data-type' the default value is used,
>> which is 'read data in bytes'.
>> It is needed when you want to know not only read+write data bytes but
>> i.e. only write data in byte, or number of read requests, etc.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/event/exynos-ppmu.c | 61 +++++++++++++++++++++++++------------
>>   include/linux/devfreq-event.h       |  6 ++++
>>   2 files changed, 48 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>> index c61de0b..073bf2c 100644
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -154,9 +154,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	/* Set the event of Read/Write data count  */
>> +	/* Set the event of proper data type monitoring */
>>   	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
>> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
>> +			   edev->desc->data_type);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> @@ -368,23 +368,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	/* Set the event of Read/Write data count  */
>> -	switch (id) {
>> -	case PPMU_PMNCNT0:
>> -	case PPMU_PMNCNT1:
>> -	case PPMU_PMNCNT2:
>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
>> -		if (ret < 0)
>> -			return ret;
>> -		break;
>> -	case PPMU_PMNCNT3:
>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>> -				PPMU_V2_EVT3_RW_DATA_CNT);
>> -		if (ret < 0)
>> -			return ret;
>> -		break;
>> -	}
>> +	/* Set the event of proper data type monitoring */
>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>> +			   edev->desc->data_type);
>> +	if (ret < 0)
>> +		return ret;
>>   
>>   	/* Reset cycle counter/performance counter and enable PPMU */
>>   	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>> @@ -508,6 +496,7 @@ static int of_get_devfreq_events(struct device_node *np,
>>   	struct device *dev = info->dev;
>>   	struct device_node *events_np, *node;
>>   	int i, j, count;
>> +	int ret;
>>   
>>   	events_np = of_get_child_by_name(np, "events");
>>   	if (!events_np) {
>> @@ -544,6 +533,40 @@ static int of_get_devfreq_events(struct device_node *np,
>>   		desc[j].driver_data = info;
>>   
>>   		of_property_read_string(node, "event-name", &desc[j].name);
>> +		ret = of_property_read_u32(node, "event-data-type",
>> +					   &desc[j].data_type);
>> +		if (ret) {
>> +			/* Set the event of proper data type counting.
>> +			 * Check if the data type has been defined in DT,
>> +			 * use default if not.
>> +			 */
>> +			if (of_device_is_compatible(np,
>> +					"samsung,exynos-ppmu-v2")) {
> 
> It is not proper to compare the compatible string again
> in the device driver. Instead, you can define the ppmu device type
> as following and then use 'struct of_device_id' in order to
> identify the device type.
I have been thinking about modifying the code in similar fashion as you
did. Good to see similar approach. I'll take your changes with a small
additional code, which sets the 'info->ppmu_type' before the for
loop, as an additional patch. Would it be OK if I add you as an author
and add Sign-off-by: Chanwoo Choi <cw00.choi@samsung.com>?

Regards,
Lukasz
> 
> 	enum exynos_ppmu_type {
> 		EXYNOS_TYPE_PPMU,
> 		EXYNOS_TYPE_PPMU_V2,
> 	};
> 
>   static const struct of_device_id exynos_ppmu_id_match[] = {
>          {
>                  .compatible = "samsung,exynos-ppmu",
> -               .data = (void *)&exynos_ppmu_ops,
> +               .data = (void *)EXYNOS_TYPE_PPMU,
>          }, {
>                  .compatible = "samsung,exynos-ppmu-v2",
> -               .data = (void *)&exynos_ppmu_v2_ops,
> +               .data = (void *)EXYNOS_TYPE_PPMU_V2,
>          },
> 
> 
> The many device drivers in the mainline uses this code
> in order to get the device type. You can refer the example
> in the drivers/mfd/max14577.c.
> 
> (snip)
> 
> 
> Example, I add the example. but it is not tested.
> 
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -16,6 +16,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of_address.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/suspend.h>
> @@ -23,6 +24,11 @@
>   
>   #include "exynos-ppmu.h"
>   
> +enum exynos_ppmu_type {
> +       EXYNOS_TYPE_PPMU,
> +       EXYNOS_TYPE_PPMU_V2,
> +};
> +
>   struct exynos_ppmu_data {
>          struct clk *clk;
>   };
> @@ -36,6 +42,7 @@ struct exynos_ppmu {
>          struct regmap *regmap;
>   
>          struct exynos_ppmu_data ppmu;
> +       enum exynos_ppmu_type ppmu_type;
>   };
>   
>   #define PPMU_EVENT(name)                       \
>   
>          /* Reset cycle counter/performance counter and enable PPMU */
>          ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
> @@ -483,31 +476,23 @@ static const struct devfreq_event_ops exynos_ppmu_v2_ops = {
>   static const struct of_device_id exynos_ppmu_id_match[] = {
>          {
>                  .compatible = "samsung,exynos-ppmu",
> -               .data = (void *)&exynos_ppmu_ops,
> +               .data = (void *)EXYNOS_TYPE_PPMU,
>          }, {
>                  .compatible = "samsung,exynos-ppmu-v2",
> -               .data = (void *)&exynos_ppmu_v2_ops,
> +               .data = (void *)EXYNOS_TYPE_PPMU_V2,
>          },
>          { /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, exynos_ppmu_id_match);
>   
> -static struct devfreq_event_ops *exynos_bus_get_ops(struct device_node *np)
> -{
> -       const struct of_device_id *match;
> -
> -       match = of_match_node(exynos_ppmu_id_match, np);
> -       return (struct devfreq_event_ops *)match->data;
> -}
> -
>   static int of_get_devfreq_events(struct device_node *np,
>                                   struct exynos_ppmu *info)
>   {
>          struct devfreq_event_desc *desc;
> -       struct devfreq_event_ops *event_ops;
>          struct device *dev = info->dev;
>          struct device_node *events_np, *node;
>          int i, j, count;
>   
>          events_np = of_get_child_by_name(np, "events");
>          if (!events_np) {
> @@ -515,7 +500,6 @@ static int of_get_devfreq_events(struct device_node *np,
>                          "failed to get child node of devfreq-event devices\n");
>                  return -EINVAL;
>          }
> -       event_ops = exynos_bus_get_ops(np);
>   
>          count = of_get_child_count(events_np);
>          desc = devm_kcalloc(dev, count, sizeof(*desc), GFP_KERNEL);
> @@ -540,11 +524,38 @@ static int of_get_devfreq_events(struct device_node *np,
>                          continue;
>                  }
>   
> -               desc[j].ops = event_ops;
> +               switch (info->ppmu_type) {
> +               case EXYNOS_TYPE_PPMU:
> +                       desc[j].ops = &exynos_ppmu_ops;
> +                       break;
> +               case EXYNOS_TYPE_PPMU_V2:
> +                       desc[j].ops = &exynos_ppmu_v2_ops;
> +                       break;
> +               }
> +
> 
> 
