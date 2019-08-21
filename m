Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8737696ECA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfHUB0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:26:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34375 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHUB0o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id b24so293394pfp.1;
        Tue, 20 Aug 2019 18:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fq9Ra9tdvF7Qi10iYc1MjapFbh+vHSgrNz2CY+/61MM=;
        b=coIKAROFVWUs2fudMvsIM30iY7nKimYzRfgn45aeULJzlLs1QB0fOXVuteRZQSLjaJ
         NsW6mGpJU983hqjkPgLPHI8O9KAGMIF4/a8i4RAiQePwb0hnV+6WuiqYbUO15tvJ8144
         DsKhuVtWxTQqeX3DVTk6S/CfyDfLzQjeIbFkQaYc2kl7+CCdDlD0EjUclCBwpjVzl8/W
         /PzL0yfpLK2tYOxqO2oL4nTBKAbEYsuucHtiOByYA98nL1nriGWNcttLocS5r0reC/xI
         qfTHenLpcPSQXYdSWvqrriCiE1kFXe1CQiu2lOIpa3DyCZC+uR6i6Tb9YnfvgavhLrxd
         Uk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fq9Ra9tdvF7Qi10iYc1MjapFbh+vHSgrNz2CY+/61MM=;
        b=EJfZQqMnBSA7FUxGkBkD0HlI30QYXXPJPZPtdiaX+5OmNBBSG9cYtmm0VPW9AYwQoN
         slBY1aRh+ipbOAT2kLufSvIfoezkZA2uEIhKmlQWuyPdyBIGT7slA1qlC+DKH0GEdwAS
         FzHC8bqF0jijMbJUDxy9Rv05rOlAZPpJ5A1s5H79YkHGhGXgx46QlNuYCH0LHd8Bj7Db
         5ks7DzwarFTjlil77aTHWa2GGarybK9XxYvpGOaZXjmtxbX6rv8HjviMRsiuT1Wq6W4K
         F/4KdeDa9rMbEvpc2QmNQwEE1piDAEs0L/t6zf9f/P/81YGyNRp10B+3jkkXXjgset/q
         ACwg==
X-Gm-Message-State: APjAAAWmKMZidJhMb21J2KJwIyl3T2NZqAQA07O0limGHxBvyvI5xuDt
        VwdM2VUjFD/1W1Nt+xczu6KNyKMGl/c=
X-Google-Smtp-Source: APXvYqwGWBlXSjWg8kR0ATKfg1mnoTCNz31FYpaI4C8lFQn204TGJj3s9rQNMewoCB6o5gnAwkX0XA==
X-Received: by 2002:a65:4304:: with SMTP id j4mr27961203pgq.419.1566350803489;
        Tue, 20 Aug 2019 18:26:43 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:42 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 00/12] QorIQ TMU multi-sensor and HWMON support
Date:   Tue, 20 Aug 2019 18:26:00 -0700
Message-Id: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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
[rfc] lore.kernel.org/lkml/20190404080647.8173-1-daniel.lezcano@linaro.org


Andrey Smirnov (12):
  thermal: qoriq: Add local struct device pointer
  thermal: qoriq: Don't store struct thermal_zone_device reference
  thermal: qoriq: Add local struct qoriq_sensor pointer
  thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
  thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
  thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
  thermal: qoriq: Convert driver to use devm_ioremap()
  thermal: qoriq: Convert driver to use regmap API
  thermal: qoriq: Enable all sensors before registering them
  thermal: qoriq: Do not report invalid temperature reading
  thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
  thermal: qoriq: Add hwmon support

 drivers/thermal/qoriq_thermal.c | 272 ++++++++++++++++----------------
 drivers/thermal/thermal_hwmon.c |  28 ++++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 175 insertions(+), 132 deletions(-)

-- 
2.21.0

