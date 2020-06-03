Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E161EC829
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 06:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgFCECb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 00:02:31 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:12221 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFCECa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 00:02:30 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200603040226epoutp03093ffad638a2260f56fe22cbd75af5c3~U7NAKHqNy2412224122epoutp03K
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 04:02:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200603040226epoutp03093ffad638a2260f56fe22cbd75af5c3~U7NAKHqNy2412224122epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591156946;
        bh=8DzpvgsCYbB55jRT92lei5XQhwUZ2CriPqL7BXIekdM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Tj+1w+RnWa5i85nv3Sq2alEqdTa0HKukvsWC1e3JVh54hbOMDDvhBS79WB04/LTuB
         j2jnD46iHKStHDcBE7AnGG9wo5SDgOwqTaaMDRDiIjO/7ejST+1vVZk4nzg29MCuJy
         0tvQ/TsQE/Cl7YzvVpQrb3gFJu+0LI5pouJJB2sI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200603040226epcas1p132d5aec7e1972ef6b5a66067188550e3~U7M-mzEBi3046630466epcas1p1I;
        Wed,  3 Jun 2020 04:02:26 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49cFbz31qpzMqYkk; Wed,  3 Jun
        2020 04:02:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.28.29173.FC027DE5; Wed,  3 Jun 2020 13:02:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200603040222epcas1p4dcac72b1d620804fc9a148db59beb71b~U7M8nBQtF0693606936epcas1p4H;
        Wed,  3 Jun 2020 04:02:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200603040222epsmtrp2b66c310760f383b730d6af6c69dd22bd~U7M8mDcRo0224702247epsmtrp2B;
        Wed,  3 Jun 2020 04:02:22 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-a2-5ed720cf86be
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.D1.08382.EC027DE5; Wed,  3 Jun 2020 13:02:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200603040222epsmtip128ab7f0c28d350ec69647bd75a9cd6cc~U7M8G82ag2616926169epsmtip1s;
        Wed,  3 Jun 2020 04:02:22 +0000 (GMT)
Subject: Re: [PATCH 06/12] PM / devfreq: Add cpu based scaling support to
 passive_governor
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
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <89ecb940-d613-1b18-c7fc-abab4d4264c2@samsung.com>
Date:   Wed, 3 Jun 2020 13:12:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1591100614.1804.1.camel@mtksdaap41>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzeuW0vLQS9FJBjI4h3WzarQGspHAkwccbdyTZItpHFOLDATUso
        bddbFtwSxgTGI4qwOcTycooyGExFwis8AsI6mG5Cx0MGCQ6GDAqVIZZp9mh7WcZ/3/ed77u/
        fL9zLp8jtOIiforGQOs1CjWJu3Jbbu+VBPzkPx4vKTXvQK3XF3joywdzOKru/5GH7p62uKAn
        P+djqGl2jIfMHRU4MmcPA7R2th+gq+PDGDqdI0O/fPo1jiwbdzF054cRHsrt6ndBf4/d5KKx
        r6w8dGFaiG6uU4c8qYaqBkCZi85iVLtx2oVqqi/AqamxTpy6VfMJlTPYw6WaR/O4VFFzPaBM
        E60YtdbkF+t2PDVcRSuSab0/rUnSJqdolBFk9NsJrybIQyTSAOlBFEr6axRpdAR55I3YgKMp
        ans50v9DhTrdLsUqGIYMigzXa9MNtL9KyxgiSFqXrNYd1AUyijQmXaMMTNKmhUklkgNyu/Fk
        qqp8LZujq3DL6LWZQBb4h18IBHxIBMOnXa1YIXDlC4k2AGuqyrgs+QPA3jwLjyVPAPxr9Xs7
        4TsjE+P7WL0LwKHL0y4ssQJ4bm2I5/iuJ3ECWrrOcRzYyx5ou1gOHCYOUcSD4w0WpwknxLBn
        YQJ34O3EHji6MQsc2J2IhLbaLKeHS7wAZx7fdnq8iTg42JKz6fGAgxfnuA4sIKSwc67W6eEQ
        PnByrhpj8W7YulzBcQyGxAUBXOqeB2zrI7DjfCHOYk+4aGp2YbEIrq10beofw7rBfpwN5wPY
        3HOPxx7IYM/VLzDHLjjEXni9I4iV98D2Z5WAHbwNrqyf2VyXO8z/TMhanofmmWmMxTvhlbwC
        vBiQxi11jFsqGLdUMP4/7BLg1oMdtI5JU9KMVCfbet1NwPnyxaFtoHT5UWAfwPigD0A+h/Ry
        D/Mdixe6JytOfUTrtQn6dDXN9AG5fcElHJF3ktb+62gMCVL5AZlMhoKlIXKplPRxfzPsXryQ
        UCoMdCpN62j9fzmMLxBlYb6Z65bfh0Y+iFvtWfQVhr/zKFO8b/JWtOsriW9Bt2+Gn01WTvVe
        UpbMx5RVWuXR317h3K++7/eyJExYfi3xvfdL+ZEds4biBY/t8UdDCugbVdTlmajs1WPdBt27
        RJRfyJCtXVw8sFQd2J+kXpTM48cbm1Bj8NKCoOaxdeDQKXWL52GmLKaO23lCF7j0m1exqvvk
        Lv13USU3conMOHHvxkOA9uc1jniXvR56zFUpenGOsQ020lye2fSg4bVduzNWVE/rag+vJg58
        Xm6KjHvufHfQQ+yMbX/t1M7lYo+MJdvMtbhft4leEgpifMrIoPnsXMvoHVPAeEtnPbPyZ1SV
        0VpEchmVQirm6BnFv/YDblmCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSnO45hetxBve7VSy2r3/BajH14RM2
        i/lHzrFanG16w27x7UoHk8Wmx9dYLS7vmsNmcbn5IqPF594jjBZLr19ksmhqMba43biCzeLN
        j7NMFmdOX2K1aN17hN3i37WNLBbXFr5ntZh+V8hi41cPB2GPNfPWMHpc7utl8tg56y67x6ZV
        nWwed67tYfPYvKTeo+XkfhaPLVfbWTz6tqxi9Dh+YzuTx+dNcgHcUVw2Kak5mWWpRfp2CVwZ
        sz83MxfM4a44+P04YwPjf44uRg4OCQETiRvXtbsYuTiEBHYzSnx6vp29i5ETKC4pMe3iUWaI
        GmGJw4eLIWreAtV0HGQDqREWiJF4s7efGcQWAZqzY+ZsRpAiZoEJrBI9B56yQXTcY5L4OekK
        WAebgJbE/hc3wGx+AUWJqz8eM4LYvAJ2Et+XN7CC2CwCKhIPvhwGqxEVCJPYueQxE0SNoMTJ
        mU9YQGxOAUOJPU+Wg9UwC6hL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYzCs5C0z0LSMgtJyywk
        LQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHvpbmDsbtqz7oHWJk4mA8xCjB
        wawkwmsley1OiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+NwoVxQgLpiSWp2ampBalFMFkmDk6p
        BqbJoffKvi79rMBdsDhIIuXrMplF2/o6f8w+ULrusUDBJOYnf92dvcWuFpv+3X7MgvHmpxX9
        PnGfPqQeKIiSeJDg4ie7ia/TJ/PRovfbXblmqJhJtUaHzYz+ePv4y3RtptKroUsvVPGe915X
        MdM027PIQXH1dq3f7L2My6b5fnE/8N2DObXd+EfkE403jumRh95nWjHlKeUoCszQf37+bm7Q
        b//a5QbfRQ9EdM/mM296s/7+3NAN72MfJYjel3Mu3nop7nndEdcH2ucF76tbsdrHeLpemt7Y
        xrUri39+YV5xnny44zc2ZvEKj/zHd80Zuk8b8b50PbjKf8c5z5aDIkqCzdetHPxuWcS473/9
        XImlOCPRUIu5qDgRAKpCScVsAwAA
X-CMS-MailID: 20200603040222epcas1p4dcac72b1d620804fc9a148db59beb71b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520034335epcas1p45a321a1a878fb7cd7b9c9ada0a474ef7
References: <20200520034307.20435-1-andrew-sh.cheng@mediatek.com>
        <CGME20200520034335epcas1p45a321a1a878fb7cd7b9c9ada0a474ef7@epcas1p4.samsung.com>
        <20200520034307.20435-7-andrew-sh.cheng@mediatek.com>
        <64b81eea-641c-811d-9830-718b28db4188@samsung.com>
        <7ad35770-9327-084a-d2ca-1646cabd0a4d@samsung.com>
        <1591100614.1804.1.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andrew-sh.Cheng,

On 6/2/20 9:23 PM, andrew-sh.cheng wrote:
> On Thu, 2020-05-28 at 16:17 +0900, Chanwoo Choi wrote:
>> Hi Andrew-sh.Cheng,
>>
>> The exynos-bus.c used the passive governor.
>> Even if don't make the problem because DEVFREQ_PARENT_DEV is zero,
>> you need to initialize the parent_type with DEVFREQ_PARENT_DEV as following:
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index 8fa8eb541373..1c71c47bc2ac 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -369,6 +369,7 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>                 return -ENOMEM;
>>  
>>         passive_data->parent = parent_devfreq;
>> +       passive_data->parent_type = DEVFREQ_PARENT_DEV;
>>  
>>         /* Add devfreq device for exynos bus with passive governor */
>>         bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
> Hi Chanwoo Choi,
> Do you just remind me to initialize it to DEVFREQ_PARENT_DEV whn use
> this governor?

Yes. This change was not included in this patchset.

> I will do it and thank you for reminding.

Thanks.

(snip)


And, this patchset doesn't include the dt-binding example
and any real example in devicetree. If possible, I recommend
you better to update dt-binding document with example.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
