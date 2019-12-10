Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54411849E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 11:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfLJKPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 05:15:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32986 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfLJKPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 05:15:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191210101515euoutp02ee52028fd09e18804935af0188585449~e_wRQyZD-0125201252euoutp02E
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 10:15:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191210101515euoutp02ee52028fd09e18804935af0188585449~e_wRQyZD-0125201252euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575972915;
        bh=o+fqTQmHkgIUVDjeyDhnw95Z1FypZQg67lOw8oVsV0o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t55lIjDsL8ea3cgSnLgjghGcQj0dHWnB4Yl5Wr+I/AzGh+tkLH2XAvUqXLFmFSGdP
         G/EkT0yjqnGIJeLMVX2L32M3KV4DyLmjsFhEbvbf7y+TCvyv3Bp68ZAku5PeBiKpPN
         b0XvyYCZwjNO/15qPi6IY10Bk1gIgdCL4ozR51zY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191210101515eucas1p2118cc863f5bcacd7dde33cdd5a526185~e_wRDu0EH3145931459eucas1p2l;
        Tue, 10 Dec 2019 10:15:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.8A.60698.3307FED5; Tue, 10
        Dec 2019 10:15:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210101515eucas1p2c867a48662a2597ad714b2bfe4144242~e_wQuhViU0250602506eucas1p2S;
        Tue, 10 Dec 2019 10:15:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210101514eusmtrp1ec79c94d50a982f319100abc592abd1e~e_wQt4zHF0822208222eusmtrp1i;
        Tue, 10 Dec 2019 10:15:14 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-84-5def70337261
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.B2.08375.2307FED5; Tue, 10
        Dec 2019 10:15:14 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210101514eusmtip1868593dcd3b968299b3ecf4c43b6900d~e_wQQNcxp3184431844eusmtip1S;
        Tue, 10 Dec 2019 10:15:14 +0000 (GMT)
Subject: Re: [PATCH 2/4] PM / devfreq: add possibility for delayed work
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <1e327cd8-6b78-6973-4b24-0ed2c1ba7447@samsung.com>
Date:   Tue, 10 Dec 2019 11:15:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209192742.GP228856@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rGBe9jDb4cELTYOGM9q8X1L89Z
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xecNjxktbjeuYHPg9JjdcJHFY9OqTjaPvi2r
        GD0+b5ILYInisklJzcksSy3St0vgypgwYRlzwWzNitUrupgaGFsVuxg5OCQETCRmdVh3MXJx
        CAmsYJS4fOQQO4TzhVGibV8LM4TzmVGi9cMvxi5GTrCOw3s2s0EkljNKzNk7ixHCecsocW3r
        TiaQKmEBd4nZzbdYQWwRAQ2JJ7/PgxUxCxxjkth16C9Ygk1AX+Lg2ZMsIDavgJ3E5E93wOIs
        AqoS8/q7GEEOFBWIkDj9NRGiRFDi5MwnYOWcAoYSrQshdjELiEvcejIfypaX2P52DjPEpbvY
        JdauVoOwXSS2rL0OFReWeHV8CzuELSNxenIPC4RdLvF0YR/Y/xICLYwSD9o/QiWsJQ4fv8gK
        cg+zgKbE+l36EGFHiQuf5zJCwpFP4sZbQYgT+CQmbZvODBHmlehoE4KoVpV4fqqHCcKWluj6
        v451AqPSLCSPzULyzCwkz8xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYCo6
        /e/41x2M+/4kHWIU4GBU4uFd4PAuVog1say4MvcQowQHs5II7/E2oBBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MCbpVz9Q3bDSbtPv4TccV/Mu7NboE
        njv7T1qySHHPpv4p6xy/P/XP+OKetFDM4MC6HxEqIRcrJddq9/+c4MSokHVs2+N9Z9wXdy/z
        udLHcuz6gabHLF67/z/ULKqb7dt9ZV7P1vRz9qrHEkyZH6mHtu4odrfNmJa9ck/sx80XG6xn
        XEx6rrD/rRJLcUaioRZzUXEiAJ1EnF5BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7pGBe9jDbp/mlpsnLGe1eL6l+es
        FufPb2C3ONv0ht3i8q45bBafe48wWqw9cpfd4vOGx4wWtxtXsDlwesxuuMjisWlVJ5tH35ZV
        jB6fN8kFsETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp
        2yXoZUyYsIy5YLZmxeoVXUwNjK2KXYycHBICJhKH92xm62Lk4hASWMoo8fnOC0aIhLRE4+nV
        TBC2sMSfa11QRa8ZJXZu+MIOkhAWcJeY3XyLFcQWEdCQePL7PCNIEbPAMSaJB4teMkN0vGKU
        eH+ugQWkik1AX+Lg2ZNgNq+AncTkT3fAulkEVCXm9XeBrRYViJB4vv0GI0SNoMTJmU/A6jkF
        DCVaF+4EO4lZQF3iz7xLzBC2uMStJ/Oh4vIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNI
        amlxbnpusaFecWJucWleul5yfu4mRmAMbjv2c/MOxksbgw8xCnAwKvHwLnB4FyvEmlhWXJl7
        iFGCg1lJhPd4G1CINyWxsiq1KD++qDQntfgQoynQcxOZpUST84HpIa8k3tDU0NzC0tDc2NzY
        zEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6PAw7CmL1kZk/kmuW9c3i58KW951DeGF0xf
        y3dVO7ZN/HjJXCX4fskD5V2y7FotjbpcPQKT7ldq/198es/qUv6X6YmH9MNcr8yN3fg545vr
        WuMfscvX6AZHT4i3kjS8ssBuR5JPVpn6udP14bMuGpxbclFsxjajgv9TFmwNMglvKLk+t68n
        J0WJpTgj0VCLuag4EQA8FUMa1wIAAA==
X-CMS-MailID: 20191210101515eucas1p2c867a48662a2597ad714b2bfe4144242
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5@eucas1p2.samsung.com>
        <20191209144425.13321-3-k.konieczny@samsung.com>
        <20191209192742.GP228856@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 09.12.2019 20:27, Matthias Kaehlcke wrote:
> Hi,
> 
> On Mon, Dec 09, 2019 at 03:44:23PM +0100, Kamil Konieczny wrote:
>> Current devfreq workqueue uses deferred timer. Introduce sysfs
>> file delayed_timer and use it for change from deferred to
>> delayed work. The default is to use old deferred one, which
>> saves power, but can miss increased demand for higher bus
>> frequency if timer was assigned to idle cpu.
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> ---
>>  Documentation/ABI/testing/sysfs-class-devfreq | 10 ++++
>>  drivers/devfreq/devfreq.c                     | 46 ++++++++++++++++++-
>>  include/linux/devfreq.h                       |  2 +
>>  3 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
>> index 9758eb85ade3..07bfd0df6a4a 100644
>> --- a/Documentation/ABI/testing/sysfs-class-devfreq
>> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
>> @@ -30,6 +30,16 @@ Description:
>>  		target_freq when get_cur_freq() is not implemented by
>>  		devfreq driver.
>>  
>> +What:		/sys/class/devfreq/.../delayed_timer
>> +Date:		December 2019
>> +Contact:	Kamil Konieczny <k.konieczny@samsung.com>
>> +Description:
>> +		This ABI shows or clears timer type used by devfreq
>> +		workqueue. When 0, it uses default deferred timer.
>> +		When set to 1 devfreq will use delayed timer. Example
>> +		useage:
>> +			echo 1 > /sys/class/devfreq/.../delayed_timer
>> +
>>  What:		/sys/class/devfreq/.../target_freq
>>  Date:		September 2012
>>  Contact:	Rajagopal Venkat <rajagopal.venkat@linaro.org>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 955949c6fc1f..c277d1770fef 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -445,7 +445,11 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>  	if (devfreq->governor->interrupt_driven)
>>  		return;
>>  
>> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> +	if (devfreq->delayed_timer)
>> +		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>> +	else
>> +		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> +
>>  	if (devfreq->profile->polling_ms)
>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>> @@ -698,6 +702,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	devfreq->last_status.current_frequency = profile->initial_freq;
>>  	devfreq->data = data;
>>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>> +	devfreq->delayed_timer = false;
> 
> devfreq is zero initialized (allocated with kzalloc()), hence this is
> unnecessary.

ok, I will remove it

> 
>>  
>>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>>  		mutex_unlock(&devfreq->lock);
>> @@ -1288,6 +1293,44 @@ static ssize_t available_governors_show(struct device *d,
>>  }
>>  static DEVICE_ATTR_RO(available_governors);
>>  
>> +static ssize_t delayed_timer_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	int i;
>> +
>> +	i = to_devfreq(dev)->delayed_timer ? 1 : 0;
>> +	return sprintf(buf, "%d\n", i);
> 
> get rid of 'i' and just use df->delayed_timer in sprintf().

ok

> 
>> +}
>> +
>> +static ssize_t delayed_timer_store(struct device *dev,
>> +				   struct device_attribute *attr,
>> +				   const char *buf, size_t count)
>> +{
>> +	struct devfreq *df = to_devfreq(dev);
>> +	bool old_timer;
> 
> Not a great name, the variable doesn't hold a timer. I'd suggest something
> like 'prev_val'.

ok, will change to 'bool prev, value;'

> 
>> +	int value, ret;
>> +
>> +	if (!df->governor)
>> +		return -EINVAL;
>> +
>> +	ret = kstrtoint(buf, 10, &value);
>> +	if (ret || (value != 1 && value != 0))
>> +		return -EINVAL;
> 
> use kstrtobool() instead of partially re-implementing it.

ok

>> +
>> +	mutex_lock(&df->lock);
>> +	old_timer = df->delayed_timer;
>> +	df->delayed_timer = value == 0 ? false : true;
> 
> What's wrong with:
> 
> df->delayed_timer = value;
> 
> ?

ok, when I change type of value and use above kstrtobool, this will be ok

> 
>> +	mutex_unlock(&df->lock);
> 
> Does the locking as is actually provide any value? The use case seems to
> be concurrent setting of the sysfs attribute. The lock is released after
> the assignment, hence the value of 'df->delayed_timer' could be overwritten
> before the condition below is evaluated.

Good point, before send I spotted these lines and "optimized" code so it got worse...

> If you want to protect against this case you need something like this:
> 
> // don't release the lock before evaluating the condition
> 
>> +	if (old_timer != df->delayed_timer) {

even better: if (prev != value) {
so no need for ugly mutex_unlock in both if-else paths

>   	   	mutex_unlock(&df->lock);

>> +		devfreq_monitor_stop(df);
>> +		devfreq_monitor_start(df);
>> +	}
>   	else {
> 		mutex_unlock(&df->lock);
> 	}
> 
> I don't pretend it's pretty ;-)

Thank you for review.

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

