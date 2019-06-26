Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C281655DB1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFZBe7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:34:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40233 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZBe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:34:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so358796lff.7;
        Tue, 25 Jun 2019 18:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJ2vim5KZIApK8x3ewXLTeNdS/0vU4ME8rbQ/SI9AvY=;
        b=nWEUztQtFeiRmi6ulmabtFA6qwg+mF9tIoEySdAet7Ac+qrU7fZRQLxTngA/zUte1O
         XxffWdH8G+hHyfOXQ/zATYw31RGkA62NCazDi+TqsLL3H7XXnUuY+WeTkhBUKQJBMLlB
         Z3zs9kOR6esRFPgMQ4uOsB3NAj8FYhK8/5mUoJq7eg4QcyHuWnZ8jIW+pe5Hj3iecmCq
         6ZV0fWcp2ukcFxZULBnSAm8o7i+A7p8mkzXKYrgkHNwIy51o46m4geg/qaK6wU0q3Rs+
         4xDwe5a8PdWZOb48arVLUHHAcVnvHLZhmSCNPLGumElB6Fb/25G7JPeArnnWg0XzmmFg
         vBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJ2vim5KZIApK8x3ewXLTeNdS/0vU4ME8rbQ/SI9AvY=;
        b=t9n9JMvbG2X949tmzGBzqudoCRl61Odb7qHkwIR/eK01Kp4TnGzNGZOKBMm0714owI
         SjiU5RxUNDLRgCeZqBNcv9v2VLHXLK3gUG5w7qcoXElxepVNC+Nb38IyH6K+Fx1/CzJT
         a0hkkqME1dhxK0OXJGbcNaeWjGYScaYCsVj481FTiwpVh3O/GH3Ki0YTRuA9KAdj2rXv
         zg9a6aLYevqVL0UwPKPPrcPglypfeWzmORKVa1EvQhx72e4iz9q7tEHMiVWTatpsOM9m
         z04KOtqB0+294TydYH7vuL3k49GVw7GotAZjIaH2ly4oTTO6nYwJlYRzdLgpUOE7Pvv4
         bCpg==
X-Gm-Message-State: APjAAAU464u6j/X5zMb5XsQw3ASzI8qixWaq7yqkaRVzalWNY700hcyg
        PnC7AUIdl/jF932+Us25GJU=
X-Google-Smtp-Source: APXvYqzO3fEmmWcJPm56uMETxyIiZAVvFVgQYiK4xpd1n+RBoFRBQ36hLCCmQpLjPWFmtypqPCiucg==
X-Received: by 2002:a19:6a07:: with SMTP id u7mr1004503lfu.74.1561512896931;
        Tue, 25 Jun 2019 18:34:56 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:34:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/17] More improvements for Tegra30 devfreq driver
Date:   Wed, 26 Jun 2019 04:32:34 +0300
Message-Id: <20190626013252.30470-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series addresses some additional review comments that were made by
Thierry Reding to [1] and makes several important changes to the driver,
fixing excessive interrupts activity. In the end I'm proposing myself as
a maintainer for the Tegra devfreq drivers.

[1] https://lore.kernel.org/lkml/0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com/T/

Changelog:

v2:  Added more patches that are cleaning driver's code further and
     squashing another kHz conversion bug.

     The patch "Rework frequency management logic" of the v1 series is now
     converted to "Set up watermarks properly" because I found some problems
     in the original patch and then realized that there is no need to change
     the logic much. So the logic mostly preserved and only got improvements.

     The series is based on the today's linux-next (25 Jun) and takes into
     account minor changes that MyungJoo Ham made to the already queued
     patches from the first batch [1].

Dmitry Osipenko (17):
  PM / devfreq: tegra30: Change irq type to unsigned int
  PM / devfreq: tegra30: Keep interrupt disabled while governor is
    stopped
  PM / devfreq: tegra30: Handle possible round-rate error
  PM / devfreq: tegra30: Drop write-barrier
  PM / devfreq: tegra30: Set up watermarks properly
  PM / devfreq: tegra30: Tuneup boosting thresholds
  PM / devfreq: tegra30: Use CPUFreq notifier
  PM / devfreq: tegra30: Move clk-notifier's registration to governor's
    start
  PM / devfreq: tegra30: Reset boosting on startup
  PM / devfreq: tegra30: Don't enable consecutive-down interrupt on
    startup
  PM / devfreq: tegra30: Add debug messages
  PM / devfreq: tegra30: Inline all one-line functions
  PM / devfreq: tegra30: Constify structs
  PM / devfreq: tegra30: Ensure that target freq won't overflow
  PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
  PM / devfreq: tegra30: Use kHz units uniformly in the code
  PM / devfreq: tegra20/30: Add Dmitry as a maintainer

 MAINTAINERS                       |   9 +
 drivers/devfreq/tegra30-devfreq.c | 562 +++++++++++++++++++++---------
 2 files changed, 413 insertions(+), 158 deletions(-)

-- 
2.22.0

