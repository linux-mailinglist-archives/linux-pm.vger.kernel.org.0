Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80191C1912
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgEAPLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:11:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:62052 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgEAPLU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 11:11:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DG1238SPz7N;
        Fri,  1 May 2020 17:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588345878; bh=cdEPjXnsn5z8U7feR9uktwJxgwGG0ztxZgZbcfEtYks=;
        h=Date:From:Subject:To:Cc:From;
        b=jL4fRjRpYzfcA9Nv12xAeNOFmBtEmxww0u+tL3y2bOYqE2ds7pjoFYO/XGFHTahFc
         opp/YGBwgz2PhAsEL1pxDapBHfJT4hSojWGf/OlkjFec3FX8h+FVlEAMa79XGExzQt
         leRLTj14QRP2cmay8emfx13+2unibV6wSNlT+kZdgModSuonJBii3PQPUGiemT1zFD
         aluCyky8t3e5KnAzuowtF7b8TlIKKsjgGiGF6D/ulby1Ja8okxTrlg6QwNcnPieB3d
         QEnuxJ25yykh1vHnVSHA4bsNEXnTiENF1dG35s67jY/xCOk13UkwsE83nDVJAlyGb8
         yGrFjMgDzrtHQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 01 May 2020 17:11:18 +0200
Message-Id: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 0/4] power: supply: core: extend with new properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series extend power supply class core with additional properties
for measurements of power supply input and output power.

v4 is a rebase on top of recently applied first part of v3, including
patch 1 workaround for gcc and clang bugs.

Michał Mirosław (4):
  power: supply: core: tabularize HWMON temperature labels
  power: supply: core: add input voltage/current measurements
  power: supply: core: add output voltage measurements
  power: supply: core: document measurement points

 Documentation/power/power_supply_class.rst |   6 +
 drivers/power/supply/power_supply_hwmon.c  | 142 ++++++++++++++++++++-
 drivers/power/supply/power_supply_sysfs.c  |   5 +
 include/linux/power_supply.h               |   5 +
 4 files changed, 152 insertions(+), 6 deletions(-)

-- 
2.20.1

