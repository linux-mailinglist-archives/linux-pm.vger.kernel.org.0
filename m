Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CF41F7F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfFLIoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 04:44:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36168 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFLIoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 04:44:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so6349160plr.3;
        Wed, 12 Jun 2019 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a71+4/xkYWo6AZpIBbpcYXBdHpYz0ec0WPHCFWRwGUc=;
        b=P1p3QyL46oA1H0GNZkkdNrpCh2+8uaFsWYrqOK1uEQ3vt+HjBoNDctMEhhMIvoCrsB
         J/PHypMSM8mghICRpC4mDZXTzvSpHu/SvqgVHGafhuntSi7gT1hj8uSm/In8DeZv9boC
         L4+OfeFJJ4YDNsn6lipJWifDiMkOs2iHFLPB+NsLH2zEqOmlbazgDIhKQeYAY9cJK60b
         Q32HfKMDt/5iZ4+d1mD4kWv0CeZG2ixMfS9PrdQs0o2xl2AXsQVHoawc6CBUX1sO1mFG
         TLWspqUTsd9kXgMy5pV2GetKWmmORZPpafbdsREH3cW4t11RLKdb52klEOm/DZhNP+k9
         vqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a71+4/xkYWo6AZpIBbpcYXBdHpYz0ec0WPHCFWRwGUc=;
        b=XaWRschaYtWpRsj3B0zECa99+mtCqZY99VcVrjyaKIpTwd3lt4PWT+9tNV+B9zDjcF
         ZIMmmxaMeh7lDR+lavJR/ceDuHLDtJZwiGv/p+Vudv42ioL3quGYGBo8tiev4suEz+vj
         JGoHaKmofuZ1udoaHfshfNLJxpXZLf27749pTPtWdO9/VBv3eVs5WOsdjYCufEzeaEcP
         UgEvjPgwsbB2CMaHukTgTfmd3/iidjEJ6VLDT1qWC+l25p2ARe3Ggm27Ylh2h1rMoHza
         /IbjKKNTZYLZJdF8++tr5GcnwmTCokqwnwC1nCB0ZMTh441nw5lzNjK+doPtFFCMPZQs
         Uo1A==
X-Gm-Message-State: APjAAAUoDYHLmMgNH/fE524Lxr2QPyx1JiIjGSHy3OiYoMV45lP8LPzk
        kzClx6mRA7mWGsX3N3g8qD2G/osqKUY=
X-Google-Smtp-Source: APXvYqyVB7egX4lmy8jSpM1deUJHXQ6lxQoGoMl5/BfQ4JV8ULZmZ7A6OFbuPOTfFr7OGnekby3mag==
X-Received: by 2002:a17:902:7c04:: with SMTP id x4mr21552131pll.70.1560329057984;
        Wed, 12 Jun 2019 01:44:17 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v9sm16372124pfm.34.2019.06.12.01.44.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:44:17 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] HWMON compatibility layer for power supplies
Date:   Wed, 12 Jun 2019 01:44:03 -0700
Message-Id: <20190612084404.21685-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Everyone:

This small series contains the code I wrote to expose various power
supply sensors via HWMON layer in order to be able to access all of
the sensors in the system with libsensors.

Changes since [v3]:

  - Patch converted to have HWMON be registered in
    power_supply_register() and free'd in power_supply_unregister().

  - Collected Tested-by from Chris

Changes since [v2]:

  - Added missing static specified to devm_power_supply_add_hwmon_sysfs()
  
  - Collected Reviewed-by from Guenter

Changes since [v1]:

  - All multiplications converted to use check_mul_overflow()

  - All divisions converted to use DIV_ROUND_CLOSEST()

  - Places that were ignoring errors now don't

  - Alphabetized include list

[v3] lkml.kernel.org/r/20190605072323.21990-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20190531011620.9383-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20190529071112.16849-1-andrew.smirnov@gmail.com

Thanks,
Andrey Smirnov

Andrey Smirnov (1):
  power: supply: Add HWMON compatibility layer

 drivers/power/supply/Kconfig              |  14 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/power_supply_core.c  |   7 +
 drivers/power/supply/power_supply_hwmon.c | 355 ++++++++++++++++++++++
 include/linux/power_supply.h              |  13 +
 5 files changed, 390 insertions(+)
 create mode 100644 drivers/power/supply/power_supply_hwmon.c

-- 
2.21.0

