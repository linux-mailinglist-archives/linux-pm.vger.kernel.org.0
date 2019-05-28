Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073E42BCBD
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 03:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfE1BQR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 21:16:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18866 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfE1BQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 21:16:17 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190528011614epoutp020aa346f5bc2eb0f3922b37785e976f0a~is9sr8_8V0472304723epoutp02B
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2019 01:16:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190528011614epoutp020aa346f5bc2eb0f3922b37785e976f0a~is9sr8_8V0472304723epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559006174;
        bh=0vYxNaN0DjAJ27p8LoaH8nU/xLDm2uIusYx8OTjPnRA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=imEoJ5UoRtq1t+29AiddUXiW1c/gxL+zpnS7j6UFadseVReNbSA2k7XcGMx97+/FI
         DonOKCwKnBmQ9fBK/IXZiGJ0yI9ofcyROORUdzUEog/sJp49dQnQzVSwm1xI5mEUWg
         StJjs+0Jx9EmdYlxGJBUxSOmixq0DXkkAmEcmvcw=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190528011612epcas1p17d6e23d0e004e4c60644686cd5d57e1a~is9p-VmL21279612796epcas1p1D;
        Tue, 28 May 2019 01:16:12 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.32.04257.BDB8CEC5; Tue, 28 May 2019 10:16:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190528011611epcas1p1364c6a80db0e526c689950c4a66f53ea~is9pZADRb1280812808epcas1p1n;
        Tue, 28 May 2019 01:16:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190528011611epsmtrp21e70426903cb4f0878cb07d5483b0a64~is9pYNceQ1136211362epsmtrp2X;
        Tue, 28 May 2019 01:16:11 +0000 (GMT)
X-AuditID: b6c32a38-a3dc09c0000010a1-f4-5cec8bdbfd1d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.C2.03692.BDB8CEC5; Tue, 28 May 2019 10:16:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190528011611epsmtip28557f32efc5ece3feae685ba1e24084a~is9pMKrQR1103611036epsmtip2V;
        Tue, 28 May 2019 01:16:11 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: try_then_request_governor should not
 return NULL
To:     Rob Clark <robdclark@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e1232f97-c80d-2bf2-639a-7f7b9195d1f0@samsung.com>
Date:   Tue, 28 May 2019 10:18:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJs_Fx4hw3nrUAksQxTrVrJubQAxADE5FmBrSs+EOmE3jwL9bg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmnu7t7jcxBh3nNSzONr1ht5i4/yy7
        xeVdc9gsPvceYbS43biCzeLaz8fMFs8X/mB2YPeY3XCRxWPnrLvsHn1bVjF6fN4kF8ASlW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y/qa
        o4wFD1Uqdnf1sjUwPpfpYuTkkBAwkej6+IC5i5GLQ0hgB6PE6uNNTBDOJ0aJSVu/s0A43xgl
        Nu1aygzTcrURJrGXUWJB61qolveMEtcPHGPtYuTgEBYIlbg7QR6kQURATWJrzxWwBmaB14wS
        966uZwNJsAloSex/cQPM5hdQlLj64zEjiM0rYCfxavFXFhCbRUBVYm/fPDBbVCBC4v6xDawQ
        NYISJ2c+AYtzCgRKLNs0BayXWUBc4taT+UwQtrxE89bZUFc/Z5N4uSwDwnaRmNO5jQXCFpZ4
        dXwLO4QtJfH53V42CLtaYuXJI2wgR0sIdDBKbNl/gRUiYSyxf+lkJpAnmQU0Jdbv0ocIK0rs
        /D0X6gY+iXdfe8DhICHAK9HRJgRRoixx+cFdJghbUmJxeyfbBEalWUi+mYXkg1lIPpiFsGwB
        I8sqRrHUguLc9NRiwwIT5NjexAhOnVoWOxj3nPM5xCjAwajEw2tx6nWMEGtiWXFl7iFGCQ5m
        JRFe0y2vYoR4UxIrq1KL8uOLSnNSiw8xmgIDeyKzlGhyPjCt55XEG5oaGRsbW5gYmpkaGiqJ
        88Zz34wREkhPLEnNTk0tSC2C6WPi4JRqYMzj07u3zzqXf7LimhNpb9P02X9pusl92+R6dKPz
        zFYfBvc1dscfOkVdsOT1Mn61a1HIhw73Tv7bZwT6LLYsWFMb/ONzyP7iGb+09b+s2vagSCJM
        4LOamc8FPvae9G+TQjymTpednZ6pe6VqqVYev5fT3KOHlC2jbeKCVuiH+zzMkv9RlCw9R4ml
        OCPRUIu5qDgRAIgaCjezAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvd295sYg1e3BC3ONr1ht5i4/yy7
        xeVdc9gsPvceYbS43biCzeLaz8fMFs8X/mB2YPeY3XCRxWPnrLvsHn1bVjF6fN4kF8ASxWWT
        kpqTWZZapG+XwJUxfc1RxoKHKhW7u3rZGhify3QxcnJICJhIXG38ztLFyMUhJLCbUWLTifUs
        EAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZQ48fwlE0iNsECoxJRlvYwgtoiAmsTWnitgg5hBit5v
        PMYI0dHBJHFwxmJmkCo2AS2J/S9usIHY/AKKEld/PAbr5hWwk3i1+CvYZhYBVYm9ffPAbFGB
        CIkz71ewQNQISpyc+QTM5hQIlFi2aQpYL7OAusSfeZeYIWxxiVtP5jNB2PISzVtnM09gFJ6F
        pH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOI60NHcwXl4S
        f4hRgINRiYfX4tTrGCHWxLLiytxDjBIczEoivKZbXsUI8aYkVlalFuXHF5XmpBYfYpTmYFES
        532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwMjwa1+65uGtYeJxBdozgzNev5/benfywQ4poRVv
        fQ62iZaUNXM/t/7IXvFOLe5ZesKmz6rz1524aMC1QTWG7YC3l7qNB8/naOmzL0JXZvjkbHtk
        9kgnPWytFp/Ei5pnwXGzovWrkqtLf0coT5u6WqDlvHDFmdPNZ29c3avalLGg8vnpackNd5RY
        ijMSDbWYi4oTAYSr59efAgAA
X-CMS-MailID: 20190528011611epcas1p1364c6a80db0e526c689950c4a66f53ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190523215902epcas5p40e3aca0efb342c8d778529fef416c3fd
References: <CGME20190523215902epcas5p40e3aca0efb342c8d778529fef416c3fd@epcas5p4.samsung.com>
        <20190523215853.16622-1-robdclark@gmail.com>
        <9c63ac15-9917-7adc-3ef8-3e44060797bd@samsung.com>
        <CAJs_Fx4hw3nrUAksQxTrVrJubQAxADE5FmBrSs+EOmE3jwL9bg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

You're right. It have to be posted to stable@vger.kernel.org.
As you recommended, I send it[1] to stable@vger.kernel.org for fixup.
[1]https://lkml.org/lkml/2019/5/27/547

Best Regards,
Chanwoo Choi

On 19. 5. 24. 오후 10:15, Rob Clark wrote:
> Ahh, thanks, I've not moved to the latest -rc yet..
> 
> That commit would be a good candidate for 5.1.y stable branch
> 
> BR,
> -R
> 
> On Fri, May 24, 2019 at 12:13 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> Hi,
>>
>> This issue[1] is already fixed on latest linux.git
>> You can check it. Thanks.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b53b0128052ffd687797d5f4deeb76327e7b5711
>>
>> Regards,
>> Chanwoo Choi
>>
>>
>> On 19. 5. 24. 오전 6:58, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> The two spots it is called expect either an IS_ERR() or a valid pointer,
>>> but not NULL.
>>>
>>> Fixes this crash that I came across:
>>>
>>>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
>>>    Mem abort info:
>>>      ESR = 0x96000005
>>>      Exception class = DABT (current EL), IL = 32 bits
>>>      SET = 0, FnV = 0
>>>      EA = 0, S1PTW = 0
>>>    Data abort info:
>>>      ISV = 0, ISS = 0x00000005
>>>      CM = 0, WnR = 0
>>>    [0000000000000030] user address but active_mm is swapper
>>>    Internal error: Oops: 96000005 [#1] PREEMPT SMP
>>>    Modules linked in:
>>>    Process kworker/2:1 (pid: 212, stack limit = 0x(____ptrval____))
>>>    CPU: 2 PID: 212 Comm: kworker/2:1 Not tainted 5.1.0-43338-g460e6984675c-dirty #54
>>>    Hardware name: Google Cheza (rev3+) (DT)
>>>    Workqueue: events deferred_probe_work_func
>>>    pstate: 00c00009 (nzcv daif +PAN +UAO)
>>>    pc : devfreq_add_device+0x2e4/0x410
>>>    lr : devfreq_add_device+0x2d4/0x410
>>>    sp : ffffff8013d93740
>>>    x29: ffffff8013d93790 x28: ffffffc0f54f8670
>>>    x27: 0000000000000001 x26: 0000000000000007
>>>    x25: ffffff80124abfd8 x24: 0000000000000000
>>>    x23: ffffffc0fabc4048 x22: ffffffc0fabc4388
>>>    x21: ffffffc0fabc4010 x20: ffffffc0fa243010
>>>    x19: ffffffc0fabc4000 x18: 0000000091c3d373
>>>    x17: 0000000000000400 x16: 000000000000001a
>>>    x15: 000000019e06d400 x14: 0000000000000001
>>>    x13: 0000000000000000 x12: 00000000000006b6
>>>    x11: 0000000000000000 x10: 0000000000000000
>>>    x9 : ffffffc0fa18ba00 x8 : 0000000000000000
>>>    x7 : 0000000000000000 x6 : ffffff80127a3d9a
>>>    x5 : ffffff8013d93550 x4 : 0000000000000000
>>>    x3 : 0000000000000000 x2 : 0000000000000000
>>>    x1 : 00000000000000fe x0 : 0000000000000000
>>>    Call trace:
>>>     devfreq_add_device+0x2e4/0x410
>>>     devm_devfreq_add_device+0x64/0xac
>>>     msm_gpu_init+0x320/0x5c0
>>>     adreno_gpu_init+0x21c/0x274
>>>     a6xx_gpu_init+0x68/0xf4
>>>     adreno_bind+0x158/0x284
>>>     component_bind_all+0x110/0x204
>>>     msm_drm_bind+0x118/0x5b8
>>>     try_to_bring_up_master+0x15c/0x19c
>>>     component_master_add_with_match+0xb4/0xec
>>>     msm_pdev_probe+0x1f0/0x27c
>>>     platform_drv_probe+0x90/0xb0
>>>     really_probe+0x120/0x298
>>>     driver_probe_device+0x64/0xfc
>>>     __device_attach_driver+0x8c/0xa4
>>>     bus_for_each_drv+0x88/0xd0
>>>     __device_attach+0xac/0x134
>>>     device_initial_probe+0x20/0x2c
>>>     bus_probe_device+0x34/0x90
>>>     deferred_probe_work_func+0x74/0xac
>>>     process_one_work+0x210/0x428
>>>     worker_thread+0x278/0x3e4
>>>     kthread+0x120/0x130
>>>     ret_from_fork+0x10/0x18
>>>    Code: aa0003f8 b13ffc1f 54000762 f901c278 (f9401b08)
>>>    ---[ end trace a6ecc18ce5894375 ]---
>>>    Kernel panic - not syncing: Fatal exception
>>>
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>  drivers/devfreq/devfreq.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 0ae3de76833b..d29f66f0e52a 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -254,7 +254,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>>>               /* Restore previous state before return */
>>>               mutex_lock(&devfreq_list_lock);
>>>               if (err)
>>> -                     return NULL;
>>> +                     return ERR_PTR(err);
>>>
>>>               governor = find_devfreq_governor(name);
>>>       }
>>>
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
