Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9325FAD20
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfKMJjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:39:13 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61971 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfKMJjN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:39:13 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191113093910epoutp020f47ed1271a8a2784e324d0badd84f7f~Wr2DTrhkq0650906509epoutp02U
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:39:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191113093910epoutp020f47ed1271a8a2784e324d0badd84f7f~Wr2DTrhkq0650906509epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573637950;
        bh=fer+xJv5ptTLV8wVyIiupxZXWIWHbKvk/tjZTh9lZbU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Akpo7rx8qduhr+tlSjVo3HaWaynGlMn+OcUKgkAMuL6EnWPmBQTWyZXcsDXv9WX5h
         cphC+wv8BvFHB0w5papVEASiajt8BPpMeEQn6CETUR1HVJEYFfUaBpDiCBjROaJK3N
         wZwpG8Mp7DbwCfeeElNh/pb8yez2qm48Z0FEDLCQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191113093909epcas1p4b66174d3a600e6f813341ea9eb5351a5~Wr2DCtZR01177511775epcas1p4C;
        Wed, 13 Nov 2019 09:39:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47CfhC1DfQzMqYkf; Wed, 13 Nov
        2019 09:39:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.D7.04144.B3FCBCD5; Wed, 13 Nov 2019 18:39:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191113093906epcas1p3a2009e50cacf6f8f0a1fa0a28826a6c9~Wr1-1xZ4k0479204792epcas1p3l;
        Wed, 13 Nov 2019 09:39:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113093906epsmtrp17ab34406663f5aca817991188a840508~Wr1-1Diol0404104041epsmtrp1T;
        Wed, 13 Nov 2019 09:39:06 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-b0-5dcbcf3b0d71
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.5A.25663.A3FCBCD5; Wed, 13 Nov 2019 18:39:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113093906epsmtip1ec5153cd51837e725ec974ab8830f5f4~Wr1-j50ZO0559505595epsmtip1Y;
        Wed, 13 Nov 2019 09:39:06 +0000 (GMT)
Subject: Re: [PATCH 1/7] devfreq: change time stats to 64-bit
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <58cf5fc7-9f57-d123-9231-243fb4f9ad66@samsung.com>
Date:   Wed, 13 Nov 2019 18:44:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113091336.5218-2-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRzf75675+6a4+n08nUs14M/ZKd7qstDZUzs0FZb0xqSR/eo1r25
        53rjnzAkbyFDQ4cl2izS6mpIaUu1q9SYtMQ0pCRJSRP39GT67/P9fD/fl8/v95Vhylu4SpZq
        trM2M2MkcQ9x5dPlgZqwtpYE7YMbcvr+pTIJffrxH0Q7Ri5J6La2e1LadWhQSnfWXMHp76ca
        EH23oUdKdx+8ja+T68tLj+P6uqGHIv3pilKk/17uFyPenhaewjIG1qZmzUkWQ6o5OYLcGpu4
        IVEXqqU01Gp6Fak2MyY2goyMitFsSjW6dyHVGYwx3U3FMBxHBq4Nt1nS7aw6xcLZI0jWajBa
        V1tXcoyJSzcnr0yymNZQWm2Qzi3cnZYyUPELt55YmDUw7kQ5qMAnD8lkQITA83fb8pBcpiSc
        CD6UUnnIw41HEJz7dlEiBGMIan6/k/AqvqBz6PBM4hGCW67DIiH4iqBrslfCt51PREB1/16+
        wIvQwKCzGOM1GNEpgpcPXFI+gRMBUPvpFc7jeYQ/vPj5HvFYQayFwda307yYWAZHLvQivqc3
        EQ8tPxhB4glNl/vEPJYT4eBwNU23xAhfeN1XJBLwYqj6cgUTlh7HoX0iW3AcCWNnvQR6Pnxu
        rJAKWAX9Z47O4ANwp6kB51cGIhdBRW37jPlgqC0+L+L7YMRyKKsJFGh/qJ68ioSxc2Hox0mJ
        MEoBuUeVgmQJdL7tEQl4Adw8dhzPR2ThLDOFswwUzjJQ+H+YA4lLkQ9r5UzJLEdZqdk/XY6m
        bzRA50QFrVH1iJAhco7iybXmBKWEyeCyTfUIZBjppXBmPUtQKgxM9n7WZkm0pRtZrh7p3E99
        FlN5J1ncF2+2J1K6oODgYDqECtVRFOmrWF9SnKAkkhk7m8ayVtb2r04kk6tyEDaVm+/pt3mP
        xuF/5madPCdOFLYrqm9xOb2xucRXjuE7G6fWlYRkFb1/kxo2Mcy2rfhwed++SrXfYPfE9UpH
        oOeNrYsyVYZDoXFhmaOLQrYURNdcK44e6RoeuK65q1XVfbQOFe34FP/Up74j2ndppQc3qm86
        cmxLlff2gHsdrnmKWFLMpTBUAGbjmL8E2BTGuQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnK7V+dOxBpenSVtsnLGe1aJv339G
        iwWfZrBanD+/gd3ibNMbdovLu+awWXzuPcJosfbIXXaL240r2Bw4PTat6mTzOPhuD5NH35ZV
        jB6fN8kFsERx2aSk5mSWpRbp2yVwZbze8outoFu64vX3HYwNjFPEuhg5OSQETCQuv2tm7WLk
        4hAS2M0osfXQbHaIhKTEtItHmbsYOYBsYYnDh4shat4ySvy+cJ4NJC4sYCux82UaSLmIgK7E
        mx1LmUFsZoGrTBI7TjtB1B9klPh04TwTSIJNQEti/4sbbCA2v4CixNUfjxlBbF4BO4k35x6A
        xVkEVCVap94Hi4sKREg8334DqkZQ4uTMJywgNqeAjcSCsyfZIZapS/yZdwlqsbjErSfzmSBs
        eYntb+cwT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93
        EyM4rrS0djCeOBF/iFGAg1GJh/fAvFOxQqyJZcWVuYcYJTiYlUR4d1SciBXiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgmy8TBKdXAGDVV9eqxnfO5Tc2bLn50buNX
        45nzRTGk8J7YNg3Lp39uhptXXpVO7u8TNFc0b/TyazHdsaol97TUhfWTW53zDed+VTstosbZ
        e8tGT2jbZJ1V317nbv19NeBtlPLM2INJJZvSrxtEfUtVdLli9u/QDIM11Vrd2Wrv/fZnKczZ
        cp5B3CKz3Ga9EktxRqKhFnNRcSIA6mM38acCAAA=
X-CMS-MailID: 20191113093906epcas1p3a2009e50cacf6f8f0a1fa0a28826a6c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091351eucas1p24afdb94f868b6a7a52b43e81462bb674
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091351eucas1p24afdb94f868b6a7a52b43e81462bb674@eucas1p2.samsung.com>
        <20191113091336.5218-2-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/13/19 6:13 PM, Kamil Konieczny wrote:
> Change time stats counting to bigger type by using 64-bit jiffies.
> This will make devfreq stats code look similar to cpufreq stats and
> prevents overflow (for HZ = 1000 after 49.7 days).
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 14 +++++++-------
>  include/linux/devfreq.h   |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index ab22bf8a12d6..1602cca20fc4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -158,9 +158,9 @@ static int set_freq_table(struct devfreq *devfreq)
>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int lev, prev_lev, ret = 0;
> -	unsigned long cur_time;
> +	unsigned long long cur_time;
>  
> -	cur_time = jiffies;
> +	cur_time = get_jiffies_64();
>  
>  	/* Immediately exit if previous_freq is not initialized yet. */
>  	if (!devfreq->previous_freq)
> @@ -478,7 +478,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
> -	devfreq->last_stat_updated = jiffies;
> +	devfreq->last_stat_updated = get_jiffies_64();
>  	devfreq->stop_polling = false;
>  
>  	if (devfreq->profile->get_cur_freq &&
> @@ -698,7 +698,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>  			devfreq->profile->max_state,
> -			sizeof(unsigned long),
> +			sizeof(*devfreq->time_in_state),
>  			GFP_KERNEL);
>  	if (!devfreq->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
> @@ -706,7 +706,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->last_stat_updated = jiffies;
> +	devfreq->last_stat_updated = get_jiffies_64();
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1423,8 +1423,8 @@ static ssize_t trans_stat_show(struct device *dev,
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
>  
>  	struct srcu_notifier_head transition_notifier_list;
>  };
> 

Looks good to me.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

But, When I tried to apply it to devfreq-next branch[1],
the merge conflict happen. You need to rebase it on devfreq-next branch[1] or linux-next.git.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/ (branch : devfreq-next)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
