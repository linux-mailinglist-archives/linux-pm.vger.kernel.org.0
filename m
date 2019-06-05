Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55B73579D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFEHXm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 03:23:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39341 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEHXm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 03:23:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so9363780plm.6;
        Wed, 05 Jun 2019 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QxJ+z/7JNLNHMMwUtAoUXwkceuj/SaTUZVOFbLgjLg=;
        b=eAC9jl1E6rw/JS1z02Gw0KZn0csw+7ORGdjR8tAmW67rgR3z/9MvUFJK/UR5A7/eC2
         cbgktlcpvvRHxJRSlhjYbEOddKXzti8F1nsFT08zE+SIt3K2QwXhVpAk6i5DVzwUp0YU
         Wn7aWPRY6/SSnnFsGeiqQuIgPdi++CkHKIdNzL7Zj11MJuaJ5zjoQvOmLzZA/WMrEWYJ
         YzgAeU2ruVS9h7/56eP++70f06uIbZnBxUmhQ3zljD9ajKJaaiPduoGBVBhY317a01Ux
         fYy7Ei07abpx8JQZ+Lg1/k+/K8PPXh6v0ipyzO5tN435G9Gd/PRukFSaONKlO2CeceGX
         fY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QxJ+z/7JNLNHMMwUtAoUXwkceuj/SaTUZVOFbLgjLg=;
        b=i9VvVfr81sXSjVEc4cUMbw6g4mXcbrDW9v7O2YaC6Uz9jV58Hji2AvVjYQ5vQNX9dj
         0JA/ODdtf9AsHv9oKenjxuoXLJM3drGFlGXDOgcCv8JhO0VGVioI//8X2orsmhRb1dDJ
         mWppOItX+88n9kanfqH+T1LNUmAjzYHblwXQvOJB0frZWRcLo1FnY/wai9JrZRKapY/+
         uteOl3ldZtNFrjnO7K3egE2yNjgpB2ZFnSk2ojsk5X7BvwF8wwnX+RHKnJcTU5elEQoY
         uTVshBqDoSr84cUoaAWm9W07h4O5vsh55DM/qK1fdRSpC4PuAl/Pacicu/B9C8rv5PFz
         J6YA==
X-Gm-Message-State: APjAAAXnRzEzYnwJWh3S44B9cwNvxyhXt0iq50aH+WPHPil1LXi/vYYf
        PBQGFZOFOqws4ZhfIWjn4Ex6bMmR54o=
X-Google-Smtp-Source: APXvYqzBrNu6EcZb6sZncPpDiicDtvBS15EhsceaLiPiDfa+9v77+ARdw78uAh/py8co8HIx0cOcMw==
X-Received: by 2002:a17:902:bb95:: with SMTP id m21mr42258650pls.154.1559719421564;
        Wed, 05 Jun 2019 00:23:41 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i4sm1027404pjd.31.2019.06.05.00.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:23:40 -0700 (PDT)
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
Subject: [PATCH v3 0/2] HWMON compatibility layer for power supplies
Date:   Wed,  5 Jun 2019 00:23:21 -0700
Message-Id: <20190605072323.21990-1-andrew.smirnov@gmail.com>
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

Changes since [v2]:

  - Added missing static specified to devm_power_supply_add_hwmon_sysfs()
  
  - Collected Reviewed-by from Guenter

Changes since [v1]:

  - All multiplications converted to use check_mul_overflow()

  - All divisions converted to use DIV_ROUND_CLOSEST()

  - Places that were ignoring errors now don't

  - Alphabetized include list

[v2] lkml.kernel.org/r/20190531011620.9383-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20190529071112.16849-1-andrew.smirnov@gmail.com

Thanks,
Andrey Smirnov

Andrey Smirnov (2):
  power: supply: Add HWMON compatibility layer
  power: supply: ucs1002: Add HWMON interface

 drivers/power/supply/Kconfig              |  14 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/power_supply_hwmon.c | 349 ++++++++++++++++++++++
 drivers/power/supply/ucs1002_power.c      |   6 +
 include/linux/power_supply.h              |   9 +
 5 files changed, 379 insertions(+)
 create mode 100644 drivers/power/supply/power_supply_hwmon.c

-- 
2.21.0

