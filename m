Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B60B2B4C93
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbgKPRWu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 12:22:50 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58514 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731001AbgKPRWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 12:22:50 -0500
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 474C63B3350
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 17:12:37 +0000 (UTC)
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3564E1BF227;
        Mon, 16 Nov 2020 17:12:14 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/5] Improve reset for ocelot and add support for new platfrom
Date:   Mon, 16 Nov 2020 18:11:54 +0100
Message-Id: <20201116171159.1735315-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series first adds new feature to the ocelot reset driver and then
it extends its support for 2 other MIPS based SoCs: Luton and Jaguar 2.

Patches 1, 2 and 4 should be merged through the reset subsystem, while
the device tree changes in patches 3 and 5 should go through the mips
subsystem.

Gregory

Gregory CLEMENT (3):
  MIPS: dts: mscc: add reset switch property
  power: reset: ocelot: Add support 2 othe MIPS based SoCs
  MIPS: dts: mscc: add reset support for Luton and Jaguar2

Lars Povlsen (2):
  dt-bindings: reset: ocelot: Add documentation for
    'microchip,reset-switch-core' property
  power: reset: ocelot: Add support for reset switch on load time

 .../bindings/power/reset/ocelot-reset.txt     |  6 ++
 arch/mips/boot/dts/mscc/jaguar2.dtsi          |  6 ++
 arch/mips/boot/dts/mscc/luton.dtsi            |  5 ++
 arch/mips/boot/dts/mscc/ocelot.dtsi           |  1 +
 drivers/power/reset/ocelot-reset.c            | 70 +++++++++++++++++--
 5 files changed, 83 insertions(+), 5 deletions(-)

-- 
2.29.2

