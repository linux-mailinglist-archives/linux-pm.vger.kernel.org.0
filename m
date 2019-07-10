Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF5CF6478C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfGJNvL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 09:51:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52321 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfGJNvL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 09:51:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190710135109euoutp0142a07b3dbd41d82e7537e038f7377333~wEAGP63DH3197131971euoutp01e
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2019 13:51:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190710135109euoutp0142a07b3dbd41d82e7537e038f7377333~wEAGP63DH3197131971euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562766669;
        bh=4absh/hBLS9UjuxzT1kCq57KXKyG6pUw5ycbD+qq0cM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Mzjz159ELtaZNCpqoesX25kinWg0yTp58kVTfj7U3kJxgSxpYJqtIqKX2FyAbcnll
         IrLRXWsBVswLgZjPzB/e57d8yh5Ar31DpuFAWav8nk9A4C0GYTiWYX2qTag5jkY9Cx
         c1b3qTnkzopRewzZmFL8jTZU3l6FVfpkpxdh/3Vc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190710135108eucas1p1f28fd54a869e8784e661bcf66accaf5e~wEAFZijPC0688306883eucas1p1G;
        Wed, 10 Jul 2019 13:51:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 98.F0.04298.C4DE52D5; Wed, 10
        Jul 2019 14:51:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190710135107eucas1p1e82d9cdd577cdb9fc7455aa08e533f88~wEAEpXXoS0690306903eucas1p1H;
        Wed, 10 Jul 2019 13:51:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190710135107eusmtrp2dde0bc7d0d6574d0a914642e08ad712f~wEAEbIw0U3023630236eusmtrp2R;
        Wed, 10 Jul 2019 13:51:07 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-46-5d25ed4c7545
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.4C.04146.B4DE52D5; Wed, 10
        Jul 2019 14:51:07 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190710135106eusmtip1810244f21f3438fba8b8d052f8b6f0a5~wEADsr-_j1936719367eusmtip1C;
        Wed, 10 Jul 2019 13:51:06 +0000 (GMT)
Subject: Re: [PATCH 0/3] add coupled regulators for Exynos5422/5800
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <631ffd68-7aab-2483-8799-2019bf3bb444@partner.samsung.com>
Date:   Wed, 10 Jul 2019 15:51:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJKOXPc1rOyFujyWk4HwmQb6YEXd=CEHKwN8AH_pKxk-6CA08w@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHffZe9vri5HEqnlyYLAwK0qTABwxJKxvUh4I+RDVq1pta3tqr
        MwvLItMWlkWUTvFCV8xSZ7kS9YMuZ+Ulu6iYkeQkMi28ppDa5rvIb/9z+XHO/3A4SjnI+HPx
        SamCPkmXoGZ5uq51rnP9rrEg7YbvZStITUEVQ3qnvjGk1NrJkGtDPyjS1VUtJx0XRuXEPNTD
        kPf1xSyZzLMiUtDVJCOPrZ/l5F5vt4x8Ov+QJaOzHTKS3WiVk4WeGprUDrayW7w0lSWVSGOu
        uMxqau+e01x9WoE0tj6LTDNpDtjN7uc3HxUS4g2CPiTiMB83W94iS2nzOGW2GFEWKuKNyJ0D
        vAmms2ysEfGcEj9EMDiXSzsLSjyFYCLPQypMImgdmWX+EQP2BhfxAEHbtN0VjCGYG72CjIjj
        vPFW+NO41gn44LXQO/+bcfZQeJaGrJEXSyNYHAZfLe0yp1bgaMgva2GdmsZBUFeTSzm1L94H
        r60ltNTjBa8K7UvaHe+B6xdyllgK+0G/vdSlV4FlrJhyDgN8mYOfrSa5tPY2qDIP05L2hhHb
        U1d+JSy+kGDA6TBcflUuwRcdx8gZdwHh0GLrZpzOKIedqvoQKR0J9oX5JcOAPaFvzEvawRNu
        1N2mpLQCci8ppe71ULLY7jqiCoyLT5h8pDYtc2Za5sa0zI3p/9wyRFcgPyFNTIwVxNAkIT1Y
        1CWKaUmxwUeSE83I8XdvFmwTz9H0u5hmhDmk9lBwjh9UMjqDmJHYjICj1D6Kph2rtUrFUV3G
        aUGffEifliCIzUjF0Wo/xRm3wQNKHKtLFU4IQoqg/1eVce7+jq953b84k1kYEBweszei+9fM
        lxT1rjUHP/i6KRpO3in05VU5obWqoWPFL1NJ3cbMZ+vikt8dUw3dTD8+aXrbqAg26LLCjt86
        G11ut8RvDWrKPlE9GjUcGNl2sz9g/D4fZbVo+VXaRwb19vzrNTubPxT5tgR+LORfDRhs4g1c
        2bjgo6bFOF3oOkov6v4ClXHWNnMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7reb1VjDU6uVbTYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZvFmx9nmSxa9x5ht/h3bSOLxeYHx9gcBD3WzFvD6LFpVSebx+Yl9R59W1Yxehy/sZ3J
        4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27
        BL2MHwsPMxWc4KnYtL2LsYFxNlcXIyeHhICJxJ0ne9i6GLk4hASWMkpc3vGaESIhLdF4ejUT
        hC0s8edaFxuILSTwmlFi1RKlLkYODmEBZ4k/ezVBwiICmhLX/35nBZnDLPCHRaKrcQYjxNDH
        TBITfp0GG8omYC7xaPsZsKG8Am4SExYcBhvKIqAqsW1jBzOILSoQITHp2k4WiBpBiZMzn4DZ
        nAKBEhOb2sF6mQXUJf7Mu8QMYYtL3HoyHyouL7H97RzmCYxCs5C0z0LSMgtJyywkLQsYWVYx
        iqSWFuem5xYb6hUn5haX5qXrJefnbmIERvi2Yz8372C8tDH4EKMAB6MSD++Pe6qxQqyJZcWV
        uYcYJTiYlUR497krxwrxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjD55JXEG5oamltYGpob
        mxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYHRfejJEepIry74Ndl6e32qcf8zXT8s6
        qnfO6fQLrpPGZgfrPsyMzI+t2bXgf0uc4/3Ii8WKVi9jzh9J22Eqvjb71kY7EZsDIs/+2744
        rLdbl0Xnj7uo0bw/v8UV1jHnsbxJkoybKaS5pmyuvuaWZY6vV3K92NtwgVny/trV8rMn3Tjl
        kVbFuV6JpTgj0VCLuag4EQDsFWtaBgMAAA==
X-CMS-MailID: 20190710135107eucas1p1e82d9cdd577cdb9fc7455aa08e533f88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95
References: <CGME20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95@eucas1p1.samsung.com>
        <20190708141140.24379-1-k.konieczny@partner.samsung.com>
        <CAJKOXPd+UZ2MdrTVfBv5UYzK5LgKNQHUFzRbRNeq271EaDSchg@mail.gmail.com>
        <91f65527-3440-90fd-4096-5824fba1df78@partner.samsung.com>
        <CAJKOXPc1rOyFujyWk4HwmQb6YEXd=CEHKwN8AH_pKxk-6CA08w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10.07.2019 12:14, Krzysztof Kozlowski wrote:
> On Wed, 10 Jul 2019 at 12:03, Kamil Konieczny
> <k.konieczny@partner.samsung.com> wrote:
>>
>> On 10.07.2019 11:00, Krzysztof Kozlowski wrote:
>>> On Mon, 8 Jul 2019 at 16:12, <k.konieczny@partner.samsung.com> wrote:
>>>>
>>>> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>>
>>>> Hi,
>>>>
>>>> The main purpose of this patch series is to add coupled regulators for
>>>> Exynos5422/5800 to keep constrain on voltage difference between vdd_arm
>>>> and vdd_int to be at most 300mV. In exynos-bus instead of using
>>>> regulator_set_voltage_tol() with default voltage tolerance it should be
>>>> used regulator_set_voltage_triplet() with volatege range, and this is
>>>> already present in opp/core.c code, so it can be reused. While at this,
>>>> move setting regulators into opp/core.
>>>>
>>>> This patchset was tested on Odroid XU3.
>>>>
>>>> The last patch depends on two previous.
>>>
>>> So you break the ABI... I assume that patchset maintains
>>> bisectability. However there is no explanation why ABI break is needed
>>> so this does not look good...
>>
>> Patchset is bisectable, first one is simple and do not depends on others,
>> second depends on first, last depends on first and second.
>>
>> What do you mean by breaking ABI ?
> 
> I mean, that Linux kernel stops working with existing DTBs... or am I
> mistaken and there is no problem? Maybe I confused the order...

It is not ABI break, it should work with existing DTBs

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

