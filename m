Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A394519DF35
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgDCUVM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:21:12 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:62955 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgDCUUd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBk1bhRz89;
        Fri,  3 Apr 2020 22:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945230; bh=9o0jU3pHTAuBzNswBF/b03ymf3m7K1HzGbtH3v7tck4=;
        h=Date:From:Subject:To:Cc:From;
        b=UNBLvvWYhaRBtVcXfkR4qe6OGXoBnZTDR2gPRLdjNwVo/uvvF/MrmL2evMNQqpzGM
         XUTPxNsLKFK6lhbjVSzECWj/pwBAPoG3+yw1+lm0nWDgnY9fDkJjnTGhRawVCF6AVP
         7gBbbTcPqAqG/fVUhLYuy4V2T0w6wtOoNTJZ8SIHeLc7Z6jg6ih5J6NaZBAeg9Iohh
         OQj5Xt6ij3OqxLMu9leY1CVHl/n84G+u3VSjbUCDNqpkQpoguX4f+fTgfU2a+WfDjU
         3G8eycQ6pdK00fis7QLmLpOfd55gAS51P7qIls01rUqMwFpfNeKxqADBKsZfzhnqVK
         QyJUmrptgNU7w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:26 +0200
Message-Id: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 00/11] extensions and fixes
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

1-5. constify property and usb_type lists as they should not be changed
     after driver registration
6-8. fix and clean up HWMON labels
9-11. extend core to support input/battery/output supply point
     measurements

I guess the first part is largely independent, so I can extract it to
a separate series if that's useful.

---
v2: splits power_supply_hwmon_read_string() fix from extensioa
    (patches 3-4)
v3: removes power_supply_hwmon_read_string() parameter checks and
    adds a prerequisite patches to two drivers to make them compile
    after property list constification patch is applied
---

Michał Mirosław (11):
  power: charger-manager: remove duplicate assignment
  power: charger-manager: don't write through desc->properties
  power: generic-adc-battery: fold psy_props[] to private data
  power: supply: core: reduce power_supply_show_usb_type() parameters
  power: supply: core: allow to constify property lists
  power: supply: core: fix HWMON temperature labels
  power: supply: core: tabularize HWMON temperature labels
  power: supply: core: hide unused HWMON labels
  power: supply: core: add input voltage/current measurements
  power: supply: core: add output voltage measurements
  power: supply: core: document measurement points

 Documentation/power/power_supply_class.rst |   6 +
 drivers/power/supply/charger-manager.c     |  17 +-
 drivers/power/supply/generic-adc-battery.c |  30 ++--
 drivers/power/supply/power_supply_hwmon.c  | 178 +++++++++++++++++++--
 drivers/power/supply/power_supply_sysfs.c  |  15 +-
 include/linux/power_supply.h               |   9 +-
 6 files changed, 211 insertions(+), 44 deletions(-)

-- 
2.20.1
