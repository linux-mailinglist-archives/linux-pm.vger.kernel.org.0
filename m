Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4587C1A6C16
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbgDMSjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbgDMSi7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 14:38:59 -0400
X-Greylist: delayed 11050 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Apr 2020 11:38:59 PDT
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519FBC0A3BDC;
        Mon, 13 Apr 2020 11:38:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DC6932A12B8
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4D2BF4800F7; Mon, 13 Apr 2020 20:38:55 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/4] Add support for constant power-supply property tables
Date:   Mon, 13 Apr 2020 20:38:49 +0200
Message-Id: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This marks the properties and usb_types entries in
struct power_supply_desc as const, so that drivers
can constify those tables.

-- Sebastian

Sebastian Reichel (4):
  power: supply: core: Constify usb_types
  power: supply: charger-manager: Prepare for const properties
  power: supply: generic-adc-battery: Prepare for const properties
  power: supply: core: Constify properties

 drivers/power/supply/charger-manager.c     | 40 ++++++++++++----------
 drivers/power/supply/generic-adc-battery.c | 22 ++++++------
 drivers/power/supply/power_supply_sysfs.c  |  2 +-
 include/linux/power_supply.h               |  4 +--
 4 files changed, 36 insertions(+), 32 deletions(-)

-- 
2.25.1

