Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9654723C707
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 09:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgHEHif (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 03:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEHie (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 03:38:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA8C06174A;
        Wed,  5 Aug 2020 00:38:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so13928685pfx.13;
        Wed, 05 Aug 2020 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zI12ASDPrZzCs4CeMeIEyoiyadcioD0vlIAhn4UgqXk=;
        b=O9VAtBoE8m9pLKolHVXq9C+h3xjFpigEO59KKEw4kmEIIcSOeMMg9v8JVb21AV4TR9
         LFL2IuqCTWdPZTdOuBK/Rieq9tgHVV/03i2xQT2jSeE8B6MpPHKNsBOg6765S1V1vzDf
         0OkmGmwP8qHF/I282tZV7T2tx9xfo4bXs2o8fpji6lgfL7JI+Zd/I4qXDYIitx5v2Ys8
         EriuWxoppqV7/cfAxFeKc7Rk2rw9Hsv+6o3e8A9sIVC3yQDuY1xdyKgBcmGC+gQW0zrv
         SdROIqYtEK0q6gCD2v4EIFKYqe5zPWgpvIxBVJcZd3SG+VTuOc4/i1fkSnldI1h+4aGB
         OGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zI12ASDPrZzCs4CeMeIEyoiyadcioD0vlIAhn4UgqXk=;
        b=KsddvHMjZrhTYCiGnfv8abNouudOxQbiOJ/r0fbHtMbVxLgRvcX4KHLgTSmVuiyqwM
         bAM6SbyXHd1SnnWDfCrSQLZ7GpmipSjnmpuUW91lNgKXSaF9WtxcCLY7JfPNT1j1ChCF
         Oa7GAwgKXXsHu6epMpeSUBIUR0fkG7egdp1TC3Q0DLjeg9EK3weSJDSk5cLSRUY/GM9r
         lISSCNuF0zo4B/NBZeDKijbo1vHbYJBFGpXJBMbgpwEcLcDJ8Ar6cbtrQpR8UlhJJ60E
         eCZ1v/nglxrTGXsMBBPnbj2qx1RgvOUofR2FY4YaHUqDPOCkLqi3FtV6PKlmr7OcfrUh
         0/fg==
X-Gm-Message-State: AOAM533tQRWVMLw2/c2DlahDNlao27CYmDUcvwJRCC0oNURjySipdd87
        CFO2KzkTw+wOasxiH+G31V2m1iNXdCeV6A==
X-Google-Smtp-Source: ABdhPJw+QpPJNzZa5IUMV9Yu0eWvZwLDXap0j131WsCRjykSWzSD/1EzCKOVo8aXg2nYuvqEz3uSHw==
X-Received: by 2002:aa7:9703:: with SMTP id a3mr2086822pfg.268.1596613113224;
        Wed, 05 Aug 2020 00:38:33 -0700 (PDT)
Received: from yangdongdo-OptiPlex-9010.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id r28sm1972871pfg.158.2020.08.05.00.38.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 00:38:32 -0700 (PDT)
From:   Dongdong Yang <contribute.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
Subject: [PATCH v5] Provide USF for the portable equipment.
Date:   Wed,  5 Aug 2020 15:36:20 +0800
Message-Id: <cover.1596612536.git.yangdongdong@xiaomi.com>
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
cpufreq governor to support high level layer sysfs inodes setting for
util adjustment purpose from the identified scenario on portable
equipment. Because the power consumption and UI response are more cared
for by portable equipment users. And the "screen off" status stands for
no request from the user, however, the kernel is still expected to
notify the user in time on modem, network or powerkey events occur. USF
provides "non_ux_r" sysfs inode to cut down the utils from user space
tasks according to high level scenario. In addition, it usually hints
more cpufreq demand that the preemptive counts of the tasks on the cpu
burst and over the user expecting completed time such as the ratio
sysctl_sched_latency to sysctl_sched_min_granularity on "screen on"
status, which more likely with more UI. The sysfs inodes "up_l0_r" and
"down_r" have been provided to adjust the utils according to high level
identified scenario to alloc the cpufreq in time.

Changes in v5
Based on comments from Greg, Peterz, Qais and Randy
  - Updated USF sysfs to ABI
  - Updated the names of USF functions.
  - Clean sched.h and trace.h changes.

Changes in v4
Based on comments from Greg, Randy and Viresh
  - Add USF sysfs to ABI
  - Remove kobj field from usf.
  - Clean Kconfig left at staging.

Changes in v3
Based on comments from Greg, Dietmar, Christoph and Randy
  - Move usf.c to kernel/sched from staging.
  - Remove trace_printk and debugfs.
  - Add document draft.
  - Update comments.

Changes in v2
Based on comments from Steven, Greg, Peter and Dan:
  - Add adjust_task_pred_set switch.
  - Move adjust_task_pred_demand declaration into sched.h
  - Update comments.
  - Clean usf structure.

Changes in v1
Initial USF 

Dongdong Yang (1):
  sched: Provide USF for the portable equipment.

 Documentation/ABI/testing/sysfs-devices-system-cpu |  31 ++
 drivers/cpufreq/Kconfig                            |  11 +
 kernel/sched/Makefile                              |   1 +
 kernel/sched/cpufreq_schedutil.c                   |   5 +
 kernel/sched/usf.c                                 | 314 +++++++++++++++++++++
 5 files changed, 362 insertions(+)
 create mode 100644 kernel/sched/usf.c

-- 
2.7.4

