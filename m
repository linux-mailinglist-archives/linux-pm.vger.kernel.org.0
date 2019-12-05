Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBCE1138D6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 01:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfLEAcC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 19:32:02 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:36606 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfLEAcC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 19:32:02 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191205003159epoutp01b82809839dc7f2e185cff3757dbe3fc9~dUklfiCwb2561525615epoutp01t
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 00:31:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191205003159epoutp01b82809839dc7f2e185cff3757dbe3fc9~dUklfiCwb2561525615epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575505919;
        bh=KuYsxdaQllsL9jhgWWVnCcPlMyTS/bIlDftBqHVglWs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ikpHJVRuWMpT409usVgz2PRNDLml3qUNVlqxOyleDIGOSYSqMgkxS8AX49YuPQUvf
         HnJ+WSLckK3WUR/idd1buA83ZG8fHTYvy/VoAh2WfDXWQK9dBOW4WOZWSrD7oQ8umh
         5bH+vQmUMEQr8jguXyjWiGkM81DIGsxTuyxhwa2Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191205003159epcas1p4988e06bb4aead83ec44708133b7415a9~dUkk_HBtY1456714567epcas1p4P;
        Thu,  5 Dec 2019 00:31:59 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47SxVg686PzMqYkt; Thu,  5 Dec
        2019 00:31:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.0D.52419.7FF48ED5; Thu,  5 Dec 2019 09:31:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191205003150epcas1p3112cde988243614d4855e100c50186a1~dUkdO3G752048420484epcas1p3-;
        Thu,  5 Dec 2019 00:31:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205003150epsmtrp11e03eb412a077b4265707a217afc5154~dUkdOKKf02217722177epsmtrp1k;
        Thu,  5 Dec 2019 00:31:50 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-26-5de84ff71110
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.89.06569.6FF48ED5; Thu,  5 Dec 2019 09:31:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205003150epsmtip214118351c0f5ff116bb935ac06a3e1bd~dUkdA8MPc2333323333epsmtip2b;
        Thu,  5 Dec 2019 00:31:50 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] devfreq: add clearing transitions stats
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e707f735-49d0-44dc-a7c3-586ee6563cbe@samsung.com>
Date:   Thu, 5 Dec 2019 09:38:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191204150018.5234-3-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+Xa2s2O4/FqZbyNqnfyjDHOnuTyZSlSYXSjBqBCGnfSwibux
        sw0rqiVhZtmdsmEqlZTrPsTsutBBGSwNu1+oKCtjtdAyK6i2HSP/+/F8z8Pzve/3UYSygVRR
        pRYHb7dwJpocJW3tmK5J/b7ig15zrlfNXqw9L2Mb+2tlbFfXBTkbrAjJ2Z4rdSQ7UBNA7NnA
        Czn7bOspch6V5/PuIPN2t3hR3oBvUj5RWJZl5LkS3q7mLcXWklKLIZteWlC0oEg3W8OkMnPY
        DFpt4cx8Nr1wWX5qbqkpcgNa7eJMzoiUzwkCnZaTZbc6HbzaaBUc2TRvKzHZ5thmCpxZcFoM
        M4ut5kxGo5mlixjXlhlvNG+X2nxJ5R2dftKNGpTVKI4CnA6NP/dLqtEoSonbEBwKnkHRAyXu
        R3AnXCjyIILWd5v+BX42uWVi4DqCJwcaCNEURvD+5pooj8ULoH5bbUwfh1Mh1NZERAMErpdA
        6FC3LHpA4hTwf3hMRjkBT4EHQ29izQqcA96dQzFdipNh8OFJaZQT8SrobN027BkDnUfexvQ4
        nAXdj8IxP4GT4OnbBonIk+HSp7pYMeAwCQ9fPybEERbCH2+fVOSx8PFWi1xkFfTtqRzmjdDc
        GSDFcBWCFr94a8Ba8DcdiDRQkYbpcP5KmihPgcu/jiKxeDR8/rZLFrUAVkBV5fCqp0LPqxcS
        kSfA8e07yL2I9owYxzNiBM+IETz/yxqR1IvG8zbBbOAFxqYd+dg+FPucKRlt6MLdZe0IU4iO
        V7h97/VKGecS1pvbEVAEPU7RCr16paKEW7+Bt1uL7E4TL7QjXWTb+whVYrE18tUtjiJGN0ur
        1bLpzGwdw9BJCmronl6JDZyDL+N5G2//l5NQcSo3ip+4ZeB0Ql2OMT43JS/dE9KXb7g643do
        an2g2bm/yrXka7DCfO17QuazRYeHXgoFNc8d/rTKuuV7K+yu4Mrd/YN/fp+4urj2QbA3OTMn
        I95Uo1pp6E9ew5TfGD2/7b7QJL9d0Nu32jVt87owW1g9ce7t+Qc/zj3WE3Dfsnl/fHmdu5iW
        CkaOSSHsAvcXboSf0bIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXveb/4tYg7eX9Sw2zljParHg0wxW
        i/PnN7BbnG16w25xedccNovPvUcYLdYeuctucbtxBZsDh8emVZ1sHn1bVjF6fN4kF8AcxWWT
        kpqTWZZapG+XwJWxb2U7S8Em8YrDJ/ezNTDOF+pi5OSQEDCR+LW0gbWLkYtDSGA3o8TRtR8Y
        IRKSEtMuHmXuYuQAsoUlDh8uhqh5yyhx7OEKsBphAWeJeS0zmEFsEQFdiTc7ljKDFDELLGCS
        mH9zIgtEx0FGiQmfXrCCVLEJaEnsf3GDDcTmF1CUuPrjMdgkXgE7iVXdP8DiLAIqEt+uLWcB
        sUUFwiR2LnnMBFEjKHFy5hOwOKeAjcSF6+/B6pkF1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvME
        RuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxguNIS2sH
        44kT8YcYBTgYlXh4b2x5HivEmlhWXJl7iFGCg1lJhHebxNNYId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYyW15PmyRRfULTxj37gl/HsxFE9tq3mi8yZ
        o79GXvh4fVLKDw2+yRLyr0Ws33E/bXh6Tl4mPPL9151fONdyXGyq/cZlXZRs8qTn3pR9dvv8
        20PuO0sElj/I49u7ye9po7uuygZZv6qopiKzLyURGwNqS96G152fvCWi8HH8tF8+IhwSXE9P
        LVViKc5INNRiLipOBADKNiinnwIAAA==
X-CMS-MailID: 20191205003150epcas1p3112cde988243614d4855e100c50186a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10@eucas1p1.samsung.com>
        <20191204150018.5234-3-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/5/19 12:00 AM, Kamil Konieczny wrote:
> Add clearing transition table and time in states devfreq statistics
> by writing to trans_stat file in devfreq sysfs.

Have to add command example how to reset the trans_stat via sysfs
on patch description.

And, have to add how to do it on documentation file as following:
On next version, please contain the following modification with this patch.

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 75897e2fde43..c172ff838643 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -60,7 +60,10 @@ Description:
                the number of transitions between states.
                In order to activate this ABI, the devfreq target device
                driver should provide the list of available frequencies
-               with its profile.
+               with its profile. If need to reset the statistics of devfreq
+               behavior on a specific device, enter 0(zero) to 'trans_stat'
+               as following:
+                       echo 0 > /sys/class/devfreq/.../trans_stat
 
 What:          /sys/class/devfreq/.../userspace/set_freq
 Date:          September 2011


> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
> Changes in v2:
>  instead of creating new sysfs file, add new functionality to trans_stat
>  and clear stats when anything is writen to it
> 
>  drivers/devfreq/devfreq.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0e2030403e4a..901af3b66a76 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1478,7 +1478,27 @@ static ssize_t trans_stat_show(struct device *dev,
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
> +

Why don't you check the input value is whether value is 0(zero) or not?
If user enter the any value to 'trans_stat', devfreq core
reset the statistics data. I want to decide the fixed value
for the reset as following:

	echo 0 > /sys/class/devfreq/devfreqX/trans_stat

> +	if (cnt == 0)
> +		return count;
> +
> +	mutex_lock(&df->lock);
> +	memset(df->time_in_state, 0, cnt * sizeof(u64));
> +	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
> +	df->last_stat_updated = get_jiffies_64();
> +	df->total_trans = 0;
> +	mutex_unlock(&df->lock);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(trans_stat);
>  
>  static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_name.attr,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
