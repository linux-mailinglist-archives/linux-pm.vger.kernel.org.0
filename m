Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515704C875
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfFTHfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 03:35:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35145 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfFTHfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 03:35:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so1179058pfd.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 00:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZWBp7XRLY7BMhAB/5Wb1Dw0CKJ6+atW+qt+VNCpkPU=;
        b=jCN9LFhwlqk32q1x84xet3TXGEXC8C5tUfPhwYwEAXK5NS7UhkEsEv4Cap07CZCu4b
         uefsWk+zr+kVvRugckZFitv+YaJKTcDFLoGVK68AG98ECYqekqhD2P0N44bDrgjJP/cQ
         neGID9fqg096WWtYWnn1LRuTY7wUi3YDGaUQiw4YCpyhqKiUyhHhFZM+vvCvplF218Sh
         HIoQnbX+kQZrLw5h2gAwCyx1rmUMvK9qEDRDPIYS5bFBp2QqQjJwapAtvTjtnSO7MvF/
         iSRgZDpfvKQFKYhXhHeGKGzJPw9T2qpO528pTnkK8cciqzWguj6uVfTS0r/Ugfj9fdkl
         C9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZWBp7XRLY7BMhAB/5Wb1Dw0CKJ6+atW+qt+VNCpkPU=;
        b=NBlJFP39G5/Xuhq/jaIv1MEAb3wyRLtZbeR6giGFc2HVhWu7TXoFUH+AMsTvrOxBkS
         3IQADkzaEdddcN2AS0eSCS4HWHM+S3amcA8ev5gSsAoeYg7CVLBtkD+cBwVpXAmTgVVZ
         545ifEgJdeQkF+kZfWTQkOJq8cjuroHrFLik6gyWW2pGI0aQuUKYETO/pgmhVEOK65eN
         DKHbNWwIxsco2xWE2HTkmE37BwO+30ThIafvNNZIEGIhhp/ZvZDr8JojjxH05McZiEi0
         +adZYdssuuW8AZyUl9KGUcHSf7u9ShYuoMq5AqWXVgq9C5UpSdwPAGHFC4M811azD2da
         0dAQ==
X-Gm-Message-State: APjAAAXJ1WCQFC8eozGq2Z4v3WkYNtAmEeb1e/MzJS0Rsx/FdkL9W0Ob
        inW8BbsSEuyR1jB1k7a6YaHjLw==
X-Google-Smtp-Source: APXvYqzqXxTIJnr8YPEJ6VfjSUXXwzfpp6K4RCFrCL7guad8vXMWvH1MWAuLZdZ8W1iqt5tb2Lk2eA==
X-Received: by 2002:a63:151a:: with SMTP id v26mr11860950pgl.9.1561016140764;
        Thu, 20 Jun 2019 00:35:40 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id a12sm6239579pje.3.2019.06.20.00.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:35:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/6] cpufreq: Use QoS layer to manage freq-constraints
Date:   Thu, 20 Jun 2019 13:05:23 +0530
Message-Id: <cover.1561014965.git.viresh.kumar@linaro.org>
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

This is rebased over pm/linux-next and another cleanup series [1].

Todo:
- Migrate all users to the QoS framework and get rid of cpufreq specific
  notifiers.
- Make PM QoS learn about the relation of CPUs in a policy, so a single
  list of constraints is managed for all of them instead of per-cpu
  constraints.

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

Viresh Kumar (6):
  PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
  PM / QOS: Rename __dev_pm_qos_read_value() and
    dev_pm_qos_raw_read_value()
  PM / QOS: Pass request type to dev_pm_qos_read_value()
  PM / QoS: Add support for MIN/MAX frequency constraints
  cpufreq: Register notifiers with the PM QoS framework
  cpufreq: Add QoS requests for userspace constraints

 Documentation/power/pm_qos_interface.txt |  12 +-
 drivers/base/power/domain.c              |   8 +-
 drivers/base/power/domain_governor.c     |   4 +-
 drivers/base/power/qos.c                 | 135 ++++++++++++++--
 drivers/base/power/runtime.c             |   2 +-
 drivers/cpufreq/cpufreq.c                | 198 ++++++++++++++++-------
 drivers/cpuidle/governor.c               |   2 +-
 include/linux/cpufreq.h                  |  11 +-
 include/linux/pm_qos.h                   |  48 ++++--
 9 files changed, 316 insertions(+), 104 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

