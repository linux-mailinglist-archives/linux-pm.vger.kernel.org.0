Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB42213078
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 02:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGCAdO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 20:33:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11315 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCAdO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 20:33:14 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200703003310epoutp025ff9ae403e6c8576c05a1cc29702f05a~eFs2bKEfX0954309543epoutp02Z
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 00:33:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200703003310epoutp025ff9ae403e6c8576c05a1cc29702f05a~eFs2bKEfX0954309543epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593736390;
        bh=WgDPUYOS70hgOg400YBVb5DhaHc/yBFjmgoXoUJmDMw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r8p9duiMBKndbOsMEPllv2s58Cu+2nfi05VcJX8bELHBNIh5xaGhiy1AFIktpxo1E
         3eBYRGrqYol8TvVJAz+qQF2yTW90FrceeeOS3vatEOm1QibV718Kp2gIxmXlVV+kUK
         /33+DTFnb3PsoVaLo/9ElqMYE4atDOSTWf5aVrRc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200703003309epcas1p3caf2fd985ec2c237f1e0bcbf83990f01~eFs18fMzl2651926519epcas1p33;
        Fri,  3 Jul 2020 00:33:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49ybXg5G4szMqYkv; Fri,  3 Jul
        2020 00:33:07 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.4E.18978.3CC7EFE5; Fri,  3 Jul 2020 09:33:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200703003307epcas1p20b58f82e8e7e0beb335410cd4b877884~eFsziTrw82396023960epcas1p2Z;
        Fri,  3 Jul 2020 00:33:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703003307epsmtrp233b13333867cbb0d370434cc05862122~eFszhjaJP0418304183epsmtrp2X;
        Fri,  3 Jul 2020 00:33:07 +0000 (GMT)
X-AuditID: b6c32a35-b8298a8000004a22-25-5efe7cc36538
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.CB.08382.3CC7EFE5; Fri,  3 Jul 2020 09:33:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200703003307epsmtip285aa2853c809377373831f3619fdd8db~eFszSmAja2432224322epsmtip2Q;
        Fri,  3 Jul 2020 00:33:07 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: tegra: Add Dmitry as a maintainer
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <a08f16bc-df90-2199-91c8-f2acfe0f94ad@samsung.com>
Date:   Fri, 3 Jul 2020 09:44:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <921abb5e-8c12-db8b-b345-fbe49080dc1c@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmvu7hmn9xBu/ua1is/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZnDl9idXi5655LA6cHjtn3WX36G1+x+ax5Wo7
        i0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dL
        zs+1MjQwMDIFKkzIzli2+QFrwQ7eip/3XzM1ML7j6mLk5JAQMJHoP/6SGcQWEtjBKLHjfGgX
        IxeQ/YlRYu6N2+wQzjdGiU+3PrHCdKzdto0JIrGXUeLK37+MEM57RomGn1uAWjg4hAXcJfrn
        24I0sAloSex/cYMNpEZE4A+jxIXbl8AmMQtEShzeuZoJxOYXUJS4+uMxI4jNK2AnMbN3AjuI
        zSKgIvF68l6wuKhAmMTJbS1QNYISJ2c+YQGxOQXsJc6t/sAEMVNc4taT+VC2vMT2t3OYQRZL
        CKzkkHj9tJ0J4gUXiTef/zFD2MISr45vYYewpSQ+v9vLBmFXS6w8eYQNormDUWLL/gtQ/xtL
        7F86mQnkS2YBTYn1u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJssTlB3ehTpCUWNze
        yTaBUWkWkndmIXlhFpIXZiEsW8DIsopRLLWgODc9tdiwwBA5tjcxghOrlukOxolvP+gdYmTi
        YDzEKMHBrCTCm6D6L06INyWxsiq1KD++qDQntfgQoykwgCcyS4km5wNTe15JvKGpkbGxsYWJ
        oZmpoaGSOK+4zIU4IYH0xJLU7NTUgtQimD4mDk6pBqbz135auy2ZVHHP8Wtw7+Ha9/91Z61r
        2tI2t2DH5veb98zZ+zR22z9ZxdyEJaVrpBgsXlpP+zyz8sC5z5z7/p9mL8nPbnyzj/Xy29wv
        +npXD0kE2LrFOxXvFFZcuqrviHaI/Sop/fr9Jz2e7Y+P/sA3ZaGOoCBHf/YScfmzsvuS+N9v
        6lKvjY1TfpW93n6DXeUUnWlZt4yrXD4c39i1VEF6epRSpmzu84sG20+FNzmkOWsuSI23Ttu5
        r8V4wWKb2yyhPxWk9j9+sD3b5o74hxnF03d+1y1vcj034+6dRPcnG+efyzBQvvdG3ivaWXu/
        0FX7W6JHTgovYrkc7Xwp5l3OOY3mcLfKE6s8fr9N27hJiaU4I9FQi7moOBEABYj04TUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXvdwzb84g33reC1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gszpy+xGrxc9c8FgdOj52z7rJ79Da/Y/PYcrWd
        xaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgylm1+wFqwg7fi5/3XTA2M77i6GDk5JARMJNZu
        28bUxcjFISSwm1Fi5u8LLBAJSYlpF48ydzFyANnCEocPF0PUvGWUeHnmPCtIXFjAXaJ/vi1I
        OZuAlsT+FzfYQGpEBBqYJFoXLWMCSTALREr0zN3CBtG8l1Hi/byFzCAJfgFFias/HjOC2LwC
        dhIzeyewg9gsAioSryfvBYuLCoRJ7FzymAmiRlDi5MwnYMdxCthLnFv9AWqBusSfeZeYIWxx
        iVtP5kPF5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLS
        vHS95PzcTYzgGNPS3MG4fdUHvUOMTByMhxglOJiVRHgTVP/FCfGmJFZWpRblxxeV5qQWH2KU
        5mBREue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cBUrbgk5NH3by+fb5g5pT5wkpb0Xu0J11pO
        Clq9/D3p5MbTWf4d1kWX1RjX39dV5vXgiN9slsWewC8T8b/+r/Anq8cx0iFe3Jsm87sUNS5u
        YzwQra78wN006MyP0Bds+YumfUuXYt4++2iFqHaBqM6zJY/ain9s79kaFWb6YLv3okrWnM1l
        3IefnLG5HM/+zodBfm58jJn/a/12sz45F52j4WbCLAEBxm9O6lcuF7dsEPknPu2n8vKtqSf/
        9r3qZE1/eTqgRfAL2wv/m8dCFJVd6lL5Zk//cX7ftoUJi81vnpDpXCX3y69mhXLDnZbEjc8C
        bGKqvl2fFlP+8sWjsnCB2OmicxQT3qfcDVv8+YkSS3FGoqEWc1FxIgDb/Ma6IAMAAA==
X-CMS-MailID: 20200703003307epcas1p20b58f82e8e7e0beb335410cd4b877884
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200402222006epcas1p4027cd509b32ba2d2bdf90e9e84cf4bec
References: <CGME20200402222006epcas1p4027cd509b32ba2d2bdf90e9e84cf4bec@epcas1p4.samsung.com>
        <20200402221723.6064-1-digetx@gmail.com>
        <921abb5e-8c12-db8b-b345-fbe49080dc1c@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear all,

On 5/8/20 1:04 PM, Chanwoo Choi wrote:
> Hi Rafael,
> 
> Could you please apply it to linux-pm directly?
> 
> I think that it is better to be applied directly
> for preventing the possible merge conflict of MAINTAINERS file.
> 
> Best Regards,
> Chanwoo Choi
> 
> On 4/3/20 7:17 AM, Dmitry Osipenko wrote:
>> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
>> want to help keep them working and evolving in the future.
>>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v2: - Addressed review comments made by Chanwoo Choi to v1 by correcting
>>       git's address, making this patch standalone and adding Rafael Wysocki
>>       to the list of email recipients.
>>
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 245a96316636..0a694e20ea19 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10922,6 +10922,15 @@ F:	include/linux/memblock.h
>>  F:	mm/memblock.c
>>  F:	Documentation/core-api/boot-time-mm.rst
>>  
>> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
>> +M:	Dmitry Osipenko <digetx@gmail.com>
>> +L:	linux-pm@vger.kernel.org
>> +L:	linux-tegra@vger.kernel.org
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
>> +S:	Maintained
>> +F:	drivers/devfreq/tegra20-devfreq.c
>> +F:	drivers/devfreq/tegra30-devfreq.c
>> +
>>  MEMORY MANAGEMENT
>>  M:	Andrew Morton <akpm@linux-foundation.org>
>>  L:	linux-mm@kvack.org
>>
> 
> 

I applied it to devfreq-next branch. Thanks.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
