Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A201A345674
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 04:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCWDyT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 23:54:19 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21103 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCWDyL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 23:54:11 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210323035409epoutp046c643af1e9dc092c0d180540ef06ea2d~u3GaIignH3223732237epoutp04F
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 03:54:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210323035409epoutp046c643af1e9dc092c0d180540ef06ea2d~u3GaIignH3223732237epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616471649;
        bh=np2sXMPS9QrGQ0lOPl+ID1HmzTpfCD92XNEJiQyLgnU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=X2HXFa4emYHV5yfEY4EyqAOnq6sWKffWwsEiJpl3VbAEFf/5eVLALo5lMMV7YlAXp
         ml1sxEdeUMt/Jqsw8x+xQzMq7R6GemvFVoDZmRPwxOGyEGyTw/PuP0x0NQuqyd+TVL
         ynxJEsmomWmwk2joWIHcyhC9YhfEZ4562bogPK5c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210323035408epcas1p2edc9c167a31f96886853fb32c1dc14d9~u3GZHhhv31220812208epcas1p2w;
        Tue, 23 Mar 2021 03:54:08 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4F4HY94CVVz4x9QG; Tue, 23 Mar
        2021 03:54:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.5C.63458.D5669506; Tue, 23 Mar 2021 12:54:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210323035404epcas1p16b02136773431d453dd224f9063517f8~u3GWCiFXH3092130921epcas1p18;
        Tue, 23 Mar 2021 03:54:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210323035404epsmtrp2f7453c6a60f8a82603d5de7b85b4fd0b~u3GWBm6EK0951309513epsmtrp2T;
        Tue, 23 Mar 2021 03:54:04 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-69-6059665d1f9d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.9A.08745.C5669506; Tue, 23 Mar 2021 12:54:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210323035404epsmtip1aaee3dfe32006a13d9166f51c13ebd07~u3GVxkg6Z0043500435epsmtip12;
        Tue, 23 Mar 2021 03:54:04 +0000 (GMT)
Subject: Re: [PATCH V2 0/6] PM / devfreq: a few small fixes and improvements
To:     Dong Aisheng <dongas86@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Abel Vesa <abel.vesa@nxp.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ffcd13a3-68cd-9b57-1fae-ac1b6624ddfe@samsung.com>
Date:   Tue, 23 Mar 2021 13:11:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAA+hA=Sb+eXqaVFKtSgzM6RsnwufqEHcKrbnD_rmnDW3-qGJSQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmrm5sWmSCwZY3shbLLh1ltPgydRez
        xd/N09ksVk3dyWJxtukNu8Wmx9dYLbp+rWS2uLxrDpvF594jjBa3G1ewWbzYIu7A7bFz1l12
        j02rOtk8Ni+p99j4bgeTR/9fA4++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53
        jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
        q5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnTGzZzlzQbNAxeoD/1gbGLfzdDFyckgI
        mEg82rOVtYuRi0NIYAejxNq57xghnE+MEo+mH4NyPjNKzG3YyATTsvXgXDaIxC5GiWeNa1hB
        EkIC7xklbj0rBrGFBXwkfk5ZCtYgIuAlsezhUnYQm1ngF5PE/D+qIDabgJbE/hc32EBsfgFF
        ias/HjOC2LwCdhKnly5lBrFZBFQlZmzZCjZHVCBM4uS2FqgaQYmTM5+wgNicAoES0+ZNYYKY
        Ly5x68l8KFteYvvbOcwgh0oIHOGQeHPzBDvEBy4Sq7dNZIawhSVeHd8CFZeS+PxuLxuEXS2x
        8uQRNojmDkaJLfsvsEIkjCX2L50MtIEDaIOmxPpd+hBhRYmdv+cyQizmk3j3tYcVpERCgFei
        o00IokRZ4vKDu9BAlJRY3N7JNoFRaRaSd2YheWEWkhdmISxbwMiyilEstaA4Nz212LDACDm2
        NzGCU6+W2Q7GSW8/6B1iZOJgPMQowcGsJMLbEh6RIMSbklhZlVqUH19UmpNafIjRFBjAE5ml
        RJPzgck/ryTe0NTI2NjYwsTQzNTQUEmcN9HgQbyQQHpiSWp2ampBahFMHxMHp1QDU7FV0I47
        FqznDOffDO6oOfl+efhs9TXNxytrUkUTre42655PPlW75r+5dWUGv+pS2zeRb0TtW9PPc6Uk
        FZrKJYbfcFo7LS7M/jbXJZ/VC0+p6SfNOrzO+OMzpv/n1b9w/fg293mNu9/prUvO+vx/YPC5
        uvN1m0zW3tafe478nO3EVix3vHKhmXTjhFNFim4FdqnB72qYkg6b3QjN0X4xc4HX0U7dlp9Z
        jm6t2aYWjCvPiK613nd5xU5b5uaNviIruXfMti898a5lReSt+RKnREXadySZFyX2rz6jeutj
        bd+pHRpLrYsuWfKKpi7QMFpzJ7bYomh/+P+9EzaerdSTWPp9JevkpqIwlQPGZwoWK7EUZyQa
        ajEXFScCAPoPeXlGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnG5MWmSCwf9ubYtll44yWnyZuovZ
        4u/m6WwWq6buZLE42/SG3WLT42usFl2/VjJbXN41h83ic+8RRovbjSvYLF5sEXfg9tg56y67
        x6ZVnWwem5fUe2x8t4PJo/+vgUffllWMHp83yQWwR3HZpKTmZJalFunbJXBlzOxZzlzQLFCx
        +sA/1gbG7TxdjJwcEgImElsPzmXrYuTiEBLYwShxcv5vRoiEpMS0i0eZuxg5gGxhicOHiyFq
        3jJKzHx5FKxGWMBH4ueUpUwgtoiAl8Syh0vZQYqYBf4wSfxZ8JkZouM+o8Snec3MIFVsAloS
        +1/cYAOx+QUUJa7+eAw2iVfATuL00qVgNSwCqhIztmwFmyoqECaxc8ljJogaQYmTM5+wgNic
        AoES0+ZNAYszC6hL/Jl3iRnCFpe49WQ+VFxeYvvbOcwTGIVnIWmfhaRlFpKWWUhaFjCyrGKU
        TC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5DLa0djHtWfdA7xMjEwXiIUYKDWUmEtyU8
        IkGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJpnOsLvM
        5/b9bOZbLHBK/9CWF1e0d8dkHvO6XSARabW3ySLZlrP7yGaT7Rax0XO6W1RvmZ9eOeGUzdKQ
        x283XXotJpd6c7vUz5WXPQq+mlybdmTbfrFG3dMuytPm7fvxZMNPkesRzu/4Q3LnLlm9PXnN
        E0a5tZpTwkrfem6taUmO2fXrXfktBneFA3mz+rce2X8hjyPfIcFhcWGZ8/dUproG4cS+Kds4
        S4+dzYk0/Td1yYSZG9tjr2nMSHbds1tu4/quR1VXlFnC+soTTqsFK5qYbAx+qDr1ZkTxN60m
        j+si9rV9np9tTUs/Wnlv3dFa9CfjgZGy5wWuDvPWMzP36J+JcVlXZFUbc0TsyPpP4UosxRmJ
        hlrMRcWJAB6Sr5QyAwAA
X-CMS-MailID: 20210323035404epcas1p16b02136773431d453dd224f9063517f8
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
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/23/21 12:25 PM, Dong Aisheng wrote:
> Hi Chanwoo,
> 
> On Tue, Mar 23, 2021 at 11:13 AM Dong Aisheng <aisheng.dong@nxp.com> wrote:
>>
>> A few small fixes and improvements
>>
>> ChangeLog:
>> v1->v2:
>>  * squash a few patches
>>  * rebase to devfreq-testing
> 
> I have to rebase to devfreq-testing instead of devfreq-next because
> below two patches
> only exist in devfreq-testing.
> 5cc75e9252e9 (devfreq/devfreq-testing) PM / devfreq: Add
> devfreq_transitions debugfs file
> dc9e557845c1 PM / devfreq: Add new up_threshold and down_differential
> sysfs attrs
> My patch 5 needs change based on it according to your suggestion. So i have to
> rebase to that branch.
> 
> However, i found devfreq-testing can't build with GOV_PASSVIE enabled.
> Patch 1 fixed it. You can squash to the original one when apply.
> 
> Please help take a look at this new series.

Please rebase your patches either devfreq-next or linux-next.git
Because devfreq-testing branch is not official. 

> Thanks
> 
> Regards
> Aisheng
> 
>>  * drop two patches which are already in devfreq-next
>>
>> Dong Aisheng (6):
>>   PM / devfreq: fix build error when DEVFREQ_GOV_PASSIVE enabled
>>   PM / devfreq: Use more accurate returned new_freq as resume_freq
>>   PM / devfreq: Remove the invalid description for get_target_freq
>>   PM / devfreq: bail out early if no freq changes in devfreq_set_target
>>   PM / devfreq: governor: optimize simpleondemand get_target_freq
>>   PM / devfreq: imx8m-ddrc: remove imx8m_ddrc_get_dev_status
>>
>>  Documentation/ABI/testing/sysfs-class-devfreq |  5 +--
>>  drivers/devfreq/devfreq.c                     | 37 +++++++------------
>>  drivers/devfreq/governor.h                    |  2 -
>>  drivers/devfreq/governor_simpleondemand.c     | 31 ++++++++++------
>>  drivers/devfreq/imx8m-ddrc.c                  | 14 -------
>>  5 files changed, 35 insertions(+), 54 deletions(-)
>>
>> --
>> 2.25.1
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
