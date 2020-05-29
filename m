Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F221E7581
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 07:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgE2FpL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 01:45:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53496 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2FpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 01:45:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200529054508euoutp028e5a66d548050c4bd2a546f113ec8cd1~TaYPVRtdn2842028420euoutp02P
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 05:45:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200529054508euoutp028e5a66d548050c4bd2a546f113ec8cd1~TaYPVRtdn2842028420euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590731108;
        bh=PhYV4Ig7hxvvmf0mdrqx6bcTuMgVhMvwyNQLnIx936w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pk00bMCqaMz41c8y4EMFkOLaDj661V0DtzYjz31GCg2a/wTA6WnLVdcPYMSfexXF8
         K5a/Alzdf+q9SdTz1R6Z4oI0lm3uQ1TUstKVaaGqlxS59s6i6XQVnsCC/A0sYiLRom
         QLRbNq4odB+dG4+wSK9Itwy2okluOjtYHAcOjdhc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200529054507eucas1p2bfa9e6bd17d79b2ad655cf9692828634~TaYO7KLFs2876028760eucas1p2R;
        Fri, 29 May 2020 05:45:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3B.38.60698.361A0DE5; Fri, 29
        May 2020 06:45:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200529054507eucas1p25ab3a5fe0f76e766738143b46b2c6e87~TaYOcteCM0802308023eucas1p2v;
        Fri, 29 May 2020 05:45:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529054507eusmtrp1fd3b41be09d8c35f3d9b9148147bf8be~TaYOb6-tf0887308873eusmtrp1R;
        Fri, 29 May 2020 05:45:07 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-95-5ed0a163fbf0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.FF.07950.361A0DE5; Fri, 29
        May 2020 06:45:07 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200529054506eusmtip212b23ce8c28928465fcd087af254baf0~TaYNqnhVK2563425634eusmtip2K;
        Fri, 29 May 2020 05:45:06 +0000 (GMT)
Subject: Re: [PATCH] regulator: do not balance regulators without
 constraints
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <56e496bc-172f-d62f-5376-c8d734af6a51@samsung.com>
Date:   Fri, 29 May 2020 07:45:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528134338.GD3606@sirena.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2znbjquN41R8UStYJBSmLfvxWWJ3ONSPCqIi8LLq5KRpspOW
        /SjNTJM17UZzaloSmem8YKnDJDVctdpKU8tLJRmWuG66pVmS2+niv+d5n+f53gsfRcjfCwOo
        hKQjrDZJpVGIJOTdjinb8v3XnsWsyHQpca2hWogvDw2LcO/EiBDf/voOYbu9RozfFr8SYNeL
        HAHuMheJ8Pi5Bwgb7C0CPDb5VID7r3aR+Im1U4hnempJnPPAReBaJ7OOZpqMg2KmruKsiBno
        aRYxeb9WMPXd2SSjr69AjOVlg4AZr1u4ndoriTzAahJSWW1YVJxE3fvlkzj55rxj5nJ1Oir1
        ykUUBfQqMDnVuUhCyelyBOXPuwU8mUBQWWQieTKOoL/yzazi5Uk4Szr+CDcRPMq0Ejz5jMCR
        8U3sdvnQ22DolgG5sS+9GLq/3/MkCLqChKr8G0K3IKKVkOvIFbmxlI6CFwaHpwVJL4HnzVme
        h/zoaNC9GSV4jzc8Khgm3diLXgm/bk96PAS9CBocRQSP/aFvuMSzBNBZFOgbBxE/9ybQ9w4K
        eewDo5Z6MY+DwHpRR/KBTARDtioxT3QIuk4Z/qTXwIDth8h9M4JeCtXmML68HqbPZgn5U8rg
        pcObH0IGF+5eIfiyFHLOyHl3MBgtpn9tW591EvlIYZyzmnHOOsY56xj/9y1FZAXyZ1O4xHiW
        C09ij4ZyqkQuJSk+dP/hxDo0+/msMxZnI2r5ua8N0RRSzJfWFNhj5EJVKpeW2IaAIhS+0g1P
        rTFy6QFV2nFWezhWm6JhuTYUSJEKf2n49Y/RcjpedYQ9xLLJrPavKqC8AtJRwYnXEdNNUZam
        ntVpeXZZtr6PK/HdvOq9sT9kRLxg6+Wgg3fCdAk7L8lm2scu7SY1I2qQMUfx6uC1gkb/8zur
        1staQjcOyO4rH5ftKzG1R7TbzX47NHu2hBBBHS6TeldxYSuW1yZnRILt9EO/D4WBZWzgycfV
        fd7jcbH5o1OcguTUKuUyQsupfgOtJGNveAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7rJCy/EGWyaK2qxccZ6VoupD5+w
        WVz/8pzVYvXHx4wW589vYLd4MPcmk8W3Kx1MFpd3zWGz+Nx7hNFixvl9TBZvfpxlsrg97zKL
        xZnTl1gt/l3byGLRceQbs8XGrx4OAh47Z91l99i0qpPN4861PWwe/X8NPLZcbWfx6NuyitHj
        +I3tTB6fN8kFcETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
        pRbp2yXoZVz/8I69YDl3xa4VGQ2MCzi7GDk5JARMJL7OP8bSxcjFISSwlFHi8MZ+doiEjMTJ
        aQ2sELawxJ9rXWwQRW8ZJdrWdTKDJIQFfCUaVzwBaxARUJa4+n0v2CRmgTUsEo0H70J17GSU
        6N2wkg2kik3AUKLrbReYzStgJ3FlxlsmEJtFQFXi4p5WsEmiArES3Yt/sEPUCEqcnPmEBcTm
        FDCS+LsaIs4sYCYxb/NDZghbXmL72zlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiS
        Wlqcm55bbKRXnJhbXJqXrpecn7uJERjr24793LKDsetd8CFGAQ5GJR7eDTPPxwmxJpYVV+Ye
        YpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBaSivJN7Q1NDcwtLQ3Njc
        2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANj7sSQcy2ZWu83zQ85UbL8e9/6tsvr2v/r
        JG9fu1qBhyVZPu1X7m6mr49EDosGnJhcJjF1w11B19+KUmeZcreEzO6oslo91e786YOqW5we
        bdROfv51l1WhLfuH7mfhO5/IbF8XvHanmqVh6xWhW8pHVRtd62rKOK3WFW/ufOx6waL0xqat
        p3euUWIpzkg01GIuKk4EAHc2PxoLAwAA
X-CMS-MailID: 20200529054507eucas1p25ab3a5fe0f76e766738143b46b2c6e87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba
References: <CGME20200528131144eucas1p121b9151996fa3f780a5028f68c69d5ba@eucas1p1.samsung.com>
        <20200528131130.17984-1-m.szyprowski@samsung.com>
        <20200528134338.GD3606@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

On 28.05.2020 15:43, Mark Brown wrote:
> On Thu, May 28, 2020 at 03:11:30PM +0200, Marek Szyprowski wrote:
>> Balancing coupled regulators must wait until the clients for all of the
>> coupled regualtors set their constraints, otherwise the balancing code
>> might change the voltage of the not-yet-constrained regulator to the
>> value below the bootloader-configured operation point, what might cause a
>> system crash.
> This forces every supply to have something which explicitly manages
> voltages which means that if one of the coupled supplies doesn't really
> care about the voltage (perhaps doesn't even have any explicit
> consumers) and just needs to be within a certain range of another supply
> then it'll end up restricting things needlessly.
Frankly, that's exactly what we need for Exynos5422 case. If devfreq 
driver is not enabled/compiled, we want to keep the "vdd_int" volatage 
unchanged. This confirms me that we really need to have a custom coupler 
for Exynos5422 case. It will solve such issues without adding hacks to 
regulator core.
> Saravana was trying to do some stuff with sync_state() which might be
> interesting here although I have concerns with that approach too:
>
>     https://lore.kernel.org/lkml/20200527074057.246606-1-saravanak@google.com/

This still doesn't solve the above mentioned case.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

