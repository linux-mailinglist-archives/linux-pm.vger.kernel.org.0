Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6C48889
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfFQQPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41939 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfFQQPI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so5942634pff.8;
        Mon, 17 Jun 2019 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyMLu3J6iYMkAmCwweOVUS9SdYbqG2eLD9uEU5hYSWk=;
        b=ZNSm4e2cY1iwH6h3ep9WHjzTU4egfp6TLe+knIvAAJhcwtxT6xI45yi06Tgmvb1ltk
         QFUAPHSckZJWZAt/xVj33wF6pmYb8LRC/gkbjHYGNbfJxykoWkfjAIt1XX+5BKxCKizg
         XQ/H/jBoiCwZ0OI7+1c7JBRo62gcqhdkI8RoADSZYqNHDvv9Gw8dzuva6ZxdDPq+8wd8
         K34FzQ/xhBSGAXUYvSFtn3ovT+iKuCPvEEYLbJSCKIST/Qz5LtQguaLWyF0qufW4c97P
         21EjOmAoV7qM+l3yEgWKGGMQY+x7jdObdmMQsKLpltL0cHz9Z0UdPvEPrvWx7PMrS/Z4
         1/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyMLu3J6iYMkAmCwweOVUS9SdYbqG2eLD9uEU5hYSWk=;
        b=aPkTm3UU4XZqrXgWIrMK/8nYqalJw21ipUfyaTDhnTIt8pt1uEK0szMOVdBbfd2Pp5
         YPh+/Dahox0QriPM92FL+svV8gteS8Ssn4CsBa9mlv3IHnW4bkaKVfXC2cldkNGZQ0lK
         8TYUpDV1yC6k8ZgX7XdTBuSnpW6ARcelOZQto8Es11sV0gXURrdhlUfkIY48vNZgndBA
         3Jhsj6lzRrMaNqsbXKNXvSBCab+q0OU1g11jwL9mUn86jN2WVWRg+jx54EULa3bWQqN1
         7/0Wl4KmlFcoh/eB+narsZTjTMJNpmYF0yanGQLhSQHfUlug1dCSsy+PgzADnzh+uwGG
         32Tw==
X-Gm-Message-State: APjAAAXxc34izWvGNxYE3U9hrZ/SebtInjOu6rkwBDXe+H7pnUWt2ZUT
        Khjp3rP+7rwrKCBCkuS1ykwCWYqW338=
X-Google-Smtp-Source: APXvYqyPO9pflbLHsKY+dvfoZ9SnoyfH29SPRwuune0MMFyoTaNte8tfGUTTP5lfEShvseHTjn0F+w==
X-Received: by 2002:a17:90a:b00b:: with SMTP id x11mr27192327pjq.120.1560788107419;
        Mon, 17 Jun 2019 09:15:07 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:06 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/12] QorIQ TMU multi-sensor and HWMON support
Date:   Mon, 17 Jun 2019 09:14:46 -0700
Message-Id: <20190617161458.3754-1-andrew.smirnov@gmail.com>
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
working on it on i.MX8MQ.n

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

