Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83BA64DDB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 22:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGJUyJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 16:54:09 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36902 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJUyJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 16:54:09 -0400
Received: by mail-wr1-f48.google.com with SMTP id n9so3895869wrr.4
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2019 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ps4kQfzGq5gpWNZxk/C1CFE6R6ZOY8VylpxaBfWoytU=;
        b=QJUKXbVp0jU72Yc403EAJF2UhwXD8aqYcaIhJAeZkDfgOZZYySAlgl4Ow44xbSgOQ3
         WmUJdY1iuhyMIBXA4pyNC6oAJL1AagdQQeFol2G95Nbeh8Zu//oOIXUlPFDgqzHBS13l
         5bZHSQiTNlBns9g8TNlfZzKtmydeL4Sc3Xi4w1RbHedFRXOS385pXsFvBxLclbVUGlT0
         U+ZxX9nEU/OtcbOtfFplrAaONSCMZg6PG979cSEFB4dHCC1zNH279TZ4F7MepZZehg0F
         GkYhO/UKiNgxzuddyioC+PtRcIPUphKbHicO+jtFFxnt3viIimMQl8t9qC0C23pN9u6X
         034A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ps4kQfzGq5gpWNZxk/C1CFE6R6ZOY8VylpxaBfWoytU=;
        b=PIAJuCZRQZynbZR+OlHF7XnzZ0IWE0tBKs80cRd/2yWAdlv7CvAe8P7H1vZAwXrp0w
         EvEf0zKZVba+FuZA+5knpXq1K3L0YXQEWWY5Q84wpKtp1pssEjiQ/TZQaluW+tSVCbiY
         pQX4THjC3+P8JESfYwxDMR/I6sdsOZxDTS+kOf3W3Qi1G+4cQnuP61IxXylDjTaIvrIS
         9IFNNdFDT7pgcTXrQpXqS5wG1R0h74qb1cTUGqHgXCRfdajLcUQTChfN9tPVrfgq57wF
         GrNJkgKQjSLyhGbsSXRWfWjRMRltv+YeWd02neuSJNqU59380R5QY6xgNizVLyyeDCTk
         zmNw==
X-Gm-Message-State: APjAAAWZNhhlCYziIXP2p40pY/4TdL5OrV6/wOQeVCoNQWUedLZwHfpU
        Mz+KCoxowCv5726N/nNrZMsn4aqL
X-Google-Smtp-Source: APXvYqxMqI8jmXX/j1f8n+oXy1gdXAhoeW2W3+alUeM2wKz65LyGboP6V4Y2Iy3GIwbszXdzpptqlQ==
X-Received: by 2002:adf:8bd1:: with SMTP id w17mr12872490wra.50.1562792045692;
        Wed, 10 Jul 2019 13:54:05 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd6:c00:54ae:9c17:4aac:c628? (p200300EA8BD60C0054AE9C174AACC628.dip0.t-ipconnect.de. [2003:ea:8bd6:c00:54ae:9c17:4aac:c628])
        by smtp.googlemail.com with ESMTPSA id y12sm1924189wrm.79.2019.07.10.13.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:54:04 -0700 (PDT)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: cpufreq-related deadlock warning on recent linux-next
Message-ID: <6addb70f-6b21-4f09-e1a0-21476b55df14@gmail.com>
Date:   Wed, 10 Jul 2019 22:53:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I just got the following when manually suspending the system with
"systemctl suspend" and waking it up with the power button.


[  380.203172] Restarting tasks ... done.

[  380.211714] ============================================
[  380.211719] WARNING: possible recursive locking detected
[  380.211726] 5.2.0-rc7-next-20190704+ #2 Not tainted
[  380.211731] --------------------------------------------
[  380.211737] systemd-sleep/2367 is trying to acquire lock:
[  380.211745] 0000000043cf69ce (&policy->rwsem){+.+.}, at: refresh_frequency_limits+0x36/0x90
[  380.211761]
               but task is already holding lock:
[  380.211767] 0000000043cf69ce (&policy->rwsem){+.+.}, at: cpufreq_cpu_acquire+0x25/0x50
[  380.211777]
               other info that might help us debug this:
[  380.211783]  Possible unsafe locking scenario:

[  380.211789]        CPU0
[  380.211792]        ----
[  380.211795]   lock(&policy->rwsem);
[  380.211800]   lock(&policy->rwsem);
[  380.211805]
                *** DEADLOCK ***

[  380.211811]  May be due to missing lock nesting notation

[  380.211818] 8 locks held by systemd-sleep/2367:
[  380.211823]  #0: 000000000e253e21 (sb_writers#5){.+.+}, at: vfs_write+0x16b/0x1d0
[  380.211835]  #1: 00000000d0140159 (&of->mutex){+.+.}, at: kernfs_fop_write+0xfd/0x1c0
[  380.211846]  #2: 00000000383c283a (kn->count#155){.+.+}, at: kernfs_fop_write+0x105/0x1c0
[  380.211857]  #3: 000000007e6f342b (system_transition_mutex){+.+.}, at: pm_suspend.cold+0xd0/0x36a
[  380.211869]  #4: 000000002ee59360 ((pm_chain_head).rwsem){++++}, at: __blocking_notifier_call_chain+0x46/0x80
[  380.211883]  #5: 000000003972eb2e (&tz->lock){+.+.}, at: step_wise_throttle+0x3f/0x90
[  380.211893]  #6: 0000000007747f02 (&cdev->lock){+.+.}, at: thermal_cdev_update+0x1e/0x16c
[  380.211904]  #7: 0000000043cf69ce (&policy->rwsem){+.+.}, at: cpufreq_cpu_acquire+0x25/0x50
[  380.211914]
               stack backtrace:
[  380.211921] CPU: 1 PID: 2367 Comm: systemd-sleep Not tainted 5.2.0-rc7-next-20190704+ #2
[  380.211929] Hardware name: NA ZBOX-CI327NANO-GS-01/ZBOX-CI327NANO-GS-01, BIOS 5.12 04/26/2018
[  380.211937] Call Trace:
[  380.211944]  dump_stack+0x70/0xa0
[  380.211950]  __lock_acquire.cold+0xc0/0x206
[  380.211957]  lock_acquire+0x90/0x190
[  380.211963]  ? refresh_frequency_limits+0x36/0x90
[  380.211970]  down_write+0x38/0x80
[  380.211975]  ? refresh_frequency_limits+0x36/0x90
[  380.211981]  refresh_frequency_limits+0x36/0x90
[  380.211987]  ? cpufreq_cpu_get+0x60/0x70
[  380.211993]  ? cpufreq_get_policy+0x5e/0x70
[  380.212000]  ? __module_text_address+0x10/0x60
[  380.212006]  ? is_module_text_address+0x18/0x29
[  380.212013]  ? kernel_text_address+0x3e/0x90
[  380.212019]  ? __kernel_text_address+0x10/0x40
[  380.212026]  ? unwind_get_return_address+0x1c/0x30
[  380.212034]  ? __thaw_task+0x50/0x50
[  380.212040]  ? arch_stack_walk+0xa2/0xf0
[  380.212046]  ? stack_trace_save+0x55/0x80
[  380.212052]  ? alloc_list_entry+0x15/0x60
[  380.212058]  ? __lock_acquire+0x1067/0x1940
[  380.212064]  ? cpufreq_cpu_acquire+0x25/0x50
[  380.212071]  ? down_write+0x38/0x80
[  380.212076]  ? cpufreq_cpu_acquire+0x25/0x50
[  380.212082]  cpufreq_update_policy+0x51/0x70
[  380.212089]  cpufreq_set_cur_state.part.0+0x82/0xa0
[  380.212096]  processor_set_cur_state+0xa1/0x110
[  380.212102]  thermal_cdev_update+0x86/0x16c
[  380.212108]  step_wise_throttle+0x58/0x90
[  380.212114]  handle_thermal_trip+0x80/0x240
[  380.212120]  thermal_zone_device_update.part.0+0x68/0x1a0
[  380.212127]  thermal_pm_notify+0x10f/0x130
[  380.212133]  notifier_call_chain+0x53/0x80
[  380.212139]  __blocking_notifier_call_chain+0x5f/0x80
[  380.212146]  pm_notifier_call_chain+0x22/0x40
[  380.212151]  pm_suspend.cold+0x341/0x36a
[  380.212157]  state_store+0x7d/0xe0
[  380.212162]  kobj_attr_store+0x33/0x50
[  380.212168]  sysfs_kf_write+0x46/0x60
[  380.212174]  kernfs_fop_write+0x134/0x1c0
[  380.212181]  __vfs_write+0x37/0x70
[  380.212186]  vfs_write+0xdc/0x1d0
[  380.212191]  ksys_write+0x6e/0xf0
[  380.212196]  __x64_sys_write+0x19/0x20
[  380.212202]  do_syscall_64+0x50/0x1a0
[  380.212209]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  380.212216] RIP: 0033:0x7f0fd7e801f8
[  380.212223] Code: 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 25 50 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 60 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  380.212238] RSP: 002b:00007ffc3d20f288 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  380.212247] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f0fd7e801f8
[  380.212253] RDX: 0000000000000004 RSI: 00007ffc3d20f370 RDI: 0000000000000004
[  380.212260] RBP: 00007ffc3d20f370 R08: 00007f0fd66a6840 R09: 0000561ed5a28e50
[  380.212267] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
[  380.212273] R13: 0000561ed5a27290 R14: 0000000000000004 R15: 00007f0fd7f507c0
[  382.995704] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control rx/tx
