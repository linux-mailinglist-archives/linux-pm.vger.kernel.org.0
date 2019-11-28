Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6410CAB7
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfK1Oy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:54:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35161 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1Oy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:54:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id q13so13273944pff.2;
        Thu, 28 Nov 2019 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P/DvvVqY88h8qjrElwC+TntQygBRJpTMf+ORNvfk45c=;
        b=aLMIKFsQBEJTDmAuiv03bBxl3ZQHr8Ul++QJpS0rglPgjm3TOucl7IiAJ9VoZSgc0L
         cFNNax3aV+x03ClsZiRfPlMwN1Rgy6XaQfl8avt9y+uwfmv5k7Yobo0nc/YdyJMU6CNv
         yMWMWCplcAOMELOOEVc6U0TJRzw8ZnWuFQ2qbe7CSZXgD0w+gL2WpEiiiXoBDLKiOZeg
         q/xShB+c2VVujjtJr8M59ZnJclyk+Hm19fowaq8vIJhzFqRcxFxr1L0ecAefvJK3TpC0
         IBSsEkaoinBZNCYsKyuLVWzAtSAx9pphtl+2nEO8CcCLzqLaYyRhT4Sfq488m1RLXQGe
         Qxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P/DvvVqY88h8qjrElwC+TntQygBRJpTMf+ORNvfk45c=;
        b=TWzMtZPfkOS73yWUDvyoh0wslTcpl5xVNYN0dr5jK0T30DZ1rDAJIDvN4uM28fPlA9
         NIaXQXxTmJ/IgASZSTV+T76vFERWVLQmxqJkbyXJuxjTb2ydTuUrn+J/Tnu1e6whOhro
         Ym4jFqf4hozytMpky8lcpfWop3fgLNGphbAk/nUph6r1SNtHiccAkE1oTEggL3DhlQmZ
         zfpk/6aGYpvso6oiSy0iJAm1fH6IBxk1538NqOKRIEsdsiINkfORRBVUWUk9lUkAkdFn
         tPpwU1vDKYGJuBXIZWGLVjl3VOafLSDGbYVvXULIQ0zOPNtE30vaiL04lsUrtaOyBiLP
         wzWw==
X-Gm-Message-State: APjAAAUyPey5NuNOau9SKxmsdmY5MtKzT6yS0DFrIU+etU/fDNDQf3xs
        M0g4dJR2I3sKkSQdeSE9+y4=
X-Google-Smtp-Source: APXvYqwuNtOJ51bQrQY+Kw3mlYu1GrcIS6mWU2lAq/0U7uWjbvcok0PMGch3BZ5vsUAJyWT226vUgw==
X-Received: by 2002:a63:1953:: with SMTP id 19mr5926293pgz.157.1574952896376;
        Thu, 28 Nov 2019 06:54:56 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8015:e854:5ef0:f52e])
        by smtp.gmail.com with ESMTPSA id z11sm22282563pfg.117.2019.11.28.06.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:54:54 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 0/8] add header file for kelvin to/from Celsius conversion helpers
Date:   Thu, 28 Nov 2019 23:54:31 +0900
Message-Id: <1574952879-7200-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are several helper macros to convert kelvin to/from Celsius in
<linux/thermal.h> for thermal drivers.  These are useful for any other
drivers or subsystems, but it's odd to include <linux/thermal.h> just for
the helpers.

This adds a new <linux/temperature.h> that provides the equivalent inline
functions for any drivers or subsystems, and switches all the users of
conversion helpers in <linux/thermal.h> to use <linux/temperature.h>
helpers.

* v2
- add deci_kelvin_to_millicelsius_with_offset() in linux/temperature.h
- stop including linux/temperature.h from linux/thermal.h
- include <linux/temperature.h> explicitly from thermal drivers
- fix s/temprature/temperature/ typo in commit log
- use deci_kelvin_to_millicelsius_with_offset() in ACPI thermal zone driver
- don't mix up another fix (format string for cellsius value)
- add Acked-by and Reviewed-by tags

Akinobu Mita (8):
  add header file for kelvin to/from Celsius conversion helpers
  ACPI: thermal: switch to use <linux/temperature.h> helpers
  platform/x86: asus-wmi: switch to use <linux/temperature.h> helpers
  platform/x86: intel_menlow: switch to use <linux/temperature.h>
    helpers
  thermal: int340x: switch to use <linux/temperature.h> helpers
  thermal: intel_pch: switch to use <linux/temperature.h> helpers
  nvme: hwmon: switch to use <linux/temperature.h> helpers
  thermal: remove kelvin to/from Celsius conversion helpers from
    <linux/thermal.h>

 drivers/acpi/thermal.c                             | 36 ++++++++-------
 drivers/nvme/host/hwmon.c                          | 13 +++---
 drivers/platform/x86/asus-wmi.c                    |  7 ++-
 drivers/platform/x86/intel_menlow.c                |  9 ++--
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  7 +--
 drivers/thermal/intel/intel_pch_thermal.c          |  3 +-
 include/linux/temperature.h                        | 51 ++++++++++++++++++++++
 include/linux/thermal.h                            | 11 -----
 8 files changed, 91 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/temperature.h

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
-- 
2.7.4

