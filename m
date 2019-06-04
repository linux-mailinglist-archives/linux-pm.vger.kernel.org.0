Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71D34EF1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFDRdo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 13:33:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfFDRdo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 13:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3163AE05;
        Tue,  4 Jun 2019 17:33:42 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        mturquette@baylibre.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] cpufreq support for the Raspberry Pi
Date:   Tue,  4 Jun 2019 19:32:18 +0200
Message-Id: <20190604173223.4229-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,
this series aims at adding cpufreq support to the Raspberry Pi family of
boards.

The previous revision can be found at: https://lkml.org/lkml/2019/5/20/431

The series first factors out 'pllb' from clk-bcm2385 and creates a new
clk driver that operates it over RPi's firmware interface[1]. We are
forced to do so as the firmware 'owns' the pll and we're not allowed to
change through the register interface directly as we might race with the
over-temperature and under-voltage protections provided by the firmware.

Next it creates a minimal cpufreq driver that populates the CPU's opp
table, and registers cpufreq-dt. Which is needed as the firmware
controls the max and min frequencies available.

This was tested on a RPi3b+ and RPI2b which are the boards I have access
to. Until this is tested broadly the cpufreq driver takes care of
filtering out the rest of boards.

That's all,
kind regards,
Nicolas

[1] https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface

---

Changes since RFC:
  - Addressed Viresh's comments in cpufreq driver
  - Addressed Stefan's comments in both cpufreq & clk drivers
  - Moved all firmware clk operations into it's own driver

Nicolas Saenz Julienne (4):
  clk: bcm2835: remove pllb
  clk: bcm283x: add driver interfacing with Raspberry Pi's firmware
  clk: bcm2835: register Raspberry Pi's firmware clk device
  cpufreq: add driver for Raspbery Pi

 drivers/clk/bcm/Makefile              |   1 +
 drivers/clk/bcm/clk-bcm2835.c         |  40 ++--
 drivers/clk/bcm/clk-raspberrypi.c     | 316 ++++++++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm           |   8 +
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/raspberrypi-cpufreq.c |  84 +++++++
 6 files changed, 423 insertions(+), 27 deletions(-)
 create mode 100644 drivers/clk/bcm/clk-raspberrypi.c
 create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c

-- 
2.21.0

