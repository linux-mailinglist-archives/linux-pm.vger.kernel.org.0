Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EAAFD308
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 03:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKOCli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 21:41:38 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:50220 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKOCli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 21:41:38 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191115024134epoutp0330acb627acc65fe97485f92c32518315~XNcBFrnOj0420504205epoutp03Y
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 02:41:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191115024134epoutp0330acb627acc65fe97485f92c32518315~XNcBFrnOj0420504205epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573785694;
        bh=rrEXPmBLtCwvfgy/REU0C8PXjZ+TZxP2NNvKo4CyY4Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LWi7+rpiTNpEFV1CvHlCkVZs01PGU8ay5aGf2cXyuLHyNTzZ9gSTkCxxkHxPdJjUR
         FCFnmb4F/2JPzUpSoCyII/34QyZsGhlVzmf623XVaDc3zf2lPfaEUtOrckbQvK+V87
         sbxxWDP9Y7lncHWpNlv23uS77WhJncAeJ72a7nEs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191115024134epcas1p160bb2567f2737b7dde919fc38bc5f4c2~XNcAfADpj0936209362epcas1p1v;
        Fri, 15 Nov 2019 02:41:34 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47DjKR3MLGzMqYkX; Fri, 15 Nov
        2019 02:41:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.03.04135.9501ECD5; Fri, 15 Nov 2019 11:41:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191115024129epcas1p107f2772f8919b82395dcc632f953ca2c~XNb76Rl5q0936209362epcas1p1m;
        Fri, 15 Nov 2019 02:41:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191115024129epsmtrp294635bc19f145cdaf9fdb85fad3e40a7~XNb75T3q91733017330epsmtrp2O;
        Fri, 15 Nov 2019 02:41:29 +0000 (GMT)
X-AuditID: b6c32a36-7fbff70000001027-ef-5dce1059dd51
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.4D.25663.8501ECD5; Fri, 15 Nov 2019 11:41:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191115024128epsmtip19227c10fec3e40912680bc68872e3f0b~XNb7PNV1O1569915699epsmtip1t;
        Fri, 15 Nov 2019 02:41:28 +0000 (GMT)
Subject: Re: [PATCH 3/7] devfreq: add clearing transitions stats in sysfs
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <22eda7a2-3c3d-fd3e-fe5f-169c17a50a0b@samsung.com>
Date:   Fri, 15 Nov 2019 11:47:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <95813188-be4f-d3b3-459a-597be775f035@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1ddrpYKw+63atiZYxGiVBOi3FQYuKGoPaD4yJwQVxAkNButlp
        CeiHgsaKQcUdC0SDO6IgIQIarCLGoIgaghoRN/gg4ELAEqMR7TAY+Tv3vHPePfe9SxHqElJD
        pdvdvMvOWWlyrPzWg/m68I24JVHX36plbxZWKNhz/YUK9tmzSiX7NPezkm29XUyyA4caEXu9
        sUPJtudcIZdRcVVleWTc4eoyFDdQNTOe2JRhSuO5FN6l5e3JjpR0uyWGXrs+aUWSMUrHhDPR
        7EJaa+dsfAy90hwfvirdGkxAazM5qydIxXOCQEcsMbkcHjevTXMI7hiad6ZYndHOBQJnEzx2
        y4Jkh20Ro9PpjUHhtoy0QO5i5wVt1rWP5bI96LTmIAqhAEfC+2O1soNoLKXGtQiK35YopaIf
        QffQj5FiEEFB80Pin+XdrVdy6aAeQV/l75HiG4KK7/lyUTUJr4bcouagg6ImYx66/VZRQ+Bu
        BFWn2hSihsRh4O9+TYp4Ag6Fth+dSNSr8BL43jJXpOV4DuT/qhy+ZgpOgCcBTqRVeCI0neka
        7hSCl4L3w5/hWwg8Dd50nZVJeBbUfCkeydxLQsu9dRJeCfcHexUSngQ9j6qVEtbAwNd6UsK7
        4GpTIylGBnwAQbX/+YjBAP6Lx2ViHgLPh4rbERIdCnW/SpDUdzx8DeQrRAlgFRzYr5Yks6H1
        Q4dMwtPhvDePLEC0b9Q0vlET+EZN4Pvf7BySl6GpvFOwWXiBcepHf3UVGl7NsKhaVNpibkCY
        QvQ4Fbx5mqhWcJlCtq0BAUXQk1UnvjQnqlUpXPZO3uVIcnmsvNCAjMG3PkpopiQ7gotudycx
        Rr3BYGAjmSgjw9DTVLGXLyaqsYVz8xk87+Rd/3wyKkSzB62pC5jHl7MvcrIu3Yl9TG/uLfJs
        XbMh8pCQ0P5z4gxyjLcjQpObuirH3FY3Zv8WmLO9dGiWvqdTWatNbS/kMtyRRfUvhz7VWLy+
        zoS3BYa+0thl86qjY5Yfztp3I6p8r081eHJ9h8m8+3Lo9pq8u6+mVuhNfu/98B2vaY8r+0gA
        0XIhjWPCCJfA/QWwS5ujsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTjdS4Fyswc+dzBYbZ6xntVjwaQar
        xfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3uN24gs2Bw2PTqk42j74tqxg9Pm+SC2CO4rJJ
        Sc3JLEst0rdL4Mr42mRdsEShYvXDNUwNjNOluhg5OSQETCTubbvO0sXIxSEksJtRYsezHawQ
        CUmJaRePMncxcgDZwhKHDxeDhIUE3jJK9M3TAbGFBTwlmmafASsREUiVWP0wBCTMLPCCUaK5
        PRhi5GomiS9H/jGBJNgEtCT2v7jBBmLzCyhKXP3xmBGkl1fATuLLOTWQMIuAqkTP7w3MILao
        QITE8+03GEFsXgFBiZMzn7CA2JwC9hLtD/6zQexSl/gz7xIzhC0ucevJfCYIW15i+9s5zBMY
        hWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjh4trR2M
        J07EH2IU4GBU4uGVuHU2Vog1say4MvcQowQHs5II75S3Z2KFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MKqePX/2StZTufpEl0kfljFxRB/Wsd8n8Pfm
        La0z7UGGa+aYN7tN1diilnEnJlhpbUF02kvvPeJa6nejF3yLvLPw+e9NrnrmQTGFTUs+KfvK
        XPUTWa84rWxK9Vx/Efey/c65D3yZJnJNX9vQfyThuKN+T/HCOq/qvasPZf59rKf88PRX9222
        skosxRmJhlrMRcWJAE+UzuaaAgAA
X-CMS-MailID: 20191115024129epcas1p107f2772f8919b82395dcc632f953ca2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b@eucas1p2.samsung.com>
        <20191113091336.5218-4-k.konieczny@samsung.com>
        <3a5096c3-03d2-fd5d-852a-6a19c5b262a5@samsung.com>
        <95813188-be4f-d3b3-459a-597be775f035@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bartlomiej,

On 11/15/19 3:23 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Chanwoo,
> 
> On 11/13/19 10:41 AM, Chanwoo Choi wrote:
>> Hi,
>>
>> If user only want to use the transitions stats information
>> from now, the user just read the sysfs twice and then
>> can calculate them between the read data. It is enough
> 
> IOW you are suggesting that user should invest his valuable time
> into actually doing such calculations (or implementing some extra
> script to do the data parsing and calculations automatically)
> instead of doing simple write to special sysfs file?

Actually, I wouldn't like to add the new node for the debugging.
If there are some requirement for the debugging, we better to
add the debugfs for devfreq (devfreq has not yet developed
the debugfs. I'll do that). If some node is necessary for the devfreq
core/device operation, Surely, I'll agree.

On the initial version of devfreq, it contained the 'trans_stat'.
In order to keep the compatibility, just could not move 'trans_stat'
to under debugfs path.

If there are any requirement for resetting for transition stats,
I prefer to use the following style without any extra debugging node.

	For resetting for transition stats as following,
	echo 0 > /sys/class/devfreq/devfreq0/trans_stat

> 
> Also similar patch for cpufreq has been applied not so long ago:
> 
> commit ee7930ee27fe5240398cc302fa8eb4454725f188
> Author: Markus Mayer <mmayer@broadcom.com>
> Date:   Mon Nov 7 10:02:23 2016 -0800
> 
>     cpufreq: stats: New sysfs attribute for clearing statistics
>     
>     Allow CPUfreq statistics to be cleared by writing anything to
>     /sys/.../cpufreq/stats/reset.
>     
>     Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>     Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ...
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> to get the existing sysfs information. 
>>
>> And I don't know the any other reason. So, I can't agree this patch.
>> So, Not ack.
>>
>> Regards,
>> Chanwoo Choi
>>
>>
>> On 11/13/19 6:13 PM, Kamil Konieczny wrote:
>>> Add new function trans_reset in sysfs for clearing transition
>>> table and time in states devfreq statistics.> 
>>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 26 ++++++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index ac04b5baef70..0a88055d1362 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -1445,6 +1445,31 @@ static ssize_t trans_stat_show(struct device *dev,
>>>  }
>>>  static DEVICE_ATTR_RO(trans_stat);
>>>  
>>> +static void defvreq_stats_clear_table(struct devfreq *devfreq)
>>> +{
>>> +	unsigned int count = devfreq->profile->max_state;
>>> +
>>> +	spin_lock(&devfreq->stats_lock);
>>> +	memset(devfreq->time_in_state, 0, count * sizeof(u64));
>>> +	memset(devfreq->trans_table, 0, count * count * sizeof(int));
>>> +	devfreq->last_stat_updated = get_jiffies_64();
>>> +	devfreq->total_trans = 0;
>>> +	spin_unlock(&devfreq->stats_lock);
>>> +}
>>> +
>>> +static ssize_t trans_reset_store(struct device *dev,
>>> +				 struct device_attribute *attr,
>>> +				 const char *buf,
>>> +				 size_t count)
>>> +{
>>> +	struct devfreq *devfreq = to_devfreq(dev);
>>> +
>>> +	defvreq_stats_clear_table(devfreq);
>>> +
>>> +	return count;
>>> +}
>>> +static DEVICE_ATTR_WO(trans_reset);
>>> +
>>>  static struct attribute *devfreq_attrs[] = {
>>>  	&dev_attr_governor.attr,
>>>  	&dev_attr_available_governors.attr,
>>> @@ -1455,6 +1480,7 @@ static struct attribute *devfreq_attrs[] = {
>>>  	&dev_attr_min_freq.attr,
>>>  	&dev_attr_max_freq.attr,
>>>  	&dev_attr_trans_stat.attr,
>>> +	&dev_attr_trans_reset.attr,
>>>  	NULL,
>>>  };
>>>  ATTRIBUTE_GROUPS(devfreq);
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
