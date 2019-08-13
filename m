Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA08AF47
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 08:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfHMGKZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 02:10:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:36775 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfHMGKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 02:10:25 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190813061020epoutp04101bd30b7fb8f4b2d856abcf75da1c8f~6Zpc9N8UH1263812638epoutp04W
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 06:10:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190813061020epoutp04101bd30b7fb8f4b2d856abcf75da1c8f~6Zpc9N8UH1263812638epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565676620;
        bh=0AYKYCJkMqvSTFa3lwIWHRmGu/K1850Hl8DPO8644gg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=c3WgBI+fLaA7g32tXyJcztRx5jVcIKHRWC4QoEJmtoxiCjAez49KGGKUtgYW7lTQ9
         r6esRutrql0Ki+QBi4npfol86WSjRHzZM/we3c0WPNhjeinhdvfFo1UY6azwpEefWc
         Z7lRjp3qDAQ/GxJBB4HryJOF0xS14oK2DuzZIYsw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190813061019epcas1p2e12d35fabb496531b64b85df733af5f8~6Zpcf0gMc0759607596epcas1p2l;
        Tue, 13 Aug 2019 06:10:19 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4672Ph4Zr3zMqYm1; Tue, 13 Aug
        2019 06:10:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.1D.04088.744525D5; Tue, 13 Aug 2019 15:10:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190813061015epcas1p3c69ec11a5648f3a3b54d83ae61919ac0~6ZpYPadHa2559425594epcas1p3p;
        Tue, 13 Aug 2019 06:10:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190813061015epsmtrp234b48cb08bcbe52563ece6b9312d8eef~6ZpYOfJHk2073520735epsmtrp2S;
        Tue, 13 Aug 2019 06:10:15 +0000 (GMT)
X-AuditID: b6c32a35-cb2cd9c000000ff8-a1-5d525447f3e2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.33.03706.644525D5; Tue, 13 Aug 2019 15:10:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813061014epsmtip2ea4618392ce7a66ae5fca3daada4c0e3~6ZpX__gCN0101301013epsmtip2g;
        Tue, 13 Aug 2019 06:10:14 +0000 (GMT)
Subject: Re: [PATCHv2] PM / devfreq: Add dev_pm_qos support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b3941b19-f0aa-87a6-d50a-299d07a26532@samsung.com>
Date:   Tue, 13 Aug 2019 15:14:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e45c28528ff941abb1f72fdb1eedf65fb3345c5a.1565274802.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmvq57SFCswcsmaYtDx7ayW3w9fYrR
        4uUhTYvpezexWZw/v4Hd4mzTG3aLWw0yFivufmS12PT4GqvF594jjBa3G1ewWZw5fYnVouvQ
        XzaLjV89HPg83t9oZfdYsKnUY9OqTjaPO9f2sHlsXlLvsfHdDiaPg+/2MHlsudrO4tG3ZRWj
        x+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
        OUDXKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0M
        jEyBChOyM/oP+Rac9KnYs/IXUwPjfLsuRk4OCQETiUVHNzB2MXJxCAnsYJS4t2AyO4TziVHi
        TMsGVgjnG6PE7s5ONpiW+wu/QVXtZZS4/u8NK0hCSOA9o8Ta/4kgtrCAtcSyj7OYQWwRgVWM
        ElMfG4I0MAtsZZbYuP01WIJNQEti/4sbYFP5BRQlrv54zAhi8wrYSWw5+YIFxGYRUJU4+vs4
        O4gtKhAh8enBYVaIGkGJkzOfgNVwCsRJzL/wG2wOs4C4xK0n85kgbHmJ5q2zmUEWSwgcY5c4
        u/0UUBEHkOMicetxMsQ3whKvjm9hh7ClJD6/2wv1ZbXEypNH2CB6Oxgltuy/wAqRMJbYv3Qy
        E8gcZgFNifW79CHCihI7f89lhLB5JRo2/maHuIFP4t3XHlaItbwSHW1CECXKEpcf3GWawKg8
        C8k3s5B8MAvJB7MQli1gZFnFKJZaUJybnlpsWGCIHNmbGMEJW8t0B+OUcz6HGAU4GJV4eCsS
        AmOFWBPLiitzDzFKcDArifBeMgmKFeJNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5wGySVxJv
        aGpkbGxsYWJoZmpoqCTOu/CHRayQQHpiSWp2ampBahFMHxMHp1QDI3eUxJTprK8mxHHmKt5x
        enSgWFzFcArDiRnqM/5dF3uknxnCE/y5yPS+rle43hP7584KDRw8PCFMPh9fxc94u+b45FlH
        Tv49qrkjL/bKrq43sxKnn2DOe7zq5bmd36OXB61tL1tdZ/ifq+TUv4ayiak2C6VvJ7QX7TJY
        8K/QMYvnNFNnwvYqXyWW4oxEQy3mouJEAGReNMTuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCSvK57SFCswYafTBaHjm1lt/h6+hSj
        xctDmhbT925iszh/fgO7xdmmN+wWtxpkLFbc/chqsenxNVaLz71HGC1uN65gszhz+hKrRdeh
        v2wWG796OPB5vL/Ryu6xYFOpx6ZVnWwed67tYfPYvKTeY+O7HUweB9/tYfLYcrWdxaNvyypG
        j8+b5AK4orhsUlJzMstSi/TtErgy+g/5Fpz0qdiz8hdTA+N8uy5GTg4JAROJ+wu/sXcxcnEI
        CexmlJg6Zw0jREJSYtrFo8xdjBxAtrDE4cPFEDVvGSUO/57FBFIjLGAtsezjLGaQhIjAGkaJ
        13tamEAcZoGdzBITbs1ng2jZyCixZtFZNpAWNgEtif0vboDZ/AKKEld/PAZbxytgJ7Hl5AsW
        EJtFQFXi6O/j7CC2qECExOEds6BqBCVOznwCVsMpECcx/8JvsDnMAuoSf+ZdYoawxSVuPZnP
        BGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k
        /NxNjOD41dLcwXh5SfwhRgEORiUe3oqEwFgh1sSy4srcQ4wSHMxKIryXTIJihXhTEiurUovy
        44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamDka8hUmnhhumiR2/cPc5i8
        Vu42Kdx1KU08J5Jn7ZsITeb6f2caJj9erJrwTvf3FrmT7dNLviwXbpnbwJCkvPn41GV9lufd
        V3W+CN1gPvVFS0XUk/nfdF+Vfr8wKXjDI4kuGeulPBKzWcqe1ZjKLni5Z1ue7IYHB6SXXbKo
        fNfb7nfkufXiC0Y2SizFGYmGWsxFxYkAjx/mZNsCAAA=
X-CMS-MailID: 20190813061015epcas1p3c69ec11a5648f3a3b54d83ae61919ac0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190808143919epcas4p33c93a5a3d4df1032fa84ddad9110a160
References: <CGME20190808143919epcas4p33c93a5a3d4df1032fa84ddad9110a160@epcas4p3.samsung.com>
        <e45c28528ff941abb1f72fdb1eedf65fb3345c5a.1565274802.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

In case of cpufreq, cpufreq.c replace the body of store_min_freq()
and store_max_freq() by using struct dev_pm_qos_request instancce
with dev_pm_qos_update_request().

If you use the new way with dev_pm_qos_update_request() for
min_freq_store() and max_freq_store(), it doesn't need to
get the final frequency from three candidate frequencies.

In result, We only consider the following two candidate frequencies
as following:
1. "devfreq->scaling_min_freq" will contain the requirement
   from devfreq thermal throttling by OPP interface.
2. "devfreq->min_freq" will contain the requirements
   from both user input through sysfs and the dev_pm_qos_request.

On 19. 8. 8. 오후 11:39, Leonard Crestez wrote:
> Add dev_pm_qos notifies to devfreq core in order to support frequency
> limits via the dev_pm_qos_add_request.
>
> Unlike the rest of devfreq the dev_pm_qos frequency is measured Khz:
> this is consistent with current dev_pm_qos usage for cpufreq and allows
> frequencies above 2Ghz (pm_qos expresses limits as s32).
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>
> ---
> Changes since v1:
>  * Add doxygen comments for min_nb/max_nb
>  * Remove notifiers on error/cleanup paths. Keep gotos simple by relying
> on dev_pm_qos_remove_notifier ignoring notifiers which were not added.
> Link to v1: https://patchwork.kernel.org/patch/11078475/
>
>  drivers/devfreq/devfreq.c | 83 ++++++++++++++++++++++++++++++++++-----
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 79 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 784c08e4f931..7f1f273562f4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -22,10 +22,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
> +#include <linux/pm_qos.h>
>  #include "governor.h"
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/devfreq.h>
>  
> @@ -96,10 +97,26 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  		dev_pm_opp_put(opp);
>  
>  	return max_freq;
>  }
>  
> +static unsigned long get_effective_min_freq(struct devfreq *devfreq)
> +{
> +	return max3(devfreq->scaling_min_freq, devfreq->min_freq,
> +		1000 * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent,
> +				DEV_PM_QOS_MIN_FREQUENCY));

As I commented above, if we use the dev_pm_qos_request, it is not needed.

> +}
> +
> +static unsigned long get_effective_max_freq(struct devfreq *devfreq)
> +{
> +	return min3(devfreq->scaling_max_freq, devfreq->max_freq,
> +		1000 * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent,
> +				DEV_PM_QOS_MAX_FREQUENCY));
> +}

ditto.

> +
>  /**
>   * devfreq_get_freq_level() - Lookup freq_table for the frequency
>   * @devfreq:	the devfreq instance
>   * @freq:	the target frequency
>   */
> @@ -356,12 +373,12 @@ int update_devfreq(struct devfreq *devfreq)
>  	 *
>  	 * List from the highest priority
>  	 * max_freq
>  	 * min_freq
>  	 */
> -	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
> -	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
> +	max_freq = get_effective_max_freq(devfreq);
> +	min_freq = get_effective_min_freq(devfreq);
>  
>  	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
> @@ -570,10 +587,31 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  	mutex_unlock(&devfreq->lock);
>  
>  	return ret;
>  }
>  
> +static int devfreq_qos_notifier_call(struct devfreq *devfreq)
> +{
> +	int ret;
> +
> +	mutex_lock(&devfreq->lock);
> +	ret = update_devfreq(devfreq);
> +	mutex_unlock(&devfreq->lock);
> +
> +	return ret;
> +}
> +
> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb, unsigned long val, void *ptr)

Please keep the under 80 line if there are no any special reason.

> +{
> +	return devfreq_qos_notifier_call(container_of(nb, struct devfreq, nb_min));

ditto.

> +}
> +
> +static int devfreq_qos_max_notifier_call(struct notifier_block *nb, unsigned long val, void *ptr)

ditto.

> +{
> +	return devfreq_qos_notifier_call(container_of(nb, struct devfreq, nb_max));

ditto.

> +}
> +
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:	the devfreq device
>   *
>   * Remove devfreq from the list and release its resources.
> @@ -592,10 +630,14 @@ static void devfreq_dev_release(struct device *dev)
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +			DEV_PM_QOS_MAX_FREQUENCY);
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +			DEV_PM_QOS_MIN_FREQUENCY);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
>  
>  /**
> @@ -636,21 +678,44 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
>  
>  	mutex_init(&devfreq->lock);
> -	mutex_lock(&devfreq->lock);
>  	devfreq->dev.parent = dev;
>  	devfreq->dev.class = devfreq_class;
>  	devfreq->dev.release = devfreq_dev_release;
>  	devfreq->profile = profile;
>  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
> +	/*
> +	 * notifier from pm_qos
> +	 *
> +	 * initialized outside of devfreq->lock to avoid circular warning
> +	 * between devfreq->lock and dev_pm_qos_mtx
> +	 */
> +	devfreq->nb_min.notifier_call = devfreq_qos_min_notifier_call;
> +	devfreq->nb_max.notifier_call = devfreq_qos_max_notifier_call;
> +
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +				      DEV_PM_QOS_MIN_FREQUENCY);
> +	if (err) {
> +		dev_err(dev, "Failed to register MIN QoS notifier: %d\n", err);
> +		goto err_dev;
> +	}
> +
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +				      DEV_PM_QOS_MAX_FREQUENCY);
> +	if (err) {
> +		dev_err(dev, "Failed to register MAX QoS notifier: %d\n", err);
> +		goto err_dev;
> +	}
> +
> +	mutex_lock(&devfreq->lock);
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
>  			goto err_dev;
> @@ -741,10 +806,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	mutex_unlock(&devfreq_list_lock);
>  err_devfreq:
>  	devfreq_remove_device(devfreq);
>  	devfreq = NULL;
>  err_dev:
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +			DEV_PM_QOS_MAX_FREQUENCY);
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +			DEV_PM_QOS_MIN_FREQUENCY);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(devfreq_add_device);
> @@ -1311,13 +1380,11 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> -	struct devfreq *df = to_devfreq(dev);
> -
> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
> +	return sprintf(buf, "%lu\n", get_effective_min_freq(to_devfreq(dev)));
>  }
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -1356,13 +1423,11 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  static DEVICE_ATTR_RW(min_freq);
>  
>  static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> -	struct devfreq *df = to_devfreq(dev);
> -
> -	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
> +	return sprintf(buf, "%lu\n", get_effective_max_freq(to_devfreq(dev)));
>  }
>  static DEVICE_ATTR_RW(max_freq);
>  
>  static ssize_t available_frequencies_show(struct device *d,
>  					  struct device_attribute *attr,
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2bae9ed3c783..8b92ccbd1962 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -134,10 +134,12 @@ struct devfreq_dev_profile {
>   * @total_trans:	Number of devfreq transitions
>   * @trans_table:	Statistics of devfreq transitions
>   * @time_in_state:	Statistics of devfreq states
>   * @last_stat_updated:	The last time stat updated
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> + * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
> + * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>   *
>   * This structure stores the devfreq information for a give device.
>   *
>   * Note that when a governor accesses entries in struct devfreq in its
>   * functions except for the context of callbacks defined in struct
> @@ -176,10 +178,13 @@ struct devfreq {
>  	unsigned int *trans_table;
>  	unsigned long *time_in_state;
>  	unsigned long last_stat_updated;
>  
>  	struct srcu_notifier_head transition_notifier_list;
> +
> +	struct notifier_block nb_min;
> +	struct notifier_block nb_max;
>  };
>  
>  struct devfreq_freqs {
>  	unsigned long old;
>  	unsigned long new;
>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

