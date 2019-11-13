Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D71FAD14
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKMJfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:35:48 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41224 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKMJfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:35:48 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191113093545epoutp015095193b219b3637254941ceaaa8b8ff~WrzFHBw4F2756627566epoutp01T
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:35:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191113093545epoutp015095193b219b3637254941ceaaa8b8ff~WrzFHBw4F2756627566epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573637746;
        bh=hN/freHQN5DDO02HqUVZsK+Cd5drA67THay2ZfhaDDg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=o/srXWDkjWLNbHvKpnNqZLvVhw4mv9PRDJKSP/yaijisOoMK3uSR/+vgzfGba0GuW
         ML+FwEr/GqX//xFpadAMj0+jQVMVlcB/BuKKGYs2hCstYZTPui/2FJNRz5AgtDiRaE
         og/NyR3c53aRBvld0Rnw52BlxBDq+2exB/Ncx/RM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191113093545epcas1p2cb3aa871db575cb1a0c9cbaf8b718d2a~WrzEQjmls3193831938epcas1p2J;
        Wed, 13 Nov 2019 09:35:45 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47CfcG4GwdzMqYkh; Wed, 13 Nov
        2019 09:35:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.54.04068.A6ECBCD5; Wed, 13 Nov 2019 18:35:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113093537epcas1p2fe2754effccb88f2baa61ddd8f60708b~Wry9Y2I4t0946409464epcas1p2i;
        Wed, 13 Nov 2019 09:35:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113093537epsmtrp2a99e15e51e2db7294b11c5b87f45caf2~Wry9YIcgv2952929529epsmtrp2d;
        Wed, 13 Nov 2019 09:35:37 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-69-5dcbce6a96bd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.EC.24756.96ECBCD5; Wed, 13 Nov 2019 18:35:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113093537epsmtip1a3db82c86501fbca8438f39663f22382~Wry9MuTTu0059600596epsmtip1C;
        Wed, 13 Nov 2019 09:35:37 +0000 (GMT)
Subject: Re: [PATCH 3/7] devfreq: add clearing transitions stats in sysfs
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
Message-ID: <3a5096c3-03d2-fd5d-852a-6a19c5b262a5@samsung.com>
Date:   Wed, 13 Nov 2019 18:41:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113091336.5218-4-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec/Zzs7E1evMehTKeSIoY+rJZsfQyIpYdMEuHyoQO7jTNHdj
        Z0YXiuWH8pJdsA82E7utVBDNRJdWko3KtFnYjSKSHBKldhmaVFbbTpHffs/z/p/3/zzP+9Kk
        up6KowssDsFu4U0MFSFru7soSbvH15uTMnA7grtW1STnTtz+jbjzX6vkXH9/s4J7VDyi4AY6
        zlFcoMKLuEbvGwX3+kgdtVKpb2kopfR3xm4S+hOtDUgfaJmXLdtZmJEv8AbBrhEseVZDgcWY
        yazfmrs6V5eWwmrZdG4Zo7HwZiGTWbMhW7u2wBTshdHs5U1FwVQ2L4pM8ooMu7XIIWjyraIj
        kxFsBpMt3ZYk8maxyGJMyrOal7MpKUt0QeGuwvwjT64j2wje97a2AznRoKoM0TTgpfD286oy
        FEGrsQfBUK1bIQVfEZR0fvsbTCB4N1GC/lX4+tRS/haC6s4OuRR8QtDorJOVISUdjddBcXUf
        GeJZWAsjHjcZEpF4gIDn1x8pQgcUToSu9y+pEM/ECfBscgiFWIVXwJXKfiLEMrwAGi75FSHn
        GLwdesd5SRIFPWf9YS8lzoDHzvdhLxLPgVf+WkLieGgfPRf2BRygwOeaDN8PeA04Jz7KJY6G
        D/dbFRLHQWDsFiXxQajv8VJScQmC1q7HfwtSoctdSYQaIvEiaOpIltIJcONHDZKMZ8DY+HG5
        tC0VlBxVS5L5MDD4hpA4Fi4dK6VOIcY1bRzXtBFc00Zw/Tc7j2QNaLZgE81GQWRtuumP3YLC
        3zQx3YPu+TZ0I0wjJlIFFx7mqOX8XnG/uRsBTTKzVJ59D3LUKgO//4Bgt+bai0yC2I10wWWf
        JuNi8qzBT29x5LK6JampqdxSNk3HsswcVdZVd44aG3mHUCgINsH+r46glXFOlFEpazRst487
        AyPD1T36bVQb/NpYF1k+Rc4t107t+vIxy+yoOW36vumFt6mQPlnzc/NFz0R7hSuCiKnWlnoP
        H6swJG9sOZOnvLa40jC1x5RVPnn5V2/8aJR2dzyxw9/ct3J4sPOQrXh+q3GhtvmhJnKLb/Hl
        UZf/Ziz7dG406WZkYj7PJpJ2kf8DoxNff7wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnG7mudOxBveuqlpsnLGe1aJv339G
        iwWfZrBanD+/gd3ibNMbdovLu+awWXzuPcJosfbIXXaL240r2Bw4PTat6mTzOPhuD5NH35ZV
        jB6fN8kFsERx2aSk5mSWpRbp2yVwZTRe3MxY8Eag4v78XYwNjA94uxg5OCQETCTOnRHqYuTi
        EBLYzSgxacl8xi5GTqC4pMS0i0eZIWqEJQ4fLoaoecso8eFfEwtIjbCAp0TT7DPMILaIgK7E
        mx1LwWxmgatMEjtOO0E0HGSU2Dh9JthQNgEtif0vbrCB2PwCihJXfzwGi/MK2Eksm3yeCcRm
        EVCVWLX4CTuILSoQIfF8+w2oGkGJkzOfgC3mFLCRuNDwAmqZusSfeZegbHGJW0/mM0HY8hLb
        385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw
        XGlp7mC8vCT+EKMAB6MSD6/EwlOxQqyJZcWVuYcYJTiYlUR4d1SciBXiTUmsrEotyo8vKs1J
        LT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBMWDjpspF80ssGf6LzFmQvHLlnk8+
        ByqLgvScQuZ8SPDseyu9sqBv8lThW8yThUr8JAPOP7NVf8D+W7C065Amz5tQD66Iec5Oc74L
        rjbv+R9+aP52XinBu0emcR5v6I0oO51cy+zZEOJw9HYjR0f/5bXaBXdTjjWrSZ4yFY2XnjJ1
        8ZM/IjzPlFiKMxINtZiLihMBBabyP6cCAAA=
X-CMS-MailID: 20191113093537epcas1p2fe2754effccb88f2baa61ddd8f60708b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b@eucas1p2.samsung.com>
        <20191113091336.5218-4-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

If user only want to use the transitions stats information
from now, the user just read the sysfs twice and then
can calculate them between the read data. It is enough
to get the existing sysfs information. 

And I don't know the any other reason. So, I can't agree this patch.
So, Not ack.

Regards,
Chanwoo Choi


On 11/13/19 6:13 PM, Kamil Konieczny wrote:
> Add new function trans_reset in sysfs for clearing transition
> table and time in states devfreq statistics.> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index ac04b5baef70..0a88055d1362 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1445,6 +1445,31 @@ static ssize_t trans_stat_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(trans_stat);
>  
> +static void defvreq_stats_clear_table(struct devfreq *devfreq)
> +{
> +	unsigned int count = devfreq->profile->max_state;
> +
> +	spin_lock(&devfreq->stats_lock);
> +	memset(devfreq->time_in_state, 0, count * sizeof(u64));
> +	memset(devfreq->trans_table, 0, count * count * sizeof(int));
> +	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->total_trans = 0;
> +	spin_unlock(&devfreq->stats_lock);
> +}
> +
> +static ssize_t trans_reset_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t count)
> +{
> +	struct devfreq *devfreq = to_devfreq(dev);
> +
> +	defvreq_stats_clear_table(devfreq);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(trans_reset);
> +
>  static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_governor.attr,
>  	&dev_attr_available_governors.attr,
> @@ -1455,6 +1480,7 @@ static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_min_freq.attr,
>  	&dev_attr_max_freq.attr,
>  	&dev_attr_trans_stat.attr,
> +	&dev_attr_trans_reset.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(devfreq);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
