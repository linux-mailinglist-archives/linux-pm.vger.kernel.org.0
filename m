Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7A2345853
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 08:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCWHKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 03:10:12 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43643 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCWHKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 03:10:02 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210323070959epoutp041f7ee21a5a31466f7bca548f58aacf20~u5xZ4M9oc1234612346epoutp04X
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 07:09:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210323070959epoutp041f7ee21a5a31466f7bca548f58aacf20~u5xZ4M9oc1234612346epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616483400;
        bh=Au5ti1wVPPlKBd41V0ogOxsfCivWxwZWOYtYDqk4n5s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GqqTfyqdl1gcumG8pl3a/Gw2GOW1/PxcsK6gPQPHOI9m3BMz8I+YxaEwoI5Hhye1r
         QOQWSuqFD+aPlcDBNLHM87MBUT2K2yO4t5UHVqXMDRuOjhvNfCOAoaEnv6wzC0xLF7
         UlOJrsINOyExjJy9FyPSqY1YA/4FZCnZ0V/zFJ00=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210323070959epcas1p15705b9bcb906ef04b8a7b778ec370a54~u5xZY2zlI1599815998epcas1p1s;
        Tue, 23 Mar 2021 07:09:59 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F4Mv74tDcz4x9Q1; Tue, 23 Mar
        2021 07:09:55 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.94.63458.34499506; Tue, 23 Mar 2021 16:09:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210323070954epcas1p1cf67be2e096e5b52720fbe817a23826a~u5xVMwj4d1648916489epcas1p1E;
        Tue, 23 Mar 2021 07:09:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210323070954epsmtrp1696d5a24d26c06e6188e1851798382b8~u5xVLx3FU3219132191epsmtrp1N;
        Tue, 23 Mar 2021 07:09:54 +0000 (GMT)
X-AuditID: b6c32a36-c6d65a800000f7e2-17-60599443ed30
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.63.13470.24499506; Tue, 23 Mar 2021 16:09:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210323070954epsmtip1a47f625e4427190827fc052a23141ff7~u5xUtrgVQ1120911209epsmtip1B;
        Tue, 23 Mar 2021 07:09:54 +0000 (GMT)
Subject: Re: [PATCH V2 0/6] PM / devfreq: a few small fixes and improvements
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Dong Aisheng <dongas86@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <80303c89-3306-c4fd-1bfd-a11268bf553b@samsung.com>
Date:   Tue, 23 Mar 2021 16:26:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB4966CC15309EA6F0D78EC6BB80649@AM6PR04MB4966.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmrq7zlMgEgyVP1CyWXTrKaPFl6i5m
        i7+bp7NZrJq6k8XibNMbdotNj6+xWnT9WslscXnXHDaLz71HGC1uN65gs3ixRdyB22PnrLvs
        HptWdbJ5bF5S77Hx3Q4mj/6/Bh59W1YxenzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+P48p2MBb08FbtmXWBqYLzF2cXIwSEh
        YCLR/zCmi5GLQ0hgB6PE3TNTWbsYOYGcT4wS+5erQCS+MUr8m3mBDSQB0rC26xo7RGIvo8S0
        K3NYIJz3jBLz30xjBKkSFvCR+DllKROILSLgJbF323cmkCJmge3MEms/toIl2AS0JPa/uAE2
        ll9AUeLqj8dgzbwCdhLXPu0Bs1kEVCU2nl4DViMqECZxclsLVI2gxMmZT1hAbE6BWInGM8uY
        QWxmAXGJW0/mM0HY8hLb385hBlksIXCCQ+LnvxPsEE+7SKxt54N4R1ji1fEt7BC2lMTL/jYo
        u1pi5ckjbBC9HYwSW/ZfYIVIGEvsXzqZCWQOs4CmxPpd+hBhRYmdv+cyQuzlk3j3tYcVYhWv
        REebEESJssTlB3eZIGxJicXtnWwTGJVmIflmFpIPZiH5YBbCsgWMLKsYxVILinPTU4sNC4yQ
        I3sTIzjxapntYJz09oPeIUYmDsZDjBIczEoivC3hEQlCvCmJlVWpRfnxRaU5qcWHGE2B4TuR
        WUo0OR+Y+vNK4g1NjYyNjS1MDM1MDQ2VxHkTDR7ECwmkJ5akZqemFqQWwfQxcXBKNTDpbEtK
        +TdPIn3ZFfFX37tdbuyLOSzNsodjb90ftbim/W1Vsi7zhLh2R1x6WSjU8nfioh835KPZovv5
        5vzUnucTyNX84qqY3+2C9NSq6SyJ0u4NV482BayP9vF+oaN6/9L82Ud8z91/rdmryzeR70l4
        vsuUUsdlvyLdTC9c2sZ6kusFR8C2G2UrPLhmMTz107FYfONv76Ne4d0/WjZlmLVIliXMCWhd
        9eL2rElhYn94DS1sPbfptsXGR7ry9NVoXdr7oSOLoyDf7fCuvz+WzDKOuvxT8Eyiy+T6CYUc
        k1UWWWk90+ZbZ+Gy7aL1lKX+DkfVs5xOH1lyL/VQzYnHzh/qKyunvubycl3vxdlmUaHEUpyR
        aKjFXFScCABAgCz2RQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnK7TlMgEgz0P9C2WXTrKaPFl6i5m
        i7+bp7NZrJq6k8XibNMbdotNj6+xWnT9WslscXnXHDaLz71HGC1uN65gs3ixRdyB22PnrLvs
        HptWdbJ5bF5S77Hx3Q4mj/6/Bh59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CVcXz5TsaCXp6K
        XbMuMDUw3uLsYuTkkBAwkVjbdY29i5GLQ0hgN6PEvdPfWSASkhLTLh5l7mLkALKFJQ4fLoao
        ecsocaf/JViNsICPxM8pS5lAbBEBL4m9274zgRQxC+xklrjW+4gNouM5k8T93l52kCo2AS2J
        /S9usIHY/AKKEld/PGYEsXkF7CSufdoDZrMIqEpsPL0GrEZUIExi55LHTBA1ghInZz4B28wp
        ECvReGYZM4jNLKAu8WfeJShbXOLWk/lMELa8xPa3c5gnMArPQtI+C0nLLCQts5C0LGBkWcUo
        mVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyHWpo7GLev+qB3iJGJg/EQowQHs5IIb0t4
        RIIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTP5FIutY
        DL5Z7exWE3ry8a3Te76aGVfqFq66zppxMXXBvI8LimILDr2euOj6it/Jy8Tlk+/+rdX8NLes
        RvxF7ePIsk9x9idEpqpb9Xb3yCcWXV3I/+p2836fpvqnLn93G3zd/mTXwYMOXZ5rc84+Z2FP
        UVi/5VJl7cTdzE2pkx9b3zNYly97kDG8ZmXvp9tlE+YdWVi42a9mhyfHlR/fE7qcsnz5HCfd
        mpC8UHLWzWb7ZrH0uv3lM1fxiQfVdNzpnd3AJe27aGniYt/TprN3xtZ5ntJ5539v0rHiU5WB
        2TVx079P7v38tvC2Z4bNtVkv5LV7c5jOWiy4udvauvP9tRMnvldar7bkOqrifP+TfKQSS3FG
        oqEWc1FxIgCAd/msMgMAAA==
X-CMS-MailID: 20210323070954epcas1p1cf67be2e096e5b52720fbe817a23826a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210323032617epcas1p162bd7e8bff584af99b6065a2f7c13325
References: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
        <CGME20210323032617epcas1p162bd7e8bff584af99b6065a2f7c13325@epcas1p1.samsung.com>
        <CAA+hA=Sb+eXqaVFKtSgzM6RsnwufqEHcKrbnD_rmnDW3-qGJSQ@mail.gmail.com>
        <ffcd13a3-68cd-9b57-1fae-ac1b6624ddfe@samsung.com>
        <AM6PR04MB4966CC15309EA6F0D78EC6BB80649@AM6PR04MB4966.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/23/21 3:11 PM, Aisheng Dong wrote:
>> From: Chanwoo Choi <cw00.choi@samsung.com>
>> Sent: Tuesday, March 23, 2021 12:11 PM
>>
>> Hi,
>>
>> On 3/23/21 12:25 PM, Dong Aisheng wrote:
>>> Hi Chanwoo,
>>>
>>> On Tue, Mar 23, 2021 at 11:13 AM Dong Aisheng <aisheng.dong@nxp.com>
>> wrote:
>>>>
>>>> A few small fixes and improvements
>>>>
>>>> ChangeLog:
>>>> v1->v2:
>>>>  * squash a few patches
>>>>  * rebase to devfreq-testing
>>>
>>> I have to rebase to devfreq-testing instead of devfreq-next because
>>> below two patches only exist in devfreq-testing.
>>> 5cc75e9252e9 (devfreq/devfreq-testing) PM / devfreq: Add
>>> devfreq_transitions debugfs file
>>> dc9e557845c1 PM / devfreq: Add new up_threshold and down_differential
>>> sysfs attrs My patch 5 needs change based on it according to your
>>> suggestion. So i have to rebase to that branch.
>>>
>>> However, i found devfreq-testing can't build with GOV_PASSVIE enabled.
>>> Patch 1 fixed it. You can squash to the original one when apply.
>>>
>>> Please help take a look at this new series.
>>
>> Please rebase your patches either devfreq-next or linux-next.git Because
>> devfreq-testing branch is not official.
> 
> Okay, then how about the patch 5 below?
> [PATCH V2 5/6] PM / devfreq: governor: optimize simpleondemand get_target_freq
> 
> Should I also rebase it to devfreq-next or drop it first and then resend when your patch
> merged into mainline?

Yes. Thanks.

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
