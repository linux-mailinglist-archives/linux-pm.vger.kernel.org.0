Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB86772C1D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfGXKJK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 06:09:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58998 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfGXKJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 06:09:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190724100907euoutp01e1fc6421cb7f5933382ed2771b75b6b7~0UAPUYTzP2200722007euoutp01X
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 10:09:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190724100907euoutp01e1fc6421cb7f5933382ed2771b75b6b7~0UAPUYTzP2200722007euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563962948;
        bh=XetWQSqaXs6nRe3zf5etzeWMxZUCaNusJKBqu7npMnU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hhLM2iJQPxFgojXY5kmm8dcM6yh+SMiJhK5fz3yF5sksiJEyxLbT+QqAcL6zdcNoz
         4fp7cNdqd9cEtKCavVw6kPQdARRzbXlR/OvGH2nB3dKa1mUtQ6KTOjC8yeR0mA2Ol0
         +xTB0NumOq2xZOAjf1pOG4L/W3VcZpx6GuIVletA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190724100907eucas1p29ef5c6bfbe6f34cc2b5508c641f07a0e~0UAOj5ott2173521735eucas1p2Z;
        Wed, 24 Jul 2019 10:09:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 78.51.04325.24E283D5; Wed, 24
        Jul 2019 11:09:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190724100906eucas1p27521c0ef99eda8954fb6462f1a3c40cb~0UANyeGHq1967719677eucas1p2N;
        Wed, 24 Jul 2019 10:09:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190724100906eusmtrp21c36cade0f3a6312c1cb5944314ec5cf~0UANkMPD91736717367eusmtrp2H;
        Wed, 24 Jul 2019 10:09:06 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-da-5d382e42ee22
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9A.57.04146.14E283D5; Wed, 24
        Jul 2019 11:09:06 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190724100905eusmtip2dd6151f7506f21dbce67219eaad087da~0UAMxAXXg0828408284eusmtip2c;
        Wed, 24 Jul 2019 10:09:05 +0000 (GMT)
Subject: Re: [PATCH v4 5/5] DT: arm: exynos4412: add event data type which
 is monitored
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <694617ed-5c02-40cc-2f27-82e8bb0ac6fe@partner.samsung.com>
Date:   Wed, 24 Jul 2019 12:09:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190723175853.GA29195@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7pOehaxBpteG1tsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZLb6deMToIOCxZt4aRo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWw
        RXHZpKTmZJalFunbJXBltC+ZwFawgq3i1rFTzA2MzaxdjJwcEgImEqtWT2DqYuTiEBJYwSjR
        t34VM4TzhVFi/+rlbBDOZ0aJoz83MMO07N9+mh3EFhJYzijRfE4Hwn7LKPGqhR/EFhaIlHh/
        bz1YjYiApsT1v99ZQQYxC8xilrh2fRaQw8HBJqAnsWNVIYjJK+AmseewCojJIqAqsX65M0in
        qECExOUtuxhBbF4BQYmTM5+wgNicAvoSC///A7OZBcQlbj2ZzwRhy0tsfzsH7H4JgUYOifkz
        TzFCnOwicW5tKxOELSzx6vgWdghbRuL/zvlQ8WKJht6FUPU1Eo/750LVWEscPn4R7GJmoFfW
        79KHCDtK7N2/nwkkLCHAJ3HjrSDECXwSk7ZNZ4YI80p0tAlBVGtIbOm5ALVITGL5mmnsExiV
        ZiF5bBaSZ2YheWYWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxApPb6X/Hv+5g
        3Pcn6RCjAAejEg9vBZN5rBBrYllxZe4hRgkOZiUR3sAGs1gh3pTEyqrUovz4otKc1OJDjNIc
        LErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjPrbvqiZpkhtWqZkW5Sz9WmC2MRwc82y516n
        fzUvibngNrOwKlWreGt6XuK9Nh+RGwfv+Qaurv9v6vHZqr708sEHWWpXzkr4LHCwmblmrmaC
        /ucLcpdrKiM2+fc2MRteUrug7rfyaJ3i28jw4zIhh7dvaS1LWazaNv1991Tht7NenK+SNZLo
        UmIpzkg01GIuKk4EAN4fLctqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xe7pOehaxBvvOMlpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZLb6deMToIOCxZt4aRo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWw
        RenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehltC+Z
        wFawgq3i1rFTzA2MzaxdjJwcEgImEvu3n2bvYuTiEBJYyijxuv8OG0RCTGLSvu3sELawxJ9r
        XWwQRa8ZJU48XwuU4OAQFoiUOHkgE6RGREBT4vrf76wgNcwCs5glVh48wATR8I5R4tnq6cwg
        DWwCehI7VhWCmLwCbhJ7DquAmCwCqhLrlzuDjBEViJDoa5sNdgKvgKDEyZlPWEBsTgF9iYX/
        /4HZzAJmEvM2P2SGsMUlbj2ZzwRhy0tsfzuHeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW5
        6bnFhnrFibnFpXnpesn5uZsYgTG97djPzTsYL20MPsQowMGoxMNbwWQeK8SaWFZcmXuIUYKD
        WUmEN7DBLFaINyWxsiq1KD++qDQntfgQoynQbxOZpUST84HpJq8k3tDU0NzC0tDc2NzYzEJJ
        nLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6OOtYbRg8gtrc/zv15umr5x5Zak1DaOt/ahW869
        PnTtf8PffJW4e9vrok+b1exk3cK1TZNrZU79dUXm7v2ya0RvWijHTRKQlnv5bE1Qt9eX28+W
        T204NnfzyiN2fA0Nxo4valyF/v7x1WRnqlrOMult17rqniMnNvJY1dfvfPlPZC233TSOyweU
        WIozEg21mIuKEwHH8dNt/wIAAA==
X-CMS-MailID: 20190724100906eucas1p27521c0ef99eda8954fb6462f1a3c40cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0
References: <20190605091236.24263-1-l.luba@partner.samsung.com>
        <CGME20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0@eucas1p1.samsung.com>
        <20190605091236.24263-6-l.luba@partner.samsung.com>
        <20190723175853.GA29195@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 7/23/19 7:58 PM, Krzysztof Kozlowski wrote:
> On Wed, Jun 05, 2019 at 11:12:36AM +0200, Lukasz Luba wrote:
>> The patch adds new field in the PPMU event which shows explicitly
>> what kind of data the event is monitoring. It is possible to change it
>> using defined values in exynos_ppmu.h file.
>>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
> 
> I tried to apply this... but prerequisites were not merged into
> v5.3-rc1. This one will have to wait then till next release.
Indeed, I will ask Chanwoo for ack for patch 4/5.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
> 
