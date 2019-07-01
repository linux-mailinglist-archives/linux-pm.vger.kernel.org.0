Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C735BDBE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 16:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfGAOM7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 10:12:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46761 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfGAOM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 10:12:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id i8so2916757pgm.13;
        Mon, 01 Jul 2019 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h+XSHd4b1fCkppqiY9xI9ITE6SRy55kX3ODXtBhYc4Y=;
        b=b6xtPlncDUrIYZX6zf/4Q5H9OUfmXC/4aphzSS8PvxnTReap814Ol1dXShonlKeSnB
         11LQ0HCF2+9yz2dtQsG9ULWaUYPTe8Nh6q9Lv26xWHYJP9l4qBH5vSxSxgptrXQt+zCl
         uqGlYngieFglTkBshLGYaLDkle22HW+EbxCp9IBbh0djsPk0ntS5CnbweYAUuiQGZPgp
         y3Dm637tX/0gR0NNmG7gw5BejYKYQ/RyQjzPO/GN9emqiyPefSoqRscferZNy0RBqW9Z
         hz+yeyrHJGOL25aV54Wv78MFCzmd3RTrQAxra4Gm6THquFeIgKm2xiNWMUL6PvInheoe
         +KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h+XSHd4b1fCkppqiY9xI9ITE6SRy55kX3ODXtBhYc4Y=;
        b=QmB8KuTyWZD5IsRITqC0ThjoKAZPRSiOSbNyuR2Osd1I0JBXPtaqKhSGzupgY6PCwa
         rWWizzVyr/Lr2Ov2oQJow3xgnCt/1/ZPoptlv7Zp6k5trF67OfzjXpQRAdMiM8zt1tee
         Pz4oyZ4hFcMg03Tcsr06cG4BNneNklOxMp4iQY7CJ+AlRh1yt75rsG+GDGm2kY4FBHR7
         QkMOh0O6ovLv6Ze0y1QFHBGyv414PEf+bb8YvCssFVRHmbMEnVmREsLYD0Ng48m574Ta
         VZizbPY/LGGoP0LvZhfFwRWKdgjP91R1/BcpQeNg/B6s1dWrEqgKYbR4gDfdH9q9pYr9
         PezA==
X-Gm-Message-State: APjAAAVvKrxIAdjWpZqAcYmPCLib2qLtsBbhIChbX5Vs8sxNjk2nl2k3
        HZUhEWHu5LFlEYwDFLzn8ZM=
X-Google-Smtp-Source: APXvYqxRq/1gXDaWEnyYxzo3l2cPbCJtiGPUMJ/+a7VBlfAQOYU32bUQ+MFApH+victAg0twkrGN6A==
X-Received: by 2002:a65:510c:: with SMTP id f12mr24221010pgq.92.1561990378431;
        Mon, 01 Jul 2019 07:12:58 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id n19sm11383871pfa.11.2019.07.01.07.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 07:12:57 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Rob Herring <robh@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 0/4] nvme: add thermal zone devices
Date:   Mon,  1 Jul 2019 23:12:30 +0900
Message-Id: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The NVMe controller reports up to nine temperature values in the SMART /
Health log page (the composite temperature and temperature sensor 1 through
temperature sensor 8).
The temperature threshold feature (Feature Identifier 04h) configures the
asynchronous event request command to complete when the temperature is
crossed its corresponding temperature threshold.

This provides these temperatures and thresholds via thermal zone devices.

The main purpose of this is to turn on a fan when overheated without
polling the device for the smart log that could prevent the lower power
state transitions.

In addition to the standard thermal zone device, this adds support for
registering the DT thermal zone device.

* v5
- remove 'Export get and set features' patch as it has been merged in -next
- split the DT thermal zone support into separate patch
- round up temperature when writing trip point
- add DT binding documentation
- don't register both standard and DT thermal zone
- use thermal_zone_device_update() instead of thermal_notify_framework()

* v4
- add thermal.c to hold thermal zone related code
- add 'use_thermal_zone' module parameter
- add CONFIG_THERMAL_WRITABLE_TRIPS dependency
- add comment about the return value of nvme_thermal_zones_register()
- support DT thermal zone device.
- use bitmap to iterate over implemented sensors

* v3
- Change the type name of thermal zone devices from 'nvme_temp<sensor>' to
  'nvme<instance>_temp<sensor>'
- Pass a NULL to the status argument of nvme_set_feature()
- Change the name of symbolic link from 'nvme_temp<sensor>' to 'temp<sensor>'
- Don't make it fatal error if the device provides a response
- Don't register thermal zone for composite temperature if smart log reports
  zero value
- Move the thermal zones registration and unregistration into the core module.

* v2
- s/correspoinding/corresponding/ typo in commit log
- Borrowed nvme_get_features() from Keith's patch
- Temperature threshold notification is splitted into another patch
- Change the data type of 'sensor' to unsigned
- Add BUILD_BUG_ON for the array size of tzdev member in nvme_ctrl
- Add WARN_ON_ONCE for paranoid checks
- Fix off-by-one error in nvme_get_temp
- Validate 'sensor' where the value is actually used
- Define and utilize two enums related to the temperature threshold feature
- Remove hysteresis value for this trip point and don't utilize the under
  temperature threshold
- Print error message for thermal_zone_device_register() failure
- Add function comments for nvme_thermal_zones_{,un}register
- Suppress non-fatal errors from nvme_thermal_zones_register()
- Add comment about implemented temperature sensors 
- Instead of creating a new 'thermal_work', append async smart event's
  action to the existing async_event_work
- Add comment for tzdev member in nvme_ctrl
- Call nvme_thermal_zones_unregister() earlier than the last reference
  release

Akinobu Mita (4):
  nvme: add thermal zone devices
  dt-bindings: thermal: nvme: Add binding documentation
  nvme: support DT thermal zone device
  nvme: notify thermal framework when temperature threshold events occur

 Documentation/devicetree/bindings/thermal/nvme.txt |  56 ++++
 drivers/nvme/host/Kconfig                          |   1 +
 drivers/nvme/host/Makefile                         |   1 +
 drivers/nvme/host/core.c                           |  19 ++
 drivers/nvme/host/nvme.h                           |  40 +++
 drivers/nvme/host/thermal.c                        | 343 +++++++++++++++++++++
 include/linux/nvme.h                               |  12 +
 7 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvme.txt
 create mode 100644 drivers/nvme/host/thermal.c

Cc: Rob Herring <robh@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
-- 
2.7.4

