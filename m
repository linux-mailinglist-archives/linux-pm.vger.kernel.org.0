Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD032AB2A
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2019 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfEZQ3e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 May 2019 12:29:34 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:44844 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfEZQ3e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 May 2019 12:29:34 -0400
Received: by mail-pg1-f175.google.com with SMTP id n2so7685238pgp.11
        for <linux-pm@vger.kernel.org>; Sun, 26 May 2019 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T6jGh4vtBMzLEIRqeEw5NmUw7G/n3dUFkmIaIlYlyhU=;
        b=pvDcUP0IFCmOOZ+fGMZEfRspF6k69A/kKLwbarjwdembNQ992KMoQHqFEGozjVysd4
         4wP4CoEAD1Nf3SxxQPK6ggYAOmSdvrSpDhF6rys1WtndgOi7nrIxwMxpaDeDXqB/NRRl
         WA8ajJEKneEikNVT53eV1HciLIAVdQXtGuXUwYADIszb9w7y7Kj6FaBWWUVTbEkWB87D
         utzrHMNjP02RUXQxWFyNzSFhjp1h0iwjG/SpJ4DH3X4eKXb+3BRODHuyXiofj0Wmej0o
         pZ8dmS9l6FM8FL8AlhuT3kvGBn+JtKHzuWuiUPBGQvXyCCTNd7OUvTpn6V33okEZ8SGC
         tlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T6jGh4vtBMzLEIRqeEw5NmUw7G/n3dUFkmIaIlYlyhU=;
        b=l/b2G1waOdaCpQgNuio+20wt20wXT/+Y/pyPiSI1WxoNB6XMem4zZh1T74sCeSUnXj
         DBpCyBkdo/1au2UJRO0pqDxMxa46BuKcd2uBEYWD9WwWORsK6u9NbHTnnd/q2ct37eAT
         xB8UkAzaKndFDi0QRo95GILLKhRozpxzacWX/aQKf5BXPBCgKVYdxX3b4XW7UQTiKr/V
         GwAiTxmG2J0+858y2UTu8KSWwclWVOJpcwZ2tj+LnJdwWmy1DRHZ7eKR+ny9IFZ2b0DB
         KoCmYPyJK3qYZlsrDQcESup5WtfNGWFY4/2Gb5peb3fE9nKavbctW4K3tdWxLJz5VfVt
         riSQ==
X-Gm-Message-State: APjAAAWkgzDpYwHdlGrtvV93QswLpgHKqSEeaDX4oRo0nvT0Lyd20t10
        xCXdTkt2HX8r8dmjuaYi38Y=
X-Google-Smtp-Source: APXvYqzo9ANzPz82Dcgqs1n9U9ZqotbRH45DeS9JJxyi0qCKNQ1T5VQONm6qAltrR44Aj1I6JCvv0Q==
X-Received: by 2002:a17:90a:c587:: with SMTP id l7mr24830185pjt.50.1558888173428;
        Sun, 26 May 2019 09:29:33 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:3427:8c7f:94e8:c445])
        by smtp.gmail.com with ESMTPSA id a11sm8671107pff.128.2019.05.26.09.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 09:29:32 -0700 (PDT)
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
Subject: [PATCH v3 0/3] nvme: add thermal zone devices
Date:   Mon, 27 May 2019 01:29:00 +0900
Message-Id: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
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

 drivers/nvme/host/core.c | 340 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  15 +++
 include/linux/nvme.h     |  12 ++
 3 files changed, 364 insertions(+), 3 deletions(-)

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

