Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6292C39F9
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 08:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKYHTh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 02:19:37 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46745 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgKYHTh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 02:19:37 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2F4F020004;
        Wed, 25 Nov 2020 07:19:35 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 0/3]  Add reset support in ocelot driver for new platforms
Date:   Wed, 25 Nov 2020 08:19:17 +0100
Message-Id: <20201125071920.126978-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series extends reset support for 2 other MIPS based SoCs: Luton
and Jaguar 2.

Patches 1 and 2 should be merged through the reset subsystem, while
the device tree changes in patches 3 should go through the mips
subsystem.

In this second series I removed the microchip,reset-switch-core
property support waiting for finding a butter solution for it.

Changelog:

 v1 -> v2:
 - Add binding documentation for the 2 new SoC
 - Fix compatible string in name device tree node
 - Add Acked-by from Alexande

Gregory

Gregory CLEMENT (3):
  dt-bindings: reset: ocelot: Add Luton and Jaguar2 support
  power: reset: ocelot: Add support 2 other MIPS based SoCs
  MIPS: dts: mscc: add reset support for Luton and Jaguar2

 .../bindings/power/reset/ocelot-reset.txt     |  4 ++-
 arch/mips/boot/dts/mscc/jaguar2.dtsi          |  5 ++++
 arch/mips/boot/dts/mscc/luton.dtsi            |  5 ++++
 drivers/power/reset/ocelot-reset.c            | 30 +++++++++++++++++--
 4 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.29.2

