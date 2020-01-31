Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A057914EDC6
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 14:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgAaNrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 08:47:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32816 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgAaNrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2020 08:47:37 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200131134735euoutp01859799c46de63f924cfeba8dc761ad23~u-Mf2tUkf0777407774euoutp01V
        for <linux-pm@vger.kernel.org>; Fri, 31 Jan 2020 13:47:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200131134735euoutp01859799c46de63f924cfeba8dc761ad23~u-Mf2tUkf0777407774euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580478455;
        bh=K/VD5EZh+bInOz1zFU0V74SrmS09t2vWwx8NZDGRefw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Afe+1PkCv4WDOj/W+RLE3h4RMS+4gSmbLyrg4+Djhd+cLwIRsBp9jY+bdlaHYf65t
         whogDpfX7wIxo7xSmN7DNdR/FI/1C4wkzYNgumQfjtLjOJbb90BoOwA6O0038C8md8
         +ydglXlUvyuuTyiiVwS3ydftGzYXhqMFk9MmGSgw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200131134734eucas1p1b673e2cffae97b39a0fb7da5bab4aeb3~u-MfnW4aK3216232162eucas1p1i;
        Fri, 31 Jan 2020 13:47:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C3.55.61286.6FF243E5; Fri, 31
        Jan 2020 13:47:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200131134734eucas1p24a9e1cd038f1923c9a2b2b539184bc05~u-MfO2ehM0966009660eucas1p2J;
        Fri, 31 Jan 2020 13:47:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200131134734eusmtrp2b4a900ad61d48ed215df9562b386833a~u-MfOECyg0099000990eusmtrp2e;
        Fri, 31 Jan 2020 13:47:34 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-b9-5e342ff6888c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.10.08375.6FF243E5; Fri, 31
        Jan 2020 13:47:34 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200131134733eusmtip1550a3cf9f52d1251f80d9ae79191edfd~u-MeMsfnx3167031670eusmtip1l;
        Fri, 31 Jan 2020 13:47:33 +0000 (GMT)
Subject: Re: [PATCH 3/3] ARM: exynos_defconfig: Enable Energy Model
 framework
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lukasz.luba@arm.com, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, dietmar.eggemann@arm.com
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <08aff2de-85d5-36b2-13bb-bad6eb5d37eb@samsung.com>
Date:   Fri, 31 Jan 2020 14:47:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcZCks1SxwBP-vhpsYzpsrV9MQo91QNU2obgAppxfTiyQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djP87rf9E3iDH40allc//Kc1WL+kXOs
        Fk8nbGW26H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWJhUwu7xdLrF5ks
        bjeuYLNo3XuE3YHPY828NYwem1Z1snlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBmT
        J0xnKbgiWtHz5S1TA+NagS5GTg4JAROJxz9+MHcxcnEICaxglPiy7BsThPOFUWLDyZ9Qmc+M
        Eu87VrDAtDy885MNIrGcUeLH9U52COcto8Tj4zuZQKqEBfwlXh3oB7NFBDQlrv/9zgpSxCyw
        g1liVudNsFFsAlYSE9tXMYLYvAJ2Eqf2v2EGsVkEVCX+vW9lB7FFBSIkPj04zApRIyhxcuYT
        sF5OgUCJ2Wvvg/UyC4hL3HoynwnClpfY/nYO2N0SAi/ZJd5e3gB1t4vEx7XvoWxhiVfHt7BD
        2DIS/3fOZ4JoWMco8bfjBVT3dkaJ5ZP/sUFUWUvcOfcLyOYAWqEpsX6XPkTYUWL9or8sIGEJ
        AT6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7dq5knsCoNAvJa7OQvDMLyTuzEPYu
        YGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZjMTv87/mkH49dLSYcYBTgYlXh4C6RN
        4oRYE8uKK3MPMUpwMCuJ8Iq6GsYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1
        OzW1ILUIJsvEwSnVwCjpcMMkNNFDaK7d6joTN1e3n2n3fRp9O8z8eAsfad9okH+8PL5Mld99
        3/XZlVf35X601T0acd92jrLi+mN7RBabmYiv5bubIN5s2i621Wd5vvLDP4mrj09qk3m/65KE
        E/frqUebEkWjfTNfGC9eybPhX3/sY6m2Tfej1pRpq2uwH4lc522wTYmlOCPRUIu5qDgRAK0s
        rKhiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xu7rf9E3iDLa95bO4/uU5q8X8I+dY
        LZ5O2Mps0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i6XXLzJZ
        3G5cwWbRuvcIuwOfx5p5axg9Nq3qZPPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DImT5jOUnBFtKLny1umBsa1Al2M
        nBwSAiYSD+/8ZOti5OIQEljKKPFqxX7mLkYOoISMxPH1ZRA1whJ/rnVB1bxmlLgy8zYjSEJY
        wFdizffbzCC2iICmxPW/31lBipgFdjFLHHg/lRWiYzuTRNfDHiaQKjYBK4mJ7avAunkF7CRO
        7X8D1s0ioCrx730rO4gtKhAhcXjHLKgaQYmTM5+wgNicAoESs9feB4szC6hL/Jl3iRnCFpe4
        9WQ+E4QtL7H97RzmCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefn
        bmIExu62Yz8372C8tDH4EKMAB6MSD2+BtEmcEGtiWXFl7iFGCQ5mJRFeUVfDOCHelMTKqtSi
        /Pii0pzU4kOMpkDPTWSWEk3OB6aVvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakF
        qUUwfUwcnFINjFbhdtfuqThwzN0y411UkOa65f93+509GDF3r87npN7+vrq+WMG52tUahRLF
        TQePhSRH5fEd5NBNUsopfC1yR8CsSftQiYZ3m4aBYc1hMe62sx+u3qh5Gvbr7cyMg+J7v6g5
        qsmp/yqofTj59nfzl8kNJ6c28Cs3KOgJbpyf9levYQrrnHxRJZbijERDLeai4kQA8pIz5vMC
        AAA=
X-CMS-MailID: 20200131134734eucas1p24a9e1cd038f1923c9a2b2b539184bc05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200127215538eucas1p2b8d4886de6f59f6a62257d3d66307c73
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200127215538eucas1p2b8d4886de6f59f6a62257d3d66307c73
References: <20200127215453.15144-1-lukasz.luba@arm.com>
        <CGME20200127215538eucas1p2b8d4886de6f59f6a62257d3d66307c73@eucas1p2.samsung.com>
        <20200127215453.15144-4-lukasz.luba@arm.com>
        <d14546d5-0cd8-c441-c2be-cdeefc8ebb8d@samsung.com>
        <CAJKOXPcZCks1SxwBP-vhpsYzpsrV9MQo91QNU2obgAppxfTiyQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 1/31/20 2:31 PM, Krzysztof Kozlowski wrote:
> On Fri, 31 Jan 2020 at 14:30, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>>
>> Hi,
>>
>> On 1/27/20 10:54 PM, lukasz.luba@arm.com wrote:
>>> From: Lukasz Luba <lukasz.luba@arm.com>
>>>
>>> Enable the Energy Model (EM) brings possibility to use Energy Aware
>>> Scheduler (EAS). This compiles the EM but does not enable to run EAS in
>>> default. The EAS only works with SchedUtil - a CPUFreq governor which
>>> handles direct requests from the scheduler for the frequency change. Thus,
>>> to make EAS working in default, the SchedUtil governor should be
>>> configured as default CPUFreq governor. Although, the EAS might be enabled
>>> in runtime, when the EM is present for CPUs, the SchedUtil is compiled and
>>> then set as CPUFreq governor, i.e.:
>>>
>>> echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>>> echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
>>>
>>> To check if EAS is ready to work, the read output from the command below
>>> should show '1':
>>> cat /proc/sys/kernel/sched_energy_aware
>>>
>>> To disable EAS in runtime simply 'echo 0' to the file above.
>>>
>>> Some test results, which stress the scheduler on Odroid-XU3:
>>> hackbench -l 500 -s 4096
>>> With mainline code and with this patch set.
>>>
>>> The tests have been made with and without CONFIG_PROVE_LOCKING (PL)
>>> (which is set to =y in default exynos_defconfig)
>>>
>>>               |               this patch set                  | mainline
>>>               |-----------------------------------------------|---------------
>>>               | performance   | SchedUtil     | SchedUtil     | performance
>>>               | governor      | governor      | governor      | governor
>>>               |               | w/o EAS       | w/ EAS        |
>>> ----------------|---------------|---------------|---------------|---------------
>>> hackbench w/ PL | 12.7s               | 11.7s         | 12.0s         | 13.0s - 12.2s
>>> hackbench w/o PL| 9.2s                | 8.1s          | 8.2s          | 9.2s - 8.4s
>>
>> Would you happen to have measurements of how much power is
>> saved by running hackbench using "SchedUtil governor w/ EAS"
>> instead of "SchedUtil governor w/o EAS"?
> 
> That's a good point and quite important reason behind enabling (or not) EAS...

IIUC EAS is enabled by default if you use SchedUtil
governor and Energy Model is available on you platform.

[ SchedUtil governor is enabled in exynos_defconfig
  although not enabled by default currently. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Best regards,
> Krzysztof
