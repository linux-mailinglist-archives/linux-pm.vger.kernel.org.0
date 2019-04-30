Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF5100AA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfD3UP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 16:15:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33188 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfD3UP5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 16:15:57 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190430201555euoutp01c8914ccb708d287770568f10c2f92e10~aWcxM1G7j1249212492euoutp01U
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 20:15:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190430201555euoutp01c8914ccb708d287770568f10c2f92e10~aWcxM1G7j1249212492euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556655355;
        bh=mn7t1uuvg68BUUAH/Tn9zR4of3JANp39h4iNEwxbGP4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tUfR82Y2KEPUr6qeHvVxbG2AqVFG8l9nITOUBBNTn7k4imqJmggGK+AYgVtil1mVP
         ry/iYoEy7EYw+zP9sPefk3mVMaG/LjwfTvwYzWEQl/xRquO6xcaJYl7bQFiEUokob2
         jxXqnbRwdx6MXv5NYPjMxomqHgZgm/8PJKRpUjMY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190430201553eucas1p16c8ec34f4c03c140ce5d385e98fccde8~aWcv7s8ke3098530985eucas1p1G;
        Tue, 30 Apr 2019 20:15:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F7.F3.04377.9FCA8CC5; Tue, 30
        Apr 2019 21:15:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190430201552eucas1p20e6654bf0e5f922312977bd8180e9be0~aWcuRMGx11156111561eucas1p28;
        Tue, 30 Apr 2019 20:15:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430201551eusmtrp220f9624dc288508cce91c124c6d1dd4e~aWcuBL1QP0508705087eusmtrp2_;
        Tue, 30 Apr 2019 20:15:51 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-d8-5cc8acf9efce
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.B2.04140.7FCA8CC5; Tue, 30
        Apr 2019 21:15:51 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430201550eusmtip1d4a86f3d0c2d00bcfb858fe60607a6d4~aWcs_ylEU0208402084eusmtip1g;
        Tue, 30 Apr 2019 20:15:50 +0000 (GMT)
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <8f488d35-d576-a710-c24b-18514c6c0f34@partner.samsung.com>
Date:   Tue, 30 Apr 2019 22:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+bJtjO8xbpnCRHmcyCB=b8DMr73GWKEz+xMXVZag0FrQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3Zfdh1tPE7LU1nRKjIhtRfpCcUKQi5FkdKHSiFveTPJme2q
        ZfVhKVhaZqhYLc38kqKWabJ8Q2NZrqzcyF5QhpFmpa4SX0CKrOtd5Lf/Oed3+P8PHI7S/2AW
        c4nJqaIpWUgysBra+nS6e910jT02xGZdSuqu1zLk3cRnhpR1vGJI9dgAIoXPS1XkxSUjyR8Y
        oUh39301eZk5qiavm0tYMp7Xgcj17jYVudvhUpO+85UsmWltVJPHoxcY0t6zk/T91JEp+0e0
        zYefmiyg+ZtmJ803WVxqvr4qh+Xzsr6x/JWGKsQ/6DrLj9cv28sd1ITHi0mJ6aIpOCJOc+xG
        MUl55H/anuNGZtTil4u8OMCboCfLinKRhtPjSgS9nx+olGICgWu4hVaKcQSZ71z0v5WsyXuM
        MqhAUNd031O4EVRkO5FM+eCjYBmyqmTti1fAz+ziWYjCkwxk1xT9hTiOxUHQWHVSZrQ4Er5c
        qZzlabwaSm6OsrJegPdD/1PZQGa84dmNwdkUXjgKpsztallT2A96B8tUil4OD90llOwFuJSD
        tnK7Wom9A2rtTo/2geHOBo/2h5kmZRmwBOa8cqToczCQX+phwuBxp5ORM1N4LdQ2Byvt7fDV
        UcTKbcA6eO/2ViLooMB6jVLaWriYrVfoAGi47PAYLYSKmmL1VWSwzDnMMucYy5xjLP99byO6
        CvmJaZIxQZQ2JIungiTBKKUlJwQdOWGsR3//sOt350Qjav512IYwhwzztY5Ie6yeEdKlDKMN
        AUcZfLV855NYvTZeyDgjmk4cMqUliZINLeFog5/27LwPMXqcIKSKx0UxRTT9m6o4r8VmdMsS
        MhLRFZ1+VBU9mn/c5c4prB9aeOdtdcS+soL0SaFgviUmbPequJz96Bwuar23xFEe3q/bMhQP
        a55vDo1xeEcZ4sMHxoSuUiOrmgkLaf5kYtyZe968WKRzD9UsGtwY+nv3LscBm3lqemXA1qge
        aOAr66KcPdYPmu+htYFjOwy0dExYH0iZJOEPxxW6MoMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4Xd3va07EGDz5K2mxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFv/37GC3OPymndVi/xUvi9u/+Sy+nXjE6CDs8e3rJBaP2Q0XWTx2zrrL7rFp
        VSebR2/zOzaPvi2rGD02n672+LxJLoAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DY
        PNbKyFRJ384mJTUnsyy1SN8uQS9j5jSLggMyFSc63zI2MO4W72Lk5JAQMJFo/rqOtYuRi0NI
        YCmjxNeTJ9ggEmISk/ZtZ4ewhSX+XOtigyh6zShx8tViJpCEsECaxOWrz1hAbBEBRYnfbdPA
        JjEL/GSVOHOoiRGio4VZYteXDiCHg4NNQE9ix6pCkAZeATeJF30rwAaxCKhKzJn9BmyzqECE
        xJn3K1ggagQlTs58AmZzCgRKfGvYD3YRs4CZxLzND5khbHGJW0/mM0HY8hLb385hnsAoNAtJ
        +ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYArYduznlh2MXe+CDzEK
        cDAq8fBqeJ6IEWJNLCuuzD3EKMHBrCTC63H8aIwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km
        5wPTU15JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsa9BrWFh1uV
        uqy/KrBdnfq9WeXTrMyklcKzF4jvuXXmMiPH+nK7ZLMj+987NMux663v+VD371X0VM3goLiU
        6bn2rrc1bj3Wupcxe7n3Bnlf3bdnFk9Yl+fRFZPfz3/6xu9rWvHFQf/muJVlZc32rvn07OIO
        VcPCzebTWLhPMr+QFOU+Y8WvI6zEUpyRaKjFXFScCADu9m08FwMAAA==
X-CMS-MailID: 20190430201552eucas1p20e6654bf0e5f922312977bd8180e9be0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
        <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
        <20190425195750.GA26031@bogus>
        <e4613d6e-0893-8163-32ef-8137c40d2b24@partner.samsung.com>
        <CAL_Jsq+bJtjO8xbpnCRHmcyCB=b8DMr73GWKEz+xMXVZag0FrQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 4/29/19 6:43 PM, Rob Herring wrote:
> On Mon, Apr 29, 2019 at 7:14 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi Rob,
>>
>> On 4/25/19 9:57 PM, Rob Herring wrote:
>>> On Fri, Apr 19, 2019 at 04:19:24PM +0200, Lukasz Luba wrote:
>>>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>>>> Memory Controller device.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
>>>>    1 file changed, 73 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>> new file mode 100644
>>>> index 0000000..133b3cc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>> @@ -0,0 +1,73 @@
>>>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>>>> +
>>>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>>>> +memory chips are connected. The driver is to monitor the controller in runtime
>>>> +and switch frequency and voltage. To monitor the usage of the controller in
>>>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>>>> +is able to measure the current load of the memory.
>>>> +When 'userspace' governor is used for the driver, an application is able to
>>>> +switch the DMC and memory frequency.
>>>> +
>>>> +Required properties for DMC device for Exynos5422:
>>>> +- compatible: Should be "samsung,exynos5422-bus".
>>>> +- clock-names : the name of clock used by the bus, "bus".
>>>> +- clocks : phandles for clock specified in "clock-names" property.
>>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>>> +- vdd-supply : phandle for voltage regulator which is connected.
>>>> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
>>>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>>>> +- device-handle : phandle of the connected DRAM memory device. For more
>>>> +    information please refer to Documentation
>>>
>>> The memory node(s) should be a child of the memory controller IMO.
>> I have followed the TI code for LPDDR2. They use 'device-handle'
>> probably because the memory controller can be moved into the common
>> .dtsi and taken by reference in .dts in a proper board file.
> 
> You'd still have to have the ctrlr node in the board file to add the
> 'device-handle' property.
> 
>> The board .dts files might specify different DRAM chips and timings.
>> In Exynos case we will also have such situation: one memory controller
>> and a few different DRAM chips.
> 
> You mean as in the case where there are multiple options and one chip
> gets populated on the board? So 'device-handle' is selecting which
> chip to use.
Yes. The 'device-handle' will point to different memories depending on
the board/SoCs. There are boards with Exynos 5420, 5422, 5800 which are
'almost' the same, but with different memories glued on top (the PoP
LPDDR3).
> 
> You can actually do both here. Keep 'device-handle' to select which
> DRAM chip and have the chips as child nodes. But if you really don't
> want to have them as child nodes, that's fine.
For now, I would like to keep it like this (if Krzysztof also agrees
with the implementation).

Regards,
Lukasz
> 
> Rob
> 
> 
