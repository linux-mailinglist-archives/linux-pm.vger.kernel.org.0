Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB6C117D4F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 02:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLJBla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 20:41:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49495 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfLJBla (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 20:41:30 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191210014127epoutp02ecfbec772d56e2d2d5c13773c05f81a3~e3vqHaLDf1382413824epoutp02Q
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 01:41:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191210014127epoutp02ecfbec772d56e2d2d5c13773c05f81a3~e3vqHaLDf1382413824epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575942087;
        bh=tNdal5xb8XfGZAbELHyE2Os/t+aByfUOa0eudCUQQgs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nQ62bwWgGhb7SLp/gRQF4HfM05z5zIuNbRuxc56x3gU0fKBof5uVXlufnktF4zFdo
         YEP65lGjvBI+H5nC9iWDk3zODmFNCTnThCq2y4ZfWvaxJmCx70ASRzqvTSQWt66asl
         Nx709Cm2vqEWiA6T1+R/4gRvzmhHqtCWaHqf2G6M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191210014126epcas1p1bb0942bcbce8ad3e42df829ed4dd8b9c~e3vpjfEVU2674426744epcas1p1w;
        Tue, 10 Dec 2019 01:41:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47X2pZ4590zMqYkx; Tue, 10 Dec
        2019 01:41:26 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.F1.48498.6C7FEED5; Tue, 10 Dec 2019 10:41:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210014126epcas1p2dc2a8af6145d962942995e936ef32abd~e3vpCrhHv2461624616epcas1p2J;
        Tue, 10 Dec 2019 01:41:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191210014126epsmtrp2b7f1b9e5e2cf1683cccc3507794db681~e3vpB2vFF1553115531epsmtrp2B;
        Tue, 10 Dec 2019 01:41:26 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-a7-5deef7c6ef70
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.EB.10238.5C7FEED5; Tue, 10 Dec 2019 10:41:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191210014125epsmtip24d10ddbe72dad8f9d32223276720d860~e3vozteFd1076410764epsmtip2o;
        Tue, 10 Dec 2019 01:41:25 +0000 (GMT)
Subject: Re: [PATCH 2/4] PM / devfreq: add possibility for delayed work
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2881c0b8-9d05-aa5f-c216-8d5a09eb0b00@samsung.com>
Date:   Tue, 10 Dec 2019 10:47:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191209144425.13321-3-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmru6x7+9iDa6dUbTYOGM9q8WCTzNY
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xe3GFWwOHB6bVnWyefRtWcXo8XmTXABzVLZN
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjHu3
        Z7MV3NOtaJ59gLGBcYpqFyMnh4SAicTfy4+Yuxi5OIQEdjBKTGh/yQThfGKUmPRvJwuE841R
        4vONc+wwLa+W90BV7WWU+H35LgtIQkjgPaPErVWCILawgLvE7OZbrCC2iICuxJsdS8F2MAvM
        Y5J4M+0CWIJNQEti/4sbbCA2v4CixNUfjxlBbF4BO4l3X7YygdgsAqoS35fvYgaxRQXCJE5u
        a4GqEZQ4OfMJ2GJOAVuJd3ePg9UwC4hL3HoynwnClpfY/nYO2GIJgddsEg+332GBeMFFYvOp
        PlYIW1ji1fEtUK9JSXx+t5cNwq6WWHnyCBtEcwejxJb9F6AajCX2L50MtIEDaIOmxPpd+hBh
        RYmdv+cyQizmk3j3tYcVpERCgFeio00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQvDMLyQuzkLww
        C2HZAkaWVYxiqQXFuempxYYFRsjRvYkRnDy1zHYwLjrnc4hRgINRiYd3gcO7WCHWxLLiytxD
        jBIczEoivMfbgEK8KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5jY80riDU2NjI2NLUwMzUwN
        DZXEeTl+XIwVEkhPLEnNTk0tSC2C6WPi4JRqYFw8i2Gtr6XgG8/Xgg82rPgkWh+SeGvxvU9V
        u1WNfqTu6F7WcWXW6YAg7Vo+3sBJd+f6Wn1pmmFUv/W+7Qf9/Y2lHTf2ZXPznHv9Lv/cdM/f
        9xz/z9CQD/2s+/hQTVXWV7n2kpN6O9Y6dD22TAk+tkjk9NdyxQb2REuFB+v4p5/waSttWJyk
        nKLEUpyRaKjFXFScCAD5jqyxtAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvfo93exBrtO2VhsnLGe1WLBpxms
        FufPb2C3ONv0ht3i8q45bBafe48wWqw9cpfd4nbjCjYHDo9NqzrZPPq2rGL0+LxJLoA5issm
        JTUnsyy1SN8ugSvj3u3ZbAX3dCuaZx9gbGCcotrFyMkhIWAi8Wp5D1MXIxeHkMBuRokDs8+x
        QCQkJaZdPMrcxcgBZAtLHD5cDFHzllHi8uznbCA1wgLuErObb7GC2CICuhJvdixlBiliFljA
        JDH/5kQWiI7DjBLnF1wBq2IT0JLY/+IGWDe/gKLE1R+PGUFsXgE7iXdftjKB2CwCqhLfl+9i
        BrFFBcIkdi55zARRIyhxcuYTsOs4BWwl3t09DlbDLKAu8WfeJShbXOLWk/lMELa8xPa3c5gn
        MArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxHWpo7
        GC8viT/EKMDBqMTDu8DhXawQa2JZcWXuIUYJDmYlEd7jbUAh3pTEyqrUovz4otKc1OJDjNIc
        LErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGFfPfdKjqhdYcGPOocqNWgvC3hm6f80zbEr8
        +8zv7fmaqo9x1Yan+pRv/5xRXvXZze/FArmkfu2++kUSfyQ3Fz58zP7m94/matlwjnkxb/7v
        mVB9+FCsRK+jkew/E9eJ0QIPbPg9+Fx51JKv/+9g/Czy3u3XcsmgmYZOsiZdd1T+/Kj97Dzh
        ixJLcUaioRZzUXEiAMdeu3SfAgAA
X-CMS-MailID: 20191210014126epcas1p2dc2a8af6145d962942995e936ef32abd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5@eucas1p2.samsung.com>
        <20191209144425.13321-3-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/9/19 11:44 PM, Kamil Konieczny wrote:
> Current devfreq workqueue uses deferred timer. Introduce sysfs
> file delayed_timer and use it for change from deferred to
> delayed work. The default is to use old deferred one, which
> saves power, but can miss increased demand for higher bus
> frequency if timer was assigned to idle cpu.

As I commented on patch1, If you hope to change the feature
related to both performance  and power-consumption, 
you have to suggest the reasonable data with test result
on multiple scenarios.

Firstly,
I don't agree to add 'delayed_timer' sysfs entries.
If some device driver want to use the different type of
workqueue, they can choice the workqueue type in the
probe function of device driver. 

Secondly, the 'dealyed_timer' is not for all devfreq
device driver. Only devfreq device driver uses the
'simple_ondemand' governor. It is wrong to show
without any specific reason.


If you suggest the reasonable data with test result,
I prefer to add the new flag to 'struct devfreq_dev_profile'.

> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-class-devfreq | 10 ++++
>  drivers/devfreq/devfreq.c                     | 46 ++++++++++++++++++-
>  include/linux/devfreq.h                       |  2 +
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 9758eb85ade3..07bfd0df6a4a 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -30,6 +30,16 @@ Description:
>  		target_freq when get_cur_freq() is not implemented by
>  		devfreq driver.
>  
> +What:		/sys/class/devfreq/.../delayed_timer
> +Date:		December 2019
> +Contact:	Kamil Konieczny <k.konieczny@samsung.com>
> +Description:
> +		This ABI shows or clears timer type used by devfreq
> +		workqueue. When 0, it uses default deferred timer.
> +		When set to 1 devfreq will use delayed timer. Example
> +		useage:
> +			echo 1 > /sys/class/devfreq/.../delayed_timer
> +
>  What:		/sys/class/devfreq/.../target_freq
>  Date:		September 2012
>  Contact:	Rajagopal Venkat <rajagopal.venkat@linaro.org>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 955949c6fc1f..c277d1770fef 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -445,7 +445,11 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>  	if (devfreq->governor->interrupt_driven)
>  		return;
>  
> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +	if (devfreq->delayed_timer)
> +		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
> +	else
> +		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +
>  	if (devfreq->profile->polling_ms)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
> @@ -698,6 +702,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
> +	devfreq->delayed_timer = false;
>  
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>  		mutex_unlock(&devfreq->lock);
> @@ -1288,6 +1293,44 @@ static ssize_t available_governors_show(struct device *d,
>  }
>  static DEVICE_ATTR_RO(available_governors);
>  
> +static ssize_t delayed_timer_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	int i;
> +
> +	i = to_devfreq(dev)->delayed_timer ? 1 : 0;
> +	return sprintf(buf, "%d\n", i);
> +}
> +
> +static ssize_t delayed_timer_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct devfreq *df = to_devfreq(dev);
> +	bool old_timer;
> +	int value, ret;
> +
> +	if (!df->governor)
> +		return -EINVAL;
> +
> +	ret = kstrtoint(buf, 10, &value);
> +	if (ret || (value != 1 && value != 0))
> +		return -EINVAL;
> +
> +	mutex_lock(&df->lock);
> +	old_timer = df->delayed_timer;
> +	df->delayed_timer = value == 0 ? false : true;
> +	mutex_unlock(&df->lock);
> +
> +	if (old_timer != df->delayed_timer) {
> +		devfreq_monitor_stop(df);
> +		devfreq_monitor_start(df);
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(delayed_timer);
> +
>  static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> @@ -1513,6 +1556,7 @@ static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_name.attr,
>  	&dev_attr_governor.attr,
>  	&dev_attr_available_governors.attr,
> +	&dev_attr_delayed_timer.attr,
>  	&dev_attr_cur_freq.attr,
>  	&dev_attr_available_frequencies.attr,
>  	&dev_attr_target_freq.attr,
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index de2fdc56aa5b..761aa0a09db7 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -134,6 +134,7 @@ struct devfreq_stats {
>   *		reevaluate operable frequencies. Devfreq users may use
>   *		devfreq.nb to the corresponding register notifier call chain.
>   * @work:	delayed work for load monitoring.
> + * @delayed_timer:	use delayed or deferred timer for workqueue.
>   * @previous_freq:	previously configured frequency value.
>   * @data:	Private data of the governor. The devfreq framework does not
>   *		touch this.
> @@ -166,6 +167,7 @@ struct devfreq {
>  	char governor_name[DEVFREQ_NAME_LEN];
>  	struct notifier_block nb;
>  	struct delayed_work work;
> +	bool delayed_timer;
>  
>  	unsigned long previous_freq;
>  	struct devfreq_dev_status last_status;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
