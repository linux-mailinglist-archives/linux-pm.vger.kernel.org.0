Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EFCBBA69
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 19:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389737AbfIWR15 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 13:27:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389338AbfIWR15 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 13:27:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so9156916ljj.5;
        Mon, 23 Sep 2019 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ynd2Huq/W1JVW4gwoa1s+Sns1ACUyaWf0IT0B4FOulY=;
        b=uR4Tos2pgCCsXD8pWPJOv3IBomp+UsSW614q3eidHlx92imCTEi85ptduWUDMapBjc
         a2kKOefmKPtJYpFtkrpCf+FXC0vt4qjM+GSR00hqupIN/ijRF9VhmTOGazn8K2QH5dp4
         sqB3o2JWA1qWOl1NHgmgpHRd1OhesrCLgXBxastTwNQ+LD90n/4fv25aziWAQnlFobGU
         8erPNpVaq7r1zraLzgVqZ4JnJpvgdkofQ6xc6UkhM4UhSOCKtvpGkllc3NmHviWMM3u1
         aM1Bj/qqfxGVCwn0mf1awhWr0l3xjI2xp3g0N1a187VGjv/VK1G6H7sJzyPFv8PO45RQ
         aNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ynd2Huq/W1JVW4gwoa1s+Sns1ACUyaWf0IT0B4FOulY=;
        b=uRaYwmVkkbL5GuDDPk9T3/l1ZYgAz31RlSlc6kBAP/8PkIQB8fwshi/qLLU/yrHiKR
         I2J1anatRIAsuZScw96mp7IOzmquOfGDn+s/q9xeJcBEHkVMUV8uKPB2Nsa73FzPwW8N
         0dEglh+3gu3FighmFvV+OknJEE4x7rsLG2aepPSRYn30sqWOI+fGS2qfKxr5s+Y7TogN
         J1KDn9xQkBClexHXbzrO7/QQCA9K7YptpZIjk83jPHxCAghMA2I0qtxraY3lJsMgGBQL
         BYmzdB/ZfQc3J4z6tngdXXpc3ABAaqd5W5IU7B26unkmxFa8qkO3fYtWIfsMXjImCIN3
         Tk8A==
X-Gm-Message-State: APjAAAXNAlXslDtKzG3BzAZ6+2UAU/zqGPlrgLsyDGoERYVKK+4slwxj
        je3E9frhzia7zdTwPkmGlpIgHYn3
X-Google-Smtp-Source: APXvYqxTC9/fZLOhVSWwi3ml6goC4lcaHDI+ml5SYAhK5B9bK/99xXzQwN3pd1bpWnMfcc6dL2sBfw==
X-Received: by 2002:a2e:b4c4:: with SMTP id r4mr302405ljm.69.1569259672854;
        Mon, 23 Sep 2019 10:27:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id r5sm2338437lfc.85.2019.09.23.10.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:27:52 -0700 (PDT)
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
 <20190923135654.wcsdl5jdzxqeht3l@vireshk-mac-ubuntu>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <16bfccc5-36d5-3050-fd8d-5bce59e2d7b3@gmail.com>
Date:   Mon, 23 Sep 2019 20:27:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923135654.wcsdl5jdzxqeht3l@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.09.2019 16:56, Viresh Kumar пишет:
> On 22-09-19, 23:12, Dmitry Osipenko wrote:
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
> 
> Hi Dmitry,
> 
> Unfortunately I am traveling right now and can't test this stuff, though I may
> have found the root cause here. Can you please test the below diff for me ?
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 6c90fd7e2ff8..9ac244ee05fe 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -328,6 +328,8 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>         spin_unlock_irq(&dev->power.lock);
>  
>         kfree(qos->resume_latency.notifiers);
> +       kfree(qos->min_frequency.notifiers);
> +       kfree(qos->max_frequency.notifiers);
>         kfree(qos);
>  
>   out:
> 

Doesn't help. The use-after-free bugs are usually caused by a missing
NULL assignment after kfree(), like in this snippet:

	..
	if (!a)
		a = kmalloc();
	..
	kfree(a);
	// a = NULL    <-- missing!
	..

I briefly looked through the code and don't see anything obviously
wrong. The bug isn't critical since unlikely that somebody reloads
cpufreq module for a non-development purposes, so it's not a big deal
and can wait. Please take your time.

I also want to point out that kernel crashes after second module reload,
hence the KASAN report should be valid.
