Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906D6BEA1D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 03:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389536AbfIZBbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 21:31:34 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:15879 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbfIZBbe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 21:31:34 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190926013130epoutp049cb8c5ad0bee47860d38495230fbcafb~H2OkatK-o3253632536epoutp04G
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 01:31:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190926013130epoutp049cb8c5ad0bee47860d38495230fbcafb~H2OkatK-o3253632536epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569461490;
        bh=H7dIy4NLJ0Vtiyy8JGjYV3SoJNF1jlpXFN42Cx87qDc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RYxrHJEfxavRVL74TZhStzp1M3v/kexRPRSkVkrwVdcc3Rli0TRLydxnMlzWTggMu
         APil17qJ3Sj+XDeku/SiEyIC8X8jyTEhLWhkqsZDHG56cyHIncbauk6cGbdL0e87Yb
         MuuVq8blmNZkztmkX5h0/3q9dBSwwvvy3gpwOVH0=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190926013130epcas1p434480b7b054308c3daa91f68e59e0203~H2Oj9hRqA1545815458epcas1p4j;
        Thu, 26 Sep 2019 01:31:30 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46dy7g5MxVzMqYkc; Thu, 26 Sep
        2019 01:31:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.05.04068.AE41C8D5; Thu, 26 Sep 2019 10:31:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190926013122epcas1p1dcdbefd63f655e8082d138064c09e9dd~H2OcdAG4O2486724867epcas1p1B;
        Thu, 26 Sep 2019 01:31:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190926013122epsmtrp1664d228cded2bcb996429c2f343c14fe~H2OccJ9l43098130981epsmtrp18;
        Thu, 26 Sep 2019 01:31:22 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-35-5d8c14ea9a2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.41.04081.AE41C8D5; Thu, 26 Sep 2019 10:31:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190926013122epsmtip1910ffa9271d525d0209975049806c252~H2OcPcUkN2250222502epsmtip1B;
        Thu, 26 Sep 2019 01:31:22 +0000 (GMT)
Subject: Re: [PATCH 1/2] devfreq: Rename devfreq_update_status() to
 devfreq_update_stats() and viceversa
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3fb18474-b31e-bc7e-8b6a-660904a19443@samsung.com>
Date:   Thu, 26 Sep 2019 10:36:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925184314.30251-1-mka@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmge4rkZ5Yg9uL1CzOLjvIZtEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i0sHFjBZfN7wmNHiduMKNot9HQ+YLH7umsfiwO0xu+Ei
        i8fOWXfZPVr23WL36G1+x+bxft9VNo++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6UkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
        X1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnfH7zGzmggV6Fc9bzjA1MB5X62Lk
        4JAQMJGY98S6i5GLQ0hgB6NEx/+PTF2MnEDOJ0aJe689IRLfGCUWzZ3CDpIAaWjb+pUZIrGX
        UeLuktnsEM57RombE5sYQaqEBbIkWrZOAUuICMxlkui5NxXMYRZoZpS4tHou2BI2AS2J/S9u
        sIHY/AKKEld/PGYEOYpXwE6i4ZUASJhFQFXiUv9EsNWiAhESnx4cZgWxeQUEJU7OfMICYnMK
        mEl83XsUbAyzgLjErSfzmSBseYnmrbPBTpUQWMYucb5tOdQPLhK/pi1kgrCFJV4d3wIVl5J4
        2d8GZVdLrDx5hA2iuYNRYsv+C6wQCWOJ/UsnM4EcyiygKbF+lz5EWFFi5++5jBCL+STefe1h
        hQQwr0RHmxBEibLE5Qd3odZKSixu72SbwKg0C8k7s5C8MAvJC7MQli1gZFnFKJZaUJybnlps
        WGCKHNubGMEJWMtyB+Oxcz6HGAU4GJV4eCUiu2OFWBPLiitzDzFKcDArifDOkumKFeJNSays
        Si3Kjy8qzUktPsRoCgzticxSosn5wOyQVxJvaGpkbGxsYWJoZmpoqCTO65HeECskkJ5Ykpqd
        mlqQWgTTx8TBKdXAuMX4eaDcgnmVG/Lkn6nw+QU9fio0+/HJtQp/fseuyZ3CzuZxL8e9W9nu
        euCVkNz+3YrT1pfpnZm8/rj+9B8zODgEt622++cS+FQySFzpwUOji9Ip3pue3L6sprWjfQLz
        vFonvqL3Ub6aVxrPrxVwjbdfb2L50ddR93TEM7GWinc8XydK//s2TYmlOCPRUIu5qDgRAI8D
        kX7WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSnO4rkZ5Yg/69PBZnlx1ks2iZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxaUDC5gsPm94zGhxu3EFm8W+jgdMFj93zWNx4PaY3XCR
        xWPnrLvsHi37brF79Da/Y/N4v+8qm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBl/D4zm7lg
        gV7F85YzTA2Mx9W6GDk5JARMJNq2fmXuYuTiEBLYzSjRMr+ZFSIhKTHt4lGgBAeQLSxx+HAx
        RM1bRomljw4wg9QIC2RJtGydwg6SEBGYzyRxad0jVhCHWaCZUWJJ338WiJZORomHy/+CtbAJ
        aEnsf3GDDcTmF1CUuPrjMSPICl4BO4mGVwIgYRYBVYlL/RPZQWxRgQiJwztmMYLYvAKCEidn
        PmEBsTkFzCS+7j0KNoZZQF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0
        LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyNWpo7GC8viT/EKMDBqMTDeyCs
        O1aINbGsuDL3EKMEB7OSCO8sma5YId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5ak
        ZqemFqQWwWSZODilGhgX2ihvOSba8TUy0feUIUfqbFGOoxHeS0689l2mmfJI6qvDxUVfHZlD
        Wa0D0k95lP1avVRFWy1O8IWX9u5L13dcNCsROVP1pnIPd+CfIiXxJ69yJ21J01mt81vsxeOL
        V3ffY7lZus75xueHJxV4Xx+uXu+gqz7vxU7bkPfVs4sDb2g8mxGsN6dXiaU4I9FQi7moOBEA
        z35ZUMICAAA=
X-CMS-MailID: 20190926013122epcas1p1dcdbefd63f655e8082d138064c09e9dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190925184505epcas2p3f8f4395f37df4b1fe33309393e8af4df
References: <CGME20190925184505epcas2p3f8f4395f37df4b1fe33309393e8af4df@epcas2p3.samsung.com>
        <20190925184314.30251-1-mka@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I'm not sure that it is necessary. I think that it depends on
personal opinions. There are no correct answer perfectly.
Also, after this changes, there are no any beneficial.
It touch the history rather than behavior improvement.

On 19. 9. 26. 오전 3:43, Matthias Kaehlcke wrote:
> devfreq has two functions with very similar names, devfreq_update_status()
> and devfreq_update_stats(). _update_status() currently updates
> frequency transitions statistics, while _update_stats() retrieves the
> device 'status'. The function names are inversed with respect to what
> the functions are actually doing, rename devfreq_update_status() to
> devfreq_update_stats() and viceversa.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> We could also rename the current devfreq_update_stats() to
> devfreq_refresh_status() to make it easier to distinguish it from
> devfreq_update_stats().
> ---
>  drivers/devfreq/devfreq.c                 | 12 ++++++------
>  drivers/devfreq/governor.h                |  4 ++--
>  drivers/devfreq/governor_passive.c        |  2 +-
>  drivers/devfreq/governor_simpleondemand.c |  2 +-
>  drivers/devfreq/tegra30-devfreq.c         |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 446490c9d635..fb4318d59aa9 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -151,11 +151,11 @@ static int set_freq_table(struct devfreq *devfreq)
>  }
>  
>  /**
> - * devfreq_update_status() - Update statistics of devfreq behavior
> + * devfreq_update_stats() - Update statistics of devfreq behavior
>   * @devfreq:	the devfreq instance
>   * @freq:	the update target frequency
>   */
> -int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
> +int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int lev, prev_lev, ret = 0;
>  	unsigned long cur_time;
> @@ -191,7 +191,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	devfreq->last_stat_updated = cur_time;
>  	return ret;
>  }
> -EXPORT_SYMBOL(devfreq_update_status);
> +EXPORT_SYMBOL(devfreq_update_stats);
>  
>  /**
>   * find_devfreq_governor() - find devfreq governor from name
> @@ -311,7 +311,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  	freqs.new = new_freq;
>  	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>  
> -	if (devfreq_update_status(devfreq, new_freq))
> +	if (devfreq_update_stats(devfreq, new_freq))
>  		dev_err(&devfreq->dev,
>  			"Couldn't update frequency transition information.\n");
>  
> @@ -450,7 +450,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
>  		return;
>  	}
>  
> -	devfreq_update_status(devfreq, devfreq->previous_freq);
> +	devfreq_update_stats(devfreq, devfreq->previous_freq);
>  	devfreq->stop_polling = true;
>  	mutex_unlock(&devfreq->lock);
>  	cancel_delayed_work_sync(&devfreq->work);
> @@ -1398,7 +1398,7 @@ static ssize_t trans_stat_show(struct device *dev,
>  	unsigned int max_state = devfreq->profile->max_state;
>  
>  	if (!devfreq->stop_polling &&
> -			devfreq_update_status(devfreq, devfreq->previous_freq))
> +			devfreq_update_stats(devfreq, devfreq->previous_freq))
>  		return 0;
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index bbe5ff9fcecf..e11f447be2b5 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -64,9 +64,9 @@ extern void devfreq_interval_update(struct devfreq *devfreq,
>  extern int devfreq_add_governor(struct devfreq_governor *governor);
>  extern int devfreq_remove_governor(struct devfreq_governor *governor);
>  
> -extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
> +extern int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq);
>  
> -static inline int devfreq_update_stats(struct devfreq *df)
> +static inline int devfreq_update_status(struct devfreq *df)
>  {
>  	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>  }
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index be6eeab9c814..1c746b96d3db 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -110,7 +110,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>  		goto out;
>  
>  	if (devfreq->profile->freq_table
> -		&& (devfreq_update_status(devfreq, freq)))
> +		&& (devfreq_update_stats(devfreq, freq)))
>  		dev_err(&devfreq->dev,
>  			"Couldn't update frequency transition information.\n");
>  
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 3d809f228619..2cbf26bdcfd6 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -25,7 +25,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
>  	struct devfreq_simple_ondemand_data *data = df->data;
>  
> -	err = devfreq_update_stats(df);
> +	err = devfreq_update_status(df);
>  	if (err)
>  		return err;
>  
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index a6ba75f4106d..536273a811fe 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -526,7 +526,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>  	unsigned int i;
>  	int err;
>  
> -	err = devfreq_update_stats(devfreq);
> +	err = devfreq_update_status(devfreq);
>  	if (err)
>  		return err;
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
