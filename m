Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77D52FDCAC
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 23:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbhATWby (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 17:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbhATW1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 17:27:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED33C061575;
        Wed, 20 Jan 2021 14:27:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id s24so4062848wmj.0;
        Wed, 20 Jan 2021 14:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKcbJOeGT1X867/R9y81CHjqL2NMHtb7qjxbq5JTTeY=;
        b=WEjw89t9vfKEoWaPW9FfwUDOx7EJFwSflfFIYw7I7k7tG7mjfLOXk4r3Wwq+1JqEQm
         OFRkXqQTNsZfGeO5qk5XlU/FGvRLR+faZ0lAa1BRI+omdBVc3A7vbOdfkTaJh8vJ+CW/
         KxKwKPeZJ2R/wLFDYF/FH7TFeiyTyJWsP/W9OOrei5ZNy1606QXqkginswgWFvx1CFZd
         VV29M0YZBztO7fpfB9SGkoXA4pdPhZN9WDGTRTG89cU73IkT1GINHY5MfOld7V6CLHr1
         r7xeWetE0YOsKgSw8UT9OI9HUTjlVDcx/gEieadPNSdtFJyXtVBSKhq/BUQiR5csP/va
         s+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKcbJOeGT1X867/R9y81CHjqL2NMHtb7qjxbq5JTTeY=;
        b=QMzu0gpS328nKqKRCFuw6gsvdjvLpmzxCLEqyahoPN3C/tOpAqjE2ycTbw2X8mCMJQ
         rgPcbWuEE5qsJ4ww8PAKTSA4qFQIxSv0NwUfKUy1v8jcESQuy3XOycIt9+ooEgmxu3jK
         04fxuHtmKa4uTQn277+zg4x9soZs8KAs2RghKjTffMLRWddnHllicuGbMHNpWpw7OMTU
         U+F1tp/33/ry/v6zX2lnd4v1NGgc3aw7h4zDMQ7Mpkppr5mVZ3ZKBsxU9Y6xA0vMJ4hx
         9YXggAh+GVG33CKQ6cIWTnAl1uL4IVZT1S/0ANnhDsFLhkrHqrrMv0hhUNQnQBplBXEo
         btUg==
X-Gm-Message-State: AOAM533IKCF0pOvdcApozMBbEI9xJH+RTZhqi1mN6lHhtyqewpkdn5iY
        oYbXUeFvvHq5Gz6hU9fNJlo=
X-Google-Smtp-Source: ABdhPJyyrGsYpY1bAWX8P5JPdH4Zf1EuoMPcCtKKcCDcP95EdaCe7tIrn7eHGT2F1R9v6Ws8LWzYDw==
X-Received: by 2002:a1c:a7c5:: with SMTP id q188mr6130788wme.108.1611181620905;
        Wed, 20 Jan 2021 14:27:00 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id i131sm5663710wmi.25.2021.01.20.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:27:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 0/4] OPP API fixes and improvements
Date:   Thu, 21 Jan 2021 01:26:45 +0300
Message-Id: <20210120222649.28149-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series fixes problems and adds features to OPP API that are required
for implementation of a power domain driver for NVIDIA Tegra SoCs.

It is a continuation of [1], where Viresh Kumar asked to factor OPP
patches into a separate series. I factored out the patches into this
series, addressed the previous review comments and re-based patches
on top of [2], which replaced some of my patches that added resource-managed
helpers.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
[2] https://lore.kernel.org/linux-pm/20210101165507.19486-1-tiny.windzz@gmail.com/

Changelog:

v4: - Fixed missing export of devm_pm_opp_attach_genpd(). Thanks to
      Nicolas Chauvet for catching this problem.

    - Removed a bit questionable locking from dev_pm_opp_sync_regulators()
      and dev_pm_opp_set_voltage(). We may come back to the OPP locking
      sometime later, it's not an essential problem right now. I moved
      the lock from OPP core to the PD driver for now.

    - Added "Make _set_opp_custom() work without regulators" patch,
      which is made on top of "Prepare for ->set_opp() helper to work without
      regulators" patch from Viresh Kumar. The set_opp() helper now works
      without regulators.

v3: - Reordered patches by importance.

    - Added locking to dev_pm_opp_set_voltage().

    - Reworked "Fix adding OPP entries in a wrong order if rate is unavailable"
      patch, like it was suggested by Viresh Kumar.

    - Reworked "Support set_opp() customization without requiring to use
      regulators" patch, like it was suggested by Viresh Kumar.

      The opp_table->set_opp_data is now allocated by dev_pm_opp_register_set_opp_helper().

      The set_opp_data is refcounted now and can be allocated by any other
      OPP functions if this will become needed in the future for other OPP API
      changes.

Dmitry Osipenko (4):
  opp: Export devm_pm_opp_attach_genpd()
  opp: Add dev_pm_opp_sync_regulators()
  opp: Add dev_pm_opp_set_voltage()
  opp: Make _set_opp_custom() work without regulators

 drivers/opp/core.c     | 119 +++++++++++++++++++++++++++++++++++++----
 include/linux/pm_opp.h |  12 +++++
 2 files changed, 122 insertions(+), 9 deletions(-)

-- 
2.29.2

