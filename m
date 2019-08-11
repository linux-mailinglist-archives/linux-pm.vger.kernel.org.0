Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9089427
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfHKVYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:24:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39811 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKVYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:24:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id x4so4489238ljj.6;
        Sun, 11 Aug 2019 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w78o7FE+His5sDh+LTJiPbYrRNieIA8qgNLYlAInU8M=;
        b=iclCAz3T0y5eD2TmYcRtT28YN8BkY6YshqtmIg34GgsP5OiA5OR31z0yfb6OZ9Lxzw
         wNN9kyKYdcgsa/hkcUHRpMfDWnfD8XSrOTvebPhsQI/JV45748rqir7oL448rPnGaJHM
         dFvJqwX0LcBFFmNC+pV0KW2jVytGSL0fsj236CCL0FMG4uynhSpXSsI5nmJusB+fsXqP
         3dEEf0+sHH8wznMskKVAq1Y6unIh5K9YKhhbtGDeCwqVKqPmFwd1k0XfXtvgukn/ItUT
         GmEfVtFVkZfLCvLrGnL8V7M76ukdq9P36IePdu85HDRMn8ZioXmoQizfQC0kdhgzyow9
         b8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w78o7FE+His5sDh+LTJiPbYrRNieIA8qgNLYlAInU8M=;
        b=MwyqUoweUSn6eklfSoCrNvkDECWxQITdA5AUIONdwgZutJ6SCljtWCqF+YyU0AexvB
         oUUBBZq13VhRhACoKJNvc+Saa8GNZ+2mhhlv++RtPn9EFuDFA8A3AgM0yivOEtkjZeFJ
         A0qgS+JWdBvzrCHaHm3nYiPKfsiiPm0mpn8JfiywXHw5EfQBfthLHjBHWTLXZ6K0MjSV
         PONIFr9ySC3y+OPrJzjK1MuKuyj+AOZabyCJyI8MkPt+ZyhGKh2v8AV0l/zw/s377Jle
         bB2gIYC7951yd7jNC2h82CAe8JNLSowU9Fx19CKTtvW+NmirjdfqeFOc9x3ln9KEefZg
         z9xw==
X-Gm-Message-State: APjAAAUlrVedwpa8L4pVfeGSQXUhDJBN+Q4sOD/1Tta95x1n5D7yMVWn
        3waTDUkvEYjEmMhcFrL8eqc=
X-Google-Smtp-Source: APXvYqzuO+iieBlcFcsuaq5fdI2Aj7FYIn83ut4GNwr+hmESKf0l3dWOCJe6Rcy8yCff1PzGxBdcyw==
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr7745507ljg.70.1565558673179;
        Sun, 11 Aug 2019 14:24:33 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id f1sm20470806ljk.86.2019.08.11.14.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:24:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/19] More improvements for Tegra30 devfreq driver
Date:   Mon, 12 Aug 2019 00:22:56 +0300
Message-Id: <20190811212315.12689-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series addresses some additional review comments that were made by
Thierry Reding to [1], makes several important changes to the driver,
fixing excessive interrupts activity, and adds new features. In the end
I'm proposing myself as a maintainer for the Tegra devfreq drivers.

[1] https://lore.kernel.org/lkml/0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com/T/

Changelog:

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
  PM / devfreq: tegra30: Set up watermarks properly
  PM / devfreq: tegra30: Tune up boosting thresholds
  PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
  PM / devfreq: tegra30: Ensure that target freq won't overflow
  PM / devfreq: tegra30: Use kHz units uniformly in the code
  PM / devfreq: tegra30: Reduce unnecessary interrupts activity
  PM / devfreq: tegra30: Use CPUFreq notifier
  PM / devfreq: tegra30: Move clk-notifier's registration to governor's
    start
  PM / devfreq: tegra30: Reset boosting on startup
  PM / devfreq: tegra30: Don't enable consecutive-down interrupt on
    startup
  PM / devfreq: tegra30: Constify structs
  PM / devfreq: tegra30: Include appropriate header
  PM / devfreq: tegra30: Increase sampling period to 16ms
  PM / devfreq: tegra30: Support variable polling interval
  PM / devfreq: tegra20/30: Add Dmitry as a maintainer

 MAINTAINERS                       |   9 +
 drivers/devfreq/tegra30-devfreq.c | 706 +++++++++++++++++++++++-------
 2 files changed, 555 insertions(+), 160 deletions(-)

-- 
2.22.0

