Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0442FE02D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 15:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKOOfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 09:35:04 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46423 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfKOOfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 09:35:04 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191115143502euoutp01513f98fb31ef3aff46477d6084f44778~XXK87vsmU1193011930euoutp012
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 14:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191115143502euoutp01513f98fb31ef3aff46477d6084f44778~XXK87vsmU1193011930euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573828502;
        bh=tliG1lwM0DkcqtXTHHwZcvJIgEztupB7DhGYnNEewcU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s9Yipadg4GMjRpFcJ+DWZuJECu3UpfX7Oo5viQkBISZ8qWRC7wz9aCPhH8gbBhyxI
         PmAS1R0wm1q7SO+FgLzCHJVmysE6sfXxw6eigILYrcLXd39UijcFhVcAPVydktQvoL
         3nlywasmZ1k5Cyb4AYDPnCeaWZ9XAlg5Wqec6D3s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191115143501eucas1p161c0f249e2b80ac432d3a5f6e90a714c~XXK8XGsFt1169711697eucas1p14;
        Fri, 15 Nov 2019 14:35:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.24.04469.597BECD5; Fri, 15
        Nov 2019 14:35:01 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191115143501eucas1p26f7140d77ff0e97f033de98535bf86dc~XXK8Cwf1Q2375923759eucas1p23;
        Fri, 15 Nov 2019 14:35:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191115143501eusmtrp28a9612f8e0d0f98e953ffe896c7b6305~XXK8CFhI81553515535eusmtrp24;
        Fri, 15 Nov 2019 14:35:01 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-1c-5dceb795f13f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 05.E2.04166.597BECD5; Fri, 15
        Nov 2019 14:35:01 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191115143501eusmtip1177d2a6c0d61f38ef19ca0ea51718913~XXK7j7OCI2478024780eusmtip1G;
        Fri, 15 Nov 2019 14:35:00 +0000 (GMT)
Subject: Re: [PATCH 3/7] devfreq: add clearing transitions stats in sysfs
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <0f8becc4-a63a-5ac9-99e4-ad43ab43e157@samsung.com>
Date:   Fri, 15 Nov 2019 15:35:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <22eda7a2-3c3d-fd3e-fe5f-169c17a50a0b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju85ztHFeLz6n4olFxYFFS85I/FuWVCoMo6VdUM6ceVNqm7HhJ
        xTKVNCu76dQppBI6Ft6Wd4JIJVvzQl5QEsMfliKttGkmWebxGPnveZ/3fd7nfT4+mpDViDzp
        BF0yq9epNYxYQra9WR08UtI+qPJddPgrm8saRcrxpVmRcmioiVIO5HyhlCNdlWKl434vUtb3
        TlHKyVsmcQgdbjHfEYcXtZhRuMOyN4K4JDkRy2oSUlm9T1CUJH6+NY9Kymeuv1zLEWejaa9C
        5EwDDoC2uVWSxzJsQpCbe6AQSTbwEoLRjm9ioXAgqMkxUoWI3lR0/E4V+DoEjrU6J6GwI1h8
        8YPgV7niM5BT0b+J3XAUrNmekfwQgecQWAxjIr4hxj7wesBK8lulOAg+2gN4msRyWHleTPC0
        O74ItmU1T0uxC1jLZzannXEwvH0UyNME9oAPM0+dBLwP2u2VBO8EuIGC1qpOQkh5Esaae0gB
        u8J8Xwsl4D2w3imIAafBp+oiShDnIZjOX9wSHIeevvci3pjAh6Cxy0egQ2F0oVQkvMlumLC7
        CDfshsdtpYRAS6HgtkyYlsPsu3tbTl5QuN4geogY47Zgxm1pjNvSGP/7ViHSjDzYFE4bx3J+
        OjZNwam1XIouThGTqLWgjZ9j+9P3vQMtD0d3I0wjZpc05MmgSiZSp3Lp2m4ENMG4SYvt/SqZ
        NFadnsHqE6/qUzQs1428aJLxkGbumL4sw3HqZPYayyax+n9dJ9rZMxu5zx09X32MijHcMF75
        GeStiN6fnxEcXZ+34u8b6Yi2LnAjcnNzgkW/89z46alJbKrPUvQUHJyXVA+XXTB01WbftDp6
        GpYyDHmur2pMtlB2Ik6uPRVZVB6WmR72y2Sr0JyNGPhaaWtiPtcGJqlK7YFcaElWWcXhu7Sh
        0j/7gT9DcvFqP29Cz6n/AqQ3Gmg1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7pTt5+LNbhxSMpi44z1rBbXvzxn
        tTh/fgO7xdmmN+wWl3fNYbP43HuE0WLtkbvsFrcbV7A5cHhsWtXJ5tG3ZRWjx+dNcgHMUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZr7a2sBe0
        K1Xs+dPE1sD4QLqLkYNDQsBEYsffsi5GLg4hgaWMEv0H9rJ1MXICxaUlGk+vZoKwhSX+XOti
        gyh6zShxff5yFpCEsICnRNPsM8wgtohAgsTjJTPB4swCLxglmtuDIRoeMElMfzeFFSTBJqAv
        cfDsSRaQzbwCdhL33pqAhFkEVCW+r54CNkdUIELi+fYbjCA2r4CgxMmZT8DKOQXsJU5MtIUY
        ry7xZ94lZghbXOLWk/lMELa8xPa3c5gnMArNQtI9C0nLLCQts5C0LGBkWcUoklpanJueW2yo
        V5yYW1yal66XnJ+7iREYZ9uO/dy8g/HSxuBDjAIcjEo8vA6Tz8UKsSaWFVfmHmKU4GBWEuGd
        8vZMrBBvSmJlVWpRfnxRaU5q8SFGU6DfJjJLiSbnA1NAXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGRuMV6x6Jzb0e07J7n+ufiXIeiyc0SN63V3dwUrwal6d3
        OXXi+viTgUufq6fd3/WjXvX5FQNO+TfyK5bPqf0buvSJ3tx7DyobD3TlXb3s+dbZVEPy1Otl
        oZxy+w56q9csSea7tNZLIOdRU1o47zU3nTOz2nd3d+oWP99XZdPsvorfoiryaoCAnRJLcUai
        oRZzUXEiABjL+oPJAgAA
X-CMS-MailID: 20191115143501eucas1p26f7140d77ff0e97f033de98535bf86dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b@eucas1p2.samsung.com>
        <20191113091336.5218-4-k.konieczny@samsung.com>
        <3a5096c3-03d2-fd5d-852a-6a19c5b262a5@samsung.com>
        <95813188-be4f-d3b3-459a-597be775f035@samsung.com>
        <22eda7a2-3c3d-fd3e-fe5f-169c17a50a0b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 15.11.2019 03:47, Chanwoo Choi wrote:
> Hi Bartlomiej,
> 
> On 11/15/19 3:23 AM, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi Chanwoo,
>>
>> On 11/13/19 10:41 AM, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> If user only want to use the transitions stats information
>>> from now, the user just read the sysfs twice and then
>>> can calculate them between the read data. It is enough
>>
>> IOW you are suggesting that user should invest his valuable time
>> into actually doing such calculations (or implementing some extra
>> script to do the data parsing and calculations automatically)
>> instead of doing simple write to special sysfs file?
> 
> Actually, I wouldn't like to add the new node for the debugging.
> If there are some requirement for the debugging, we better to
> add the debugfs for devfreq (devfreq has not yet developed
> the debugfs. I'll do that). If some node is necessary for the devfreq
> core/device operation, Surely, I'll agree.
> 
> On the initial version of devfreq, it contained the 'trans_stat'.
> In order to keep the compatibility, just could not move 'trans_stat'
> to under debugfs path.
> 
> If there are any requirement for resetting for transition stats,
> I prefer to use the following style without any extra debugging node.
> 
> 	For resetting for transition stats as following,
> 	echo 0 > /sys/class/devfreq/devfreq0/trans_stat

ok, I will change the stats reset to this.

>> Also similar patch for cpufreq has been applied not so long ago:
>>
>> commit ee7930ee27fe5240398cc302fa8eb4454725f188
>> Author: Markus Mayer <mmayer@broadcom.com>
>> Date:   Mon Nov 7 10:02:23 2016 -0800
>>
>>     cpufreq: stats: New sysfs attribute for clearing statistics
>>     
>>     Allow CPUfreq statistics to be cleared by writing anything to
>>     /sys/.../cpufreq/stats/reset.
>>     
>>     Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>     Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ...
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>> to get the existing sysfs information. 
>>>
>>> And I don't know the any other reason. So, I can't agree this patch.
>>> So, Not ack.
>>>
>>> Regards,
>>> Chanwoo Choi
>>>
>>>
>>> On 11/13/19 6:13 PM, Kamil Konieczny wrote:
>>>> Add new function trans_reset in sysfs for clearing transition
>>>> table and time in states devfreq statistics.> 
>>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>>> ---
>>>>  drivers/devfreq/devfreq.c | 26 ++++++++++++++++++++++++++
>>>>  1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index ac04b5baef70..0a88055d1362 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -1445,6 +1445,31 @@ static ssize_t trans_stat_show(struct device *dev,
>>>>  }
>>>>  static DEVICE_ATTR_RO(trans_stat);
>>>>  
>>>> +static void defvreq_stats_clear_table(struct devfreq *devfreq)
>>>> +{
>>>> +	unsigned int count = devfreq->profile->max_state;
>>>> +
>>>> +	spin_lock(&devfreq->stats_lock);
>>>> +	memset(devfreq->time_in_state, 0, count * sizeof(u64));
>>>> +	memset(devfreq->trans_table, 0, count * count * sizeof(int));
>>>> +	devfreq->last_stat_updated = get_jiffies_64();
>>>> +	devfreq->total_trans = 0;
>>>> +	spin_unlock(&devfreq->stats_lock);
>>>> +}
>>>> +
>>>> +static ssize_t trans_reset_store(struct device *dev,
>>>> +				 struct device_attribute *attr,
>>>> +				 const char *buf,
>>>> +				 size_t count)
>>>> +{
>>>> +	struct devfreq *devfreq = to_devfreq(dev);
>>>> +
>>>> +	defvreq_stats_clear_table(devfreq);
>>>> +
>>>> +	return count;
>>>> +}
>>>> +static DEVICE_ATTR_WO(trans_reset);
>>>> +
>>>>  static struct attribute *devfreq_attrs[] = {
>>>>  	&dev_attr_governor.attr,
>>>>  	&dev_attr_available_governors.attr,
>>>> @@ -1455,6 +1480,7 @@ static struct attribute *devfreq_attrs[] = {
>>>>  	&dev_attr_min_freq.attr,
>>>>  	&dev_attr_max_freq.attr,
>>>>  	&dev_attr_trans_stat.attr,
>>>> +	&dev_attr_trans_reset.attr,
>>>>  	NULL,
>>>>  };
>>>>  ATTRIBUTE_GROUPS(devfreq);

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

