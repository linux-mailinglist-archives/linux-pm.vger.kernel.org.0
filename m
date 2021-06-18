Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D33AC086
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 03:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhFRB1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 21:27:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11057 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFRB1v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 21:27:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5h4N38ttzZd5F;
        Fri, 18 Jun 2021 09:22:44 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:25:41 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:25:40 +0800
Subject: Re: [PATCH -next v2] x86/power: fix doc warnings in cpu.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Haibing <yuehaibing@huawei.com>, <yangjihong1@huawei.com>,
        yu kuai <yukuai3@huawei.com>
References: <20210615033535.2907295-1-libaokun1@huawei.com>
 <CAJZ5v0iajoHXbJO-HgOMZkDo1GfRNEgDoNaSmFcOpeJGhgrYdA@mail.gmail.com>
 <CAJZ5v0g2+far_FMgBSV9OdobJU6kKD6BR3pg5VabavQVYC-uQQ@mail.gmail.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <da0a3ee0-3ed9-1c81-5d40-5ae9922199b4@huawei.com>
Date:   Fri, 18 Jun 2021 09:25:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g2+far_FMgBSV9OdobJU6kKD6BR3pg5VabavQVYC-uQQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you for your advice.

I'm about to send a patch v3 with the changes to fix the warning.

Best Regards.


在 2021/6/18 1:32, Rafael J. Wysocki 写道:
> On Thu, Jun 17, 2021 at 2:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Tue, Jun 15, 2021 at 5:26 AM Baokun Li <libaokun1@huawei.com> wrote:
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>   arch/x86/power/cpu.c:76: warning: Function parameter or
>>>    member 'ctxt' not described in '__save_processor_state'
>>>   arch/x86/power/cpu.c:192: warning: Function parameter or
>>>    member 'ctxt' not described in '__restore_processor_state'
>>>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ---
>>> V1->V2:
>>>          Fix the formatting of this kerneldoc comment
>>>
>>>   arch/x86/power/cpu.c | 31 ++++++++++++++++---------------
>>>   1 file changed, 16 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
>>> index 3a070e7cdb8b..54b530db5ed0 100644
>>> --- a/arch/x86/power/cpu.c
>>> +++ b/arch/x86/power/cpu.c
>>> @@ -58,19 +58,20 @@ static void msr_restore_context(struct saved_context *ctxt)
>>>   }
>>>
>>>   /**
>>> - *     __save_processor_state - save CPU registers before creating a
>>> - *             hibernation image and before restoring the memory state from it
>>> - *     @ctxt - structure to store the registers contents in
>>> + * __save_processor_statei() - Save CPU registers before creating a
>>> + *                             hibernation image and before restoring
>>> + *                             the memory state from it
>>> + * @ctxt: Structure to store the registers contents in.
>>>    *
>>> - *     NOTE: If there is a CPU register the modification of which by the
>>> - *     boot kernel (ie. the kernel used for loading the hibernation image)
>>> - *     might affect the operations of the restored target kernel (ie. the one
>>> - *     saved in the hibernation image), then its contents must be saved by this
>>> - *     function.  In other words, if kernel A is hibernated and different
>>> - *     kernel B is used for loading the hibernation image into memory, the
>>> - *     kernel A's __save_processor_state() function must save all registers
>>> - *     needed by kernel A, so that it can operate correctly after the resume
>>> - *     regardless of what kernel B does in the meantime.
>>> + * NOTE: If there is a CPU register the modification of which by the
>>> + * boot kernel (ie. the kernel used for loading the hibernation image)
>>> + * might affect the operations of the restored target kernel (ie. the one
>>> + * saved in the hibernation image), then its contents must be saved by this
>>> + * function.  In other words, if kernel A is hibernated and different
>>> + * kernel B is used for loading the hibernation image into memory, the
>>> + * kernel A's __save_processor_state() function must save all registers
>>> + * needed by kernel A, so that it can operate correctly after the resume
>>> + * regardless of what kernel B does in the meantime.
>>>    */
>>>   static void __save_processor_state(struct saved_context *ctxt)
>>>   {
>>> @@ -181,9 +182,9 @@ static void fix_processor_context(void)
>>>   }
>>>
>>>   /**
>>> - * __restore_processor_state - restore the contents of CPU registers saved
>>> - *                             by __save_processor_state()
>>> - * @ctxt - structure to load the registers contents from
>>> + * __restore_processor_state() - Restore the contents of CPU registers saved
>>> + *                               by __save_processor_state()
>>> + * @ctxt: Structure to load the registers contents from.
>>>    *
>>>    * The asm code that gets us here will have restored a usable GDT, although
>>>    * it will be pointing to the wrong alias.
>>> --
>> Applied as 5.14 material, thanks!
> And dropped, because it introduced a build issue.
> .
