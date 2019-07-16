Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395876A8B2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfGPM1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:27:39 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38516 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbfGPM1j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:27:39 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190716122736epoutp022cb603b71ba4b952d703f9b71d4b7854~x4u3QgRdv2102321023epoutp02v
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:27:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190716122736epoutp022cb603b71ba4b952d703f9b71d4b7854~x4u3QgRdv2102321023epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563280056;
        bh=013XDTRF+mOJtbNAez5L7T9XzgED0jQZoctMXo+/Qko=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JBQNAwEeR5ykcv6d5/+hdh+kEzK909i4wyB0C5BxJBuQyD4SwXCbmXoLQCCBF2U9j
         SRBTpuPbGl6YXCWfzopPkvihezaN/FNTNyaIO9W7N5nmPnxjI+D46doSvXcdzL2M5W
         tIoWJQxQoMnXPz6uLkfnO24N6CgVZG9HdWgyIlw4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716122735epcas1p2e201304de05226457450eeafa1e713f4~x4u2hg3UY0782407824epcas1p2J;
        Tue, 16 Jul 2019 12:27:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45p05x4THRzMqYkY; Tue, 16 Jul
        2019 12:27:33 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.21.04066.5B2CD2D5; Tue, 16 Jul 2019 21:27:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190716122733epcas1p3ed97b78a5ed263ac72b473db41493b96~x4uz6AcVn0402804028epcas1p3f;
        Tue, 16 Jul 2019 12:27:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716122733epsmtrp183416bda84f199ed5b5dde298a26e109~x4uz2kpNe0818508185epsmtrp1r;
        Tue, 16 Jul 2019 12:27:33 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-b8-5d2dc2b5159c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.5E.03706.4B2CD2D5; Tue, 16 Jul 2019 21:27:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716122732epsmtip257d53f68f19a4cfd3fb56e3be4e58d66~x4uzmN7e50877608776epsmtip2S;
        Tue, 16 Jul 2019 12:27:32 +0000 (GMT)
Subject: Re: [PATCH v4 14/24] PM / devfreq: tegra30: Ensure that target freq
 won't overflow
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e6b53ba0-ac98-bda6-b087-553088a43d9f@samsung.com>
Date:   Tue, 16 Jul 2019 21:30:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-15-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRDl626XLVpdK8rYiLZrjIJUWUpxNdSgENNEEIyJUZKCG7oC0ivd
        1vOPikFQwTMqVdCIJoDxwkKAiDWFRKqCJ2o0NRognvHEKx7Yshj592bezPfmzTckpjhPKMlC
        q5N3WDkzTUTgTe0xGk2jT2OML/utZs987EXsdvdJnO3a9jacvdd6jGA/l3cgtmzATbBPttYS
        7I/WapytOHuXSJEZmgOnkKHFHQg3lBe/IwwVnnpk+NwwJUuaXZRcwHMm3qHirXk2U6E1X08v
        WZ6bmqtLimc0zDx2Lq2ychZeT6elZ2kWF5qDA9GqdZzZFUxlcYJAz1mQ7LC5nLyqwCY49TRv
        N5nt8+yzBc4iuKz5s/NslvlMfHyCLli4uqig/Gsbbn9IbrhaFb0FVYbvRDISqES4NNhF7EQR
        pIJqRtAX2B8uBp8Q3PGek4rBVwTXawfQv5YTvuZhog3B/RcPkBi8R9B7MMTIyPGUEbbeLMVD
        RCT1B0HZj2IiRGDUKmhvOSMJYYKKBe/LR0P5sZQaer73DknIqQVwpenI0IQ4NR0O7erHQngC
        tRKud1TjYs048Ff2BTFJyqgk6PEvE5+Pgsd9xyUingrFjUex0AxADRJQd+w+IVpIg4bKKomI
        x8Pra57hbSjh1Z6SYbwZ6vwdhNhcisDjvS0VCS14Tx+QhIQxKgbOt84R02po+VmFROEx8O7L
        bmmoBCg5lJYoxJJpcO9ZYFh2EtTsKCP2Ito9wo17hAX3CAvu/2InEF6PJvJ2wZLPC4xdO/K3
        G9DQscbObUYXutN9iCIRPVreeTnOqJBy64SNFh8CEqMj5fovs4wKuYnbuIl32HIdLjMv+JAu
        uOx9mHJCni14+lZnLqNL0Gq1bCKTpGMYOkpe/SvGqKDyOSdfxPN23vGvT0LKlFuQ4MU6Uhuf
        7jlXE9aefXRhV+/kUSkf8p6v9c9QRJvq56+/EbA1LPIMZng6tQnaztFrz966uGbFjThcPTNq
        e+00j6Yxs25hX3fk4ZP9PyOUFbemvzGbv23DbWMedV9I7kmPVvtLrqYlZmzIUeWkLF3xqSfM
        5bfqU//EGI1hmQP9NQfjaFwo4JhYzCFwfwEI78drwgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO6WQ7qxBt33zCxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyer/tZSm4zlFxYK5sA+NM9i5GTg4JAROJBYd2
        sHYxcnEICexmlGi7s5MJIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBLf13wGaxYWiJVoPNPBApIQ
        EWhiktjUewEswSwQKdEzdwsbRMcWRokHm76ygiTYBLQk9r+4wQZi8wsoSlz98ZgRxOYVsJPY
        t20GWDOLgKrEtO6nzCC2qECExKRrO1kgagQlTs58wgJyEaeAmcTVk4EQu9Ql/sy7xAxhi0vc
        ejKfCcKWl2jeOpt5AqPwLCTds5C0zELSMgtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5xaV5
        6XrJ+bmbGMERpqW5g/HykvhDjAIcjEo8vB8O6MYKsSaWFVfmHmKU4GBWEuG1/aodK8SbklhZ
        lVqUH19UmpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVANjySkJt5LpizZ4un9V
        7POp/XbrmcwcryMrZC2fygh3rfz/NLaOm9mnTqJCZ84l7ys7XtxYac3K3GLBuUTCmem63v8p
        5983X8w6xb2D54/96V9Froa7Fqj+s4qe7TSj+z5LsGyxqMnBo1yyyVZ+nRN2G+m7G5v/62/+
        U1djciAn0Or/C7mvgkuUWIozEg21mIuKEwGN713wrAIAAA==
X-CMS-MailID: 20190716122733epcas1p3ed97b78a5ed263ac72b473db41493b96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223631epcas4p42012d0364a4c952d90f078fb45982722
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223631epcas4p42012d0364a4c952d90f078fb45982722@epcas4p4.samsung.com>
        <20190707223303.6755-15-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> Potentially very high boosting could cause an integer overflow for a
> highly clocked memory after conversion to MHz.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 2f59c78930bd..0de1efdaabf4 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -460,6 +460,7 @@ static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>  	unsigned long target_freq;
>  
>  	target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD + dev->boost_freq;
> +	target_freq = min(target_freq, ULONG_MAX / KHZ);

Did you meet this corner case?
If have to change it, you better to use 'tegra->max_freq' as following:
	min(target_freq, tegra->max_freq);

>  	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
>  
>  	return target_freq;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
