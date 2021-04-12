Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4535B9F0
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 07:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhDLFwj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 01:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhDLFwj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 01:52:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CEC061574
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 22:52:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so8217538pjb.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=s9oqpekg6UTvbtV36QgI+UPxeATfQeEORiRuOpyUmUw=;
        b=pQxff+4k5v3NZDu087DhdnsF2QEX+LriwRszS3sRzsX7Eag5eUM9oxCnNze9iq6znT
         940QNDiHu4h1ewM31BSx9eRAbUiXCgq6vg/oKtfCn8wFz0ogncZ8MUevJhp6/WkM0RCB
         C8a5aq907djSKet6LXnqzexhLh6ZZrKSzCyANsqn7RazX/5i56QPLF5uTao3oOUrIK2b
         hk1pTmhBINffq8sINYOWNiB/AJeAzLAiq/jtb6GN8ORdnliPUQq+55aTWJXn7CVjVX1c
         HOSVsDUI9JcWgLmb0EW7qE5f9DUM9tJmK9Q/+LqGhxWlW4tmRUGv2ESDkW2XFmREWnA+
         j4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=s9oqpekg6UTvbtV36QgI+UPxeATfQeEORiRuOpyUmUw=;
        b=WkY+UxyXUdN3pmyNMz/TY4BKlNz3IbRK04sc35wlolfwY5JpWcRM3m9TvVYj+YODSV
         5IDs/yJYyfY2Xe/70LKN4AQL/3PWQOkiMQwlb7PESdRxZTbPsfkQl8B8w23vjc+UvoGj
         AGl198X4UrQvzZXbQps50HILdVXRRlteYKPQre3xxvb4CVw6i/g0P303o3zPJNvp7VSF
         g/u5OHczp9Vpemy57qmbsVQRGh1F4k0R3zFvTsgGeHETMsWCVlO8GFcSzFxT0Q92gaKM
         8mVjyhBIbLC2aHVWT7SPiOlYdEjHtgrmyD1xXs7owXGX/rhldtmE6iPb8GJs4NM5q4GC
         twHg==
X-Gm-Message-State: AOAM530v7qthKfZT74TYLncjbbPmtbmIN7jlxGCZs7KgX2/WSX+Htfw9
        SlptW8c8qDRaP3Jc2qojY+QSpjxlok0iog==
X-Google-Smtp-Source: ABdhPJz2yT731xWc3qjVQLiFJBX3p8RUupiRxDQtyxcWD2sA0d1GEAGhT1NchQyuyfu3PGw+3aMStw==
X-Received: by 2002:a17:90b:228a:: with SMTP id kx10mr7111731pjb.105.1618206741479;
        Sun, 11 Apr 2021 22:52:21 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id p2sm9767093pgm.24.2021.04.11.22.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 22:52:21 -0700 (PDT)
Date:   Mon, 12 Apr 2021 11:22:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.13
Message-ID: <20210412055219.zt47pkorhxbnsg5z@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request adds devm variants for OPP APIs, and updates few of the users
as well (Yangtao Li and Dmitry Osipenko).

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit 606a5d4227e4610399c61086ac55c46068a90b03:

  opp: Don't drop extra references to OPPs accidentally (2021-03-12 09:26:52 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to a8bb0e872bfb962de4653ce8f8723c0e1f712ce3:

  memory: samsung: exynos5422-dmc: Convert to use resource-managed OPP API (2021-03-25 14:38:48 +0530)

----------------------------------------------------------------
Dmitry Osipenko (2):
      opp: Change return type of devm_pm_opp_register_set_opp_helper()
      opp: Change return type of devm_pm_opp_attach_genpd()

Yangtao Li (11):
      opp: Add devres wrapper for dev_pm_opp_set_clkname
      opp: Add devres wrapper for dev_pm_opp_set_regulators
      opp: Add devres wrapper for dev_pm_opp_set_supported_hw
      opp: Add devres wrapper for dev_pm_opp_of_add_table
      serial: qcom_geni_serial: Convert to use resource-managed OPP API
      spi: spi-geni-qcom: Convert to use resource-managed OPP API
      spi: spi-qcom-qspi: Convert to use resource-managed OPP API
      mmc: sdhci-msm: Convert to use resource-managed OPP API
      drm/lima: Convert to use resource-managed OPP API
      drm/panfrost: Convert to use resource-managed OPP API
      memory: samsung: exynos5422-dmc: Convert to use resource-managed OPP API

 drivers/gpu/drm/lima/lima_devfreq.c         |  47 +++--------
 drivers/gpu/drm/lima/lima_devfreq.h         |   3 -
 drivers/gpu/drm/panfrost/panfrost_devfreq.c |  37 ++-------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |   2 -
 drivers/memory/samsung/exynos5422-dmc.c     |  13 +--
 drivers/mmc/host/sdhci-msm.c                |  19 ++---
 drivers/opp/core.c                          | 122 ++++++++++++++++++++++------
 drivers/opp/of.c                            |  36 ++++++++
 drivers/spi/spi-geni-qcom.c                 |  16 ++--
 drivers/spi/spi-qcom-qspi.c                 |  18 ++--
 drivers/tty/serial/qcom_geni_serial.c       |  23 ++----
 include/linux/pm_opp.h                      |  44 ++++++++--
 include/linux/qcom-geni-se.h                |   2 -
 13 files changed, 217 insertions(+), 165 deletions(-)

-- 
viresh
