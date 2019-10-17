Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42EBDAC19
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409360AbfJQM1p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:27:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32830 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406042AbfJQM1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 08:27:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so1586815pfl.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xXhwH1GxOvSRaIU9bxiCbTTSTX9/U+uLuT7KdF8P4CM=;
        b=e5vaYirqBd7rd5gjNOfLQGnvgXImhmAvNARYpjIdWHGASWHw0wjASMXczXxCHszFi2
         3MXKT6fzXK7e2X2AssVRAaZD431e8zPVVNYDOhlm8uy6duNfEXFaLTyp4+7zVEIWbGEU
         x1eUOLGL4M+uPER1/2PgNcKqx/XeurVzaU/bIWELbvOcpQA4GHpTKESFHiZ/bd2Q1ugo
         ecubimKIgw/orjyVxBxwoIgtI6L07rDyU9VgqAG9c2ekfWCO2gTfp0F5H4adpNLst/UZ
         uh4ArkLfiYCHdFaUPfyHQmUEAyTl2ap8ocOeNSiV7BTDcPZfNsYHVRA/nMSnEMjV6+vx
         SAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xXhwH1GxOvSRaIU9bxiCbTTSTX9/U+uLuT7KdF8P4CM=;
        b=DdCY6G5vw8dJi13u3sn2lvBZEyLDmsnPu25KxlPoI+RhtGUVCQZ/N33aEThsybn/Fl
         Um8Qa8q6f6EjOwLw5K5hWhlbEMrqn2VqRk75vQ8D10WjA9KEIhMTQqVy/l31lPJ3cU5R
         rc4HvjySqeo7gbRg+TEmuaV8IEGmTg/vC+4qpi/oe+9bikFve2VlOc9bNPQjFPyXf677
         00vTkq+WXURHrmYvb3sXHspr33Z0wsumQM+8PN0WK1OjQRFJ55a/Fopgd6DgPpI82spz
         OmeZ2CBZdYOojvfpCErddxjiA+31JyMSBP228/5e6YFUQz1jac8UxFQL+VPF/Brt88cS
         Q4QA==
X-Gm-Message-State: APjAAAXHG3OGjc+vQhsEr2H2BMIX+B/SMyLdq4xzvJUfK8Ul+NQK7w/P
        VzqlSq48TQdv3P70ruUjv3Oh4Q==
X-Google-Smtp-Source: APXvYqwrbDVTljiTae+qiRKHjetQf9tZw02mbcbYDsSUdv32aHy+VpABwoL4ZWvfAIZW85NEPPclAg==
X-Received: by 2002:aa7:9acb:: with SMTP id x11mr3558307pfp.249.1571315264027;
        Thu, 17 Oct 2019 05:27:44 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id h2sm4838518pfq.108.2019.10.17.05.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:27:43 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-clk@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/6] Initialise thermal framework and cpufreq earlier during boot
Date:   Thu, 17 Oct 2019 17:57:32 +0530
Message-Id: <cover.1571314830.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes since v2:
- Missed one patch when posting v2. Respinning.

Changes since v1:
- Completely get rid of netlink support in the thermal framework.
- This changes the early init patch to a single line - change to
  core_initcall. Changed authorship of patch since it is nothing like the
  original. Lina, let me know if you feel otherwise.
- I've tested to make sure that the qcom-cpufreq-hw driver continues to
  work correctly as a module so this won't impact Android's GKI plans.
- Collected Acks

Device boot needs to be as fast as possible while keeping under the thermal
envelope. Now that thermal framework is built-in to the kernel, we can
initialize it earlier to enable thermal mitigation during boot.

We also need the cpufreq HW drivers to be initialised earlier to act as the
cooling devices. This series only converts over the qcom-hw driver to
initialize earlier but can be extended to other platforms as well.

Amit Kucheria (6):
  thermal: Remove netlink support
  thermal: Initialize thermal subsystem earlier
  cpufreq: Initialise the governors in core_initcall
  cpufreq: Initialize cpufreq-dt driver earlier
  clk: qcom: Initialise clock drivers earlier
  cpufreq: qcom-hw: Move driver initialisation earlier

 .../driver-api/thermal/sysfs-api.rst          |  26 +----
 drivers/clk/qcom/clk-rpmh.c                   |   2 +-
 drivers/clk/qcom/gcc-qcs404.c                 |   2 +-
 drivers/clk/qcom/gcc-sdm845.c                 |   2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +-
 drivers/cpufreq/cpufreq_conservative.c        |   2 +-
 drivers/cpufreq/cpufreq_ondemand.c            |   2 +-
 drivers/cpufreq/cpufreq_performance.c         |   2 +-
 drivers/cpufreq/cpufreq_powersave.c           |   2 +-
 drivers/cpufreq/cpufreq_userspace.c           |   2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c             |   2 +-
 drivers/thermal/thermal_core.c                | 110 +-----------------
 include/linux/thermal.h                       |  11 --
 13 files changed, 22 insertions(+), 145 deletions(-)

-- 
2.17.1

