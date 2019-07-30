Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12CC7ADD8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbfG3QcW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:32:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56213 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfG3QcV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:32:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so57773918wmj.5;
        Tue, 30 Jul 2019 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mJBhLQBGKw9W1CH7iiRGJ+NYhLg8OsmSZT/MaVZztU0=;
        b=AdDy3qZl8TR2Dr1ieEe5a5RTbAFUsZYCOin0+uegsJi40aexEm9s9f5pH/eBmtBmDz
         0CnvAX+yGvHGbmRHR7ZpbwynG/J7kkhff4Vf2ORSOm85OBZYRyQ+CVLmMxjyk/BTfbBh
         jEry6Pw3UceY7nIpklVt4xnekAU7zKpl65JVaTyLfp8y14f7Z5cIuNnrB/45ZcRBsiAu
         +ok2rbCYVIg/s/i9N7WixRlRLhcPOaTVABOuV2YHdUwKUdKk24b8JcjXQCU8ez6TIsf7
         J2MUlDdFt6wgXFzA+ib79IUJwXGF8HFlFj74B3cfe3KwxVXy/gAlv4joKETKQjwdgIPA
         hMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mJBhLQBGKw9W1CH7iiRGJ+NYhLg8OsmSZT/MaVZztU0=;
        b=ip8YF5kQf1twtj5HC6Ff4yu20qcvjTh2jaLzLbPWqrB78xNxksvaunfZRL5KnoqOwf
         ydWA6i86xyqasejNNABUGgawL6+lxFrcn/kQTXVjS03d00GZaO7Met3cpugMCFPJfx+N
         zM6pQJyj94L5zUnSd7iTHyCa+P4+SHAHDDTYXjfNVgAt82gTByMR7fCRDaniBaTzXceY
         mkXnQAhWawE65jtameAhJSsq7aUeLBG3wQTLyo4buKG8S208HNpMW8nNQbok8vVDLN8S
         COgX/BhwD/lYw1JJlvir9JhFFJb20VcRYAiWg9lnGixd8Ny218DC+EUTK16jCfgvNPgW
         OBoA==
X-Gm-Message-State: APjAAAWrWAE3aB/PH/pod5vhpfiLUr/ez4b4CWivb8kNiJjLiKz+FPxz
        moHRvtBY27wPsym5/2/cZ7k=
X-Google-Smtp-Source: APXvYqz1etbIwSkmRp08u8llnZcMpY7U9CUtUhBXvOw2c/P42fpeq1ZAX2ECdyDaCfdoWk1fKhxi5Q==
X-Received: by 2002:a1c:c542:: with SMTP id v63mr103080598wmf.97.1564504338780;
        Tue, 30 Jul 2019 09:32:18 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id c65sm64835175wma.44.2019.07.30.09.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:32:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/20] More improvements for Tegra30 devfreq driver
Date:   Tue, 30 Jul 2019 19:22:16 +0300
Message-Id: <20190730162236.6063-1-digetx@gmail.com>
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

Dmitry Osipenko (20):
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
  PM / devfreq: tegra30: Define ACTMON_DEV_CTRL_STOP
  PM / devfreq: tegra30: Support variable polling interval
  PM / devfreq: tegra20/30: Add Dmitry as a maintainer

 MAINTAINERS                       |   9 +
 drivers/devfreq/tegra30-devfreq.c | 706 +++++++++++++++++++++++-------
 2 files changed, 555 insertions(+), 160 deletions(-)

-- 
2.22.0

