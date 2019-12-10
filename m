Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBC1182F9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 10:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLJJDa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 04:03:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37738 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfLJJDa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 04:03:30 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191210090328euoutp0188d43ad16b1886eb66e92cfb7f70b298~e9xmDqPqK1097210972euoutp01w
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 09:03:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191210090328euoutp0188d43ad16b1886eb66e92cfb7f70b298~e9xmDqPqK1097210972euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575968608;
        bh=NjU7fQwFCrnvfRgHU9DpHgmgtFbrrRdVa7ep57RTfjs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tKHJ+womvrCGrkn3Zyq9TMZ+h7zT2uG2RNx9J4NkB2XdA6cCxPhY+vcMQ1Vv5qClO
         ciF4c6WYxkPp5q4DMV5OoJOBS13+o6jhkpB6Vk0iBeqsHJxvGTIyVBsGz6vNx68hM7
         f+8723k9Ev5OHLmg3/zarV2enJiTzqebMKwhnE+s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191210090328eucas1p159d4d4653cbe003c7c7ac76a1d54e40f~e9xl1lkP92982229822eucas1p1x;
        Tue, 10 Dec 2019 09:03:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.E8.60679.06F5FED5; Tue, 10
        Dec 2019 09:03:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191210090328eucas1p175453fa6d0a8462a0a5e37fc893c692d~e9xlh8spY0819308193eucas1p1P;
        Tue, 10 Dec 2019 09:03:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191210090328eusmtrp208391d1d92594f44e66a76e1ebd194b8~e9xlhN5tB0432204322eusmtrp2i;
        Tue, 10 Dec 2019 09:03:28 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-4b-5def5f60018c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.18.07950.F5F5FED5; Tue, 10
        Dec 2019 09:03:27 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210090327eusmtip1578b3f44c21e9d81ee73bcf1e10f56f7~e9xlGBmbA3075330753eusmtip1u;
        Tue, 10 Dec 2019 09:03:27 +0000 (GMT)
Subject: Re: [PATCH 2/4] PM / devfreq: add possibility for delayed work
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <03350bb0-11a8-a179-7197-1049dc5e1ef6@samsung.com>
Date:   Tue, 10 Dec 2019 10:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2881c0b8-9d05-aa5f-c216-8d5a09eb0b00@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHez1nZ0dx8joVn7QLLQSTvNaHQ4WXENJ9CgSzyPSUB5XclB2n
        GRFqaVNzZEHl8g55mdjURFMjckpDzbyWYZh9WImmabgCyzK3M8lv/+f//P68/wdempDWi7zo
        VGUmp1KyaTLKiex8tT7qn5iwEh+UVyBl2h4aRMy0ZV7EjI62ipmR/CUxM9lTQTFrpQOIaRmY
        FTMf8hqpcDqqXV9ERWk79ChqrX3faeKc04kkLi01i1MFhiY6pbTlNpEZRSFXCvK0VC5651uM
        HGnAR2FofpYoRk60FDciWOwuoYTBgmCiy2DfrCF4ulws2o6saix2qgHByly+fVhG8PjXithK
        ueFT8OjGjC3hjn2h/M8UskIErnKApftjtgWFA6FvZJC0agkOhcXnHQ5WTWIfGKl6u6Vp2gPH
        wfAPVkBcYbDcbMMdcRj09VbZcAJ7woy52q73Q9dyha02YL0Ypn/PUULtSDDX9pOCdoNFU4dY
        0Htgs1sIA86Gz7VasRC+ieDTre/2wHHoN42LrIUIfAgMPYGCHQFja5XIagN2gffLrkIHF7jb
        +YAQbAloCqUC7QPzQ7ftL3lD8eYT0R0k0+24TLfjGt2Oa3T/361BpB55cmpekczxIUouO4Bn
        FbxamRxwKV3RjrZ+z/Bfk+UZ6tm4aESYRjJnSU34t3ipiM3icxRGBDQhc5eYCrcsSRKbc5VT
        pSeo1Gkcb0TeNCnzlBypW4iX4mQ2k7vMcRmcanvrQDt65SLm5YZcfiz4o8d1ii5VfzEH/Swx
        aeV1AYlv+sIvvDbGZdYxHvlDq0u7mklW3mssMwyfia5fnIioKXOIbvIPP/sVrwfuPcDqVZqF
        Qk1kRUlZzD1VT0xLZaTfSWlAm5I7mNdtqWqr3q0b59VTrS+wwrkPwiavxZ7XwHhDbPNhGcmn
        sMF+hIpn/wEfjCs+OQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7rx8e9jDd6dsbTYOGM9q8X1L89Z
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xe3GFWwOHB6bVnWyefRtWcXo8XmTXABzlJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GxoaVLAWd
        RhWtjX1sDYzXNLoYOTkkBEwkPnR8Yeti5OIQEljKKPFo3kx2iIS0ROPp1UwQtrDEn2tdUEWv
        GSVenW1mA0kIC7hLzG6+xQpiiwhoSMz8e4URpIhZYAGTxPybE1kgOn4wShzZtJoZpIpNQF/i
        4NmTLCA2r4CdxKs9W8BWsAioSpyddxXMFhWIkHi+/QYjRI2gxMmZT8DqOQXsJQ7ungdWwyyg
        LvFn3iVmCFtc4taT+VBxeYntb+cwT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84
        Mbe4NC9dLzk/dxMjMN62Hfu5ZQdj17vgQ4wCHIxKPLwLHN7FCrEmlhVX5h5ilOBgVhLhPd4G
        FOJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YCrIK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMk
        kJ5YkpqdmlqQWgTTx8TBKdXAyCzwX8hgM79i15GdARksZ/cysB9S6l3MJ5Z49OqjF1xr1Hqr
        /q7JVni9X8VgGkuOjozhg7hjax6GWtnweN6UubR32qOYZqvvl3q+bupIP38j9n6kjk65m/sz
        v7bU1/tc3oUWl99K7t9x8lzErLuty1U/aaWKbjUXjAq69SNy8p+4eSc2LzijpcRSnJFoqMVc
        VJwIAEl2N9vNAgAA
X-CMS-MailID: 20191210090328eucas1p175453fa6d0a8462a0a5e37fc893c692d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5@eucas1p2.samsung.com>
        <20191209144425.13321-3-k.konieczny@samsung.com>
        <2881c0b8-9d05-aa5f-c216-8d5a09eb0b00@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 10.12.2019 02:47, Chanwoo Choi wrote:
> On 12/9/19 11:44 PM, Kamil Konieczny wrote:
>> Current devfreq workqueue uses deferred timer. Introduce sysfs
>> file delayed_timer and use it for change from deferred to
>> delayed work. The default is to use old deferred one, which
>> saves power, but can miss increased demand for higher bus
>> frequency if timer was assigned to idle cpu.
> 
> As I commented on patch1, If you hope to change the feature
> related to both performance  and power-consumption, 
> you have to suggest the reasonable data with test result
> on multiple scenarios.

Unfortunatly I do not have such tests. Do you have them ?
May you share them with me or Marek ?

> Firstly,
> I don't agree to add 'delayed_timer' sysfs entries.
> If some device driver want to use the different type of
> workqueue, they can choice the workqueue type in the
> probe function of device driver. 

sysfs allows change in runtime

> Secondly, the 'dealyed_timer' is not for all devfreq
> device driver. Only devfreq device driver uses the
> 'simple_ondemand' governor. It is wrong to show
> without any specific reason.

Good point, performance or powersave with fixed max or min freq
do not need them.

> If you suggest the reasonable data with test result,
> I prefer to add the new flag to 'struct devfreq_dev_profile'.

imho users of devfreq may give it a try and perform tests themselfs
and then share results.

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
>> +}
>> +
>> +static ssize_t delayed_timer_store(struct device *dev,
>> +				   struct device_attribute *attr,
>> +				   const char *buf, size_t count)
>> +{
>> +	struct devfreq *df = to_devfreq(dev);
>> +	bool old_timer;
>> +	int value, ret;
>> +
>> +	if (!df->governor)
>> +		return -EINVAL;
>> +
>> +	ret = kstrtoint(buf, 10, &value);
>> +	if (ret || (value != 1 && value != 0))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&df->lock);
>> +	old_timer = df->delayed_timer;
>> +	df->delayed_timer = value == 0 ? false : true;
>> +	mutex_unlock(&df->lock);
>> +
>> +	if (old_timer != df->delayed_timer) {
>> +		devfreq_monitor_stop(df);
>> +		devfreq_monitor_start(df);
>> +	}
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_RW(delayed_timer);
>> +
>>  static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
>>  			     char *buf)
>>  {
>> @@ -1513,6 +1556,7 @@ static struct attribute *devfreq_attrs[] = {
>>  	&dev_attr_name.attr,
>>  	&dev_attr_governor.attr,
>>  	&dev_attr_available_governors.attr,
>> +	&dev_attr_delayed_timer.attr,
>>  	&dev_attr_cur_freq.attr,
>>  	&dev_attr_available_frequencies.attr,
>>  	&dev_attr_target_freq.attr,
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index de2fdc56aa5b..761aa0a09db7 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -134,6 +134,7 @@ struct devfreq_stats {
>>   *		reevaluate operable frequencies. Devfreq users may use
>>   *		devfreq.nb to the corresponding register notifier call chain.
>>   * @work:	delayed work for load monitoring.
>> + * @delayed_timer:	use delayed or deferred timer for workqueue.
>>   * @previous_freq:	previously configured frequency value.
>>   * @data:	Private data of the governor. The devfreq framework does not
>>   *		touch this.
>> @@ -166,6 +167,7 @@ struct devfreq {
>>  	char governor_name[DEVFREQ_NAME_LEN];
>>  	struct notifier_block nb;
>>  	struct delayed_work work;
>> +	bool delayed_timer;
>>  
>>  	unsigned long previous_freq;
>>  	struct devfreq_dev_status last_status;
>>
> 
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

