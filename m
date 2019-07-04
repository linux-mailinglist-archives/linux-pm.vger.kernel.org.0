Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8A5F3D3
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGDHga (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 03:36:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33362 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGDHga (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 03:36:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so2643303plo.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2019 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HRLgsM/YRXffCDN0dNN2kJ7G9GZLkToihDfCd/KbHc=;
        b=RWeNBkc7jbRxcq/jToCqRSX7TpZu/Sxt4xherbLXDgW7CFwokq3TBp0AnHLDq5b0i2
         Rmqc4Z3aGr2wzmWWz8QCP5BGsJCZrqK8rx7Ao7kwo7Xrl0QV8GJg7ZtGTg1mBeQJFMic
         zYMgW3VLPPJVEl+MR1GE+OT93rVUmooSQRAED8wlQbDA/5Y5bfNjunKj1v4x6yQn5/DT
         x6mZEpW8a+YocNvyv+sSC1bWuSgeDxf+sg+2mi9jPxmGaJykE7dib2BubR7Wjpy6yy7y
         oHOmjpIRjYiWU0qkchxdvV2eg8YLReorwwZP6ipu8yrPFcRLmmEhnI6Cdu+8Nb4sXBjn
         YXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HRLgsM/YRXffCDN0dNN2kJ7G9GZLkToihDfCd/KbHc=;
        b=jGIo9v5Co0MBd/ScPxpjyuMJzogZa8kjtuPVECLaPMjGXgpX6CPNDhgC0yvkMfz08S
         uGM9cP0i/VeKr2cMZChu6eNrLYZ5R9jpS0cNLCJ5e1xqImVTZ4q+LhSxs0plKuVoouxC
         rXJaSdxKtuxsnm7v4Na4uYTQeakbwn+p3NdYd2wWjNf5e5masnwnxzb6oOiWQV6McS3w
         X6FLk74IIEJ/eDFaO5Kk2qU9Cy6aOMIewmMYM2trn0nQT1cAgXCUwzghGuvB8U238K4w
         C66sIHDpyHhxsxMFrlmAlKiBkAd+jhqCM466lNo8SUFaOBeVyph7KuxLAmRr7qAEdoKf
         xXsw==
X-Gm-Message-State: APjAAAUvOWBH5+n/BR6VeBQNFmrIpqsKwAPuP9M+OP6FABsdDBaw0TIX
        c8u2GwWWIMN92FVq1lADnVaLYQ==
X-Google-Smtp-Source: APXvYqwYs6LSq7cyeou9/jnEoPLlcAis7RlPoTqhfVKxyGj6txSB5Q4CxW4Oe9vGrN4moSXypWmGuQ==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr1335671plt.102.1562225789355;
        Thu, 04 Jul 2019 00:36:29 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id y8sm5670277pfn.52.2019.07.04.00.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 00:36:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Len Brown <lenb@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V6 0/7] cpufreq: Use QoS layer to manage freq-constraints
Date:   Thu,  4 Jul 2019 13:06:16 +0530
Message-Id: <cover.1562210705.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Sorry about another version after another round of embarrassment over
compilation issues. The same patches have gone through pm/linux-next and
linux-next/master earlier, not sure why the current issues never came up
before. Anyway, they were stupid coding mistakes :(

I have pushed these patches again for the build bot to test, which
should finish before these get merged in PM tree now.

This patchset attempts to manage CPU frequency constraints using the PM
QoS framework. It only does the basic stuff right now and moves the
userspace constraints to use the QoS infrastructure.

Todo:
- Migrate all users to the QoS framework and get rid of cpufreq specific
  notifiers.
- Make PM QoS learn about the relation of CPUs in a policy, so a single
  list of constraints is managed for all of them instead of per-cpu
  constraints.

V5->V6:
- Fixed compilation issues with !CONFIG_PM case on riscv architecture.

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

