Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB1135725
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 11:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgAIKig (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 05:38:36 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:16960 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgAIKif (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 05:38:35 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200109103832epoutp047dbd03cbe70e97708a01ab487c223e59~oMbKtRw7j0733407334epoutp04V
        for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2020 10:38:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200109103832epoutp047dbd03cbe70e97708a01ab487c223e59~oMbKtRw7j0733407334epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578566312;
        bh=dsJat2dIoMSukh1t+PG3blAm7nGrQ41KND9hQx8YTOM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GjLPKH4yMUXkGJHRChBgQWjUFbaYN6DxqUnBdIkp++n8PU8AQPPi+K4PdXqeudcll
         THrj4nfwB3KHWI86c54ieCiYTanz+K2o+I/RMXJp5jaG7Pwpnxeffg3silvfH2zFRW
         WLjON9KK99gWUkpCZRjrCLINLh4whgkdf6zoLO38=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200109103832epcas1p41e2718fbcf167f8ae4cee72ab03e6617~oMbKDzNRK2527025270epcas1p4F;
        Thu,  9 Jan 2020 10:38:32 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47tjJP6brczMqYkZ; Thu,  9 Jan
        2020 10:38:29 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.4E.52419.5A2071E5; Thu,  9 Jan 2020 19:38:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200109103829epcas1p4e5646d254c28dd2262fb97653aca58bf~oMbHkDBPc1742817428epcas1p4w;
        Thu,  9 Jan 2020 10:38:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109103829epsmtrp18d7303850cef005f11778a055e985862~oMbHjSE6w3208532085epsmtrp1X;
        Thu,  9 Jan 2020 10:38:29 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-09-5e1702a5940a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.83.06569.5A2071E5; Thu,  9 Jan 2020 19:38:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200109103829epsmtip1018528490c326be323b63e9c60928018~oMbHVPk0V3205132051epsmtip1J;
        Thu,  9 Jan 2020 10:38:29 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <18548375-5fe5-4222-67ac-f04bca7ea5ba@samsung.com>
Date:   Thu, 9 Jan 2020 19:45:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ddbc54d1-c657-747c-265d-3c7bd5924e59@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmvu5SJvE4g/dPjSzuz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG1xtukNu8WKux9ZLS7vmsNm8bn3CKPFwqYWdou1
        R+6yW9xuXMHmwOexZt4aRo/Lfb1MHjvuLmH02DnrLrvHplWdbB53ru1h89j4bgeTx99Z+1k8
        +rasYvT4vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+
        rpWhgYGRKVBhQnbGjzdNTAWnDCvefNzE1sDYrN3FyMkhIWAi8et9G1MXIxeHkMAORoll03uZ
        IZxPjBJbzzxmg3C+MUqsWHaQBabl5sIJjBCJvYwSJ6ceYIFw3jNKLH+xHqxKWMBbYn7XEjBb
        RKBS4tC582BzmQVmM0lMvdjBBpJgE9CS2P/iBpjNL6AocfXHY0YQm1fATqKh9wQziM0ioCJx
        af97JhBbVCBM4uS2FqgaQYmTM5+ALeAUsJaYumwj2BxmAXGJW0/mM0HY8hLNW2czQ5x9jF1i
        c3cwhO0i0TNrNVRcWOLV8S3sELaUxMv+Nii7WmLlySNg/0sIdDBKbNl/gRUiYSyxf+lkoAUc
        QAs0Jdbv0ocIK0rs/D2XEWIvn8S7rz2sICUSArwSHW1CECXKEpcf3GWCsCUlFrd3sk1gVJqF
        5JtZSD6YheSDWQjLFjCyrGIUSy0ozk1PLTYsMEaO7k2M4OStZb6DccM5n0OMAhyMSjy8DEpi
        cUKsiWXFlbmHGCU4mJVEeI/eAArxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGBmySuJNzQ1
        MjY2tjAxNDM1NFQS5+X4cTFWSCA9sSQ1OzW1ILUIpo+Jg1OqgTGgcsbSnhvXSx+ELRRpmFCp
        9eZzwtTzxT05Tls+ybccl1o5W4Zr6Rsmx+6EIIP4+X9dXnzjWujyq+Ff3fdXUycevt3jwZ2g
        J+PwWsTviOmt4I+ub/2t47wtgswZSz3rWa7Nenvzl228R6jGrtOz3uznla2zPrDwb6HZLxen
        t/kzTx3QU5BaJ6rEUpyRaKjFXFScCAB6KLja9AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7bCSnO5SJvE4gym/xC3uz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG1xtukNu8WKux9ZLS7vmsNm8bn3CKPFwqYWdou1
        R+6yW9xuXMHmwOexZt4aRo/Lfb1MHjvuLmH02DnrLrvHplWdbB53ru1h89j4bgeTx99Z+1k8
        +rasYvT4vEkugCuKyyYlNSezLLVI3y6BK+PHmyamglOGFW8+bmJrYGzW7mLk5JAQMJG4uXAC
        I4gtJLCbUaJ1XS5EXFJi2sWjzF2MHEC2sMThw8VdjFxAJW8ZJRofHmIFqREW8JaY37WEBcQW
        EaiUON98CGwOs8BsJonjxxMhZh5gkjj6Lw7EZhPQktj/4gYbiM0voChx9cdjsHpeATuJht4T
        zCA2i4CKxKX975lAbFGBMImdSx4zQdQISpyc+QRsF6eAtcTUZRvZIHapS/yZd4kZwhaXuPVk
        PhOELS/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1
        kvNzNzGCI1hLawfjiRPxhxgFOBiVeHgZlMTihFgTy4orcw8xSnAwK4nwHr0BFOJNSaysSi3K
        jy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp1cBYtKD3y8snM69fN66fE6s0
        N2d3kE0Eg5zHFqXVZ4L0+JLO1u4Nkiy5tN34/JYripdWHZuYW88uvHHtlceVWsveFYqW5Jjn
        nE9QnqT+gWla99MlZRJc7zx2bHudPoeLYbPG5usNwuc7v3n6GOtsfe1t833K7I1L+k5XGUZ1
        bololFM6LR6vK7dDiaU4I9FQi7moOBEAYLIDfNwCAAA=
X-CMS-MailID: 20200109103829epcas1p4e5646d254c28dd2262fb97653aca58bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea
References: <20200107090519.3231-1-cw00.choi@samsung.com>
        <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
        <20200107090519.3231-3-cw00.choi@samsung.com> <20200107214834.GB738324@yoga>
        <c1e6f324-b0c2-41ff-a015-7ba0b29ad42c@gmail.com>
        <ddbc54d1-c657-747c-265d-3c7bd5924e59@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/9/20 12:44 AM, Lukasz Luba wrote:
> Hi,
> 
> On 1/8/20 2:20 PM, Dmitry Osipenko wrote:
>> 08.01.2020 00:48, Bjorn Andersson пишет:
>>> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
>>>
>>>> Add new devfreq_transitions debugfs file to track the frequency transitions
>>>> of all devfreq devices for the simple profiling as following:
>>>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>>>
>>>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>>>> in Kconfig in order to save the transition history.
>>>>
>>>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>>>> - time_ms    : Change time of frequency transition. (unit: millisecond)
>>>> - dev_name    : Device name of h/w.
>>>> - dev        : Device name made by devfreq core.
>>>> - parent_dev    : If devfreq device uses the passive governor,
>>>>           show parent devfreq device name.
>>>> - load_%    : If devfreq device uses the simple_ondemand governor,
>>>>           load is used by governor whene deciding the new frequency.
>>>>           (unit: percentage)
>>>> - old_freq_hz    : Frequency before changing. (unit: hz)
>>>> - new_freq_hz    : Frequency after changed. (unit: hz)
>>>>
>>>> [For example on Exynos5422-based Odroid-XU3 board]
>>>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>>>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>>>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>>>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>>>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>>>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>>>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>>>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>>>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>>>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>>>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>>>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>>>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>>>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>>>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>>>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>>>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>>>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>>>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>>>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>>>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>>>> [snip]
>>>>
>>>
>>> Wouldn't it make more sense to expose this through the tracing
>>> framework - like many other subsystems does?
>>
>> I think devfreq core already has some tracing support and indeed it
>> should be better to extend it rather than duplicate.
>>
> 
> In my opinion this debugfs interface should be considered as a helpful
> validation entry point. We had some issues with wrong bootloader
> configurations in clock tree, where some frequencies could not be set
> in the kernel. Similar useful description can be find in clock subsystem
> where there is clock tree summary file.
> 
> It is much cheaper to poke a few files in debug dir by some automated
> test than starting tracing, provoking desired code flow in the
> devfreq for every device, paring the results... A simple boot test
> which reads only these new files can be enough to rise the flag.
> Secondly the tracing is not always compiled.
> 
> It could capture old/wrong bootloaders which pinned devices
> improperly to PLLs or wrong DT values in OPP table.
> (a workaround for Odroid xu4 patchset:
> https://protect2.fireeye.com/url?k=364d2fbb-6b9993d3-364ca4f4-0cc47a3356b2-98db7e7cf023414c&u=https://lkml.org/lkml/2019/7/15/276
> )
> 
> Chanwoo what do think about some sanity check summary?
> It could be presented in a 3rd file: 'devfreq_sanity', which
> could report if the devices could set their registered OPPs
> and got the same values, i.e. set 166MHz --> set to 150MHz
> in reality. If a config option i.e. DEVFREQ_SANITY is set
> then during the registration of a new device it checks OPPs
> if they are possible to set. It could be done before assigning
> the governor for the device and results present in of of your files.

Firstly, I'm welcoming to add new debugging feature.

As you suggested, it is required for the OPP control.
But, I'm not sure that it have to be verified in either OPP or devfreq.
Or it have be verified when adding the OPP table into devicetree file.

If we add this debugging feature, I think 'resource_sanity' as following path.
/sys/kernel/debug/devfreq/devfreqX/resource_sanity (not fixed name)
- show the sanity result of regulator voltage and frequency

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
