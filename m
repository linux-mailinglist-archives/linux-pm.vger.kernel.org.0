Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7F20D1B0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgF2SnF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 14:43:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41815 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgF2Smz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 14:42:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200629113600euoutp02f8ded135dc213cfbf2d5a0045d044d0a~dAKcVKHg22853028530euoutp02F
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 11:36:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200629113600euoutp02f8ded135dc213cfbf2d5a0045d044d0a~dAKcVKHg22853028530euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593430560;
        bh=mR3af4GsplzakCJ2RD7YyC8Nx2Q/97Z1bArASLzxswE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cdV3yvRJQshxigRPmiJuFJc99uUwYLEp0LlEiK2jshABfhCZQelR+e3cOWnnYkK5v
         OBqiSCdujI1UKUaqsq3OlPvhWklgW+/rpFPp4rVBOUCP4Q2r3FrnAQTXdGU2/biZYP
         xrd1Gjw/Y9oYpYdwgdFHsw80OJ//30rrlwadn8y4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200629113600eucas1p2b7290c9e2481bb5a9b1360930d39d26e~dAKby_ANu3155231552eucas1p2B;
        Mon, 29 Jun 2020 11:36:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3F.9A.06318.F12D9FE5; Mon, 29
        Jun 2020 12:36:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200629113559eucas1p1a1854e3bb9cc4e8bb85df0293d3fe5a2~dAKbaGY9t2307423074eucas1p1K;
        Mon, 29 Jun 2020 11:35:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200629113559eusmtrp19f0cd42a20299bc2fcf8630e8d4ef8e7~dAKbZWVxl1367113671eusmtrp1K;
        Mon, 29 Jun 2020 11:35:59 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-47-5ef9d21f47f4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.21.06314.F12D9FE5; Mon, 29
        Jun 2020 12:35:59 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200629113559eusmtip11c749750d969d672ca72195897c607a2~dAKa8K3AM2840128401eusmtip1H;
        Mon, 29 Jun 2020 11:35:59 +0000 (GMT)
Subject: Re: [PATCH 3/4] ARM: exynos_defconfig: Enable big.LITTLE cpuidle
 driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <3d607023-ee15-cfe8-4004-738a3ec8b30f@samsung.com>
Date:   Mon, 29 Jun 2020 13:35:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622172026.GC4174@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7oKl37GGSw/zGixccZ6Vot5n2Ut
        zp/fwG6x6fE1VovPvUcYLWac38dk8eb3C3aLhU0t7A4cHmvmrWH02LSqk83jzrU9bB6bl9R7
        9G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8bdxfsYC9ayVnyf+oe1gXE5SxcjJ4eEgInEmUW7
        mbsYuTiEBFYwSrQe+8UE4XxhlLi1aiEbSJWQwGdGiZVN4TAdq88fZYMoWs4o8W7RD6iO94wS
        M57MBJsrLBAkcfzxXbBuEQFNiet/v7OCFDELLGSSODZpKRNIgk3AUKLrbRdYEa+AnUT7zh9A
        RRwcLAKqEs2dBiBhUYFYib6lC6BKBCVOznwCNp9TQE/i6e3JYDazgLzE9rdzmCFscYlbT+aD
        HSQhsI9d4lTHaXaQmRICLhJrl+VCfCAs8er4FnYIW0bi9OQeFoj6ZkaJh+fWskM4PYwSl5tm
        MEJUWUvcOfeLDWQQM9A363fpQ4QdJdZ13mOFmM8nceOtIMQNfBKTtk1nhgjzSnS0CUFUq0nM
        Or4Obu3BC5eYJzAqzULy2Swk38xC8s0shL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn
        525iBKak0/+Of93BuO9P0iFGAQ5GJR7ehHM/44RYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA6M687ZryzmlmiRvqth9
        +/nYd9HTfh4fzRM/mQ/zRizw0edafr5TbGO7GLfvt61+fX7bUvaki8UK+neXKl9eFM3BLME5
        2aDD8NJdw4uKwrf4l9xIut+mND/P3n3J7OknP3G47z+adOZRRuikhAmnw9av2fxz13VH57nL
        c5dO/7D/H1vL5qk681cqsRRnJBpqMRcVJwIAU84OQUUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7ryl37GGSy6rWuxccZ6Vot5n2Ut
        zp/fwG6x6fE1VovPvUcYLWac38dk8eb3C3aLhU0t7A4cHmvmrWH02LSqk83jzrU9bB6bl9R7
        9G1ZxejxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsbdxfsYC9ayVnyf+oe1gXE5SxcjJ4eEgInE6vNH2boYuTiEBJYySpx5NIMZIiEj
        cXJaAyuELSzx51oXVNFbRom5K94wgiSEBYIkjj++ywZiiwhoSlz/+50VpIhZYCGTxPPfX8CK
        hAReMkrMPyoGYrMJGEp0ve0Ca+AVsJNo3/kDqIGDg0VAVaK50wAkLCoQK/Ht3haoEkGJkzOf
        gF3KKaAn8fT2ZDCbWcBMYt7mh8wQtrzE9rdzoGxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDI
        sopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwCrcd+7l5B+OljcGHGAU4GJV4eBPO/YwTYk0s
        K67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6DfJjJLiSbnAxNEXkm8oamhuYWl
        obmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxk4V57Jelb0qNlMCPl688aKyVuCk
        zM3jO57rqW2xOz/vmYHJ4YzH3Uoppsl8HrNnThFZtsHl2s8f+WIrdGIWzlEsX7BeKLnk3qLj
        T10Dtaao6AoHnBLOryooe+HzprTvi7a0YP519fN56rO7XtbPj+Cb8UhLIv1FPtMkcQc+liu9
        ASyT2v4vV2Ipzkg01GIuKk4EABaJnFrYAgAA
X-CMS-MailID: 20200629113559eucas1p1a1854e3bb9cc4e8bb85df0293d3fe5a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081250eucas1p2de7110898dad050866d78cb5d5120422
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081250eucas1p2de7110898dad050866d78cb5d5120422
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CGME20200616081250eucas1p2de7110898dad050866d78cb5d5120422@eucas1p2.samsung.com>
        <20200616081230.31198-4-m.szyprowski@samsung.com>
        <20200622172026.GC4174@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22.06.2020 19:20, Krzysztof Kozlowski wrote:
> On Tue, Jun 16, 2020 at 10:12:29AM +0200, Marek Szyprowski wrote:
>> Enable big.LITTLE cpuidle driver, which can be used on Exynos-based
>> Peach Pit/Pi Chromebooks.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm/configs/exynos_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
> I guess this should be enabled after adjusting the compatibles
> in patch 2/4? If yes, then it will have to wait.

Indeed, this one and multi_v7 patch have to wait one cycle to avoid 
breaking Odroid XU3/XU4 board family.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

