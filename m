Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3985721AAE
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfEQPfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 11:35:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728778AbfEQPfQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 May 2019 11:35:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABC58ACEF;
        Fri, 17 May 2019 15:35:13 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [RFC 0/5] cpufreq support for the Raspberry Pi
Date:   Fri, 17 May 2019 17:35:02 +0200
Message-Id: <20190517153508.18314-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,
as some of you may recall I've been spending some time looking into
providing 'cpufreq' support for the Raspberry Pi platform[1]. I think
I'm close to something workable, so I'd love for you to comment on it.

There has been some design changes since the last version. Namely the
fact that I now make sure *only* the CPU frequency is updated. The
firmware API we use has two modes, with or without turbo. Enabling turbo
implies not only scaling the CPU clock but also the VPU and other
peripheral related clocks.  This is problematic as some of them are not
prepared for this kind frequency changes. I spent some time adapting the
peripheral drivers, but the result was disappointing as they poorly
support live frequency changes (which most other chips accept, think for
instance I2C and clock stretching) but also turned out hard to integrate
into the kernel. As we were planning to use 'clk_notifiers' which turns
out not to be such a good idea as it's prone to deadlocks and not
recommended by the clock maintainers[2]. It's also worth mentioning that
the foundation kernel doesn't support VPU frequency scaling either.

With this in mind, and as suggested by clock maintainers[2], I've
decided to integrate the firmware clock interface into the bcm2835 clock
driver. This, in my opinion, provides the least friction with the
firmware and lets us write very simple and portable higher level
drivers. As I did with the 'cpufreq' driver which simply queries the max
and min frequencies available, which are configurable in the firmware,
to then trigger the generic 'cpufreq-dt'.

In the future we could further integrate other firmware dependent clocks
into the main driver. For instance to be able to scale the VPU clock,
which should be operated through a 'devfreq' driver.

This was tested on a RPi3b+ and if the series is well received I'll test
it further on all platforms I own.

That's all,
kind regards,
Nicolas

[1] https://lists.infradead.org/pipermail/linux-rpi-kernel/2019-April/008634.html
[2] https://www.spinics.net/lists/linux-clk/msg36937.html

---

Nicolas Saenz Julienne (5):
  clk: bcm2835: set CLK_GET_RATE_NOCACHE on CPU clocks
  clk: bcm2835: set pllb_arm divisor as readonly
  clk: bcm2835: use firmware interface to update pllb
  dts: bcm2837: add per-cpu clock devices
  cpufreq: add driver for Raspbery Pi

 arch/arm/boot/dts/bcm2837.dtsi        |   8 +
 drivers/clk/bcm/clk-bcm2835.c         | 284 ++++++++++++++++++++++++--
 drivers/cpufreq/Kconfig.arm           |   8 +
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/raspberrypi-cpufreq.c |  79 +++++++
 5 files changed, 362 insertions(+), 18 deletions(-)
 create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c

-- 
2.21.0

