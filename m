Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818CB132E23
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgAGSQS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 13:16:18 -0500
Received: from mout.gmx.net ([212.227.15.15]:53391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgAGSQS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 13:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578420964;
        bh=fStf+8RF6qmT38/5o2VMhgNCxx4YDKOqS+6ymSk2hVA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=d9HAQrSHcd8IpQHrnD7QnLWvY34o9aZGluK5xDCOfkXl/ctDqARxBO039GMtLY6p8
         4b1dgvRfu8liXH5Sd4umlA1YgbS7OujTTja38Esiy9gCnKDzIqRxUH50o6udP4Vpn+
         fdZXnzQFcmCibON1iNWwO0ggMgR3NxaYqumiaA1M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTAFh-1jHAwl1fqx-00UXyY; Tue, 07 Jan 2020 19:16:04 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 0/4] ARM: Enable thermal support for Raspberry Pi 4
Date:   Tue,  7 Jan 2020 19:15:53 +0100
Message-Id: <1578420957-32229-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:xkFz0dLUtTbMvdFsQps4ETe/MuVllBCYSLf/H/6OpwsfMs6tNd3
 X6PXvReYKhvwDSzLeprp9PesTWWsWfWB5Mkt87VssaeyetCzrSlQ8A4oX4Y6Ttkfz+VUObT
 rooWqxyoOcHxc2KFR6nigDhPGGfIgXaiM5Bj8aRB64sLA4ybf5r3nS/stlYgzy8O5GY6X1L
 UsOGhE69KexYdQRATkT9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WIesbUME1I0=:JFzG6lFhRvAeiyna9slav0
 mYylMG+lG39zpj0pqbGUrF0+eF9YfjFSr+H4N01Av1elAtoRK6AUStVwP7oW0C3wz+YIdkh8k
 TjVti9j3GBJ6+4PDN84kj+FU3F5N2z297iobibGRAtVMlFM/D8tulsoqpYMWO55fgZvxqms6a
 ahcYsWKqG2SzzMXjMUEmz5GjcnKSw3aikD8IAvS8pcSuRrtTHmg3iwfRd6pYBLzJihedkA0pe
 H/Q5a86O+3joTklgCO0A8BzALBWv/p6IqxWC/yQjF5gLUgvn49YnSQXgujREA2siVEtIVt6Xq
 TA6qMH/4KB9+CCRdvGHjZcXQhX94kc6p/pWH6ThPb6r6PqNpUe6ZhS9CpMqSwqu/6hCIXtBad
 EkAbwBAN5RimQlydCtvo+k7gT7Ob38p+sffQ9s6SxTnlTn4YNd9UbQxYo2yxS0mepGvZNZRjg
 3BbqRkj6ZkoqE5uXWZIyHfMUjEWdTdjwiavlW+SXSplrWjwuQG5BDrgPIsigFzGaXsXwdyTmX
 mldBdohc0x4HtyLZoA3HHW1tWNz4/noA/XB28FSpIh0fwjN98mx/u7iULeEMK9ICfOw2E817K
 OCBgPNRvAbgolZes3oW5TuzJL54zeCTqDG1KKMg07i9xg6dEoH0oEsfYdrwEz6cIAgEU+h/ak
 FQ5VgifCAtEMYRvTE1ykThGY/IbqzbthkNJMSx7gpfeOJijZ0vfGe+P5gmDuzCAY2fwzSughh
 c6klPCMDscqZod6FPanG0VkpnVT0CYDEOOBQ0y1wAgk5c8A7EptnQ8Cranysoz8MeF541FcnS
 m+wJbn7bAunCBP7/6u4R7DbQij0I2VWkns9EXmE1BkVWYurNvIDxCwYiOVlI1mNBUhox83k7T
 C63zidmO7y/GNSsQnrgfmgAt2S549/zWHyfUvaQJnRRS8WGs08KkN4mbRSKag9vplfCV0bLHl
 uXap25Tupjzppe23e9oyBmKXo6j8/pnvXSGKnzws+UC5ev3y/2ooqceJnIMzhB43GbUGkWkNA
 VyzAs6+Lyd8WeILoNip4Wa+tYHG2xS3ceTGw9yzYsMSGJJgMd0n2lc6v1FRECoD+z615aE624
 /RzGwNmXe9txKmx7Ynw7NLWM9WFd8+0Zt5XtJ4Tbdlku544Yt3yJRgaZqAMc0A+RfX950YbzS
 uz1Z2SFir2axcrKnlO9tYeq7vnU5HF//M+ck+JtvwH8yVgyt1vUXulh/vl4gwTGYxyigjvOBK
 7/Eyh/gKcnRbDez7QxE13FM/hi8MkSjT6TBddIA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series enables thermal support for the Raspberry Pi 4. Neither the
bcm2835_thermal nor the brcmstb_thermal are suitable for the BCM2711.
So add a new thermal driver to read out the SoC temperature from the
AVS RO block of the BCM2711.

Changes in V3:
- add Rob's, Florian's and Nicolas' reviewed-by/tested-by
- adjust binding license
- make error pointer handling consistent

Changes in V2:
- rebase on thermal/linux-next
- convert binding to YAML
- make AVS RO block a subnode of AVS monitor and access it via syscon
- drop unnecessary TSENS clock and get the rid of remove callback
- add Florian's reviewed-by to last/unchanged patch

Stefan Wahren (4):
  dt-bindings: Add Broadcom AVS RO thermal
  thermal: Add BCM2711 thermal driver
  ARM: dts: bcm2711: Enable thermal
  ARM: configs: Build BCM2711 thermal as module

 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  45 +++++++
 arch/arm/boot/dts/bcm2711.dtsi                     |  12 ++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/broadcom/Kconfig                   |   7 ++
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/bcm2711_thermal.c         | 129 ++++++++++++++++=
+++++
 7 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-=
thermal.yaml
 create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c

=2D-
2.7.4

