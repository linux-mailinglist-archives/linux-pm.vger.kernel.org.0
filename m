Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4B8C3C2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 23:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHMVdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 17:33:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39461 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfHMVdA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 17:33:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so107883867qtu.6
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=qCbB+P5oHA9cZT/nz3Y/aGC8nM9/7bB2HylO7P1DLH0=;
        b=bR3xyAb5DYDi5lyhiOo5mBPz5yoUVJC933X8edJw5MHjQdVxcXXzUDSUvmJcNyOdjo
         YUGyXFKe4XJZ3RCAhhN6rmlBuf6N7UOCckovrJ6QPsaTrsTEndmO2rtY0BAvttWKiXr8
         X775u1AfnnXV2oWsGhrphvYMdWIgWHj4VXvHVeLmHN+Dp6ZdDFZ8QRSx9hFiCMTMbqVs
         WW3G/WB8dCIlt3S10CJRxOxsr8D9/KsZYTGznxZAr6A+fC+TXHKUWYMBSpBbwQihOMQW
         s/YGmq1LvJ3mTTGkIu9EfqCSubl0Kpgg6Mw/b8kzXW9WS8hBt/XyLYIpj6u/1byZU6Az
         G/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=qCbB+P5oHA9cZT/nz3Y/aGC8nM9/7bB2HylO7P1DLH0=;
        b=jFpa8WqFXpme5lyidyAhlzQZDqfKLvLGOsG3pFp2fQuPFCAw/sr5UbA1NkNaXvu0cL
         om7pdhCTq6km725yRFdX4BqXXE997vSiYDgjk52wV29H7Pvfh2VQ6q1kuQj75FGBNGWj
         MTCKaEB03ecDps0vkvrI2p4cNajhBrPWGQoOkJZVRw5BPOGUDy1JMsB8LRKMq/uhFUtk
         L9ZC53t6eiJeIklOkVGzJSqjUH9dKKAVvwlyfj/somRTrS3Ly9K07nN4b6j19zCNUk7a
         d7ZK87LP+QILECKzaN7kLW6UpvUIzbInRWNLFXUAe21PEVt5l6k2P4VEc+uY7dm24vpg
         WytA==
X-Gm-Message-State: APjAAAXnHg3TD9o2c4zwoFCcY6WYnQKuSlULTOGJE8d37NK25uuT3M05
        YmTvIM98pPnZyhWSnSJCVvX2uA==
X-Google-Smtp-Source: APXvYqzl5VHWHWJkDK+Cj5EMkuSBm4Co/Zg0gkn5tC+QN2hCZnLwbpKQmICGAhd+7CI3BeVXbt5plw==
X-Received: by 2002:ac8:24b4:: with SMTP id s49mr11675536qts.255.1565731978799;
        Tue, 13 Aug 2019 14:32:58 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o18sm5935478qtt.4.2019.08.13.14.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 14:32:58 -0700 (PDT)
Message-ID: <1565731976.8572.16.camel@lca.pw>
Subject: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot
 warnings
From:   Qian Cai <cai@lca.pw>
To:     Tri Vo <trong@android.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Aug 2019 17:32:56 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The linux-next commit "PM / wakeup: Show wakeup sources stats in sysfs" [1]
introduced some baddies during boot on several x86 servers. Reverted the commit
fixed the issue.

[1] https://lore.kernel.org/lkml/20190807014846.143949-4-trong@android.com/

[   39.195053][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[   39.197347][    T1] kobject_add_internal failed for wakeup (error: -2 parent:
serio0)
[   39.199845][    T1] INFO: trying to register non-static key.
[   39.201582][    T1] the code is fine but needs lockdep annotation.
[   39.203477][    T1] turning off the locking correctness validator.
[   39.205399][    T1] CPU: 12 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc4-
next-20190813 #3
[   39.207938][    T1] Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420
Gen9, BIOS U19 12/27/2015
[   39.210606][    T1] Call Trace:
[   39.210606][    T1]  dump_stack+0x62/0x9a
[   39.210606][    T1]  register_lock_class+0x95a/0x960
[   39.210606][    T1]  ? __platform_driver_probe+0xcd/0x230
[   39.210606][    T1]  ? __platform_create_bundle+0xc0/0xe0
[   39.210606][    T1]  ? i8042_init+0x4ec/0x578
[   39.210606][    T1]  ? do_one_initcall+0xfe/0x45a
[   39.219571][    T1]  ? kernel_init_freeable+0x614/0x6a7
[   39.219571][    T1]  ? kernel_init+0x11/0x138
[   39.219571][    T1]  ? ret_from_fork+0x35/0x40
[   39.219571][    T1]  ? is_dynamic_key+0xf0/0xf0
[   39.219571][    T1]  ? rwlock_bug.part.0+0x60/0x60
[   39.219571][    T1]  ? __debug_check_no_obj_freed+0x8e/0x250
[   39.219571][    T1]  __lock_acquire.isra.13+0x5f/0x830
[   39.229491][    T1]  ? __debug_check_no_obj_freed+0x152/0x250
[   39.229491][    T1]  lock_acquire+0x107/0x220
[   39.229491][    T1]  ? __pm_relax.part.2+0x21/0xa0
[   39.229491][    T1]  _raw_spin_lock_irqsave+0x35/0x50
[   39.229491][    T1]  ? __pm_relax.part.2+0x21/0xa0
[   39.229491][    T1]  __pm_relax.part.2+0x21/0xa0
[   39.239588][    T1]  wakeup_source_destroy.part.3+0x18/0x190
[   39.239588][    T1]  wakeup_source_register+0x43/0x50
[   39.239588][    T1]  device_wakeup_enable+0x76/0x170
[   39.239588][    T1]  device_set_wakeup_enable+0x13/0x20
[   39.239588][    T1]  i80probe+0x921/0xa45
[   39.339546][    T1]  ? i8042_toggle_aux+0xeb/0xeb
[   39.349486][    T1]  ? kernfs_create_link+0xce/0x100
[   39.349486][    T1]  ? sysfs_do_create_link_sd+0x7b/0xe0
[   39.349486][    T1]  ? acpi_dev_pm_attach+0x31/0xf0
[   39.349486][    T1]  platform_drv_probe+0x51/0xe0
[   39.349486][    T1]  really_probe+0x1a2/0x630
[   39.349486][    T1]  ? device_driver_attach+0xa0/0xa0
[   39.349486][    T1]  driver_probe_device+0xcd/0x1f0
[   39.359562][    T1]  ? device_driver_attach+0xa0/0xa0
[   39.359562][    T1]  device_driver_attach+0x8f/0xa0
[   39.359562][    T1]  __driver_attach+0xc7/0x1a0
[   39.359562][    T1]  bus_for_each_dev+0xfe/0x160
[   39.359562][    T1]  ? subsys_dev_iter_init+0x80/0x80
[   39.359562][    T1]  ? __kasan_check_read+0x11/0x20
[   39.359562][    T1]  ? _raw_spin_unlock+0x27/0x40
[   39.369488][    T1]  driver_attach+0x2b/0x30
[   39.369488][    T1]  bus_add_driver+0x298/0x350
[   39.369488][    T1]  driver_register+0xdc/0x1d0
[   39.369488][    T1]  ? i8042_toggle_aux+0xeb/0xeb
[   39.369488][    T1]  __platform_driver_probe+0xcd/0x230
[   39.3  __platform_create_bundle+0xc0/0xe0
[   39.769489][    T1]  ? i8042_toggle_aux+0xeb/0xeb
[   39.779556][    T1]  ? i8042_probe+0xa45/0xa45
[   39.779556][    T1]  i8042_init+0x4ec/0x578
[   39.779556][    T1]  ? i8042_probe+0xa45/0xa45
[   39.779556][    T1]  ? netdev_run_todo+0x2f/0x4a0
[   39.779556][    T1]  ? qdisc_create_dflt+0xf0/0xf0
[   39.779556][    T1]  ? net_olddevs_init+0x67/0x67
[   39.779556][    T1]  ? i8042_probe+0xa45/0xa45
[   39.789486][    T1]  do_one_initcall+0xfe/0x45a
[   39.789486][    T1]  ? initcall_blacklisted+0x150/0x150
[   39.789486][    T1]  ? __kasan_check_write+0x14/0x20
[   39.789486][    T1]  ? up_write+0xee/0x2a0
[   39.789486][    T1]  kernel_init_freeable+0x614/0x6a7
[   39.789486][    T1]  ? rest_init+0x188/0x188
[   39.789486][    T1]  kernel_init+0x11/0x138
[   39.799563][    T1]  ? rest_init+0x188/0x188
[   39.799563][    T1]  ret_from_fork+0x35/0x40
[   39.803412][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12

