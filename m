Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F881C473C
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgEDTrc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:47:32 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:10499 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgEDTrc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:32 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0K42qCz9Y;
        Mon,  4 May 2020 21:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621650; bh=25E4+7GJWRVGLEPBw92wrN02s487IK+3yN9N7dS+Zts=;
        h=Date:From:Subject:To:Cc:From;
        b=d4bFSvGenemYIbtwAVLvG1Uw29bejoY4D7PBYLz34HyUrmKW/NvbrG6pzgJn7vkn5
         RRjcUgEqVOHOi546OSCekC4mXTeQkLvyvzJGVjhrTpWITSmbmUPDuDB6zqciNQIG77
         dvoAAcw1NEJFECIoLm5e7JnujE97DLH6nOL1M54mJ4+HPXXgihm08+h9FKAzvFne4o
         xmmpuHTGXbmJDRlNIQI4bwRxjMvzjUm7Sh4aphUHyuUDLLMFG0geZMBYVN7qXpMd0B
         2+wNu2C+fiFObUUz+t89AlGsXCLWLSfaG/I0sLOgC/UYBywBMLRFm1aInr1j9HxEP8
         gioyX7v4xP0fQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:09 +0200
Message-Id: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 0/8] power: supply: bq25890: fix and extend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series consists of a set of fixes and enchancements to bq25890
driver. This is tested on a board using bq25896 as battery controller.

Patches 1-3 fix property value reading, 4-6 add more information to
be read from the chip, 7-8 add IBAT compensation support.

---
v2 removes VBUS and VSYS additions (they need more intrusive changes
   to properly fit into power supply class ABI) and adds binding
   description to IBAT compensation devicetree properties.

v3 drops cleanup patches already applied and reintroduces a patch
   to fix IBAT reading property ID (patch 1)

Michał Mirosław (8):
  power: bq25890: use proper CURRENT_NOW property for I_BAT
  power: bq25890: fix ADC mode configuration
  power: bq25890: update state on property read
  power: bq25890: implement CHARGE_TYPE property
  power: bq25890: implement PRECHARGE_CURRENT property
  power: bq25890: implement INPUT_CURRENT_LIMIT property
  power: bq25890: support IBAT compensation
  power: bq25890: document IBAT compensation DT properties

 .../bindings/power/supply/bq25890.txt         |  4 +
 drivers/power/supply/bq25890_charger.c        | 99 +++++++++++++++----
 2 files changed, 86 insertions(+), 17 deletions(-)

-- 
2.20.1

