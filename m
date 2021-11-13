Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7FD44F27F
	for <lists+linux-pm@lfdr.de>; Sat, 13 Nov 2021 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhKMKpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 05:45:30 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:48557 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhKMKp3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Nov 2021 05:45:29 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636800156;
        bh=ESS4PJFNqBSyT0t32NT6SXPSUNZ2SzCvuI/arOjvzXc=;
        h=From:To:Cc:Subject:Date:From;
        b=I1vjxJi74M8nmx4Wjef1FJc7YpPhIWg9fUU8jsEXX8eNThPpQGcTIradsuTAlSo43
         XFCqVji9xUHQ8HR2QTGRv3LwYRDc+Rk7ErtnVZO9IJY2kwtkrL/g9efY7xi0l+Fu2v
         5qvX1Hf6zPSKdSbQSyipu82DsrU9hf6HMb3Cy7FU=
To:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
Subject: [PATCH 0/4] power: supply: add charge_behaviour property (force-discharge, inhibit-charge)
Date:   Sat, 13 Nov 2021 11:42:21 +0100
Message-Id: <20211113104225.141333-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

this series adds support for the charge_behaviour property to the power
subsystem and thinkpad_acpi driver.

As thinkpad_acpi has to use the 'struct power_supply' created by the generic
ACPI driver it has to rely on custom sysfs attributes instead of proper
power_supply properties to implement this property.

Patch 1: Adds the power_supply documentation and basic public API
Patch 2: Adds helpers to power_supply core to help drivers implement the
  charge_behaviour attribute
Patch 3: Adds support for force-discharge to thinkpad_acpi.
Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.

Patch 3 and 4 are largely taken from other patches and adapted to the new API.
(Links are in the patch trailer)

Ognjen Galic, Nicolo' Piazzalunga, Thomas Koch:

Your S-o-b is on the original inhibit_charge and force_discharge patches.
I would like to add you as Co-developed-by but to do that it will also require
your S-o-b. Could you give your sign-offs for the new patches, so you can be
properly attributed?

Sebastian Reichel:

Currently the series does not actually support the property as a proper
powersupply property handled fully by power_supply_sysfs.c because there would
be no user for this property.

Previous discussions about the API:

https://lore.kernel.org/platform-driver-x86/20211108192852.357473-1-linux@weissschuh.net/
https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fec29983d1@gmail.com/

Thomas Weißschuh (4):
  power: supply: add charge_behaviour attributes
  power: supply: add helpers for charge_behaviour sysfs
  platform/x86: thinkpad_acpi: support force-discharge
  platform/x86: thinkpad_acpi: support inhibit-charge

 Documentation/ABI/testing/sysfs-class-power |  14 ++
 drivers/platform/x86/thinkpad_acpi.c        | 154 +++++++++++++++++++-
 drivers/power/supply/power_supply_sysfs.c   |  51 +++++++
 include/linux/power_supply.h                |  16 ++
 4 files changed, 231 insertions(+), 4 deletions(-)


base-commit: 66f4beaa6c1d28161f534471484b2daa2de1dce0
-- 
2.33.1

