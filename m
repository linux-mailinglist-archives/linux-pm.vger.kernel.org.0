Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8CDBE0C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfJRHMB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 03:12:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45445 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbfJRHMB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 03:12:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191018071158euoutp0130905901a3db8ecac43476fe17d246ae~OrEHhFA6U2494124941euoutp01E
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 07:11:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191018071158euoutp0130905901a3db8ecac43476fe17d246ae~OrEHhFA6U2494124941euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571382718;
        bh=/b+UtEDzqIRy6CN2PZOjcj8YUjV1F/6jvH4ZCUASKwQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CkyYl2n2M+rMDRP/d/kPhsf5OJI7YdicMcRVpvMpNv+QMgrdQFCfWdKtWdaAm9kQP
         BYifBme/C7N5wNk8ucTlmPV3QzC5qyWznE3ndq2V46gD9UVBLaN2khDUB7G4K1hahA
         ycnFLc1R0ZKj95+N6uaQoWmQzAh4YLDHaqHjXrpE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191018071158eucas1p1b4360baf515416e1769aa7c27d3c2e17~OrEHNxF4h3269432694eucas1p1Y;
        Fri, 18 Oct 2019 07:11:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8B.D4.04469.EB569AD5; Fri, 18
        Oct 2019 08:11:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191018071158eucas1p122811d8eafc3a26ec01c1402ad4fbd29~OrEGtj5PQ0537705377eucas1p1S;
        Fri, 18 Oct 2019 07:11:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191018071158eusmtrp151f87c2ded25646c165448642c0527fa~OrEGsxByD0657006570eusmtrp1k;
        Fri, 18 Oct 2019 07:11:58 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-c4-5da965bec4ee
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.36.04117.DB569AD5; Fri, 18
        Oct 2019 08:11:57 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191018071157eusmtip2c2847cd7dea4752f23fb6028350b0127~OrEGDvu8D0960909609eusmtip2W;
        Fri, 18 Oct 2019 07:11:57 +0000 (GMT)
Subject: Re: [PATCH] opp: core: Revert "add regulators enable and disable"
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <db377033-3d1d-f8c7-b0c0-5a7359022a62@samsung.com>
Date:   Fri, 18 Oct 2019 09:11:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018043026.xm7a6emczm6w7bck@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzHfe957rnH5exx2H1Go27Tlq2TxnrErNIfN2smWW3pyskzLD+u
        O0StzY/04yJGhstGNvkVOowjGZJL1hEjFEOqMbeGrKvVVXePyn/vz/v7+n4/7/f2JTHhc64L
        GZeYzCgT5fFigo+3D34z7Oth6mT7zW/EtLa0mUsXLywRdMPae0RXrpdy6ZGRxzx6vKucoDfy
        BhBdOtLDoVdNrzi0eVKL09pNKd06P0gctpN2amZ50pb624T03WQ3Ib3bVo+k+qkOjnSjxS2U
        OMMPiGbi41IZpVdgJD92wBymaCDTfmX+4GUgE6FGtiRQPlCUX81TIz4ppGoR5LSYcHb4gqC4
        YprDDhsIVu6PIzUirVd02mDWr0EwqNduQUYEc0+qrJAjFQw5qxKLdKI8YXmasSAYdQ+D9p/5
        mGU1QXmD2qi2xhBQgVA4VGn1ccoDarSTuEU7UzKYM+kxlnGAobIlq29L+UH+QCvHojHKHTqM
        5RirRTCzVGHNA9QiD3RZmxw29DHIrg5jKzvCir6Nx+qdMFyUi7N8NoIFQyOPHXIRjGeVIpby
        h2f611zLQxi1F5q7vFj7CDQVvMDY9+1hyujAZrCHwvaSLVsAt24IWXoPaPRN/9b2jY5hBUis
        2dZMs62NZlsbzf+9lQivRyImRZUQw6i8E5nLEpU8QZWSGCO5kJTQgv58rmGzfl2HNsei+hFF
        IrGdQBdaKxNy5amq9IR+BCQmdhKc9K+TCQXR8vQrjDLpvDIlnlH1I1cSF4sEV23mI4RUjDyZ
        ucgwCkb595RD2rpkIAeP9cLIiADZpYdlb5t2nbgpM3QdellyztXQ5xf33d435ENGXna3sFbk
        1rswdu1sxvRBY3Lm7HRQ6HGbEMOa39eJB/69BwbNVY3LrWN1p+74OJ/WhiuUK2mjqYum609X
        ojiuZCe5e+ZRmsTjqMI3MujThHTHx3DGP1CTWVLmXvV5SYyrYuXenphSJf8NGUtu8VgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7p7U1fGGmxusLbYOGM9q8XUh0/Y
        LFZ/fMxoseDTDFaL8+c3sFtc3jWHzeJz7xFGixnn9zFZvPlxlsni37WNLBYbv3pYbH5wjM2B
        x2PnrLvsHptWdbJ53Lm2h82jb8sqRo/jN7YzeXzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRn
        aGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXceRfUMFqjor/jX/YGxh/sHUxcnBICJhI
        7Njo1cXIxSEksJRR4uvnh+xdjJxAcRmJk9MaWCFsYYk/17rYIIpeM0rseriEGaRZWMBLovWN
        HogpIqAl8fJmKkgJs8A0ZonLPz+yQ9TvZ5TYtPEr2FA2AUOJrrcggzg5eAXsJCadXMAMYrMI
        qEos33iNBWSQqECsxKa9ZhAlghInZz5hAbE5BSwl+o9sZgKxmQXMJOZtfsgMYctLbH87B8oW
        l7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI3Xb
        sZ9bdjB2vQs+xCjAwajEw7sjYEWsEGtiWXFl7iFGCQ5mJRHeYOuVsUK8KYmVValF+fFFpTmp
        xYcYTYF+m8gsJZqcD0wieSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4
        OKUaGLsezt4udTvcv62+hu/d/rg1sfaBV87wV8eW719kbRfw9I4C86Il139pn3Xzap5xuMaY
        48/fezO+cnrUbZq05B1zHB9v7Ow9EZ4zHstOSb11rklF6FPSPc31G+a2m3a6hUvGMx1/ySi5
        tEjaxGn22p9TVkqbnwwR3LVyHt9kl/aLe3ITZl25pqzEUpyRaKjFXFScCACz7TtV6gIAAA==
X-CMS-MailID: 20191018071158eucas1p122811d8eafc3a26ec01c1402ad4fbd29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191017102843eucas1p164993b3644d006481fb041e36175eebe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191017102843eucas1p164993b3644d006481fb041e36175eebe
References: <CGME20191017102843eucas1p164993b3644d006481fb041e36175eebe@eucas1p1.samsung.com>
        <20191017102758.8104-1-m.szyprowski@samsung.com>
        <20191018043026.xm7a6emczm6w7bck@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 18.10.2019 06:30, Viresh Kumar wrote:
> On 17-10-19, 12:27, Marek Szyprowski wrote:
>> All the drivers, which use the OPP framework control regulators, which
>> are already enabled. Typically those regulators are also system critical,
>> due to providing power to CPU core or system buses. It turned out that
>> there are cases, where calling regulator_enable() on such boot-enabled
>> regulator has side-effects and might change its initial voltage due to
>> performing initial voltage balancing without all restrictions from the
>> consumers. Until this issue becomes finally solved in regulator core,
>> avoid calling regulator_enable()/disable() from the OPP framework.
>>
>> This reverts commit 7f93ff73f7c8c8bfa6be33bcc16470b0b44682aa.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> This is a follow-up from the following discussion:
>> https://lkml.org/lkml/2019/10/9/541
> I suppose this must go the v5.4-rcs, right ?

Yes, please.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

