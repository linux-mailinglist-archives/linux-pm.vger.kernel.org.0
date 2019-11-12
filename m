Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12421F857E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 01:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKLAlO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 19:41:14 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:17978 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKLAlN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 19:41:13 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191112004111epoutp01ce20b44c46474b9c27a77005aac9c405~WQ3CvstEv2833728337epoutp01J
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 00:41:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191112004111epoutp01ce20b44c46474b9c27a77005aac9c405~WQ3CvstEv2833728337epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573519271;
        bh=l/mntHh5jVoZi+FB8o6mkO/+8HnbJubP2On4/yTuV0w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AZiEWhpbvfBZMjIwq9FmceOy9+lYxllQ9MARrWOQBxAnhg2246RybIOBxIx/ANx/V
         GjZ6aAXQ+J+y7U5K1CxcslJNjSuGd17gmkF6VE9KY8sR88YHu/2+YkERdffHZlP5Ml
         sBz9YJ7aTPv4aQdCyUUXT9X13iQWrdpfoXjNgyCA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191112004110epcas1p3bb61a75453a7a1c80f8af913dfd80f78~WQ3B2gbrP1223012230epcas1p3t;
        Tue, 12 Nov 2019 00:41:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Bpnv56jRzMqYkn; Tue, 12 Nov
        2019 00:41:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.90.04068.3AFF9CD5; Tue, 12 Nov 2019 09:41:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191112004107epcas1p4384d64502361b6fb98db0e937aa02255~WQ2-I31xu1783117831epcas1p45;
        Tue, 12 Nov 2019 00:41:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191112004107epsmtrp1ff96fd40c81be93f93efce4495305b41~WQ2-IHgDH1292212922epsmtrp15;
        Tue, 12 Nov 2019 00:41:07 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-1e-5dc9ffa3f04d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.81.25663.3AFF9CD5; Tue, 12 Nov 2019 09:41:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191112004106epsmtip1970e51e6e5851910ebd393d79b2c2eca~WQ2_4q_se2607826078epsmtip1B;
        Tue, 12 Nov 2019 00:41:06 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Add usage_stat file to sysfs
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <41c7e481-7bbd-cf5c-a18c-31b4a3dd907e@samsung.com>
Date:   Tue, 12 Nov 2019 09:46:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f70ebc907933717ae5fe2af5bc7f53eed0ef3308.1573508311.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmge7i/ydjDX7c0bI4dGwru8XZpjfs
        FivufmS1+Nx7hNHi84bHjBa3G1ewWZw5fYnV4vjacIuNXz0cOD1mN1xk8bhzbQ+bx8Z3O5g8
        Dr7bw+Sx5Wo7i0ffllWMHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQ
        K07MLS7NS9dLzs+1MjQwMDIFKkzIzvg27S1zwR3Fip/LtrE3MM6T7mLk5JAQMJH41HmUpYuR
        i0NIYAejxKSN21khnE+MEvdfdrCBVAkJfGOUmLXQHKbj6IJdbBBFexklTnYthmp/zygx/+dv
        RpAqYQF7iYn9VxhBEiICzYwSW0+8ZQJxmAUamCSenvkGVsUmoCWx/8UNsB38AooSV388Bovz
        CthJfJv7ByjOwcEioCqx8Tw3iCkqECFx+msiRIWgxMmZT1hAbE6BOIl3Xc+ZQGxmAXGJW0/m
        Q9nyEtvfzmEGWSsh0M8use32MSaIF1wkVl6dxgJhC0u8Or6FHcKWknjZ3wZlV0usPHmEDaK5
        g1Fiy/4LrBAJY4n9SyczgRzELKApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGW
        uPzgLtQJkhKL2zvZJjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxaYIsf2JkZwotWy
        3MF47JzPIUYBDkYlHl6GhJOxQqyJZcWVuYcYJTiYlUR4d1SciBXiTUmsrEotyo8vKs1JLT7E
        aAoM64nMUqLJ+cAskFcSb2hqZGxsbGFiaGZqaKgkzuu4fGmskEB6YklqdmpqQWoRTB8TB6dU
        A2OYO/uMdZnJEUs/c0efstv0xHjWib9TfQ1XbFkUKpy1/IHdlsb8qEXCQmzn5Lpdop41nhe8
        89tRjb3yQVBa96FjHWWa9RtT+w4/d99cXiPEZRNpHP5r4s6dPzkU9j3xu7PupOe6plUePs6l
        W/nUrteanWDrsq9d7RZ/NY2n7mvZy3Czlkkn4pRYijMSDbWYi4oTAdYYDOXKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnO7i/ydjDW5tZLU4dGwru8XZpjfs
        FivufmS1+Nx7hNHi84bHjBa3G1ewWZw5fYnV4vjacIuNXz0cOD1mN1xk8bhzbQ+bx8Z3O5g8
        Dr7bw+Sx5Wo7i0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlfJv2lrngjmLFz2Xb2BsY50l3
        MXJySAiYSBxdsIsNxBYS2M0o0TlRDSIuKTHt4lHmLkYOIFtY4vDh4i5GLqCSt4wSuyddYgep
        ERawl5jYf4URJCEi0Moocef0DzYQh1mgiUni6eYJzBAtGxkllv/fwwLSwiagJbH/xQ2wdfwC
        ihJXfzxmBLF5Bewkvs39wwayjkVAVWLjeW6QsKhAhMTz7TegSgQlTs58AjaGUyBO4l3XcyYQ
        m1lAXeLPvEvMELa4xK0n86Hi8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6x
        YYFRXmq5XnFibnFpXrpecn7uJkZwzGlp7WA8cSL+EKMAB6MSDy9DwslYIdbEsuLK3EOMEhzM
        SiK8OypOxArxpiRWVqUW5ccXleakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpg
        TLZSEjy0sqP7hNDHI5sVF1/z+X/cruYi758ShqK3RTtYjj+Z/Vi9wX6xjfPSeI98f19h0X8B
        E4SLTjyNDQn1P/Ei4dPNO+9ZeuulI6w2p4kvkedT/vn+x9tndoe+zJcJOGamxpqmf+fkXna1
        hRvaOZNaDgqbPouMuLWrsVSc1WKm3sXONTMDlFiKMxINtZiLihMBBV1CTrUCAAA=
X-CMS-MailID: 20191112004107epcas1p4384d64502361b6fb98db0e937aa02255
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191111215534epcas5p35b69167fa14a5c026b765c43faa5ec67
References: <CGME20191111215534epcas5p35b69167fa14a5c026b765c43faa5ec67@epcas5p3.samsung.com>
        <f70ebc907933717ae5fe2af5bc7f53eed0ef3308.1573508311.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

The role of sysfs is not the debugging. We cannot add new sysfs entry
in order to get the load tracking for the debugging. 

For the debugging, use the perf event in linux kernel generally.
And devfreq core already merged the perf event as following:

[1] commit 1be0730f1dcd ("trace: events: add devfreq trace event file")
[2] commit cf451adfa392 ("PM / devfreq: add tracing for scheduling work")

In result, Not Ack of this patch.

Thanks,
Chanwoo Choi

On 11/12/19 6:55 AM, Leonard Crestez wrote:
> This file shows the currently usage of the device as reported by
> get_dev_status.
> 
> This is the same information used by the ondemand governor to make
> decisions and it is not otherwise easily available.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/ABI/testing/sysfs-class-devfreq |  8 +++++
>  drivers/devfreq/devfreq.c                     | 34 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> The output might be a little too "free-form" for a sysfs file,
> suggestions welcome.
> * Splitting it into single-field files would make
> reads non-atomic.
> * There is currently no debugfs for devfreq
> 
> The only current alternative seems to be debug statements in the
> driver's implementation of get_dev_status.
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 01196e19afca..680dab768105 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -53,10 +53,18 @@ Description:
>  		the number of transitions between states.
>  		In order to activate this ABI, the devfreq target device
>  		driver should provide the list of available frequencies
>  		with its profile.
>  
> +What:		/sys/class/devfreq/.../usage_stat
> +Date:		November 2019
> +Contact:	Leonard Crestez <leonard.crestez@nxp.com>
> +Description:
> +		This file shows the currently usage of the device if
> +		measurement is enabled. This is the same information used by
> +		ondemand governor to make decisions.
> +
>  What:		/sys/class/devfreq/.../userspace/set_freq
>  Date:		September 2011
>  Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
>  Description:
>  		The /sys/class/devfreq/.../userspace/set_freq shows and
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 78a5af869a0e..20dce6167946 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1559,20 +1559,54 @@ static ssize_t trans_stat_show(struct device *dev,
>  					devfreq->total_trans);
>  	return len;
>  }
>  static DEVICE_ATTR_RO(trans_stat);
>  
> +static ssize_t usage_stat_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct devfreq *devfreq = to_devfreq(dev);
> +	struct devfreq_dev_status *stat = &devfreq->last_status;
> +	int ret;
> +	ssize_t len = 0;
> +
> +	if (!devfreq->profile->get_dev_status)
> +		return sprintf(buf, "Not Supported.\n");
> +
> +	if (!devfreq->stop_polling) {
> +		mutex_lock(&devfreq->lock);
> +		ret = devfreq->profile->get_dev_status(dev->parent, stat);
> +		mutex_unlock(&devfreq->lock);
> +		if (ret) {
> +			len += sprintf(buf + len, "Poll error: %d\n", ret);
> +			return len;
> +		}
> +	} else
> +		len += sprintf(buf + len, "Polling stopped\n");
> +
> +	len += sprintf(buf + len, "Busy: %lu\n", stat->busy_time);
> +	len += sprintf(buf + len, "Total: %lu\n", stat->total_time);
> +	len += sprintf(buf + len, "Current Frequency: %lu\n",
> +		       stat->current_frequency);
> +	len += sprintf(buf + len, "Usage: %lu%%\n",
> +		       stat->busy_time * 100 / stat->total_time);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(usage_stat);
> +
>  static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_governor.attr,
>  	&dev_attr_available_governors.attr,
>  	&dev_attr_cur_freq.attr,
>  	&dev_attr_available_frequencies.attr,
>  	&dev_attr_target_freq.attr,
>  	&dev_attr_polling_interval.attr,
>  	&dev_attr_min_freq.attr,
>  	&dev_attr_max_freq.attr,
>  	&dev_attr_trans_stat.attr,
> +	&dev_attr_usage_stat.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(devfreq);
>  
>  static int __init devfreq_init(void)
> 
