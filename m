Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D27140339
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 06:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgAQFOt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 00:14:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:46577 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgAQFOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 00:14:49 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200117051445epoutp01e7edf88c65eb9ef8ccac345c53fe3385~qlKv801yH0265602656epoutp01-
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 05:14:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200117051445epoutp01e7edf88c65eb9ef8ccac345c53fe3385~qlKv801yH0265602656epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579238085;
        bh=4rDyvrwiqEvZkgB0cIZA1l+ZQ9LZ9qrA3Ngps1EaEAw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QpvvqpMmhrIDcPwimSko7sHtB5tKMVWh8YvqBYzBHQuXW6ehSdw0biqan+W3jPblU
         Qj/ST6fseP23e7wwGknDlHafcmk9gxAdFCFZEhev692UvwWMdtjKc4p2hququttxdB
         RevXkxhV1WnCdmlbrNmsNxE2hy1SzK7YIeFG58MY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200117051445epcas1p2f7aa54665780213e0311479ef3015c20~qlKvU6LJT0464204642epcas1p2N;
        Fri, 17 Jan 2020 05:14:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47zTl65pRYzMqYkc; Fri, 17 Jan
        2020 05:14:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.E3.48019.2C2412E5; Fri, 17 Jan 2020 14:14:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200117051442epcas1p2bbaf74e1f4d89be0015356be1d387f78~qlKsxOuEm0464204642epcas1p2I;
        Fri, 17 Jan 2020 05:14:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200117051442epsmtrp1d53e1aef5cca29871ae1b2997edb167e~qlKswgMob1370613706epsmtrp1R;
        Fri, 17 Jan 2020 05:14:42 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-3e-5e2142c2b43c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.B8.06569.2C2412E5; Fri, 17 Jan 2020 14:14:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200117051442epsmtip250cbf02491a6ec89bbff6f81d6410333~qlKsjapqP2225922259epsmtip2M;
        Fri, 17 Jan 2020 05:14:42 +0000 (GMT)
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Use PM QoS to set
 frequency limits
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d73e67eb-4f2d-dc4b-c718-929a964d3640@samsung.com>
Date:   Fri, 17 Jan 2020 14:22:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200116151219.v2.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmnu4hJ8U4g9dndSy+n/vJZDHvs6zF
        /CvXWC3ONr1ht1hx9yOrxeVdc9gsPvceYbT4vOExo8XtxhVsFk8e9rE5cHnMbrjI4rFz1l12
        j8V7XjJ53Lm2h81j47sdTB59W1YxenQcr/T4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs4
        3jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EQlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5x
        ia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGzOajTAUbtSpuXWxnamD8qdjFyMkh
        IWAi8fjwSuYuRi4OIYEdjBJ3929gBEkICXxilLh+SgEi8Y1RYsmNJ0wwHRtW/WKCSOxllFj6
        p5EVwnnPKPH90i+wKmGBMIlHVzaygCREBP4wSrS+/8cMkmAW6GeUmHE6EcRmE9CS2P/iBhuI
        zS+gKHH1x2Ow3bwCdhL79p5mAbFZBFQl2o5/B+sVBRp6clsLVI2gxMmZT8BqOAVCJU7OboOa
        Ly5x68l8JghbXmL72zlgz0kIzGOX2HNkBTvEDy4SN9fNZIWwhSVeHd8CFZeSeNnfBmVXS6w8
        eYQNormDUWLL/gtQDcYS+5dOBtrAAbRBU2L9Ln2IsKLEzt9zGSEW80m8+9rDClIiIcAr0dEm
        BFGiLHH5wV1oMEpKLG7vZJvAqDQLyTuzkLwwC8kLsxCWLWBkWcUollpQnJueWmxYYIIc3ZsY
        welXy2IH455zPocYBTgYlXh4ZwQpxAmxJpYVV+YeYpTgYFYS4T05QzZOiDclsbIqtSg/vqg0
        J7X4EKMpMLQnMkuJJucDc0NeSbyhqZGxsbGFiaGZqaGhkjjvdBegOQLpiSWp2ampBalFMH1M
        HJxSDYxh1od60lmedydffcCTPt/2VvWZ6n1HhdQsFWJX+7f0H5udrPHCf3G47+Tly65t4r3+
        023/pJ+FPjFMiftYpGYxCq940lAj+cdPOuFWv6ODOVPI2omWR/mKngqGlT8/Fvz8/fWAu5Pn
        1D1eJbTwkdv9mO1PeJKqdugXxR/47twdJFlvfPzCq6dKLMUZiYZazEXFiQBxR+8H1QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSvO4hJ8U4g2Uf+Cy+n/vJZDHvs6zF
        /CvXWC3ONr1ht1hx9yOrxeVdc9gsPvceYbT4vOExo8XtxhVsFk8e9rE5cHnMbrjI4rFz1l12
        j8V7XjJ53Lm2h81j47sdTB59W1YxenQcr/T4vEkugCOKyyYlNSezLLVI3y6BK2Nm81Gmgo1a
        FbcutjM1MP5U7GLk5JAQMJHYsOoXUxcjF4eQwG5Giaff1rJDJCQlpl08ytzFyAFkC0scPlwM
        UfOWUeL93F5WkBphgTCJhUf62EESIgL/GCWab25hA3GYBfqBqp71M0K0rGCUuPHvM9hYNgEt
        if0vbrCB2PwCihJXfzxmBLF5Bewk9u09zQJiswioSrQd/84MYosCrdi55DETRI2gxMmZT8Bq
        OAVCJU7ObgOrYRZQl/gz7xKULS5x68l8JghbXmL72znMExiFZyFpn4WkZRaSlllIWhYwsqxi
        lEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiORS2tHYwnTsQfYhTgYFTi4Z0RpBAnxJpY
        VlyZe4hRgoNZSYT35AzZOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtS
        i2CyTBycUg2MvFp17jpHRRlqPsxP2HLN+anmy1zJ6d+3bPnvyrvnmmy/cu5jg9X7DQ7qvNj1
        IS3t0O7b3OW1URVb9Z592sB2as1lqfSbE9i7Cu/Yr1W7OTlN2ZW9bOnr3ivXBRrbnj82dndf
        yWm3Y9pTnuiaGIn4f3xtujtnL1Crd76lcnoRu/Sriw+uBMtPU2Ipzkg01GIuKk4EAO0SppXB
        AgAA
X-CMS-MailID: 20200117051442epcas1p2bbaf74e1f4d89be0015356be1d387f78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116231233epcas1p363ab7e3ad2966d0ae7bac11e33aa6b83
References: <CGME20200116231233epcas1p363ab7e3ad2966d0ae7bac11e33aa6b83@epcas1p3.samsung.com>
        <20200116151219.v2.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/17/20 8:12 AM, Matthias Kaehlcke wrote:
> Now that devfreq supports limiting the frequency range of a device
> through PM QoS make use of it instead of disabling OPPs that should
> not be used.
> 
> The switch from disabling OPPs to PM QoS introduces a subtle behavioral
> change in case of conflicting requests (min > max): PM QoS gives
> precedence to the MIN_FREQUENCY request, while higher OPPs disabled
> with dev_pm_opp_disable() would override MIN_FREQUENCY.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v2:
> - added documentation for 'req_max_freq'
> - fixed jumps in of_devfreq_cooling_register_power() unwind
> - added comment about behavioral change to the commit message
> 
>  drivers/thermal/devfreq_cooling.c | 70 ++++++++++---------------------
>  1 file changed, 23 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index ef59256887ff63..cbbaf5bc425d1a 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -24,11 +24,13 @@
>  #include <linux/idr.h>
>  #include <linux/slab.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  #include <linux/thermal.h>
>  
>  #include <trace/events/thermal.h>
>  
> -#define SCALE_ERROR_MITIGATION 100
> +#define HZ_PER_KHZ		1000
> +#define SCALE_ERROR_MITIGATION	100
>  
>  static DEFINE_IDA(devfreq_ida);
>  
> @@ -53,6 +55,8 @@ static DEFINE_IDA(devfreq_ida);
>   *		'utilization' (which is	'busy_time / 'total_time').
>   *		The 'res_util' range is from 100 to (power_table[state] * 100)
>   *		for the corresponding 'state'.
> + * @req_max_freq:	PM QoS request for limiting the maximum frequency
> + *			of the devfreq device.
>   */
>  struct devfreq_cooling_device {
>  	int id;
> @@ -65,49 +69,9 @@ struct devfreq_cooling_device {
>  	struct devfreq_cooling_power *power_ops;
>  	u32 res_util;
>  	int capped_state;
> +	struct dev_pm_qos_request req_max_freq;
>  };
>  
> -/**
> - * partition_enable_opps() - disable all opps above a given state
> - * @dfc:	Pointer to devfreq we are operating on
> - * @cdev_state:	cooling device state we're setting
> - *
> - * Go through the OPPs of the device, enabling all OPPs until
> - * @cdev_state and disabling those frequencies above it.
> - */
> -static int partition_enable_opps(struct devfreq_cooling_device *dfc,
> -				 unsigned long cdev_state)
> -{
> -	int i;
> -	struct device *dev = dfc->devfreq->dev.parent;
> -
> -	for (i = 0; i < dfc->freq_table_size; i++) {
> -		struct dev_pm_opp *opp;
> -		int ret = 0;
> -		unsigned int freq = dfc->freq_table[i];
> -		bool want_enable = i >= cdev_state ? true : false;
> -
> -		opp = dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
> -
> -		if (PTR_ERR(opp) == -ERANGE)
> -			continue;
> -		else if (IS_ERR(opp))
> -			return PTR_ERR(opp);
> -
> -		dev_pm_opp_put(opp);
> -
> -		if (want_enable)
> -			ret = dev_pm_opp_enable(dev, freq);
> -		else
> -			ret = dev_pm_opp_disable(dev, freq);
> -
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
>  					 unsigned long *state)
>  {
> @@ -134,7 +98,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>  	struct devfreq_cooling_device *dfc = cdev->devdata;
>  	struct devfreq *df = dfc->devfreq;
>  	struct device *dev = df->dev.parent;
> -	int ret;
> +	unsigned long freq;
>  
>  	if (state == dfc->cooling_state)
>  		return 0;
> @@ -144,9 +108,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>  	if (state >= dfc->freq_table_size)
>  		return -EINVAL;
>  
> -	ret = partition_enable_opps(dfc, state);
> -	if (ret)
> -		return ret;
> +	freq = dfc->freq_table[state];
> +
> +	dev_pm_qos_update_request(&dfc->req_max_freq,
> +				  DIV_ROUND_UP(freq, HZ_PER_KHZ));
>  
>  	dfc->cooling_state = state;
>  
> @@ -529,9 +494,15 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  	if (err)
>  		goto free_dfc;
>  
> -	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
> +	err = dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,
> +				     DEV_PM_QOS_MAX_FREQUENCY,
> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
>  	if (err < 0)
>  		goto free_tables;
> +
> +	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
> +	if (err < 0)
> +		goto remove_qos_req;
>  	dfc->id = err;
>  
>  	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
> @@ -552,6 +523,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>  
>  release_ida:
>  	ida_simple_remove(&devfreq_ida, dfc->id);
> +
> +remove_qos_req:
> +	dev_pm_qos_remove_request(&dfc->req_max_freq);
> +
>  free_tables:
>  	kfree(dfc->power_table);
>  	kfree(dfc->freq_table);
> @@ -600,6 +575,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  
>  	thermal_cooling_device_unregister(dfc->cdev);
>  	ida_simple_remove(&devfreq_ida, dfc->id);
> +	dev_pm_qos_remove_request(&dfc->req_max_freq);
>  	kfree(dfc->power_table);
>  	kfree(dfc->freq_table);
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
