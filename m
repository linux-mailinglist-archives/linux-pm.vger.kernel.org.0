Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9800C44EA
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 02:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfJBAUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 20:20:41 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40561 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbfJBAUk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 20:20:40 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191002002035epoutp03c53a0ee4ce79f275f9eb481ad0930d6a~JrIWmWWUG1463914639epoutp03t
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 00:20:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191002002035epoutp03c53a0ee4ce79f275f9eb481ad0930d6a~JrIWmWWUG1463914639epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569975635;
        bh=QRIPBG3kP6qcTxkFn4qlrxDCC6zMO78V4+Q6FvPIoFA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GI0Cmve35GRLEX2vWT/lXV8Fm+pzUMxaRg4RUccUDSH6v+1TwvIjqo4RRbBRg0HH7
         hZoXxvAJ/wwBKVAHPNr/RHdWg+cB16R2TR/THKySKRmX//j8BlUfWQuoi+G/0uGFHs
         zCm3hLt2dlW0G1TzGgrKzZsy/Ty7LEXtFUtr1mbk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191002002034epcas1p1c4a4947369265914a034c7c0da043bc6~JrIV4EeG41118211182epcas1p1H;
        Wed,  2 Oct 2019 00:20:34 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46jcH40S8LzMqYkk; Wed,  2 Oct
        2019 00:20:32 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.44.04224.F4DE39D5; Wed,  2 Oct 2019 09:20:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191002002031epcas1p1720a197ed6182f3cf15b17abc881c049~JrISz-BYn1117611176epcas1p1D;
        Wed,  2 Oct 2019 00:20:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191002002031epsmtrp2306bc87eedbb629dcec5b7b3c27ad371~JrISzObpc1200412004epsmtrp2z;
        Wed,  2 Oct 2019 00:20:31 +0000 (GMT)
X-AuditID: b6c32a38-d43ff70000001080-ea-5d93ed4f4e7a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.C5.04081.E4DE39D5; Wed,  2 Oct 2019 09:20:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191002002030epsmtip2076e8d751f85fe15e19fe811132cf731~JrISnP3mX2716127161epsmtip2V;
        Wed,  2 Oct 2019 00:20:30 +0000 (GMT)
Subject: Re: [PATCH v6 00/19] More improvements for Tegra30 devfreq driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <503b2ade-ff8e-c354-3886-3b7b511bd07e@samsung.com>
Date:   Wed, 2 Oct 2019 09:25:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <17dabcfc-3351-13a1-b3de-81af88f64d84@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzrZq9TZLn/ah5skiBZcnXZ1EK0hyqJBhRgViJ3fYzN3Y
        mdLlQ5ZZJk1KieqoFdpNJUpRMzMGZoaE3SSwi3ZxUERpNbvYfdsp8tvvufzf5/I+SkJzmdIq
        8+1u3mXnrDQ1hWy/Ea2PXfuuKieupCeRbfowgth9Yh3J9u99q2AHOmso1u/pQezBcZFin+y5
        QLETnSdJtuLiA2qVytgxdAYZr4pDCqOnZJQyVrQ2IqO/ZW6mfHNBkoXnTLxLx9vzHKZ8uzmZ
        Ts/KXZ1rWBrHxDLL2WW0zs7Z+GQ6JSMzdk2+NdAQrSvirIUBVyYnCPTiFUkuR6Gb11kcgjuZ
        5p0mq3O5Uy9wNqHQbtbnOWyJTFzcEkMgcUuBpfdHB+kc1G+vrrtPFqNf88uRSgk4Aepa/agc
        TVFqcAeCqpZuQjI+Iui/0qyQjM8IhofKAxFlSFLRiyX/dQQvyo9TkjGGoLm0QRF8Nwynwak7
        50I8C2fBzcbh0LME3ieD054vRDBA4Rjwvh6kgjwDR8LDryMoyGq8AsRXx0JiEkdB6eOfoZzZ
        eCN8fH5DLuXMhL4TPjLIKpwM3q53IS2BI+Cx75RM4nlQ0lYdKgz4NwX17T5CmjoFjl4pQxKH
        wZtbrQqJteAfvU5JvAsa+nooSVyGoNV7Ty4F4sF7tkoW3AWBo+FS52LJHQlXv9f+bWI6jH46
        JJfWpYay/RopZT4MPB+SSTwH6g8cpA4jWpw0jjhpBHHSCOL/YqcR2YjCeadgM/MC40yY/N0t
        KHStMWwH6rqT0Y2wEtHT1IPrq3I0cq5I2GHrRqAk6FnqpB+VORq1iduxk3c5cl2FVl7oRobA
        to8Q2tl5jsDt2925jGFJfHw8m8AsNTAMHaE2motzNNjMufkCnnfyrn86mVKlLUa12ZG24ZRF
        387vToxeV2v8TpksvdfSpo6n6z3jteG2dLbmVVdUcd6x9tQ5FSv377TUP7s91+Qdw/17SnW/
        zFufNvksnQNp5zZkTX/ZGHb3qWfqpoUlmzNUjxLeb4+NWjBxd5u/qE/3e2xrmwox1Sv7uhqi
        ZrCVqVpfRvYT7WGPXaRJwcIxMYRL4P4Am2J6HsMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvK7f28mxBvevWFus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlHPuzg6Xghl7F7EUXWRoY/yl3MXJwSAiYSPQd
        E+hi5OIQEtjNKLHi0ArWLkZOoLikxLSLR5khaoQlDh8uhqh5yyjx/P4DZpAaYQEvifnnlrGD
        2CICwRJzll5hAbGZBdqYJN58ioVo2MMocfv4M7ChbAJaEvtf3GADsfkFFCWu/njMCGLzCthJ
        zHo+HWwQi4CKROutv2A1ogIREod3zIKqEZQ4OfMJ2AJOAVuJ/XveMkIsU5f4M+8SM4QtLnHr
        yXwmCFteonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al
        6yXn525iBEeYluYOxstL4g8xCnAwKvHwNgRNjhViTSwrrsw9xCjBwawkwmvzZ1KsEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwrezxlJqyTu6vgLpcf
        aMD9a1pIS1PZJaG//vf61twPPvbj5rHNuY8UQnylt2vLC/1ldIu13fhh91lN8d/Zid+X3vi+
        MOyS37kk9fdPuLbENu24c+VNaWb19E96GnfqInVCpn2yWMH2tvZ1nN/SdQXsU+tdi+/atMa6
        JDfIFUbstd88bznr+w4lluKMREMt5qLiRADGBRkorAIAAA==
X-CMS-MailID: 20191002002031epcas1p1720a197ed6182f3cf15b17abc881c049
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191001211534epcas2p1e5f878969d3f68d4dfcafd82b1538487
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20191001211534epcas2p1e5f878969d3f68d4dfcafd82b1538487@epcas2p1.samsung.com>
        <17dabcfc-3351-13a1-b3de-81af88f64d84@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Dmitry and Thierry,

On 19. 10. 2. 오전 6:15, Dmitry Osipenko wrote:
> 12.08.2019 00:22, Dmitry Osipenko пишет:
>> Hello,
>>
>> This series addresses some additional review comments that were made by
>> Thierry Reding to [1], makes several important changes to the driver,
>> fixing excessive interrupts activity, and adds new features. In the end
>> I'm proposing myself as a maintainer for the Tegra devfreq drivers.
>>
>> [1] https://lore.kernel.org/lkml/0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com/T/
>>
>> Changelog:
>>
>> v6:  Addressed review comment that was made by Chanwoo Choi to v5 by
>>      squashing "Define ACTMON_DEV_CTRL_STOP" patch into the "Use CPUFreq
>>      notifier" patch.
>>
>> v5:  Addressed review comments that were made by Chanwoo Choi to v4 by
>>      squashing few patches, dropping some questionable patches, rewording
>>      comments to the code, restructuring the code and etc.
>>
>>      These patches are now dropped from the series:
>>
>>        PM / devfreq: tegra30: Use tracepoints for debugging
>>        PM / devfreq: tegra30: Inline all one-line functions
>>
>>      The interrupt-optimization patches are squashed into a single patch:
>>
>>        PM / devfreq: tegra30: Reduce unnecessary interrupts activity
>>
>>      because it's better to keep the optimizations as a separate change and
>>      this also helps to reduce code churning, since the code changes depend
>>      on a previous patch in order to stay cleaner.
>>
>>      Fixed a lockup bug that I spotted recently, which is caused by a
>>      clk-notifier->cpufreq_get()->clk_set_rate() sequence. Now a non-blocking
>>      variant of CPU's frequency retrieving is used, i.e. cpufreq_quick_get().
>>
>>      Further optimized the CPUFreq notifier by postponing the delayed
>>      updating in accordance to the polling interval, this actually uncovered
>>      the above lockup bug.
>>
>>      Implemented new minor driver feature in the new patch:
>>
>>        PM / devfreq: tegra30: Support variable polling interval
>>
>> v4:  Added two new patches to the series:
>>
>>        PM / devfreq: tegra30: Synchronize average count on target's update
>>        PM / devfreq: tegra30: Increase sampling period to 16ms
>>
>>      The first patch addresses problem where governor could get stuck due
>>      to outdated "average count" value which is snapshoted by ISR and there
>>      are cases where manual update of the value is required.
>>
>>      The second patch is just a minor optimization.
>>
>> v3:  Added support for tracepoints, replacing the debug messages.
>>      Fixed few more bugs with the help of tracepoints.
>>
>>      New patches in this version:
>>
>>        PM / devfreq: tegra30: Use tracepoints for debugging
>>        PM / devfreq: tegra30: Optimize CPUFreq notifier
>>        PM / devfreq: tegra30: Optimize upper consecutive watermark selection
>>        PM / devfreq: tegra30: Optimize upper average watermark selection
>>        PM / devfreq: tegra30: Include appropriate header
>>
>>      Some of older patches of this series also got some extra minor polish.
>>
>> v2:  Added more patches that are cleaning driver's code further and
>>      squashing another kHz conversion bug.
>>
>>      The patch "Rework frequency management logic" of the v1 series is now
>>      converted to "Set up watermarks properly" because I found some problems
>>      in the original patch and then realized that there is no need to change
>>      the logic much. So the logic mostly preserved and only got improvements.
>>
>>      The series is based on the today's linux-next (25 Jun) and takes into
>>      account minor changes that MyungJoo Ham made to the already queued
>>      patches from the first batch [1].
>>
>> Dmitry Osipenko (19):
>>   PM / devfreq: tegra30: Change irq type to unsigned int
>>   PM / devfreq: tegra30: Keep interrupt disabled while governor is
>>     stopped
>>   PM / devfreq: tegra30: Handle possible round-rate error
>>   PM / devfreq: tegra30: Drop write-barrier
>>   PM / devfreq: tegra30: Set up watermarks properly
>>   PM / devfreq: tegra30: Tune up boosting thresholds
>>   PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
>>   PM / devfreq: tegra30: Ensure that target freq won't overflow
>>   PM / devfreq: tegra30: Use kHz units uniformly in the code
>>   PM / devfreq: tegra30: Reduce unnecessary interrupts activity
>>   PM / devfreq: tegra30: Use CPUFreq notifier
>>   PM / devfreq: tegra30: Move clk-notifier's registration to governor's
>>     start
>>   PM / devfreq: tegra30: Reset boosting on startup
>>   PM / devfreq: tegra30: Don't enable consecutive-down interrupt on
>>     startup
>>   PM / devfreq: tegra30: Constify structs
>>   PM / devfreq: tegra30: Include appropriate header
>>   PM / devfreq: tegra30: Increase sampling period to 16ms
>>   PM / devfreq: tegra30: Support variable polling interval
>>   PM / devfreq: tegra20/30: Add Dmitry as a maintainer
>>
>>  MAINTAINERS                       |   9 +
>>  drivers/devfreq/tegra30-devfreq.c | 706 +++++++++++++++++++++++-------
>>  2 files changed, 555 insertions(+), 160 deletions(-)
>>
> 
> Hello Chanwoo,
> 
> I don't have any more updates in regards to this series, everything is
> working flawlessly for now. Will be awesome if we could continue the
> reviewing and then get the patches into linux-next to get some more testing.
> 
> 

Hello Dmitry,

I'm sorry for late reply. Except for patch5, I reviewed the patches.
Please check my comment. Actually, It is difficult to review the patch5
without any testing environment and detailed knowledge of watermark of tegra.
It is not familiar with me.


Hello Thierry,
If possible, Could you review the patch5 related to setting up the watermark
and other patches?

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
