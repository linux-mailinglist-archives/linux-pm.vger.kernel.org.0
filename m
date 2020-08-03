Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FE23A88F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHCOd1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOd0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 10:33:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69962C06174A;
        Mon,  3 Aug 2020 07:33:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l2so11844871pff.0;
        Mon, 03 Aug 2020 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSryihUrOfV/QpASOmMQXnPhqAteV/tdNxvfNf+2Xfg=;
        b=f6NQsPx1SkjRWIIzrAvw+PGh7OTrPeRIjU09/5f1HbEsEBW3tw9g0Ar8D+a8idmOb4
         5FTeGXd2+X2YtudoVzwpciidf2SUXhlbjHbPx6B/XR3tcXvBBWcbiSoeoa46lHW2N8Hg
         p6Kc+bkMd02lDhTNFpL3vxsLMIZkPTai+FCiRW/lVS/lTNEydmuQ7uwyaJ5JHrJVtbCb
         LxxcQ47FRB/UgRGX11GVDSIcxnXRu0gtVOXSvaLrGUI5utT828y27TVT8gtINMCh4pOK
         P4doXOcAx6+88uFgzha2bpxsf14ck6e/d+qZ3BVSEbEzFT0D6G9xliA+Xl72rGid/RGL
         REFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSryihUrOfV/QpASOmMQXnPhqAteV/tdNxvfNf+2Xfg=;
        b=Uqs/jLCLK9BRJBlfudPaztkIv7+nbKlBP21gmCxanlmO0souvzW/cByXf1B7FqKb/9
         4m4wvedEzTOuOxSidS4i0eZpw60nFkrd6VIy86uYpRaH9YWHWXeLA01AWMXsF6HkkqvV
         /m6grhkZ1fOlSoLnfATeJKqXAvPaNtepCeWNipCiCgLT+s/fBlkevzwWyimUGD+k+Ll/
         +gNmHM2a8cG98zmj4KEtWMV9oiSuwOmZhYFfkwdKGx0KenQ3Hen8TCKiEBBdPboritk7
         oMufWZL51chu+vTbOrhtqdIli7udtCoNqA8eijM48WdnaGoUs/5Pal8pxL2boBod0Zac
         vfsA==
X-Gm-Message-State: AOAM533AQDkGBROuSsSLtgDf7KljDsI4GepTqQxABT1zrFD/ykA1tP6M
        vJSs15S4Gz3hvJY0/e7maQg=
X-Google-Smtp-Source: ABdhPJw8jUAIC6cPasGvqz562zsJjwF1GyLzlxHbXTTNNN7GXWCblmsAa3t3KFutJ5N751+aeL6uNw==
X-Received: by 2002:a62:19c4:: with SMTP id 187mr15865681pfz.312.1596465205971;
        Mon, 03 Aug 2020 07:33:25 -0700 (PDT)
Received: from yangdongdo-OptiPlex-9010.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id x20sm15849188pgc.49.2020.08.03.07.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2020 07:33:25 -0700 (PDT)
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
Subject: [PATCH v3] Provide USF for the portable equipment.
Date:   Mon,  3 Aug 2020 22:31:14 +0800
Message-Id: <cover.1596464894.git.yangdongdong@xiaomi.com>
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

Changes in v3
  - Move usf.c to kernel/sched.
  - Remove trace_printk and debugfs.
  - Add document draft.
  - Update comments.

Changes in v2
  - Add adjust_task_pred_set switch.
  - Move adjust_task_pred_demand declaration into sched.h
  - Update comments.


Dongdong Yang (1):
  sched: Provide USF for the portable equipment.

 Documentation/scheduler/sched-ufs.txt |  78 +++++++++
 drivers/cpufreq/Kconfig               |  11 ++
 drivers/staging/Kconfig               |   2 +
 drivers/staging/Makefile              |   1 +
 include/trace/events/sched.h          |  35 ++++
 kernel/sched/Makefile                 |   1 +
 kernel/sched/cpufreq_schedutil.c      |   3 +
 kernel/sched/sched.h                  |  10 ++
 kernel/sched/usf.c                    | 305 ++++++++++++++++++++++++++++++++++
 9 files changed, 446 insertions(+)
 create mode 100644 Documentation/scheduler/sched-ufs.txt
 create mode 100644 kernel/sched/usf.c

-- 
2.7.4

