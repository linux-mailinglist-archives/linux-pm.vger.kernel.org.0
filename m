Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F82133C72
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 08:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgAHHtb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 02:49:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:30282 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgAHHtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 02:49:31 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200108074928epoutp03696e7bbe443270d65822b3d6bc52d7cd~n2eRKK6A32108821088epoutp03H
        for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2020 07:49:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200108074928epoutp03696e7bbe443270d65822b3d6bc52d7cd~n2eRKK6A32108821088epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578469768;
        bh=584aCk63e5RA1sUDbXlX9a2aW2l9YA7m6z16yqgJX6A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZPfneF+46JXkshCG1wuIZGK4SkFScDHEDHEdlvEA0B2kVg5UtqtkBw0CDOpTxPoOj
         9Wy4kaZi7xlc7pCprXgfCfaO57a58TObDffo3cnAIS3kSLKGLCWcyp74uPAlTonOCb
         xAHG88eSTHzYATDn+2u0PoMb55ftLHgfHDyO2kM4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200108074928epcas1p1990be9c2c6e1a00e8f3c43464a8640ce~n2eQvGCcc1326313263epcas1p1M;
        Wed,  8 Jan 2020 07:49:28 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47t1bn5xZBzMqYkb; Wed,  8 Jan
        2020 07:49:25 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.59.48498.589851E5; Wed,  8 Jan 2020 16:49:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200108074924epcas1p29f306b5822b708e7cb49a486e320ec4e~n2eNfEaD30550105501epcas1p2Z;
        Wed,  8 Jan 2020 07:49:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200108074924epsmtrp14165ba136856d964b19f112cd90c8658~n2eNeP2Pv1352513525epsmtrp1U;
        Wed,  8 Jan 2020 07:49:24 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-27-5e15898563fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.56.10238.489851E5; Wed,  8 Jan 2020 16:49:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200108074924epsmtip1635caef54c86d2336297feca6ed0e951~n2eNLBgav2771127711epsmtip1T;
        Wed,  8 Jan 2020 07:49:24 +0000 (GMT)
Subject: Re: [PATCH 1/2] PM / devfreq: Add debugfs support with
 devfreq_summary file
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, jcrouse@codeaurora.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <19fd2201-2a7d-46df-09cf-e39f6668b488@samsung.com>
Date:   Wed, 8 Jan 2020 16:56:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200107211558.GA738324@yoga>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmnm5rp2icQXOLocX9ea2MFqf3v2Ox
        mHjjCovF6o+PGS3W3D7EaPFjwylmi40Lsi3ONr1ht1hx9yOrxeVdc9gsPvceYbRY2NTCbrH2
        yF12i9uNK9gc+DzWzFvD6HG5r5fJY8fdJYweO2fdZffYtKqTzePOtT1sHhvf7WDy+DtrP4tH
        35ZVjB6fN8kFcEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4
        BOi6ZeYAfaCkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87P
        tTI0MDAyBSpMyM6YcGgxe8E+vYp5i/+yNTBeVuhi5OSQEDCReHP9KTuILSSwg1FieqtUFyMX
        kP2JUeLjqpVMEM43RomLz3ezwnS8O/OWDSKxl1Hi4ZqvrBDOe0aJQ/9usYFUCQuESUy4PZEJ
        xBYRMJA4euYyC0gRs8ARJoldq3+BJdgEtCT2v7gB1sAvoChx9cdjRhCbV8BO4uGOOywgNouA
        isTsk/PA4qJAQ09ua4GqEZQ4OfMJWA2ngLbEyf6fYE8wC4hL3HoynwnClpfY/nYOM8hiCYFT
        7BLNS7qgfnCRWHhpLxOELSzx6vgWdghbSuJlfxuUXS2x8uQRNojmDkaJLfsvQDUbS+xfOhmo
        mQNog6bE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQiiRFni8oO7UGslJRa3d7JNYFSa
        heSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBCju5NjODkrWW2g3HROZ9DjAIcjEo8vD8W
        i8QJsSaWFVfmHmKU4GBWEuHV0gEK8aYkVlalFuXHF5XmpBYfYjQFhvZEZinR5HxgZskriTc0
        NTI2NrYwMTQzNTRUEufl+HExVkggPbEkNTs1tSC1CKaPiYNTqoGxSZpT8mL/qZUGCVdSt+Yy
        VkvNXdm37MCixeceVz7KcGHc9/H9nZ031Sf95l1xaaFHvsH6ipLcAzb5+uZujHG26Rk7ctiv
        2W28n199v3ifVf2iD58Wx8jfWWpnfcxwM4PhgfcV15M0AvrKOL9+3FiX2f4obY9z1vV9vnfK
        VCS4OWasyWuolrmixFKckWioxVxUnAgA7oJ2OvQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnG5Lp2icwfu7hhb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmBz4PNYM28No8flvl4mjx13lzB67Jx1l91j06pONo871/aweWx8t4PJ4++s/Swe
        fVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlTHh0GL2gn16FfMW/2VrYLys0MXIySEhYCLx7sxb
        NhBbSGA3o8ShVj6IuKTEtItHmbsYOYBsYYnDh4u7GLmASt4ySiybtIYZpEZYIExiwu2JTCC2
        iICBxNEzl1lAipgFjjBJvH15hRGi4w6jxMK1U9hBqtgEtCT2v7gBto1fQFHi6o/HjCA2r4Cd
        xMMdd1hAbBYBFYnZJ+eBxUWBNuxc8pgJokZQ4uTMJ2A1nALaEif7f4LNZBZQl/gz7xIzhC0u
        cevJfCYIW15i+9s5zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0u
        zUvXS87P3cQIjmItzR2Ml5fEH2IU4GBU4uH9sVgkTog1say4MvcQowQHs5IIr5YOUIg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5OqQZGJ/YjelcryzpYOL5c
        6D7APneSAYOuRYZ25oGYgM9Cx+d08BhMtbPvVZkms9t+7bGYWbaum1ki7ob+mq7M9LKqX8hj
        6ezPPea7sg9IqzxdsE25ynzLMv3ZE3lYL2UeyJrXIvuRd+fy3hcndlZxXbFRKDIV6d67vuOd
        1M0f0ixXJvqUeVhvU5NUYinOSDTUYi4qTgQAyYGH/t4CAAA=
X-CMS-MailID: 20200108074924epcas1p29f306b5822b708e7cb49a486e320ec4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107085812epcas1p12121f8ef6492ed78053dea4977216788
References: <20200107090519.3231-1-cw00.choi@samsung.com>
        <CGME20200107085812epcas1p12121f8ef6492ed78053dea4977216788@epcas1p1.samsung.com>
        <20200107090519.3231-2-cw00.choi@samsung.com> <20200107211558.GA738324@yoga>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/8/20 6:15 AM, Bjorn Andersson wrote:
> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
> 
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
>> - cur_freq_hz	: Current Frequency (unit: hz)
>> - old_freq_hz	: Frequency before changing. (unit: hz)
>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>
>> [For example on Exynos5422-based Odroid-XU3 board]
>> - In order to show the multiple governors on devfreq_summay result,
>> change the governor of devfreq0 from simple_ondemand to userspace.
>>
>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>> dev_name                       dev        parent_dev governor        polling_ms cur_freq_hz  min_freq_hz  max_freq_hz
>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>> 10c20000.memory-controller     devfreq0              userspace       0          206000000    165000000    825000000
>> soc:bus_wcore                  devfreq1              simple_ondemand 50         532000000    88700000     532000000
>> soc:bus_noc                    devfreq2   devfreq1   passive         0          111000000    66600000     111000000
>> soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          222000000    111000000    222000000
>> soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    75000000     200000000
>> soc:bus_fsys2                  devfreq5   devfreq1   passive         0          200000000    75000000     200000000
>> soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    83250000     333000000
>> soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000    88700000     266000000
>> soc:bus_peri                   devfreq8   devfreq1   passive         0          66600000     66600000     66600000
>> soc:bus_g2d                    devfreq9   devfreq1   passive         0          0            83250000     333000000
>> soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          0            66500000     266000000
>> soc:bus_jpeg                   devfreq11  devfreq1   passive         0          0            75000000     300000000
>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          0            83250000     166500000
>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          0            120000000    200000000
>> soc:bus_disp1                  devfreq14  devfreq1   passive         0          0            120000000    300000000
>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          0            150000000    300000000
>> soc:bus_mscl                   devfreq16  devfreq1   passive         0          0            84000000     666000000
> 
> This looks quite useful.
> 
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
> 
> May I ask how the build test robot came up with this idea?

I'm missing the detailed what are the reported by kbuild test robot.
It reported the possible build error. I'll add the following description
on next version:
	[lkp: Reported the build error]

> 
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 80 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> [..]
>> +/**
>> + * devfreq_summary_show() - Show the summary of the registered devfreq devices
>> + *				via 'devfreq_summary' debugfs file.
> 
> Please make this proper kerneldoc, i.e:
> 
>  * func() - short description
>  * @s:
>  * @data:
>  * 
>  * Long description
>  * 
>  * Return: foo on bar

OK.

> 
> [..]
>> @@ -1733,6 +1803,16 @@ static int __init devfreq_init(void)
>>  	}
>>  	devfreq_class->dev_groups = devfreq_groups;
>>  
>> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
>> +	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs)) {
> 
> Don't PTR_ERR() before IS_ERR().

Before checking IS_ERR(), have to check the PTR_ERR(devfreq_debugfs)
is -ENODEV or not because debugfs_create_dir return the '-ENODEV'
if DEBUG_FS is disabled. If return the -ENODEV, it is not error.

> 
>> +		devfreq_debugfs = NULL;
> 
> I don't think you need this, given that debugfs_create_file() will fail
> gracefully when passed and IS_ERR()

Right. Jut on patch2 checks the 'devfreq_debugfs' is NULL or not
in order to catch the DEBUG_FS is well working for devfreq.
Anyway, it would be better to add it to patch2 because devfreq_debugfs
is not used when failed to create debugfs dir.

> 
>> +		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
> 
> Afaict debugfs_create_() won't fail without printing a message already.

It just print the error message when DEBUG_FS is enabled
and debugfs_create_dir() returns the error.

> 
>> +	} else {
>> +		debugfs_create_file("devfreq_summary", 0444,
>> +				devfreq_debugfs, NULL,
>> +				&devfreq_summary_fops);
>> +	}
>> +
>>  	return 0;
>>  }
>>  subsys_initcall(devfreq_init);
> 
> Regards,
> Bjorn
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
