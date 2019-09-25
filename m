Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB28BD61D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391843AbfIYBcr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 21:32:47 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14146 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390869AbfIYBcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 21:32:46 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190925013242epoutp01e0eaf74348add22cbbccaa527d8388fa~HimVTRn5H2555125551epoutp011
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 01:32:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190925013242epoutp01e0eaf74348add22cbbccaa527d8388fa~HimVTRn5H2555125551epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569375162;
        bh=ur4DoEMusld0e9RjxdZjAgtxIbRb4ZV3adi0CPu8o78=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jNkM2l/8RezcWOY4t8FVtTW76MdDxMZzhrBzPzKXlDsuqsNvjenrG55oaKw5BTVzc
         TbXCEUl9bJqD1GLWuEDZBHF/JQVDkWQVRVu2nuzyqZSCdjscGjXHN2GvM5ukJoIk0U
         /xhuO1cH41xrcgqrMeFpYdbuVL5s4Ppua2Z5yFTI=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925013242epcas1p1b2564d68f09c72e5822bc41e4cd368e0~HimUxkm--1303813038epcas1p1G;
        Wed, 25 Sep 2019 01:32:42 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46dLCX05k9zMqYkb; Wed, 25 Sep
        2019 01:32:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.71.04085.7B3CA8D5; Wed, 25 Sep 2019 10:32:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925013239epcas1p2503b3f3fdeca392a3ba340c5d0f15e87~HimSQFPpm0836508365epcas1p2V;
        Wed, 25 Sep 2019 01:32:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925013239epsmtrp1c3e72e1b3297766161491705d68965f5~HimSPEQUJ2356223562epsmtrp1a;
        Wed, 25 Sep 2019 01:32:39 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-fa-5d8ac3b7c359
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.85.04081.7B3CA8D5; Wed, 25 Sep 2019 10:32:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925013239epsmtip25c88accb48258e2217fb4bfa6af2f6e9~HimR8Fif11932219322epsmtip2W;
        Wed, 25 Sep 2019 01:32:39 +0000 (GMT)
Subject: Re: [PATCH v8 4/6] PM / devfreq: Introduce get_freq_range helper
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fe6845b9-4e20-3dad-0178-97b216e858e7@samsung.com>
Date:   Wed, 25 Sep 2019 10:37:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <674fe91065034083fd7c8c1810305cd01551bb80.1569319738.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmvu72w12xBgd+WFkcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4AeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfm
        Fpfmpesl5+daGRoYGJkCFSZkZ7yc/ZyxYIJ1xfyLS1kbGFfodTFyckgImEh82PiQpYuRi0NI
        YAejxNfOfnYI5xOjxPT5j5khnG+MEp8vNTLDtBxZ2MYGkdjLKPF/YjNU1XtGiUk/jzGCVAkL
        eEpsud0LViUisJpRomXpHbAEs8ATZok96+VBbDYBLYn9L26wgdj8AooSV388BqvhFbCTaGhY
        zw5iswioSjxuXAxmiwpESHx6cJgVokZQ4uTMJ0CXc3BwCsRJHF6cAjFeXOLWk/lMELa8RPPW
        2WDHSQicY5f4eL2FBeIFF4lLR6YwQtjCEq+Ob2GHsKUkXva3QdnVEitPHmGDaO5glNiy/wIr
        RMJYYv/SyUwgi5kFNCXW79KHCCtK7Pw9F+pHPol3X3tYQUokBHglOtqEIEqUJS4/uMsEYUtK
        LG7vZJvAqDQLyTezkLwwC8kLsxCWLWBkWcUollpQnJueWmxYYIwc3ZsYwalcy3wH44ZzPocY
        BTgYlXh4HVi7YoVYE8uKK3MPMUpwMCuJ8M6SAQrxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHk
        fGCeySuJNzQ1MjY2tjAxNDM1NFQS5/VIb4gVEkhPLEnNTk0tSC2C6WPi4JRqYORKk+3ObLP6
        snKa+ZzjOku+GF5/w543+fwVgTorB1+H8Pqdit9ezbtiyTyvbOob/yW200pCdk+9ePvB+v3b
        Q6xEFsgV9AoznZ/2lnvGJu/5egFil/T+7Yly9vq2Ks353O2ZW2+tkt4sJnBppqv8i8m2+cJ3
        Sq9PkDF3Oq+VN8/d0pDdjWWF8CclluKMREMt5qLiRAAjIgrw+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSvO72w12xBiv/y1scOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyXs5+zlgwwbpi/sWlrA2MK/S6GDk5
        JARMJI4sbGMDsYUEdjNK/PzjDRGXlJh28ShzFyMHkC0scfhwcRcjF1DJW0aJHyf+gdULC3hK
        bLndC2aLCKxllJhz3gHEZhZ4xixxYlcaRMMjRonF09ezgiTYBLQk9r+4AdbAL6AocfXHY0YQ
        m1fATqKhYT07iM0ioCrxuHExmC0qECFxeMcsqBpBiZMzn7CAHMQpECdxeHEKxC51iT/zLjFD
        2OISt57MZ4Kw5SWat85mnsAoPAtJ9ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFi
        bnFpXrpecn7uJkZwPGtp7mC8vCT+EKMAB6MSD68Da1esEGtiWXFl7iFGCQ5mJRHeWTJAId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhh5N0bP6D/5+4v5
        6WnJnzZd3BCiIl/28N31yogzJdd606R3b7K5zahg2//n1H7RwldM7jUTvx+cXvPIZ6K9zJI5
        i5p8lDNjczYf/JyqNz1RooFlkuWq5wc0v1UL3Tla5HTTelHzV6l3EQzy52/Pnsia1rnT+PgL
        10qmTX7iKpfjS46fzxZbw1mgxFKckWioxVxUnAgA8ToSFOMCAAA=
X-CMS-MailID: 20190925013239epcas1p2503b3f3fdeca392a3ba340c5d0f15e87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924101141epcas4p357c10af190e97f1c77098cd66cb313ab
References: <cover.1569319738.git.leonard.crestez@nxp.com>
        <CGME20190924101141epcas4p357c10af190e97f1c77098cd66cb313ab@epcas4p3.samsung.com>
        <674fe91065034083fd7c8c1810305cd01551bb80.1569319738.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
> Moving handling of min/max freq to a single function and call it from
> update_devfreq and for printing min/max freq values in sysfs.
> 
> This changes the behavior of out-of-range min_freq/max_freq: clamping
> is now done at evaluation time. This means that if an out-of-range
> constraint is imposed by sysfs and it later becomes valid then it will
> be enforced.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 112 ++++++++++++++++++++++----------------
>  1 file changed, 64 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4a878baa809e..eee403e70c84 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -96,10 +96,54 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  		dev_pm_opp_put(opp);
>  
>  	return max_freq;
>  }
>  
> +/**
> + * get_freq_range() - Get the current freq range
> + * @devfreq:	the devfreq instance
> + * @min_freq:	the min frequency
> + * @max_freq:	the max frequency
> + *
> + * This takes into consideration all constraints.
> + */
> +static void get_freq_range(struct devfreq *devfreq,
> +			   unsigned long *min_freq,
> +			   unsigned long *max_freq)
> +{
> +	unsigned long *freq_table = devfreq->profile->freq_table;
> +
> +	lockdep_assert_held(&devfreq->lock);
> +
> +	/*
> +	 * Init min/max frequency from freq table.

Init -> Initialize
min/max -> minimum/maximum 

> +	 * Drivers can initialize this in either ascending or descending order

Drivers -> devfreq drivers

> +	 * and devfreq core supports both.
> +	 */


In result, I prefer to change the comments as following: 
	/*
	 * Initialize the minimum/maximum frequency from freq_table.
 	 * The devfreq drivers can initialize freq_table in either
	 * ascending or descending order and devfreq core supports both.
	 */

> +	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
> +		*min_freq = freq_table[0];
> +		*max_freq = freq_table[devfreq->profile->max_state - 1];
> +	} else {
> +		*min_freq = freq_table[devfreq->profile->max_state - 1];
> +		*max_freq = freq_table[0];
> +	}
> +
> +	/* constraints from sysfs */

'constraints' -> Constraint because first verb have to be used
as the sigular verbs. Also, I think that have to enhance the comments
I prefer to use following comments: 

	 /* Constraint minimum/maximum frequency from user input via sysfs */



> +	*min_freq = max(*min_freq, devfreq->min_freq);
> +	*max_freq = min(*max_freq, devfreq->max_freq);
> +
> +	/* constraints from OPP interface */

ditto. I prefer to use following comments: 

	/* Constraint minimum/maximum frequency from OPP interface */


> +	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
> +	/* scaling_max_freq can be zero on error */

Please remove it.

> +	if (devfreq->scaling_max_freq)

As I knew, devfreq->scaling_max_freq is never zero.
So, it is always true. This if statement is needed.

> +		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> +
> +	/* max_freq takes precedence over min_freq */

As I said, almost people know that min_freq have be under than max_freq.
Please remove it. And until finishing the discussion on mailing list,
please don't send the next version. If you just replied from my comment
and then wait my next comment, we can save the time without replying
the repetitive and same comment for same point.

> +	if (*min_freq > *max_freq)
> +		*min_freq = *max_freq;
> +}
> +
>  /**
>   * devfreq_get_freq_level() - Lookup freq_table for the frequency
>   * @devfreq:	the devfreq instance
>   * @freq:	the target frequency
>   */
> @@ -349,20 +393,11 @@ int update_devfreq(struct devfreq *devfreq)
>  
>  	/* Reevaluate the proper frequency */
>  	err = devfreq->governor->get_target_freq(devfreq, &freq);
>  	if (err)
>  		return err;
> -
> -	/*
> -	 * Adjust the frequency with user freq, QoS and available freq.
> -	 *
> -	 * List from the highest priority
> -	 * max_freq
> -	 * min_freq
> -	 */
> -	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
> -	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
> +	get_freq_range(devfreq, &min_freq, &max_freq);
>  
>  	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
> @@ -1298,40 +1333,28 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -
> -	if (value) {
> -		if (value > df->max_freq) {
> -			ret = -EINVAL;
> -			goto unlock;
> -		}
> -	} else {
> -		unsigned long *freq_table = df->profile->freq_table;
> -
> -		/* Get minimum frequency according to sorting order */
> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> -			value = freq_table[0];
> -		else
> -			value = freq_table[df->profile->max_state - 1];
> -	}
> -
>  	df->min_freq = value;
>  	update_devfreq(df);
> -	ret = count;
> -unlock:
>  	mutex_unlock(&df->lock);
> -	return ret;
> +
> +	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	unsigned long min_freq, max_freq;
> +
> +	mutex_lock(&df->lock);
> +	get_freq_range(df, &min_freq, &max_freq);
> +	mutex_unlock(&df->lock);
>  
> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
> +	return sprintf(buf, "%lu\n", min_freq);
>  }
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -1343,40 +1366,33 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
>  
> -	if (value) {
> -		if (value < df->min_freq) {
> -			ret = -EINVAL;
> -			goto unlock;
> -		}
> -	} else {
> -		unsigned long *freq_table = df->profile->freq_table;
> -
> -		/* Get maximum frequency according to sorting order */
> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> -			value = freq_table[df->profile->max_state - 1];
> -		else
> -			value = freq_table[0];
> -	}
> +	/* Interpret zero as "don't care" */

Please remove it. Also, the detailed comment for user have to add
the documentation file. 

> +	if (!value)
> +		value = ULONG_MAX;
>  
>  	df->max_freq = value;
>  	update_devfreq(df);
> -	ret = count;
> -unlock:
>  	mutex_unlock(&df->lock);
> -	return ret;
> +
> +	return count;
>  }
>  static DEVICE_ATTR_RW(min_freq);
>  
>  static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	unsigned long min_freq, max_freq;
> +
> +	mutex_lock(&df->lock);
> +	get_freq_range(df, &min_freq, &max_freq);
> +	mutex_unlock(&df->lock);
>  
> -	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
> +	return sprintf(buf, "%lu\n", max_freq);
>  }
>  static DEVICE_ATTR_RW(max_freq);
>  
>  static ssize_t available_frequencies_show(struct device *d,
>  					  struct device_attribute *attr,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
