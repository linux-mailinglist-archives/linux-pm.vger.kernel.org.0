Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA26EBE1A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 07:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKAGqI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 02:46:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58955 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKAGqH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 02:46:07 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191101064605epoutp03df218194672d6a84471eabd5ebc390b8~S9vg73zYK3169231692epoutp03t
        for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2019 06:46:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191101064605epoutp03df218194672d6a84471eabd5ebc390b8~S9vg73zYK3169231692epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572590765;
        bh=oE1vKRf9KfKqu3zr6FieGsODlnie4bMmsyb+gfv+dTQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=enpaHuDYwXQPo3Zfcq56V26Y5sq/iIA+vdp+FznzNGNwMsDAkZ5xi4653DPD7xL0m
         hp3ZjKghOO65sRffB4MN0rWVyBppakvTWToYjGAyLgkuLDzzE30TzgzvhZYnaqKvma
         lVs83BI3qDamhC4J7RfqE2DTAVyYASJRnt4GhRkE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191101064605epcas1p1323ab4351d7b964f67d531f2b6110bc5~S9vgY_6AN0373603736epcas1p1E;
        Fri,  1 Nov 2019 06:46:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 474CQ25d6MzMqYkh; Fri,  1 Nov
        2019 06:46:02 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.E7.04224.AA4DBBD5; Fri,  1 Nov 2019 15:46:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191101064602epcas1p10339b9c1a2eed204bac1acf3885d79a7~S9vdTg6lV0610206102epcas1p1R;
        Fri,  1 Nov 2019 06:46:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191101064602epsmtrp2cd1980aeab7e3cfe894743e329be8b97~S9vdSpE4H2799827998epsmtrp2q;
        Fri,  1 Nov 2019 06:46:02 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-d9-5dbbd4aa66dd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.A6.25663.9A4DBBD5; Fri,  1 Nov 2019 15:46:01 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191101064601epsmtip2286b09d9f75b10b361a36590c3420d72~S9vdA0cqz2931229312epsmtip28;
        Fri,  1 Nov 2019 06:46:01 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: events: fix excessive stack usage
To:     Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lukasz Luba <l.luba@partner.samsung.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e0d6b270-477a-9438-e992-263187bc52aa@samsung.com>
Date:   Fri, 1 Nov 2019 15:51:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022142703.1789898-1-arnd@arndb.de>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmge6qK7tjDVYtVrP4O+kYu0X/49fM
        FufPb2C3ONv0ht3iVoOMxabH11gtLu+aw2bxufcIo8WM8/uYLG43rmBz4PL4/WsSo8emVZ1s
        HpuX1HscfLeHyaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4AOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBbo
        FSfmFpfmpesl5+daGRoYGJkCFSZkZ1z7KlxwULRiwdmnzA2MEwW7GDk4JARMJE71hnQxcnEI
        CexglFi/dDsLhPOJUeL9yilMEM43RomzB06zdzFygnU8n3SEGSKxl1Fi2fnXjBDOe0aJfbuW
        sYBUCQu4SHy+/44NJCEisJ9RYvHt92AOs8BGRom9k6+BVbEJaEnsf3GDDcTmF1CUuPrjMSOI
        zStgJ7Fs1xGwOIuAisTiKz/YQa4VFYiQOP01EaJEUOLkzCdgYzgFTCWW90K0MguIS9x6Mp8J
        wpaXaN46G+xUCYF2dol5j+9D/eAise/tckYIW1ji1fEtUHEpic/v9rJB2NUSK08eYYNo7mCU
        2LL/AitEwlhi/9LJTCAHMQtoSqzfpQ8RVpTY+Xsu1BF8Eu++9rBCQphXoqNNCKJEWeLyg7tM
        ELakxOL2TrYJjEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBSbIsb2JEZxotSx2MO45
        53OIUYCDUYmHd0bX7lgh1sSy4srcQ4wSHMxKIrzb1wGFeFMSK6tSi/Lji0pzUosPMZoCA3si
        s5Rocj4wC+SVxBuaGhkbG1uYGJqZGhoqifM6Ll8aKySQnliSmp2aWpBaBNPHxMEp1cC47siK
        L7PSvTJn8FlJnQmdMO/1rXqxqpUP6j9U2t1tEZB8uSZ12b9X6flZF08pFjFfcmzZna/2/+vU
        TfJFj5/OkFpzq+ywy2M75XPx6/4bPnh4oOmXGBvr8uzqtYEPPfU1V+RNPXGO6eq5cKmJ16v8
        pm5ccaz13PcOFtNlsp+NWhSuLzDT6L2zQomlOCPRUIu5qDgRAP/Wx6fKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvO7KK7tjDRbdtrD4O+kYu0X/49fM
        FufPb2C3ONv0ht3iVoOMxabH11gtLu+aw2bxufcIo8WM8/uYLG43rmBz4PL4/WsSo8emVZ1s
        HpuX1HscfLeHyaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyrn0VLjgoWrHg7FPmBsaJgl2M
        nBwSAiYSzycdYQaxhQR2M0o8eckLEZeUmHbxKFCcA8gWljh8uLiLkQuo5C2jxINvG1hAaoQF
        XCQ+33/HBpIQEdjPKHHyz0FmEIdZYCNQ1eK5TBAtHYwS5z9fB1vBJqAlsf/FDTYQm19AUeLq
        j8eMIDavgJ3Esl1HwOIsAioSi6/8YAexRQUiJJ5vvwFVIyhxcuYTsNWcAqYSy3shepkF1CX+
        zLvEDGGLS9x6Mp8JwpaXaN46m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp
        5XrFibnFpXnpesn5uZsYwTGnpbWD8cSJ+EOMAhyMSjy8M7p2xwqxJpYVV+YeYpTgYFYS4d2+
        DijEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBMVBpyz35
        GdPTFXjCAm7vafNsjNvAZCn0ff3cPQev6k014W5N1niz6FSY9bfLTokrC1mZH9bqvb71T+r9
        yiWnFQPCWE8cSPp7V999yUJe4+7exmzdRtOPVht4y/xCLzN4uT862nPu41KOh+ezdi9Zu+e5
        wedzn7epFK0Ma7djeMqgXr8pa7pJvRJLcUaioRZzUXEiALC0KYy1AgAA
X-CMS-MailID: 20191101064602epcas1p10339b9c1a2eed204bac1acf3885d79a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191022142726epcas3p4c09cde8944f5e8f1472b496e1e1fbccc
References: <CGME20191022142726epcas3p4c09cde8944f5e8f1472b496e1e1fbccc@epcas3p4.samsung.com>
        <20191022142703.1789898-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Arnd,

On 19. 10. 22. 오후 11:26, Arnd Bergmann wrote:
> Putting a 'struct devfreq_event_dev' object on the stack is generally
> a bad idea and here it leads to a warnig about potential stack overflow:
> 
> drivers/devfreq/event/exynos-ppmu.c:643:12: error: stack frame size of 1040 bytes in function 'exynos_ppmu_probe' [-Werror,-Wframe-larger-than=]
> 
> There is no real need for the device structure, only the string inside
> it, so add an internal helper function that simply takes the string
> as its argument and remove the device structure.
> 
> Fixes: 1dd62c66d345 ("PM / devfreq: events: extend events by type of counted data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 87b42055e6bc..302e466549d3 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -101,17 +101,22 @@ static struct __exynos_ppmu_events {
>  	PPMU_EVENT(dmc1_1),
>  };
>  
> -static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
> +static int __exynos_ppmu_find_ppmu_id(const char *edev_name)
>  {
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(ppmu_events); i++)
> -		if (!strcmp(edev->desc->name, ppmu_events[i].name))
> +		if (!strcmp(edev_name, ppmu_events[i].name))
>  			return ppmu_events[i].id;
>  
>  	return -EINVAL;
>  }
>  
> +static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
> +{
> +	return __exynos_ppmu_find_ppmu_id(edev->desc->name);
> +}
> +
>  /*
>   * The devfreq-event ops structure for PPMU v1.1
>   */
> @@ -556,13 +561,11 @@ static int of_get_devfreq_events(struct device_node *np,
>  			 * use default if not.
>  			 */
>  			if (info->ppmu_type == EXYNOS_TYPE_PPMU_V2) {
> -				struct devfreq_event_dev edev;
>  				int id;
>  				/* Not all registers take the same value for
>  				 * read+write data count.
>  				 */
> -				edev.desc = &desc[j];
> -				id = exynos_ppmu_find_ppmu_id(&edev);
> +				id = __exynos_ppmu_find_ppmu_id(desc->name);

I got that the original exynos_ppmu_find_ppmu_id() function
has the bug. If 'events' node contains the one more events,
it will be failed. Because 'events' node only contained
the only one event on device-tree node on real use-case,
the problem had not happened.

'desc' indicates the array. So, instead of desc->name,
have to use 'desc[j].name correctly. 

And I'll fix the fundamental bug on separate patch.

>  
>  				switch (id) {
>  				case PPMU_PMNCNT0:
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
