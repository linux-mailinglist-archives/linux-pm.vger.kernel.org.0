Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5098223B614
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 09:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHDHwo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 03:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgHDHwo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 03:52:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703CFC06174A;
        Tue,  4 Aug 2020 00:52:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s15so10112645pgc.8;
        Tue, 04 Aug 2020 00:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYEc+6a7E/gabrUW1l1oa9EKsDvyQIWgJXIkTHUE6P0=;
        b=MQKi9p+OTeU7KudYYa62FbuV/BULPjiYgzSkpxX0hFt239tzKILs5CMVfi2I1KxSZL
         GfihFA6OtXRLxRQZD7oKwMeU6KXG34wfOsADEs28IGhmmbGqiDHJdzpccC0r6xQi6DWC
         SmnN8OHk6s9e2JP/D9Q+JfazrLLzkvtesb7IIRikhyUkITFY5PbKPCZHHwbs2/apyclg
         eNcuyJ6WnVTf9qPR9vDJKs7jVfL8wIU6TsQX4MyyqBMwS1E5Vd7SgH1otpekCUFEz6p4
         PqxhKVpxcN5w3gGBM4dy1lH3mTxVsrUKrh4Mxpvh0oQEovzU9xkWFM83iZS3SVMQhlcV
         TaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYEc+6a7E/gabrUW1l1oa9EKsDvyQIWgJXIkTHUE6P0=;
        b=RV2YpjJTcdXYMxSzaMI8JT5F/qFPPlniw6iI45fVvroWET+RdYdW2IKh7JGXuydKDJ
         Pr5/waLxnDOc1trXG/p0HaHv47VKbCcnaf8yy7q3v+KLPG0v23XNKU3tSEoJiH9S/Jda
         Mq3GTMvOVFvx6l+x0xJX4wLaw8kWgGKOmfnjT4Sgf6Xtt0U7dUTQ5ccxQnrJFMGdPM79
         b67zl3F141L1Aal0ZcTV0HJslxJbH3U/5vm3az0Uv9MKKeY9PiCQlvMfYaY7zQ55hGnX
         tmDClgj4WAY3M8gvIrbUkcGC4kLqAuPHh4M4Y9kV3zy3Am2UQFHN3otA3zwUfvwTwudA
         boKQ==
X-Gm-Message-State: AOAM531uEGzD4r0+zKH1WjWwgg66N36PjirEV+9AKv0dyWE14AFCBaHg
        /90w79YkOGi14AuUC2v3/mo=
X-Google-Smtp-Source: ABdhPJy5sW+NQlKW9dHOgTUY65Od+XjtI8kIDLJBPZM2/PUy6h7MzNiFxtnGDWcOudMFF6TPeijAeA==
X-Received: by 2002:a63:741b:: with SMTP id p27mr558733pgc.194.1596527563970;
        Tue, 04 Aug 2020 00:52:43 -0700 (PDT)
Received: from yangdongdo-OptiPlex-9010.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id h18sm9462018pfo.21.2020.08.04.00.52.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 00:52:43 -0700 (PDT)
From:   Dongdong Yang <contribute.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
Subject: [PATCH v4] Provide USF for the portable equipment.
Date:   Tue,  4 Aug 2020 15:50:34 +0800
Message-Id: <cover.1596526941.git.yangdongdong@xiaomi.com>
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

 Documentation/ABI/testing/sysfs-devices-system-cpu |  48 ++++
 drivers/cpufreq/Kconfig                            |  11 +
 include/trace/events/sched.h                       |  35 +++
 kernel/sched/Makefile                              |   1 +
 kernel/sched/cpufreq_schedutil.c                   |   3 +
 kernel/sched/sched.h                               |  10 +
 kernel/sched/usf.c                                 | 294 +++++++++++++++++++++
 7 files changed, 402 insertions(+)
 create mode 100644 kernel/sched/usf.c

-- 
2.7.4

