Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECEC139F00
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 02:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgANBeb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 20:34:31 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38567 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgANBea (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 20:34:30 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200114013426epoutp01d5ed695211a3e850af5ab34e37a058fc~pnOhlnz8D2289222892epoutp01i
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 01:34:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200114013426epoutp01d5ed695211a3e850af5ab34e37a058fc~pnOhlnz8D2289222892epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578965666;
        bh=Z7MDZt9ItBFSdrDsXrOPQtyzCzJ3lDAFfaKazSKp680=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s7NGQqPfxu5d69ml/1mHejwYG1Y5DmLLraz93YRf+JxZ2eUsKkY9mep7aLku4xrhy
         9+O84ymD+LpNEOrUehHJypq7XT4KlzZdrxUDuKnfYkr/1KKHeoP24/RvtbtmLmaH7Y
         Jq0g+Xo1j3K6ftHfv9S6EbJ2OoNMKlQ+MVfx3Kw8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200114013425epcas1p4bf8cd5ca8d26eec5b529294a61292887~pnOg7lCg62792527925epcas1p4N;
        Tue, 14 Jan 2020 01:34:25 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47xY0G5FqnzMqYkV; Tue, 14 Jan
        2020 01:34:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.2C.48498.E9A1D1E5; Tue, 14 Jan 2020 10:34:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200114013421epcas1p3249aa0c46dfdf1d0b00b7f0ba6cf97b4~pnOdbFLpD2408724087epcas1p3A;
        Tue, 14 Jan 2020 01:34:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200114013421epsmtrp2e8ae7451b95ce9bfb44cfd628992faf3~pnOdaI8sL2772527725epsmtrp2R;
        Tue, 14 Jan 2020 01:34:21 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-4c-5e1d1a9edf0d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.BB.10238.D9A1D1E5; Tue, 14 Jan 2020 10:34:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200114013421epsmtip2b1ddb85175acf619c824e117634eb193~pnOdHFOK_2229922299epsmtip2n;
        Tue, 14 Jan 2020 01:34:21 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: Add debugfs support with
 devfreq_summary file
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "a.swigon@samsung.com" <a.swigon@samsung.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "hl@rock-chips.com" <hl@rock-chips.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "chanwoo@kernel.org" <chanwoo@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7cae1c23-f708-35c5-bf9f-0f1cfa5231db@samsung.com>
Date:   Tue, 14 Jan 2020 10:41:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB702316C611FCF43240B02D7AEE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzH9/Sudwex7rG+8KOZG942DSwVjlo8FyFLNMsl0wyzaMwyqRd6
        a4G+2WsJamI6g1MJEF7+mJZanHMReQmjYwhErJYuBDbJBhtxYxUVY4xTCEOXLsuy9TjN+O/z
        +z3fb37P93lhCP0dysCUuXyS1yU6WCqd7BvOzjWGDetL8tpmcviZ8AnEfxedI/nGWz+RfMfC
        LOI7p2OIT341RvA95yv4m8cf03xbYkHLTw6GKH6xLo74z49X03xXPEHz05+0Ue+sFDrDnUiY
        rK/TCP2Ji0gYCCZoIdJ+mhJ+m7pKCT1z/Rrhn2CUFOp725GwGHm1OP3Diu12SbRK3izJVeq2
        lrlshex7H1h2WMwFeZyR28ZvZbNcolMqZHfuKja+W+ZIJWCzKkWHP9UqFmWZzS3a7nX7fVKW
        3S37ClnJY3V4tnk2y6JT9rtsm0vdzre5vLx8c0p4sMJeHR5AnntFVQuhZ3QAJY01KI0BvAU6
        pq5ralA6o8f9CCaSYaQWfyCInxih1OJPBGPNs9oXlqcD1bS6MISg5WT782IeQU/PCFmDGGY1
        3gsL3bsVwxpshN+fNBGKhsBXtDDz7zmNskDhHIg+vEUp/DLeAD8nZ5Hi1eEiaAlkK20SvwnD
        T79eGrwW74PRvmqksA6vgtGz90mF0/ABmH/QRyhM4Az49X6rRuXX4MqT0NJcwOM01D+uQ2qC
        nTDRfIZUeTU8GumlVTbA4twQpfJRuDwap1TzKQS90R+exzdB9MtmjbJRAmdD92Cu2t4AA3+f
        Q+rglTD3rFarSADr4NSnelXyOkzeSWhUzoQvTp6mGhAbXBYnuCxCcFmE4P/DziOyHa2TPLLT
        JsmcJ3/5bUfQ0uvOKehHF8Z3xRBmELtCF3C9UqLXipXyYWcMAUOwa3SRcUOJXmcVDx+RvG6L
        1++Q5Bgyp067kTCsLXWn/orLZ+HM+SaTid/CFZg5js3QMckfD+ixTfRJFZLkkbwvfBomzRBA
        Acej6dFQ941NjYMTlrGM2+sytr6feW1/4LOpVTMFLzU0Hest38iHqY9j9sjkpZajaZmH7H0d
        F8M1Hz2o9c/vq9zxVnpXV9n4Ysi65xuWo1tLO//S3zxCZ5vK7+r2nFk/0fRLVSt9+axtxXzx
        sfK9w8HhN6zfHqpqiHcbLg3tZ74/WMuSsl3kcgivLP4HWfoOVPMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSvO5cKdk4g5kbNS3uz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG1xtukNu8WKux9ZLS7vmsNm8bn3CKPFwqYWdou1
        R+6yW9xuXMHmwOexZt4aRo/Lfb1MHjvuLmH02DnrLrvHplWdbB53ru1h89j4bgeTx99Z+1k8
        +rasYvT4vEkugCuKyyYlNSezLLVI3y6BK6Nl3k7Ggkd2FR/nfGVvYPyh28XIySEhYCLxZWcL
        excjF4eQwG5GiZkXFrFBJCQlpl08ytzFyAFkC0scPlwMUfOWUWJVy39WkBphgVCJ2x/2M4PY
        IgK6Eq/fTmIGKWIW2MkqcbbzGgtEx0NGiblnz4BVsQloSex/cQNsA7+AosTVH48ZQTbwCthJ
        zG7QBAmzCKhKHP6yGWyBqECYxM4lj5lAbF4BQYmTM5+wgNicArES759tAxvJLKAu8WfeJShb
        XOLWk/lMELa8xPa3c5gnMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhb
        XJqXrpecn7uJERzFWpo7GC8viT/EKMDBqMTD25AnEyfEmlhWXJl7iFGCg1lJhHfTOak4Id6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhiX1Zffnrxfu5x9
        xpOX3KkHXxnWb3CJtvJ6kZFw4JT+Nn9BWzG1rTN+PPp88an0jyB5XynmxdpF35OSHjFaZP89
        olgwYeuHM3mzbe58mMNYLXLjW8y8fsXcEBURi02Vl10O3VZYP+13k9djBwbJulVzijvKZl2o
        KPuVYXE9gJVZcsvDBz9DG0yUWIozEg21mIuKEwERjR0f3gIAAA==
X-CMS-MailID: 20200114013421epcas1p3249aa0c46dfdf1d0b00b7f0ba6cf97b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200113045609epcas1p1188f24c37f8ba230a0e3856aeb0e4d8e
References: <CGME20200113045609epcas1p1188f24c37f8ba230a0e3856aeb0e4d8e@epcas1p1.samsung.com>
        <20200113050324.26232-1-cw00.choi@samsung.com>
        <VI1PR04MB702316C611FCF43240B02D7AEE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/14/20 3:18 AM, Leonard Crestez wrote:
> On 13.01.2020 06:56, Chanwoo Choi wrote:
>> Add debugfs interface to provide debugging information of devfreq device.
>> It contains 'devfreq_summary' entry to show the summary of registered
>> devfreq devices as following and the additional debugfs file will be added.
>> - /sys/kernel/debug/devfreq/devfreq_summary
>>
>> [Detailed description of each field of 'devfreq_summary' debugfs file]
>> - dev_name	: Device name of h/w.
>> - dev		: Device name made by devfreq core.
>> - parent_dev	: If devfreq device uses the passive governor,
>> 		  show parent devfreq device name.
>> - governor	: Devfreq governor.
>> - polling_ms	: If devfreq device uses the simple_ondemand governor,
>> 		  polling_ms is necessary for the period. (unit: millisecond)
>> - cur_freq_Hz	: Current Frequency (unit: Hz)
>> - old_freq_Hz	: Frequency before changing. (unit: Hz)
>> - new_freq_Hz	: Frequency after changed. (unit: Hz)
>>
>> [For example on Exynos5422-based Odroid-XU3 board]
>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>> dev_name                       dev        parent_dev governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>> 10c20000.memory-controller     devfreq0              simple_ondemand          0    165000000    165000000    825000000
>> soc:bus_wcore                  devfreq1              simple_ondemand         50    532000000     88700000    532000000
>> soc:bus_noc                    devfreq2   devfreq1   passive                  0    111000000     66600000    111000000
>> soc:bus_fsys_apb               devfreq3   devfreq1   passive                  0    222000000    111000000    222000000
>> soc:bus_fsys                   devfreq4   devfreq1   passive                  0    200000000     75000000    200000000
>> soc:bus_fsys2                  devfreq5   devfreq1   passive                  0    200000000     75000000    200000000
>> soc:bus_mfc                    devfreq6   devfreq1   passive                  0    333000000     83250000    333000000
>> soc:bus_gen                    devfreq7   devfreq1   passive                  0    266000000     88700000    266000000
>> soc:bus_peri                   devfreq8   devfreq1   passive                  0     66600000     66600000     66600000
>> soc:bus_g2d                    devfreq9   devfreq1   passive                  0    333000000     83250000    333000000
>> soc:bus_g2d_acp                devfreq10  devfreq1   passive                  0    266000000     66500000    266000000
>> soc:bus_jpeg                   devfreq11  devfreq1   passive                  0    300000000     75000000    300000000
>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive                  0    166500000     83250000    166500000
>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive                  0    200000000    120000000    200000000
>> soc:bus_disp1                  devfreq14  devfreq1   passive                  0    300000000    120000000    300000000
>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive                  0    300000000    150000000    300000000
>> soc:bus_mscl                   devfreq16  devfreq1   passive                  0    666000000     84000000    666000000
>>
>> [lkp: Reported the build error]
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> Changes from v1:
>> - Drop the patch about 'devfreq_transitions' debugfs file
>> - Modify from 'hz' to 'Hz'
>> - Edit the indentation of 'devfreq_summary' when show summary
>> - Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir
>>
>>   drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 89260b17598f..c2ebed42704b 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/kmod.h>
>>   #include <linux/sched.h>
>> +#include <linux/debugfs.h>
>>   #include <linux/errno.h>
>>   #include <linux/err.h>
>>   #include <linux/init.h>
>> @@ -33,6 +34,7 @@
>>   #define HZ_PER_KHZ	1000
>>   
>>   static struct class *devfreq_class;
>> +static struct dentry *devfreq_debugfs;
>>   
>>   /*
>>    * devfreq core provides delayed work based load monitoring helper
>> @@ -1643,6 +1645,79 @@ static struct attribute *devfreq_attrs[] = {
>>   };
>>   ATTRIBUTE_GROUPS(devfreq);
>>   
>> +/**
>> + * devfreq_summary_show() - Show the summary of the devfreq devices
>> + * @s:		seq_file instance to show the summary of devfreq devices
>> + * @data:	not used
>> + *
>> + * Show the summary of the devfreq devices via 'devfreq_summary' debugfs file.
>> + * It helps that user can know the detailed information of the devfreq devices.
>> + *
>> + * Return 0 always because it shows the information without any data change.
>> + */
>> +static int devfreq_summary_show(struct seq_file *s, void *data)
>> +{
>> +	struct devfreq *devfreq;
>> +	struct devfreq *p_devfreq = NULL;
>> +	unsigned long cur_freq, min_freq, max_freq;
>> +	unsigned int polling_ms;
>> +
>> +	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",
>> +			"dev_name",
>> +			"dev",
>> +			"parent_dev",
>> +			"governor",
>> +			"polling_ms",
>> +			"cur_freq_Hz",
>> +			"min_freq_Hz",
>> +			"max_freq_Hz");
>> +	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",
>> +			"------------------------------",
>> +			"----------",
>> +			"----------",
>> +			"---------------",
>> +			"----------",
>> +			"------------",
>> +			"------------",
>> +			"------------");
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +
>> +	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
>> +		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
>> +							DEVFREQ_NAME_LEN)) {
>> +			struct devfreq_passive_data *data = devfreq->data;
>> +
>> +			if (data)
>> +				p_devfreq = data->parent;
>> +		} else {
>> +			p_devfreq = NULL;
>> +		}
>> +
>> +		mutex_lock(&devfreq->lock);
>> +		cur_freq = devfreq->previous_freq,
>> +		get_freq_range(devfreq, &min_freq, &max_freq);
>> +		polling_ms = devfreq->profile->polling_ms,
>> +		mutex_unlock(&devfreq->lock);
>> +
>> +		seq_printf(s,
>> +			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",
>> +			dev_name(devfreq->dev.parent),
>> +			dev_name(&devfreq->dev),
>> +			p_devfreq ? dev_name(&p_devfreq->dev) : "",
> 
> Can you prints some sort of "null" here instead of just skipping the field?
> 
> This would ensure output is always a whitespace-separated table that can 
> be easily processed with tools like "awk".

OK.
I had considered what is better to show 'null' or not.
If there is requirement, print 'null'.

> 
>> +			devfreq->governor_name,
>> +			polling_ms,
>> +			cur_freq,
>> +			min_freq,
>> +			max_freq);
>> +	}
>> +
>> +	mutex_unlock(&devfreq_list_lock);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
>> +
>>   static int __init devfreq_init(void)
>>   {
>>   	devfreq_class = class_create(THIS_MODULE, "devfreq");
>> @@ -1659,6 +1734,15 @@ static int __init devfreq_init(void)
>>   	}
>>   	devfreq_class->dev_groups = devfreq_groups;
>>   
>> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
>> +	if (IS_ERR(devfreq_debugfs) && PTR_ERR(devfreq_debugfs) != -ENODEV) {
>> +		pr_warn("%s: couldn't create debugfs dir\n", __FILE__); > +	} else {
>> +		debugfs_create_file("devfreq_summary", 0444,
>> +				devfreq_debugfs, NULL,
>> +				&devfreq_summary_fops);
>> +	}
>> +
>>   	return 0;
>>   }
>>   subsys_initcall(devfreq_init);
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
