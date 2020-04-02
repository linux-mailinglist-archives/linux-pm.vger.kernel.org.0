Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08319C506
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbgDBO5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:57:04 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:16195 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388239AbgDBO5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:57:04 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR3x59J3z9j;
        Thu,  2 Apr 2020 16:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839421; bh=Cnipj6qlDTsuXA/1q+W9CTZs5JFIJcQJ/Vo8HSDyOEw=;
        h=Date:From:Subject:To:Cc:From;
        b=TK+rZo3mOPWc0JHqcwy76l3X+diXRQUPW8Wk4+XYzSwq7uyO68k6hYs2PSCkHV+6L
         Bhg4f7wQzYaTXcQqrYDmroONiPrhzXQvA7u76iXJMQSZInTHqt3Ilpaz1mnrrKnLuK
         dYHzQNr1h8Zen48pWQ+xtYrfFCwAbxFWBoFc5Y6bIwjYZF1Us5VL6dXlwDyVmqusCZ
         SnE3VhlTI1MTRf99TI2J0Lq2tnWFtYMps+v0ZIZyFB4uJ8SCrmBds8l75ym63h1mWz
         ZP8uaFvfuBEy6YS7gejagG3sb0z3krI5jssR4Vn64xeI/NFa24bAtvxMJkt6MHkLiU
         jue152F0Lf0uQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:57:01 +0200
Message-Id: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/7] power: supply: core: extensions and fixes
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
3. make HWMON temp* labels match measurements
4. filter out unused HWMON labels
5-7. extend core to support input/battery/output supply point measurements

A patchset extending bq25890 driver to use the new infrastructure will
follow.

Michał Mirosław (7):
  power: supply: core: reduce power_supply_show_usb_type() parameters
  power: supply: core: allow to constify property lists
  power: supply: core: fix HWMON temperature labels
  power: supply: core: hide unused HWMON labels
  power: supply: core: add input voltage/current measurements
  power: supply: core: add output voltage measurements
  power: supply: core: document measurement points

 Documentation/power/power_supply_class.rst |   6 +
 drivers/power/supply/power_supply_hwmon.c  | 189 ++++++++++++++++++++-
 drivers/power/supply/power_supply_sysfs.c  |  15 +-
 include/linux/power_supply.h               |   9 +-
 4 files changed, 202 insertions(+), 17 deletions(-)

-- 
2.20.1

