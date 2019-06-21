Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1F4DF35
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 04:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfFUCvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 22:51:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:12498 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUCvT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 22:51:19 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190621025116epoutp035935c286b8f6fca3084a98e7de139167~qFvhLeE4W3071230712epoutp03m
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 02:51:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190621025116epoutp035935c286b8f6fca3084a98e7de139167~qFvhLeE4W3071230712epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561085476;
        bh=Vs8IOVDH/ICARp40T4SJapoAoFYLuMTrtpm/gZVtr4M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KZ21sZDF7kO4fLiBpbziMe5Nvegm2lCkUCDgFHX+qW/xyjqrCcy2dMbTP+OYRd1uO
         OJI70x28dE570eUswVLAYOIXqQEQhOjpRBno2FGPk/155D+qDqVkKyuUdDG/mxIjMK
         A8ef9PJkQmKasFAVg2oMaxxXRvuSJNmpAShXNICA=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190621025112epcas1p358a16e840e927ebeafea22edd5b9eb06~qFvdZPbMl2107121071epcas1p3E;
        Fri, 21 Jun 2019 02:51:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.6A.04142.E164C0D5; Fri, 21 Jun 2019 11:51:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190621025109epcas1p36f2e431e786ff333c4b885dc9ee91d94~qFva3Nvbg3157631576epcas1p3T;
        Fri, 21 Jun 2019 02:51:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190621025109epsmtrp26690da66d78a6409ea254949ea22a6b2~qFva2BjZH3207232072epsmtrp2d;
        Fri, 21 Jun 2019 02:51:09 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-f3-5d0c461e2d24
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.B3.03662.D164C0D5; Fri, 21 Jun 2019 11:51:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190621025109epsmtip2782a4bbbaa64c3d4d75d1cc717899bbb~qFvauzoue1068610686epsmtip2P;
        Fri, 21 Jun 2019 02:51:09 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Sanitize prints
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8b6d523e-7bb3-c705-7393-64d9b5fde900@samsung.com>
Date:   Fri, 21 Jun 2019 11:53:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c6bc6c42a29d9cf996dc82880ee01b806b0705c2.camel@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmga6cG0+swfJJrBZrbh9itNi54Qu7
        xeZzPawWZ5vesFt87j3CaHG7cQWbA5vHjrtLGD36tqxi9Pi8SS6AOSrbJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
        v7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO2PxlT1sBX9ZK1a17mFr
        YLzM0sXIySEhYCJxd/lt9i5GLg4hgR2MEgs+XGQDSQgJfGKU6NjIBZH4xihx9+5UZpiOt/Ng
        OvYySjTcn88M4bxnlJjw9BUTSJWwgJnElystLCAJEYEmRok3b1azgiSYBbIl5hyfxw5iswlo
        Sex/cQNsH7+AosTVH48ZQWxeATuJryeXgh3IIqAqsaNhLpgtKhAh8WXnJqgaQYmTM5+AxTkF
        vCVeT3/PDjFfXOLWk/lMELa8RPPW2VBnX2eTODNfHsJ2kbi6ei0bhC0s8er4FnYIW0ri87u9
        UPFqiZUnj7CBPCAh0MEosWX/BVaIhLHE/qWTgRZwAC3QlFi/Sx8irCix8/dcRoi9fBLvvvaw
        gpRICPBKdLQJQZQoS1x+cJcJwpaUWNzeyTaBUWkWkm9mIflgFpIPZiEsW8DIsopRLLWgODc9
        tdiwwAg5tjcxgtOkltkOxkXnfA4xCnAwKvHwHpjFHSvEmlhWXJl7iFGCg1lJhPcpI1CINyWx
        siq1KD++qDQntfgQoykwsCcyS4km5wNTeF5JvKGpkbGxsYWJoZmpoaGSOG88980YIYH0xJLU
        7NTUgtQimD4mDk6pBsZTyUlu4sqCpisl5NpdTSyCGU8sqwx+/T3zkK/0/74q30uSFyeeeMSa
        4PD/e+NiSxG7zwcD+n+Y5Wkkzc9duLqm+fTkhzcnLBVgeqeZr3Jjaxpf5Tf74PyNfyaF/J35
        0ugJd3euuvTEkIPzN1+sCH4QzWTy5kGE15/pBnIrvGuu6Ns6Rz/6ulyJpTgj0VCLuag4EQB4
        5wIRqQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXlfWjSfWoHmvpsWa24cYLXZu+MJu
        sflcD6vF2aY37Bafe48wWtxuXMHmwOax4+4SRo++LasYPT5vkgtgjuKySUnNySxLLdK3S+DK
        WHxlD1vBX9aKVa172BoYL7N0MXJySAiYSLydd5sdxBYS2M0o8fx3NkRcUmLaxaPMXYwcQLaw
        xOHDxV2MXEAlbxklvh37AFYvLGAm8eVKCwtIQkSghVHi8amZbCAJZoFsiedb1zJBdGxnkrh8
        +jnYNjYBLYn9L26AFfELKEpc/fGYEcTmFbCT+HpyKVgNi4CqxI6GuWC2qECExOxdDSwQNYIS
        J2c+AbM5BbwlXk9/zw6xTF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0
        LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwxWlo7GE+ciD/EKMDBqMTDe2AW
        d6wQa2JZcWXuIUYJDmYlEd6njEAh3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1Kz
        U1MLUotgskwcnFINjKFOkTUPcg4r77IQjRa/m+nSzrpNpamk5fUj8d+ajDuuqvyNbJhyYUV5
        74F7z386d8r8E7ZzSEtZkC5daSBU8ejIq+UW7HxPGpO4jab+EWKL6fyttGeH5Mbs2ynJiWVb
        06uP/bjFKs0tvWRi6+WDqdOnhi0qPMwccvybxNO0HzmfVWJfuq6aoMRSnJFoqMVcVJwIACwC
        D56UAgAA
X-CMS-MailID: 20190621025109epcas1p36f2e431e786ff333c4b885dc9ee91d94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190605190249epcas3p4c5e474328413c4a3944a1ae7cbd54c29
References: <20190605190053.19177-1-ezequiel@collabora.com>
        <CGME20190605190249epcas3p4c5e474328413c4a3944a1ae7cbd54c29@epcas3p4.samsung.com>
        <20190605190053.19177-2-ezequiel@collabora.com>
        <c053eea7-7c7f-a03a-0f09-83cd006a6a3a@samsung.com>
        <c6bc6c42a29d9cf996dc82880ee01b806b0705c2.camel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 6. 20. 오후 11:41, Ezequiel Garcia wrote:
> On Thu, 2019-06-20 at 16:23 +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> Frankly, I don't like the existing 'DEVFREQ: ' prefix 
>> because it is not used on all error log and it is not necessary.
>>
>> Instead of this patch, I just prefer to delete the 'DEVFREQ: ' prefix
>>
> 
> Hm, I have to disagree. Having naked pr_{} with just the __func__
> reducess logging consistency.

Actually, it is minor clean-up and there are no any benefits.

As I said, 'DEVFREQ: ' prefix was not used on all devfreq log.
If you don't agree to remove 'DEVFREQ: ', no problem.
IMO, just better to keep the current style without
any addition changes.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
