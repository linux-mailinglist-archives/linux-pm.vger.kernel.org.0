Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F608254284
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 11:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH0JfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 05:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0JfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 05:35:04 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B25C061264
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 02:35:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j13so155036vsr.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZoZRWBejixABEWT5ob4yAZy+/4BzgKmNPxRPIsvrKC0=;
        b=Iby+b/VEw8MIEt16ewhQ9obSWVH5Cuz7dt+ecYwt9wwONbSFO5+9V0RrNIHtKScOfK
         6BPpscL+EWdtUr8FL0SRaJjgQqSc0M+7kn0CPXZ9Sb3G0wK92Yf9gP8FQPbBPW8PR92H
         9ErGadQW3UXW6y5JLLiU/g2ejReQ5CfZsMwdVgS5zKo5K2hc9K7PP63AW2qluKGBWSBh
         KPRBgftT/sAp4lA68F0+BiS9RThjdaDdunag6JuUvV6kW+EY3AER2CnDYu4g6aaoz4pu
         iE91I/8nPb/oPZ9wZHp+EJ7Rwyr0d2CTrrXD0mTPZdR3GSg1y8c7auWj0stUvrRRPvox
         Qj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZoZRWBejixABEWT5ob4yAZy+/4BzgKmNPxRPIsvrKC0=;
        b=KY46EesfYrw1OHe+zMMIYhZShvQSPuSWJK+ZGnHUyQJ114Ql6NcdwXksjSzl6tZQ75
         lPbVJuTwGIrdmAFEqxrA9rc/GDo8V/8M4bze+RJXZ9pMaEXtk0cl4qerQd5ttATMG6dX
         8Glc5WO8QzSN7KgwX+SU38IQQj5yaw9ShTE0CToAkANtxFpy/apP+8kDcfmyyRdO0FWB
         qUoVKvt/E0dr7F6FLsEl7Z9W/yqB2+RQmnMWPeRUN8Z5h1arRiVnlpZd2M7i/WvQ+ezY
         bIgUeuPymDFcHVOkpb3eQfpLZfZIgNZnS6EV8CzUqpUGXaK4O52To88hUpreGJq9IAMb
         cAHw==
X-Gm-Message-State: AOAM53257jzfqEYO0QqJX9IinLIodjJL1+vJOWLegQiH2PjfiUPm2oHv
        GzJk+aFR0WAVWFqO2INdp3qQ8PvuCjmzBJ5xTVzCJshbds55zmjG
X-Google-Smtp-Source: ABdhPJzzfui8hxlaJnkurpGMgX/qf5AHwDlnmkE2kMh7RnHjKPR6L+OLrlI2Yp5O1xfARMh8kKVIRyFsGZNkq7lfmas=
X-Received: by 2002:a67:7905:: with SMTP id u5mr11663816vsc.179.1598520902978;
 Thu, 27 Aug 2020 02:35:02 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 27 Aug 2020 15:04:51 +0530
Message-ID: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
Subject: WARNING: at drivers/opp/core.c:678 dev_pm_opp_set_rate+0x4cc/0x5d4 -
 on arm x15
To:     open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While boot testing arm x15 devices the Kernel warning noticed with linux next
tag 20200825.

BAD:  next-20200825
GOOD:  next-20200824

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: 3a00d3dfd4b68b208ecd5405e676d06c8ad6bb63
  git describe: next-20200825
  make_kernelversion: 5.9.0-rc2
  kernel-config:
https://builds.tuxbuild.com/LDTu4GFMmvkJspza5LJIjQ/kernel.config

We are working on git bisect and boot testing on x15 and get back to you.

warning log:
-----------------
[   13.330201] sdhci-pltfm: SDHCI platform and OF driver helper
[   13.352903] omap_gpio 4805d000.gpio: Could not set line 27 debounce
to 200000 microseconds (-22)
[   13.361767] sdhci-omap 4809c000.mmc: Got CD GPIO
[   13.366885] sdhci-omap 4809c000.mmc: supply vqmmc not found, using
dummy regulator
[   13.374716] ------------[ cut here ]------------
[   13.379414] WARNING: CPU: 0 PID: 21 at drivers/opp/core.c:678
dev_pm_opp_set_rate+0x4cc/0x5d4
[   13.387999] Modules linked in:
[   13.391089] CPU: 0 PID: 21 Comm: kworker/0:1 Not tainted
5.9.0-rc2-next-20200825 #1
[   13.398779] Hardware name: Generic DRA74X (Flattened Device Tree)
[   13.404908] Workqueue: events dbs_work_handler
[   13.409378] Backtrace:
[   13.411852] [<c040e860>] (dump_backtrace) from [<c040ebd4>]
(show_stack+0x20/0x24)
[   13.419460]  r7:c20cca94 r6:00000000 r5:60000013 r4:c20cca94
[   13.425153] [<c040ebb4>] (show_stack) from [<c0941338>]
(dump_stack+0xec/0x118)
[   13.432505] [<c094124c>] (dump_stack) from [<c0451530>] (__warn+0xe8/0x100)
[   13.439501]  r10:e8b50600 r9:00000009 r8:c105f6f4 r7:000002a6
r6:c105f6f4 r5:00000009
[   13.447369]  r4:00000000 r3:c2004f30
[   13.450968] [<c0451448>] (__warn) from [<c04518fc>]
(warn_slowpath_fmt+0x74/0xc4)
[   13.458485]  r7:000002a6 r6:c1b42034 r5:00000000 r4:e9b50000
[   13.464174] [<c045188c>] (warn_slowpath_fmt) from [<c105f6f4>]
(dev_pm_opp_set_rate+0x4cc/0x5d4)
[   13.472999]  r9:e8b50280 r8:e9b50000 r7:ffffffea r6:3b9aca00
r5:59682f00 r4:e8902c00
[   13.480783] [<c105f228>] (dev_pm_opp_set_rate) from [<c106aa8c>]
(set_target+0x3c/0x64)
[   13.488824]  r10:00000002 r9:00000000 r8:c22b508c r7:c2227048
r6:0016e360 r5:00000000
[   13.496688]  r4:e8903000
[   13.499243] [<c106aa50>] (set_target) from [<c1064ca0>]
(__cpufreq_driver_target+0x2d0/0x628)
[   13.507808]  r7:c2227048 r6:e9b50000 r5:00000000 r4:e8903000
[   13.513499] [<c10649d0>] (__cpufreq_driver_target) from
[<c1069040>] (od_dbs_update+0x14c/0x170)
[   13.522327]  r10:c2204070 r9:e8b50880 r8:e8b50800 r7:e8b51440
r6:e8b50880 r5:e8b50800
[   13.530192]  r4:e8903000
[   13.532741] [<c1068ef4>] (od_dbs_update) from [<c1069d5c>]
(dbs_work_handler+0x3c/0x68)
[   13.540783]  r9:00000000 r8:c21d902c r7:e8903000 r6:e8b50804
r5:00000000 r4:e8b50838
[   13.548572] [<c1069d20>] (dbs_work_handler) from [<c046f204>]
(process_one_work+0x200/0x560)
[   13.557051]  r9:00000000 r8:00000000 r7:efc2c600 r6:efc29300
r5:e9b24500 r4:e8b50838
[   13.564833] [<c046f004>] (process_one_work) from [<c046f5b0>]
(worker_thread+0x4c/0x57c)
[   13.572963]  r10:efc29300 r9:00000008 r8:c2003d00 r7:efc29318
r6:e9b24514 r5:efc29300
[   13.580828]  r4:e9b24500
[   13.583381] [<c046f564>] (worker_thread) from [<c04773e0>]
(kthread+0x144/0x170)
[   13.590812]  r10:e9979e7c r9:e9b24500 r8:c046f564 r7:e9b50000
r6:00000000 r5:e9b25b80
[   13.598675]  r4:e99c0140
[   13.601228] [<c047729c>] (kthread) from [<c040024c>]
(ret_from_fork+0x14/0x28)
[   13.608484] Exception stack(0xe9b51fb0 to 0xe9b51ff8)
[   13.613559] 1fa0:                                     00000000
00000000 00000000 00000000
[   13.621777] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   13.629994] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   13.636642]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c047729c
[   13.644506]  r4:e9b25b80
[   13.647118] ---[ end trace 4ddd29ac9505935c ]---
[   13.651768] cpu cpu0: multiple regulators are not supported
[ #
  13.655036] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[   13.657394] cpufreq: __target_index: Failed to change cpu frequency: -22
[   13.670803] ------------[ cut here ]------------
[   13.675501] WARNING: CPU: 0 PID: 21 at drivers/opp/core.c:678
dev_pm_opp_set_rate+0x4cc/0x5d4
[   13.684068] Modules linked in:
[   13.687178] CPU: 0 PID: 21 Comm: kworker/0:1 Tainted: G        W
     5.9.0-rc2-next-20200825 #1
[   13.696267] Hardware name: Generic DRA74X (Flattened Device Tree)
[   13.702394] Workqueue: events dbs_work_handler
[   13.706861] Backtrace:
[   13.709334] [<c040e860>] (dump_backtrace) from [<c040ebd4>]
(show_stack+0x20/0x24)
[   13.716942]  r7:c20cca94 r6:00000000 r5:60000013 r4:c20cca94
[   13.722633] [<c040ebb4>] (show_stack) from [<c0941338>]
(dump_stack+0xec/0x118)
[   13.729983] [<c094124c>] (dump_stack) from [<c0451530>] (__warn+0xe8/0x100)
[   13.736978]  r10:e8b50600 r9:00000009 r8:c105f6f4 r7:000002a6
r6:c105f6f4 r5:00000009
[   13.744844]  r4:00000000 r3:c2004f30
[   13.748442] [<c0451448>] (__warn) from [<c04518fc>]
(warn_slowpath_fmt+0x74/0xc4)
[   13.755960]  r7:000002a6 r6:c1b42034 r5:00000000 r4:e9b50000
[   13.761649] [<c045188c>] (warn_slowpath_fmt) from [<c105f6f4>]
(dev_pm_opp_set_rate+0x4cc/0x5d4)
[   13.770479]  r9:e8b50280 r8:e9b50000 r7:ffffffea r6:3b9aca00
r5:59682f00 r4:e8902c00
[   13.778263] [<c105f228>] (dev_pm_opp_set_rate) from [<c106aa8c>]
(set_target+0x3c/0x64)
[   13.786304]  r10:00000002 r9:00000000 r8:c22b508c r7:c2227048
r6:0016e360 r5:00000000
[   13.794168]  r4:e8903000
[   13.796717] [<c106aa50>] (set_target) from [<c1064ca0>]
(__cpufreq_driver_target+0x2d0/0x628)
[   13.805281]  r7:c2227048 r6:e9b50000 r5:00000000 r4:e8903000
[   13.810971] [<c10649d0>] (__cpufreq_driver_target) from
[<c1069040>] (od_dbs_update+0x14c/0x170)
[   13.819797]  r10:c2204070 r9:e8b50880 r8:e8b50800 r7:e8b51440
r6:e8b50880 r5:e8b50800
[   13.827662]  r4:e8903000
[   13.830213] [<c1068ef4>] (od_dbs_update) from [<c1069d5c>]
(dbs_work_handler+0x3c/0x68)
[   13.838256]  r9:00000000 r8:c21d902c r7:e8903000 r6:e8b50804
r5:00000000 r4:e8b50838
[   13.846042] [<c1069d20>] (dbs_work_handler) from [<c046f204>]
(process_one_work+0x200/0x560)
[   13.854518]  r9:00000000 r8:00000000 r7:efc2c600 r6:efc29300
r5:e9b24500 r4:e8b50838
[   13.862301] [<c046f004>] (process_one_work) from [<c046f5b0>]
(worker_thread+0x4c/0x57c)
[   13.870431]  r10:efc29300 r9:00000008 r8:c2003d00 r7:efc29318
r6:e9b24514 r5:efc29300
[   13.878295]  r4:e9b24500
[   13.880846] [<c046f564>] (worker_thread) from [<c04773e0>]
(kthread+0x144/0x170)
[   13.888278]  r10:e9979e7c r9:e9b24500 r8:c046f564 r7:e9b50000
r6:00000000 r5:e9b25b80
[   13.896144]  r4:e99c0140
[   13.898694] [<c047729c>] (kthread) from [<c040024c>]
(ret_from_fork+0x14/0x28)
[   13.905948] Exception stack(0xe9b51fb0 to 0xe9b51ff8)
[   13.911024] 1fa0:                                     00000000
00000000 00000000 00000000
[   13.919241] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   13.927457] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   13.934104]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c047729c
[   13.941967]  r4:e9b25b80
[   13.944558] ---[ end trace 4ddd29ac9505935d ]---
[   13.949228] cpu cpu0: multiple regulators are not supported
[   13.954832] cpufreq: __target_index: Failed to change cpu frequency: -22
#
[   13.961638] ------------[ cut here ]------------
[   13.961941] sdhci-omap 4809c000.mmc: no pinctrl state for ddr_3_3v mode
[   13.966303] WARNING: CPU: 0 PID: 21 at drivers/opp/core.c:678
dev_pm_opp_set_rate+0x4cc/0x5d4
[   13.966311] Modules linked in:
[   13.984620] CPU: 0 PID: 21 Comm: kworker/0:1 Tainted: G        W
     5.9.0-rc2-next-20200825 #1
[   13.993706] Hardware name: Generic DRA74X (Flattened Device Tree)
[   13.999833] Workqueue: events dbs_work_handler
[   14.004301] Backtrace:
[   14.006772] [<c040e860>] (dump_backtrace) from [<c040ebd4>]
(show_stack+0x20/0x24)
[   14.014379]  r7:c20cca94 r6:00000000 r5:60000013 r4:c20cca94
[   14.020071] [<c040ebb4>] (show_stack) from [<c0941338>]
(dump_stack+0xec/0x118)
[   14.027418] [<c094124c>] (dump_stack) from [<c0451530>] (__warn+0xe8/0x100)
[   14.034416]  r10:e8b50600 r9:00000009 r8:c105f6f4 r7:000002a6
r6:c105f6f4 r5:00000009
[   14.042282]  r4:00000000 r3:c2004f30
[   14.045878] [<c0451448>] (__warn) from [<c04518fc>]
(warn_slowpath_fmt+0x74/0xc4)
[   14.053394]  r7:000002a6 r6:c1b42034 r5:00000000 r4:e9b50000
[   14.059082] [<c045188c>] (warn_slowpath_fmt) from [<c105f6f4>]
(dev_pm_opp_set_rate+0x4cc/0x5d4)
[   14.067912]  r9:e8b50280 r8:e9b50000 r7:ffffffea r6:3b9aca00
r5:59682f00 r4:e8902c00
[   14.075695] [<c105f228>] (dev_pm_opp_set_rate) from [<c106aa8c>]
(set_target+0x3c/0x64)
[   14.083736]  r10:00000002 r9:00000000 r8:c22b508c r7:c2227048
r6:0016e360 r5:00000000
[   14.091600]  r4:e8903000
[   14.094150] [<c106aa50>] (set_target) from [<c1064ca0>]
(__cpufreq_driver_target+0x2d0/0x628)
[   14.102715]  r7:c2227048 r6:e9b50000 r5:00000000 r4:e8903000
[   14.108403] [<c10649d0>] (__cpufreq_driver_target) from
[<c1069040>] (od_dbs_update+0x14c/0x170)
[   14.117229]  r10:c2204070 r9:e8b50880 r8:e8b50800 r7:e8b51440
r6:e8b50880 r5:e8b50800
[   14.125094]  r4:e8903000
[   14.127646] [<c1068ef4>] (od_dbs_update) from [<c1069d5c>]
(dbs_work_handler+0x3c/0x68)
[   14.135690]  r9:00000000 r8:c21d902c r7:e8903000 r6:e8b50804
r5:00000000 r4:e8b50838
[   14.143476] [<c1069d20>] (dbs_work_handler) from [<c046f204>]
(process_one_work+0x200/0x560)
[   14.151954]  r9:00000000 r8:00000000 r7:efc2c600 r6:efc29300
r5:e9b24500 r4:e8b50838
[   14.159737] [<c046f004>] (process_one_work) from [<c046f5b0>]
(worker_thread+0x4c/0x57c)
[   14.167867]  r10:efc29300 r9:00000008 r8:c2003d00 r7:efc29318
r6:e9b24514 r5:efc29300
[   14.175732]  r4:e9b24500
[   14.178282] [<c046f564>] (worker_thread) from [<c04773e0>]
(kthread+0x144/0x170)
[   14.185715]  r10:e9979e7c r9:e9b24500 r8:c046f564 r7:e9b50000
r6:00000000 r5:e9b25b80
[   14.193578]  r4:e99c0140
[   14.196127] [<c047729c>] (kthread) from [<c040024c>]
(ret_from_fork+0x14/0x28)
[   14.203381] Exception stack(0xe9b51fb0 to 0xe9b51ff8)
[   14.208458] 1fa0:                                     00000000
00000000 00000000 00000000
[   14.216674] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   14.224889] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   14.231536]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c047729c
[   14.239400]  r4:e9b25b80
[   14.242012] ---[ end trace 4ddd29ac9505935e ]---
[   14.246695] cpu cpu0: multiple regulators are not supported
[   14.252301] cpufreq: __target_index: Failed to change cpu frequency: -22
[   14.259160] ------------[ cut here ]------------
[   14.263821] WARNIN#
G: CPU: 0 PID: 21 at drivers/opp/core.c:678 dev_pm_opp_set_rate+0x4cc/0x5d4
[   14.272406] Modules linked in:
[   14.275542] CPU: 0 PID: 21 Comm: kworker/0:1 Tainted: G        W
     5.9.0-rc2-next-20200825 #1
[   14.284629] Hardware name: Generic DRA74X (Flattened Device Tree)
[   14.290756] Workqueue: events dbs_work_handler
[   14.295223] Backtrace:

Full log,
https://pastebin.com/HwTf2VMA

-- 
Linaro LKFT
https://lkft.linaro.org
