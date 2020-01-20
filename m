Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3761F142D1F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATOUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 09:20:24 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44936 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgATOUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 09:20:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200120142019euoutp02b75f76002abd8c8a1540955e91fbb763~rni8Lcxv23089230892euoutp02l
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2020 14:20:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200120142019euoutp02b75f76002abd8c8a1540955e91fbb763~rni8Lcxv23089230892euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579530019;
        bh=/Hxk2ksk59RNZCmsuJjxqzLBQ3KX3uIMzRZeaQwCTS8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jSD2zO1UPcME/i831fqsTWE8VYmQyuJ8L2GycFgPlflB+/3qOtrU6skG+fi0oo7pY
         fOVxgybjqXrGlx0Xeo/SySxj9az24QsfUDA/M+mtG0Hgtep9Hw3NirXTYZEKLuC3+6
         LE9XDgqkUuDolPHkoGNFFPxu83zeb8GpJVgSwgOA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200120142018eucas1p17ff8823a83a81d5c956114bfe80b7e2d~rni79KSc-2375623756eucas1p1f;
        Mon, 20 Jan 2020 14:20:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B9.3E.60679.227B52E5; Mon, 20
        Jan 2020 14:20:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200120142018eucas1p1fe9f375d3f1f56f3a8c386b86e20eb73~rni7oqjJx0750507505eucas1p11;
        Mon, 20 Jan 2020 14:20:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200120142018eusmtrp22cfedc733d49e2523cd455503905f9cd~rni7oApwF3043030430eusmtrp2N;
        Mon, 20 Jan 2020 14:20:18 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-e2-5e25b722a924
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 05.82.08375.227B52E5; Mon, 20
        Jan 2020 14:20:18 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200120142018eusmtip1ea390f841da277d618352e654fedd52f~rni7K6jCI1719917199eusmtip1Y;
        Mon, 20 Jan 2020 14:20:18 +0000 (GMT)
Subject: Re: [PATCH 2/4] PM / devfreq: add possibility for delayed work
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Message-ID: <35061548-5731-c39b-6f93-83418127c547@samsung.com>
Date:   Mon, 20 Jan 2020 15:20:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <03350bb0-11a8-a179-7197-1049dc5e1ef6@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djPc7pK21XjDC6+N7XYOGM9q8X1L89Z
        Lc6f38BucbbpDbvF5V1z2Cw+9x5htFh75C67xe3GFWwOHB6bVnWyefRtWcXo8XmTXABzFJdN
        SmpOZllqkb5dAldG20fhguPJFSsmtjM1MO5y72Lk4JAQMJHY/aO+i5GTQ0hgBaPEgyciXYxc
        QPYXRokfX3cyQzifGSUO/X/JBlIF0jDlznmoxHJGif57W1gg2t8ySpxYIQtiCwu4S8xuvsUK
        YrMJ6EscPHsSrEZEQENi5t8rjCDNzALzmCTeTLsAVsQrYCextmEKM8hJLAKqEge3gJmiAhES
        p78mQlQISpyc+QRsDKeAvcT3ZzcZQWxmAXGJW0/mM0HY8hLb384Bu01CYBW7xOLOyawQR7tI
        LG59CvWAsMSr41vYIWwZif87IZolBMolni7sY4dobgEGRftHFoiEtcSdc7/YQA5iFtCUWL9L
        HyLsKHHh81xGSCjySdx4KwhxA5/EpG3TmSHCvBIdbUIQ1aoSz0/1QG2Sluj6v451AqPSLCSf
        zULyzSwk38xC2LuAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYMI5/e/4lx2Mu/4k
        HWIU4GBU4uF9MVk1Tog1say4MvcQowQHs5II74ImoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
        40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MMyuSprzh7fvR1deV33I9YO/CSk35OytjVCZvqpbM
        ZP45M5LjeNqU0x5/G88JJ6RbT3c8obvxnd1BzmtJy9Vjv0xT3vclu7lCg3n2lZmJVfeme78z
        n6CXlH5066f5ptnHi3a8/TKz9vUNNrFnfy5OOaF2YOuPJbULzPnVrVi0Ghs/Hr8zrdjFTYml
        OCPRUIu5qDgRAGr2F1g0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7pK21XjDDovq1hsnLGe1eL6l+es
        FufPb2C3ONv0ht3i8q45bBafe48wWqw9cpfd4nbjCjYHDo9NqzrZPPq2rGL0+LxJLoA5Ss+m
        KL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS+j7aNwwfHk
        ihUT25kaGHe5dzFyckgImEhMuXOeuYuRi0NIYCmjxMkbX9ghEtISjadXM0HYwhJ/rnWxQRS9
        ZpRY13CIFSQhLOAuMbv5FpjNJqAvcfDsSRYQW0RAQ2Lm3yuMIA3MAguYJObfnMgC0b2WSeLy
        lDNgK3gF7CTWNkwB2s3BwSKgKnFwCzNIWFQgQuL59huMECWCEidnPgEbyilgL/H92U2wOLOA
        usSfeZeYIWxxiVtP5jNB2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFe
        cWJucWleul5yfu4mRmCsbTv2c/MOxksbgw8xCnAwKvHwOkxTjRNiTSwrrsw9xCjBwawkwrug
        CSjEm5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cA0kFcSb2hqaG5haWhubG5sZqEkztshcDBG
        SCA9sSQ1OzW1ILUIpo+Jg1OqgdEk+T5bhYaGwJSuHVen+TJt13h0VCNY6PiZR5s7fdOdeeuW
        xMu1iZfL8sydvP6n4XPWg9HTLRdZRptOe/VEu7M+lflz74Z3k4XUjORnTzB1Y3uyfp3hVqvP
        9dLJtptWuX8Uehd27koYU061cf/sh/2B2vEXDc0aju94k+TBn1I5/X26w+Gr0kosxRmJhlrM
        RcWJAAxKxvrLAgAA
X-CMS-MailID: 20200120142018eucas1p1fe9f375d3f1f56f3a8c386b86e20eb73
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
        <03350bb0-11a8-a179-7197-1049dc5e1ef6@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

here are some logs from Exynos XU3 with next-20200113
As you can see from them, counters saturate to -1 and then are useless.
The solution will be to change workqueue type from DEFERRED into DELAYED
(default polling time 50ms or few times more seems fine).

I changed exynos-nocp for some more debug data:

--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -167,7 +167,8 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
        edata->load_count = ((counter[1] << 16) | counter[0]);
        edata->total_count = ((counter[3] << 16) | counter[2]);
 
-       dev_dbg(&edev->dev, "%s (event: %ld/%ld)\n", edev->desc->name,
+       dev_dbg(&edev->dev, "%s (event: %ld/%ld) %08lx/%08lx\n", edev->desc->name,
+edata->load_count, edata->total_count,
 edata->load_count, edata->total_count);

Below are logs:

root@target:~/devfreq# cat nocp_debug
echo -n 'func exynos_nocp_get_event +p' > /sys/kernel/debug/dynamic_debug/control

root@target:~/devfreq# dmesg|tail
[  171.619022] devfreq-event event2: nocp@10ca1800 (event: 15170920/4932961) 00e77d68/004b4561
[  171.619088] devfreq-event event3: nocp@10ca1c00 (event: 0/4931345) 00000000/004b3f11
[  194.358276] devfreq-event event0: nocp@10ca1000 (event: -1/1875960257) ffffffff/6fd0e1c1
[  194.358529] devfreq-event event1: nocp@10ca1400 (event: 0/1875978297) 00000000/6fd12839
[  194.358860] devfreq-event event2: nocp@10ca1800 (event: -1/1875994997) ffffffff/6fd16975
[  194.359162] devfreq-event event3: nocp@10ca1c00 (event: 0/1876014197) 00000000/6fd1b475
[  194.457796] devfreq-event event0: nocp@10ca1000 (event: 25127060/8085549) 017f6894/007b602d
[  194.457930] devfreq-event event1: nocp@10ca1400 (event: 0/8062505) 00000000/007b0629
[  194.458044] devfreq-event event2: nocp@10ca1800 (event: 24674808/8032785) 017881f8/007a9211
[  194.458160] devfreq-event event3: nocp@10ca1c00 (event: 0/8014513) 00000000/007a4ab1

root@target:~/devfreq# dmesg|tail                                                                                             
[  938.626509] devfreq-event event2: nocp@10ca1800 (event: -1/-1) ffffffff/ffffffff                                           
[  938.626656] devfreq-event event3: nocp@10ca1c00 (event: 0/-1) 00000000/ffffffff                                            
[ 1026.756029] devfreq-event event0: nocp@10ca1000 (event: -1/-1) ffffffff/ffffffff                                           
[ 1026.756386] devfreq-event event1: nocp@10ca1400 (event: 0/-1) 00000000/ffffffff                                            
[ 1026.756620] devfreq-event event2: nocp@10ca1800 (event: -1/-1) ffffffff/ffffffff                                           
[ 1026.756831] devfreq-event event3: nocp@10ca1c00 (event: 0/-1) 00000000/ffffffff                                            
[ 1026.875345] devfreq-event event0: nocp@10ca1000 (event: 30306432/9742217) 01ce7080/0094a789                                
[ 1026.875466] devfreq-event event1: nocp@10ca1400 (event: 0/9733001) 00000000/00948389                                       
[ 1026.875562] devfreq-event event2: nocp@10ca1800 (event: 29891212/9717537) 01c81a8c/00944721                                
[ 1026.875658] devfreq-event event3: nocp@10ca1c00 (event: 0/9702245) 00000000/00940b65                                       
root@target:~/devfreq# dmesg|tail                                                                                             
[ 1231.215227] devfreq-event event2: nocp@10ca1800 (event: 20069796/6510789) 01323da4/006358c5                                
[ 1231.215362] devfreq-event event3: nocp@10ca1c00 (event: 0/6505265) 00000000/00634331                                       
[ 1231.274744] devfreq-event event0: nocp@10ca1000 (event: 15373176/4877213) 00ea9378/004a6b9d                                
[ 1231.274840] devfreq-event event1: nocp@10ca1400 (event: 0/4869301) 00000000/004a4cb5                                       
[ 1231.274928] devfreq-event event2: nocp@10ca1800 (event: 15107524/4860117) 00e685c4/004a28d5                                
[ 1231.275017] devfreq-event event3: nocp@10ca1c00 (event: 0/4850901) 00000000/004a04d5                                       
[ 1345.925227] devfreq-event event0: nocp@10ca1000 (event: -1/-1) ffffffff/ffffffff                                           
[ 1345.925540] devfreq-event event1: nocp@10ca1400 (event: 0/-1) 00000000/ffffffff                                            
[ 1345.925751] devfreq-event event2: nocp@10ca1800 (event: -1/-1) ffffffff/ffffffff                                           
[ 1345.926095] devfreq-event event3: nocp@10ca1c00 (event: 0/-1) 00000000/ffffffff                                            
root@target:~/devfreq# uname -a                                                                                               
Linux target 5.5.0-rc5-next-20200113-00001-g9c27c4bdca7e #82 SMP PREEMPT Mon Jan 20 14:31:11 CET 2020 armv7l GNU/Linux        
root@target:~/devfreq# cat /sys/class/devfreq/devfreq2/trans_stat                                                             
     From  :   To                                                                                                             
           :  88700000 133000000 177400000 266000000 532000000   time(ms)                                                     
*  88700000:         0         0         0         0        31    660390                                                      
  133000000:         4         0         0         0         3     32630                                                      
  177400000:         2         0         0         0         1    103520                                                      
  266000000:         1         2         1         0         0      8020                                                      
  532000000:        24         5         2         4         0    680050                                                      
Total transition : 80

On 10.12.2019 10:03, Kamil Konieczny wrote:
> Hi Chanwoo,
> 
> On 10.12.2019 02:47, Chanwoo Choi wrote:
>> On 12/9/19 11:44 PM, Kamil Konieczny wrote:
>>> Current devfreq workqueue uses deferred timer. Introduce sysfs
>>> file delayed_timer and use it for change from deferred to
>>> delayed work. The default is to use old deferred one, which
>>> saves power, but can miss increased demand for higher bus
>>> frequency if timer was assigned to idle cpu.
>>
>> As I commented on patch1, If you hope to change the feature
>> related to both performance  and power-consumption, 
>> you have to suggest the reasonable data with test result
>> on multiple scenarios.
> 
> Unfortunatly I do not have such tests. Do you have them ?
> May you share them with me or Marek ?
> 
>> Firstly,
>> I don't agree to add 'delayed_timer' sysfs entries.
>> If some device driver want to use the different type of
>> workqueue, they can choice the workqueue type in the
>> probe function of device driver. 
> 
> sysfs allows change in runtime
> 
>> Secondly, the 'dealyed_timer' is not for all devfreq
>> device driver. Only devfreq device driver uses the
>> 'simple_ondemand' governor. It is wrong to show
>> without any specific reason.
> 
> Good point, performance or powersave with fixed max or min freq
> do not need them.
> 
>> If you suggest the reasonable data with test result,
>> I prefer to add the new flag to 'struct devfreq_dev_profile'.
> 
> imho users of devfreq may give it a try and perform tests themselfs
> and then share results.
> 
>>>
>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>> ---
>>>  Documentation/ABI/testing/sysfs-class-devfreq | 10 ++++
>>>  drivers/devfreq/devfreq.c                     | 46 ++++++++++++++++++-
>>>  include/linux/devfreq.h                       |  2 +
>>>  3 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
>>> index 9758eb85ade3..07bfd0df6a4a 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-devfreq
>>> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
>>> @@ -30,6 +30,16 @@ Description:
>>>  		target_freq when get_cur_freq() is not implemented by
>>>  		devfreq driver.
>>>  
>>> +What:		/sys/class/devfreq/.../delayed_timer
>>> +Date:		December 2019
>>> +Contact:	Kamil Konieczny <k.konieczny@samsung.com>
>>> +Description:
>>> +		This ABI shows or clears timer type used by devfreq
>>> +		workqueue. When 0, it uses default deferred timer.
>>> +		When set to 1 devfreq will use delayed timer. Example
>>> +		useage:
>>> +			echo 1 > /sys/class/devfreq/.../delayed_timer
>>> +
>>>  What:		/sys/class/devfreq/.../target_freq
>>>  Date:		September 2012
>>>  Contact:	Rajagopal Venkat <rajagopal.venkat@linaro.org>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 955949c6fc1f..c277d1770fef 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -445,7 +445,11 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>>  	if (devfreq->governor->interrupt_driven)
>>>  		return;
>>>  
>>> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>>> +	if (devfreq->delayed_timer)
>>> +		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>> +	else
>>> +		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>>> +
>>>  	if (devfreq->profile->polling_ms)
>>>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>>>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>>> @@ -698,6 +702,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  	devfreq->last_status.current_frequency = profile->initial_freq;
>>>  	devfreq->data = data;
>>>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>>> +	devfreq->delayed_timer = false;
>>>  
>>>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>>>  		mutex_unlock(&devfreq->lock);
>>> @@ -1288,6 +1293,44 @@ static ssize_t available_governors_show(struct device *d,
>>>  }
>>>  static DEVICE_ATTR_RO(available_governors);
>>>  
>>> +static ssize_t delayed_timer_show(struct device *dev,
>>> +				  struct device_attribute *attr, char *buf)
>>> +{
>>> +	int i;
>>> +
>>> +	i = to_devfreq(dev)->delayed_timer ? 1 : 0;
>>> +	return sprintf(buf, "%d\n", i);
>>> +}
>>> +
>>> +static ssize_t delayed_timer_store(struct device *dev,
>>> +				   struct device_attribute *attr,
>>> +				   const char *buf, size_t count)
>>> +{
>>> +	struct devfreq *df = to_devfreq(dev);
>>> +	bool old_timer;
>>> +	int value, ret;
>>> +
>>> +	if (!df->governor)
>>> +		return -EINVAL;
>>> +
>>> +	ret = kstrtoint(buf, 10, &value);
>>> +	if (ret || (value != 1 && value != 0))
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&df->lock);
>>> +	old_timer = df->delayed_timer;
>>> +	df->delayed_timer = value == 0 ? false : true;
>>> +	mutex_unlock(&df->lock);
>>> +
>>> +	if (old_timer != df->delayed_timer) {
>>> +		devfreq_monitor_stop(df);
>>> +		devfreq_monitor_start(df);
>>> +	}
>>> +
>>> +	return count;
>>> +}
>>> +static DEVICE_ATTR_RW(delayed_timer);
>>> +
>>>  static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
>>>  			     char *buf)
>>>  {
>>> @@ -1513,6 +1556,7 @@ static struct attribute *devfreq_attrs[] = {
>>>  	&dev_attr_name.attr,
>>>  	&dev_attr_governor.attr,
>>>  	&dev_attr_available_governors.attr,
>>> +	&dev_attr_delayed_timer.attr,
>>>  	&dev_attr_cur_freq.attr,
>>>  	&dev_attr_available_frequencies.attr,
>>>  	&dev_attr_target_freq.attr,
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index de2fdc56aa5b..761aa0a09db7 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -134,6 +134,7 @@ struct devfreq_stats {
>>>   *		reevaluate operable frequencies. Devfreq users may use
>>>   *		devfreq.nb to the corresponding register notifier call chain.
>>>   * @work:	delayed work for load monitoring.
>>> + * @delayed_timer:	use delayed or deferred timer for workqueue.
>>>   * @previous_freq:	previously configured frequency value.
>>>   * @data:	Private data of the governor. The devfreq framework does not
>>>   *		touch this.
>>> @@ -166,6 +167,7 @@ struct devfreq {
>>>  	char governor_name[DEVFREQ_NAME_LEN];
>>>  	struct notifier_block nb;
>>>  	struct delayed_work work;
>>> +	bool delayed_timer;
>>>  
>>>  	unsigned long previous_freq;
>>>  	struct devfreq_dev_status last_status;
>>>
>>
>>
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

