Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4219DB75
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404018AbgDCQXb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:23:31 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:56843 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgDCQXb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 12:23:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v4xF4cj3z89;
        Fri,  3 Apr 2020 18:23:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585931009; bh=0CzaEgqfN263drxxDU5ar5X4YqApOdcM1FZ/ZfZc11c=;
        h=Date:From:Subject:To:Cc:From;
        b=ConTcMwycOVedQJkGyrX7J1npsFs24MHi/SGmCHT5MLCbIF1C9GoqdPwPVBeAQfIy
         8zz+xnI41EAi9m3mzgWGU0o919zo7WjItC7G8V1jFN/2UsrURwxTr8cTTdycmv/bZO
         0gViE6ld8TIQFipnU2Zmpe11c/5xDk5oGAbdwflbThZKbBh7lAQTpcf4gsZSgJkfWx
         cLEH6Hujii5qEHnjpJJg0lc66hk5dtQNR8GUgdYm0qtveZV2IG3mf6OiGF8uYvYNKs
         UzJ/2NulYQ8eO6R5ejyA+txe7E4w3MBEkajEuw+lwuW7bS//ScPwmCVwCsKT3VDBxR
         Yls3f4ONOqUng==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 18:23:29 +0200
Message-Id: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/8] power: supply: core: extensions and fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series covers three areas of power supply class:

1-2. constify property and usb_type lists as they should not be changed
     after driver registration
3-5. fix and clean up HWMON labels
6-8. extend core to support input/battery/output supply point
     measurements

---
v2: splits power_supply_hwmon_read_string() fix from extensioa
    (patches 3-4)

Michał Mirosław (8):
  power: supply: core: reduce power_supply_show_usb_type() parameters
  power: supply: core: allow to constify property lists
  power: supply: core: fix HWMON temperature labels
  power: supply: core: tabularize HWMON temperature labels
  power: supply: core: hide unused HWMON labels
  power: supply: core: add input voltage/current measurements
  power: supply: core: add output voltage measurements
  power: supply: core: document measurement points

 Documentation/power/power_supply_class.rst |   6 +
 drivers/power/supply/power_supply_hwmon.c  | 198 +++++++++++++++++++--
 drivers/power/supply/power_supply_sysfs.c  |  15 +-
 include/linux/power_supply.h               |   9 +-
 4 files changed, 210 insertions(+), 18 deletions(-)

-- 
2.20.1

