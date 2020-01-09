Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0FC1353F9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 09:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgAIIAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 03:00:06 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:62436 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgAIIAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 03:00:06 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200109080002epoutp03af6f07beab42e6eabc9b242602f4880a~oKQxTHVZM2591925919epoutp03g
        for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2020 08:00:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200109080002epoutp03af6f07beab42e6eabc9b242602f4880a~oKQxTHVZM2591925919epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578556802;
        bh=GISTzON3FUJxE0UCMZa11CdWc2rxeQJllnlBZ3BuxHc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TsRHMUqZX3Guf2iCKkd2GNoRR/uAfWRJABVBfWqU6o+jjPPw5r4/Eh5LJBJabQ0UC
         KZtRBAUY3mjbRhjO1rSXh9zlnjG/EGqvvaL2zBLo+EDkcM2FV8TSFRS32WgCdWrx8/
         ze7TzR082JQw7M17E8H5KK23UN7sixZsxKGjvXak=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200109080001epcas1p20772340e8a3226c11cbea94714b1ff31~oKQwst8GU0984409844epcas1p2G;
        Thu,  9 Jan 2020 08:00:01 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47tdnW0rQnzMqYkd; Thu,  9 Jan
        2020 07:59:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.46.48019.F7DD61E5; Thu,  9 Jan 2020 16:59:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200109075958epcas1p47b0450efdd9444da21b6d5cf36c81b6d~oKQtZSHko1368513685epcas1p4a;
        Thu,  9 Jan 2020 07:59:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109075958epsmtrp16c5873f3ba436428b0b8ed6491d94d9c~oKQtYbNZl1123911239epsmtrp11;
        Thu,  9 Jan 2020 07:59:58 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-33-5e16dd7fe7e3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.B5.06569.D7DD61E5; Thu,  9 Jan 2020 16:59:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200109075957epsmtip1b83c2225a297b974edaca976aad98f88~oKQtHY7tJ1007210072epsmtip1I;
        Thu,  9 Jan 2020 07:59:57 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
To:     Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9c3574e8-945b-56c4-3425-28e68cd3d2a9@samsung.com>
Date:   Thu, 9 Jan 2020 17:07:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <c1e6f324-b0c2-41ff-a015-7ba0b29ad42c@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmnm79XbE4g9PLWC3uz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG1xtukNu8WKux9ZLS7vmsNm8bn3CKPFwqYWdou1
        R+6yW9xuXMHmwOexZt4aRo/Lfb1MHjvuLmH02DnrLrvHplWdbB53ru1h89j4bgeTx99Z+1k8
        +rasYvT4vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnF
        J0DXLTMH6AMlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+
        rpWhgYGRKVBhQnbGlM9PGQu2KVQ823WDqYHxiVgXIweHhICJxPQd2l2MXBxCAjsYJQ6+/MYO
        4XxilGiesJkRwvnGKLGj9zhzFyMnWMe61qlMEIm9jBKrVvxihnDeM0qcOnoVrEpYwFtiftcS
        FhBbRCBMouX6ITaQImaBTUwS7RNvs4Ik2AS0JPa/uMEGYvMLKEpc/fGYEcTmFbCTeDdrLzuI
        zSKgIvH2XxdYvSjQoJPbWqBqBCVOznwCtoBTwFbi1JkpYHOYBcQlbj2ZzwRhy0s0b50Ndp2E
        wCl2ia65i5ggfnCR+Lj+GwuELSzx6vgWdghbSuJlfxuUXS2x8uQRNojmDkaJLfsvsEIkjCX2
        L53MBAo+ZgFNifW79CHCihI7f89lhFjMJ/Huaw8rJIR5JTrahCBKlCUuP7gLdYKkxOL2TrYJ
        jEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBSbI0b2JEZy8tSx2MO4553OIUYCDUYmH
        l0FJLE6INbGsuDL3EKMEB7OSCO/RG0Ah3pTEyqrUovz4otKc1OJDjKbA0J7ILCWanA/MLHkl
        8YamRsbGxhYmhmamhoZK4rwcPy7GCgmkJ5akZqemFqQWwfQxcXBKNTAy8s74J8nRq8gYafZo
        0cITBSvrXniwn/64jsHf/a6+mKZU/+MKvdlJ9x7POrvupvmZ3m9n6799jF+XULHiq/N7mQUG
        mot1Uv/OORX/QDXMxJL78C2bT4LT92yZ5s/2wGPXNf4L77NP7Ex1ey5c36XtcfBNnr5w0k6J
        g8L+aupzVr2et5l/yvHtSizFGYmGWsxFxYkAl90mE/QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSnG7tXbE4gzOLbSzuz2tltDi9/x2L
        xcQbV1gsVn98zGix5vYhRosfG04xW2xckG1xtukNu8WKux9ZLS7vmsNm8bn3CKPFwqYWdou1
        R+6yW9xuXMHmwOexZt4aRo/Lfb1MHjvuLmH02DnrLrvHplWdbB53ru1h89j4bgeTx99Z+1k8
        +rasYvT4vEkugCuKyyYlNSezLLVI3y6BK2PK56eMBdsUKp7tusHUwPhErIuRk0NCwERiXetU
        pi5GLg4hgd2MEt/vr2WGSEhKTLt4FMjmALKFJQ4fLoaoecso8fX7RBaQGmEBb4n5XUvAbBGB
        MIn1t1cxghQxC2xikjjS+oMdoqOfSWLrpbWMIFVsAloS+1/cYAOx+QUUJa7+eAwW5xWwk3g3
        ay87iM0ioCLx9l8XK4gtCjR155LHTBA1ghInZz4B28YpYCtx6swUsDnMAuoSf+ZdYoawxSVu
        PZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8
        dL3k/NxNjOA41tLawXjiRPwhRgEORiUeXgYlsTgh1sSy4srcQ4wSHMxKIrxHbwCFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MC49/spKrd3x+vGJW1a+
        PqhUEXRIrO5e30mtlUlWHzpY7lxkWN98q/akiHTbtlsq1779WzrhQMDaBVmcr5yk9e9x9L4O
        PLEjKyWKT7PXYNraez88H3F9bd974cq31LyQk1wbQi88i683Y7lx3ivPir/+WvVvg+LarVec
        XP0Evd93zbiva6M6/YYSS3FGoqEWc1FxIgDog/gq3wIAAA==
X-CMS-MailID: 20200109075958epcas1p47b0450efdd9444da21b6d5cf36c81b6d
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn and Dmitry,

I replied from Bjorn and Dmitry opinion.

On 1/8/20 11:20 PM, Dmitry Osipenko wrote:
> 08.01.2020 00:48, Bjorn Andersson пишет:
>> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
>>
>>> Add new devfreq_transitions debugfs file to track the frequency transitions
>>> of all devfreq devices for the simple profiling as following:
>>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>>
>>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>>> in Kconfig in order to save the transition history.
>>>
>>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>>> - time_ms	: Change time of frequency transition. (unit: millisecond)
>>> - dev_name	: Device name of h/w.
>>> - dev		: Device name made by devfreq core.
>>> - parent_dev	: If devfreq device uses the passive governor,
>>> 		  show parent devfreq device name.
>>> - load_%	: If devfreq device uses the simple_ondemand governor,
>>> 		  load is used by governor whene deciding the new frequency.
>>> 		  (unit: percentage)
>>> - old_freq_hz	: Frequency before changing. (unit: hz)
>>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>>
>>> [For example on Exynos5422-based Odroid-XU3 board]
>>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>>> [snip]
>>>
>>
>> Wouldn't it make more sense to expose this through the tracing
>> framework - like many other subsystems does?
> 
> I think devfreq core already has some tracing support and indeed it
> should be better to extend it rather than duplicate.
> 

First of all, thanks for comments.

Before developing it, I have considered what is better to
support debugging features for devfreq device. As you commented,
trace event is more general way to catch the detailed behavior.

But, I hope to provide the very easy simple profiling way
for user if it is not harmful to the principle of linux kernel.

In order to prevent the performance regression when DEBUG_FS is enabled,
I will add the CONFIG_DEVFREQ_TRANSITIONS_DEBUG for 'devfreq_transitions'
to make it selectable.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
