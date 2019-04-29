Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD3CE1EB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfD2MGD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 08:06:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38901 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfD2MGD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 08:06:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190429120602euoutp021f25f81ca3eed5587cbe57856470c53e~Z8HwZXbNH0317003170euoutp02r
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 12:06:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190429120602euoutp021f25f81ca3eed5587cbe57856470c53e~Z8HwZXbNH0317003170euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556539562;
        bh=Wi9LwnwCAQ5U1Z6yKDclgwENDQ4apGGAxH2IOMX7n6c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MJEFYBpFUc+I40BTzI+W+4fBktttnjBpNy8XxlTfQRKtVhIc61Gs8wjyXYWuEDdsa
         O3xJV1eUlA9Sl1+NpThOrgvWlkiZx5WpJCsnKbfR/8jVbjjDdk8yydlNefGEmbOMNE
         vVsAPepFKODp/MRwtMb+RKJifoMkotDaOw2pYKr8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190429120601eucas1p280b051a146dba355c9066cdfec6c4b94~Z8HvlO0em3036430364eucas1p27;
        Mon, 29 Apr 2019 12:06:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.E2.04298.8A8E6CC5; Mon, 29
        Apr 2019 13:06:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190429120600eucas1p25ac06a4e91280c63d0b4baf6f481c01b~Z8Huz4oUe2905229052eucas1p2v;
        Mon, 29 Apr 2019 12:06:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190429120600eusmtrp1e296db905c3daaa1f5f4d8891b0f166d~Z8HuzICTx2909529095eusmtrp1K;
        Mon, 29 Apr 2019 12:06:00 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-d5-5cc6e8a8d90c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 63.EA.04146.8A8E6CC5; Mon, 29
        Apr 2019 13:06:00 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190429120559eusmtip1c65bf3191c2b5e37b9421ebdf5f7eb47~Z8HuBK6dC1245012450eusmtip1k;
        Mon, 29 Apr 2019 12:05:59 +0000 (GMT)
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <68bf0a3f-6fb4-979d-bfdc-fdab930248f1@partner.samsung.com>
Date:   Mon, 29 Apr 2019 14:05:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425195338.GB31128@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe95nnuejmvfrugzDN3WVCZsbF8/59faM//wD0tpOnqWH92V
        eyo/Mjs/8rNfujlcmh8bbqd2p07qhizpKJwkEgm1sUi4UEJ6PGf67/V5f96fX9uHozSfmLHc
        RkO6YDToUrRKFV1R1/9gqu1d3ZrpfU9mkcsnHAx52vuWIadrHzDk0ucORMz1xQpy74ie5He8
        p4jX62TJ/T0fWNLkPqUkvtxaRE54byhIaW0bS57vtinJ4LVKltz6cIAh1Y+XkecDgeTbnTdo
        YTD/7WshzReZGmm+ytrG8mX2Q0o+d+9HJZ/nsiO+vCGL95VNWMHFqeYlCSkbMwXjtAWJqg3Z
        7iN0Wg+1re1mDzKhHOowCuAAz4Tqj4XMYaTiNNiGwNX32x/0IsjLc7Jy4ENgvnYM/SvpHCxD
        cuIigvLmPoUcdCOoePWSlVzBOB668h4zEofgMBjYb/nbl8LXKfB1vh4q5zgljoZK+xbJo8Yx
        YHGblRLTOBx+OC1/+4zGsdBe52RkTxDcPdlJS6UBeAoUNM+XZAqHQmvnaYXME+Fq9ylKGgW4
        mIN9VS3+rZdCv+cZK3MwdHlcfh4PDeYcWmYRTLln/f6d0JFf7PfMhVueRkaaS+FIcLinyfIi
        aK2zKSUZcCC0dAfJKwRCYcVxSpbVcHC/RnZHgCvnoULmMXCxxMIWIK112F3WYcdYhx1j/T/3
        DKLtKFTIEPXJgjjDIGyNFnV6McOQHL0+VV+Ghv6w4bfnSyX6+mhdDcIc0o5ST+q6vUbD6DLF
        7foaBBylDVHzniFJnaTbvkMwpq41ZqQIYg0ax9HaUHXWiFfxGpysSxc2C0KaYPyXVXABY02o
        PDbWUfSlOapluvPc+eMWc8iPqp6gmMX2wVU36g9lzTYk74mYEpa+d2TFT29T4kuFbxQbHvnd
        WPpsbnf2ZKiNyzl6tyThWLZLld9+we1N3DFnFzuwzfuw6Yo7fvWvk2mKhYH1L7KXRJhWOl73
        V+9rTRgccDb0zsHpm2y58xmzY3mNlhY36GZEUUZR9wcr8XWQgwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzo7S4jQ1XxTMTkSgeGxettdSET/IIQwEIyMNG3qYknO6
        s4kXCivL1DRTEp2afolkYvNGmpi3vF/xlpUolKLmlVhJZmhbK/Dbj+f///HwwENikiyhExmf
        qOU0iYoEmrDFRw4GFjxq1vqjzheUiVFDqVGI5r6vClFV77gQ1X5bAqh4uFKARvNU6MnSBoYm
        JupFaOzepghNt1UQyJTfC1DpRIcA1fUuiND83RoCHba3itC7zWwh6py5hOb3j6PdwS8gyI7d
        /VGEs+WZkzj7Rr8gYhsNOQSbf3+bYAuaDYBtGslgTY0uYeR1xl+j1mk51zg1rw2gI6XIi5H6
        IcbLx4+RestvXPDypT0D/WO5hPgUTuMZeJOJe9CWhyftYKkLXTsgEzzGcoENCSkfuHzYCHKB
        LSmhXgC4XZuNW4OTsKijRWRlO/j7fS5hLW0AaPowDCyBHRUJ1wtmhBa2p07D/YclQksJo95i
        0NhW+c/IFMD2oTlzQpIExcBWQ7JFEFMhsKStmLAwTp2Fv+pL/m5zoK7B0Z0a3No5AYfKlnGL
        akO5w8LZAMsYo2TwedNnzMqO8NNylcDKp2DLVgVWCCT6I7b+iKI/ouiPKNUANwB7TserlCpe
        yvAKFa9LVDIxalUjMH/A6/69plYw1RDeAygS0MfErut9URKhIoVPU/UASGK0vZgdMI/EsYq0
        dE6jjtboEji+B/iab3uKOTnEqM3/lKiNlvpK5chPKveWe8sQ7Sh+RHVHSSilQsvd4rgkTvPf
        E5A2TpngGW28UoWVxrhFhM4sVtcZQ2V1PcVTPnx4+djtpXNny/qGxpirLyM2D0zKMzNwTzWJ
        VkxbzfGDd5zHXSbCguboSA9ZZ2rJz4/y4IAM51fR3TbpcmXW3GJX31rIyvSQLhjGiKeSLwey
        RNOkW4777NfiCNlqetCs6eJG70i7oZvG+TiF1A3T8Io/4IREGhcDAAA=
X-CMS-MailID: 20190429120600eucas1p25ac06a4e91280c63d0b4baf6f481c01b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
        <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
        <20190425195338.GB31128@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/25/19 9:53 PM, Rob Herring wrote:
> On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
>> The device tree bindings for LPDDR3 SDRAM memories.
> 
> Also, 'dt-bindings: ddr: ' for the subject. You've got a mixture of
> subjects with no consistency.
Right, I will change it.
> 
>>
>> For specifying the AC timing parameters of the memory device
>> the 'lpddr3' binding uses binding 'lpddr2-timings'.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> 
> 
