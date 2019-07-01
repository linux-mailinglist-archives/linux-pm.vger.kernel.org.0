Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8025BA8F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfGAL0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 07:26:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38014 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfGAL0Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 07:26:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so6443595pfn.5
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2019 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ynBBs/NOZX3NzX0Q9+1BmT1OjndcQg2QjZPTWCNOFLQ=;
        b=CMuYzAocf2wKTBA+GXQccgtp+dOADRGiyab8LzNK8mpqZGI8+ekJbNSqjuhfGczRbq
         hIyzHyq/PiHMbripC+nQ6rGz1xIto5k8YmbZ/QToU1+wA38o0NOtwV3vN3FydQ4oJlJ6
         DeZhtBv1ma2z613Udb89826z95GgCHsVy8x4RgAmIpmJhpBJLGz0pX00h/+sWQdBCx+w
         3YIBy8CkySQxBodv1KAwNRBYE80ptRyiunQwNu6lrXoQgRyhzccdr1ApGHHHMeJp+Pav
         Fa9gc2WB04WtnC4y4X8rGtcSZtpzJGVJMrUKnzxjWLd435YOtIXQjYJcMceDY3iumXWQ
         /n7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ynBBs/NOZX3NzX0Q9+1BmT1OjndcQg2QjZPTWCNOFLQ=;
        b=RdjATBBrqcwP+lXKyOHz0sznoFjlKXKd6LQltvYKK5wlkYgKUCgrCliKxDecVfnJnE
         pIVzg56E2ScE2yCLLBucT/UZs3xN/U/CKpnBqUATzYh3yqvW/FCBI256elxONmViU+HW
         Dy+uzhM25CIco59uWMeHjYvBFcvGGNMJZ+S35J4j36k5MVrYsytcUMiJLUCBplnss4Rk
         sQqGBoanEpeSH37DHkyoMNT5zRRbYYgKhGQA6dHCWk5A4jqvk02kK7vdQ/mqlw3Y5rGh
         KCrQJR8ckienQJCImzFZCTmDYxa+fFkj+FJw9iz4Dv48TvkOUgmXanxfXmABnPceux+e
         127A==
X-Gm-Message-State: APjAAAU2dBE0EoSupUbeqjl4jJkfz5qnpiPmpQ5RwKqsS++WsxEwiGZq
        al4c5q3Iosx4YI1r/YxTYtDN9A==
X-Google-Smtp-Source: APXvYqygZ3fAikMt9o/P/XbZtlOuA1YA0A6ZN7tJAAFjFS+dwZF9vKO/IVT+6FQ6twYmXoNi+aXWPQ==
X-Received: by 2002:a17:90a:33c4:: with SMTP id n62mr31355142pjb.28.1561980383274;
        Mon, 01 Jul 2019 04:26:23 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id i9sm8248146pgo.46.2019.07.01.04.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:26:22 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Len Brown <lenb@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/7] cpufreq: Use QoS layer to manage freq-constraints
Date:   Mon,  1 Jul 2019 16:56:08 +0530
Message-Id: <cover.1561979715.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset attempts to manage CPU frequency constraints using the PM
QoS framework. It only does the basic stuff right now and moves the
userspace constraints to use the QoS infrastructure.

Todo:
- Migrate all users to the QoS framework and get rid of cpufreq specific
  notifiers.
- Make PM QoS learn about the relation of CPUs in a policy, so a single
  list of constraints is managed for all of them instead of per-cpu
  constraints.

V4->V5:
- A new patch added, 6/7.

V3->V4:
- Few commit logs updated as suggested during reviews.
- Separate commit (2/6) to create resume-latency specific routines
- Reused earlier work ("update") for notifiers as well.
- Kept Reviewed-by tags as is as the patches normally got better only.
  Please take them back if you find any issues.

V2->V3:
- Add a comment in cpufreq.c as suggested by Qais.
- Rebased on latest pm/linux-next.

V1->V2:
- The previous version introduced a completely new framework, this one
  moves to PM QoS instead.
- Lots of changes because of this.

--
viresh

[1] http://lore.kernel.org/lkml/cover.1560999838.git.viresh.kumar@linaro.org


Viresh Kumar (7):
  PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
  PM / QOS: Rename __dev_pm_qos_read_value() and
    dev_pm_qos_raw_read_value()
  PM / QOS: Pass request type to dev_pm_qos_read_value()
  PM / QoS: Add support for MIN/MAX frequency constraints
  cpufreq: Register notifiers with the PM QoS framework
  cpufreq: intel_pstate: Reuse refresh_frequency_limits()
  cpufreq: Add QoS requests for userspace constraints

 Documentation/power/pm_qos_interface.txt |  12 +-
 drivers/base/power/domain.c              |   8 +-
 drivers/base/power/domain_governor.c     |   4 +-
 drivers/base/power/qos.c                 | 135 +++++++++++++--
 drivers/base/power/runtime.c             |   2 +-
 drivers/cpufreq/cpufreq.c                | 201 ++++++++++++++++-------
 drivers/cpufreq/intel_pstate.c           |   7 +-
 drivers/cpuidle/governor.c               |   2 +-
 include/linux/cpufreq.h                  |  12 +-
 include/linux/pm_qos.h                   |  48 ++++--
 10 files changed, 320 insertions(+), 111 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

