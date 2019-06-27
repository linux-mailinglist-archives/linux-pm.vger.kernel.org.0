Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3286858C90
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfF0VM0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39137 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0VM0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so2526159lfo.6;
        Thu, 27 Jun 2019 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBc6n3CYBkvzlHwB103ylCdVYWoXy633oQ/H/yLj6/w=;
        b=IBVQo2NIxQgWfrMsSBV/CHWRUTOIIF9Xagubni4fRrQxJNeWq3bbXN1Qb10t1LDe/I
         +Ndj9PzHav8EWxvP2tQJkDUIWLrO4R3OhRtMM9gCDv/ZBkKl8U0ZyUt41D7CjGf8b2j2
         XwOsUwEmYxfq1whLJgzPDJcLPRTlTbnT8stnDJkYvYIVuIR9ZJGSaoaxloBhDiUUEtMZ
         Nj3KIw22UYd1KPDvv9IIA18T/JsrEf599L3QmuwY1ihE8Pn02SkZ+KLZ2D5UZccIL84a
         VzaZON9wBf6uDdk4GV9X625QLhJIzYZ0q/QP1iMBZ0C+RpBR0SgdJgdLN44DeUfBYnG7
         IwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBc6n3CYBkvzlHwB103ylCdVYWoXy633oQ/H/yLj6/w=;
        b=UB6XfqXlOAoUucHK6ZC3jhfsC8EvGeur/VqvR/spxuwWATY0r1bg47UpXd+VKe2Skl
         e08+5iFPpN7f2ru9TTuX8b38CkFHTmkVkP3JCuCqMyH/ddApoNuHIZGGvGILeGVnQCKp
         KyeqrSFvbcpbf79y/PYnnJ7EDcyp8uFE9iL6F3Z3LtuMlIYRMFFtGEJ3nl1Axs0YO5yt
         I7bJfBdK6OP1svY7yvti0eo2THyYKwp1wSNdAaBgy5nJwHnRUhAGOU3VZsqe/sxS0/0j
         pKXZmnfTQH4vv1EUQyeG6N7CtoFerpX62ZzKUekP0Z7YrZFk1v2AA1FLlbtVQG+VL57x
         VQyQ==
X-Gm-Message-State: APjAAAWR6tovM5apYj90gKX0JPet3Hjtdo/OxzlQzocMJjLcY6Zo8CVn
        qpP+nPN6nqEK3GBorBQsXpw=
X-Google-Smtp-Source: APXvYqx/N1+0rPOFfGO+DAGSU3BX6/9MST9BPLoWWDpXv3liIvxdN7ty5A1jm6+tx0wK2VCm4zmW/A==
X-Received: by 2002:ac2:4839:: with SMTP id 25mr3154376lft.79.1561669943453;
        Thu, 27 Jun 2019 14:12:23 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/22] More improvements for Tegra30 devfreq driver
Date:   Fri, 28 Jun 2019 00:10:53 +0300
Message-Id: <20190627211115.21138-1-digetx@gmail.com>
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

Dmitry Osipenko (22):
  PM / devfreq: tegra30: Change irq type to unsigned int
  PM / devfreq: tegra30: Keep interrupt disabled while governor is
    stopped
  PM / devfreq: tegra30: Handle possible round-rate error
  PM / devfreq: tegra30: Drop write-barrier
  PM / devfreq: tegra30: Set up watermarks properly
  PM / devfreq: tegra30: Tune up boosting thresholds
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
  PM / devfreq: tegra30: Use tracepoints for debugging
  PM / devfreq: tegra30: Optimize CPUFreq notifier
  PM / devfreq: tegra30: Optimize upper consecutive watermark selection
  PM / devfreq: tegra30: Optimize upper average watermark selection
  PM / devfreq: tegra30: Include appropriate header
  PM / devfreq: tegra20/30: Add Dmitry as a maintainer

 MAINTAINERS                            |   9 +
 drivers/devfreq/tegra30-devfreq.c      | 631 ++++++++++++++++++-------
 include/trace/events/tegra30_devfreq.h | 105 ++++
 3 files changed, 583 insertions(+), 162 deletions(-)
 create mode 100644 include/trace/events/tegra30_devfreq.h

-- 
2.22.0

