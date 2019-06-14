Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B51945CFB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfFNMiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 08:38:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50555 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfFNMiL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 08:38:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190614123810euoutp020b3e4736d93c68b5d9cbcdc3d56ab9a9~oEO8o-aTh0745707457euoutp02b
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 12:38:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190614123810euoutp020b3e4736d93c68b5d9cbcdc3d56ab9a9~oEO8o-aTh0745707457euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560515890;
        bh=j9U7/xfbzG3tH4otaa2XZGd/3eo3lkUCRocvGFiU7kc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TzBaIpEcxX3EBmGPQb+JgCAR5l4g1jEBVcxv6zkc2aIi9tr9wji24ZURRMg/+MryX
         XOV09msG3OTynGBRYXOuReDVOJod5ToK9LkyiiaKjFBsj70lJHHuQaV818y0PNA+V/
         rhdeEnkYEqtZj5Q2NTpq3IjcdTcRsQFaTeryb4fE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614123809eucas1p260bd0cce22618c5edbfede1068af4da3~oEO7orhTa0107701077eucas1p2q;
        Fri, 14 Jun 2019 12:38:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 80.66.04325.035930D5; Fri, 14
        Jun 2019 13:38:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614123808eucas1p2f53cbbe210ea8c0105f0800cbabccbed~oEO6lXyex3177231772eucas1p2o;
        Fri, 14 Jun 2019 12:38:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190614123807eusmtrp1cfa3cfd99ca8d0ff66be8bdb57405b28~oEO6VBfqN1310613106eusmtrp1L;
        Fri, 14 Jun 2019 12:38:07 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-57-5d039530a89c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.64.04146.F25930D5; Fri, 14
        Jun 2019 13:38:07 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190614123806eusmtip18a4aea36406a8dc951b9ed4ce6568ad1~oEO5ekFGu1928019280eusmtip1e;
        Fri, 14 Jun 2019 12:38:06 +0000 (GMT)
Subject: Re: [PATCH v10 01/13] clk: samsung: add needed IDs for DMC clocks
 in Exynos5420
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, mturquette@baylibre.com,
        sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <cbfa8fab-7cd0-1508-7b9b-482fefdb4de3@samsung.com>
Date:   Fri, 14 Jun 2019 14:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeeVhHS62jiUgwySf5EYzW2Rkvu=HxyA7NjpGZFp=fWYQ@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRz2vfdnce3rRJ+lsd0wGdH440sYW+xls/GHrbHGW14p3cW9orTp
        1BjX9WN+5tRpYnKHdFmUVpPT4arTWFKjwmYozTpnOpPuXj/673mez/PZ53m2D09pitlIPlV/
        QDLoxXQtG0rXtf7oWLTkLJW4pNEaS2pKqxny0vuBIZecHQyxf32HSH5lNUtOPy1XkbYCHSl+
        95kiHs9tjrTnDXKkxxhFvprfMOR5QxlLRgqdiJR6mlTkpvM1RzqfriO9R6tY8qurhibNLzaS
        Xn8Y8T1+i9bMEHzfTtHCcPcxTrho7KSFestrTnDYTrJCc/kNTijM/8IKD740qoSiOzYk1Lpz
        hBHHrM2Tt4Wu3CWlpx6UDItX7wzdM1zWSu37zmTZaj9TRjRAm1AID3gZfK/xcCYUymtwFYIn
        bj+tEC+C3q5nSCEj46Su59/Kxf4uRhlcQ1D8YJBSyBCCWx/dQdc0vA0qG/q4AA7HW6HVe5MN
        mCjsp2HgUT4KDFgcC4WPioJYjVdD25lWNoBpPBc+mM3B5ek4Abz1jj+eqfDkwvvxAzwfgreA
        ryotIFM4AvK81xkFz4a7Q2XBQIDbeHB6fawSOx56ugopBU+DT647nIKjwH3aTCsL+QjM93s5
        hZQg6HNVIMUVBw9dnUzgMoWjobphsSKvhcYWazAQ4DDoHpqqhAiDU3XnKUVWw4njGsU9B/y2
        8yoFR0LB+zG6BGktE5pZJtSxTKhj+X+3AtE2FCFlyroUSV6qlw7FyKJOztSnxCRn6Bxo/E3d
        v1zf7qGmn0ktCPNIO0VdWkQlahjxoJyta0HAU9pwtTVuXFLvErMPS4aMHYbMdEluQTN5Whuh
        zpnUv12DU8QD0l5J2icZ/k5VfEikES3sePYqa9NItt5gunLfmktWVsw/afUMZyQ9rAXfDH97
        2qhp0qaagW7Iai/w5Jqi+5wrIuzhG5ryHLvFQXVj/cyrycti7KNjGkOivd+/e3/8q/X2y+3N
        UUlx+piSeHXu8o1yefFVfMQ4uir1xvr+F/MWueLlc2ni4YSEsZzJ891aWt4jxi6gDLL4Gy9Y
        T+2iAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xu7r6U5ljDaZ16VhsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLS6ecrW43biCzeLftY0sFvuveFnc/s1n8e3EI0YHMY9vXyex
        eLy/0cruMbvhIovHzll32T02repk89g/dw27R2/zOzaPg+/2MHn0bVnF6LH5dLXH501yAdxR
        ejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnv5xxj
        LvjOWrFq82vmBsaHLF2MnBwSAiYSsx9cY+1i5OIQEljKKHHhzHmmLkYOoISUxPwWJYgaYYk/
        17rYIGpeM0qs/XoCrFlYIEriz+9GdhBbRCBU4tPkUywgRcwCf1kkNu/4ywySEBKYwCSxb7MP
        iM0mYCjRe7SPEcTmFbCTODPlGBuIzSKgKvG8pwdskKhAhMTsXQ0sEDWCEidnPmEBOYhTIFDi
        24oskDCzgLrEn3mXmCFscYmmLytZIWx5ie1v5zBPYBSahaR7FpKWWUhaZiFpWcDIsopRJLW0
        ODc9t9hQrzgxt7g0L10vOT93EyMwcWw79nPzDsZLG4MPMQpwMCrx8M7oY44VYk0sK67MPcQo
        wcGsJMI7zxooxJuSWFmVWpQfX1Sak1p8iNEU6LeJzFKiyfnApJZXEm9oamhuYWlobmxubGah
        JM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHRZxv7p/n/Ky3rOeZ9U1p53r1FUV3d6P2CfwXC
        Pg8Zp2z4eHJCUKCwzvTGJXt2PA0qrTDYxSOcuE3crSZ83eqltUtmzZDavH51Qeza2yyHfFl5
        Ly5dzBueYvw9ffKpzW1Ldqt+zUhwapFd7nSh7cjKM8dstZl3qXzhsn/yZmrDVc1PpZwSjvoB
        SizFGYmGWsxFxYkAOjK39jIDAAA=
X-CMS-MailID: 20190614123808eucas1p2f53cbbe210ea8c0105f0800cbabccbed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538
References: <CGME20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538@eucas1p2.samsung.com>
        <20190614095309.24100-1-l.luba@partner.samsung.com>
        <20190614095309.24100-2-l.luba@partner.samsung.com>
        <CAJKOXPeeVhHS62jiUgwySf5EYzW2Rkvu=HxyA7NjpGZFp=fWYQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/14/19 14:04, Krzysztof Kozlowski wrote:
> I do not quite understand why this patch is still being resent instead
> of have been applied some time ago. Are there any issues here? Or are
> there any issues with the entire patchset (except some review comments
> to be resolved)? If not, then this is a dependency which should go
> regardless of other patches. There is no point to keep it pending...
> All other changes, e.g. DTS will have to wait for more cycles till
> this gets in.
> 
> Therefore either please apply this or please comment what is stopping
> dependencies from being applied.

Indeed the first 3 (clk) patches should not be part of the series any more,
I have applied them few days ago - https://lkml.org/lkml/2019/6/6/554
