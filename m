Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEDB114ABF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 03:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfLFCDH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 21:03:07 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:15902 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFCDF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 21:03:05 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191206020302epoutp03dcf899d9313c457103491c790a441880~dpdXJUJif1289012890epoutp03N
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 02:03:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191206020302epoutp03dcf899d9313c457103491c790a441880~dpdXJUJif1289012890epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575597782;
        bh=/J4bbOh/im3Q0/SZMy2JQoaCbxm5WJSp6NHH/ELX6jw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Kwzmn/SmkTEVl+RR4Rtn1JYdzO57aXQ34+tuDSU4GcPatYeOY9S96b7zBzK/qC5Tf
         NmnX7hWq+rwnHQoYv0CYKo0JxJcRULERfUynnOUBt6ge7u9i8Dl+CKuGBnQZfTeVc4
         foWz9opp2GQFo2lVes5w/yVJlHGQ2oQipgya1BZM=
Received: from epcpadp2 (unknown [182.195.40.12]) by epcas1p2.samsung.com
        (KnoxPortal) with ESMTP id
        20191206020301epcas1p2e08c5c9322489308bcecf46490b4afb6~dpdWaCtPZ3093830938epcas1p2C;
        Fri,  6 Dec 2019 02:03:01 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191206015532epcas1p3c0555be59b53f966e45034fe4a171090~dpW0uE26l2233422334epcas1p3_;
        Fri,  6 Dec 2019 01:55:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206015532epsmtrp28f94a776a52cacf09935ee77571482a7~dpW0s5yfQ0278202782epsmtrp2J;
        Fri,  6 Dec 2019 01:55:32 +0000 (GMT)
X-AuditID: b6c32a2a-077ff700000019a9-d7-5de9b514c5d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.6C.06569.415B9ED5; Fri,  6 Dec 2019 10:55:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191206015532epsmtip2cfe59875bb2b9a36a68bcc782cc5ee5b~dpW0Z-dMX0080600806epsmtip2R;
        Fri,  6 Dec 2019 01:55:32 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] devfreq: add clearing transitions stats
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1019298652.01575597781442.JavaMail.epsvc@epcpadp2>
Date:   Fri, 6 Dec 2019 11:01:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191205145527.26117-3-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSvK7I1pexBg0zzCzeLDnGbLFxxnpW
        i5eHNC2aF69ns1jwaQarxfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3WLbpD5PF7cYVbBaP
        V7xld+D1WLznJZPHplWdbB4TFh1g9Ng/dw27R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGW0
        9sxmKuiVrWj79Jy1gbFbvIuRk0NCwETixo1tLCC2kMBuRonzuxQg4pIS0y4eZe5i5ACyhSUO
        Hy7uYuQCKnnLKLHw7ndGkBphAWeJvXsgekUEdCXe7FjKDFLELNDLInF6+S5WiI7DjBK9r46y
        gVSxCWhJ7H9xA8zmF1CUuPrjMSPIBl4BO4kT6zlAwiwCKhIPJ3SwgtiiAmESO5c8ZgKxeQUE
        JU7OfAK2jFPAVuJlxxNmEJtZQF3iz7xLULa4xK0n85kgbHmJ7W/nME9gFJ6FpH0WkpZZSFpm
        IWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOCK1tHYwnjgRf4hRgINRiYd3
        xucXsUKsiWXFlbmHGCU4mJVEeNP5XsYK8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCe
        WJKanZpakFoEk2Xi4JRqYNTZamR3w9nx5ZMlPdJOsXte7MnvT1dpsOKdcEpp/sv4nfOyWFps
        ZjxW0qm86vgj0nrbwcqiBjtjnyMfNtc36Da8Mq3+J5+ykGNj3XOd16aq03aVX9MSWbxsL0/q
        ysc26VsCxR9ZLG77Hb52xrZUpgX/0o4+1Hi+dv28/Qe2bJgxa+nmP3JfOFYpsRRnJBpqMRcV
        JwIAzSYLUMQCAAA=
X-CMS-MailID: 20191206015532epcas1p3c0555be59b53f966e45034fe4a171090
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20191205145543eucas1p1a317647203c47be07bbcee7867fb3e1e
References: <20191205145527.26117-1-k.konieczny@samsung.com>
        <CGME20191205145543eucas1p1a317647203c47be07bbcee7867fb3e1e@eucas1p1.samsung.com>
        <20191205145527.26117-3-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/5/19 11:55 PM, Kamil Konieczny wrote:
> Add clearing transition table and time in states devfreq statistics
> by writing 0 (zero) to trans_stat file in devfreq sysfs. An example use
> is like following:
> 
> echo 0 > /sys/class/devfreq/devfreqX/trans_stat
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
> Changes in v3:
> - add checks for zero in input and clear stats only when zero is written
>   to trans_stats
> - change documentation of trans_stat in sysfs
> 
> Changes in v2:
> - instead of creating new sysfs file, add new functionality to trans_stat
>   and clear stats when anything is writen to it
> ---
>  Documentation/ABI/testing/sysfs-class-devfreq | 11 +++++---
>  drivers/devfreq/devfreq.c                     | 27 ++++++++++++++++++-
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 75897e2fde43..9758eb85ade3 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -55,12 +55,15 @@ What:		/sys/class/devfreq/.../trans_stat
>  Date:		October 2012
>  Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
>  Description:
> -		This ABI shows the statistics of devfreq behavior on a
> -		specific device. It shows the time spent in each state and
> -		the number of transitions between states.
> +		This ABI shows or clears the statistics of devfreq behavior
> +		on a specific device. It shows the time spent in each state
> +		and the number of transitions between states.
>  		In order to activate this ABI, the devfreq target device
>  		driver should provide the list of available frequencies
> -		with its profile.
> +		with its profile. If need to reset the statistics of devfreq
> +		behavior on a specific device, enter 0(zero) to 'trans_stat'
> +		as following:
> +			echo 0 > /sys/class/devfreq/.../trans_stat
>  
>  What:		/sys/class/devfreq/.../userspace/set_freq
>  Date:		September 2011
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index abecadeb3dc2..218eb64d7f28 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1478,7 +1478,32 @@ static ssize_t trans_stat_show(struct device *dev,
>  					devfreq->total_trans);
>  	return len;
>  }
> -static DEVICE_ATTR_RO(trans_stat);
> +
> +static ssize_t trans_stat_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct devfreq *df = to_devfreq(dev);
> +	unsigned int cnt = df->profile->max_state;
> +	int err, value;
> +
> +	if (cnt == 0)
> +		return count;
> +
> +	err = kstrtoint(buf, 10, &value);
> +	if (err || value != 0)
> +		return count;

Better returning -EINVAL to inform the error of user.
I changed it by myself.

> +
> +	mutex_lock(&df->lock);
> +	memset(df->time_in_state, 0, cnt * sizeof(u64));

Changed the size calculation way as following by myself:

    memset(df->time_in_state, 0, (df->profile->max_state *                  
					sizeof(*devfreq->time_in_state)));  

> +	memset(df->trans_table, 0, cnt * cnt * sizeof(int));

Changed the size calculation way with array3_size() as following by myself:
	memset(df->trans_table, 0, array3_size(sizeof(unsigned int),            
					df->profile->max_state,                 
					df->profile->max_state));     


> +	df->last_stat_updated = get_jiffies_64();
> +	df->total_trans = 0;

Changed the init sequence as following by myself.
	df->total_trans = 0;
	df->last_stat_updated = get_jiffies_64();

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

