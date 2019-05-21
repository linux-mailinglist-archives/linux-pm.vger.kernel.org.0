Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52042254CD
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfEUQE2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 12:04:28 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:41967 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQE2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 12:04:28 -0400
Received: by mail-pl1-f181.google.com with SMTP id f12so8652691plt.8
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2019 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nk+/ciJTmIcBRGNtwKGKAlhXjyIqj/WCax4ZAyWNJvI=;
        b=n8itc6KpW9b62d7kZTafU9Be8Rh6F3YYh0MblP5v2Rd3atB0SxQyAo+DvmdmP+IL0R
         Ti0i4Ry9D7v/OBhYDoRsK6Zs8SnwsSMrz8XebxeNVkjS1CV0YwkyjX13IlgXGUOw3B6V
         nVL7MAFl0h/IGpEO72nqYRMyhRLiUo1DAxWluV6a8BPXmpHArCgujY7t/5xCJdgj3CBP
         EjtSZWYrcWw/AxoepLPYIFWeeLk1gY+Kj1C5bG+f7d8yAgbS3zoVVd1ua8RcV5bM6CTf
         sEvp7jpYUF3HV8J5wPHuL+khaX2bVmtd+9JJ8ddmZl/TlXVI24O76xeFZ8ERRHZrQwGF
         n4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nk+/ciJTmIcBRGNtwKGKAlhXjyIqj/WCax4ZAyWNJvI=;
        b=m55atzbmr5To3kLw88CmcMK8cxw+H3YwK1O5Wfwcjh+1X/S0mLIYUsaqDnVAN9KRB7
         2k7k4Fcro73v23w+RKJKmJwWWR7DeHwe3HSoqwUmv6SIBMyOn6yIciris88XQg72xaU8
         wgUZJLkD/FQ3Z/qUcN3IOhjPZIXTREL3v3GvhyUEsU3RCtHb4h5c0oophXNjwhwCCA7D
         Xzd35gXYXCEuIsWC+a4wUlxHTKWwcR1BYKJILfaBGzllvsF5DcT/tIE4XblWgWosuIKs
         CFgFcdECiGmBVggFSIX6du5gRvXSKit9rqY7IkBEAqcH1jeoxaTN/rHEr4Ebe+L1dXjK
         kTOg==
X-Gm-Message-State: APjAAAXCN4u7mmt8+l0X0L9RlPeuNpiJxZ189y/Ax99MPo8ZF4W1fQhV
        gN29XihHJwQYsvhL8e6Z9NE=
X-Google-Smtp-Source: APXvYqxRakC6491Var96axSgPs7513lbbFuXi1FP2lOh833bGTyI8P9IlnxdSUuvQR3n5FsuxgeA6A==
X-Received: by 2002:a17:902:1021:: with SMTP id b30mr45020517pla.324.1558454667844;
        Tue, 21 May 2019 09:04:27 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:9cd0:73e8:b74a:624e])
        by smtp.gmail.com with ESMTPSA id j5sm28954786pfa.15.2019.05.21.09.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 09:04:27 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2 0/4] nvme: add thermal zone devices
Date:   Wed, 22 May 2019 01:04:05 +0900
Message-Id: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
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

This provide these temperatures and thresholds via thermal zone devices.

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

Akinobu Mita (3):
  nvme: add thermal zone infrastructure
  nvme: notify thermal framework when temperature threshold events occur
  nvme-pci: support thermal zone

Keith Busch (1):
  nvme: Export get and set features

 drivers/nvme/host/core.c | 317 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  31 +++++
 drivers/nvme/host/pci.c  |   5 +
 include/linux/nvme.h     |  12 ++
 4 files changed, 362 insertions(+), 3 deletions(-)

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
-- 
2.7.4

