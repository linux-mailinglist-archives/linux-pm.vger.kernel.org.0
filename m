Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0FFACF2
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKMJ3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:29:40 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:39488 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfKMJ3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:29:40 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191113092937epoutp035e4f799c75bf9f7944cf84ded8dc3ea8~WrttsSTiE0994409944epoutp03g
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:29:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191113092937epoutp035e4f799c75bf9f7944cf84ded8dc3ea8~WrttsSTiE0994409944epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573637377;
        bh=0Zp5MeAHXgdYYKav4zs9Etj+B0vEkY/VANYNZ3/uL60=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QFi7npCd0Srtpx2Z0cg8gd5NgkUk4H6VgSvuXd6ZiF/n1GNOy5vJKxy9dVKX6B4Kg
         hj3/UTIW871PV5Pt/mcxu5YfeuklyoWJkSFueUYVJGaCycKU/uB35a3UWJqWbrvX3f
         oeYc6KxXVKlOmc+7cxtu7D96LHSLqUkNgKfdTiik=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113092936epcas1p128daa2fbe050acff1243f76aea51668f~Wrts_XuVe1334313343epcas1p1o;
        Wed, 13 Nov 2019 09:29:36 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47CfT95CfKzMqYkf; Wed, 13 Nov
        2019 09:29:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.73.04068.DFCCBCD5; Wed, 13 Nov 2019 18:29:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113092932epcas1p2a2307ca76556d3032bb577c6c4ca2f9d~Wrtpq6FiN2352123521epcas1p2q;
        Wed, 13 Nov 2019 09:29:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113092932epsmtrp2a6803c21220ff3e2e28071ae168a3a65~WrtpqKzIq2596325963epsmtrp2V;
        Wed, 13 Nov 2019 09:29:32 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-a4-5dcbccfd2648
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.9C.24756.CFCCBCD5; Wed, 13 Nov 2019 18:29:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191113092932epsmtip27d5322255a923e67f56eaffe8444be73~Wrtpet2092189921899epsmtip2n;
        Wed, 13 Nov 2019 09:29:32 +0000 (GMT)
Subject: Re: [PATCH 4/7] devfreq: change var name used in time statistics
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
Message-ID: <2c671b4e-697d-d99a-d0d3-3280dd170c42@samsung.com>
Date:   Wed, 13 Nov 2019 18:35:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113091336.5218-5-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e1ud1drdZtap/2R60ZEwtSrzq4xpcjMSkgIwophF3eZ5l7t
        zsiid5haWlmBrZdh9hDKWqvm8lFzVDpNyazoAUVPrAwcVlBpu7tF/vc553zP7zx+h8CUF3EV
        UWRxcHYLa6LwSOmNjrnxmt/dAX3iI+8c5mptk4ypbhtDTN1wrYzp7b0iZ3p2fZYz/d4TOBOs
        8iPmkv+lnHm+8wK+ICLb1ViBZ98ZapFkV7sbUXbQNSNXuqZYV8ixBs6u5iwFVkORxZhOLV+Z
        vyhfm5pIa+g0Zh6ltrBmLp3KzMnVZBWZQr1Q6o2sqSTkymV5nkrI0NmtJQ5OXWjlHekUZzOY
        bGm2eJ418yUWY3yB1TyfTkxM0oaE64oL/SNn5bZe9aYDvkr5DvRaVYkIAsgUqL88uxJFEkrS
        g6D83QgmGsMIeoJBWSWKCBnfEFS/mCywkDB27ahEFLUiGPhdIxWNrwjO9fswQRVFLoU7Yx1h
        jiY18NnTEH4WI/sl8Phaj1wI4GQctH98igs8mZwJAz/eIIEVZAY0v9ojFVhKzoZ9NY0SodcY
        Mg8CI6womQKdx96GJRGkDgZPeSUCY+Q0ePb29F+OhZtfToTrAvkdh12fapA4QiaUHT+LixwF
        g/fccpFVEBxq/evfAhc7/biYXI7A3d4nEwPJ0N5wONwQRs6FJm+C6J4JzT9PIrHwJBga2S8T
        96uA8jKlKJkF/a9eSkSeDvV7K/CDiHKOG8c5bgTnuBGc/4vVIWkjmsrZeLOR42mbdvxnu1D4
        TOPSPOjugxwfIglETVTAmS69UsZu5EvNPgQERkUrPJvu65UKA1u6mbNb8+0lJo73IW1o2Ycw
        VUyBNXT0Fkc+rU1KTk5mUuhULU1T0xQLzzfolaSRdXDFHGfj7P/yJESEage6HTD24WXb3Yce
        1o7O393lP/WBG3XlMaqq2HOxy71ZUzMHMlZHntwen5M+/Gut3uwozlsvW29/T21NjTY13Wpb
        8CI1pfpYe0C3anjr86LmpAkfHqtWBA3LujvQ9OuHC5xRR1xVAbTtibuW0IwemXJJ19K32JMW
        N2/nCmaJ5esG4hEl5QtZOg6z8+wfZ2DW47wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvO6fM6djDTY+N7bYOGM9q0Xfvv+M
        Fgs+zWC1OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWtxtXsDlwemxa1cnmcfDdHiaPvi2r
        GD0+b5ILYInisklJzcksSy3St0vgyjjydQl7wXmFiv5DXewNjA+luhg5OSQETCT+b57K1MXI
        xSEksJtR4t+PFkaIhKTEtItHmbsYOYBsYYnDh4shat4ySrRvus0CUiMs4Clx8P9hZhBbREBX
        4s2OpWA2s8BVJokdp50gGg4ySiy91M8GkmAT0JLY/+IGmM0voChx9cdjsGW8AnYSOx+0gA1l
        EVCV6J60ignEFhWIkHi+/QZUjaDEyZlPwGo4BWwkXs3bxQSxTF3iz7xLUIvFJW49mQ8Vl5fY
        /nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC
        I0tLcwfj5SXxhxgFOBiVeHglFp6KFWJNLCuuzD3EKMHBrCTCu6PiRKwQb0piZVVqUX58UWlO
        avEhRmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjBXPWb1/tMXc+3nmxulvzwTvloi1
        Nzb7blwsJ2Xhur/HyHjCO/+Ply4YOn+KMF+9dMucb5ZZ3HuzNplK/97/zJaXXfnhc8uHX1dM
        fffIUf+i5yPp9gWz3j7sufra1WEN35ydMbvezHku2NC0WfP1y9a7BifP3RTYI/W4PDvhjMz8
        utaFgifz5xspsRRnJBpqMRcVJwIAgUYg+agCAAA=
X-CMS-MailID: 20191113092932epcas1p2a2307ca76556d3032bb577c6c4ca2f9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091352eucas1p1825d815661c1a8377449f511c65ea230
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091352eucas1p1825d815661c1a8377449f511c65ea230@eucas1p1.samsung.com>
        <20191113091336.5218-5-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Actually, it just change the variable name. I don't want to
change the name without any behavior improvement. Frankly,
we might make the many patches to rename the some variables
on various subsystem and driver. But, It is not necessary
if there are any critical beneficial.

Rather than just changing the name, it is more important to keep
the history. And devfreq is not cpufreq. There are no any reason
to follow the cpufreq for variable name.

So, Not ack of this patch. Thanks.

Regards,
Chanwoo Choi


On 11/13/19 6:13 PM, Kamil Konieczny wrote:
> Change var name used in time statistics from last_stat_updated to
> last_time. This will make it shorter and similar to cpufreq_stats.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 12 ++++++------
>  include/linux/devfreq.h   |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0a88055d1362..6e5a17f4c92c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -165,7 +165,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	/* Immediately exit if previous_freq is not initialized yet. */
>  	if (!devfreq->previous_freq) {
>  		spin_lock(&devfreq->stats_lock);
> -		devfreq->last_stat_updated = cur_time;
> +		devfreq->last_time = cur_time;
>  		spin_unlock(&devfreq->stats_lock);
>  		return 0;
>  	}
> @@ -179,7 +179,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	}
>  
>  	devfreq->time_in_state[prev_lev] +=
> -			 cur_time - devfreq->last_stat_updated;
> +			 cur_time - devfreq->last_time;
>  	lev = devfreq_get_freq_level(devfreq, freq);
>  	if (lev < 0) {
>  		ret = lev;
> @@ -193,7 +193,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  	}
>  
>  out:
> -	devfreq->last_stat_updated = cur_time;
> +	devfreq->last_time = cur_time;
>  	spin_unlock(&devfreq->stats_lock);
>  	return ret;
>  }
> @@ -485,7 +485,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  	spin_lock(&devfreq->stats_lock);
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->last_time = get_jiffies_64();
>  	spin_unlock(&devfreq->stats_lock);
>  	devfreq->stop_polling = false;
>  
> @@ -714,7 +714,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_devfreq;
>  	}
>  
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->last_time = get_jiffies_64();
>  	spin_lock_init(&devfreq->stats_lock);
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
> @@ -1452,7 +1452,7 @@ static void defvreq_stats_clear_table(struct devfreq *devfreq)
>  	spin_lock(&devfreq->stats_lock);
>  	memset(devfreq->time_in_state, 0, count * sizeof(u64));
>  	memset(devfreq->trans_table, 0, count * count * sizeof(int));
> -	devfreq->last_stat_updated = get_jiffies_64();
> +	devfreq->last_time = get_jiffies_64();
>  	devfreq->total_trans = 0;
>  	spin_unlock(&devfreq->stats_lock);
>  }
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index a344e0be99f3..2ddf25993f7d 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -134,7 +134,7 @@ struct devfreq_dev_profile {
>   * @total_trans:	Number of devfreq transitions
>   * @trans_table:	Statistics of devfreq transitions
>   * @time_in_state:	Statistics of devfreq states
> - * @last_stat_updated:	The last time stat updated
> + * @last_time:		The last time stats were updated
>   * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
>   *			and total_trans used for statistics
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> @@ -177,7 +177,7 @@ struct devfreq {
>  	unsigned int total_trans;
>  	unsigned int *trans_table;
>  	u64 *time_in_state;
> -	unsigned long long last_stat_updated;
> +	unsigned long long last_time;
>  	spinlock_t stats_lock;
>  
>  	struct srcu_notifier_head transition_notifier_list;
> 
