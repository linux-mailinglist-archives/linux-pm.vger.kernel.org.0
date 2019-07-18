Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A256CC97
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 12:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbfGRKMv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 06:12:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61936 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfGRKMu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 06:12:50 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190718101248epoutp03fd5837e7c14a26b3c9f65268d5419498~yeLvITm780679806798epoutp036
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 10:12:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190718101248epoutp03fd5837e7c14a26b3c9f65268d5419498~yeLvITm780679806798epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563444768;
        bh=q4AXsxwgMmz4VppU+8iLi0hu4RYhX6p529VJi7RbIZU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BKPRh6K0onYxUbR8CVZA/tFeZPBLLHtPcctFsm9kBdAnHDfVupWdIBh4Yeyl6LdWU
         9tFDHteUznV0I1ZkgJPXSD9w+cxw1dcRHZdOin0692iKR2k0cT+mLGQ7CMjfJLoU/C
         ML1MjxU0LVVYqVuq4zUo6yGm631/YzCfF1pNbIw8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718101247epcas1p151d08aa422c4dfc14aa9a89611c4d263~yeLubwvz70692106921epcas1p1E;
        Thu, 18 Jul 2019 10:12:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45q91T46d0zMqYkW; Thu, 18 Jul
        2019 10:12:45 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.9E.04088.D16403D5; Thu, 18 Jul 2019 19:12:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718101244epcas1p19776ec41c724caf6b2090bf70ff83643~yeLrw12G61389513895epcas1p1W;
        Thu, 18 Jul 2019 10:12:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718101244epsmtrp2ee7f5027edea51a1b27eacc550474333~yeLrv_0l42324823248epsmtrp2R;
        Thu, 18 Jul 2019 10:12:44 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-4c-5d30461d3416
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.9E.03706.C16403D5; Thu, 18 Jul 2019 19:12:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718101244epsmtip1716dd067dec0d5971c04508765c8957e~yeLriFFUV0387303873epsmtip1w;
        Thu, 18 Jul 2019 10:12:44 +0000 (GMT)
Subject: Re: [PATCH v4 21/24] PM / devfreq: tegra30: Synchronize average
 count on target's update
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
Message-ID: <f83fb873-9214-9649-9435-9f211c4cba9e@samsung.com>
Date:   Thu, 18 Jul 2019 19:15:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-22-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2+XsrFx9TstXo9Jj/pg1t9OcnUKji8S6/JAu0gWxgzs4c7d2
        ZqlFeMtUUiy7rtKwC6mUJBY6EsOMWGVFUlhiJAZdCMO0aCnatmPkv+d93+f53uf5vo8UK5uJ
        CDLL6uQcVtZMEbMl9x6q1OpFG7Vp2orBKKZpZAgxJa56CdNT9E3G9LovEcxoZTdiysdcBNNf
        eJNgvO5aCVN16xWxVm5oG7iGDO2uAZmhsniYMFS1NiLDaMviFOme7EQTxxo5RyRnzbAZs6yZ
        SdSW7ekb0vUJWlpNr2JWUpFW1sIlUclbU9Qbs8w+Q1TkQdac42ulsDxPadYkOmw5Ti7SZOOd
        SRRnN5rtq+xxPGvhc6yZcRk2y2paq12h9xH3ZZvOjnll9j+hucV9baIC5MUVSE4Cjgd39ThR
        gWaTStyGoGPyjEgofiAorTkrE4pfCMbeX5L8kzyo80xLOhDcL62S+gdK/B3BnXLej0NwBoxV
        vpX6SaF4EkG5t5jwD8R4NzxsbxL5MYFjofNzX6A/D0fB699DqAKRpAKvgXODAYoEx8CrU80B
        yny8C5501wZMKHAweC58DGA5ToBzt6unjw+Ddx/rRAJeAsV3L4r9HgBPEfDC2yASEiSDp7RD
        LOAQ+Pq4VSbgCBgd7iAEfBgaPN2EIC5D0Nr5UioMdNB5vUbkNyrGKmh2a4R2FLSPX0bC4rkw
        /POE1E8BrICyUqVAiYbeDwPTFsLh6vFyohpRrhlxXDMiuGZEcP1fdgVJGtECzs5bMjmettMz
        X7sFBT5rrL4NnX6+tQthElFBij5Kk6aUsgf5PEsXAlJMhSr6v/haCiObl885bOmOHDPHdyG9
        77ZPiiPmZ9h8X9/qTKf1K3Q6HRNPJ+hpmgpT1E6o0pQ4k3Vy2Rxn5xz/dCJSHlGAlo+q6OBD
        dbrU1KkjonXKJ+FefWHZjp7zIab6TTHrVRNRc6b23Wiqib5VUvlzwjx0N3qnLmjWd/2BZws1
        eY8WDJB7ndHucfP6L0dGutu3vGnm315o0PR+WHgspmmvI/Focmf/lR+f7hmfPvulzj+Wu3Rz
        3bKS+KOzWrYVDS7fGePZL5dTEt7E0rFiB8/+BYxCO4XCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnK6Mm0GswcbDRharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ0778ZC/4JVLRfGMHUwPjT4EuRk4OCQETiQPz
        T7J1MXJxCAnsZpT4ffweC0RCUmLaxaPMXYwcQLawxOHDxRA1bxklni7YzA5SIyyQLLH14Gpm
        kISIQBOTxKbeC2AJZoFIiZ65W6CmbmGUODVnKiNIgk1AS2L/ixtsIDa/gKLE1R+PGUE28ArY
        SUx/yAQSZhFQlbg0aT1YiahAhMSkazvBDuIVEJQ4OfMJmM0pYCYxfd0ENohd6hJ/5l1ihrDF
        JW49mc8EYctLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
        0rx0veT83E2M4BjT0tzBeHlJ/CFGAQ5GJR7eG0r6sUKsiWXFlbmHGCU4mJVEeG+/BArxpiRW
        VqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAmLLC1PL/F54mzQXh
        GmxPBL6cTFf/KfcnUOm+p8gkk/VssUuMXk9vnpaezhus6H9eMeJimW/yq9424S6Ljd1Bx8wY
        fJhvrl0yL/qGf2raotj5uV2vK8vt5pZe3Z4m9lpr6/XLRg8ZWZIz1GcJ8bVlnvunUOvQ3LGv
        +9N7uWu2j/8xdfwzmuKrxFKckWioxVxUnAgAxfJ4Ra0CAAA=
X-CMS-MailID: 20190718101244epcas1p19776ec41c724caf6b2090bf70ff83643
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223619epcas4p3dea48e3e09983cd2a76af39fbf7bf99b
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223619epcas4p3dea48e3e09983cd2a76af39fbf7bf99b@epcas4p3.samsung.com>
        <20190707223303.6755-22-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:33, Dmitry Osipenko wrote:
> The average count may get out of sync if interrupt was disabled / avoided
> for a long time due to upper watermark optimization, hence it should be
> re-synced on each target's update to ensure that watermarks are set up
> correctly on EMC rate-change notification and that a correct frequency
> is selected for device.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 4d582809acb6..8a674fad26be 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -466,11 +466,41 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  			      dev->boost_freq, cpufreq_get(0));
>  }
>  
> +static void tegra_devfreq_sync_avg_count(struct tegra_devfreq *tegra,
> +					 struct tegra_devfreq_device *dev)
> +{
> +	u32 avg_count, avg_freq, old_upper, new_upper;
> +
> +	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
> +	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
> +
> +	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
> +	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
> +
> +	/* similar to ISR, see comments in actmon_isr_device() */
> +	if (old_upper != new_upper) {
> +		dev->avg_freq = avg_freq;
> +		dev->boost_freq = 0;
> +	}
> +}
> +
>  static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
>  					  struct tegra_devfreq_device *dev)
>  {
>  	unsigned long target_freq;
>  
> +	/*
> +	 * The avg_count / avg_freq is getting snapshoted on device's
> +	 * interrupt, but there are cases where actual value need to
> +	 * be utilized on target's update, like CPUFreq boosting and
> +	 * overriding the min freq via /sys/class/devfreq/devfreq0/min_freq
> +	 * because we're optimizing the upper watermark based on the
> +	 * actual EMC frequency. This means that interrupt may be
> +	 * inactive for a long time and thus making snapshoted value
> +	 * outdated.
> +	 */
> +	tegra_devfreq_sync_avg_count(tegra, dev);

I think that you don't need to add the separate function to calculate
the 'dev->avg_freq'. It is enough with your detailed comment to add
this code in this function.

> +
>  	target_freq = min(dev->avg_freq + dev->boost_freq, KHZ_MAX);
>  	target_freq = tegra_actmon_account_cpu_freq(tegra, dev, target_freq);
>  
> 

And also, is it impossible to squash this patch with patch19/patch20?

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
