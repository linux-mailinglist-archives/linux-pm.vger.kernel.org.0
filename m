Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D82B1796
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 09:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKMIxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 03:53:51 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:54149 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKMIxv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 03:53:51 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201113085347epoutp04b524a9d63b4afd1c4d990d9bb0fbd862~HBU6YZL3Q2862328623epoutp04S
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 08:53:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201113085347epoutp04b524a9d63b4afd1c4d990d9bb0fbd862~HBU6YZL3Q2862328623epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605257627;
        bh=CmhQQ+b8Nd14NE83uFOol/Pb/bgGtMAeG2yEorHiLng=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RaaGs8W4NGnLjqEhrgATAWHDMA/uYX9JkZ4SJxJLtMtSS6wv3xiVd4t9e84lWq61e
         DjcDn2QCa5t0L12x3FqK+SPFt7BDrAKT+dre3CvSVZyZi5peko01DQde2s/gMbuzIL
         OH33m4itVPEV1CUQmmV6A33lJW6KD0cEKJlnLldY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201113085346epcas1p4d8103c2ea5ecc14e318301bdcb107c6c~HBU5xVZM92081020810epcas1p45;
        Fri, 13 Nov 2020 08:53:46 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CXXLw3dnXzMqYkX; Fri, 13 Nov
        2020 08:53:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.21.09577.8994EAF5; Fri, 13 Nov 2020 17:53:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201113085343epcas1p198641b74a3aff97168379b595e37b7fa~HBU3OC3Bm2769827698epcas1p1A;
        Fri, 13 Nov 2020 08:53:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201113085343epsmtrp24919d78d46d76d4d4ac3f71d7533107d~HBU3NOwmf2268222682epsmtrp28;
        Fri, 13 Nov 2020 08:53:43 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-e5-5fae4998deb6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.D1.08745.7994EAF5; Fri, 13 Nov 2020 17:53:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201113085343epsmtip2326aba259bb05a3468ef94574a790136~HBU26NvLh2166221662epsmtip2W;
        Fri, 13 Nov 2020 08:53:43 +0000 (GMT)
Subject: Re: [PATCH v9 0/5] Exynos: Simple QoS for exynos-bus using
 interconnect
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        inki.dae@samsung.com
Cc:     krzk@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9cb7e3a6-2a3f-8f46-2bf1-d6d8ea01613b@samsung.com>
Date:   Fri, 13 Nov 2020 18:07:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <b0a8e994-06d2-e04a-579c-40580b71f760@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmnu4Mz3XxBucnSVrcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZtF694j7BaH37SzWsyY/JLNQcBj06pONo871/awedzvPs7ksXlJvUffllWMHp83yQWw
        RWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdraRQ
        lphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzI
        zph9eAtjwTS+irkzrjE1MB7k7mLk5JAQMJFovjSDHcQWEtjBKNG3TK+LkQvI/sQosaD9NiuE
        85lRYvXSZnaYju/HVrBAJHYxShx++JAZov09o0TnTlkQW1ggSGLi/SNgDSIChRJznv4Ea2AW
        eM0kcfjmeSaQBJuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2Eqv2TWUBsVkEVCXOHDwJViMqECZx
        clsLVI2gxMmZT8BqOIHqFy98xwpiMwuIS9x6Mp8JwpaX2P52DjPIYgmBFxwSGz7sZIN4wUVi
        y6qFUO8IS7w6vgXKlpL4/G4vVE21xMqTR9ggmjsYJbbsv8AKkTCW2L90MtAGDqANmhLrd+lD
        hBUldv6eywixmE/i3dceVpASCQFeiY42IYgSZYnLD+4yQdiSEovbO9kmMCrNQvLOLCQvzELy
        wiyEZQsYWVYxiqUWFOempxYbFpgix/YmRnCa1rLcwTj97Qe9Q4xMHIyHGCU4mJVEeJUd1sQL
        8aYkVlalFuXHF5XmpBYfYjQFBvBEZinR5HxgpsgriTc0NTI2NrYwMTQzNTRUEuf9o90RLySQ
        nliSmp2aWpBaBNPHxMEp1cCkeTV5otCUpUrxx/06WGcEmK/cafU1asrevSIZetGF9dv2+VWx
        +Tt47hWOrH5z+bxN5d9TMVKrn4bdveTYGau1cRbn7GMMiec5P8dkFOw9IOF43dRExbxzy66Y
        p22cjdO5dUPkQ3vPnGqad3WHz7JpC4r+CvaYbVIMMHz/YNUPn5IsnpBpbTY+Vu8ri7SE4945
        3ngjrbQ9Y6eIeaRKff+tz4eOrbOWqNys+OqeUU7rhmeyjE/drCI78tze/7H2VT25aOLdO4fm
        C/9LtN/n7HSS1bFwafP5O5zulc9yL3LvqMt/mMkp83Ox/7PDF7bueHT8wTGOE/eNGSuKy/IW
        PK4zEBdeIBLOc+ZI/EezZ0FKLMUZiYZazEXFiQDXa5MTXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvO50z3XxBv2LDS3uz2tltNg4Yz2r
        xfwj51gtrnx9z2Yxfe8mNotJ9yewWJw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        uN24gs2ide8RdovDb9pZLWZMfsnmIOCxaVUnm8eda3vYPO53H2fy2Lyk3qNvyypGj8+b5ALY
        orhsUlJzMstSi/TtErgyZh/ewlgwja9i7oxrTA2MB7m7GDk5JARMJL4fW8HSxcjFISSwg1Fi
        4vM57BAJSYlpF48ydzFyANnCEocPF0PUvGWUmHroBQtIjbBAkMTE+0fA6kUECiXOTrkENohZ
        4DWTxJyJ39khOg4zStxbcZoRpIpNQEti/4sbbCA2v4CixNUfj8HivAJ2Eqv2TQWbyiKgKnHm
        4EmwGlGBMImdSx4zQdQISpyc+QSshhOofvHCd6wgNrOAusSfeZeYIWxxiVtP5jNB2PIS29/O
        YZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcMxq
        ae1g3LPqg94hRiYOxkOMEhzMSiK8yg5r4oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21ME5I
        ID2xJDU7NbUgtQgmy8TBKdXAZBk0JVeJgSNPSbqjKo352FtLG+N3Xy977Xiz+XzlHU/119Ym
        Z3fGxU51PFczxapdkOH5luwNHsVn+gqrXZl2rGl4uGJ60+WS42mnyh6ZLTx1xJDhVKmB9Zaj
        1fbaD9iVCpd03I5+Kb9Aes7JQ3MNP9V0RDxJeO3FEBLHd/6+Wt6TFTlSMwOrji9c1bhs0sRl
        6pFCqxbEqh3rkPDc80DpaWPamvOGZxZnv5T7urEh6deE01nqArcUJop8/3R+a5JlHfOJxWqu
        TEvfn22RO+esF7y04u6J9pJLFWE6ex9qrpu6ehnrjr3JN5543TjvVLzL78IzFbftp4/op25b
        amJlz5z3suNf26ozPuve56f41ymxFGckGmoxFxUnAgArIZi3SAMAAA==
X-CMS-MailID: 20201113085343epcas1p198641b74a3aff97168379b595e37b7fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201112141041eucas1p1a29130955afd4ec1d5d94cf17183920c
References: <CGME20201112141041eucas1p1a29130955afd4ec1d5d94cf17183920c@eucas1p1.samsung.com>
        <20201112140931.31139-1-s.nawrocki@samsung.com>
        <b0a8e994-06d2-e04a-579c-40580b71f760@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/13/20 5:48 PM, Georgi Djakov wrote:
> On 11/12/20 16:09, Sylwester Nawrocki wrote:
>>
>> This patchset adds interconnect API support for the Exynos SoC "samsung,
>> exynos-bus" compatible devices, which already have their corresponding
>> exynos-bus driver in the devfreq subsystem.  Complementing the devfreq
>> driver with an interconnect functionality allows to ensure the QoS
>> requirements of devices accessing the system memory (e.g. video processing
>> devices) are fulfilled and allows to avoid issues like the one discussed
>> in thread [1].
>>
>> This patch series adds implementation of the interconnect provider per each
>> "samsung,exynos-bus" compatible DT node, with one interconnect node per
>> provider.  The interconnect code which was previously added as a part of
>> the devfreq driver has been converted to a separate platform driver.
>> In the devfreq a corresponding virtual child platform device is registered.
>> Integration of devfreq and interconnect frameworks is achieved through
>> the PM QoS API.
>>
>> A sample interconnect consumer for exynos-mixer is added in patch 5/5,
>> it is currently added only for exynos4412 and allows to address the
>> mixer DMA underrun error issues [1].
> 
> Good work Sylwester! Thank you and all the reviewers! What would be the merge
> path for this patchset? Looks like there is no build dependency between patches.
> Should i take just patches 2,3 or also patch 1? Chanwoo?

Hi Georgi,

If you take the patch 2,3, I'll apply patch 1,4 to devfreq.git.

Hi Sylwester,
First of all, thanks for your work to finish it for a long time.
I'm very happy about finishing this work. It is very necessary feature
for the QoS. Once again, thank for your work.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
