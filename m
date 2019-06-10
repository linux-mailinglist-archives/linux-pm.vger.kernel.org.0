Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF63B371
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbfFJKvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:51:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41183 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389548AbfFJKvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 06:51:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so4573478pff.8
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nrRXRZLGYNCevB7P9G3OypvWpceLIiQ3ZsEEykg2uo=;
        b=kcgbprTvW7V6ti9e2eqMCTo+r0IkcXNP3aoI3bJr+vpxKG+hZGfrsF0QSplUGzrwhp
         1hYixkVbW/8RDdREbEjyH9YJhd4IaqEOTSw7d6xsjNLU1vmIbUdhVafW6PHj7jJEuy6G
         D9zC/DPQBUzyhzTb7Lt+YgG7+YJXTozze7YjSvSQ3r/gy31bFfbXIJrbgnulgLqLIEn2
         Vy7H4zYXdhAgTdqSn174uwtPI64/2dEj9dydKFIIvo17BE0sGuxjyag/dj7mX+b2L4ZC
         PZs6ufhW5SkDVK4ygXKSkxzmIc8efcnz0IsMSGDPXVEcX7R3NNesnOBojR1dShR0bn29
         bVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nrRXRZLGYNCevB7P9G3OypvWpceLIiQ3ZsEEykg2uo=;
        b=pj9RVzXWuVzFFgR2JWvup1fZWYePx/eAag1fSw/TcW2Z3EXKDMtvWJ5GCsdArB8aLH
         CFHCimuJb2Ad68eY6vby4Kdrg27feVtBU6BRYurOpuw1zK57LEC/Z+n69h1Jaw8i+CI8
         XX65hSUtFOEA2/+hX90hHH/d8XbYcdd0B2/9DKNIAvmpvPtWIun1pQqdV7Lf0Lvjv0sv
         bJSWd9fhDTEVvd0gkw8+ggUqmwwQ3wRurju6a5PEubSInFtR8OOswpH7B5D2y9dsQVeF
         YOBD1YKASCVQPFZyNRmA5BBkYtSwqGEp09o+lncyfr9ujKFWz8DxIX1YHyhQ1SC+stuE
         O1RA==
X-Gm-Message-State: APjAAAV9ziQDDmDnKgeQZEfCoBaxZ99B8AhRDS6BsUkn/Xm5McdznFzt
        f0SQVmdjZ2KKb9Vi3yPk5bDEDA==
X-Google-Smtp-Source: APXvYqyGlVDir430MCaqbMXQr7mk1OEzFBHQegeaPhz5iaPiwEcmW4FtmltmprADvphfod21ZvUIbg==
X-Received: by 2002:a17:90a:a785:: with SMTP id f5mr20588788pjq.4.1560163911094;
        Mon, 10 Jun 2019 03:51:51 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id y22sm5484067pfm.70.2019.06.10.03.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:51:50 -0700 (PDT)
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
Subject: [PATCH V3 0/5] cpufreq: Use QoS layer to manage freq-constraints
Date:   Mon, 10 Jun 2019 16:21:31 +0530
Message-Id: <cover.1560163748.git.viresh.kumar@linaro.org>
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

V2->V3:
- Add a comment in cpufreq.c as suggested by Qais.
- Rebased on latest pm/linux-next.

V1->V2:
- The previous version introduced a completely new framework, this one
  moves to PM QoS instead.
- Lots of changes because of this.

--
viresh

Viresh Kumar (5):
  PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
  PM / QOS: Pass request type to dev_pm_qos_read_value()
  PM / QoS: Add support for MIN/MAX frequency constraints
  cpufreq: Register notifiers with the PM QoS framework
  cpufreq: Add QoS requests for userspace constraints

 Documentation/power/pm_qos_interface.txt |  12 +-
 drivers/base/power/domain.c              |   8 +-
 drivers/base/power/domain_governor.c     |   4 +-
 drivers/base/power/qos.c                 | 115 +++++++++++--
 drivers/base/power/runtime.c             |   2 +-
 drivers/cpufreq/cpufreq.c                | 203 ++++++++++++++++-------
 drivers/cpuidle/governor.c               |   2 +-
 include/linux/cpufreq.h                  |  12 +-
 include/linux/pm_qos.h                   |  71 ++++++--
 9 files changed, 325 insertions(+), 104 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

