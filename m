Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D687A4406
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbjIRIKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbjIRIK3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 04:10:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51499;
        Mon, 18 Sep 2023 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024624; x=1726560624;
  h=from:to:cc:subject:date:message-id;
  bh=z53DQi3OMtw1hJWbbZsWKA60P424xUL1Xq/vuIDGPRw=;
  b=G9LJdc+RmSbo1DOm8yvcT21HUTTi/X8zmjp7+3RyhCXh75z7k52NXzxM
   15R5t2xs9/Q8+xzGm9ZvVxRk3HsfeyzFLMiW+9DnFk1nSqRXnJL8lQgBH
   UZy8znv9F5+y/YJzuIhFuNmWqcedyKm2oXFUQW8ofz6cE86c5pUydhjc2
   eSFyV7j7L2oYsgjyHSivSPqpXW8vZD6Wl2FSp1Fu4pgtUQhV1Yy7c16OL
   fstLZvd6ajlOxM+EV7f2q3xcJ3UNt8I476I4VUe4TBHwqrGYEmcdfW04B
   1B5OqBdr/WO9PedxJ+buufRNommgv6dxw4JdTmkn+oo5mwLCXePTpRQRC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410550826"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410550826"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695442254"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695442254"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2023 01:10:10 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        rmfrfs@gmail.com, jean-baptiste.maneyrol@tdk.com, lee@kernel.org,
        laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH for-next v2 00/10] Fix symbol export for _SIMPLE_ variants of _PM_OPS()
Date:   Mon, 18 Sep 2023 13:39:41 +0530
Message-Id: <20230918080951.3615-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently EXPORT_*_SIMPLE_DEV_PM_OPS() use EXPORT_*_DEV_PM_OPS() set of
macros to export dev_pm_ops symbol, which export the symbol in case
CONFIG_PM=y but don't take CONFIG_PM_SLEEP into consideration.

Since _SIMPLE_ variants of _PM_OPS() do not include runtime PM handles
and are only used in case CONFIG_PM_SLEEP=y, we should not be exporting
dev_pm_ops symbol for them in case CONFIG_PM_SLEEP=n.

This can be fixed by having two distinct set of export macros for both
_RUNTIME_ and _SIMPLE_ variants of _PM_OPS(), such that the export of
dev_pm_ops symbol used in each variant depends on CONFIG_PM and
CONFIG_PM_SLEEP respectively.

Changes since v1:
- Update drivers to new set of macros

Raag Jadav (10):
  PM: Introduce export macros for _SIMPLE_ variants of _PM_OPS()
  PM: Update EXPORT_*_DEV_PM_OPS() to EXPORT_*_RUNTIME_PM_OPS()
  iio: accel: fxls8962af: convert to EXPORT_NS_GPL_RUNTIME_PM_OPS()
  iio: gyro: fxas21002c: convert to EXPORT_NS_GPL_RUNTIME_PM_OPS()
  iio: imu: inv_icm42600: convert to EXPORT_NS_GPL_RUNTIME_PM_OPS()
  iio: imu: inv_mpu: convert to EXPORT_NS_GPL_RUNTIME_PM_OPS()
  drm/imx/dcss: convert to EXPORT_GPL_RUNTIME_PM_OPS()
  mfd: arizona: convert to EXPORT_GPL_RUNTIME_PM_OPS()
  mfd: cs42l43: convert to EXPORT_NS_GPL_RUNTIME_PM_OPS()
  ASoC: cs35l41: convert to EXPORT_GPL_RUNTIME_PM_OPS()

 drivers/gpu/drm/imx/dcss/dcss-dev.c           |  2 +-
 drivers/iio/accel/fxls8962af-core.c           |  2 +-
 drivers/iio/gyro/fxas21002c_core.c            |  2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  2 +-
 drivers/mfd/arizona-core.c                    |  2 +-
 drivers/mfd/cs42l43.c                         |  2 +-
 include/linux/pm.h                            | 38 ++++++++++++-------
 include/linux/pm_runtime.h                    | 13 +++++--
 sound/soc/codecs/cs35l41.c                    |  2 +-
 10 files changed, 41 insertions(+), 26 deletions(-)

-- 
2.17.1

