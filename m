Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF77ED4D8
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfKCUmG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38992 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfKCUmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id y3so15387194ljj.6;
        Sun, 03 Nov 2019 12:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h+y9JvQKmkZDektrVGodVCasQAVlpaUJr5NA4uPYFA=;
        b=Dk7m+jJ7LcmTyP23Ve1A1hk6rp36ct7ojMjPxPj2TWl7pSZQas4ED4+j+R6M+5eWjB
         aJj/RXJy2Lj2icmKMgkEFOagKL92+ZBy3OQT9XMu2gmzKYPgwh5h6b3+01/Eig4c7rQx
         QscmBTvUt9/GyliyZVg7PWt3G/IZhdaHH7grPd7mek7uUK9MrBvA5eU7lWI3dmkgLIDj
         IJYhIrbxDErrVCW8Ag+6G+Yc19U/KNUniFP52/uCpUwPlXfc4UK9zpUxEy/SlBgk46oH
         aB5MMug3my3jO8xzt7dD4OQCgVB22ru1T2amhXOE/jciV1w9e+cofz8IrjsuYGacEQ8o
         f4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h+y9JvQKmkZDektrVGodVCasQAVlpaUJr5NA4uPYFA=;
        b=iaSNWQKziUvqIUb4sRRM53umSFkEta4oKhY3n4hIiSqymYXnseh2an2/udruE6+UBb
         ssW0K5+hgDStpznLPNz69oZc6kUV9dgR7KMGHU9JfC82lhR9lXIQ7AKgduYW02oa4JQ4
         12XUhjfgR2QvXY6hpp6CNVJxVAYf2o5yXH+Xpm79p+0sAKtaPalJTJE/LcG1e6Ci6ETy
         DWSjwp13G5AXbgooIvObXP8XYdecCbqs7R/apDvJ46WDtxASQ7EFlaDpBsf0DzdvUlGw
         Ma7eICN1roqnh1qeBvflq/LIVmAa+fay4/vJnZWwWSc55+Q4DRXPQDTtCBPKwighiJJu
         VAsA==
X-Gm-Message-State: APjAAAVZPEtx0l2L2ThN7aVyp748UX3sUUrVMLkpIjFsMS6Jr5kUpjuX
        ZdOE0syaUBZGz7MAH9eUkkk=
X-Google-Smtp-Source: APXvYqy6NiGv42MNYpUo7Zk8PMP8FbSnXUwlGM7JbrPsHXiVL5D6mmWdrXTpd8pByYbmfa1qEnhaJA==
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr9873898ljj.232.1572813722406;
        Sun, 03 Nov 2019 12:42:02 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/18] More improvements for Tegra30 devfreq driver
Date:   Sun,  3 Nov 2019 23:41:12 +0300
Message-Id: <20191103204130.2172-1-digetx@gmail.com>
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

v8:  Addressed review comments that were made by Chanwoo Choi to v7 by:

     1. Taking into account suggestions that were made for the "Add new
        interrupt_driven flag for governors".

     2. Patch "Support variable polling interval" now doesn't use
        devfreq->stop_polling and uses tegra->cur_freq instead. There is
        now a comment for the 256ms max polling interval limitation as well.

     The patch "Increase sampling period to 16ms" is dropped from the series
     for now since we found out that it doesn't bring much benefit.

     The cur_freq value is now refreshed after clk-notifier registration in
     the "Move clk-notifier's registration to governor's start" patch, for
     consistency. This also becomes useful for the "Support variable polling
     interval" patch since it now uses the cur_freq for tracking of the
     governor's enable-state.

     The patch "Support variable polling interval" now has a proper scaling
     of the dependency threshold value, which I missed to backport into
     v7 after dropping some of the v6 patches. The do_percent() function
     now doesn't suffer from integer overflow bug when freq, boosting and
     polling interval values are too large.

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

Dmitry Osipenko (18):
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
  PM / devfreq: tegra30: Don't enable already enabled consecutive
    interrupts
  PM / devfreq: tegra30: Disable consecutive interrupts when appropriate
  PM / devfreq: Add new interrupt_driven flag for governors
  PM / devfreq: tegra30: Support variable polling interval
  PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient
  PM / devfreq: tegra20/30: Add Dmitry as a maintainer

 MAINTAINERS                       |   9 +
 drivers/devfreq/devfreq.c         |   9 +-
 drivers/devfreq/governor.h        |   3 +
 drivers/devfreq/tegra30-devfreq.c | 394 +++++++++++++++++++++---------
 4 files changed, 303 insertions(+), 112 deletions(-)

-- 
2.23.0

