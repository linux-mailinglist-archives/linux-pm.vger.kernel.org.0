Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704AE1102F
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEAXlm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:41:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50785 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAXlm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:41:42 -0400
Received: by mail-it1-f195.google.com with SMTP id q14so362090itk.0;
        Wed, 01 May 2019 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnT0HZUrSkPAf62Nq5Lp+ecgHqDHRXVjUFxnFCahDOY=;
        b=Lqv1YbTqvom86+7/lE6U9SACKtF0F/Qq7zpHyaavTiVV9Wp28vzbpuUS0L1rSB6AGG
         2UmY3Kf7Vu9ylvEYyjVcifFOp6hIj3ev8keSdTLh9FTqvrqO7tIuPGXAW6BOTG15x69X
         B94wg7SzkS5IpUhWkqcWXq0zty2zQN0A0TBRxAMuKBlxsV2+s/GsmKpVo1WPejfWq5FM
         PLgZkq5IxzlhFLW4usrsM2eTnCmFtW2aOawfk8VjZfnYbAaSJxTEWhu7TnqgxBQk0TOH
         H33Gsc10TqfHZtXEof12XS0kLNwd06roWkyDzMPnBW88au5xFRfCUuQObqaEmzCn9MAF
         bd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnT0HZUrSkPAf62Nq5Lp+ecgHqDHRXVjUFxnFCahDOY=;
        b=jMiIvgejnpVI9au7S6uc1dc7NOlV0OUCozNndh35pv1zpAxUNqsmwG64SG4ZfE/hGv
         Gy1Jjpg57SBekh9FEII9Qb/8Heoz7STeVVMEFtMXCxAMWlhoWaNdH1MDYa3oHj1oFQS2
         sTcnRIusCyPtErly17L1/2z1YDcA3s41ilsVU7SCE3G7i8cbyC25xQLwSzv4NeXSddha
         i3zCe4ktysNLLSCs4GH3rLsJi6lNOn2GN5pDJn2xK9NoE8/iaQX1Gff0LYf7Zd8xKtUQ
         0WWaHpJ06vL8c0+UFlXP8iCitmFVmAsm5z9NpraAfkaaUVjLSb40naOuidsigQwoy33a
         FvuA==
X-Gm-Message-State: APjAAAXhnopsU4as135epmhq3KaMrxjpEbX5yX6K/dHRlBSLc0jlmixJ
        b20AJ5e+9Jhw4thSjCoP+kosAshh
X-Google-Smtp-Source: APXvYqzhe09Pgdh3StOglufr1LW3DFH5RNgtkgWKazS/LM4NepZXI3XSVojE4IpPjSiczaWFPlZvpg==
X-Received: by 2002:a24:3755:: with SMTP id r82mr244747itr.60.1556754101322;
        Wed, 01 May 2019 16:41:41 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:41:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and Tegra20/30 support
Date:   Thu,  2 May 2019 02:37:59 +0300
Message-Id: <20190501233815.32643-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changelog:

v4: Addressed all review comments that were made by Chanwoo Choi to v3:

    - changed the driver removal order to match the probe exactly
    - added clarifying comment for 1/8 ratio to the Tegra20 driver

    Chanwoo, please also note that the clk patch that should fix
    compilation problem that was reported the kbuild-test-robot is already
    applied and available in the recent linux-next.

v3: Addressed all review comments that were made by Chanwoo Choi to v2.

    Patch "Synchronize IRQ after masking it in hardware" morphed into
    "Properly disable interrupts", which disables interrupts more solidly.

    Added new minor patch: "Rename tegra-devfreq.c to tegra30-devfreq.c".

    Added missed error handlings for dev_pm_opp_add().

v2: The patchset was quite heavily reworked since v1, few patches we
    dropped or squashed into the new ones and more patches we added.
    In a result more bugs and potential problems are fixed now, driver's
    code got more clean up.

    The Tegra20 driver-addition patch is now a part of this series, it has
    no changes since v1.

Dmitry Osipenko (16):
  PM / devfreq: tegra: Fix kHz to Hz conversion
  PM / devfreq: tegra: Replace readl-writel with relaxed versions
  PM / devfreq: tegra: Replace write memory barrier with the read
    barrier
  PM / devfreq: tegra: Don't ignore clk errors
  PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
  PM / devfreq: tegra: Drop primary interrupt handler
  PM / devfreq: tegra: Properly disable interrupts
  PM / devfreq: tegra: Clean up driver's probe / remove
  PM / devfreq: tegra: Avoid inconsistency of current frequency value
  PM / devfreq: tegra: Mark ACTMON's governor as immutable
  PM / devfreq: tegra: Move governor registration to driver's probe
  PM / devfreq: tegra: Reconfigure hardware on governor's restart
  PM / devfreq: tegra: Support Tegra30
  PM / devfreq: tegra: Enable COMPILE_TEST for the driver
  PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
  PM / devfreq: Introduce driver for NVIDIA Tegra20

 MAINTAINERS                                   |   8 +
 drivers/devfreq/Kconfig                       |  15 +-
 drivers/devfreq/Makefile                      |   3 +-
 drivers/devfreq/tegra20-devfreq.c             | 212 ++++++++++++
 .../{tegra-devfreq.c => tegra30-devfreq.c}    | 315 ++++++++----------
 5 files changed, 379 insertions(+), 174 deletions(-)
 create mode 100644 drivers/devfreq/tegra20-devfreq.c
 rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (81%)

-- 
2.21.0

