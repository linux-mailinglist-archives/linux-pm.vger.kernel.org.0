Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20932118D70
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJQVv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:21:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42525 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfLJQVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:21:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so20556026ljo.9;
        Tue, 10 Dec 2019 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XgcYNjdeceF7X7AAaXp087bGaoicu0qayGBfhAoZSuY=;
        b=M+NWGQaG4WvOcvo7NTjSzVAeian+2Cqts+FSRlPWVphWlAIOZEvswaSHsPDvt6xHL2
         IpTGWy5nPQYiMH8MSr3PeEz3TPy0uUWJoKOtZNExqHA6lreqksC5PuVknPdQA/0M++MM
         aiGUc9KX7Z3xRnpfCleJOgC7KMgUb94GlsFP8gGut8lzUljsHy8v2nFBkWd1b103bKCL
         bZCumfLO5KcEIp7qKf36KPZ+G5VQvZQ4rjNrFy2Vj4/1hsCzNshI6QsALa1ae5+7QxyG
         WSDbw+/ADxijndmi1BgJWnOCjjfnGoO/ywJWUHLm8P/lRu7iyqVSC/YjB/VlfGWe2uNi
         OnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XgcYNjdeceF7X7AAaXp087bGaoicu0qayGBfhAoZSuY=;
        b=e4lKpnl3fKPzaJsnNDQLfr/M5Jlq6a01bfjqmQpkn2jXFpoey9h5xijqlEh3i8//rJ
         uBplkkNp3qDnxPiqYN4TVsS5RLjLAHZhTVS6qdlrByc53a0lZnm6qxTcwDpUylfynV9Z
         vAx6zmseOeDlk3SC0z6kC4QvMg7fkH1gtstMSKGTxRrD7cStVsepZ8Bwurq64kgtVI2t
         bp1QVnWKHrajGJ4xxis2cn9pCsONcRrnRzJujo3NiM4AdiLQg13Xz3MIZ+EeK4rkZqBi
         4w/BBX/F7osFqiAvzlfwdNBEiKcUqdiqBJyQIHtH2XAABwv8EDr+xaTOJHWlwN3S+pI6
         0Tng==
X-Gm-Message-State: APjAAAXl57Tb3QJUkXWcrwnOv9t5NDwhcMWahQ7+Lrw1wD/Ytwil4M9I
        rkwsUZEytegX0swOob2qzg2gAaC6
X-Google-Smtp-Source: APXvYqzvOUj0ESgJzD0IjA0pBkpl8IH4Z8YUTYFaqXS49+4MF9RMlX3/Y+Ykc0hsV23tBK6rV395Bg==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr21513013ljk.238.1575994907336;
        Tue, 10 Dec 2019 08:21:47 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l23sm1809068lfh.74.2019.12.10.08.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 08:21:46 -0800 (PST)
Subject: Re: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191203004116.11771-1-digetx@gmail.com>
 <20191207215216.GA9561@qmqm.qmqm.pl>
 <0b3a861d-e5e8-ddca-ac60-0a3c61a9d9dc@gmail.com>
 <20191209160420.GA24097@qmqm.qmqm.pl>
 <323f5f70-5249-e75a-98cc-7fdca2d375c2@gmail.com>
 <20191210023549.GA15246@qmqm.qmqm.pl>
 <205cd87d-6957-9457-4ed5-31c534ae0846@gmail.com>
Message-ID: <5de4eb77-276d-e1af-993b-5cdf52e93856@gmail.com>
Date:   Tue, 10 Dec 2019 19:21:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <205cd87d-6957-9457-4ed5-31c534ae0846@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10.12.2019 19:02, Dmitry Osipenko пишет:
> 10.12.2019 05:35, Michał Mirosław пишет:
>> On Tue, Dec 10, 2019 at 12:22:18AM +0300, Dmitry Osipenko wrote:
>>> 09.12.2019 19:04, Michał Mirosław пишет:
>>>> On Sun, Dec 08, 2019 at 01:56:14AM +0300, Dmitry Osipenko wrote:
>>>>> 08.12.2019 00:52, Michał Mirosław пишет:
>>>>>> On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> This series does the following:
>>>>>>>
>>>>>>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>>>>>>>      into common drivers/cpuidle/ directory.
>>>>>>>
>>>>>>>   2. Enables CPU cluster power-down idling state on Tegra30.
>>>>>>>
>>>>>>> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
>>>>>>> and of the Tegra's arch code in general. Please review, thanks!
>>>>>>
>>>>>> I did a quick smoke test for this series on top of Linus' master:
>>>>>>  - rebuilding with the patches applied, CONFIG_ARM_TEGRA_CPUIDLE=n - works
>>>>>>  - building with CONFIG_ARM_TEGRA_CPUIDLE=y - doesn't boot
>>>>>>
>>>>>> The hang is somewhere early in the boot process, before simplefb can
>>>>>> take the console and show any logs. If I get BOOTFB to work again I might
>>>>>> be able to get some more info.
>>>>>
>>>>> Thank you very much for trying these patches!
>>>>>
>>>>> Could you please try to make ARM_TEGRA_CPUIDLE "tristate" in the Kconfig
>>>>> and compile it as a loadable module? That way you'll get framebuffer
>>>>> shown before the hang happens.
>>>>>
>>>>> Does LP2 suspend/resume work for you? There should be
>>>>> "nvidia,suspend-mode = <2>" in the PMC's node of device-tree.
>>>>
>>>> Not at the moment. I also tried suspend-mode = <1> and <0>, but it
>>>> made no difference.
>>>
>>> If LP2 doesn't work, then it explains why you're getting the hang.
>>>
>>> Are you using TF300T for the testing? I'm recalling that LP2 worked for
>>> you sometime ago on TF300T, maybe some offending change was introduced
>>> since then. Could you please try to do the git bisection or at least
>>> find out what is the last good kernel version?
>>>
>>> I rebased this series on a recent linux-next and you could find the
>>> rebased patches here [1].
>>>
>>> [1] https://github.com/grate-driver/linux/commits/master
>>>
>>> With [1] you should be able to remove "nvidia,suspend-mode" property
>>> from the device-tree to get cpuidle working with the disabled CC6 state
>>> (LP2). Could you please check that at least disabled CC6 works for you?
>>
>> I tested suspend with your tree merged, but CONFIG_TEGRA_CPUIDLE=n. LP2
>> seems to work [1]. The same tree with CONFIG_TEGRA_CPUIDLE=y doesn't
>> boot. I'll try comparing DTs, but other than that I'm blocked on BOOTFB now.
> 
> That's an interesting result.
> 
>> [1] rtcwake -s 3 -d /dev/rtc0 -v -m mem
>>
>> (...)
>> [ 2710.157919] PM: suspend entry (deep)
>> [ 2710.161205] Filesystems sync: 0.000 seconds
>> [ 2710.176677] Freezing user space processes ... (elapsed 0.001 seconds) done.
>> [ 2710.178342] OOM killer disabled.
>> [ 2710.178527] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>> [ 2710.347871] Disabling non-boot CPUs ...
>> [ 2710.349160] IRQ 18: no longer affine to CPU1
>> [ 2710.352499] IRQ 19: no longer affine to CPU2
>> [ 2710.370059] IRQ 20: no longer affine to CPU3
>> [ 2710.371284] Entering suspend state LP2
>> [ 2710.371556] Enabling non-boot CPUs ...
>> [ 2710.373157] CPU1 is up
>> [ 2710.374598] CPU2 is up
>> [ 2710.375996] CPU3 is up
>> [ 2710.462876] OOM killer enabled.
>> [ 2710.463018] Restarting tasks ...
>> [ 2710.463880] tegra-devfreq 6000c800.actmon: Failed to get emc clock
>> [ 2710.464509] done.
>> [ 2710.552824] asus-ec 1-0015: model         : ASUS-TF201-PAD
>> [ 2710.558345] asus-ec 1-0015: FW version    : PAD-EC20T-0216
>> [ 2710.562942] asus-ec 1-0015: Config format : ECFG-0001
>> [ 2710.567651] asus-ec 1-0015: HW version    : TF201-PAD-SKU1
>> [ 2710.572488] asus-ec 1-0015: EC FW behaviour: susb on when system wakeup
>> [ 2710.769796] atkbd serio1: no of_node; not parsing pinctrl DT
>> [ 2710.835629] asus-ec 5-0019: model         : ASUS-TF201-DOCK
>> [ 2710.838686] asus-ec 5-0019: FW version    : DOCK-EC20N-0207
>> [ 2710.841865] asus-ec 5-0019: Config format : ECFG-0001
>> [ 2710.844271] asus-ec 5-0019: HW version    : PCBA-SKU-2
>> [ 2710.847950] asus-ec 5-0019: EC FW behaviour: susb on when receive ec_req
>> [ 2711.040935] PM: suspend exit
>>
> 
> Could you please try this change on top of recent grate-linux (it should
> allow display to light up before the hang):
> 
> diff --git a/drivers/cpuidle/cpuidle-tegra.c
> b/drivers/cpuidle/cpuidle-tegra.c
> index db9ccba5a74c..21317b4e16c1 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -22,6 +22,7 @@
>  #include <linux/ktime.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
> +#include <linux/workqueue.h>
> 
>  #include <linux/clk/tegra.h>
>  #include <linux/firmware/trusted_foundations.h>
> @@ -332,7 +333,7 @@ static void tegra_cpuidle_setup_tegra114_c7_state(void)
>  	s->exit_latency = 500;
>  }
> 
> -static int tegra_cpuidle_probe(struct platform_device *pdev)
> +static void tegra_cpuidle_probe_work(struct work_struct *work)
>  {
>  	/* LP2 could be disabled in device-tree */
>  	if (tegra_pmc_get_suspend_mode() < TEGRA_SUSPEND_LP2)
> @@ -372,10 +373,18 @@ static int tegra_cpuidle_probe(struct
> platform_device *pdev)
>  		break;
> 
>  	default:
> -		return -EINVAL;
> +		return;
>  	}
> 
> -	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
> +	cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
> +}
> +
> +static DECLARE_DELAYED_WORK(delayed_probe, tegra_cpuidle_probe_work);
> +
> +static int tegra_cpuidle_probe(struct platform_device *pdev)
> +{
> +	schedule_delayed_work(&delayed_probe, 5 * HZ);
> +	return 0;
>  }
> 
>  static struct platform_driver tegra_cpuidle_driver = {
> 

Also, do you have CONFIG_ARM_TEGRA20_CPUFREQ=y? Please try to disable it
if it's enabled and if you enabled CPU OPPs in the device-tree.
