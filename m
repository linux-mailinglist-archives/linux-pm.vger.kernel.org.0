Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAAE29566B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 04:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411762AbgJVCcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 22:32:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21863 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443033AbgJVCcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 22:32:24 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201022023220epoutp02ad703b539b59e1561365f52080e8dc31~AL7l0qdZc3126231262epoutp02P
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 02:32:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201022023220epoutp02ad703b539b59e1561365f52080e8dc31~AL7l0qdZc3126231262epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603333940;
        bh=SqBzh37QiR1i4Cy2nyt9C03pMst8sC3TvDU3I/4gOD0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oKhw357fqcCkm8x0hxGaDM2DqjxogXbAh50+ssz5fxu6+myi0KvJGQHIYY7Ws4ZYx
         2Rpnwr5tLTsOnlSShqLEco9Awonvbiefzu90F1ysm02nqtSoTeOQy7h49EzHEUdT8l
         gzG5qZOATbSqc0hdMXYuSQSYMX8Rl5DdiCepSF9g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201022023220epcas1p2cfd5b39afb14de4ec020806a08015abf~AL7lAw_DJ0996709967epcas1p2U;
        Thu, 22 Oct 2020 02:32:20 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CGrwx4BB2zMqYkZ; Thu, 22 Oct
        2020 02:32:17 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.50.09918.13FE09F5; Thu, 22 Oct 2020 11:32:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201022023216epcas1p3d05f4780732aee6454a1b29131742f20~AL7iH4MIB2113321133epcas1p3H;
        Thu, 22 Oct 2020 02:32:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201022023216epsmtrp11cb95ebdb731f7891fc68609882a619e~AL7iG6r9Y2255122551epsmtrp1O;
        Thu, 22 Oct 2020 02:32:16 +0000 (GMT)
X-AuditID: b6c32a36-713ff700000026be-65-5f90ef3133ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.76.08745.03FE09F5; Thu, 22 Oct 2020 11:32:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201022023216epsmtip28eaea78d354bd553299549f3daab5f44~AL7hze6Q52436824368epsmtip2j;
        Thu, 22 Oct 2020 02:32:16 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     lukasz.luba@arm.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        abel.vesa@nxp.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7ee9dcd8-f326-0bc4-25ba-8f58f22d692c@samsung.com>
Date:   Thu, 22 Oct 2020 11:45:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <b94b5c9d-6bfc-0535-baaf-d0809f74de42@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmvq7h+wnxBp93S1ssu3SU0WLjjPWs
        FhNvXGGxWP3xMaPFmtuHGC1+bDjFbNEyaxGLxYJPM1gtzja9Ybe4vGsOm8Xn3iOMFp1fZrFZ
        LGxqYbe43biCzeLnrnksDvwea+atYfTYcXcJo8fOWXfZPTat6mTz6G1+x+ax8d0OJo+/s/az
        ePRtWcXo8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtALSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k
        /FwrQwMDI1OgwoTsjGeNb5gKJrJV7Lh4gb2B8Q5LFyMnh4SAiUTDipfMXYxcHEICOxglWmZv
        YYdwPjFK/G5axgxSJSTwmVHi+FsOmI77Rw5BdexilJgwdysThPOeUWLF23VsIFXCAvESTycd
        ZwSxRQRqJY5cfMAGUsQs0MskMW3PUiaQBJuAlsT+FzfAGvgFFCWu/ngM1sArYCex8vIRsDiL
        gKrEnp+NYMeKCoRJnNzWAlUjKHFy5hOgOAcHp4CtRE+3BEiYWUBc4taT+UwQtrxE89bZYJdK
        CHzhkHh97AMTxAsuEs/XfGWDsIUlXh0H+RnElpJ42d8GZVdLrDx5hA2iuYNRYsv+C6wQCWOJ
        /UsnM4EsZhbQlFi/Sx8irCix8/dcRojFfBLvvvawgpRICPBKdLQJQZQoS1x+cBfqBEmJxe2d
        bBMYlWYh+WYWkhdmIXlhFsKyBYwsqxjFUguKc9NTiw0LjJBjexMjOHlrme1gnPT2g94hRiYO
        xkOMEhzMSiK8eaIT4oV4UxIrq1KL8uOLSnNSiw8xmgLDdyKzlGhyPjB/5JXEG5oaGRsbW5gY
        mpkaGiqJ8/7R7ogXEkhPLEnNTk0tSC2C6WPi4JRqYMpcGO50sEPp4vw7vkGNzXcDnqdKrYvx
        WzDhls0u9o2ipz6u1nQv1DDwXrT8SXFe2aR5dm1+3xNv/NDPeWkTmLnb+8+vpfkXfpxO/2HS
        eynI7Vq1NbuGzv3JHCo/t0a1sq0rdXy97suKR8+f/Bc8bHHhe8iEyw0mkbnXL9sl1PV8OLS8
        4GLzOcfmW/NiJ5XPatjk4uldtVSGz3f1e7c9fCs7TwjvYbSQ7lEXesJw9XXsafH/QgFHmU9m
        /BQMk+nzmcivnuamKqBfH8dTdPTK/xj2TVH+N/P2TknUNRRV006OsXh04sKurwkWHlN/TP3k
        fC3q7iw/S6u3F0JNYxj/qlZtXaNxYYnGr6/s2XwxykosxRmJhlrMRcWJABUmVRVnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSvK7B+wnxBuf6jCyWXTrKaLFxxnpW
        i4k3rrBYrP74mNFize1DjBY/NpxitmiZtYjFYsGnGawWZ5vesFtc3jWHzeJz7xFGi84vs9gs
        Fja1sFvcblzBZvFz1zwWB36PNfPWMHrsuLuE0WPnrLvsHptWdbJ59Da/Y/PY+G4Hk8ffWftZ
        PPq2rGL0+LxJLoAzissmJTUnsyy1SN8ugSvjWeMbpoKJbBU7Ll5gb2C8w9LFyMkhIWAicf/I
        IeYuRi4OIYEdjBItb0+wQiQkJaZdPAqU4ACyhSUOHy6GqHnLKLHq9GImkBphgXiJp5OOM4LY
        IgK1Eq9WT2cFKWIW6GWS6Nq1F2yQkMAnRon97aEgNpuAlsT+FzfYQGx+AUWJqz8egzXzCthJ
        rLx8BCzOIqAqsednI9h1ogJhEjuXPGaCqBGUODnzCQvIQZwCthI93RIgYWYBdYk/8y4xQ9ji
        EreezGeCsOUlmrfOZp7AKDwLSfcsJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5x
        aV66XnJ+7iZGcBRrae1g3LPqg94hRiYOxkOMEhzMSiK8eaIT4oV4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzfp21ME5IID2xJDU7NbUgtQgmy8TBKdXA5Bb481fmq3vO0t75FvWnWn6zCi2t2t+3
        +aqCPNORCbmO1R7X057wujKq905cEzn/nG2gQV7N4QXBmleePMiJjU+YrXR/Zm78kvS1SiIi
        ip2mCuaMiQuXND3i3RetU/pem3+fr+AT1kbj8Ihek90yZpKFLC++KfHw+i+UXNg78dZEtx3l
        W5XC3ONLmRV02K/ym91eWfN+n8VzpikuU17/eDX97JGd1lsn1jQ/iOmvFQh+WpYtrFaU9XPB
        rejq9/ZrOh2FC6a3LdK/+HvXlVeJk5hNg4PTN948aTLRv/yOgU7d7Y5qxTr3+7t2V4dXvFoz
        286rn3XiLMdTRwOFV2aoTFsTLc06g+3xo+uHA9iVWIozEg21mIuKEwHRJADKUQMAAA==
X-CMS-MailID: 20201022023216epcas1p3d05f4780732aee6454a1b29131742f20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21
References: <20201020030407.21047-1-cw00.choi@samsung.com>
        <CGME20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21@epcas1p4.samsung.com>
        <20201020030407.21047-3-cw00.choi@samsung.com>
        <b94b5c9d-6bfc-0535-baaf-d0809f74de42@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/22/20 11:30 AM, Dmitry Osipenko wrote:
> 20.10.2020 06:04, Chanwoo Choi пишет:
>>  /**
>>   * struct devfreq_governor - Devfreq policy governor
>>   * @node:		list node - contains registered devfreq governors
>>   * @name:		Governor's name
>> + * @attr:		Governor's sysfs attribute flag
>>   * @flags:		Governor's feature flags
>>   * @get_target_freq:	Returns desired operating frequency for the device.
>>   *			Basically, get_target_freq will run
>> @@ -57,6 +68,7 @@ struct devfreq_governor {
>>  	struct list_head node;
>>  
>>  	const char name[DEVFREQ_NAME_LEN];
>> +	const u64 attr;
>>  	const u64 flags;
> 
> What about to use plural for the "attrs" as well?
> 
> 

OK. I'll edit it.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
