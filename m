Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9491C4759
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfJBGBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 02:01:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44392 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfJBGBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 02:01:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191002060109euoutp0161c2a55a0584ee967873a99bd5c9047d~JvxtQrFrn1416514165euoutp01L
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 06:01:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191002060109euoutp0161c2a55a0584ee967873a99bd5c9047d~JvxtQrFrn1416514165euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569996069;
        bh=yuCGV1S0VKd0ozUAZTYAj1RajvjGsX0dFbmBxV1nsmE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vX+QAqJREI2wKkvCNcWtJyTqrz47z1+t0Eg7rwPVmIXi9iXuUlSp/tAWwLYv+8bL4
         6W8YkM1mj0pKGT1kC9ZKJcUN4fLk4Lgeqh+VDSAZhSS2RaQQHT1UdUHdeD98pjA1+2
         pCZTSZG1lJcL5B42fftzDAOmC1Fsb8ei2wp9abU4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191002060108eucas1p2c7469fb69a002592edafe342a25b0c6b~Jvxsuj-771635816358eucas1p2H;
        Wed,  2 Oct 2019 06:01:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F7.F1.04374.42D349D5; Wed,  2
        Oct 2019 07:01:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060108eucas1p27be49c6cd819bc9de2d59a0eb90ee605~JvxsQWqH20364903649eucas1p24;
        Wed,  2 Oct 2019 06:01:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191002060108eusmtrp2fad6b8ae641b232663d9bd2af670d292~JvxsPVBN73010930109eusmtrp27;
        Wed,  2 Oct 2019 06:01:08 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-70-5d943d2411d0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.B3.04166.32D349D5; Wed,  2
        Oct 2019 07:01:08 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060106eusmtip245037d0e21126944c7edac27833fa4ed~JvxrFiL5l2679726797eusmtip2T;
        Wed,  2 Oct 2019 06:01:06 +0000 (GMT)
Subject: Re: [PATCH v13 0/8] Exynos5 Dynamic Memory Controller driver
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
Message-ID: <7c8cd09c-aa6b-29e4-1208-2476027d9c85@partner.samsung.com>
Date:   Wed, 2 Oct 2019 08:01:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001192947.GA1815@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNYRzHPe+9cvJ2XM7Pfc5iriFmj8SYy97ZhIYZCy+9i+kcnLdQzA5J
        pByrkKOUmWmncpSmhOgyRaUO6RyXY1FuUUZIi+j0Zvrv8/s+3+f3+32fPRypPs0M47bpwySD
        XgzVMu7U9XsdD6d4z00Kmua8MhLnJFtpbP/2jsZpZQ9pnPmlEeGoi1YGJz5IJXDVcR02NX4k
        cU3NVRZXH/rE4i9xL2n8uDCFwW3xZQgn1xQROLvMyeJLdhuBbQ8W4+cHMxgcfbuMxaWfYmjc
        VZ9D4Tt1S/HzTk/8o+I1mg9C1vksJPz4nkAJnx3RrHDOaKOEG2YnK+RajjHCndQsVoiPamWE
        E3kWJFyr3Ce05Y5a4bHO3T9YCt22WzJMnbfJfevPqvfUzlr13nf12YQRRQ+IRW4c8DPBejOG
        iEXunJrPQHA3pQQpxTcEpXVvKKVoQ1D9uI2NRVzPlboWSdEvI2g/3EQqRQuCF/mttKvvQH4x
        RHd+YFw8iJ8A9t/tPTrJ36LAmDDU1YjhfaDAssslq/glcLvibo+d4r0hvvYVcvFgfi18bSil
        FY8X3D/bRLnYrftqotPIKi018KwpjVB4NOS3pPTsA7yDgyv2TkLJuQg6cjIphQdCc3keq/AI
        +HMjrdcjgzH+AlJ4PzSaUns9c6C03Ea7dia7s1gLpyryAmiuiEHKm3iCo8VLWcETEq6fIRVZ
        BUePqBX3eMiLq+0dNAQuZ51mTyKtuU8wc58w5j5hzP/npiPKgjRSuKwLkeQZemmPjyzq5HB9
        iM+WHbpc1P1bK7vKvxegol+bSxDPIW1/lWNVYpCaFnfLEboSBBypHaTy/5UQpFYFixGRkmHH
        RkN4qCSXoOEcpdWo9vVrWK/mQ8Qwabsk7ZQM/04Jzm2YEQU8fTKm2ozrIj6/MbVaq2ZP9rcE
        Np8zn/Ulxekr7b7BGQF+85Z5iqcig3QB414QS+M8Fm0vlxZMGj9KOH5+wwmvt4H4SWCKn3Ps
        GqfNUDyLSn76qMO4vN4/0ux3LSmsvdAjrTi9kjOtLvLWPNNkX1341U9fkD6r+MBP0zjHhfzM
        VVpK3ipOn0gaZPEvwTLsJKkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsVy+t/xe7oqtlNiDR5kW2ycsZ7V4vqX56wW
        84+cY7VY/fExo0Xz4vVsFpNPzWWyONOda9H/+DWzxfnzG9gtzja9Ybf42HOP1eLyrjlsFp97
        jzBazDi/j8li7ZG77BZLr19ksrh4ytXiduMKNovWvUfYLQ6/aWe1+HdtI4vF/iteFrd/81l8
        O/GI0UHCY828NYwe375OYvF4f6OV3WN2w0UWj52z7rJ7bFrVyeaxf+4ado/e5ndsHn1bVjF6
        bD5d7fF5k1wAd5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexo8zL1gKLghVPL+2lqmBsZW/i5GDQ0LAROLK29QuRi4OIYGljBK/HnawdDFyAsXF
        JCbt284OYQtL/LnWxQZR9JpRYt2k3YwgCWEBV4nW3y/ZQGwRAU2J63+/s4IUMQvsYZF4tfQK
        E0THdkaJWffvMYGsYxPQk9ixqhCkgVfATWLviQNgzSwCKhK9Fx6CDRUViJA4vGMWI0SNoMTJ
        mU/ALuIEap18twHsImYBM4l5mx8yQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZhaRl
        ASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMB0su3Yz807GC9tDD7EKMDBqMTD2xA0OVaI
        NbGsuDL3EKMEB7OSCK/Nn0mxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTHV5JfGGpobm
        FpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYOS7czPr6LCtJuuDYqphOpgbH
        Gue/C0VK1jzz4fohes1QI2t/2SvXOUxKkrlTliUvbeLnmq+YcYTv/+8uhtJ0fkW9m9XnFr+Z
        eKmtTJn5hGJOdJelqdlGpksti8xu8YY9/n3lhLEOV/WO38cl1xzZf/Ok0ruMrfOtdBSETCRK
        FBbve3jNgOukEktxRqKhFnNRcSIAAooCoz0DAAA=
X-CMS-MailID: 20191002060108eucas1p27be49c6cd819bc9de2d59a0eb90ee605
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
References: <CGME20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8@eucas1p2.samsung.com>
        <20190821104303.32079-1-l.luba@partner.samsung.com>
        <20191001192947.GA1815@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 10/1/19 9:29 PM, Krzysztof Kozlowski wrote:
> On Wed, Aug 21, 2019 at 12:42:55PM +0200, Lukasz Luba wrote:
>> Hi all,
>>
>> This is v13 which makes cosmetic changes. It is based on current mainline
>> (v5.3-rc5) with with devfreq/for-next where there is a PPMU patch [1].
>>
>> The patch set adds support of Dynamic Memory Controller for Exynos5422 SoC.
>> The driver supports Dynamic Voltage and Frequency Scaling
>> for the DMC and DRAM. It also provides needed timings for different
>> speed operations of the DRAM memory.
>> There is also new generic code in of_memory and headers which allows to parse
>> LPDDR3 memories defined in device-tree.
>>
>> Here are the last changes suggested by Krzysztof during his review.
>> For the previous changes in older revisions please refer to [2], there is
>> more detailed change log.
>>
>> changes:
>> v13:
>> - skipped patch with chipID changes in DT, since it is not used anymore,
>> - removed license comment in of_memory.c since SPDX has been merged,
>> - aligned comment to the current fields in the structure,
>> - changed printed warning when timings are not found,
>>
>> Regards,
>> Lukasz Luba
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=b617376df8f01c975dee66802f4da16291f92079
>> [2] https://protect2.fireeye.com/url?k=76a66a31f783ea89.76a7e17e-142fcaf2360aff73&u=https://lkml.org/lkml/2019/7/22/251
>>
>>
>> Lukasz Luba (8):
>>    dt-bindings: ddr: rename lpddr2 directory
>>    dt-bindings: ddr: add LPDDR3 memories
>>    drivers: memory: extend of_memory by LPDDR3 support
>>    dt-bindings: memory-controllers: add Exynos5422 DMC device description
>>    drivers: memory: add DMC driver for Exynos5422
>>    ARM: dts: exynos: add syscon to clock compatible
>>    ARM: dts: exynos: add DMC device for exynos5422
>>    ARM: exynos_defconfig: enable DMC driver
>>
> 
> Just to let you know:
> 
> I applied the set some days ago but this did not make to merge window.
> Now, I put it on for-next branch so will appear on linux-next soon. I
> also applied the fixes sent later.

Thank you Krzysztof!

> 
> I'll take also the latest work with interrupt mode for DMC (after minor
> fix in bindings).
> 

I will send the latest IRQ mode version with this binding IRQ names
description in a minute.

Regards,
Lukasz
