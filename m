Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9002A679F2
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2019 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfGMLYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Jul 2019 07:24:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33575 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMLYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jul 2019 07:24:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so10905166wme.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Jul 2019 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8xkSC0VROCxML4cXy2uTReuWmPLKOSWduXGHO9Bgs64=;
        b=o2vB/8v2mYJvmbd0dFDIcvZfOK+aXgOrF7lc5CNEzhMehHvDVCx5u5A7HEo8UNf8VX
         J599zNvU/GlRU34Sq6/cil4R4ha4XpwPITiKKoOmLaHzkN93PmsIJS6hyePI7vmiiQNg
         fKZf2wqfwl04F1Hv6g0KEnLJfza9fntgjQpgzOdlAp9n5iMzsOdCuoHlVnhiJt/ZWFYn
         sWgsVad0Rs44fEna0nc6Sx2mG7gDzJHWaon5mmz66s1P045sGltYsx86un2Ns+EEBcuq
         72mF5f52JcZFal/oLXb+fIycrhYAq36B+kMRs4EVDXfQBAACziZMqb9CyKYMA2E7WFcB
         wuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8xkSC0VROCxML4cXy2uTReuWmPLKOSWduXGHO9Bgs64=;
        b=HQfatCMy7C47YqN08/gfUp90yBMP7QoZ9xy6YyQVM37Y/XwkRfYxdvz6Ti4f4dikDk
         cFWhj/lUCVmu5p0yolqEvEmz8A0UcEJKN6LSUeCDhRTf1mpqoOWRW+SJZQHkzlQP9tyC
         9STpl31j4GjItipjzqvYZU6KuKumqyuqZ6NF17YThvAnlQWywyx+mKmOOWfA9Bk97srV
         oG95/MK+ZSl9F3Ik7Tdy72gSuzBSJ4CNG+lK7vJa/ik05tmn5x+YfcLvpjOeXPsMChip
         bLrJAQr+yqRZCFVTK/3Fo0ht6P9xJZvskhONKe8Xwvj43A2rr951OAyxJZz2NU2xFgdk
         FoJw==
X-Gm-Message-State: APjAAAXhcZgNpKiC4liahO3zy4RuTqfKmuoI6Kzf1KRRZ6t4t7Ac9/a6
        5/SXQutNx5KnBtrZJhypo4tZwlIA
X-Google-Smtp-Source: APXvYqymNILwwCpN7TVaimAjj3WlNkAuXTzdaUXfpzhIqkbHOU5/ubJheNO7PKwX1dK4318VF540+g==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr14484940wme.104.1563017076079;
        Sat, 13 Jul 2019 04:24:36 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd6:c00:9c47:80d8:6d49:f2a9? (p200300EA8BD60C009C4780D86D49F2A9.dip0.t-ipconnect.de. [2003:ea:8bd6:c00:9c47:80d8:6d49:f2a9])
        by smtp.googlemail.com with ESMTPSA id j33sm23818003wre.42.2019.07.13.04.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 04:24:35 -0700 (PDT)
Subject: Re: cpufreq-related deadlock warning on recent linux-next
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
References: <6addb70f-6b21-4f09-e1a0-21476b55df14@gmail.com>
 <20190711022813.zfroyk3drfarvpwj@vireshk-i7>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <edd74314-869c-e4e3-76bf-35962165153e@gmail.com>
Date:   Sat, 13 Jul 2019 13:24:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190711022813.zfroyk3drfarvpwj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11.07.2019 04:28, Viresh Kumar wrote:
> On 10-07-19, 22:53, Heiner Kallweit wrote:
>> I just got the following when manually suspending the system with
>> "systemctl suspend" and waking it up with the power button.
>>
>>
>> [  380.203172] Restarting tasks ... done.
>>
>> [  380.211714] ============================================
>> [  380.211719] WARNING: possible recursive locking detected
>> [  380.211726] 5.2.0-rc7-next-20190704+ #2 Not tainted
>> [  380.211731] --------------------------------------------
>> [  380.211737] systemd-sleep/2367 is trying to acquire lock:
>> [  380.211745] 0000000043cf69ce (&policy->rwsem){+.+.}, at: refresh_frequency_limits+0x36/0x90
>> [  380.211761]
>>                but task is already holding lock:
>> [  380.211767] 0000000043cf69ce (&policy->rwsem){+.+.}, at: cpufreq_cpu_acquire+0x25/0x50
>> [  380.211777]
>>                other info that might help us debug this:
>> [  380.211783]  Possible unsafe locking scenario:
>>
>> [  380.211789]        CPU0
>> [  380.211792]        ----
>> [  380.211795]   lock(&policy->rwsem);
>> [  380.211800]   lock(&policy->rwsem);
>> [  380.211805]
>>                 *** DEADLOCK ***
>>
>> [  380.211811]  May be due to missing lock nesting notation
>>
>> [  380.211818] 8 locks held by systemd-sleep/2367:
>> [  380.211823]  #0: 000000000e253e21 (sb_writers#5){.+.+}, at: vfs_write+0x16b/0x1d0
>> [  380.211835]  #1: 00000000d0140159 (&of->mutex){+.+.}, at: kernfs_fop_write+0xfd/0x1c0
>> [  380.211846]  #2: 00000000383c283a (kn->count#155){.+.+}, at: kernfs_fop_write+0x105/0x1c0
>> [  380.211857]  #3: 000000007e6f342b (system_transition_mutex){+.+.}, at: pm_suspend.cold+0xd0/0x36a
>> [  380.211869]  #4: 000000002ee59360 ((pm_chain_head).rwsem){++++}, at: __blocking_notifier_call_chain+0x46/0x80
>> [  380.211883]  #5: 000000003972eb2e (&tz->lock){+.+.}, at: step_wise_throttle+0x3f/0x90
>> [  380.211893]  #6: 0000000007747f02 (&cdev->lock){+.+.}, at: thermal_cdev_update+0x1e/0x16c
>> [  380.211904]  #7: 0000000043cf69ce (&policy->rwsem){+.+.}, at: cpufreq_cpu_acquire+0x25/0x50
> 
> This is already fixed in linux-next few days back. Can you try the
> latest stuff again ?
> 
linux-next from Jul 12th is fine.

Thanks, Heiner
