Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09B5118363
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 10:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfLJJTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 04:19:01 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:29904 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfLJJTA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 04:19:00 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191210091855epoutp03c44bd71ab9583e407cf7061b16f12ff1~e9-FkFvpg1621516215epoutp03S
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 09:18:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191210091855epoutp03c44bd71ab9583e407cf7061b16f12ff1~e9-FkFvpg1621516215epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575969535;
        bh=3hdCeQwWFZQSogkjtNK8wKAaFRc0a2bGIVeBUs+CZkc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eaIt9WtC6RHY/2X2IPDt3K8EDffrV3MyutXiS5jMS8tjKdbF3jp0+UmCCcSL7cYNJ
         X+vebSsgo6K9yZLrcBAh/N+q9wWYQmPw9dEB0byfPVQenPp2GnvkMFhcXEHYkqU1Hn
         VbPAIOuWXSAadL0uPLSqf28D6sni8WOnaGeNqoNE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191210091854epcas1p41a546c8aeb2218e75f0bd2a925bb8e1a~e9-E0hZIe1023210232epcas1p4P;
        Tue, 10 Dec 2019 09:18:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47XDyN49F3zMqYkk; Tue, 10 Dec
        2019 09:18:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.7A.51241.BF26FED5; Tue, 10 Dec 2019 18:18:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191210091851epcas1p2c00cdfae9340a610769aaf951428283d~e9-BNDj5R3073530735epcas1p2l;
        Tue, 10 Dec 2019 09:18:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191210091850epsmtrp1fba8c22f8ea0c83dbcc8ceeebaea451d~e9-BHmAnk3031430314epsmtrp1Z;
        Tue, 10 Dec 2019 09:18:50 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-13-5def62fbf64b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.D1.06569.AF26FED5; Tue, 10 Dec 2019 18:18:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191210091850epsmtip1eab599cc4db407bbf805f17df241fb0b~e9-A2hSR01022110221epsmtip1t;
        Tue, 10 Dec 2019 09:18:50 +0000 (GMT)
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
Message-ID: <9f5c7de3-dd03-5c0a-ea97-bc170303422b@samsung.com>
Date:   Tue, 10 Dec 2019 18:25:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <03350bb0-11a8-a179-7197-1049dc5e1ef6@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO7vb3TVanpbmr0WlN4QUprva6ippRi8hESGISMVuelBzL3Y3
        exHYy1R6EpQuU3tiUqyWlloi2fIRmWVUZlhRVlraqLCE/mnbXeR/n/P9fb/8fr9zDkOpa2kN
        U2iyEatJMLD0dPmt+1E67Z+tnmydZ3IBf6PSqeDrflQq+L6+60q+d9+Ykn/WWk3zP4+4EX/N
        PaTkX++tp1OYVFdDOZ16tLEBpf50LcigNhctLyBCHrGGE1OuOa/QlJ/Ert+QsypHv1THabkE
        fhkbbhKMJIldnZahXVto8E7AhhcLBrtXyhBEkY1NXm41220kvMAs2pJYYskzWBIsMaJgFO2m
        /JhcszGR0+ni9F7jlqKCfmeb0nKc3+E+HVmCHmorUBADeAkcqeqXV6DpjBo3Ixg92BQ4/EDQ
        P/lbJh1+Ieg+f075L1JycQhJhTYErVUe2ldQYw+Cpu+bfTwbr4Mz+wcVPg7BWhhrvkT5AhSu
        kcHYqSf+Ao2joX1kwB8OxhHwfPID8rEKJ8O9k3v9HjmOhPHSermPQ/FG6Ll1IOCZBT1Vw349
        CK+A359e+XUKh8HgcK1M4oVwe7yakqb+SsNb12KJV0NX9wOFxLPhS1djYDMNjB4rDfBuuNLj
        pn1DAy5D0Nj+JBCIh/ZLJ70NGG+DKHC2xkpyBLT8ORuYYSZ8mzis8FkAq6CsVC1ZFsGzd0My
        iefChUPl9HHEOqZs45iygWPKBo7/zeqQvAHNIRbRmE9EzqKf+tgu5P+c0QnNqPNxWgfCDGJn
        qOpSvmWrFUKxuNPYgYCh2BBVV6lXUuUJO3cRqznHajcQsQPpvZd9gtKE5pq9X91ky+H0cfHx
        8fwSbqme49gwFTP5NFuN8wUbKSLEQqz/cjImSFOCZpqD+eRpZZenOYddwZFG6u77pJV3ord9
        cKRH7X6p6YyLHVxJakq42x+dvQ9TyLWsbYnBQ5luUp6VPm/k8URop/Nq74vMvj3f+95UBj3y
        3Kylt4/OaEm7YA2pSpw/cb7i1BcFfWjfQNidjpYNmzKH7a63xYaY+vTPa8IGzuSmvJ9rZuVi
        gcBFU1ZR+AtJKcFFsgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTvdX0vtYg7n7TS02zljParHg0wxW
        i/PnN7BbnG16w25xedccNovPvUcYLdYeuctucbtxBZsDh8emVZ1sHn1bVjF6fN4kF8AcxWWT
        kpqTWZZapG+XwJVxaf1e9oIJFhVHpqs2MJ7S7WLk5JAQMJFoWHKXEcQWEtjNKPH8tyREXFJi
        2sWjzF2MHEC2sMThw8UQJW8ZJb4tMQSxhQXcJWY332IFsUUEdCXe7FgKVM7FwSywgEli/s2J
        LCCOkMBaJonLU86wg1SxCWhJ7H9xgw3E5hdQlLj64zHYYl4BO4mDkxvBJrEIqEq8bVvBAmKL
        CoRJ7FzymAmiRlDi5MwnYHFOAXuJ789ugvUyC6hL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYzC
        s5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHkJbWDsYT
        J+IPMQpwMCrx8HrYvYsVYk0sK67MPcQowcGsJMJ7vA0oxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgXF689rTHHN8uiRDXraK/7f3P+5v67zhpMLszOqA
        px6zHUv2PPn6+8mBeo2uO8ofLTVX/O09ZHee99l/8e4NPfu//M3qWH2LQbnluNTjtXWrdxV+
        cX9gUX55ZZVF/MoZOmnBYtPXHV6572HaVYnvHgcbDeY0XFeu3/j1UuaUe552gS6STKwV7YpK
        LMUZiYZazEXFiQC1Ny3anAIAAA==
X-CMS-MailID: 20191210091851epcas1p2c00cdfae9340a610769aaf951428283d
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
        <2881c0b8-9d05-aa5f-c216-8d5a09eb0b00@samsung.com>
        <03350bb0-11a8-a179-7197-1049dc5e1ef6@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/19 6:03 PM, Kamil Konieczny wrote:
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

You have to do some test for this patch
because you tried to use the 'delayed work' by this patch.

Actually, If possible, I want to apply some feature
if there are any real requirements.

> 
>> Firstly,
>> I don't agree to add 'delayed_timer' sysfs entries.
>> If some device driver want to use the different type of
>> workqueue, they can choice the workqueue type in the
>> probe function of device driver. 
> 
> sysfs allows change in runtime

hmm. I don't say that sysfs can't change the value at the runtime.
It is not proper answer from my opinion. Without any answer
from my opinion, you just say the feature of sysfs interface.
You and me already knew that user can change the value via sysfs.

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

As I commented above, I want to apply some feature
if there are any real requirements.

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
Best Regards,
Chanwoo Choi
Samsung Electronics
