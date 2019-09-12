Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B083B0681
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfILB3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:29:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41942 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfILB3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:29:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so14818718pfo.8;
        Wed, 11 Sep 2019 18:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrU0IYQyBsvMOvZ5TK8iQito/Esd2MFSggYTGJLHDkc=;
        b=oVlGs8wEHyMq2aHibt8pv7DGRYuR46TxlFYyXShCGB8EBnNs1tTZbBcAuMNdCJGtHu
         YdROYUhTvnMV0BJkZReaUMRUHBH/TrS5J/T0nLbcGaiokMdAto6awCsjKtu+T5aXZQUQ
         lqXmrxkmj1NZqTOiLzvoadmNDeK7N58yKwsOYfw5i0tGTdTvcdngv+qayShH/XuZLNWU
         QvPZNbieLQp5k0UAvw1GALMz/UDZG9j2ZIkAaoODwGM0EzoNEPXfeIt/ujoUQaNWIwK2
         JKhchno2yWnDyvv76vXXqCyKN22C1X4woF1+kzRu5ngGZnPQM878v6UHjBF5BsU5jTvw
         /v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrU0IYQyBsvMOvZ5TK8iQito/Esd2MFSggYTGJLHDkc=;
        b=i5MmHQdMgbsNsRJJeeSttbN72W5dJSSCkkgAgd5qvZTWncoF3kLF6R4Wy01TLQYtTs
         5bvrETCQJb6uE001sN/dqOQPdKqdfPf0dom31QuprS47IVGcYXdXVfFv5PkptXPmohtZ
         v6+S+/r9ECkxTFEwkhK7D0TU0EbJAXxgabzD8e8cwT/ngA2Vdp3swWYpWk39wtp+TH+P
         UwI1NJ7T1Bj+taiTUL7zyIOvKYkR3HMgNrOwoXz6sAePMTmZ5QwOy/MFFZYX1nn9uiYD
         /8OoujY5MQbqHl7wbi771MUec08cz3rkud0VR0EJjrXmi373IrFHw5WiOP7YY24AsBlb
         JR0A==
X-Gm-Message-State: APjAAAWLHELmbiLyxfuVNkRnnHwkxkFeVQkPMIaP7P8zFK5/rjFd2SHq
        DaN+HcwHSsHVOC4aZygbyd8=
X-Google-Smtp-Source: APXvYqwpBJXwypJdVsMeTL4dGUOto9izo+02b3dNt1K3AS585lTETmUfg4NHKb00DbPxYcXhyp9bGA==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr376400pgk.431.1568251778054;
        Wed, 11 Sep 2019 18:29:38 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id u4sm20781699pfh.55.2019.09.11.18.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:29:36 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/12] QorIQ TMU multi-sensor and HWMON support
Date:   Wed, 11 Sep 2019 18:29:08 -0700
Message-Id: <20190912012920.29601-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Everyone:

This series contains patches adding support for HWMON integration, bug
fixes and general improvements (hopefully) for TMU driver I made while
working on it on i.MX8MQ.

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v6]:

   - Rebased on top of Zhang's "next" branch

   - Added "thermal: qoriq: Drop unnecessary drvdata cleanup"

Changes since [v5]

    - Rebased on recent linux-next, dropped "thermal: qoriq: Remove
      unnecessary DT node is NULL check" since it is already in the
      tree

    - Dropped dependency on [rfc]

Changes since [v4]

    - Collected Tested-by from Lucas
    
    - Collected Reviewed-by from Daniel

    - Converted "thermal: qoriq: Enable all sensors before registering
      them" to use if instead of switch statement for error checking

Changes since [v3]

    - Series reabse on top of [rfc]
    
    - Fixed incorrect goto label in "thermal: qoriq: Pass data to
      qoriq_tmu_calibration()"
      
    - Added REGS_TRITSR() register description to "thermal: qoriq: Do
      not report invalid temperature reading"
      
    - Reworded commit message of "thermal: qoriq: Remove unnecessary
      DT node is NULL check"

Changes since [v2]

    - Patches rebased on v5.1-rc1

Changes since [v1]

    - Rebased on "linus" branch of
      git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
      that included latest chagnes adding multi-sensors support

    - Dropped

	thermal: qoriq: Add support for multiple thremal sites
	thermal: qoriq: Be more strict when parsing
	thermal: qoriq: Simplify error handling in qoriq_tmu_get_sensor_id()

      since they are no longer relevant

    - Added

	thermal: qoriq: Don't store struct thermal_zone_device reference
	thermal: qoriq: Add local struct qoriq_sensor pointer
	thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
	thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly

      to simplify latest codebase

    - Changed "thermal: qoriq: Do not report invalid temperature
      reading" to use regmap_read_poll_timeout() to make sure that
      tmu_get_temp() waits for fist sample to be ready before
      reporting it. This case is triggered on my setup if
      qoriq_thermal is compiled as a module

[v1] lore.kernel.org/lkml/20190218191141.3729-1-andrew.smirnov@gmail.com
[v2] lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com
[v3] lore.kernel.org/lkml/20190401041418.5999-1-andrew.smirnov@gmail.com
[v4] lore.kernel.org/lkml/20190413082748.29990-1-andrew.smirnov@gmail.com
[v5] lore.kernel.org/lkml/20190424064830.18179-1-andrew.smirnov@gmail.com
[v6] lore.kernel.org/lkml/20190821012612.7823-1-andrew.smirnov@gmail.com
[rfc] lore.kernel.org/lkml/20190404080647.8173-1-daniel.lezcano@linaro.org

Andrey Smirnov (12):
  thermal: qoriq: Add local struct device pointer
  thermal: qoriq: Don't store struct thermal_zone_device reference
  thermal: qoriq: Add local struct qoriq_sensor pointer
  thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
  thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
  thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
  thermal: qoriq: Drop unnecessary drvdata cleanup
  thermal: qoriq: Convert driver to use regmap API
  thermal: qoriq: Enable all sensors before registering them
  thermal: qoriq: Do not report invalid temperature reading
  thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
  thermal: qoriq: Add hwmon support

 drivers/thermal/qoriq_thermal.c | 252 +++++++++++++++++---------------
 drivers/thermal/thermal_hwmon.c |  28 ++++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 167 insertions(+), 120 deletions(-)

-- 
2.21.0

