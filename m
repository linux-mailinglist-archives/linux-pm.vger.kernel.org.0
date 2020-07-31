Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC642346A9
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGaNOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgGaNOa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 09:14:30 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D33C061574;
        Fri, 31 Jul 2020 06:14:30 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t18so25308106ilh.2;
        Fri, 31 Jul 2020 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IpiXoaEfhRVC/TiOprnmSx5/CzTTYxkk2Z3fpn71RCE=;
        b=Ic8H8EqmDSiSpRlFWR3J+0nYg5rJVN9lTRx3pbXRJk5H057eGeXS2L44ZflLe4pnUd
         ww53jvYTDHPsM3TNbxQ3Vk6U25m/f41g+8cw0R93ZhglrpxPf5k+her8E7JzOLWfCzWc
         E5WDl5nYtmPUtb7tLD8Psik/MuMduSFHyNKhJJMpfc9i2/Hix6hzSWFTE38sRKlrZq3/
         wkxqWytqUHfJUIV/VAWOvnOdrj3LDT2i04f+SnUsR8pXKsOIo80tO6vAq/xNL6bKlmkh
         CgkcyvnAmgQGcTAICZEfrC27wZsooZNqa8KFofw/xUyuZSW1ra81lWW4P46fPAsNH700
         IR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IpiXoaEfhRVC/TiOprnmSx5/CzTTYxkk2Z3fpn71RCE=;
        b=DXxoXcVXQ3cgCRfjxbM/xjz6uZCnobHfujPTMLvc3WB1uYYVkLNULst+Ypw3SWKAzI
         rp+u1cHFtleCyLVhZBhLsDQLnIRvyf+f2BL/bcGBbxrSdMhrGv2DlgODaS7h+xGeFocc
         ZDUxng+VW+12MM2k4f7NaUdnIsPrl8qlgiOb7AvZSsXJnL6ftrmprahfjz7ITFWkEvTI
         85VqIOQBaSJS+3LJIDdFFwTVIhJMy7vsZpw6NO/EjAsQMMTkGFVl6Yy4+8diYtFTRepB
         jqNxzHgFZFzhq0pFBow5UB7H4+Z+Xof/25XtCUdM/2BwiMt/tsqsKJ4mhrVqVt1yHaMt
         1Ljg==
X-Gm-Message-State: AOAM532qvnfJqgB4/qAEnzPB7izDT3j19IIgB9eITLkFiUdNRG9qPx98
        TPofjoSVNax8kI9SND1XYMD1hRnGK4gFRw==
X-Google-Smtp-Source: ABdhPJy9d85FEkeqqnEQaC/Th8l7Zp8/PAymqCSZ0KRDh7yYuZath1yYVLNCx1hLxXaUKzfBpI9JyA==
X-Received: by 2002:a65:4507:: with SMTP id n7mr3511459pgq.180.1596199720490;
        Fri, 31 Jul 2020 05:48:40 -0700 (PDT)
Received: from yangdongdo-OptiPlex-9010.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id m20sm10378742pgn.62.2020.07.31.05.48.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 05:48:40 -0700 (PDT)
From:   Dongdong Yang <contribute.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
Subject: [PATCH v2] Provide USF for the portable equipment.
Date:   Fri, 31 Jul 2020 20:46:29 +0800
Message-Id: <cover.1596196060.git.yangdongdong@xiaomi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dongdong Yang <yangdongdong@xiaomi.com>

This patch provides USF(User Sensitive Feedback factor) auxiliary
cpufreq governor to support high level layer sysfs inodes setting
for utils adjustment purpose from the identified scenario on portable
equipment. Because the power consumption and UI response are more cared
for by portable equipment users. And the "screen off" status stands for
no request from the user, however, the kernel is still expected to
notify the user in time on modem, network or powerkey events occur. USF
provides "sched_usf_non_ux_r" sysfs inode to cut down the utils from
user space tasks according to high level scenario. In addition, it
usually hints more cpufreq demand that the preemptive counts of the
tasks on the cpu burst and over the user expecting completed time such
as the ratio sysctl_sched_latency to sysctl_sched_min_granularity on
"screen on" status, which more likely with more UI. The sysfs inodes
"sched_usf_up_l0_r" and "sched_usf_down_r" have been provided to adjust
the utils according to high level identified scenario to alloc the
cpufreq in time.

Changes in v2
  - Add adjust_task_pred_set switch.
  - Move adjust_task_pred_demand declaration into sched.h
  - Update comments.

Dongdong Yang (1):
  sched: Provide USF for the portable equipment.

 drivers/staging/Kconfig          |   2 +
 drivers/staging/Makefile         |   1 +
 drivers/staging/fbsched/Kconfig  |  10 ++
 drivers/staging/fbsched/Makefile |   2 +
 drivers/staging/fbsched/usf.c    | 346 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |   3 +
 kernel/sched/sched.h             |  10 ++
 7 files changed, 374 insertions(+)
 create mode 100644 drivers/staging/fbsched/Kconfig
 create mode 100644 drivers/staging/fbsched/Makefile
 create mode 100644 drivers/staging/fbsched/usf.c

-- 
2.7.4

