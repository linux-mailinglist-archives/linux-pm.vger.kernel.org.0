Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5644A23A95E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgHCPaf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 11:30:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46125 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCPad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 11:30:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200803153031euoutp022c36013df6106ea17ed7ff1f52c0143b~ny8MfDJ8D1868818688euoutp02K
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 15:30:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200803153031euoutp022c36013df6106ea17ed7ff1f52c0143b~ny8MfDJ8D1868818688euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596468631;
        bh=Jz6tkQErBLsdV2v0wFX7a95nI5VkFFvWz7rn7bqAy1Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=McYstQsFMSxCGWsuBxp96VgG0398sUUSXuhSSKVvBnpi+31HfxiqKq8L07HEnI1WT
         ihPASdzwhqgd9gtKJbJ+esbc3sCYM+9IoC6Rh9ru8XI5GRZsHcbp5UGd+wusUWC1jM
         13cxq+1i6bsd3QH8In+Emfl6ZRBDWc5X8UJBH0FI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200803153031eucas1p15f0cbcfe0ddfb7c18ee4566ce1dc5f00~ny8MHGGJx2152121521eucas1p1E;
        Mon,  3 Aug 2020 15:30:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5C.78.06318.79D282F5; Mon,  3
        Aug 2020 16:30:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200803153030eucas1p2a28373f5e2cd3d6ae472aacbffb03c4e~ny8Lm2mRg2873728737eucas1p29;
        Mon,  3 Aug 2020 15:30:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200803153030eusmtrp2bd8b688608a971563485cb1ffbe96e19~ny8LmGOdj2559225592eusmtrp2Y;
        Mon,  3 Aug 2020 15:30:30 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-17-5f282d97bc09
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 05.49.06314.69D282F5; Mon,  3
        Aug 2020 16:30:30 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200803153030eusmtip22d0b2a8f9579ed8d29f0a1e38f618cf8~ny8K345ai0126701267eusmtip2K;
        Mon,  3 Aug 2020 15:30:30 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module
 param to control IRQ mode
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     willy.mh.wolff.ml@gmail.com, k.konieczny@samsung.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <db571467-48ec-8f11-de1d-00393d8aa99b@samsung.com>
Date:   Mon, 3 Aug 2020 17:30:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710191122.11029-3-lukasz.luba@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7rTdTXiDZ6fEbLYOGM9q8XEG1dY
        LK5/ec5qseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLBY2tbBb
        3G5cwWZx+E07q8W3E48YHfg91sxbw+ixc9Zddo9NqzrZPDYvqffo27KK0ePzJrkAtigum5TU
        nMyy1CJ9uwSujGMLrzAVNHBVNO5/z9zAOI2ji5GTQ0LARKL3WA9jFyMXh5DACkaJA3P7oJwv
        jBINvxazQzifGSW+/XvO1sXIAdYy8XQJRHw5o8TJjXtYQEYJCbxnlLh5Mg/EFhZIlmjd/YIN
        pEhEYBWjxPf3R1hBHGaQSZM+LGQGqWITMJToetvFBmLzCthJNNz6yg5iswioSLQt+8YIYosK
        xEmsf7mdCaJGUOLkzCdg2zgFLCWuX1kDVsMsIC/RvHU2M4QtLnHryXwmiOf+skt0rKqCsF0k
        vj6bBhUXlnh1fAs7hC0j8X8nSD0XkN3MKPHw3Fp2CKeHUeJy0wxGiCpriTvnfoH9zyygKbF+
        lz5E2FHi1L5lzJBg4ZO48VYQ4gY+iUnbpkOFeSU62oQgqtUkZh1fB7f24IVLzBMYlWYh+WwW
        km9mIflmFsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQKT2+l/x7/uYNz3J+kQ
        owAHoxIP7wJWjXgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1
        XvQyVkggPbEkNTs1tSC1CCbLxMEp1cAovNLyJ5fZ+1zOo7tnVMesf74kJSLonZOjtMzBw0dv
        GLbnuLb7NG7XT3E+epA54LpaifFvs9nzw6753RZZoWVb0DGrouYro/+FWZ+m32LxT/bkuvKt
        7KFdDUP40ZdOatN2nVdp0fW6UbU957r+xbsi+zKzhfWjKmJZG+J3zpSVvRFm2PpLW0mJpTgj
        0VCLuag4EQAFJUrWagMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xe7rTdDXiDb4sNbbYOGM9q8XEG1dY
        LK5/ec5qseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLBY2tbBb
        3G5cwWZx+E07q8W3E48YHfg91sxbw+ixc9Zddo9NqzrZPDYvqffo27KK0ePzJrkAtig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jGMLrzAVNHBV
        NO5/z9zAOI2ji5GDQ0LARGLi6ZIuRi4OIYGljBK//y5j6WLkBIrLSJyc1sAKYQtL/LnWxQZR
        9JZR4vLhRUwgCWGBZIk/O06BJUQEVjFK3Lt/gx3EYRb4zCjR/mY/C0TLbkaJKRfns4G0sAkY
        SnS97QKzeQXsJBpufWUHsVkEVCTaln1jBLFFBeIklm+Zzw5RIyhxcuYTsJs4BSwlrl9ZA1bD
        LGAmMW/zQ2YIW16ieetsKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbU
        K07MLS7NS9dLzs/dxAiM6G3Hfm7ewXhpY/AhRgEORiUe3gWsGvFCrIllxZW5hxglOJiVRHid
        zp6OE+JNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YLLJK4k3NDU0t7A0NDc2NzazUBLn7RA4
        GCMkkJ5YkpqdmlqQWgTTx8TBKdXAaBTa2b7gRztHaOjmh8unzi6aZZP3fk2FyUe1wLkZWzN4
        d77ZI1u67tBN9YWzHz1tYPjzaUFNddezPRyO/Z8T/qs1LuqbaazvYTzxgvK5lRJfdXdJfhBI
        rpWfL7a88OvVYsn3DRtn/nqqcpD/45asuxen5r/bZLn+X31T5fTEo6tjzqaHiF0W3a7EUpyR
        aKjFXFScCAARIuZi/gIAAA==
X-CMS-MailID: 20200803153030eucas1p2a28373f5e2cd3d6ae472aacbffb03c4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200710191154eucas1p296561f285ee0730e5040fdfe3fc7e75e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200710191154eucas1p296561f285ee0730e5040fdfe3fc7e75e
References: <20200710191122.11029-1-lukasz.luba@arm.com>
        <CGME20200710191154eucas1p296561f285ee0730e5040fdfe3fc7e75e@eucas1p2.samsung.com>
        <20200710191122.11029-3-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 10.07.2020 21:11, Lukasz Luba wrote:
> The driver can operate in two modes relaying on devfreq monitoring
> mechanism which periodically checks the device status or it can use
> interrupts when they are provided by loaded Device Tree. The newly
> introduced module parameter can be used to choose between devfreq
> monitoring and internal interrupts without modifying the Device Tree.
> It also sets devfreq monitoring as default when the parameter is not set
> (also the case for default when the driver is not built as a module).
>
> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

I've got back from my holidays and noticed that in meantime this commit 
got merged as commit 4fc9a0470d2d. It revealed that there is a race 
between registering exynos5422-dmc driver and exynos-ppmu driver, which 
can be observed sometimes as the following message and freeze on Odroid 
XU3 with multi_v7_defconfig:

[    8.767708] exynos5-dmc 10c20000.memory-controller: couldn't probe 
performance counters

I will check this later why the EPROBE_DEFER error is not properly 
propagated and why it causes a freeze.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

