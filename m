Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEB4AB436
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 10:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390863AbfIFIo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 04:44:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47506 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfIFIo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 04:44:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190906084425euoutp01f4241d86575aedf0c99c7ce7d870618b~BzO2Oa03T0537005370euoutp01g
        for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2019 08:44:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190906084425euoutp01f4241d86575aedf0c99c7ce7d870618b~BzO2Oa03T0537005370euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567759466;
        bh=diyIBNi3GjnlSBl8is9X8PYZkLmZEQ2+ugSACC7EIo8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KnXEBmXQxWezsTiOiFxGkUmdhO5MmPS/d41+d4yRpPAttMkcTv4+GvEeekv2ue3x3
         rgqH4hAGEuPW9BMR/N03yXO3Xs+2Qkqp+YM08zCTZXQvEcr5/M0XEAzyAnLRTwsxlF
         23x5w3d6bazA7Y0B3mfXKBpi4A6X+isUxihuVpEY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190906084424eucas1p2d965087b7e1367ca3894862d4781c5a4~BzO1LCIDM1620816208eucas1p2L;
        Fri,  6 Sep 2019 08:44:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 94.08.04309.86C127D5; Fri,  6
        Sep 2019 09:44:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190906084423eucas1p254b1daccc612896c8adddb1b5ff1f99a~BzO0SpJYq3267932679eucas1p2v;
        Fri,  6 Sep 2019 08:44:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190906084423eusmtrp1f5c1f5c81e3eb8e4f23459392ec4e0bb~BzO0Dsu9a2263822638eusmtrp1d;
        Fri,  6 Sep 2019 08:44:23 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-05-5d721c68ce1b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.A7.04117.76C127D5; Fri,  6
        Sep 2019 09:44:23 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190906084422eusmtip260b14806b754e437a8cb61dd2f1d0859~BzOzASlu30851408514eusmtip24;
        Fri,  6 Sep 2019 08:44:22 +0000 (GMT)
Subject: Re: [PATCH v13 5/8] drivers: memory: add DMC driver for Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <72d1096b-b81e-ee21-d4e1-8b40a69ca2fe@partner.samsung.com>
Date:   Fri, 6 Sep 2019 10:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904183510.GC12918@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRj27bkWu3PaohdNzOaHyyhMzGfQMONy8INhBkMuizOFtsse5Tpm
        Y4SUUmy13RgatS0pSXKvHaGyRSNULJtp0BbdMCnaPRn9e97nvTzP883HEspkehy7K3SvoA1V
        h6hoV7Lk8S/L9GAv7eYZ+kwVLkwtoHBDdyuFs83PKZz/3YbwsUsFNE5+linD1ac1OMH2lcAW
        y3UG1xxtY/D3uHcUflmWQeOueDPCqZb7MnzV3MzgnIY6Ga57tgQ3RufS+Pg9M4Mr2k5QeOBV
        IYkf1K/AjX0K3PvkI1oIvCnLhPjeniSS73h9nOHTdXUkf9vQzPBFxlM0/yDTxPDxx9pp/kyx
        EfE3qg7xXUXeq0dudJ2/UwjZFSVo/QK2uQYnxrDhFYr9uXeaSB2yjIxFLAucP/TlaWKRK6vk
        chE0nOyXSUU3gs/Zbwmp6EJQUn+WjEUuzo3bl9ooqXEFga63iXE0lJwdgb3D24HduZXwqsZM
        ObAHNwUa+n84McHdJUGXNNYhTXO+UGqMcNBybimkdMQ675PcJEhoueE8OZrbAJ3WCkqacYOn
        aS2kY9WF84Ob1ydLFz3hbUu2TMIT4JY9w+kZuHoWUmpracnzYsjq6R/y7w5fKosZCXtBVXLc
        EC+CLv4ikvBhsCVkDs3Mg4rKOsqhSwxGKSjzk+hFkKbLo6RHVMBru5tkQQFJJSmERMvhZIxS
        mp4MxXG1MgmPgSsmPZOIVIZhuQzDwhiGhTH8172ASCPyFCJFTZAgzgoV9vmKao0YGRrkuyNM
        U4QGv2rVQGV3KSr7vb0ccSxSjZJz3eGblZQ6SjygKUfAEioPeUHhICXfqT5wUNCGbdVGhghi
        ORrPkipP+aER1k1KLki9V9gjCOGC9l9XxrqM06GJc7zexKQvcJ++KmvdNbcT7Wu8fdb620oz
        yotiFEd+3j+V8+uyNcL6ZUtARLBew+bPvvMxTwyLOL+wU+81o2+gw/PbRWNN4rqo5U+bppl9
        PlxuXbY7Nbon94OHh2lfNRH16JN1/ZZzL94HTjuYY/Mn7IGt1efmvms2t1dP1P+Zt/8hyFWk
        GKyeOZXQiuq/lNxoj6YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXcuO5azt2n5IqG2+mC3Y2dz+tpF/FIcqg9BBFJeWnrQyLl1
        zpTULpbYanaxgi4zK4phLMVrtm6aOrQ0G2ZoeYNSitIU04yoRpsj8Nvved7/73l44WEIpZ0K
        YQ5kmQQxS5epoheQne724XXpy8Sk9We+q3DNtSoK9818pvAt52sK358aAbjwbhWNL3eUyfCr
        Yj2+MDJGYJerWo67To7L8dTZYQr3PL5B4+lzToCvuRpluNI5JMe2vm4Z7u7YggdO3KNx0TOn
        HLeOmyns7q0hcdPbbXjgdwCeffERxCO+4mYF4Gd/XCL5yXdFcr60oJvkH1mH5Hyt/QzNN5VV
        yPlzhRM0f77eDvi6znx+ujZ058I97CbRkG0SwjMMkmmzai+H1SwXi1l1VCzLaWKSNqi1qsi4
        TWlC5oEcQYyM28dmlJxijK0Bh+89GSQLgGuhBfgxCEahR3fHKQtYwCihDaDq+jHge1iKLjU+
        lPs4EP3ptdC+0BhAPbbLc6FAuB31djkpLwfBVajv78+5SQR8SqKvtrcynzEBUKGt2VMwDA1Z
        5LAf8goKuBVdnbSQXibhSnRhtG5u2xKYgFodVuDLLEYvr4+SXtUPRqIH1RHeNgGj0c26D4SP
        g1H/6C2Zj8PQw283iBKgtM6zrfMU6zzFOk+5DUg7CBKyJX26XlKzkk4vZWels6kGfS3w3ElD
        2696B7BM7GoBkAEqfwWcMSYpKV2OlKtvAYghVEGKqhpPS5Gmy80TREOKmJ0pSC1A6/nbRSJk
        SarBc3VZphROy8XgWC5GE6OJxqpgxWnYnKiE6TqTcFAQjIL435MxfiEFgF0b5kBlAwlKtf/G
        k/Elw5+XM/1pTPl+IxfcYXSU7r7SZS52HBHj10B3w/a8prarn7T9qe9+RfQ8G9gxM1sfV2tT
        dhzKL5hpHj7WX6wJzU+MgIe525O0eTrzjrtyBSr98txOJk9RoQ0rj75Jvlh+nFo0+L5oX+cy
        rV97T745XEVKGTpuNSFKun9VffNMPQMAAA==
X-CMS-MailID: 20190906084423eucas1p254b1daccc612896c8adddb1b5ff1f99a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104323eucas1p1ab979133de45373866e9db1a5f63fb76
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104323eucas1p1ab979133de45373866e9db1a5f63fb76
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104323eucas1p1ab979133de45373866e9db1a5f63fb76@eucas1p1.samsung.com>
        <20190821104303.32079-6-l.luba@partner.samsung.com>
        <20190904183510.GC12918@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/4/19 8:35 PM, Krzysztof Kozlowski wrote:
> On Wed, Aug 21, 2019 at 12:43:00PM +0200, Lukasz Luba wrote:
>> This patch adds driver for Exynos5422 Dynamic Memory Controller.
>> The driver provides support for dynamic frequency and voltage scaling
>> for DMC and DRAM. It supports changing timings of DRAM running with
>> different frequency. There is also an algorithm to calculate timigns
>> based on memory description provided in DT.
>> The patch also contains needed MAINTAINERS file update.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                             |    8 +
>>   drivers/memory/samsung/Kconfig          |   13 +
>>   drivers/memory/samsung/Makefile         |    1 +
>>   drivers/memory/samsung/exynos5422-dmc.c | 1257 +++++++++++++++++++++++
>>   4 files changed, 1279 insertions(+)
>>   create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
> 
> Thanks, applied... or almost. Let's fix it incrementally.
> 
> You have two smatch warnings:
>    CHECK   ../drivers/memory/samsung/exynos5422-dmc.c
> drivers/memory/samsung/exynos5422-dmc.c:272 exynos5_init_freq_table() warn: passing devm_ allocated variable to kfree. 'dmc->opp'
>    CHECK   ../drivers/memory/jedec_ddr_data.c
> drivers/memory/samsung/exynos5422-dmc.c:565 exynos5_dmc_get_volt_freq() warn: passing zero to 'PTR_ERR'
> 
> The second looks like false positive, but first seems to be real.
Right, I will fix it.
> 
> You have also sparse warning to fix:
> ../drivers/memory/samsung/exynos5422-dmc.c:736:1: warning: symbol 'exynos5_dmc_align_init_freq' was not declared. Should it be static?
Yes, it should be static but due to the artificial line break I have
missed it.

It will be sent in the follow up patch.

Thank you!

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
> 
