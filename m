Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870AC1F02FF
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 00:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgFEWoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 18:44:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41676 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgFEWoJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 18:44:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 49BB02A51AC
Received: by jupiter.universe (Postfix, from userid 1000)
        id 249E1480101; Sat,  6 Jun 2020 00:44:04 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 0/6] misc. gpio-charger patches
Date:   Sat,  6 Jun 2020 00:43:57 +0200
Message-Id: <20200605224403.181015-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This is v2 of a patchset for gpio-charger. The patches are
mostly unrelated to each other, but have some dependencies.

Merge plan is:

Assuming there are no huge blockers, the plan is to merge
patches 1-3 through power-supply subsystem for 5.9. The
ARM patches can go via ARM subsystem for 5.9 and the final
patch can simply be postponed for 5.10.

Changelog since PATCHv1:
 * Fixed the YAML binding as suggested by Rob
 * Implemented the suggestions from Emil
 * Split making "gpios" optional into separate patch, which
   simplifies reviewing and follows "one change per patch"
   style
 * Add two new patches converting platform data users to
   use GPIO descriptor tables
 * Add final patch removing gpio from platform data

-- Sebastian

Sebastian Reichel (6):
  dt-bindings: power: supply: gpio-charger: convert to yaml
  power: supply: gpio-charger: Make gpios optional
  power: supply: gpio-charger: add charge-current-limit feature
  ARM: pxa: Use GPIO descriptor for gpio-charger
  ARM: sa1100: Use GPIO descriptor for gpio-charger
  power: supply: gpio-charger: drop legacy GPIO support

 .../bindings/power/supply/gpio-charger.txt    |  31 ---
 .../bindings/power/supply/gpio-charger.yaml   |  94 ++++++++
 arch/arm/mach-pxa/tosa.c                      |  24 +--
 arch/arm/mach-sa1100/collie.c                 |  11 +-
 drivers/power/supply/gpio-charger.c           | 200 ++++++++++++++----
 include/linux/power/gpio-charger.h            |   5 -
 6 files changed, 275 insertions(+), 90 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.yaml

-- 
2.26.2

