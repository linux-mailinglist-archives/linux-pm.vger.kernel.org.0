Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA530EE92
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 09:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhBDIh7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 03:37:59 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:31558 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhBDIhz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 03:37:55 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210204083713epoutp029bc060490c781bdbece42b262e6399bb~gfpJgSNPl2511825118epoutp02T
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 08:37:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210204083713epoutp029bc060490c781bdbece42b262e6399bb~gfpJgSNPl2511825118epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612427833;
        bh=8Mj5Ia0Wbe17+4rHiGSNzvrjHnMDGiyeLkAiWH6BRTw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=M6SZbwIeR7uL/EtPSFCbhKeI5s6Sh/AwG+YH6Bg66v6xZn6t+ONw5AsFoI2bYQMVN
         v29ryDmJisau57GYD513pbosyBP1LWCg8vmr9SmvtLak2B+LABlkHgUEeolKLpakJy
         9T1dkUBNv6uN4hJ/QlvzfgGtCaWFyoDxBBa6TMj4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210204083713epcas1p46f93c98fc47988e6ad260812f420caab~gfpJBNTYm2023220232epcas1p4L;
        Thu,  4 Feb 2021 08:37:13 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DWX3W0G4Mz4x9Q2; Thu,  4 Feb
        2021 08:37:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.A6.10463.632BB106; Thu,  4 Feb 2021 17:37:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210204083710epcas1p1f03d346b83d8a1eabed3f81c91bbb447~gfpGaIteO0749807498epcas1p1h;
        Thu,  4 Feb 2021 08:37:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210204083710epsmtrp1ee71e4b75200d74c9f9fe240acb9597d~gfpGYvPjI0843908439epsmtrp1a;
        Thu,  4 Feb 2021 08:37:10 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-38-601bb236080f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.B3.08745.632BB106; Thu,  4 Feb 2021 17:37:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210204083710epsmtip224b4185165e1d4a2e9d11085dbe36334~gfpGJHRRR2837528375epsmtip2I;
        Thu,  4 Feb 2021 08:37:10 +0000 (GMT)
Subject: Re: [PATCH v5 0/3] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ab504f1d-9024-8ad2-e437-e7c10ad64121@samsung.com>
Date:   Thu, 4 Feb 2021 17:53:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210204054133.sb6vymf56u43bpwe@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmga7ZJukEg41HrCwmtG5ntjjb9Ibd
        4vKuOWwWn3uPMFrcblzBZvHmx1kmizOnL7FadB36y2bx79pGFouNXz0sNj84xubA7TG74SKL
        x4JNpR6bVnWyedy5tofNY8vVdhaPvi2rGD2O39jO5PF5k1wAR1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QnUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7IzfX5axFBzmqvj6rJGlgXED
        RxcjB4eEgInEjH1WXYycHEICOxglJq1W6WLkArI/MUq86fjABuF8ZpRo3X6bDaQKpKHh6hlW
        iMQuRom2J1eZIJz3jBLTnn8DqxIW8JG4eu4/I4gtIhAgsaK3lR2kiFngDJPE4asnwIrYBLQk
        9r+4AWbzCyhKXP3xGKyBV8BO4vaiZcwgNouAisTqZ3dYQGxRgTCJk9taoGoEJU7OfAIW5xSw
        lJi6cRETiM0sIC5x68l8KFteYvvbOcwgiyUEznBIrNs1ixHiBxeJc52rWCBsYYlXx7ewQ9hS
        Ei/726DsaomVJ4+wQTR3MEps2X+BFSJhLLF/6WQmUOgxC2hKrN+lDxFWlNj5ey4jxGI+iXdf
        e1ghAcwr0dEmBFGiLHH5wV0mCFtSYnF7J9sERqVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz0
        1GLDAhPk2N7ECE7DWhY7GOe+/aB3iJGJg/EQowQHs5IIb2KbVIIQb0piZVVqUX58UWlOavEh
        RlNgAE9klhJNzgdmgrySeENTI2NjYwsTQzNTQ0Mlcd4kgwfxQgLpiSWp2ampBalFMH1MHJxS
        DUxKTIaKOy/2JgVNuvNogbd6cNd+jz/3u9qW/bgaV2+UZs30nHljlaN4tH+F2mFO6cp+1edV
        Xn9iN4k9tZRq1yuT6TzNWD85Ju3oRpcKxSVXTwRs2dP4VP3vpavcKTWCk7L0Hdec0M/zWtPQ
        JjJx4rSNlk4fZxnxBMz04P/28vdTji4DnigLma9zj0ho9zCwLjn0m5Vn84r9i07HC6TvfPp6
        3c/HLDF6shKpNieEWzWvGCutvRv9SGxJ9/FVBw/dXnle9dymGxPOKExg6G6a5nFg7y0znv2O
        m6+/EFIxEk2tT1mhyOlpWP5EvP3FxCw9xXXt3CvvP+w7EWv9KzJS2dL44au9mi4pf65vUfrq
        UqjEUpyRaKjFXFScCAAsJG4uTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvK7ZJukEg4M3hC0mtG5ntjjb9Ibd
        4vKuOWwWn3uPMFrcblzBZvHmx1kmizOnL7FadB36y2bx79pGFouNXz0sNj84xubA7TG74SKL
        x4JNpR6bVnWyedy5tofNY8vVdhaPvi2rGD2O39jO5PF5k1wARxSXTUpqTmZZapG+XQJXxu8v
        y1gKDnNVfH3WyNLAuIGji5GTQ0LARKLh6hnWLkYuDiGBHYwSW49sYIdISEpMu3iUuYuRA8gW
        ljh8uBii5i2jxJ6XF8FqhAV8JK6e+88IYosI+Ek8abnDBlLELHCOSaJh3ywWiI69jBJXW6+A
        VbEJaEnsf3GDDcTmF1CUuPrjMVicV8BO4vaiZcwgNouAisTqZ3dYQGxRgTCJnUseM0HUCEqc
        nPkELM4pYCkxdeMisDizgLrEn3mXmCFscYlbT+ZDxeUltr+dwzyBUXgWkvZZSFpmIWmZhaRl
        ASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4JjU0trBuGfVB71DjEwcjIcYJTiY
        lUR4E9ukEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        CmZ2kjd9p5rvvDZ/Pv/SOIZHwlpR2497Js2aJR3DoZuVfnhnaOWFaaUeb5iVzbcr6cZZnLj+
        lmeL4STO/CW+OmeMDba5G1X+eJ19LyXbXTn/FKv0pKvb7abcL9m+cIflLTa/xo6Vt//Pf/L7
        xXvTdcpmG7LSu6vW8Nr18rktq9NTObQ+KSf88kkftq+xlk//tuVwV2sLKnctbu2s4HHljpgm
        eron/N6ZjuTVrZbbxdrKcnW3b1ir9LztzOTpraU51iKCS9IOC36ydgrat3b3Ma9FvyPcxbTD
        WbanlBTz3po+4a9zQNPcXUFsi/g91FPXLti64dc0R73Y1JQmN3HLBevE2gtPKHxvWhweyKLE
        UpyRaKjFXFScCACFeSpWOAMAAA==
X-CMS-MailID: 20210204083710epcas1p1f03d346b83d8a1eabed3f81c91bbb447
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210204054354epcas1p41f04a9cf560fa08e2bbe7a64ddd4784f
References: <20210203092400.1791884-1-hsinyi@chromium.org>
        <CGME20210204054354epcas1p41f04a9cf560fa08e2bbe7a64ddd4784f@epcas1p4.samsung.com>
        <20210204054133.sb6vymf56u43bpwe@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 2/4/21 2:41 PM, Viresh Kumar wrote:
> On 03-02-21, 17:23, Hsin-Yi Wang wrote:
>> The devfreq passive governor scales the frequency of a "child" device based
>> on the current frequency of a "parent" device (not parent/child in the
>> sense of device hierarchy). As of today, the passive governor requires one
>> of the following to work correctly:
>> 1. The parent and child device have the same number of frequencies
>> 2. The child device driver passes a mapping function to translate from
>>    parent frequency to child frequency.
>>
>> When (1) is not true, (2) is the only option right now. But often times,
>> all that is required is a simple mapping from parent's frequency to child's
>> frequency.
>>
>> Since OPPs already support pointing to other "required-opps", add support
>> for using that to map from parent device frequency to child device
>> frequency. That way, every child device driver doesn't have to implement a
>> separate mapping function anytime (1) isn't true.
> 
> So you guys aren't interested in dev_pm_opp_set_opp() but just the
> translation of the required-OPPs ?
> 
> I am fine with most of the stuff and I would like to take it via OPP
> tree, hope that would be fine ?

I agree. Take these patches to OPP tree.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
