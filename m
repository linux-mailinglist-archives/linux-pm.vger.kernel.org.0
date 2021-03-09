Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF2332DD0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 19:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhCISEm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 13:04:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35232 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhCISEQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 13:04:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F346F1F457FB
Received: by jupiter.universe (Postfix, from userid 1000)
        id AB63F4800C3; Tue,  9 Mar 2021 19:04:12 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/7] Cleanup SBS power-supply drivers
Date:   Tue,  9 Mar 2021 19:04:00 +0100
Message-Id: <20210309180407.650943-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This is a collection of cleanups for the SBS battery/charger/manager.
The series does three things:

1. remove legacy gpio usage (only headers needed updates)
2. simple code cleanups
3. remove probe defer message logging

To provide some more data for the last point: The following messages
appeared on a SBS battery using system if the battery driver is probed
before the charger at default loglevel and will be degraded to debug
level:

[    0.348325] power_supply sbs-0-000b: Not all required supplies found, defer probe
[    0.348337] sbs-battery 0-000b: sbs_probe: Failed to register power supply
[    0.588072] power_supply sbs-0-000b: sbs-0-000b: Found supply : battery-charger

-- Sebastian

Sebastian Reichel (7):
  power: supply: sbs-battery: use dev_err_probe
  power: supply: sbs-charger: use dev_err_probe
  power: supply: sbs-charger: drop unused gpio includes
  power: supply: sbs-manager: use managed i2c_mux_adapter
  power: supply: sbs-manager: use dev_err_probe
  power: supply: sbs-manager: update gpio include
  power: supply: core: reduce loglevel for probe defer info

 drivers/power/supply/power_supply_core.c |  4 +-
 drivers/power/supply/sbs-battery.c       | 28 +++------
 drivers/power/supply/sbs-charger.c       | 24 +++-----
 drivers/power/supply/sbs-manager.c       | 78 +++++++++---------------
 4 files changed, 47 insertions(+), 87 deletions(-)

-- 
2.30.1

