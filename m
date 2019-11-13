Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1A1FAD2A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfKMJld (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:41:33 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63049 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMJld (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:41:33 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191113094129epoutp02e0dcad151312ca12c577ce0525ef4090~Wr4FcHJPM0881408814epoutp02M
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:41:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191113094129epoutp02e0dcad151312ca12c577ce0525ef4090~Wr4FcHJPM0881408814epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573638089;
        bh=dqgFz+DwklWmeI89xEItqtdOBDQAfvDdfM/2z9ul5Ak=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=a7Wri0mhD172SpjnKkkfwS4Dw24pBgjcga7Izfq+C5udFAq61aeXN1/q456um1HpR
         yqye2lTsBext1DuZkHTNgsG/uTz6NTIUTEC5+FxqSADiN7qFGiNOMGRZpcVM69Fkor
         miC1vOl726XZN6jWTIo0w7QAZPhoEbFzwNk9U1o8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113094129epcas1p1ae4447442db6b76c3aca1edd2ea2702e~Wr4E1e1Eg1018510185epcas1p1Y;
        Wed, 13 Nov 2019 09:41:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47Cfkv29mGzMqYlr; Wed, 13 Nov
        2019 09:41:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.18.04144.7CFCBCD5; Wed, 13 Nov 2019 18:41:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191113094126epcas1p4e7a2faf9c11b803fb0ffeff2f7c9c260~Wr4CqTjsP1286112861epcas1p4H;
        Wed, 13 Nov 2019 09:41:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113094126epsmtrp23ce107b4fc1a8a1d19e1cb32793e8f70~Wr4CpnZIw0151201512epsmtrp2I;
        Wed, 13 Nov 2019 09:41:26 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-6f-5dcbcfc73189
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.4D.24756.6CFCBCD5; Wed, 13 Nov 2019 18:41:26 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113094126epsmtip1865e205a4be193c1f25b3976cdd857c5~Wr4CbV5l30559505595epsmtip1a;
        Wed, 13 Nov 2019 09:41:26 +0000 (GMT)
Subject: Re: [PATCH 2/7] devfreq: protect devfreq stats data with spinlock
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
Message-ID: <2d1a0441-b99f-8c15-972f-a71589050f91@samsung.com>
Date:   Wed, 13 Nov 2019 18:47:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113091336.5218-3-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt93dXbPVr5V1WpHrRlDCdNc1u8oUJQmxIivoybKL3qa5F7tb
        9ICoiLKX9qJyPRTFHlaYc6RZZq5RmaWWvd+URFRqOayowLZdI//7zjnfx3e+3+9QUuU5UkXl
        W528w8qZaXIYcenGdK3mVnurUevbN4qtOVotY4uuDSC2rO+ojG1vvyhn7239Imc7G46TbGCv
        H7EX/K/k7IstZ8jUiAxP1U4yo7nnqiSjyFuFMgKeSVnE8gJDHs/l8g41b82x5eZbTcn0nEXZ
        s7L1CVpGwySyM2m1lbPwyXT63CzN7HxzcBdavZYzu4KtLE4Q6LgUg8PmcvLqPJvgTKZ5e67Z
        nmiPFTiL4LKaYnNsliRGq43XB4mrCvKaWwsl9tPqdQM/S4jNqEi1C0VQgGfA1YZiYhcaRilx
        PYLeIwGZWPQh6N9RMjj5jqD2RSf6J7nde18uDhoRDHx+JhWL3qDe1yIPsUbjTPj8sVgSwmOw
        Br7UV4ZJUtwpgce198IkEsdA08enZAiPxJPh0c/3YQsFToG7Bw6HOQSeCo/a3wUxRUXhpdDa
        z4mUUdBS0kWEcAQ2wM3SY2EvKR4Hz7tKB3E01HUfD/sCDpDwuq1OJkZIh4eX3w7GGQ2fbnnl
        IlZBoKeRFPFGONviJ0VxIQJvU8egWAdNlQcloYWkeDpUN8SJ7clw+fcJJBqPgJ7+PbIQBbAC
        CrcrRcoU6Hz7SiLi8VCxYye5D9HuIXHcQyK4h0Rw/zcrQ0QVGsvbBYuJFxg7M/S7PSh8qDH6
        enSoba4PYQrRwxXXT94xKmXcWmG9xYeAktJjFPXrbhuVilxu/QbeYct2uMy84EP64GPvl6qi
        cmzBs7c6sxl9vE6nY2cwCXqGoccp0k5XGpXYxDn5Ap63845/OgkVodqMNi30RtMT/E8nehpX
        /FkQ+SGz3NiX5M7M8nvSVuoMprPTlhz5FvMpsc+4uyPlq7aZiEvWklza+RXlxvkPFpdF3b3/
        PqnIUFFXs3Kea+AhU51ZqrxiDjyZ92bbqe7m2mXFqQWxqV10dEPkA2+UZPWal4FtCctQvKY7
        IfLHge5fNTXpNCHkcUyM1CFwfwEOj6hovgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnO6x86djDV4uMLHYOGM9q0Xfvv+M
        Fgs+zWC1OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWtxtXsDlwemxa1cnmcfDdHiaPvi2r
        GD0+b5ILYInisklJzcksSy3St0vgyjh4uoOpYLlCxf8fM1kaGPukuhg5OSQETCROvL/I3sXI
        xSEksJtR4s6ljcwQCUmJaRePAtkcQLawxOHDxRA1bxkldl3uZAOpERbwknj9op8JxBYR0JV4
        s2MpWC+zwFUmiR2nnSAaDjJKHLh4AizBJqAlsf/FDbBmfgFFias/HjOC2LwCdhJnJk1jB7FZ
        BFQlrp5/BGaLCkRIPN9+A6pGUOLkzCcsIDangI3EsfmzmSCWqUv8mXcJarG4xK0n86Hi8hLb
        385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw
        ZGlp7mC8vCT+EKMAB6MSD6/EwlOxQqyJZcWVuYcYJTiYlUR4d1SciBXiTUmsrEotyo8vKs1J
        LT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBUa7o8qI1vQZS6QGF5el88Q+47cK/
        fvoSoGkWUTT96stjVTP3cXr97lkn2ZNtHtu63LPMI9rgnkp34skrmiwz0lS9j76TtG4/9Nfr
        4f598TWPNhd6nHT7EXRrdvOiRzNehd/s2GTgniXms/x8tRTX3N7Cv3mXdL/+O/XtgsfEjYvs
        5KxyfNPqlViKMxINtZiLihMBwasDZagCAAA=
X-CMS-MailID: 20191113094126epcas1p4e7a2faf9c11b803fb0ffeff2f7c9c260
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091351eucas1p2f83c221ce94fdea695775e00d5215458
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091351eucas1p2f83c221ce94fdea695775e00d5215458@eucas1p2.samsung.com>
        <20191113091336.5218-3-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/13/19 6:13 PM, Kamil Konieczny wrote:
> Protect access to devfreq transitions stats with spinlock.

You have to add the more detailed reason why spinlock is necessary.
And are there any issue without spinlock? 

In my case, I used the devfreq sysfs entries on Tizen Platfrom
for a long time, there are no any issue without spinlock.

Regards,
Chanwoo Choi

> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 18 +++++++++++++++---
>  include/linux/devfreq.h   |  3 +++
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 1602cca20fc4..ac04b5baef70 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -163,10 +163,16 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	cur_time = get_jiffies_64();
>  
>  	/* Immediately exit if previous_freq is not initialized yet. */
> -	if (!devfreq->previous_freq)
> -		goto out;
> +	if (!devfreq->previous_freq) {
> +		spin_lock(&devfreq->stats_lock);
> +		devfreq->last_stat_updated = cur_time;
> +		spin_unlock(&devfreq->stats_lock);
> +		return 0;
> +	}
>  
>  	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
> +
> +	spin_lock(&devfreq->stats_lock);
>  	if (prev_lev < 0) {
>  		ret = prev_lev;
>  		goto out;
> @@ -174,7 +180,6 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  
>  	devfreq->time_in_state[prev_lev] +=
>  			 cur_time - devfreq->last_stat_updated;
> -
>  	lev = devfreq_get_freq_level(devfreq, freq);
>  	if (lev < 0) {
>  		ret = lev;
> @@ -189,6 +194,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  
>  out:
>  	devfreq->last_stat_updated = cur_time;
> +	spin_unlock(&devfreq->stats_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL(devfreq_update_status);
> @@ -478,7 +484,9 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
> +	spin_lock(&devfreq->stats_lock);
>  	devfreq->last_stat_updated = get_jiffies_64();
> +	spin_unlock(&devfreq->stats_lock);
>  	devfreq->stop_polling = false;
>  
>  	if (devfreq->profile->get_cur_freq &&
> @@ -707,6 +715,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  
>  	devfreq->last_stat_updated = get_jiffies_64();
> +	spin_lock_init(&devfreq->stats_lock);
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> @@ -1405,6 +1414,8 @@ static ssize_t trans_stat_show(struct device *dev,
>  
>  	len = sprintf(buf, "     From  :   To\n");
>  	len += sprintf(buf + len, "           :");
> +
> +	spin_lock(&devfreq->stats_lock);
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
>  				devfreq->profile->freq_table[i]);
> @@ -1429,6 +1440,7 @@ static ssize_t trans_stat_show(struct device *dev,
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
>  					devfreq->total_trans);
> +	spin_unlock(&devfreq->stats_lock);
>  	return len;
>  }
>  static DEVICE_ATTR_RO(trans_stat);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index b81a86e47fb9..a344e0be99f3 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -135,6 +135,8 @@ struct devfreq_dev_profile {
>   * @trans_table:	Statistics of devfreq transitions
>   * @time_in_state:	Statistics of devfreq states
>   * @last_stat_updated:	The last time stat updated
> + * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
> + *			and total_trans used for statistics
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>   *
>   * This structure stores the devfreq information for a give device.
> @@ -176,6 +178,7 @@ struct devfreq {
>  	unsigned int *trans_table;
>  	u64 *time_in_state;
>  	unsigned long long last_stat_updated;
> +	spinlock_t stats_lock;
>  
>  	struct srcu_notifier_head transition_notifier_list;
>  };
> 
