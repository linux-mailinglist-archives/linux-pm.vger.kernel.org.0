Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A960AB456
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbfIFIrq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 04:47:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48822 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391810AbfIFIrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 04:47:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190906084743euoutp01eb7589fa5e6c413fb8f50512fbb795f8~BzRt7mjJg0843708437euoutp01S
        for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2019 08:47:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190906084743euoutp01eb7589fa5e6c413fb8f50512fbb795f8~BzRt7mjJg0843708437euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567759663;
        bh=mdHSl3DWTISRFY6N/nl+irQUa6Nraxuw1qiJgfh/WyY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U9iBKLtg5iI9uhY2NfNbQpOUKo/jW9RnU8xqo8zRP6hgmAeEmoO4oF4+vId5WMJar
         nwyoip7uy/LDAMpiH6rojO+3yk5SMpnNKU5km0pVnSDIqeEC7TMETuuU3SqKGCW82e
         CD6qfo4MOip2m6rkJdilHts/kQQy0ZhFQaVBIkwI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190906084742eucas1p29b75adc5b5a5eb1fcc8152b8e6213bd8~BzRs4MIjo2754527545eucas1p2y;
        Fri,  6 Sep 2019 08:47:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8E.BC.04469.D2D127D5; Fri,  6
        Sep 2019 09:47:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190906084741eucas1p2171298d988768ed567f177b1bd7c209a~BzRr9nq8y3243632436eucas1p2Y;
        Fri,  6 Sep 2019 08:47:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190906084740eusmtrp27abec0c3aaf8daa396364297b68521ed~BzRrvQKt91506415064eusmtrp2J;
        Fri,  6 Sep 2019 08:47:40 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-68-5d721d2dcd3f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.18.04117.C2D127D5; Fri,  6
        Sep 2019 09:47:40 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190906084739eusmtip1b1d48dedbf3fda46f3e4d9a9dbf05c8d~BzRqpuuhH1527015270eusmtip1z;
        Fri,  6 Sep 2019 08:47:39 +0000 (GMT)
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
Message-ID: <2a6cab9f-1f14-64da-ad5a-c5bc66aa77eb@partner.samsung.com>
Date:   Fri, 6 Sep 2019 10:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904184037.GD12918@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7djP87q6skWxBsdvG1hsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3+Nhzj9Xi8q45bBaf
        e48wWsw4v4/JYu2Ru+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLxf4rXha3f/NZ
        fDvxiNFBwmPNvDWMHt++TmLxeH+jld1jdsNFFo+ds+6ye2xa1cnmsX/uGnaP3uZ3bB59W1Yx
        emw+Xe3xeZNcAHcUl01Kak5mWWqRvl0CV0bTgatsBXMEK96ubGJsYJzI18XIySEhYCLRv+Q/
        cxcjF4eQwApGiafNM5lAEkICXxgl3q/1g0h8ZpS4fms1E0zHlr1HWSASyxklLj94wwjhvGWU
        mN/awAxSJSzgKtH6+yUbiC0ioClx/e93VhCbWWAPi0TDJMkuRg4ONgE9iR2rCkHCvAJuEk9e
        3AFbwCKgInG9pY8dxBYViJD49OAwK0SNoMTJmU9YQGxOAX2JA109bBAjxSVuPZnPBGHLS2x/
        OwfsHQmBGxwSV+9/YYe42kViW/9sKFtY4tXxLVC2jMT/nfOhPiuWaOhdyAhh10g87p8LVWMt
        cfj4RVaQm5mBflm/Sx8i7Cjx6kQ7I0hYQoBP4sZbQYgT+CQmbZvODBHmlehoE4Ko1pDY0nMB
        apGYxPI109gnMCrNQvLYLCTPzELyzCyEvQsYWVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefn
        bmIEptbT/45/2sH49VLSIUYBDkYlHl6BLwWxQqyJZcWVuYcYJTiYlUR4128ECvGmJFZWpRbl
        xxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamCUUn4ZLNR5LCTg+RG2V53u
        iqq3GVebK8W3bNvKJLpfyJGrMStodvDW5Xnn6u6+v3vu7/rnyTNMzS4pn9p416Vvw9mvSiGs
        C9KimOe6dksqTZlZFlU8aY0sb+xMgY3bI16+yMsoYS6L1wu4qFTvUz/p5MEsI1s2nZVfRX6E
        tP/s+rDw4ua4TZ5KLMUZiYZazEXFiQCPEL0+qQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/09F2e/Tg9fbWQ3s4V+uav0jfKwyX6MzWYjKXXqt2q6u9zv
        DvGHlIbzzD/8VB7bOLW6K3qQ9HAppVqka5INIZSHyoWIOzdb/732+bxfn88+24fB5UWkP5Om
        NQh6rTpdQXkSbZPN/UGLZuvjF7f8DEKW8yUkso+9I9ElWweJbn19DVDOtRIKnWvNx9CjYxp0
        6vVHHHV2ltKoPXuIRl+PvyDRk+o8Co2esAF0vrMWQ8W2fhoV2rsw1NUajfoO3qBQ7j0bjRqH
        DpNossdCoPvd61DfxAzkaHkFVkK+qKAI8I5vZwn+c28uzV/M6iL4Kqmf5q3moxR/P7+I5k/k
        fKL4k+VmwJe17edHrXM2TovlIvU6o0GYm6oTDVGKbUqk4pQRiFOFRnDKkPD4paowRfDyyGQh
        PW23oA9ensilZtc9pTLyvPYO38wGWeDMDBPwYCAbCsvvNREm4MnI2UIAJ8tqcHfDF56traDd
        PBP+6jFR7tBHADssb4GrMZONhrkT7ykXe7OB0P57nHSFcLaGgB8KuzG3UQlgRWGzcyzDUCwH
        K827XIKMXQMHBp9jLibYedB+6OS/bT5sDGyslIA74wUfXhggXOzBBsM60/F/y3B2CSwoe4m7
        2Q8+G7iEuTkAVgzn4aeBXJqiS1MUaYoiTVEuA8IMvAWjqEnRiCpOVGtEozaFS9JprMD5KXce
        /CivBKZPmxoAywDFdBk7lhEvJ9W7xUxNA4AMrvCWlVicJVmyOnOfoNcl6I3pgtgAwpzHncH9
        fZJ0zr/TGhKUYcpwFKEMDwkPWYIUfrIjbH2cnE1RG4SdgpAh6P97GOPhnwUu7lnnOKJdUXXK
        YcwMnD13R/Vgx/CVxLu9v+3PJ1cNH7OtHhmol11X9VEw2iZhV635qd9jPWd5PY7/Ih81bN3g
        G3hAwje3/3iDjzSVsrWDZNS+25hfyEJ+o+WQYtx6O644smrZlYBn3fPVQQ7/aVxFbEdLjjlz
        yxd6/do/26WYAAUhpqqVC3C9qP4LmC96xT8DAAA=
X-CMS-MailID: 20190906084741eucas1p2171298d988768ed567f177b1bd7c209a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
References: <CGME20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8@eucas1p2.samsung.com>
        <20190821104303.32079-1-l.luba@partner.samsung.com>
        <20190904184037.GD12918@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/4/19 8:40 PM, Krzysztof Kozlowski wrote:
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
>> [2] https://lkml.org/lkml/2019/7/22/251
>>
> 
> Thanks, applied entire set (except last defconfig patch) to two topic
> branches, either for v5.4 or for v5.5 (it is quite late). I'll take the
> last defconfig separately.
> 
> Automated tools found few issues to fix, please send incremental
> patches.
OK, there will be around 3 patches with fixes.
> 
> In general, for new drivers always run automated checks - Smatch and
> Sparse. Coccinelle is also recommended. Checkpatch pointed missing
> compatible documentation - need to be fixed (see
> https://elixir.bootlin.com/linux/v5.3-rc7/source/Documentation/devicetree/bindings/eeprom/at25.txt
> as an example).
As I have responded in my previous email, I ignored it since Elpida
lpddr2 does not have bindings documentation. I will create the needed
documentation file in the follow up patch.

Regards,
Lukasz

