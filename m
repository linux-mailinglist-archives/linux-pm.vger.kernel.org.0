Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5643A74
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfFMPVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:21:18 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:43103 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfFMPUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 11:20:53 -0400
Received: by mail-pg1-f180.google.com with SMTP id f25so11139678pgv.10
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cbSuT3oGjvIR+sARU/EqP3cMk9NkxTMi+chkMo+Xgd8=;
        b=GYA4QfzJ31sVC8bg4WMlTmsKR3+wJ8uwWET9uagjisTWVAClgEliYyv/f2O3o0eRvg
         bymAHZqdaqAG1CDba+CVbJatnn7I0gWpnRbLaJNmLXpX+7+RPJ9ZDP5b4NxW3S9KJcf1
         8DGvndPgDdrJgVO/10D/XQpe9XfV1UTEU/I5G3TVyZDMDjWrR3zT/tQsJ3ZloGsOMEk7
         DMqeeVHCXVtIdzuFl7ZoIk4XbyVuO4NcieAkx0Z82icsqTQHZCIt7YsDt2khWN66Do0y
         zKi8hGs3OIzZ5yzNsqexf1HO58Yrn1h3YpfFD+pEdlee3Luwj7YNbtARGnD6NhvM6atw
         7VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cbSuT3oGjvIR+sARU/EqP3cMk9NkxTMi+chkMo+Xgd8=;
        b=HOrCAFJ6E8jFPPgyPgUJcDP/k1ZYWbuj3JbXfHGgPO98JEPzD4bTG/7AfGkVqP45cd
         aPiIY7CzLizt6+4XsqwSOQWVb4icPlblfXlNbO8GVenY6ZJ4W6UuCcNWfQlOByerhr2P
         N+JMexMk4NjyrlZ2eok0Ov6d0YMljYibRKqhVDgIuR3PPxh/nr9caShP31dofOvcRsU2
         9QbyYge7Y2V30OPbJvzaP2R8ohgSmylR2o/90Cd+ryv/GMmAe2TLq0hDvgTt9X4gRmqE
         ck1EISvGhpt0SqavDKfmu8ANmiUve3gwpN+gxI5q7+s9eO/ZlN4X8lOQXQaPUyfgOcyD
         UJPQ==
X-Gm-Message-State: APjAAAV6gzY3lW20HduhzgwIzhIRUdD2Vpq5rSlU5m7hMkkIiAyW94Ic
        o47ItvK//yE9HGglmCtoxPw=
X-Google-Smtp-Source: APXvYqzNOnMaVi7qOjPVkmsbyB3V+/+fmz5KZPffUlYIhLBfW2iLsgeeqzSSiSki2WpfBGDP/uOrcQ==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr6177041pjs.101.1560439253201;
        Thu, 13 Jun 2019 08:20:53 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id n66sm40988pfn.52.2019.06.13.08.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 08:20:52 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v4 0/3] nvme: add thermal zone devices
Date:   Fri, 14 Jun 2019 00:20:35 +0900
Message-Id: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
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

In addition to the standard thermal zone device, this also adds support for
registering the DT thermal zone device. (This is currently untested, but
I plan to get a SBC with PCIe to test with DT)

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

Akinobu Mita (2):
  nvme: add thermal zone devices
  nvme: notify thermal framework when temperature threshold events occur

Keith Busch (1):
  nvme: Export get and set features

 drivers/nvme/host/Kconfig   |   1 +
 drivers/nvme/host/Makefile  |   1 +
 drivers/nvme/host/core.c    |  43 +++++-
 drivers/nvme/host/nvme.h    |  46 +++++++
 drivers/nvme/host/thermal.c | 323 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h        |  12 ++
 6 files changed, 423 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/host/thermal.c

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

