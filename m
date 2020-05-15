Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6B1D493C
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEOJQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 05:16:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59356 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEOJQ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 05:16:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200515091625euoutp014e2f6ef8173e5ecef45fc9aa391d00ed~PKOt7U6Cp1581615816euoutp01u
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 09:16:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200515091625euoutp014e2f6ef8173e5ecef45fc9aa391d00ed~PKOt7U6Cp1581615816euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589534185;
        bh=Ie2EAXxlBaVO9eW+/38zLNexPrP9VRA8wVermRed4F4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=reqsbm6kf9xIJliJw7vsYI45QsJcOvgiQCoSlXHAkmkDfEP+Ta/QsCoCIZoiGtcYb
         QzY5uNOzFF+XhkMNdHa73qppkXGF6GlW/JYHh4nTjocdjNojeC7z9bS4MCwXr8JOa6
         2vQnGJMT54CeiBSExjUrvXxojX8kjnEqLnsEUZaw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200515091625eucas1p24fdb1d38e487a7abb396a6562e5b3a41~PKOtnxc423263732637eucas1p2U;
        Fri, 15 May 2020 09:16:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 90.AB.60698.8ED5EBE5; Fri, 15
        May 2020 10:16:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200515091624eucas1p1d7c1a75daa6096d78bfe34e63b1bb7b4~PKOtTbJ4a2803928039eucas1p1w;
        Fri, 15 May 2020 09:16:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200515091624eusmtrp211c61991d9c279978b0132a4c72c752b~PKOtSvbJ31201512015eusmtrp24;
        Fri, 15 May 2020 09:16:24 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-50-5ebe5de8958b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.6F.07950.8ED5EBE5; Fri, 15
        May 2020 10:16:24 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200515091624eusmtip133d56722f5ff177725146b609245e358~PKOss5iVn2529825298eusmtip1f;
        Fri, 15 May 2020 09:16:23 +0000 (GMT)
Subject: Re: [PATCH 0/2] opp: core: add regulators enable and disable
To:     Viresh Kumar <viresh.kumar@linaro.org>, k.konieczny@samsung.com,
        peron.clem@gmail.com, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, broonie@kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d9da5bc0-820d-59b9-a19a-32e5480313e9@samsung.com>
Date:   Fri, 15 May 2020 11:16:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1589528491.git.viresh.kumar@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRzf757nnnvQ8dxRvsO0rnVblJfpj0fKGG23/rDW+stGrjw7wrF7
        EP4ySlwUmsWxiFbcytsh563ImF1eorwlxSwkZTkvqSl3D+W/z/fz/Xx+n+9n+5GY2MB3ICOV
        8YxKKY+WEJZ4U8/PwZMLIR2hHq2PvemCmTmCLvtRyKdHWkoIejWnG9FfN/t59PsHIzj92jDM
        p7dH63A6s3sdo+vWZLTuUw/hZyXTaz4IZPXaLEI2NdpGyBre3cJldxq0SNY7/pwnW613viAI
        tjwTzkRHJjIqd98wy4jlvlkirpWfpH1YjqWiWlyNLEigTsH6mwlMjSxJMVWJ4FeOkc8NRgT3
        FjsJblhFUHl3jL9n6dms5HGLJwiMOVm7/u8IOl/0I5PKljoHE+lq81t2VDuCxVeNZgtGPUJQ
        MpTOM6kIyhPUy2rChIWUL6yurJjdOHUM5gfGBCZ8kAoBQ4UOcRoR9BXNmU+3oHxAU/zZzGPU
        YUhvLMY4bA+Tc6XmMKCmBaBt6CG4wwNha7xgt7ctfOltEHDYCf7o9wzpCGYGngm4IRvBSFoh
        4lQ+MDWwtfMSuRNxHGpa3DnaHwxVNwQmGihrGF8WcUdYQ37TfYyjhZCZIebUUtD0Vv+L7Rwa
        xnKRRLOvmmZfHc2+Opr/uWUI1yJ7JoGNUTCsl5K57sbKY9gEpcLtamxMPdr5Yobt3rVm1PH7
        SheiSCQ5IPQoaA8V8+WJbHJMFwISk9gJg2paQ8XCcHlyCqOKvaxKiGbYLuRI4hJ7oVf5YoiY
        UsjjmSiGiWNUe1seaeGQigKHyOnawoW3RY8OxX+8WWXFGlMuZlrrKpY885WF0Rl+rqXMN2lY
        cL/I8bzTRnOAjdJtLG2jw/upR7XNpRObpTbDs0tb+smza7dtpfM614CSoKgFkUurFOW2zUjo
        FOcwhbErTz+46ekYXzVsMX1aRyYdyctWvVTUJpdc80+ZPCrB2Qi5pwumYuV/ARhrHKdeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7ovYvfFGWzerWYx9eETNosFn2aw
        WlzeNYfN4nPvEUaLNz/OMlncnneZxeLM6UusFv+ubWSx6Djyjdli41cPi80PjrE5cHvsnHWX
        3WPTqk42jzvX9rB5bLnazuLRt2UVo8fxG9uZPD5vkgtgj9KzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeHvyEVvBbtaKVQsXMTcwbmDpYuTkkBAw
        kTj2YwVTFyMXh5DAUkaJO9eus0IkZCROTmuAsoUl/lzrYoMoessoceP9CrCEsICrxM3mLlaQ
        hIjAXkaJY5dms4A4zAJLGCU27rjBCtHSxyjx5Xs/WAubgKFE11uQWZwcvAJ2Ep8/fGAEsVkE
        VCWen7vODmKLCsRKrL7WyghRIyhxcuYTsGM5BawlZs1+BhZnFjCTmLf5ITOELS/RvHU2lC0u
        cevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG7bZj
        P7fsYOx6F3yIUYCDUYmH12Dq3jgh1sSy4srcQ4wSHMxKIrx+63fHCfGmJFZWpRblxxeV5qQW
        H2I0BXpuIrOUaHI+MKHklcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+Lg
        lGpgnOeruJ8xOl/8wodvln9tI+LXf7Nulvxcfsirs37vyRu9xed+Zk5Okn//ia338c9Liznc
        tkrU5v5ekHhk85yPKRGfYoVLgp3Ul7hv7yrccerFJv3ipeVr/61VY5qe+jdWQml/Y6nmQScP
        lxfXnSzMWG9pPdpQdlxNhmVtBK+S7euHe9S417zMVWIpzkg01GIuKk4EAJeFRxfwAgAA
X-CMS-MailID: 20200515091624eucas1p1d7c1a75daa6096d78bfe34e63b1bb7b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200515075745eucas1p2f14c7fcec7c3d190704ddc6f608b6ce9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200515075745eucas1p2f14c7fcec7c3d190704ddc6f608b6ce9
References: <CGME20200515075745eucas1p2f14c7fcec7c3d190704ddc6f608b6ce9@eucas1p2.samsung.com>
        <cover.1589528491.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 15.05.2020 09:57, Viresh Kumar wrote:
> This series reintroduces the usage of regulator_enable/disable() to the
> OPP core after the previous attempt was reverted [1] shortly after getting
> applied. This time the regulator is enabled only after it is configured
> by the OPP core.
>
> Marek, Kamil and Clément: Can you guys please test this out and report
> if this doesn't work as expected ?

Works fine for my test cases, especially Samsung Chromebook Peach-Pit/Pi 
still boots fine. Feel free to add to the both patches:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

