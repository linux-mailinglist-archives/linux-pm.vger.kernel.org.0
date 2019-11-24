Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A510839E
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2019 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfKXOJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Nov 2019 09:09:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35639 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKXOJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2019 09:09:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id s8so5258046pji.2;
        Sun, 24 Nov 2019 06:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fytYybgFl7xuOSmQnvp6q1/Ea79YQjw0tWt4Bizw0mA=;
        b=GVHhFrNwoGoDRtY80N3KIXvLBkqiN+/S+ChGYbUMe8BwAr2Tr1j+hFE8Tmi9VxetkG
         Bmw3loe+8p46VnVE+5HUsdYV9BPGv0uFwcI2D5UZwibK9Lw46kOIoq9aZrC+Zzr+Cjcj
         gVEW/xdtdeM07YaDgT3aS2eQrXx1YRAwawXVfjdlohWo2t/F7ujcUBOxSVol0iJrFefT
         aXu9ud7QrK04QN4gvERRWXrv0Cu5w0JSp8oWnZhFs4wpLPpeXvOIzuEuI8w+IQk20mbu
         oG3J3H4daa5FOMXPnlZ6DO03N7Ozdcrpz/DAve7sEVECGUK+Hr/5GOMF9YzgZjUwOmE6
         3jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fytYybgFl7xuOSmQnvp6q1/Ea79YQjw0tWt4Bizw0mA=;
        b=XokUoAnCypP9L6GpWZ/I94//rWLMDbERyEtmqZ3nhiuKo5WASO2igBkTHTcFuvEMvL
         O3h/er/WijcOwsw1ayGBMn6/VQBdUcvqTbkpeJV8nmpp1472KEgcoIjfPCMjoKSeVf12
         r1w6AA2/T8GL97rizP8BYbec9B3nUmR8b9vYCRGlIBsKFaVctb1/ws/XorfgKYJxjOAR
         CBiZn0zLqBEUXUgoPb04rTgZkTn/WBycOGii0g/IY6AEdoL8TNLb5Sja2FWemJcpfCEY
         8cG8SCvDUBnbDQPj+Ehgth9hC3ctCpYVwKWhyAszkg0mDyADk5SZBVsdXuFdkhbhjKKp
         yNWQ==
X-Gm-Message-State: APjAAAVkG8uODLfETs28Hs9XugI8qsLhUIpHzoLcgjeREm8Nwi4b8Y38
        ADUkts/JmtFW2wU+fBUnFJxQ6agY3gY=
X-Google-Smtp-Source: APXvYqyBSLTq/CtXVdy1kZ+42OQ1yYPI2w3yb9lfouKDp/CevSx3IwrqhzpBj4/MpiNWC/bSBrJqaQ==
X-Received: by 2002:a17:90b:30d7:: with SMTP id hi23mr31851724pjb.10.1574604547338;
        Sun, 24 Nov 2019 06:09:07 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id a3sm4816326pgh.91.2019.11.24.06.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Nov 2019 06:09:05 -0800 (PST)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/8] add header file for kelvin to/from Celsius conversion helpers
Date:   Sun, 24 Nov 2019 23:08:42 +0900
Message-Id: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
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

 drivers/acpi/thermal.c                             | 17 ++++++----
 drivers/nvme/host/hwmon.c                          | 13 +++-----
 drivers/platform/x86/asus-wmi.c                    |  7 ++--
 drivers/platform/x86/intel_menlow.c                |  8 +++--
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  6 ++--
 drivers/thermal/intel/intel_pch_thermal.c          |  2 +-
 include/linux/temperature.h                        | 39 ++++++++++++++++++++++
 include/linux/thermal.h                            | 12 +------
 8 files changed, 68 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/temperature.h

Cc: Sujith Thomas <sujith.thomas@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
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

