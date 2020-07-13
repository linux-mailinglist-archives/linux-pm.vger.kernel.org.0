Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F721D316
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 11:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgGMJpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGMJpd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 05:45:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866D7C061794
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 02:45:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a6so12948080wmm.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=otVulKjc0ogv42O2JFqcEJScHvHl4vp3m32t3UYd2Kw=;
        b=xZkDaSdOHPEuGUwfOb6nqqxZOvsPfL1pnepML+/Ed+UjvcgcEO/o0p33DH/SpU+JpV
         qvqgb7VDlYs6FjP1uLWfp/CF8LUjqY9Dp/4N4wWePkbMjnalzR+k82j0NrHN2KxOmgyY
         tlfhpO8ISIVj+kiDIEeqh7Z2sCBI4ga87fW5Pd5uuthrc+vuyPnARbVVKHyC8JvjOq1a
         +XSxNnEHzRDLAMc+brEL/6ZMWsDauigI6FWUkg9Rylhy3+RpoiTfCqgNrVWh4qcGUe5j
         m9HoTRmZZpoYfapnA7BbtCwdtuhghjRTeWCVrCtVnaXPoK3Gph7UhLMdndE7Cgan4fKJ
         GM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=otVulKjc0ogv42O2JFqcEJScHvHl4vp3m32t3UYd2Kw=;
        b=BJNrM4ka9Ed61N2iE4M+vyAvtPzKZ/9enrgdt4Prom5AEMz/TsmP6jLxmDC9FuSXZR
         b9MKVUS3psnSTrWZSyTmeUfaoCAvbwd7anyM70Uu8dgjtyY3ITQ7LXIywzuBL/1aaRdA
         uMIFxczmULdj+MMg7Q0C85dnCmbV0H6rDuSnZXSk+7rwhrXzXHiOB6Kl4WtZtjd7MciO
         FcTuwyV84dzjEBHfggczl5PDu4AkJl2Ueunn25VIOtNQMalNaKpCSUGLYKgU+oTS2Fqj
         7/WkfDWoCHG9bOZ7lZJ+stYC3ExZePDeBu0OQVF6LeKKJTORqsmEMErNZxb9HVFd+Plq
         Sw3g==
X-Gm-Message-State: AOAM531+M+pSqqz+UmdAjqxv8ZBlNhlitMPYcmu1/He1VJnY4CSeVWI+
        J715W5XRBiEr2+/Z4SHISTMblA==
X-Google-Smtp-Source: ABdhPJwfmSghj8SqWwYfEsnJ+Vo/AbskhnH8qm7h+6UXba3OKaV1P/faDsL0eoU21I1tCfkG4Xn/bQ==
X-Received: by 2002:a1c:f007:: with SMTP id a7mr17993993wmb.103.1594633531976;
        Mon, 13 Jul 2020 02:45:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:501b:b12d:3463:93f8? ([2a01:e34:ed2f:f020:501b:b12d:3463:93f8])
        by smtp.googlemail.com with ESMTPSA id n14sm23603421wro.81.2020.07.13.02.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 02:45:31 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
To:     Marek Szyprowski <m.szyprowski@samsung.com>, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
 <20200706105538.2159-4-daniel.lezcano@linaro.org>
 <CGME20200706131708eucas1p1487955a7632584c17df724399f48825a@eucas1p1.samsung.com>
 <c7ed6c63-cbb5-07dc-c292-2c473af8c4fb@samsung.com>
 <23c5830d-0a7c-9e87-e859-821d2dccb200@linaro.org>
 <8a34e9c4-6457-cfd2-3d05-05f80a630a0d@samsung.com>
 <41466d5a-24fb-b861-93ae-3ed190af7174@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e1a6063a-ec96-7fae-8c3f-cc9eb7df01a2@linaro.org>
Date:   Mon, 13 Jul 2020 11:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <41466d5a-24fb-b861-93ae-3ed190af7174@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Added Arnd in Cc.

On 13/07/2020 11:31, Marek Szyprowski wrote:
> Hi
> 
> On 07.07.2020 11:15, Marek Szyprowski wrote:
>> On 06.07.2020 15:46, Daniel Lezcano wrote:
>>> On 06/07/2020 15:17, Marek Szyprowski wrote:
>>>> On 06.07.2020 12:55, Daniel Lezcano wrote:
>>>>> The generic netlink protocol is implemented but the different
>>>>> notification functions are not yet connected to the core code.
>>>>>
>>>>> These changes add the notification calls in the different
>>>>> corresponding places.
>>>>>
>>>>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> This patch landed in today's linux-next 20200706 as commit 5df786e46560
>>>> ("thermal: core: Add notifications call in the framework"). Sadly it
>>>> breaks booting various Samsung Exynos based boards. Here is an example
>>>> log from Odroid U3 board:
>>>>
>>>> Unable to handle kernel NULL pointer dereference at virtual address 
>>>> 00000010
>>>> pgd = (ptrval)
>>>> [00000010] *pgd=00000000
>>>> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>>>> Modules linked in:
>>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-00015-g5df786e46560
>>>> #1146
>>>> Hardware name: Samsung Exynos (Flattened Device Tree)
>>>> PC is at kmem_cache_alloc+0x13c/0x418
>>>> LR is at kmem_cache_alloc+0x48/0x418
>>>> pc : [<c02b5cac>]    lr : [<c02b5bb8>]    psr: 20000053
>>>> ...
>>>> Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
>>>> Control: 10c5387d  Table: 4000404a  DAC: 00000051
>>>> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
>>>> Stack: (0xee8f1cf8 to 0xee8f2000)
>>>> ...
>>>> [<c02b5cac>] (kmem_cache_alloc) from [<c08cd170>] 
>>>> (__alloc_skb+0x5c/0x170)
>>>> [<c08cd170>] (__alloc_skb) from [<c07ec19c>]
>>>> (thermal_genl_send_event+0x24/0x174)
>>>> [<c07ec19c>] (thermal_genl_send_event) from [<c07ec648>]
>>>> (thermal_notify_tz_create+0x58/0x74)
>>>> [<c07ec648>] (thermal_notify_tz_create) from [<c07e9058>]
>>>> (thermal_zone_device_register+0x358/0x650)
>>>> [<c07e9058>] (thermal_zone_device_register) from [<c1028d34>]
>>>> (of_parse_thermal_zones+0x304/0x7a4)
>>>> [<c1028d34>] (of_parse_thermal_zones) from [<c1028964>]
>>>> (thermal_init+0xdc/0x154)
>>>> [<c1028964>] (thermal_init) from [<c0102378>] 
>>>> (do_one_initcall+0x8c/0x424)
>>>> [<c0102378>] (do_one_initcall) from [<c1001158>]
>>>> (kernel_init_freeable+0x190/0x204)
>>>> [<c1001158>] (kernel_init_freeable) from [<c0ab85f4>]
>>>> (kernel_init+0x8/0x118)
>>>> [<c0ab85f4>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
>>>>
>>>> Reverting it on top of linux-next fixes the boot issue. I will
>>>> investigate it further soon.
>>> Thanks for reporting this.
>>>
>>> Can you send the addr2line result and code it points to ?
>>
>> addr2line of c02b5cac (kmem_cache_alloc+0x13c/0x418) points to 
>> mm/slub.c +2839, but I'm not sure if we can trust it. imho it looks 
>> like some trashed memory somewhere, but I don't have time right now to 
>> analyze it further now...
> 
> Just one more thing I've noticed. The crash happens only if the kernel 
> is compiled with old GCC (tested with arm-linux-gnueabi-gcc (Linaro GCC 
> 4.9-2017.01) 4.9.4). If I compile kernel with newed GCC (like 
> arm-linux-gnueabi-gcc (Linaro GCC 6.4-2017.11) 6.4.1 20171012), it works 
> fine...
> 
> This happens also with Linux next-20200710, which again got this commit.
Arnd,

are you aware of any issue with this gcc version which can explain this
kernel panic ? Sounds like the problem does not appear with more recent
version.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
