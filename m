Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942261161E
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfEBJHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 05:07:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57141 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfEBJHt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 05:07:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190502090747euoutp0101707e5a16a040f50e0c6bedfd81fa11~a0n_7gvaR0763407634euoutp017
        for <linux-pm@vger.kernel.org>; Thu,  2 May 2019 09:07:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190502090747euoutp0101707e5a16a040f50e0c6bedfd81fa11~a0n_7gvaR0763407634euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556788067;
        bh=7y6pfwZd2kl1NIeu3yktOUDRjdOM1tIbsD/dhVmUFg4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Un35zlu0clDc23xVDMVXdifRCgA7wlF35FjwmtybuYOBEWOenJJ19faV5C0n1VdLI
         MGwn2V29TZ0kN3472bVfIRW237a4QnK20DFqBoIBViZXDGWo8sYcPUTO+GU1b5i6rT
         6ryfHjPFsDPUbs9by5pFcGcwJTJnyK7yqKRQylIU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190502090746eucas1p27d534a5b51bc17d1c6c85dfd981a26fe~a0n_N938v0868708687eucas1p2z;
        Thu,  2 May 2019 09:07:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D8.AB.04325.263BACC5; Thu,  2
        May 2019 10:07:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190502090745eucas1p1cc1da597aca7dbdf5524e2368a45accc~a0n9bSL741494314943eucas1p1B;
        Thu,  2 May 2019 09:07:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190502090745eusmtrp146287be8f56d7b57e00a90a41952b226~a0n9NIs3A2320523205eusmtrp1H;
        Thu,  2 May 2019 09:07:45 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-da-5ccab362ba50
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C5.4F.04146.163BACC5; Thu,  2
        May 2019 10:07:45 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190502090744eusmtip13ce7d7f7dc8e4f82cb2f0b7d0160ce9b~a0n8USKY83225432254eusmtip1T;
        Thu,  2 May 2019 09:07:44 +0000 (GMT)
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
Message-ID: <4cd7b7a3-7458-2166-a784-1a94830f5507@partner.samsung.com>
Date:   Thu, 2 May 2019 11:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <be9dfa71-b6fd-ebe3-e8be-a7ea28765225@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djPc7pJm0/FGMz5wmOxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FsVlk5Kak1mWWqRvl8CV0Tj7NVPBZMWK9qclDYxzpLoYOTkkBEwkdl/dwtrFyMUhJLCCUeLf
        /i1sEM4XRon7e6dBOZ8ZJe593scO0zJt3iVmiMRyRom9My+xQzhvgVqmzGUCqRIWiJW4NWEa
        2GARgZOMEr2Nd8EcZpBZJx9cA3I4ONgE9CR2rCoEaeAVcJO4d2Q2M4jNIqAisWhHGxuILSoQ
        IXH/2AZWiBpBiZMzn7CA2JwC9hLf1+wAs5kFxCVuPZnPBGHLSzRvnQ12noTAX3aJ7es+sUDc
        7SLR9qObGcIWlnh1fAvUPzISpyf3QNUUSzT0LmSEsGskHvfPhaqxljh8/CLYzcwCmhLrd+lD
        hB0l3q7/wQQSlhDgk7jxVhDiBD6JSdumM0OEeSU62oQgqjUktvRcYIKwxSSWr5nGPoFRaRaS
        x2YheWYWkmdmIexdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzDJnf53/OsOxn1/
        kg4xCnAwKvHw/ph6MkaINbGsuDL3EKMEB7OSCO+tPUAh3pTEyqrUovz4otKc1OJDjNIcLEri
        vNUMD6KFBNITS1KzU1MLUotgskwcnFINjCfjZ/9cdfl9VprbI+dIMXHP+uC6lA3aT4L4tcW+
        TfWauWTSd88Vn9J/sxz82BP44e9Gxt3vBM1WMv96aTh3AUdM7bxv0gbzvLzmzPzq7sOnl768
        WXRK3AFWt0nijooeDWqTvLLEW3r3G8YeaZRp7/HNNfRf0h9xz7qbWfa/3cVD7yWjeP3nKbEU
        ZyQaajEXFScCAPmPPGhuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7qJm0/FGGyaI2qxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0Tj7
        NVPBZMWK9qclDYxzpLoYOTkkBEwkps27xNzFyMUhJLCUUWLa/ouMEAkxiUn7trND2MISf651
        sUEUvWaU+NM6jRUkISwQKzF/8T5GkISIwElGidkT/jKBOMwCnxklpq+5DDW3jVni+8NrQLM4
        ONgE9CR2rCoE6eYVcJO4d2Q2M4jNIqAisWhHGxuILSoQIXHm/QoWiBpBiZMzn4DZnAL2Et/X
        7ACzmQXMJOZtfsgMYYtL3HoynwnClpdo3jqbeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW5
        6bnFhnrFibnFpXnpesn5uZsYgZG97djPzTsYL20MPsQowMGoxMP7Y+rJGCHWxLLiytxDjBIc
        zEoivLf2AIV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5h08kriDU0NzS0sDc2NzY3NLJTE
        eTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MM70qs1dyV36czWDkqROw5pXlx1OyIrPFGfIyF8c
        UlUf51nyyZ7fXrw9Wq2kffGRvXn3xDMiNwi6fLb9eVhgXu2PiW/NjPQVfwkmrvR9/D3j7LYt
        Ov+W5cYG38j6ERnyOySsxvG/1suQ304/9e7s8v4td65awe96mpnJlCvHKjem1TlJ589qUGIp
        zkg01GIuKk4EADO1N9gCAwAA
X-CMS-MailID: 20190502090745eucas1p1cc1da597aca7dbdf5524e2368a45accc
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
        <adb6e86a-880e-f9b7-76b2-777a531895d2@partner.samsung.com>
        <be9dfa71-b6fd-ebe3-e8be-a7ea28765225@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/2/19 3:25 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 5. 1. 오전 6:19, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> On 4/30/19 9:34 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
>>>> This patch adds posibility to choose what type of data should be counted
>>>> by the PPMU counter. Now the type comes from DT where the event has been
>>>> defined. When there is no 'event-data-type' the default value is used,
>>>> which is 'read data in bytes'.
>>>> It is needed when you want to know not only read+write data bytes but
>>>> i.e. only write data in byte, or number of read requests, etc.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    drivers/devfreq/event/exynos-ppmu.c | 61 +++++++++++++++++++++++++------------
>>>>    include/linux/devfreq-event.h       |  6 ++++
>>>>    2 files changed, 48 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>>>> index c61de0b..073bf2c 100644
>>>> --- a/drivers/devfreq/event/exynos-ppmu.c
>>>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>>>> @@ -154,9 +154,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>>>>    	if (ret < 0)
>>>>    		return ret;
>>>>    
>>>> -	/* Set the event of Read/Write data count  */
>>>> +	/* Set the event of proper data type monitoring */
>>>>    	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
>>>> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
>>>> +			   edev->desc->data_type);
>>>>    	if (ret < 0)
>>>>    		return ret;
>>>>    
>>>> @@ -368,23 +368,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>>>    	if (ret < 0)
>>>>    		return ret;
>>>>    
>>>> -	/* Set the event of Read/Write data count  */
>>>> -	switch (id) {
>>>> -	case PPMU_PMNCNT0:
>>>> -	case PPMU_PMNCNT1:
>>>> -	case PPMU_PMNCNT2:
>>>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>>>> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
>>>> -		if (ret < 0)
>>>> -			return ret;
>>>> -		break;
>>>> -	case PPMU_PMNCNT3:
>>>> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>>>> -				PPMU_V2_EVT3_RW_DATA_CNT);
>>>> -		if (ret < 0)
>>>> -			return ret;
>>>> -		break;
>>>> -	}
>>>> +	/* Set the event of proper data type monitoring */
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>>>> +			   edev->desc->data_type);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>    
>>>>    	/* Reset cycle counter/performance counter and enable PPMU */
>>>>    	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>>>> @@ -508,6 +496,7 @@ static int of_get_devfreq_events(struct device_node *np,
>>>>    	struct device *dev = info->dev;
>>>>    	struct device_node *events_np, *node;
>>>>    	int i, j, count;
>>>> +	int ret;
>>>>    
>>>>    	events_np = of_get_child_by_name(np, "events");
>>>>    	if (!events_np) {
>>>> @@ -544,6 +533,40 @@ static int of_get_devfreq_events(struct device_node *np,
>>>>    		desc[j].driver_data = info;
>>>>    
>>>>    		of_property_read_string(node, "event-name", &desc[j].name);
>>>> +		ret = of_property_read_u32(node, "event-data-type",
>>>> +					   &desc[j].data_type);
>>>> +		if (ret) {
>>>> +			/* Set the event of proper data type counting.
>>>> +			 * Check if the data type has been defined in DT,
>>>> +			 * use default if not.
>>>> +			 */
>>>> +			if (of_device_is_compatible(np,
>>>> +					"samsung,exynos-ppmu-v2")) {
>>>
>>> It is not proper to compare the compatible string again
>>> in the device driver. Instead, you can define the ppmu device type
>>> as following and then use 'struct of_device_id' in order to
>>> identify the device type.
>> I have been thinking about modifying the code in similar fashion as you
>> did. Good to see similar approach. I'll take your changes with a small
>> additional code, which sets the 'info->ppmu_type' before the for
>> loop, as an additional patch. Would it be OK if I add you as an author
>> and add Sign-off-by: Chanwoo Choi <cw00.choi@samsung.com>?
> 
> If you agree, just add the my signed-off-by on second line.
OK

Regards,
Lukasz
