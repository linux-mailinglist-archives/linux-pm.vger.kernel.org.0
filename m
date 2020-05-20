Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4881DAA6C
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 08:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgETGOA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 02:14:00 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25083 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgETGN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 02:13:59 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200520061355epoutp03bc1ef036d03b7d193c7ef1ca2dbb8f9b~Qp9z5IYjU2367123671epoutp03c
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 06:13:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200520061355epoutp03bc1ef036d03b7d193c7ef1ca2dbb8f9b~Qp9z5IYjU2367123671epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589955236;
        bh=j6EMd3fu4ZC9Mt1Myz68nMqMHxJem37XjOfFnUWSRf0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lmzuXmqKPJzYnX1QosaisB3h98cy6/iwZTBA/tZtZjit5MKIFcxDDLSUSMLz0yYOh
         xO4/85s3hU5ZEzyyq2WvYYWxZCj4QgdkNwoTIQY5uXdCQj+CZ38YUe1ejq7TQ5xatT
         wu7F1sbHoq18nZOo6gcNDbxJX//Z3DcBd3v6Bjss=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200520061354epcas1p42297987f27134fb99194273cdfaeefe4~Qp9ywDPao1265112651epcas1p4b;
        Wed, 20 May 2020 06:13:54 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49RjB76RKbzMqYkn; Wed, 20 May
        2020 06:13:51 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.89.04744.F9AC4CE5; Wed, 20 May 2020 15:13:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200520061350epcas1p21aefa74e9894fda67a27f2adc5d23ea3~Qp9uzdn510451704517epcas1p2g;
        Wed, 20 May 2020 06:13:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200520061350epsmtrp2818a76d04777bc8af2beff39b6a9e70d~Qp9uyVMIt1432414324epsmtrp2U;
        Wed, 20 May 2020 06:13:50 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-8f-5ec4ca9fe776
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.58.18461.E9AC4CE5; Wed, 20 May 2020 15:13:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200520061350epsmtip16646910b2dc9e7fbed9ce66c5c58a21c~Qp9ud9XWS2709127091epsmtip1L;
        Wed, 20 May 2020 06:13:50 +0000 (GMT)
Subject: Re: [PATCH 00/12] Add cpufreq and cci devfreq for mt8183, and SVS
 support
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <852af745-dfb7-6bb5-da7e-798d166a3370@samsung.com>
Date:   Wed, 20 May 2020 15:24:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1589953015.8243.2.camel@mtksdaap41>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJsWRmVeSWpSXmKPExsWy7bCmge78U0fiDLr3GlpsX/+C1WLqwyds
        FvOPnGO1ONv0ht3i25UOJotNj6+xWlzeNYfN4nLzRUaLz71HGC2WXr/IZNHUYmxxu3EFm8Wb
        H2eZLM6cvsRq0br3CLvFv2sbWSym3xWy2PjVw0HIY828NYweO2fdZffYtKqTzePOtT1sHpuX
        1Hu0nNzP4rHlajuLR9+WVYwex29sZ/L4vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne
        1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6CUlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1S
        akFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGyXUrmAv+y1fcnTKJrYHxjHgXIyeHhICJ
        xNVl65m7GLk4hAR2MEq8vfiEBcL5xCixZN1NZpAqIYFvjBJ7ejNhOjYv/w7VsZdRYta172wQ
        zntGiWf3X4B1CAuESKzdsR7MFgHq2DFzNiNIEbPACxaJ5e/ngCXYBLQk9r+4wQZi8wsoSlz9
        8ZgRxOYVsJPY824iC4jNIqAq8ezGSzBbVCBM4uS2FqgaQYmTM5+AxTkFDCXOzfkCFmcWEJe4
        9WQ+E4QtL7H97RywUyUE2jklLj06wATxg4vE/e0zWCBsYYlXx7ewQ9hSEp/f7WWDsKslVp48
        wgbR3MEosWX/BVaIhLHE/qWTgQZxAG3QlFi/Sx8irCix8/dcqCP4JN597WEFKZEQ4JXoaBOC
        KFGWuPzgLtQJkhKL2zvZJjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxaYIEf3JkZw
        etey2MG455zPIUYBDkYlHt4bOw/HCbEmlhVX5h5ilOBgVhLhnfDiUJwQb0piZVVqUX58UWlO
        avEhRlNgaE9klhJNzgfmnrySeENTI2NjYwsTQzNTQ0Mlcd6p13PihATSE0tSs1NTC1KLYPqY
        ODilGhg7Cp+s2y7PZvtJYePN/dIPUuM3CJfcXtwmsUXFVPv0ujSjte/T69Jj/oXw5ihoSule
        O8YwweqwivnDm8/bZRO/azeum3P+0FcPX7ZXT137RdQSfXRObZ7L1feGcfmW8lTd9Pvz/nxb
        +JPhQ3g/c1lFuLO/xec9xxo3KubM6Vx6fSrXHHXr+MtKLMUZiYZazEXFiQAvIbzgBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSnO68U0fiDB5eFbfYvv4Fq8XUh0/Y
        LOYfOcdqcbbpDbvFtysdTBabHl9jtbi8aw6bxeXmi4wWn3uPMFosvX6RyaKpxdjiduMKNos3
        P84yWZw5fYnVonXvEXaLf9c2slhMvytksfGrh4OQx5p5axg9ds66y+6xaVUnm8eda3vYPDYv
        qfdoObmfxWPL1XYWj74tqxg9jt/YzuTxeZNcAFcUl01Kak5mWWqRvl0CV8bJdSuYC/7LV9yd
        MomtgfGMeBcjJ4eEgInE5uXfmbsYuTiEBHYzSjxYPpMRIiEpMe3iUaAEB5AtLHH4cDFEzVtG
        iZ5fS1lAaoQFQiTW7ljPDGKLAA3aMXM2WC+zwBsWie/9FSC2kMBHRomnO0NBbDYBLYn9L26w
        gdj8AooSV388BqvnFbCT2PNuIthMFgFViWc3XoLZogJhEjuXPGaCqBGUODnzCVicU8BQ4tyc
        L1C71CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nz
        iw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNcS3MH4/ZVH/QOMTJxMB5ilOBgVhLhnfDiUJwQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3huFC+OEBNITS1KzU1MLUotgskwcnFINTId7dnzlfVhuzZf8
        S2FJJb+Z9T6mhediev5d+cRb57nwpuaJt7brms1nTcqSuZuua1bj/PQeR+UNDl6nbc4q4nF9
        fW0LfsaFBz29yMYRMz+idePbM2vFnGOMPqtvf9LBpXH6O2dyyXQ+0/Qtmzcu9e9I3P9Oqkuj
        7YD6ww+X65pm5vc2JPFJaPNIpbBNkZcX6rHsznlVmvR/Q/fvk7XrThRs8Q1Rtev1C7BrnHzY
        6O6agw+Zk1JvR3iFu7XHHCoRTHq8s1VW5dvkgikZSTmdJXIvLN8eKl2tJpntLKQfWr52/YE8
        od3HWj9w3Fj/Y+O8LDeWk4c4FHabWOgoW3+5fHtiSGZxEJPdTn9nu3VKLMUZiYZazEXFiQC5
        rZF4YQMAAA==
X-CMS-MailID: 20200520061350epcas1p21aefa74e9894fda67a27f2adc5d23ea3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520034324epcas1p3affbd24bd1f3fe40d51baade07c1abba
References: <CGME20200520034324epcas1p3affbd24bd1f3fe40d51baade07c1abba@epcas1p3.samsung.com>
        <20200520034307.20435-1-andrew-sh.cheng@mediatek.com>
        <d08c0dc0-5573-6ba0-1d9f-18857c7f6fb6@samsung.com>
        <1589953015.8243.2.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 5/20/20 2:36 PM, andrew-sh.cheng wrote:
> On Wed, 2020-05-20 at 13:10 +0900, Chanwoo Choi wrote:
>> Hi Andrew,
>>
>> Could you explain the base commit of these patches?
>> When I tried to apply them to v5.7-rc1 for testing,
>> the merge conflict occurs.
>>
>> Thanks,

>> Chanwoo Choi
> 
> Hi Chanwoo Choi,
> 
> My base commit is
> commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Apr 12 12:35:55 2020 -0700
> 
>     Linux 5.7-rc1
> 
> Could you show me the conflict error?


When I tried to apply first patch with 'git am',
the merge conflict occurred.

git am \[PATCH\ 01_12\]\ OPP\:\ Allow\ required-opps\ even\ if\ the\ device\ doesn\'t\ have\ power-domains.eml
Applying: OPP: Allow required-opps even if the device doesn't have power-domains
error: patch failed: drivers/opp/core.c:755
error: drivers/opp/core.c: patch does not apply
error: patch failed: drivers/opp/of.c:195																																																																												
error: drivers/opp/of.c: patch does not apply
Patch failed at 0001 OPP: Allow required-opps even if the device doesn't have power-domains
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Regards,
Chanwoo Choi

> 
> BR,
> Andrew-sh.Cheng
>>
>> On 5/20/20 12:42 PM, Andrew-sh.Cheng wrote:
>>> MT8183 supports CPU DVFS and CCI DVFS, and LITTLE cpus and CCI are in the same voltage domain.
>>> So, this series is to add drivers to handle the voltage coupling between CPU and CCI DVFS.
>>>
>>> For SVS support, need OPP_EVENT_ADJUST_VOLTAGE and corresponding reaction.
>>>
>>> Change since v5:
>>> 	- Changing dt-binding format to yaml.
>>> 	- Extending current devfreq passive_governor instead of create a new one.
>>> 	- Resend depending patches of Sravana Kannan base on kernel-5.7
>>>
>>>
>>> Andrew-sh.Cheng (6):
>>>   cpufreq: mediatek: add clock and regulator enable for intermediate
>>>     clock
>>>   dt-bindings: devfreq: add compatible for mt8183 cci devfreq
>>>   devfreq: add mediatek cci devfreq
>>>   opp: Modify opp API, dev_pm_opp_get_freq(), find freq in opp, even it
>>>     is disabled
>>>   cpufreq: mediatek: add opp notification for SVS support
>>>   devfreq: mediatek: cci devfreq register opp notification for SVS
>>>     support
>>>
>>> Saravana Kannan (6):
>>>   OPP: Allow required-opps even if the device doesn't have power-domains
>>>   OPP: Add function to look up required OPP's for a given OPP
>>>   OPP: Improve required-opps linking
>>>   PM / devfreq: Cache OPP table reference in devfreq
>>>   PM / devfreq: Add required OPPs support to passive governor
>>>   PM / devfreq: Add cpu based scaling support to passive_governor
>>>
>>>  .../devicetree/bindings/devfreq/mt8183-cci.yaml    |  51 ++++
>>>  drivers/cpufreq/mediatek-cpufreq.c                 | 122 ++++++++-
>>>  drivers/devfreq/Kconfig                            |  12 +
>>>  drivers/devfreq/Makefile                           |   1 +
>>>  drivers/devfreq/devfreq.c                          |   6 +
>>>  drivers/devfreq/governor_passive.c                 | 298 +++++++++++++++++++--
>>>  drivers/devfreq/mt8183-cci-devfreq.c               | 233 ++++++++++++++++
>>>  drivers/opp/core.c                                 |  85 +++++-
>>>  drivers/opp/of.c                                   | 108 ++++----
>>>  drivers/opp/opp.h                                  |   5 +
>>>  include/linux/devfreq.h                            |  42 ++-
>>>  include/linux/pm_opp.h                             |  11 +
>>>  12 files changed, 874 insertions(+), 100 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci.yaml
>>>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
>>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
