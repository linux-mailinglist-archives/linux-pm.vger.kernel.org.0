Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26A872C45
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 12:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfGXKV6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 06:21:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:43507 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfGXKV5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 06:21:57 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190724102154epoutp0349b381f26eff13aa90dd04fba7e91eb3~0ULZU0xCW1091910919epoutp03H
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 10:21:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190724102154epoutp0349b381f26eff13aa90dd04fba7e91eb3~0ULZU0xCW1091910919epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563963714;
        bh=fJ240QuJ4AWiZBDFAKIhCbblPL1WVUx6EYRobuxht4Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RrRNM4Ss0ZKvII7yXlCXw2mYCY+MlKGOVF7IbHbzRUCPy0HVQWLsOD29lFH9q1/DY
         XnzfPESI3RLHrwr71o2+pT70L5MmUzgbKb9sb6y1mjUNTNSHatIY+QrddzlUQMwPTe
         bA4eXqzTU7GviTV5rP1sfYS5F1Lh6KkTOljt5Qqg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190724102153epcas1p41ee33c3d4484574076ca5c1dfe1fdb55~0ULYi-eAX3103531035epcas1p4B;
        Wed, 24 Jul 2019 10:21:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45trxC3SzmzMqYkb; Wed, 24 Jul
        2019 10:21:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.1D.04160.F31383D5; Wed, 24 Jul 2019 19:21:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190724102150epcas1p3dedca2401c63bee9e76f9f874712ea50~0ULVQhhcD0054900549epcas1p3m;
        Wed, 24 Jul 2019 10:21:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190724102150epsmtrp2f9f243fd504c9fe4f1f313d42646f4a9~0ULVO9DxM1535615356epsmtrp2_;
        Wed, 24 Jul 2019 10:21:50 +0000 (GMT)
X-AuditID: b6c32a38-b4bff70000001040-84-5d38313f5331
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.53.03706.E31383D5; Wed, 24 Jul 2019 19:21:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190724102149epsmtip2beb32fb3b843c89bf05516b7005f889c~0ULU_BLq40400504005epsmtip2P;
        Wed, 24 Jul 2019 10:21:49 +0000 (GMT)
Subject: Re: [PATCH v4 3/5] drivers: devfreq: events: extend events by type
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
Message-ID: <15375017-2e82-7df8-344c-a9c41d61331c@samsung.com>
Date:   Wed, 24 Jul 2019 19:24:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <37af143f-a585-a28a-a36f-2ed25c5b6d3b@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzeubf39sLW7azq/EkWLdcshmYgl9JybMAtmXNNRhSzLDFmDbtr
        b4DQV3oL6pwTNMjL4RYzxU5xibIM5oMV5oNZiaVxsgXKIGPzUULEPwgqOruh2Vxi27Nl/Pd9
        3/l++c53HgKrv8FnCVWegOL3yC6Rz9ScHczJy31NIvb85idAvm0/w5Fj0RGO7J++w5JYrEdL
        hnff1ZLrdS+T0PQER8b7j/Ak8UkUkfbYJYacisa1pPPXnxlyo/5rnjSEo1oyeLeRI/NXb6HX
        se1kx0lkuxCMa22h7mbe1ntil+3y3EXG1tbXjWyJ0PIy7Zbq4kpFdip+g+JxeJ1VnooS8e13
        yt8oN1vypVxpDSkSDR7ZrZSI60rLctdXuZJ7Fw21sqsmKZXJqiquXlvs99YEFEOlVw2UiIrP
        6fKt8eWpslut8VTkObxuq5SfX2BOGt+vrrza2sv5Ol7dNvzgHFeHDoktKEMAXAiJ2UmmBWUK
        enweQWJilqPkIYJ/euKIknkEjV/Vsy1ISI+MxTZTPYzg8/oeDSX3Edzcd4BJmRZhO+z9xpLS
        F+NhBFO7z/IpwuIEgqGpCS4VzmMjDMz8xqfwCzgbfnk8jVJYh9dCJB5JezT4FQh3tqQ9S/Bm
        eDg1yFHPizB0+LYmhTPwW3D6Xk/aw+KlcP32MYbiFbDnuy/YVDDgK1qoj4a1tPU6+HE2hChe
        BLM/9P2rZ0FiLsxTvAO6hqI8HW5C0DcwytEFEwx00poszoEz/aupnA0X/j6KaPDzMPfnPo4e
        lw6a9uqpZSWMT8UZipfB8cZm/lMkBhfUCS6oEFxQIfh/2JdI041eUnyqu0JRJV/hwusOofTD
        NpLz6OJIaQRhAYnP6QzPFNn1nFyrbndHEAisuFi3qc5i1+uc8vYPFb+33F/jUtQIMidP+zM2
        a4nDm/wmnkC5ZC4wmUykULKYJUlcqut4kmPX4wo5oFQrik/x/zfHCBlZdch8s71pp+mjySBX
        mo0L3j1IjNiyjQjzo3nWvkOTzKhzxZGJtpGA/BdsrX2vd2x68JpxVaNi3WTNbL3W9Wjk2X7d
        6fVFd9zFjtatx3PedOBd51Y1eOLLY9/P7Lg/Fr8lVjWIkmD2Zo5b9/y0fyb0Mfxx8PeNXVcO
        qG2BDTuHTnwgatRKWTKyflV+CrT0vvbuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSvK6doUWswZF/7BYbZ6xntZh/5Byr
        Rf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x9PpFJovb
        jSvYLFr3HmG3OPymndXi24lHjA4CHmvmrWH02DnrLrvHplWdbB6bl9R7HHy3h8mjb8sqRo/P
        m+QC2KO4bFJSczLLUov07RK4Mk50b2YtmKdTcfbDdtYGxulKXYwcHBICJhKXzkd0MXJxCAns
        ZpS4s7yBuYuREyguKTHt4lFmiBphicOHiyFq3jJKHDl+gR2kRlggVqLp0mVWkISIwFlGiUWT
        FrCDOMwCnxklpq+5zAzR0sYkMa31MAtIC5uAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2EofuHmIF
        sVkEVCX2Lu0CqxEViJA4vGMWVI2gxMmZT8DmcAq4S6x7uwGshllAXeLPvEvMELa4xK0n85kg
        bHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yf
        u4kRHLtamjsYLy+JP8QowMGoxMOrwGAeK8SaWFZcmXuIUYKDWUmEN7DBLFaINyWxsiq1KD++
        qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxnpe/4KZ/d3xG0wSV62TWjHl
        dlb5zm//XqRPfck50fIC675Pbzt07nWJmnzZGapf+GGewK858q91H+QkSVxarJT/SzT7Y6jC
        rZuLdonNXhLhpzXvl5+bxWtp65uLfzOenXFZ1UD6XO3+4MINV5Z27lpquceqm0W6cutDjfzO
        34f/Lax0fe355LkSS3FGoqEWc1FxIgCr0Is22QIAAA==
X-CMS-MailID: 20190724102150epcas1p3dedca2401c63bee9e76f9f874712ea50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a
References: <20190605091236.24263-1-l.luba@partner.samsung.com>
        <CGME20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a@eucas1p2.samsung.com>
        <20190605091236.24263-4-l.luba@partner.samsung.com>
        <37af143f-a585-a28a-a36f-2ed25c5b6d3b@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 7. 24. 오후 7:15, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> Could you have a look a this patch, please?
> This patch has been rewritten accorifing to your suggestion.
> Krzysztof tried to apply 5/5 DT patch on his current branch,
> but it is missing earlier stuff.
> The other patches have needed ACKs so could go through devfreq tree
> probably, but this one left.

Sorry for the late reply. It looks good to me.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> Regards,
> Lukasz
> 
> On 6/5/19 11:12 AM, Lukasz Luba wrote:
>> This patch adds posibility to choose what type of data should be counted
>> by the PPMU counter. Now the type comes from DT where the event has been
>> defined. When there is no 'event-data-type' the default value is used,
>> which is 'read+write data in bytes'.
>> It is needed when you want to know not only read+write data bytes but
>> i.e. only write data in byte, or number of read requests, etc.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/event/exynos-ppmu.c | 60 ++++++++++++++++++++---------
>>   include/linux/devfreq-event.h       |  6 +++
>>   2 files changed, 47 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>> index 17f3c86a6f00..12f637320e9e 100644
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -161,9 +161,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
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
>> @@ -375,23 +375,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
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
>> @@ -507,6 +495,7 @@ static int of_get_devfreq_events(struct device_node *np,
>>   	struct device_node *events_np, *node;
>>   	int i, j, count;
>>   	const struct of_device_id *of_id;
>> +	int ret;
>>   
>>   	events_np = of_get_child_by_name(np, "events");
>>   	if (!events_np) {
>> @@ -556,6 +545,39 @@ static int of_get_devfreq_events(struct device_node *np,
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
>> +			if (info->ppmu_type == EXYNOS_TYPE_PPMU_V2) {
>> +				struct devfreq_event_dev edev;
>> +				int id;
>> +				/* Not all registers take the same value for
>> +				 * read+write data count.
>> +				 */
>> +				edev.desc = &desc[j];
>> +				id = exynos_ppmu_find_ppmu_id(&edev);
>> +
>> +				switch (id) {
>> +				case PPMU_PMNCNT0:
>> +				case PPMU_PMNCNT1:
>> +				case PPMU_PMNCNT2:
>> +					desc[j].data_type = PPMU_V2_RO_DATA_CNT
>> +						| PPMU_V2_WO_DATA_CNT;
>> +					break;
>> +				case PPMU_PMNCNT3:
>> +					desc[j].data_type =
>> +						PPMU_V2_EVT3_RW_DATA_CNT;
>> +					break;
>> +				}
>> +			} else {
>> +				desc[j].data_type = PPMU_RO_DATA_CNT |
>> +					PPMU_WO_DATA_CNT;
>> +			}
>> +		}
>>   
>>   		j++;
>>   	}
>> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
>> index 4db00b02ca3f..cc160b1274c0 100644
>> --- a/include/linux/devfreq-event.h
>> +++ b/include/linux/devfreq-event.h
>> @@ -81,14 +81,20 @@ struct devfreq_event_ops {
>>    * struct devfreq_event_desc - the descriptor of devfreq-event device
>>    *
>>    * @name	: the name of devfreq-event device.
>> + * @data_type	: the data type which is going to be counted in the register.
>>    * @driver_data	: the private data for devfreq-event driver.
>>    * @ops		: the operation to control devfreq-event device.
>>    *
>>    * Each devfreq-event device is described with a this structure.
>>    * This structure contains the various data for devfreq-event device.
>> + * The data_type describes what is going to be counted in the register.
>> + * It might choose to count e.g. read requests, write data in bytes, etc.
>> + * The full supported list of types is present in specyfic header in:
>> + * include/dt-bindings/pmu/.
>>    */
>>   struct devfreq_event_desc {
>>   	const char *name;
>> +	u32 data_type;
>>   	void *driver_data;
>>   
>>   	const struct devfreq_event_ops *ops;
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
