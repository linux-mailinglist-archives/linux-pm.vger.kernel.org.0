Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA07F1C2D46
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgECPVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 11:21:13 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:13571 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgECPVM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:12 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7T5jmtzBc;
        Sun,  3 May 2020 17:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519270; bh=UjY8PzZ2ebkIWEK1WXKg4E1K2ulg0fn/7pKxOYcFaq8=;
        h=Date:From:Subject:To:Cc:From;
        b=lnIMfb03/Wy1nUudkFAxx0UXiVrRejRZY1depI/z9gcIwMCXPkFr7AX1FhTbV1qlw
         BJE/FgcpU0fc44DlsO+eWGL/pQDZ/q802TTd9V6eMq1e59mlPRHyM8LkyeJ+eaERA4
         HBjRZKhbuhCfOsBtyJasb9/3rc0HkA/iF4whzxAcW7U6esgPx2dRMlf0i8rQ9VA7X8
         c0wq0k2N7g/b442BkjtzzlZzSaPspWjOQw0rbEKpzBY8jXl68Gu00Y8LT7Bb19X9zi
         awzR0+jmkApiNJlAo3zXIcXiNQ2cf/p10+EU9YUBf0sc8VoE0VwDyLt9aU3UKiS8vE
         lWs0ITADTQAMw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:07 +0200
Message-Id: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 00/11] power: supply: bq25890: fix and extend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series consists of a set of fixes and enchancements to bq25890
driver. This is tested on a board using bq25896 as battery controller.

Patches 1-3 are cleans up the code a bit, 4-6 fix property value
reading, 7-9 add more information to be read from the chip, 10-11 add
IBAT compensation support.

v2 removes VBUS and VSYS additions (they need more intrusive changes
to properly fit into power supply class ABI) and adds binding
description to IBAT compensation devicetree properties.

Michał Mirosław (11):
  power: bq25890: remove redundant I2C bus check
  power: bq25890: simplify chip name property getter
  power: bq25890: make property table const
  power: bq25890: protect view of the chip's state
  power: bq25890: fix ADC mode configuration
  power: bq25890: update state on property read
  power: bq25890: implement CHARGE_TYPE property
  power: bq25890: implement PRECHARGE_CURRENT property
  power: bq25890: implement INPUT_CURRENT_LIMIT property
  power: bq25890: support IBAT compensation
  power: bq25890: document IBAT compensation DT properties

 .../bindings/power/supply/bq25890.txt         |   4 +
 drivers/power/supply/bq25890_charger.c        | 190 ++++++++++--------
 2 files changed, 113 insertions(+), 81 deletions(-)

-- 
2.20.1

