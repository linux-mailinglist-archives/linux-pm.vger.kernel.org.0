Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48716FC199
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 09:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfKNIdY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 03:33:24 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:18300 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNIdY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 03:33:24 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191114083320epoutp03bb4a50693a8ff0dd7056801ed862ba1a~W_l3Snelf2694626946epoutp03h
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 08:33:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191114083320epoutp03bb4a50693a8ff0dd7056801ed862ba1a~W_l3Snelf2694626946epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573720400;
        bh=I6Y8cSsjoOp8g/yBAlaiwUPcDkiaowW9hTnA9+NGhVY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WnCLHXJv3KQAjsP5EvcgfqpRFi+YKSRQPp28Ea5xuIEKyGDjD1k2Z7rVqZQ9WehIU
         J83a1YFvsdUVcSeQUIAlVOIlLrNBH1IQsGkAWc70WG6yzWi+a9n3r9OIY7SzdIET9c
         WRm66SfkVhQiuQZnPajGElDZpOp2JBA7kFhY1y8I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191114083320epcas1p353fe177c22d30e7120f597a70caa9e8e~W_l2wX0mJ3141431414epcas1p3B;
        Thu, 14 Nov 2019 08:33:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47DF9n524PzMqYkd; Thu, 14 Nov
        2019 08:33:17 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.3E.04085.D411DCD5; Thu, 14 Nov 2019 17:33:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191114083316epcas1p40975d359d19194b3d40fd29e2aa189d0~W_lz0tcFK1810418104epcas1p4f;
        Thu, 14 Nov 2019 08:33:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191114083316epsmtrp2bc26688328f4588556f59345244eff80~W_lzz47vT2132521325epsmtrp2B;
        Thu, 14 Nov 2019 08:33:16 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-42-5dcd114da2cc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.AF.24756.C411DCD5; Thu, 14 Nov 2019 17:33:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191114083316epsmtip15147a8f4b8f85af66a76ba5a2b5e0b0c~W_lzY27xN0672206722epsmtip1u;
        Thu, 14 Nov 2019 08:33:16 +0000 (GMT)
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <754ec843-eb8f-5149-bf7f-ec4abf938821@samsung.com>
Date:   Thu, 14 Nov 2019 17:39:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-tUtnX0T47YGdf7-cgp6e8K9Rgb34Mfe5Za9L4YMGS1g@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0hTYRjHeXfOjsdsdVyaT9JFTwRqajut2SlSi6wGGVh+6YLYQU86tp2N
        nS26EFhBXsoo7EKjq2GlX8o51IxhrcxMF5W4bgSWhlJqF7PbyDrbMfLb7/0//4f3+b8XElPf
        J2JJg2DnbQJnookpeOPdxNSUDZG+PE1gIIFtbopifQeGwtjulrMEO1p5D7Gv9l8j2KEfPgXb
        1flUyVZ4fxPsuL8eZ/2XPirZht77xMoIfeOtRqW++2ilQn/R5dC76soJvbunFNcfddchffvz
        JoV+1DU3h9xqXFHMc4W8LY4XCiyFBqEonV6fm786X5emYVKYZexSOk7gzHw6nZWdk7LWYJLm
        pON2ciaHJOVwokgvylhhszjsfFyxRbSn07y10GRdZk0VObPoEIpSCyzm5YxGs1gnGbcbi7/0
        VymsZeG7+q/8wUtQRVgFCieBWgIfRipRBZpCqqlmBNfe+pXy4guCka93MHnxDYG/vVL5r6Wq
        zUnIBQ8C97vaiZaPCG77n4RcM6hsGLzsDHEUlQQufx8eNGHUIQzuHu5CwQIhFVoHnxNBnk7F
        Q8+PvpCuojLgpO9ASMepBXDu9ROJSTKa2gydY5xsiYSOM/14kMOpjRD43RYKhFEx8LL/gkLm
        edA0fBaTp64Og77qKJmz4M34r4kDmAHv290THAujIx5C5r1Q23EvlBKoMill6+OJ+FporalS
        BOfBqES43rJIluPhZuAckvedBiNjR5RBC1AqKDukli3zobv3tULmWXC5tJw4hmjnpDTOSQmc
        kxI4/292EeF1aCZvFc1FvMhYtZNv24VCbzhpaTO68SjbiygS0VNVt6O78tRKbqe42+xFQGJ0
        lOrEsCSpCrnde3ibJd/mMPGiF+mksz6OxUYXWKQfIdjzGd1irVbLLmHSdAxDx6hWXa3JU1NF
        nJ038ryVt/3rU5DhsSUoed3D8m0HS14MXPn8LNK8LyHmV0Kqx5ouBAaXnzQFHmw7bH9hrpld
        8/2TeXRzJLfw1PipsUxfcmttrjtp5a2sQUvKhpYMz5zzwtveaYltJ9ZkNh3xGBs+BdoPGmZn
        GoRNpxsy5iWaLsy5etpiIks3bunxpqmSs3c01xvX/tQMR6gjaFws5pgkzCZyfwG1JPpd2QMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSnK6P4NlYgzmXdS12bBexONv0ht3i
        8q45bBafe48wWtxuXMFm8ebHWSaLM6cvsVp0HfrLZvHv2kYWi2sL37NabH5wjM2B22Pb7m2s
        Hpf7epk8Fmwq9di0qpPNY8vVdhaPvi2rGD2O39jO5PF5k1wARxSXTUpqTmZZapG+XQJXxqcn
        k5kKOjgrniz7z9LA2MXexcjJISFgIjH56Cy2LkYuDiGB3YwSOz8uhEpISky7eJS5i5EDyBaW
        OHy4GKLmLaPE/vkvGUFqhAV8JF4snsUKYosIaElsuvaYBaSIWaCDWWLh/K9MEB1dTBJv258z
        g1SxAVXtf3GDDcTmF1CUuPrjMdgkXgE7ialnm8DiLAKqEnPvXgSzRQUiJJ5vvwFVIyhxcuYT
        FhCbUyBQ4vffo2CXMguoS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMwrOQtM9C0jILScssJC0L
        GFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx6SW5g7Gy0viDzEKcDAq8fAeED0T
        K8SaWFZcmXuIUYKDWUmEd8pboBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNT
        UwtSi2CyTBycUg2M1h8L0hzzdq8QbUjc9Tn91KZpblMqZjpd+7YyikOiaabaojOHZR4+EnGY
        Uq7QG18Wn+76PEpASlOAoUb+4YqmZom0js6zpzZemf1Z93LCr10cmgfOcU8MSLu+fvHFlTO4
        DikdWrg4P571z/cZkxKWO59rdDsWeydjptP63DT5Zc+YNswyfOk8TYmlOCPRUIu5qDgRAKT9
        YenFAgAA
X-CMS-MailID: 20191114083316epcas1p40975d359d19194b3d40fd29e2aa189d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190724014230epcas5p371a5fdee330f91a646d619fbcc024acf
References: <CGME20190724014230epcas5p371a5fdee330f91a646d619fbcc024acf@epcas5p3.samsung.com>
        <20190724014222.110767-1-saravanak@google.com>
        <cb0d4aad-81e4-0b8d-40f2-7f58ef1e38d9@samsung.com>
        <CAGETcx-tUtnX0T47YGdf7-cgp6e8K9Rgb34Mfe5Za9L4YMGS1g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On 11/14/19 5:23 PM, Saravana Kannan wrote:
> On Wed, Nov 13, 2019 at 11:48 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> Dear Saravana,
>>
>> Any other progress of this series?
> 
> Hi Chanwoo,
> 
> Thanks for checking. I haven't abandoned this patch series. This patch
> series depends on "lazy linking" of required-opps to avoid a cyclic
> dependency between devfreq and OPP table population. But Viresh wasn't
> happy with my implementation of the lazy liking for reasonable
> reasons.
> 
> I had a chat with Viresh during one of the several conferences that I
> met him at. To fix the lazy linking in the way he wanted it meant we
> had to fix other issues in the OPP framework that arise when OPP
> tables are shared in DT but not in memory. So he was kind enough to
> sign up to add lazy linking support to OPPs so that I won't have to do
> it. So, I'm waiting on that. So once that's added, I should be able to
> drop a few patches in this series, do some minor updates and then this
> will be good to go.

Thanks for the detailed explanation. I'll expect the your next version.

Thanks,
Chanwoo Choi
