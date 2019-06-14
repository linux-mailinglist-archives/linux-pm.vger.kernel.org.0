Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF645E8B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfFNNk7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 09:40:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52749 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfFNNk7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 09:40:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614134057euoutp010063290441d07a9b97ff5338fba98648~oFFxhWBtx3227632276euoutp01I
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 13:40:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614134057euoutp010063290441d07a9b97ff5338fba98648~oFFxhWBtx3227632276euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560519657;
        bh=+ZzNZVpTuLGrOOQoRV7Ief94EdVHmVGQucnOC6c/nP0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Trfs0DuMSl21QJlyU9ckjlqR8CFqBM3V6byuRgPvNfVj6laK49jhlP2qQXOb8FFBR
         AIIVegDkZk981BicJaayTP4dkHG3bU9MVOlfpMOL40W6Svw94iOx9indofxoVKWBS0
         6S+aeeLEYn1cEMqqb1F6MBM4SmAfCy+tE+MBEr00=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614134056eucas1p1f027afb1e1ee5936d02bd3e470ef5b26~oFFwgE7yf2597425974eucas1p1h;
        Fri, 14 Jun 2019 13:40:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9D.22.04298.8E3A30D5; Fri, 14
        Jun 2019 14:40:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190614134055eucas1p16bbd29a62be6825394efb3b635182019~oFFvlXRvG3190831908eucas1p1E;
        Fri, 14 Jun 2019 13:40:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190614134055eusmtrp16d5f32edc3d1360d84dcda5e43addbdb~oFFvVgrBl1787017870eusmtrp1A;
        Fri, 14 Jun 2019 13:40:55 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-7c-5d03a3e877dd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.6C.04146.7E3A30D5; Fri, 14
        Jun 2019 14:40:55 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614134054eusmtip2e7741234ae8ace93d169fd44129e8334~oFFugLp_T2169921699eusmtip2J;
        Fri, 14 Jun 2019 13:40:54 +0000 (GMT)
Subject: Re: [PATCH v10 08/13] drivers: memory: add DMC driver for
 Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <6f86228d-8409-a835-20ba-ad20464379dd@partner.samsung.com>
Date:   Fri, 14 Jun 2019 15:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPehO2pKrTKMO4YRwDMaPPngmeWG9WF=kMuBG+=P1ix3NA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNcRjH/c577XDq54SexbSdaWgTbTa/Yc197zLX2dxmHLyrplOcV5H6
        I0zRFRWnQ3KWScfl5EjJDm1dnJw4CYtp0o2MQrot1PT2Zvrv83yf7/N7nu/24yltEuvLh0ce
        Fo2R+ggdq6ZLngzWzfucT+1acN3sR+6abAx509vBkLwqN0NudrchcjLfxpJMV66KPEsxkIy2
        rxSpqyviyPMTnRzpTm1iyKuHl1nSk1aFiKnusYrcrnrPkXrXatJ4/AZLKjuTGDLccJcm5a9D
        SONvT9Jf04qWTRP6+87Twve3pzjhUkI9LZSZ33OC3XqGFcpzb3FC2slvrJBebEXCvdo4occ+
        c6N6h3rpfjEiPEY0zg/eow7raDx0sEZ39EdrH52A3L7JyIMHvBDMP1rYZKTmtfgGgsftnbRS
        9CL42GxjlKIHQXdOP/NvpNJl4mTW4gIEz5IFxdSFYLg6G8kNb7wBHAXVlMxT8Fx4MzQw+hKF
        sxlwDLhHFvI8iwPhgfWQ7NHgNdCU90slM439YcDyZ3R2Kt4GvWV2pHgmw9OcdlpmD7wJ7KaG
        UT+FfeBde94Y+0Fp12VK3gXYwUNWZxmrXL0KGlJaaYW94YuzmFN4BtRmpo7pEiSkWZDC8dCW
        kTvmWQKVznpGvpkaCWN7OF+Rl0O6pUUly4A94W3XZOUETzhfcpFSZA2cTtQq7jlQnPpCpfA0
        KLh1gTuLdOZxwczjwpjHhTH/33sV0VbkI0ZLhlBRCooUjwRKeoMUHRkauC/KYEcj37N22Pnz
        Aep7ubcCYR7pJmlM6dQuLaOPkWINFQh4SjdFc2XJiKTZr489JhqjdhujI0SpAk3naZ2PJm5C
        804tDtUfFg+I4kHR+K+r4j18E9C5wdzls03rbZZZMdvTretPV3tUxs8pnvXFObFQa11xM37Q
        3yev41vpuy2FW1/G1i/c7DV1aVG+xVnkNbQYz+PXTUwNyFkbUvuqt+lSzrWWz8as4HstFr84
        h9FdMmHx5sTgqItsRvanO1eaXfGabY8WhYVmxiTpd1gLs9j7DtfK8g9uHS2F6YMCKKOk/ws+
        OqLwmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xe7rPFzPHGvRdkrPYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNu8bHnHqvF5V1z2Cw+
        9x5htJhxfh+Txdojd9ktLp5ytbjduILN4vCbdlaLf9c2sljsv+Jlcfs3n8W3E48YHcQ8vn2d
        xOLx/kYru8fshossHjtn3WX32LSqk81j/9w17B69ze/YPPq2rGL02Hy62uPzJrkArig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jOe3CwtOKFV8
        ePSVpYHxnFQXIyeHhICJxOFTM9hBbCGBpYwSGz6EQ8TFJCbt284OYQtL/LnWxdbFyAVU85pR
        ou/WCyCHg0NYwFdi93FxkBoRAU2J63+/s4LUMAtMZZWY8Pw01NAJTBLHdsWB1LMJ6EnsWFUI
        EuYVcJO4N/8XE4jNIqAq8X3hH2YQW1QgQmL2rgYWiBpBiZMzn4DZnAKBEptmXAOrZxYwk5i3
        +SEzhC0ucevJfKi4vMT2t3OYJzAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtc
        mpeul5yfu4kRmCy2Hfu5eQfjpY3BhxgFOBiVeHhn9DHHCrEmlhVX5h5ilOBgVhLhnWcNFOJN
        SaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YCLLK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5Y
        kpqdmlqQWgTTx8TBKdXA2OicoMT9dhcTjwyvqe+aNh3LRp11fXejNiyMnL79vOPjy1zX+NVL
        y0OzLsbIZGex1mi0eFx03hiX1rx9ZSnTq1Jj7nynRz0x+1/zPtf2r4tWb7V5d3Sj+yHbaptC
        JS5F1kVTDqRfnLn+Zjj7nl3GS+JL7Y61nNn3WESmcMuqKebrYmZ5hd5TYinOSDTUYi4qTgQA
        gD6NvywDAAA=
X-CMS-MailID: 20190614134055eucas1p16bbd29a62be6825394efb3b635182019
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9
References: <CGME20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9@eucas1p1.samsung.com>
        <20190614095309.24100-1-l.luba@partner.samsung.com>
        <20190614095309.24100-9-l.luba@partner.samsung.com>
        <CAJKOXPehO2pKrTKMO4YRwDMaPPngmeWG9WF=kMuBG+=P1ix3NA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 6/14/19 2:58 PM, Krzysztof Kozlowski wrote:
> On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> This patch adds driver for Exynos5422 Dynamic Memory Controller.
>> The driver provides support for dynamic frequency and voltage scaling for
>> DMC and DRAM. It supports changing timings of DRAM running with different
>> frequency. There is also an algorithm to calculate timigns based on
>> memory description provided in DT.
>> The patch also contains needed MAINTAINERS file update.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                             |    8 +
>>   drivers/memory/samsung/Kconfig          |   17 +
>>   drivers/memory/samsung/Makefile         |    1 +
>>   drivers/memory/samsung/exynos5422-dmc.c | 1262 +++++++++++++++++++++++
>>   4 files changed, 1288 insertions(+)
>>   create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 57f496cff999..6ffccfd95351 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3470,6 +3470,14 @@ S:       Maintained
>>   F:     drivers/devfreq/exynos-bus.c
>>   F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>
>> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
> 
> Eh, more comments from my side.
> "For the hard of thinking, this list is meant to remain in alphabetical order."
OK
> 
>> +M:     Lukasz Luba <l.luba@partner.samsung.com>
>> +L:     linux-pm@vger.kernel.org
>> +L:     linux-samsung-soc@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/memory/samsung/exynos5422-dmc.c
>> +F:     Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> +
>>   BUSLOGIC SCSI DRIVER
>>   M:     Khalid Aziz <khalid@gonehiking.org>
>>   L:     linux-scsi@vger.kernel.org
>> diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
>> index 79ce7ea58903..c93baa029654 100644
>> --- a/drivers/memory/samsung/Kconfig
>> +++ b/drivers/memory/samsung/Kconfig
>> @@ -5,6 +5,23 @@ config SAMSUNG_MC
>>            Support for the Memory Controller (MC) devices found on
>>            Samsung Exynos SoCs.
>>
>> +config ARM_EXYNOS5422_DMC
> 
> Why you added prefix of ARM to CONFIG think none of other Exynos
> Kconfig options follow such convention (except devfreq).
In the previous versions the driver was in drivers/devfreq/,
that's why they have this prefix.
> 
>> +       tristate "ARM EXYNOS5422 Dynamic Memory Controller driver"
>> +       depends on ARCH_EXYNOS
>> +       select DDR
> 
> In general select should be used only for non-visible symbols and DDR
> is visible. Use depends.
OK
> 
>> +       select PM_DEVFREQ
> 
> This definitely cannot be select. You do not select entire subsystem
> because some similar driver was chosen.
So I will use depends int this case
> 
>> +       select DEVFREQ_GOV_SIMPLE_ONDEMAND
>> +       select DEVFREQ_GOV_USERSPACE
> 
> I think only simple_ondemand is needed. Is userspace governor
> necessary for working? Or actually maybe both could be skipped?
> 
Actually we can skip both governors from here.

>> +       select PM_DEVFREQ_EVENT
> 
> Again, depends.
OK

There are these 4 options which the driver depends on:
         depends on ARCH_EXYNOS
         depends on DDR
         depends on PM_DEVFREQ
         depends on PM_DEVFREQ_EVENT

Should I merged them into one, two lines? like below:
a)
depends on (ARCH_EXYNOS && DDR && PM_DEVFREQ && PM_DEVFREQ_EVENT)
b) grouped into two sets
depends on (ARCH_EXYNOS && DDR)
depends on (PM_DEVFREQ && PM_DEVFREQ_EVENT)
c) grouped by pm_devfreq only
depends on ARCH_EXYNOS
depends on DDR
depends on (PM_DEVFREQ && PM_DEVFREQ_EVENT)

> 
>> +       select PM_OPP
This option can be used here IIUC
>> +       help
>> +         This adds driver for Exynos5422 DMC (Dynamic Memory Controller).
>> +         The driver provides support for Dynamic Voltage and Frequency Scaling in
>> +         DMC and DRAM. It also supports changing timings of DRAM running with
>> +         different frequency. The timings are calculated based on DT memory
>> +         information.
>> +
>> +
>>   if SAMSUNG_MC
> 
> Why this is outside of SAMSUNG_MC?
Good question, I will move it below this 'if' statement.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
