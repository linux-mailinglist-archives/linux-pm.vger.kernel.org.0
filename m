Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC7D77A2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfJONpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 09:45:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43916 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfJONpw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 09:45:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so20296002ljj.10;
        Tue, 15 Oct 2019 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XhBJozkHE/xedpBrZ0VCd5Q5zH6PXHTbsKH5oegYHnQ=;
        b=bnNiPZHWndkW6jXXwA3cbLqWpwLIc5FZqIHyNeFd1K8SfL0US0DoBSGO8+LByTR/8a
         uuUPtym+3M0sirpu0GPLRbmG4olfMmVVhgsdCa/jSPC2AQya1FHmp2bFaF2BVfI60QSp
         IwigxDJhtvFyV6E5pJW6qu0covk8D5NwhkOhWXyq9gSufBBOibPvY9TCfIOBczQmqBkF
         bEd88lQfgPGs6f4akbTkXlMgPP6M/ZUYI/M1bqiia2X6YLCfNMtjKMypDgWExF4tkZd7
         73M7NRIFgLREwM2WCOx7usgaCh7eGt49tuxnbAMoY1D1a0tqrYF5d5dSNPUH+ILJHaE2
         jlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XhBJozkHE/xedpBrZ0VCd5Q5zH6PXHTbsKH5oegYHnQ=;
        b=dBjjt1kXxJcCRIqau5BW38sxtS0jWkNIJ3tuThf5TY1GDtOOxkcHTF//XvNSdt00t4
         6IAZBiFhVCqa334kV1sPJzALlA+E0FV2h3ZnsMIx0ZILqyh7bngJguuzuiNUM+T4tQBA
         cNH4/KYmWO+OlEUIIHDK0ugB1vrV92nrKmmtbdZLRiPT/fKUhhxq2a/e3OuAV/LcZFmJ
         3V8oCzFBJzj2Mx19fPVMpLMcWwmc5e6WzTt3fSgWyFob6bT5NcgXtfZVaJOUD+f38zey
         detO3TQP4vIHMUV9l6jHFRauEp0hSYkTLBS55IoHi8zDlC1xya4zkwpjvwL6VpZAwL0n
         lJMQ==
X-Gm-Message-State: APjAAAWoleCAlUumUuKYjN+mUh2dNyRBieeOmJXp42oaucUVBdb3p6Y4
        LvyoyfYXl5w9pkiCbCGNkO1YGTrR
X-Google-Smtp-Source: APXvYqxDA51lkLWNTaf8bBq//P4W4VfYR0u+eBP4O+satZqN4rgC0XPhHwULT0gp3lRytqRDKtnXSw==
X-Received: by 2002:a2e:8593:: with SMTP id b19mr22488107lji.34.1571147148483;
        Tue, 15 Oct 2019 06:45:48 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id c3sm4909990lfi.32.2019.10.15.06.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:45:47 -0700 (PDT)
Subject: Re: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS
 framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        ulf.hansson@linaro.org, sfr@canb.auug.org.au, pavel@ucw.cz,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
 <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
 <a1c503a7-6136-a405-369c-596a680183f2@gmail.com>
 <20191015114637.pcdbs2ctxl4xoxdo@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0d0b050a-4d79-2e65-5d71-dfd662310e1f@gmail.com>
Date:   Tue, 15 Oct 2019 16:45:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191015114637.pcdbs2ctxl4xoxdo@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.10.2019 14:46, Viresh Kumar пишет:
> On 22-09-19, 23:12, Dmitry Osipenko wrote:
>> Hello Viresh,
>>
>> This patch causes use-after-free on a cpufreq driver module reload. Please take a look, thanks in advance.
>>
>>
>> [   87.952369] ==================================================================
>> [   87.953259] BUG: KASAN: use-after-free in notifier_chain_register+0x4f/0x9c
>> [   87.954031] Read of size 4 at addr e6abbd0c by task modprobe/243
>>
>> [   87.954901] CPU: 1 PID: 243 Comm: modprobe Tainted: G        W
>> 5.3.0-next-20190920-00185-gf61698eab956-dirty #2408
>> [   87.956077] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> [   87.956807] [<c0110aad>] (unwind_backtrace) from [<c010bb71>] (show_stack+0x11/0x14)
>> [   87.957709] [<c010bb71>] (show_stack) from [<c0d37b25>] (dump_stack+0x89/0x98)
>> [   87.958616] [<c0d37b25>] (dump_stack) from [<c02937e1>]
>> (print_address_description.constprop.0+0x3d/0x340)
>> [   87.959785] [<c02937e1>] (print_address_description.constprop.0) from [<c0293c6b>]
>> (__kasan_report+0xe3/0x12c)
>> [   87.960907] [<c0293c6b>] (__kasan_report) from [<c014988f>] (notifier_chain_register+0x4f/0x9c)
>> [   87.962001] [<c014988f>] (notifier_chain_register) from [<c01499b5>]
>> (blocking_notifier_chain_register+0x29/0x3c)
>> [   87.963180] [<c01499b5>] (blocking_notifier_chain_register) from [<c06f7ee9>]
>> (dev_pm_qos_add_notifier+0x79/0xf8)
>> [   87.964339] [<c06f7ee9>] (dev_pm_qos_add_notifier) from [<c092927d>] (cpufreq_online+0x5e1/0x8a4)
>> [   87.965351] [<c092927d>] (cpufreq_online) from [<c09295c9>] (cpufreq_add_dev+0x79/0x80)
>> [   87.966247] [<c09295c9>] (cpufreq_add_dev) from [<c06eb9d3>] (subsys_interface_register+0xc3/0x100)
>> [   87.967297] [<c06eb9d3>] (subsys_interface_register) from [<c0926e53>]
>> (cpufreq_register_driver+0x13b/0x1ec)
>> [   87.968476] [<c0926e53>] (cpufreq_register_driver) from [<bf800435>]
>> (tegra20_cpufreq_probe+0x165/0x1a8 [tegra20_cpufreq])
> 
> Hi Dmitry,
> 
> Thanks for the bug report and I was finally able to reproduce it at my end and
> this was quite an interesting debugging exercise :)
> 
> When a cpufreq driver gets registered, we register with the subsys interface and
> it calls cpufreq_add_dev() for each CPU, starting from CPU0. And so the QoS
> notifiers get added to the first CPU of the policy, i.e. CPU0 in common cases.
> 
> When the cpufreq driver gets unregistered, we unregister with the subsys
> interface and it calls cpufreq_remove_dev() for each CPU, starting from CPU0
> (should have been in reverse order I feel). We remove the QoS notifier only when
> cpufreq_remove_dev() gets called for the last CPU of the policy, lets call it
> CPUx. Now this has a different notifier list as compared to CPU0.
> 
> In short, we are adding the cpufreq notifiers to CPU0 and removing them from
> CPUx. When we try to add it again by inserting the module for second time, we
> find a node in the notifier list which is already freed but still in the list as
> we removed it from CPUx's list (which doesn't do anything as the node wasn't
> there in the first place).
> 
> @Rafael: How do you see we solve this problem ? Here are the options I could
> think of:
> 
> - Update subsys layer to reverse the order of devices while unregistering (this
>   will fix the current problem, but we will still have corner cases hanging
>   around, like if the CPU0 is hotplugged out, etc).
> 
> - Update QoS framework with the knowledge of related CPUs, this has been pending
>   until now from my side. And this is the thing we really need to do. Eventually
>   we shall have only a single notifier list for all CPUs of a policy, at least
>   for MIN/MAX frequencies.
> 
> - ??
> 

Viresh, thank you very much! Looking forward to a fix :)
