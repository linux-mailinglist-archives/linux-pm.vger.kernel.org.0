Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93322333E3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 16:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgG3OIE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgG3OH6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 10:07:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A1C061574;
        Thu, 30 Jul 2020 07:07:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so14224148plr.8;
        Thu, 30 Jul 2020 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvBujrZbpHTyFtf4aDyQcSP+scQySwGgnJgI3//5ECY=;
        b=Z1WD+vmRUTNVztgbMjp2ehhOi3ixY+RUkMPLYgxVngJTaX+/d8F8KS8ZV9C0VuN3lw
         Bq/BBCJG0wb5rKMSuI+d98nZg5ku3/NG16GZnkXwNrQfkzOFxCzTS6DMriXXSKRcGRkf
         Fdfol1Ay48UxOgEOW6jWWlVwEmwNA5ZrrTOLbSw4NSAMAJ7XZGdUPgRTDupgqu7ZMDFC
         oQ4Yx0aV4uI3gadiUDXJMYwhuZcEhEJfCzoL9FpjMByaq5a0Nczw8aEYcZvwpS+sZtC/
         /A5POXMfpcb3wLIRWEH8+8vNcF1xwT7cBuCyndHTRS09Kof/u0qLSQIBZP7OOnzWAxl7
         2PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvBujrZbpHTyFtf4aDyQcSP+scQySwGgnJgI3//5ECY=;
        b=smSC8dmKM3EEGL/Q2Skg6/WmkPfqwVVI8mtqc3XcyTIa7Ik29Hwp7bwiRDCAQKmKes
         +MSErU15TBe5np/MOTKa2BvevHFxPZpxWf0BPWr28MKNHhCAd70XI+V8uyKRfPfd/WY/
         YTtsmVbOeC37IryRWhMWTFmg5EOyj40piAP5LFg0gC4j9j8YOi1eNNRkQbWgXaVcksOV
         T8Tgruu64O5HMe/MVCxtt5hVwKPIIk6IgVY6eCPPdbb5Y4tYIti5b7I4aXJKDIX7rTNQ
         zyAWnGJ4/ZG5B8uNjWZLyTQaNzV1otE7e6Z5EvHaSXoR8SIO3T61TNUAWqrL0ZWuIXKZ
         LUyQ==
X-Gm-Message-State: AOAM532zzYICO+inWzH2ItggZMRaCSCQA5bddwPGzl+y/qB78Ofq2Q17
        ISWbnmMKp3j8ZPk2VLTJQOwayKadSzCLLQ==
X-Google-Smtp-Source: ABdhPJwmoDlh7vnJf/uBuu29Ec5+DQgH2UXB080ZHlB6VeyOQuaxQY51BY+zrbaJEe2ZTSYNq5asSA==
X-Received: by 2002:a63:4a0e:: with SMTP id x14mr36113319pga.271.1596116273386;
        Thu, 30 Jul 2020 06:37:53 -0700 (PDT)
Received: from yangdongdo-OptiPlex-9010.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id c139sm5987441pfb.65.2020.07.30.06.37.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:37:52 -0700 (PDT)
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
Subject: [PATCH] sched: Provide USF for the portable equipment.
Date:   Thu, 30 Jul 2020 21:35:42 +0800
Message-Id: <cover.1596101307.git.yangdongdong@xiaomi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dongdong Yang <yangdongdong@xiaomi.com>

This patch provides USF(User Sensitive Feedback factor)
auxiliary cpufreq governor to support high level layer
sysfs inodes setting for utils adjustment purpose from
the identified scenario on portable equipment.
Because the power consumption and UI response are more
cared for by portable equipment users. And the "screen
off" status stands for no request from the user, however,
the kernel is still expected to notify the user in time
on modem, network or powerkey events occur. USF provides
"sched_usf_non_ux_r" sysfs inode to cut down the utils
from user space tasks according to high level scenario.
In addition, it usually hints more cpufreq demand that
the preemptive counts of the tasks on the cpu burst and
over the user expecting completed time such as the ratio
sysctl_sched_latency to sysctl_sched_min_granularity
on "screen on" status, which more likely with more UI.
The sysfs inodes "sched_usf_up_l0_r" and "sched_usf_down_r"
have been provided to adjust the utils according to high
level identified scenario to alloc the cpufreq in time.

Dongdong Yang (1):
  sched: Provide USF for portable equipment.

 drivers/staging/Kconfig          |   2 +
 drivers/staging/Makefile         |   1 +
 drivers/staging/fbsched/Kconfig  |  10 ++
 drivers/staging/fbsched/Makefile |   2 +
 drivers/staging/fbsched/usf.c    | 351 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |  11 +-
 6 files changed, 376 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/fbsched/Kconfig
 create mode 100644 drivers/staging/fbsched/Makefile
 create mode 100644 drivers/staging/fbsched/usf.c

-- 
2.7.4

