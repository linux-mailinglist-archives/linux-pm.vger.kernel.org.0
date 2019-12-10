Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9803A118DDF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLJQmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45219 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLJQmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so101093pfg.12;
        Tue, 10 Dec 2019 08:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4yKuJg16OrUXavZtdSEQ8v/pPxXaWp48XIXdM7gnu4=;
        b=dYFZSSgQiRAla6qdQ+w9XwLTCZSeayg47Hmu6qVRPLSMzy1nX+QjOoZ8HeWpUONSiO
         HETKrOpTRDfeLrcJcCk/tGvnFebx6fc2vrXUf8tIbB4KUm3PQzsPNJTQ1WvxnmJGq1ij
         qtZgxpuKsKnczArvFM8NyPg4akBo9HibeUdkmX8JmXcM64zhCxWrGabll4CT/tI44EqI
         vxSF5WsgjEx+fk+DeYJ2waDuyBVNqWsAll8SEJ4c3MHulQxSSNEZmnSWo4AURbAfyKTO
         QIzQIXdU1CL0dYqhSt1FUZlX2820QJ2lQdlyY8/ve8lIQjcDMeCI5TAUv9hVHvoosj51
         0n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4yKuJg16OrUXavZtdSEQ8v/pPxXaWp48XIXdM7gnu4=;
        b=Pgu9za8NjN/mP9lH0wJZR4zFxtdDaZR4rLwp3czfORwdxjLklbWwFUWYQsYvxtrbAg
         OUiCUwoJepuS79pgzFDmZKMR+VqHRsZc32jFo41rYy7SH4QLFTqASTkB9SbqEWlev5aA
         H7DjqPeYsIOVaYImPm0g96rpPT9reZHrBIClkDujm2cl9CCk9eQsNPoI4QYOUwtj6hoG
         ZS9Xp6bKvUiLCmrOKZGGkssunCN0QKXLngRYZCvLTvMfv9/QgVUoBBHWaGj9yl+TDgQZ
         5sKvx8jK0T+uO9zCXCOlpoVuUAozRr83rSQGmaxkgedhK86HsarvDCWVRZaxTPY8evbz
         8kbA==
X-Gm-Message-State: APjAAAV6KXhIpVoDlFgg/lWJHFgZvRHMsgFtUhxKqsn9fh6exgjZiYL4
        vWZNqqhzp5nEcYHJaH5mx4I=
X-Google-Smtp-Source: APXvYqz+s7RfHJduf2+bdlhCkqK7XO823WrlA3OOnmYvgBvp0b62ISmZlZiKabOULsVS4ukpzilvnA==
X-Received: by 2002:a63:ce4b:: with SMTP id r11mr19228540pgi.419.1575996126312;
        Tue, 10 Dec 2019 08:42:06 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:04 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/12] QorIQ TMU multi-sensor and HWMON support
Date:   Tue, 10 Dec 2019 08:41:41 -0800
Message-Id: <20191210164153.10463-1-andrew.smirnov@gmail.com>
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

Changes since [v7]:

   - Rebased on top of 12/05 linux-next

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
[v7] lore.kernel.org/lkml/20190912012920.29601-1-andrew.smirnov@gmail.com
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

 drivers/thermal/qoriq_thermal.c | 336 +++++++++++++++-----------------
 drivers/thermal/thermal_hwmon.c |  28 +++
 drivers/thermal/thermal_hwmon.h |   7 +
 3 files changed, 195 insertions(+), 176 deletions(-)

-- 
2.21.0

