Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DADE928B
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfJ2WGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43158 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfJ2WGL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id j5so5355778lfh.10;
        Tue, 29 Oct 2019 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8Utf9ayM8XYwdDyhQBxYHMwC6OY3jEY8sLyS1jTeXg=;
        b=hkTw9HpoDR4FfDMf1gQTwliyN2W2o8IW8Xg25P/3a3PFt72OZaxJeCerSylYFz4RGe
         7GlmRb8o44WeuNi/8kWLAtQzNpZp7ezS1K0VHgzUdVREYUn4TXuKPzrDcz+xC0yv46Br
         XsBCR+yc9ps0AiMm24buRQKKR+ElpDzPQ9CQXL+VuYot6hM+hiY4qTE51dvs9g7jLgYj
         512V5ZLzYSe6k/vYVHh9vvZr94uhPfT/Cjy0cauVrVWvRtg5tAewCyDuInUXftt+KsvG
         B1S2kl4jBlAaNwG+WFRq/SBygu9u3HpaLJtMHAutmY9nfrlQu2kI6GFsnbX0OQEPGYGC
         Qn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8Utf9ayM8XYwdDyhQBxYHMwC6OY3jEY8sLyS1jTeXg=;
        b=A0HNBfrj6/NL39FxJ6kabW6QWDaZJDmRQvW0UJ7mBFSeWdgAgmmp8nEBsO1MuC4aOp
         n2c5TcZ+un80CwOdO2iMQpH23zVQKfnwDmccjZzz81QI/eIaPM2SP8aRN09Xn3UfC/OI
         5TuOZBpzZvLvlg0iA0wQA71bfGA8r6AhauQ/Lf0SjgfV16xIo109p9ZgHOCgBGkARZ8q
         yYqE/fpKZj0Mss8Y281L7xY0xbn1Sh3b8W/LZ62HHpBjKAstU7rxQ1VOSEtNEMSwMKrX
         a9YvBbv/vqy/CM7K4IvydtCW3y6LfSpHNbDiAeJKdVaXT8OEsPeoT4rC4LvsDJZfSqsj
         GWMA==
X-Gm-Message-State: APjAAAW3bHA98oK9gT7L9yUxxbAOMtJgTdD1747IpJYrMy8JFk0Ys/5i
        +wXM/oD5qYmGtfOWtStrQnQ=
X-Google-Smtp-Source: APXvYqyJkoy6Ggrpk8jhWGjFJHAeZ+19e82wf8ZmD0+VTralXXO0hdkpacpPn6zSwDjYiWpcx4z3PA==
X-Received: by 2002:a19:23d7:: with SMTP id j206mr3799697lfj.187.1572386769102;
        Tue, 29 Oct 2019 15:06:09 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/19] More improvements for Tegra30 devfreq driver
Date:   Wed, 30 Oct 2019 01:00:00 +0300
Message-Id: <20191029220019.26773-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series addresses some additional review comments that were made by
Thierry Reding to [1], makes several important changes to the driver,
reducing interrupts activity, and adds new features. In the end I'm
proposing myself as a maintainer for the Tegra devfreq drivers.

[1] https://lore.kernel.org/lkml/0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com/T/

Changelog:

v7:  Addressed review comments that were made by Chanwoo Choi to v6 by:

     1. Dropping patch "Ensure that target freq won't overflow".
     2. Making "Use kHz units uniformly in the code" patch more easier
        for review and improving its commit's message.
     3. The "Support variable polling interval" patch is reworked, now it
        doesn't touch things that should stay internal to devfreq core, like
        devfreq->stop_polling and etc. In a result a new generic
        interrupt_driven flag is available for devfreq governors (added in a
        new patch "Add new interrupt_driven flag for governors").

     Patch "Set up watermarks properly" and related to it patches are dropped
     because I found a case where it doesn't work well. These patches need
     some more thought and not ready for now, I'll continue working on them.
     I extracted useful changes from the dropped patches and then tuned up
     MCCPU boost-down coefficient to keep ACTMON silent when system is idling,
     in a result there are these new patches:

       1. Don't enable already enabled consecutive interrupts
       2. Disable consecutive interrupts when appropriate
       3. Tune up MCCPU boost-down coefficient

v6:  Addressed review comment that was made by Chanwoo Choi to v5 by
     squashing "Define ACTMON_DEV_CTRL_STOP" patch into the "Use CPUFreq
     notifier" patch.

v5:  Addressed review comments that were made by Chanwoo Choi to v4 by
     squashing few patches, dropping some questionable patches, rewording
     comments to the code, restructuring the code and etc.

     These patches are now dropped from the series:

       PM / devfreq: tegra30: Use tracepoints for debugging
       PM / devfreq: tegra30: Inline all one-line functions

     The interrupt-optimization patches are squashed into a single patch:

       PM / devfreq: tegra30: Reduce unnecessary interrupts activity

     because it's better to keep the optimizations as a separate change and
     this also helps to reduce code churning, since the code changes depend
     on a previous patch in order to stay cleaner.

     Fixed a lockup bug that I spotted recently, which is caused by a
     clk-notifier->cpufreq_get()->clk_set_rate() sequence. Now a non-blocking
     variant of CPU's frequency retrieving is used, i.e. cpufreq_quick_get().

     Further optimized the CPUFreq notifier by postponing the delayed
     updating in accordance to the polling interval, this actually uncovered
     the above lockup bug.

     Implemented new minor driver feature in the new patch:

       PM / devfreq: tegra30: Support variable polling interval

v4:  Added two new patches to the series:

       PM / devfreq: tegra30: Synchronize average count on target's update
       PM / devfreq: tegra30: Increase sampling period to 16ms

     The first patch addresses problem where governor could get stuck due
     to outdated "average count" value which is snapshoted by ISR and there
     are cases where manual update of the value is required.

     The second patch is just a minor optimization.

v3:  Added support for tracepoints, replacing the debug messages.
     Fixed few more bugs with the help of tracepoints.

     New patches in this version:

       PM / devfreq: tegra30: Use tracepoints for debugging
       PM / devfreq: tegra30: Optimize CPUFreq notifier
       PM / devfreq: tegra30: Optimize upper consecutive watermark selection
       PM / devfreq: tegra30: Optimize upper average watermark selection
       PM / devfreq: tegra30: Include appropriate header

     Some of older patches of this series also got some extra minor polish.

v2:  Added more patches that are cleaning driver's code further and
     squashing another kHz conversion bug.

     The patch "Rework frequency management logic" of the v1 series is now
     converted to "Set up watermarks properly" because I found some problems
     in the original patch and then realized that there is no need to change
     the logic much. So the logic mostly preserved and only got improvements.

     The series is based on the today's linux-next (25 Jun) and takes into
     account minor changes that MyungJoo Ham made to the already queued
     patches from the first batch [1].

Dmitry Osipenko (19):
  PM / devfreq: tegra30: Change irq type to unsigned int
  PM / devfreq: tegra30: Keep interrupt disabled while governor is
    stopped
  PM / devfreq: tegra30: Handle possible round-rate error
  PM / devfreq: tegra30: Drop write-barrier
  PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
  PM / devfreq: tegra30: Use kHz units uniformly in the code
  PM / devfreq: tegra30: Use CPUFreq notifier
  PM / devfreq: tegra30: Move clk-notifier's registration to governor's
    start
  PM / devfreq: tegra30: Reset boosting on startup
  PM / devfreq: tegra30: Don't enable consecutive-down interrupt on
    startup
  PM / devfreq: tegra30: Constify structs
  PM / devfreq: tegra30: Include appropriate header
  PM / devfreq: tegra30: Increase sampling period to 16ms
  PM / devfreq: tegra30: Don't enable already enabled consecutive
    interrupts
  PM / devfreq: tegra30: Disable consecutive interrupts when appropriate
  PM / devfreq: Add new interrupt_driven flag for governors
  PM / devfreq: tegra30: Support variable polling interval
  PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient
  PM / devfreq: tegra20/30: Add Dmitry as a maintainer

 MAINTAINERS                       |   9 +
 drivers/devfreq/devfreq.c         |  14 +-
 drivers/devfreq/governor.h        |   3 +
 drivers/devfreq/tegra30-devfreq.c | 356 +++++++++++++++++++++---------
 4 files changed, 276 insertions(+), 106 deletions(-)

-- 
2.23.0

