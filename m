Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5DFCD61
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 19:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKNSXH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 13:23:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38082 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfKNSXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 13:23:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191114182305euoutp010a806a7514d6f9eb0203fcd991c3c5e3~XGoxn6WML2328623286euoutp01c
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 18:23:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191114182305euoutp010a806a7514d6f9eb0203fcd991c3c5e3~XGoxn6WML2328623286euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573755785;
        bh=8A8cbdxqtvyWnHtbwa/FzjfQ0uga80SIYlE1UAGn4Bo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Se0pyxUNX33A4vCsulk3XeiE94gCRHRXu6cXMVV698S+So9xwycj7ZPMiGBemhZns
         VxbAinpG9CDArD7MB/R9eOF3mlZdSEqkNkKQdnimpsuid4C64ksf+miDCsbuQl8Xn5
         yL+9nMQgSspbmP+gIDQRGQJPLOsU4SzhcohhZJv0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191114182304eucas1p199982b52337f7c7e01e6535ca746e204~XGoxI_2M53104331043eucas1p1r;
        Thu, 14 Nov 2019 18:23:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 57.AC.04309.88B9DCD5; Thu, 14
        Nov 2019 18:23:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191114182304eucas1p1953894d6757259534b521aa26bb2277a~XGowlQMfs3104431044eucas1p1r;
        Thu, 14 Nov 2019 18:23:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191114182304eusmtrp27c2723dbef2e2b81fd1cb8fa1d4407c7~XGowkkBgx3098030980eusmtrp2D;
        Thu, 14 Nov 2019 18:23:04 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-53-5dcd9b88dc75
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0C.6D.04166.78B9DCD5; Thu, 14
        Nov 2019 18:23:03 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191114182303eusmtip2a8a1af312e7bd253d1f0bc6bd4643b37~XGowCjFyO0346003460eusmtip2Z;
        Thu, 14 Nov 2019 18:23:03 +0000 (GMT)
Subject: Re: [PATCH 3/7] devfreq: add clearing transitions stats in sysfs
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <95813188-be4f-d3b3-459a-597be775f035@samsung.com>
Date:   Thu, 14 Nov 2019 19:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3a5096c3-03d2-fd5d-852a-6a19c5b262a5@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGPbvbvXezyXVae9E+cFRkpGZUXCwtoWBakP9EUmitvEzRbbKr
        lkW1LHWOlDLJmqJG4VdZNkRzlOL8SvwqirR0tD+EvlzoFEGcmtc7yf+e85zfc973gUNiskZR
        AJmizWD0WlWaApcIm3vmh0OMZYMJew1fg+iR2R8iuqhtGdFVrkcieni4kaAHcyYJ+pO1HKdn
        CrsQ3dBlJ+ixW7X4UbHSUl+AKzv+vhUoi5rqkXLGsjVOeFZyOIlJS8li9GFRFyTJ722jgvQh
        uNJtDzOgfH8TEpNA7QeTZYwwIQkpo2oRuJ1GEX+YRTB324LxhxkEkxWFxFrEbnB5IjUIXlSW
        eygnglFDg4Cj/KgYyCkbwDjtT52G4i/VQg7CqDIBtObYVyGcioD7+fWI01IqCr7nPl/VQmoH
        jFa+W2U2UvHgcnSKeMYX+h5PrDxEkmLqCIyMh3A2Rsnh20SlgNfboMXJLwSUlYCC6RYhv/Yx
        uGt1YLz2g9+9TZ46m2G5lQtzgZcIFo0/PekWBDUPlnCeOgSdvR9F3GSMCoZX1jDejobPU6Wr
        NlA+MOr05ZfwgeLmUoy3pWDMk/H0TmisbsTXxppa67B7SGFe18y8ro55XR3z/7lVSFiP5Ewm
        q1Ez7D4tczmUVWnYTK069JJOY0Er/6h/qXf2DbK6L9oQRSLFBinAQIJMpMpiszU2BCSm8JeW
        OFcsaZIq+yqj153XZ6YxrA0FkkKFXHrNy3FORqlVGUwqw6Qz+rVbASkOMKCy7htQWToeN9gx
        daJ04oPjWeSupwfxvMTr7XbxibmTslh193y8n7m/LzqiztvRlnCq4wyRIRhy10oYS1W7bu5O
        uFyt0MUEbprADlQExvocH4qMTF1YtHp3bs+q8br5Jyh2OnHLr4f4Qm42EayNG1lCrxdcPSXN
        5mGrcU/dE7dCyCarwndjelb1DxzRcFRDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7rts8/GGtw+Z2lx/ctzVou+ff8Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPN4+C7PUwefVtW
        MXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl3Hi0A2mgnMSFUfv6jcwtot0MXJySAiYSNxt+MTexcjFISSwlFHi9YY9LF2MHEAJGYnj
        68sgaoQl/lzrYoOoec0o0bX5PBtIQljAU6Jp9hlmEFtEIFTi1MbJYEXMAnOZJL70/4Wa+o1R
        YvKCdawgVWwCVhIT21cxgti8AnYS91tXg9ksAqoSN+bvZQKxRQUiJA7vmAVVIyhxcuYTsIs4
        Bewlrt/RBQkzC6hL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYxCs5B0z0LSMgtJyywkLQsYWVYx
        iqSWFuem5xYb6hUn5haX5qXrJefnbmIERt+2Yz8372C8tDH4EKMAB6MSD+8B0TOxQqyJZcWV
        uYcYJTiYlUR4p7wFCvGmJFZWpRblxxeV5qQWH2I0BfptIrOUaHI+MDHklcQbmhqaW1gamhub
        G5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg5HcsfnDQ7qbf9L6dTJwbdrj+yhVcIH5r
        6se5wili0VorFkXc+7S1QECt4vGph4LFqb2NYbe/2na8XZ37yy14g+gx1uQQl8auLr76sNu+
        31dYHjb3fFSw+eXM7XaLDQTne6rsqGtdvb7/gy1j2/pHTm9OMPl/lf324nbftcsR4tcOdzNW
        tS6tUWIpzkg01GIuKk4EAIHgh2vUAgAA
X-CMS-MailID: 20191114182304eucas1p1953894d6757259534b521aa26bb2277a
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Chanwoo,

On 11/13/19 10:41 AM, Chanwoo Choi wrote:
> Hi,
> 
> If user only want to use the transitions stats information
> from now, the user just read the sysfs twice and then
> can calculate them between the read data. It is enough

IOW you are suggesting that user should invest his valuable time
into actually doing such calculations (or implementing some extra
script to do the data parsing and calculations automatically)
instead of doing simple write to special sysfs file?

Also similar patch for cpufreq has been applied not so long ago:

commit ee7930ee27fe5240398cc302fa8eb4454725f188
Author: Markus Mayer <mmayer@broadcom.com>
Date:   Mon Nov 7 10:02:23 2016 -0800

    cpufreq: stats: New sysfs attribute for clearing statistics
    
    Allow CPUfreq statistics to be cleared by writing anything to
    /sys/.../cpufreq/stats/reset.
    
    Signed-off-by: Markus Mayer <mmayer@broadcom.com>
    Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
...

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> to get the existing sysfs information. 
> 
> And I don't know the any other reason. So, I can't agree this patch.
> So, Not ack.
> 
> Regards,
> Chanwoo Choi
> 
> 
> On 11/13/19 6:13 PM, Kamil Konieczny wrote:
>> Add new function trans_reset in sysfs for clearing transition
>> table and time in states devfreq statistics.> 
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index ac04b5baef70..0a88055d1362 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -1445,6 +1445,31 @@ static ssize_t trans_stat_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(trans_stat);
>>  
>> +static void defvreq_stats_clear_table(struct devfreq *devfreq)
>> +{
>> +	unsigned int count = devfreq->profile->max_state;
>> +
>> +	spin_lock(&devfreq->stats_lock);
>> +	memset(devfreq->time_in_state, 0, count * sizeof(u64));
>> +	memset(devfreq->trans_table, 0, count * count * sizeof(int));
>> +	devfreq->last_stat_updated = get_jiffies_64();
>> +	devfreq->total_trans = 0;
>> +	spin_unlock(&devfreq->stats_lock);
>> +}
>> +
>> +static ssize_t trans_reset_store(struct device *dev,
>> +				 struct device_attribute *attr,
>> +				 const char *buf,
>> +				 size_t count)
>> +{
>> +	struct devfreq *devfreq = to_devfreq(dev);
>> +
>> +	defvreq_stats_clear_table(devfreq);
>> +
>> +	return count;
>> +}
>> +static DEVICE_ATTR_WO(trans_reset);
>> +
>>  static struct attribute *devfreq_attrs[] = {
>>  	&dev_attr_governor.attr,
>>  	&dev_attr_available_governors.attr,
>> @@ -1455,6 +1480,7 @@ static struct attribute *devfreq_attrs[] = {
>>  	&dev_attr_min_freq.attr,
>>  	&dev_attr_max_freq.attr,
>>  	&dev_attr_trans_stat.attr,
>> +	&dev_attr_trans_reset.attr,
>>  	NULL,
>>  };
>>  ATTRIBUTE_GROUPS(devfreq);

