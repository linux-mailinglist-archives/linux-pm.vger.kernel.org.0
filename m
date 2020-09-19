Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C7270E4F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 16:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgISOE3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Sep 2020 10:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOE3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Sep 2020 10:04:29 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A6F21481;
        Sat, 19 Sep 2020 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524269;
        bh=lTUgSGbTRxSMnW+nqzLb39zreeAe56fmXb+310bskNM=;
        h=From:To:Subject:Date:From;
        b=XSiIgnBQ4hRba20jld08Gptyjvu7A5rZ6gneRXN37dzuEjLNkUXkQXxRqgVdF0mvA
         04SUcMjI/Wr2wNybvU0Anp2auPjwYUafo1NsHYkgdufm/7fC8ni2H+362OxpIhTWOg
         Yt/9gXGL5/w+7qt6wIkMchmGfM7x4PvMG76NGsLo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] power: supply: bq27xxx: add bq34z100
Date:   Sat, 19 Sep 2020 16:04:12 +0200
Message-Id: <20200919140418.3705-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Changes since v1:
1. Squash patch 3 and 4 - cleanups, as suggested.

Best regards,
Krzysztof

Krzysztof Kozlowski (6):
  dt-bindings: power: bq27xxx: add bq34z100
  power: supply: bq27xxx: report "not charging" on all types
  power: supply: bq27xxx: adjust whitespace and use BIT() for bitflags
  power: supply: bq27xxx: add separate flag for single SoC register
  power: supply: bq27xxx: add separate flag for capacity inaccurate
  power: supply: bq27xxx: add support for TI bq34z100

 .../bindings/power/supply/bq27xxx.yaml        |  1 +
 drivers/power/supply/bq27xxx_battery.c        | 83 +++++++++++++++----
 drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
 include/linux/power/bq27xxx_battery.h         |  1 +
 4 files changed, 72 insertions(+), 15 deletions(-)

-- 
2.17.1

