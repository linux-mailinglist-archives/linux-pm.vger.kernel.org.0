Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52513AA9B7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 05:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhFQDxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 23:53:10 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:60018 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQDxK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 23:53:10 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210617035101epoutp0234fd43d0256c38b3983898db470f5ef6~JQiONdFxh1096610966epoutp02f
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 03:51:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210617035101epoutp0234fd43d0256c38b3983898db470f5ef6~JQiONdFxh1096610966epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623901861;
        bh=Vo5KDvTP/1K9pYRYCCipYnw9wCmroRU6OPdqaoydvZ8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=H308SLLK0ipG/23kU3gfzgkh9CQmWtJVjUxOKk55PeElYLuvkAZyodSd7SNX7e5uj
         nXnmDRVxOjCn0JmxSI4X49eBMtJ6NlCPlm7SUYC2hecBqH0V3aicbxs9b78l3EsNIV
         5z0R4Tcxz7vtXKydxyhTCf+/HAJENnL/sTuuXKB8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210617035100epcas1p412888c13548d48996eea2b3c08bd327a~JQiNzK-F60488004880epcas1p4G;
        Thu, 17 Jun 2021 03:51:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G57Ps5vs4z4x9Pr; Thu, 17 Jun
        2021 03:50:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.7E.09578.1A6CAC06; Thu, 17 Jun 2021 12:50:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210617035056epcas1p2694533e354e058c4c3bc183acd1173f0~JQiJva8d21175311753epcas1p2v;
        Thu, 17 Jun 2021 03:50:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210617035056epsmtrp2f122532a0de28ca9e962f01694139d64~JQiJul4LM0225402254epsmtrp2I;
        Thu, 17 Jun 2021 03:50:56 +0000 (GMT)
X-AuditID: b6c32a35-fb9ff7000000256a-32-60cac6a14f9b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.00.08637.0A6CAC06; Thu, 17 Jun 2021 12:50:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210617035056epsmtip1e4fef0c6af2fe3952f2aed3c1ed45f62~JQiJhYoLt2496324963epsmtip1M;
        Thu, 17 Jun 2021 03:50:56 +0000 (GMT)
Subject: Re: [PATCH] opp: of: Allow lazy-linking of required-opps to non
 genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "Viresh Kumar )" <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "andrew-sh . cheng" <andrew-sh.cheng@mediatek.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c40f535b-3075-62eb-3b82-837ad13d67d4@samsung.com>
Date:   Thu, 17 Jun 2021 13:09:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210617033351.44pxdpjicm62byuh@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmnu7CY6cSDHY91bLYvv4Fq8WE1u3M
        Fpd3zWGz+Nx7hNHizY+zTBb/rm1ksdj41cNi84NjbA4cHrMbLrJ4bFrVyeZx59oeNo+Wk/tZ
        PI7f2M7k8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k
        /FwrQwMDI1OgwoTsjNVH7ApmsFW0XD/J0sDYxNrFyMkhIWAicebrQ8YuRi4OIYEdjBKXX7Qw
        gSSEBD4xSpw6ngOR+MYoce3yeRaYjtO3LkN17GWUWHB6GjOE855Ron/qLHaQKmGBAInNK38C
        VXFwiAhoSby8mQpSwyzwh1Fi8t8zYJPYgOL7X9xgA7H5BRQlrv54zAhi8wrYSVz9PwvMZhFQ
        lZi9ZwNYjahAmMTJbS1QNYISJ2c+AZvDKWApsfPINrA4s4C4xK0n85kgbHmJ7W/ngB0nIbCU
        Q+Lyp6msIAdJCLhIPD/uBvGNsMSr41vYIWwpic/v9rJB2NUSK08eYYPo7WCU2LL/AjTAjCX2
        L53MBDKHWUBTYv0ufYiwosTO33OhbuCTePe1B2oVr0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiV
        ZiH5ZhaSD2Yh+WAWwrIFjCyrGMVSC4pz01OLDQsMkeN6EyM4pWqZ7mCc+PaD3iFGJg7GQ4wS
        HMxKIry6xScShHhTEiurUovy44tKc1KLDzGaAsN3IrOUaHI+MKnnlcQbmhoZGxtbmBiamRoa
        Konz7mQ7lCAkkJ5YkpqdmlqQWgTTx8TBKdXAtMnW4Ocjr56rJlMvrNWePfFTX94NtxP6V+5H
        Pl0ZvmR5n5rmr29T1vWF6EveagivvpS4xVDfltHKJUw8UlZT8oFwf+Zb3s1iR9nSda6XfFmr
        a3x6tfNZM7GvsaqHf786nf9w41rNFbbRl3lni3HnxPWfTM0/6nL95SuV2W1Hiv3PbTlTxuj/
        V+ZT7O9dbcdex0/9tLk62Uf59q8XD0wqZxiZBr8+f0tpjVfTz1OsDyQ3PFihKRWy0eeN/LQT
        anofqny7qqq+f2SeZBDVcj9YVGOCeku9Yc2P3Y9Ud4jH9t843nnbzSBI/JrOT9EHje8N5dxb
        8tMeVSh9OMX2XXTGfnZlTtmHWZnT/aYtk2BeocRSnJFoqMVcVJwIAEKNMREyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTnfBsVMJBmfm8FpsX/+C1WJC63Zm
        i8u75rBZfO49wmjx5sdZJot/1zayWGz86mGx+cExNgcOj9kNF1k8Nq3qZPO4c20Pm0fLyf0s
        HsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugStj9RG7ghlsFS3XT7I0MDaxdjFyckgImEicvnWZ
        sYuRi0NIYDejxPn2WYwQCUmJaRePMncxcgDZwhKHDxdD1LxllJgx9zwzSI2wgJ/Eo7mTwWpE
        BLQkXt5MBalhFvjHKPFu4m42iIZWZomNH5rYQBrYgIr2v7gBZvMLKEpc/fEYbBmvgJ3E1f8Q
        i1kEVCVm79kAViMqECaxc8ljJogaQYmTM5+wgNicApYSO49sA6tnFlCX+DPvEjOELS5x68l8
        JghbXmL72znMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dL
        zs/dxAiOLy3NHYzbV33QO8TIxMF4iFGCg1lJhFe3+ESCEG9KYmVValF+fFFpTmrxIUZpDhYl
        cd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxM/5ib/Tot9r4KmB+bUvTI6HWj22Ymj7sZcnsc
        0xS3vNddy380c5nU/xvXLe2flm83fGywzO9hoUrFnMK/4aHXzGxeTnQz6eb1VFY0XXN6eaff
        5LLc02IegdNWy5ZtmZZgcKSq62Pv79ITyV+Fdzd8OiHxxyyt8ULFg8aoTQ9/Hne9Yh/yJORO
        u9XeLZt/9J19+7WnL3KNv65w7F9770sOymeS131f/lz9mkG/5rkNTlI/Xniwv5V2z522+9HC
        C/56HdwrNG86ZNju7VXYcn1bWM6N1a3pYpILOnVdl5TMtM43K0gT7VmyuvnBxzOHardwPZc4
        L3029M6Zaou+9t0KM6ayPLyiNfGalFShnI4SS3FGoqEWc1FxIgDDhx2+HgMAAA==
X-CMS-MailID: 20210617035056epcas1p2694533e354e058c4c3bc183acd1173f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc
References: <20210616053335.4181780-1-hsinyi@chromium.org>
        <CGME20210616075555epcas1p136129544501878b4bedaf8e46f9a43dc@epcas1p1.samsung.com>
        <20210616075548.ghp3lmjf4y6pyxoy@vireshk-i7>
        <b9310754-2105-2a93-ecbf-513d9a80a91a@samsung.com>
        <20210616090945.sn337tftdcp7y7y6@vireshk-i7>
        <742b2623-e8ff-db1f-9168-bdbde98110dd@samsung.com>
        <20210617033351.44pxdpjicm62byuh@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/17/21 12:33 PM, Viresh Kumar wrote:
> On 17-06-21, 10:13, Chanwoo Choi wrote:
>> The devfreq driver(exynos-bus.c) has used the dev_pm_opp_set_rate()
>> and used the passive governor without the required-opp property.
> 
> Which is fine.
> 
>> I have a plan to use the required-opp property
>> between devfreq drivers (exynos-bus.c) with dev_pm_opp_set_rate().
>>
>> I'll support them on later if this approach doesn't break the any
>> rule of required-opp property.
> 
> You will be required to make some changes in core for that I am
> afraid. It won't work automatically.

Do you think that better to use clk_enable/regulator_enable directly
instead of dev_pm_opp_set_rate() for using required-opp property?


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
