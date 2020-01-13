Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27897138A42
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 05:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgAMEiZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 23:38:25 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:33297 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733091AbgAMEiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 23:38:24 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200113043821epoutp045c00ae4a263f7b57e8770d3340f25b82~pWF0nSVKU0201502015epoutp041
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 04:38:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200113043821epoutp045c00ae4a263f7b57e8770d3340f25b82~pWF0nSVKU0201502015epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578890301;
        bh=/rRz5phyNr4mNJEXZyX7ok3BCz3TNLCL2Umb9JgETvE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=S9XSB8KXwpgRSMRTb4uNgXm2I6y22fJcmR+DxL235ZE+J6Vb5EfsQ2sVCOcFT7ern
         mZFVOROeRPs0NoQTm2xROy3gPJ7XwPRediAj0x+WwP9hmVpakkGrL9uc8lQSiG9jzX
         L9BpVz1yckKywKRdF0+OFffXjanEKvJsF856WhDY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200113043820epcas1p3928ab3ddc65e4f5f70f0a7f6e28c6cae~pWFzsthzj2055220552epcas1p3n;
        Mon, 13 Jan 2020 04:38:20 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47x16x1RHnzMqYkj; Mon, 13 Jan
        2020 04:38:17 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.00.48019.834FB1E5; Mon, 13 Jan 2020 13:38:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200113043816epcas1p384dcab3cb1d2bbb82596df4f51ae2a51~pWFvsPxVz3210732107epcas1p3E;
        Mon, 13 Jan 2020 04:38:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200113043816epsmtrp189bb7c8b12f928d1631da3b2ba7b59ff~pWFvrcswl2907429074epsmtrp1f;
        Mon, 13 Jan 2020 04:38:16 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-10-5e1bf43856c3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.1D.10238.834FB1E5; Mon, 13 Jan 2020 13:38:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200113043815epsmtip12817b102fd9c104120b9f8b3afc1cb55~pWFvZHA7X0158801588epsmtip1F;
        Mon, 13 Jan 2020 04:38:15 +0000 (GMT)
Subject: Re: [PATCH 1/2] PM / devfreq: Add debugfs support with
 devfreq_summary file
To:     Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d941be84-33db-0943-ae8d-455b6aa78b57@samsung.com>
Date:   Mon, 13 Jan 2020 13:45:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <daf456c6-7897-3086-329c-e2fd76e75f37@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmvq7lF+k4g/cFFvfntTJanN7/jsVi
        4o0rLBarPz5mtFhz+xCjxY8Np5gtNi7Itjjb9IbdYsXdj6wWl3fNYbP43HuE0WJhUwu7xdoj
        d9ktbjeuYHPg81gzbw2jx+W+XiaPHXeXMHrsnHWX3WPTqk42jzvX9rB5bHy3g8nj76z9LB59
        W1YxenzeJBfAFZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQP0gJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/X
        ytDAwMgUqDAhO+Pq4qMsBad0Ki5Om8jewHhcvouRg0NCwERi1WuvLkYuDiGBHYwSTb9/s0M4
        nxglNnTPY4JwvjFKLJ/QCpThBOtYf/YTVGIvo8T5WTtZIJz3jBKz2xYwgVQJC4RJTLg9EcwW
        AbJbrh9iAyliFtjEJNE+8TYrSIJNQEti/4sbbCA2v4CixNUfjxlBbF4BO4nPn/+xgNgsAqoS
        rac2gNWIAg06ua0FqkZQ4uTMJ2A1nAK2EhfutoPVMAuIS9x6Mp8JwpaXaN46mxni7FPsErM2
        1ULYLhLfpn9ng7CFJV4d3wL1mpTEy/42KLtaYuXJI2BHSwh0MEps2X+BFSJhLLF/6WQmUOgx
        C2hKrN+lDxFWlNj5ey4jxF4+iXdfe1ghAcwr0dEmBFGiLHH5wV0mCFtSYnF7J9sERqVZSL6Z
        heSDWUg+mIWwbAEjyypGsdSC4tz01GLDAhPk2N7ECE7cWhY7GPec8znEKMDBqMTDK1ErHSfE
        mlhWXJl7iFGCg1lJhHfTOak4Id6UxMqq1KL8+KLSnNTiQ4ymwMCeyCwlmpwPzCp5JfGGpkbG
        xsYWJoZmpoaGSuK8HD8uxgoJpCeWpGanphakFsH0MXFwSjUwrnwz+9SPVKP1DILLZtdq8O2b
        q2LLkn8y/oEcqxX37Mbjs2fMXTWlVisiYurhEonoxA83Und3dIktncE/7cqKyW2mpkl3efe5
        xq1kuzpzdszmcN/yV3J507ZZScTH3epcvfPr9c6Lzx5ylPZ32f7b81qBMYvla8imwICiIxE6
        6T/v1EXk88z/ocRSnJFoqMVcVJwIAGSKYFTyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSnK7FF+k4g7aZLBb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmBz4PNYM28No8flvl4mjx13lzB67Jx1l91j06pONo871/aweWx8t4PJ4++s/Swe
        fVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlXF18VGWglM6FRenTWRvYDwu38XIySEhYCKx/uwn
        pi5GLg4hgd2MEj8mPmaBSEhKTLt4lLmLkQPIFpY4fLgYouYto8SLiYeYQGqEBcIkJtyeCGaL
        ANnrb69iBCliFtjEJHGk9Qc7SEJI4AiTxIEuGRCbTUBLYv+LG2wgNr+AosTVH48ZQWxeATuJ
        z5//gS1mEVCVaD21AaxGFGjoziWPmSBqBCVOznwCVsMpYCtx4W47WA2zgLrEn3mXmCFscYlb
        T+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQv
        XS85P3cTIziKtTR3MF5eEn+IUYCDUYmHV6JWOk6INbGsuDL3EKMEB7OSCO+mc1JxQrwpiZVV
        qUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTByHohd+Pnfn4qdZotF
        TGtuCb3wyO1fVfT+eYvV7YpCHfbeS48SZJ5YPIxenOxwpV3jhHOrpc+FO1fecRv+W7rXuOX3
        ROlDPUbS19c9WBofm3tY8DDnou+XDH0nasduuPvAe/bLiMO9j8rnPXr8XOLnW720O/drt72L
        Nr81LX29cJyLSuQX8Tl/lViKMxINtZiLihMBtb0qbN4CAAA=
X-CMS-MailID: 20200113043816epcas1p384dcab3cb1d2bbb82596df4f51ae2a51
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
        <19fd2201-2a7d-46df-09cf-e39f6668b488@samsung.com>
        <daf456c6-7897-3086-329c-e2fd76e75f37@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/8/20 11:14 PM, Dmitry Osipenko wrote:
> 08.01.2020 10:56, Chanwoo Choi пишет:
>> On 1/8/20 6:15 AM, Bjorn Andersson wrote:
>>> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
>>>
>>>> Add debugfs interface to provide debugging information of devfreq device.
>>>> It contains 'devfreq_summary' entry to show the summary of registered
>>>> devfreq devices as following and the additional debugfs file will be added.
>>>> - /sys/kernel/debug/devfreq/devfreq_summary
>>>>
>>>> [Detailed description of each field of 'devfreq_summary' debugfs file]
>>>> - dev_name	: Device name of h/w.
>>>> - dev		: Device name made by devfreq core.
>>>> - parent_dev	: If devfreq device uses the passive governor,
>>>> 		  show parent devfreq device name.
>>>> - governor	: Devfreq governor.
>>>> - polling_ms	: If devfreq device uses the simple_ondemand governor,
>>>> 		  polling_ms is necessary for the period. (unit: millisecond)
>>>> - cur_freq_hz	: Current Frequency (unit: hz)
>>>> - old_freq_hz	: Frequency before changing. (unit: hz)
>>>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>>>
>>>> [For example on Exynos5422-based Odroid-XU3 board]
>>>> - In order to show the multiple governors on devfreq_summay result,
>>>> change the governor of devfreq0 from simple_ondemand to userspace.
>>>>
>>>> $ cat /sys/kernel/debug/devfreq/devfreq_summary
>>>> dev_name                       dev        parent_dev governor        polling_ms cur_freq_hz  min_freq_hz  max_freq_hz
>>>> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
>>>> 10c20000.memory-controller     devfreq0              userspace       0          206000000    165000000    825000000
>>>> soc:bus_wcore                  devfreq1              simple_ondemand 50         532000000    88700000     532000000
>>>> soc:bus_noc                    devfreq2   devfreq1   passive         0          111000000    66600000     111000000
>>>> soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          222000000    111000000    222000000
>>>> soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    75000000     200000000
>>>> soc:bus_fsys2                  devfreq5   devfreq1   passive         0          200000000    75000000     200000000
>>>> soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    83250000     333000000
>>>> soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000    88700000     266000000
>>>> soc:bus_peri                   devfreq8   devfreq1   passive         0          66600000     66600000     66600000
>>>> soc:bus_g2d                    devfreq9   devfreq1   passive         0          0            83250000     333000000
>>>> soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          0            66500000     266000000
>>>> soc:bus_jpeg                   devfreq11  devfreq1   passive         0          0            75000000     300000000
>>>> soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          0            83250000     166500000
>>>> soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          0            120000000    200000000
>>>> soc:bus_disp1                  devfreq14  devfreq1   passive         0          0            120000000    300000000
>>>> soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          0            150000000    300000000
>>>> soc:bus_mscl                   devfreq16  devfreq1   passive         0          0            84000000     666000000
>>>
>>> This looks quite useful.
>>>
>>>>
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>> May I ask how the build test robot came up with this idea?
>>
>> I'm missing the detailed what are the reported by kbuild test robot.
>> It reported the possible build error. I'll add the following description
>> on next version:
>> 	[lkp: Reported the build error]
>>
>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  drivers/devfreq/devfreq.c | 80 +++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 80 insertions(+)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> [..]
>>>> +/**
>>>> + * devfreq_summary_show() - Show the summary of the registered devfreq devices
>>>> + *				via 'devfreq_summary' debugfs file.
>>>
>>> Please make this proper kerneldoc, i.e:
>>>
>>>  * func() - short description
>>>  * @s:
>>>  * @data:
>>>  * 
>>>  * Long description
>>>  * 
>>>  * Return: foo on bar
>>
>> OK.
>>
>>>
>>> [..]
>>>> @@ -1733,6 +1803,16 @@ static int __init devfreq_init(void)
>>>>  	}
>>>>  	devfreq_class->dev_groups = devfreq_groups;
>>>>  
>>>> +	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
>>>> +	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs)) {
>>>
>>> Don't PTR_ERR() before IS_ERR().
>>
>> Before checking IS_ERR(), have to check the PTR_ERR(devfreq_debugfs)
>> is -ENODEV or not because debugfs_create_dir return the '-ENODEV'
>> if DEBUG_FS is disabled. If return the -ENODEV, it is not error.
> 
> You could write it this way:
> 
> 	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
> 	err = PTR_ERR_OR_ZERO(devfreq_debugfs);
> 	if (err && err != -ENODEV) {

It is same result between your suggestion and following statement'
without any separate local variable. 

	if (IS_ERR(devfreq_debugfs) && PTR_ERR(devfreq_debugfs) != -ENODEV)


> 	...
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
