Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B900A8920
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfIDPAF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 11:00:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51508 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbfIDPAF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 11:00:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190904150003euoutp025a55bd9b1083b1f2232ee9ee95219e40~BREPqXER_2364823648euoutp02j
        for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2019 15:00:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190904150003euoutp025a55bd9b1083b1f2232ee9ee95219e40~BREPqXER_2364823648euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567609203;
        bh=NI/oCiaLC+G6Nc3ADbiZinAyF21F0uS0HOOzOp269mU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZsO95a20WOtz3ZQg9kTah50ZxJbazsD22wClz9XtzfllMd1taFNEFaO+47R7WXZD/
         epp6Zi/2b+VC33WYtxmatv5e8+V9F7RXe83LPOscTckDSFZmuTF9iMNP5PoyM79i4/
         M3kvjbipgJ0w5OoT0D4I6o9k0//Pc4xcPSjO1A8g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190904150002eucas1p29283154637ee5312a035b437d9f89656~BREOS2aQ21158711587eucas1p2s;
        Wed,  4 Sep 2019 15:00:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.72.04469.171DF6D5; Wed,  4
        Sep 2019 16:00:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190904150001eucas1p215a721a2305cef15e38f238fe30e17e2~BRENWU8gX2772527725eucas1p2u;
        Wed,  4 Sep 2019 15:00:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190904150001eusmtrp2a18e10d9ade2bf9302ca2a74535f9cf0~BRENH6sXH3234832348eusmtrp2y;
        Wed,  4 Sep 2019 15:00:01 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-ed-5d6fd1719e83
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.36.04166.071DF6D5; Wed,  4
        Sep 2019 16:00:00 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190904150000eusmtip24cc2449cc2866f5d00591645eb118427~BREMMO4Sa1710517105eusmtip2j;
        Wed,  4 Sep 2019 15:00:00 +0000 (GMT)
Subject: Re: [PATCH v13 0/8] Exynos5 Dynamic Memory Controller driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <760cdf64-af1b-2b5f-fb42-a950fdfa8c36@partner.samsung.com>
Date:   Wed, 4 Sep 2019 16:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPehHNDasNQDgTC+WtVpb_h-s0iTxXiDQY1WT=+zEdB18A@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1CMYRj17nfd2Lyt6JHr7JhxmZFym3dGiBEfv/hhxiAsPmm0G/uJwo+l
        ScSqccm27SLGbJNtlkrKLWpVcsm6tYNYyrgmVGhC7H5r9O885znPe86ZeXlKbWbD+QT9ZtGg
        1yZq2CC6rKbr7niDOykuMt+JyDmzkyGNHW8Yctx1lyFnvjQjknbKyZJD9TYFub1PR7KaP1Ck
        oeEsR+7s+siRL/ufM+TBRStL2k0uRMwNVxWkyNXEkdONbgVx18eSpzsLWJJ+xcWR6o8ZDPn9
        +BxNKh8uIE+7g8m3ulcoBgTHMQcSvnUepIU2Tzon5BndtFBhaeKE4sK9rFBpc3CCKe0TKxwo
        LURCya3tQnvx8IV9lwZFrxUTE7aIhgkzVgWtzzZ7FBuLcEpXtx0ZUZ4qEyl5wJPBesnOZKIg
        Xo0LEHhzKgNDBwLXkfuBoR1B2olf9L+Tl007WXlhR/D4TU9gaEWQV3wd+VQDcCykd79jfTgU
        j4XGX9/9T1HYy0BjfY0iE/E8iyOgvHCTT6PCc+HGM6f/lsaj4JHF5ncbiJfAV281I2tC4GZu
        i59X4kVQV3DSjykcBk9ajitkPAIutFopnxdgDw/W8xVIjj0H6q1nAhUGwPvaUk7GQ6GnQj4G
        LIHRlB/Q74DmLFtAMw2qa92MLzP1t4zz4gSZngXv6zKQjwYcDJ7WEDlCMBwsO0rJtAr27FbL
        6jFQuv9ewGgQ2B05XDbSWHoVs/QqY+lVxvLf9wSiC1GYmCzp4kUpSi9ujZC0OilZHx+xJklX
        jP7+11u/a7+Wo877q6sQ5pGmn8prS4pTM9otUqquCgFPaUJViy8nxqlVa7Wp20RD0kpDcqIo
        VaEhPK0JU23v412mxvHazeIGUdwoGv5tFbwy3IiiXmj7Tx9/NWxrUVtn1eHPPVEjIy4pHWUl
        3uyR7oV7ol+0xVQnGMdlxMS22H+UTimJlObzL80mrz5nWIrJar2wPOtB6J2O3K44vedtxUzU
        f9i1/BLVEeW63JxlqfMmhtRBZsoK66zyk0uOSqNbX4XXrJg0Vpyd9vN19JOpm+ZLkYOfaWhp
        vTZqHGWQtH8AobQK+qsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXeumovjtHzbh6whWGGzo829lolp1iGIigikEht2UGlztrOJ
        3WhaUq0stQKdmVFEY1rLWWk3NVtlszLtopmKtxDLbpqaWJY6A7/9eJ7/74EH/jQmKSGkdFKy
        ntclq9Qy0h2vG3/avjSlQRu77OzDMFSaZyNQ089eAhU5XhKo+Ec3QIcv20h0xlkoQs9PaNDp
        7s8Yqq+/QaEXGf0U+nGynUCv754n0WCWA6C8+koRuuZoo9CVpgYRanBGow/pFhJlPnBQ6FH/
        UQKNvyvFUdWb9ejD2Gw0XNsFIiBXcqEEcMNDuTj3rTmT4gqMDTh3x9xGcXbrcZKrKiyhuKzD
        X0nu1E0r4Mrq9nOD9vmbZm2Th+m0Bj2/IFEr6FfJtrMoSM6GInnQ8lA5G6yMXRGkkAWGh+3i
        1UmpvC4wfKc8MTuvWZRyjUkbHbsKjKBAbAJuNGSWw862dNIE3GkJcwXA8drXwLWYC3MryykX
        e8Hf70zToc8ANuUUT4W8mGiYOdZHTrI3sxg2/RkhJkMY00XAMWvRtNECYPbR67gJ0DTJyGGF
        dc+kIGbWwsettqlDOOMH35oL8Umew8TARxVm4Mp4wmf5PVNzN2YzrLVcmmKMCYEXyjoxF/vA
        lp4ikYt9YfmX81g2kJhn6OYZinmGYp6hXAS4FXjzBkGToBFYuaDSCIbkBHm8VmMHE025/WS0
        rAI0lm6pAQwNZB7ijkJtrIRQpQp7NTUA0pjMW7z1vjpWIt6l2ruP12njdAY1L9QAxcRzOZh0
        Trx2onfJ+jhWwSpRKKsMVgaHIJmP+BjzcIeESVDp+d08n8Lr/nsi2k1qBMfGzanfWIXXpt6c
        lpCDw/6ReZX+Hp6/pIcsNLT0r+odGrjeGNNs8AlI830xHBUz4k/1Cbe6+qoP1K8sPZL/N+B7
        TuCNxtHRT3sGFOcyniwymohiv7YFHRvtrQOrC5xf10QEKTteeZ70KF4YSda9l9jmRdVWJ0V3
        bPj49NO9dVc1ThkuJKrYJZhOUP0DXtAwRz8DAAA=
X-CMS-MailID: 20190904150001eucas1p215a721a2305cef15e38f238fe30e17e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8
References: <CGME20190821104316eucas1p2ecd715f3105921ec83e0acf1291201f8@eucas1p2.samsung.com>
        <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CAJKOXPehHNDasNQDgTC+WtVpb_h-s0iTxXiDQY1WT=+zEdB18A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 9/4/19 12:16 PM, Krzysztof Kozlowski wrote:
> On Wed, 21 Aug 2019 at 12:43, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi all,
>>
>> This is v13 which makes cosmetic changes. It is based on current mainline
>> (v5.3-rc5) with with devfreq/for-next where there is a PPMU patch [1].
>>
>> The patch set adds support of Dynamic Memory Controller for Exynos5422 SoC.
>> The driver supports Dynamic Voltage and Frequency Scaling
>> for the DMC and DRAM. It also provides needed timings for different
>> speed operations of the DRAM memory.
>> There is also new generic code in of_memory and headers which allows to parse
>> LPDDR3 memories defined in device-tree.
>>
>> Here are the last changes suggested by Krzysztof during his review.
>> For the previous changes in older revisions please refer to [2], there is
>> more detailed change log.
>>
>> changes:
>> v13:
>> - skipped patch with chipID changes in DT, since it is not used anymore,
>> - removed license comment in of_memory.c since SPDX has been merged,
>> - aligned comment to the current fields in the structure,
>> - changed printed warning when timings are not found,
>>
>> Regards,
>> Lukasz Luba
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=b617376df8f01c975dee66802f4da16291f92079
>> [2] https://lkml.org/lkml/2019/7/22/251
>>
> 
> Hi Lukasz,
> 
> Thanks for the effort and work on this patchset. The text-based
> bindings are slowly converted to JSON-schema but your patches were
> developed some time ago and have Rob's review. It would be nice if you
> or someone converted it to JSON schema later.
> Anyway, I'll pick up everything today evening either for this merge
> window or eventually postponed till next one. It is quite late in the
> cycle and I want the patches to sit in linux-next for some time.
Thank you for taking the patches.
OK, I will convert the bindings to JSON format later, when the patches
land into mainline.

Regards,
Lukasz Luba
> 
> Best regards,
> Krzysztof
> 
> 
