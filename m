Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE84C11389B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 01:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfLEAVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 19:21:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:17884 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfLEAVJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 19:21:09 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191205002105epoutp0405244c4e749a8e10612e97928fab9910~dUbEZ_7P62134221342epoutp043
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 00:21:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191205002105epoutp0405244c4e749a8e10612e97928fab9910~dUbEZ_7P62134221342epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575505265;
        bh=aRUuMrHlQQDwAmmmhmUQinAQVsf5nnrqlN834n7/lwo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AjT1fPN5T6cLCE+hXnWwaZUck9Y/2V0fvfmdhS7YYex56N/6tQEoIDNQdLnaKpQme
         zmf9AWZDwAQG8lwXIHWnMULOdNcpYPKg+X+KkBS3Sk+6lpWAHI4GKQUiqIVJHUeNkU
         Zss5ort/At0cghTkVT/40L5z/NMQf1Ms80lr0E6g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191205002105epcas1p28b1b2ca77cb68647f068e7bbd8e79b7f~dUbD8Gi3B0491804918epcas1p2H;
        Thu,  5 Dec 2019 00:21:05 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47SxG44GVwzMqYly; Thu,  5 Dec
        2019 00:21:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.33.57028.76D48ED5; Thu,  5 Dec 2019 09:20:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191205002054epcas1p46063b2d9d385ecbe30d86036a221eaa6~dUa6IO69d3207332073epcas1p4L;
        Thu,  5 Dec 2019 00:20:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205002054epsmtrp120a94ed51d592e5d4de6c7118f38ccf5~dUa6HLDlP1774817748epsmtrp1G;
        Thu,  5 Dec 2019 00:20:54 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-79-5de84d67c6e5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.58.10238.66D48ED5; Thu,  5 Dec 2019 09:20:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191205002054epsmtip1e7a47fc6b1a21978b10bea41149ade4f~dUa56OkBa2276922769epsmtip1B;
        Thu,  5 Dec 2019 00:20:54 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] devfreq: change time stats to 64-bit
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0fd243ee-001e-a93a-3421-3e3c82947f11@samsung.com>
Date:   Thu, 5 Dec 2019 09:27:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191204150018.5234-2-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmrm6674tYg47zbBYbZ6xntVjwaQar
        xfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3uN24gs2Bw2PTqk42j74tqxg9Pm+SC2COyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdsfPg
        bKaC21IV7z//Z2pgvCPaxcjJISFgInH0eA8LiC0ksINRYt7+wC5GLiD7E6NE464t7BDON0aJ
        G5MWsMB0TF+4iwUisZdR4sGBqawQ7e8ZJX7uEAaxhQUcJCa9fssMYosI6Eq82bGUGaSBWWAe
        k8SbaRfAGtgEtCT2v7jBBmLzCyhKXP3xmBHE5hWwk5iz5C6YzSKgIjHj+j2wQaICYRInt7VA
        1QhKnJz5BOwiTgEbieOP9oHVMAuIS9x6Mp8JwpaX2P52DthiCYHXbBIdV6YwQrzgInHm+1Ko
        d4QlXh0H+RPElpJ42d8GZVdLrDx5hA2iuYNRYst+iKslBIwl9i+dDLSBA2iDpsT6XfoQYUWJ
        nb/nMkIs5pN497WHFaREQoBXoqNNCKJEWeLyg7tMELakxOL2TrYJjEqzkLwzC8kLs5C8MAth
        2QJGllWMYqkFxbnpqcWGBYbIsb2JEZw6tUx3ME4553OIUYCDUYmHt2HT81gh1sSy4srcQ4wS
        HMxKIrzbJJ7GCvGmJFZWpRblxxeV5qQWH2I0BYb2RGYp0eR8YFrPK4k3NDUyNja2MDE0MzU0
        VBLn5fhxMVZIID2xJDU7NbUgtQimj4mDU6qBUXx91blJ1na2H1aoMjv3mnprf/SNnnhqRZ3c
        o8mWM2NPTbjxVa9ILUK87siL6yt+qmtk2LpKv7NN/vvsbNLiDPHLL+xOe6wVLvl6NHhezTq1
        jfq+Hao7bupE5wapuq6R0vL/f8r+0E+rYrZbcZFRkX8rF9yrr1g9pXqKjNEmpeCazPjj9c4a
        SizFGYmGWsxFxYkAMizysrMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTjfN90Wswa9NyhYbZ6xntVjwaQar
        xfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3uN24gs2Bw2PTqk42j74tqxg9Pm+SC2CO4rJJ
        Sc3JLEst0rdL4MrYeXA2U8FtqYr3n/8zNTDeEe1i5OSQEDCRmL5wF0sXIxeHkMBuRonX11cz
        QyQkJaZdPApkcwDZwhKHDxdD1LxllOhc2soIUiMs4CAx6fVbsHoRAV2JNzuWMoMUMQssYJKY
        f3Mi1NSDjBLrH39nBaliE9CS2P/iBhuIzS+gKHH1x2OwSbwCdhJzltwFs1kEVCRmXL8HNlVU
        IExi55LHTBA1ghInZz5hAbE5BWwkjj/aB1bDLKAu8WfeJShbXOLWk/lMELa8xPa3c5gnMArP
        QtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxHWpo7GC8v
        iT/EKMDBqMTD27DpeawQa2JZcWXuIUYJDmYlEd5tEk9jhXhTEiurUovy44tKc1KLDzFKc7Ao
        ifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamBMT/7K8/lFrZDFF2c2tYSPj1cV7W389Z6JvT+e
        VWNBimD4me25HboSbx3WyS/2MXuisMZaNn/C4R6Bh7z70768YO/+962tn+1Ch1HyxUy1rO2P
        ZJQs1hsl3Ne7ce1RqE9n1fnH3Yl3r2hul04pWlGfPynb6+J7hsstMwU2H2lj2aNg+e+X9SMl
        luKMREMt5qLiRAAiDxBbnwIAAA==
X-CMS-MailID: 20191205002054epcas1p46063b2d9d385ecbe30d86036a221eaa6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988@eucas1p1.samsung.com>
        <20191204150018.5234-2-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/5/19 12:00 AM, Kamil Konieczny wrote:
> Change time stats counting to bigger type by using 64-bit jiffies.
> This will make devfreq stats code look similar to cpufreq stats and
> prevents overflow (for HZ = 1000 after 49.7 days).
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes in v2:
>  added Acked-by, rebased on linux-next
> 
>  drivers/devfreq/devfreq.c | 14 +++++++-------
>  include/linux/devfreq.h   |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bdeb4189c978..0e2030403e4a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -199,10 +199,10 @@ static int set_freq_table(struct devfreq *devfreq)
>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int lev, prev_lev, ret = 0;
> -	unsigned long cur_time;
> +	unsigned long long cur_time;

It looks better to use 'u64' instead of 'unsigned long long'.
Because get_jiffies_u64 has 'u64' return type.

>  
>  	lockdep_assert_held(&devfreq->lock);
> -	cur_time = jiffies;
> +	cur_time = get_jiffies_64();
>  
>  	/* Immediately exit if previous_freq is not initialized yet. */
>  	if (!devfreq->previous_freq)
> @@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  out_update:
> -	devfreq->last_stat_updated = jiffies;
> +	devfreq->last_stat_updated = get_jiffies_64();
>  	devfreq->stop_polling = false;
>  
>  	if (devfreq->profile->get_cur_freq &&
> @@ -748,7 +748,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>  			devfreq->profile->max_state,
> -			sizeof(unsigned long),
> +			sizeof(*devfreq->time_in_state),
>  			GFP_KERNEL);
>  	if (!devfreq->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
> @@ -756,7 +756,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->last_stat_updated = jiffies;
> +	devfreq->last_stat_updated = get_jiffies_64();
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1470,8 +1470,8 @@ static ssize_t trans_stat_show(struct device *dev,
>  		for (j = 0; j < max_state; j++)
>  			len += sprintf(buf + len, "%10u",
>  				devfreq->trans_table[(i * max_state) + j]);
> -		len += sprintf(buf + len, "%10u\n",
> -			jiffies_to_msecs(devfreq->time_in_state[i]));
> +		len += sprintf(buf + len, "%10llu\n", (u64)
> +			jiffies64_to_msecs(devfreq->time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2bae9ed3c783..b81a86e47fb9 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -174,8 +174,8 @@ struct devfreq {
>  	/* information for device frequency transition */
>  	unsigned int total_trans;
>  	unsigned int *trans_table;
> -	unsigned long *time_in_state;
> -	unsigned long last_stat_updated;
> +	u64 *time_in_state;
> +	unsigned long long last_stat_updated;

ditto. 'unsigned long long' -> 'u64'.

>  
>  	struct srcu_notifier_head transition_notifier_list;
>  };
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
