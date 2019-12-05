Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2222113F69
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfLEKdP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:33:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54520 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfLEKdO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 05:33:14 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191205103311euoutp02958ac88ebdf21c2c67aa8995108534f5~dcxgRiBgf2402724027euoutp02H
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 10:33:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191205103311euoutp02958ac88ebdf21c2c67aa8995108534f5~dcxgRiBgf2402724027euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575541991;
        bh=i705saemL8w3+vhV1T23VKV+cVTTgAz1xjunX2yQW9A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=A5TjrQ95P+Xh/un+7gBCi9nQG6oy7Xd9fG4D1XVZpURUEddNBZUsMpZ9wguk/CjuO
         a4sunsOSc3U+jaAD8SxBDPsENzftNcI4qWWNEpR7F9+KxVcIdOdcusm9PLGCYQ59dE
         3shCs0Yi4cpxMNjnuWPFEY1rQEFSHbFBQ2knW4Aw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191205103311eucas1p12fc6f5b377ceda3eb5baff9c6c3b69eb~dcxgALpG91574315743eucas1p1s;
        Thu,  5 Dec 2019 10:33:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6E.C2.60679.7ECD8ED5; Thu,  5
        Dec 2019 10:33:11 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191205103311eucas1p18c923b70d7e9f69de22614b65e7de944~dcxfhS_Sn2937829378eucas1p1L;
        Thu,  5 Dec 2019 10:33:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205103311eusmtrp14478bb296fafdf69a420181f8b1ce1ba~dcxfgnf0L1352313523eusmtrp1R;
        Thu,  5 Dec 2019 10:33:11 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-61-5de8dce7a9d8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 80.6A.07950.6ECD8ED5; Thu,  5
        Dec 2019 10:33:10 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205103310eusmtip2fe68c8049c093c1cd281b77a7e1ac5bf~dcxfI5XBc1464414644eusmtip2R;
        Thu,  5 Dec 2019 10:33:10 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] devfreq: add clearing transitions stats
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <2ca32866-e1f6-afcf-2700-89208587c19e@samsung.com>
Date:   Thu, 5 Dec 2019 11:33:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e707f735-49d0-44dc-a7c3-586ee6563cbe@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7rP77yINfi3Q8Fi44z1rBbXvzxn
        tTh/fgO7xdmmN+wWl3fNYbP43HuE0WLtkbvsFrcbV7A5cHhsWtXJ5tG3ZRWjx+dNcgHMUVw2
        Kak5mWWpRfp2CVwZC7f/YC9YIFXxc8Nk5gbG7SJdjJwcEgImEo/+f2HsYuTiEBJYwShx8s9p
        NgjnC6PE9+93mCCcz4wSdzZOYYVpOXb6FwtEYjmjxMMDS6Gct4wSS5ZMYQGpEhZwlpjXMoMZ
        xBYR0JCY+fcK2BJmgXlMEm+mXQAbxSagL3Hw7EmwBl4BO4mWyRfZQWwWARWJXVu6gJo5OEQF
        IiROf02EKBGUODnzCVg5p4C9xPop3WA2s4C4xK0n85kgbHmJ7W/nMIPskhBYxy7R/usy1Nku
        EnNP7oKyhSVeHd/CDmHLSJye3MMCYZdLPF3Yxw7R3MIo8aD9I1TCWuLw8YusIAcxC2hKrN+l
        DxF2lFj2YQ8TSFhCgE/ixltBiBv4JCZtm84MEeaV6GgTgqhWlXh+qocJwpaW6Pq/jnUCo9Is
        JJ/NQvLNLCTfzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg6jn97/iXHYy7
        /iQdYhTgYFTi4W3Y9DxWiDWxrLgy9xCjBAezkgjvNomnsUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5qxkeRAsJpCeWpGanphakFsFkmTg4pRoYe03WHc7pbpapbrOxPhJfxHBH0YnP0fRHyDOh
        uGzWJ8rVXmednJp1itTNXd7lmrvf1+K/48t686KkWfvbkrIN5nl7N2aeONZxYvLJ+SfNVmg5
        vVji7R7msKuilEXOe++yh1yy7XkWczdvt9yyOJZpi8VfT9b5ZZYbyn0Vvyz0vMc28WtYeooS
        S3FGoqEWc1FxIgCmFEgfOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7rP7ryINXh/3MZi44z1rBbXvzxn
        tTh/fgO7xdmmN+wWl3fNYbP43HuE0WLtkbvsFrcbV7A5cHhsWtXJ5tG3ZRWjx+dNcgHMUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZC7f/YC9Y
        IFXxc8Nk5gbG7SJdjJwcEgImEsdO/2IBsYUEljJKLDqQCBGXlmg8vZoJwhaW+HOti62LkQuo
        5jWjxKM398ASwgLOEvNaZjCD2CICGhIz/15hBCliFljAJDH/5kQWiI5vjBL39y9hBaliE9CX
        OHj2JNg6XgE7iZbJF9lBbBYBFYldW7rAJokKREg8336DEaJGUOLkzCdg9ZwC9hLrp3SD2cwC
        6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6
        xYm5xaV56XrJ+bmbGIHRtu3Yzy07GLveBR9iFOBgVOLhbdj0PFaINbGsuDL3EKMEB7OSCO82
        iaexQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTAR5JfGGpobmFpaG5sbmxmYWSuK8HQIH
        Y4QE0hNLUrNTUwtSi2D6mDg4pRoYXUIC17MvkFo8ncNDqj4v8Gp47sQJERYCvml2+w7NcxHk
        9hc8J1E59egljYrySwdvt7fKWix0Z5mw6/L02c2CDKlNyof6JT2EjhmI6Bf+iH3s+vPSzH9p
        igfKU3jTz0/2vHGE+4jkCqvMz0wbHs07tv+3jdrTO8fYb9dK2ZqwnvFt4kywtKpRYinOSDTU
        Yi4qTgQAiOiLwcwCAAA=
X-CMS-MailID: 20191205103311eucas1p18c923b70d7e9f69de22614b65e7de944
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10@eucas1p1.samsung.com>
        <20191204150018.5234-3-k.konieczny@samsung.com>
        <e707f735-49d0-44dc-a7c3-586ee6563cbe@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 05.12.2019 01:38, Chanwoo Choi wrote:
> On 12/5/19 12:00 AM, Kamil Konieczny wrote:
>> Add clearing transition table and time in states devfreq statistics
>> by writing to trans_stat file in devfreq sysfs.
> 
> Have to add command example how to reset the trans_stat via sysfs
> on patch description.
> 
> And, have to add how to do it on documentation file as following:
> On next version, please contain the following modification with this patch.
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 75897e2fde43..c172ff838643 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -60,7 +60,10 @@ Description:
>                 the number of transitions between states.
>                 In order to activate this ABI, the devfreq target device
>                 driver should provide the list of available frequencies
> -               with its profile.
> +               with its profile. If need to reset the statistics of devfreq
> +               behavior on a specific device, enter 0(zero) to 'trans_stat'
> +               as following:
> +                       echo 0 > /sys/class/devfreq/.../trans_stat
>  
>  What:          /sys/class/devfreq/.../userspace/set_freq
>  Date:          September 2011

Thank you for spotting this and giving patch, I will include it with v3.

>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> ---
>> Changes in v2:
>>  instead of creating new sysfs file, add new functionality to trans_stat
>>  and clear stats when anything is writen to it
>>
>>  drivers/devfreq/devfreq.c | 22 +++++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0e2030403e4a..901af3b66a76 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1478,7 +1478,27 @@ static ssize_t trans_stat_show(struct device *dev,
>>  					devfreq->total_trans);
>>  	return len;
>>  }
>> -static DEVICE_ATTR_RO(trans_stat);
>> +
>> +static ssize_t trans_stat_store(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf, size_t count)
>> +{
>> +	struct devfreq *df = to_devfreq(dev);
>> +	unsigned int cnt = df->profile->max_state;
>> +
 
> Why don't you check the input value is whether value is 0(zero) or not?

I will follow your suggestion as this will help to avoid misuse

> If user enter the any value to 'trans_stat', devfreq core
> reset the statistics data. I want to decide the fixed value
> for the reset as following:
> 
> 	echo 0 > /sys/class/devfreq/devfreqX/trans_stat
> 

Thank you, I will add it to commit description.

>> +	if (cnt == 0)
>> +		return count;
>> +
>> +	mutex_lock(&df->lock);
>> +	memset(df->time_in_state, 0, cnt * sizeof(u64));
>> +	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
>> +	df->last_stat_updated = get_jiffies_64();
>> +	df->total_trans = 0;
>> +	mutex_unlock(&df->lock);
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_RW(trans_stat);
>>  
>>  static struct attribute *devfreq_attrs[] = {
>>  	&dev_attr_name.attr,

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

