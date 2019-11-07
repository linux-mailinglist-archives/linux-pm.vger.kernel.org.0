Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89BAAF25E4
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 04:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfKGDRS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 22:17:18 -0500
Received: from gateway36.websitewelcome.com ([192.185.184.18]:49806 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727751AbfKGDRS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 22:17:18 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id C517140D99E54
        for <linux-pm@vger.kernel.org>; Wed,  6 Nov 2019 20:25:50 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id SYIOiQezwqNtvSYIOiGg8N; Wed, 06 Nov 2019 21:17:16 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8sv29UR8E5pLNoh42IdLCVMD0V6+Oaujyjo0kbs91yg=; b=qI0AalYcgbXWWtVOpw90rjH8TD
        0G8wU+FJ58A8UwnSGAQ2AAy4JPjk+lkzyVeHE1zRPoC+k39UJdmDWFobT/B5LQfL+rkpkSzotzxnP
        ZW/HtA8uyC6YQ7BUtxLx2TBuTh+vah3Rkxfh2mVFAWvTvD9e1iN/AiC61qzRa0nLTd74y3GIqlhIt
        rY7QOhfPfhvJLomvLYrsK5GLma/9/ucXBOSyf8f8wc3eHKuraPtLg5kbmCYtv9CdJ9qNxCdW5YbO4
        fk+W/OOq8EvP6f0VXvYoLQa6MhZBBjAvks/5lcQlOVp4fqvKRTraEn5uDStaa+6sNUhpGvKCKaeqP
        YzRksQQg==;
Received: from [191.31.194.59] (port=34854 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iSYIN-000Mrk-V1; Thu, 07 Nov 2019 00:17:16 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v6 0/5] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date:   Thu,  7 Nov 2019 00:17:05 -0300
Message-Id: <20191107031710.5672-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191105095905.GA31721@pi3>
References: <20191105095905.GA31721@pi3>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.194.59
X-Source-L: No
X-Exim-ID: 1iSYIN-000Mrk-V1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.194.59]:34854
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 18
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series add IRQ handler for low level SOC alert, define a devicetree
binding attribute to configure the alert level threshold and check for
changes in SOC and power supply status for send uevents.

Max17043/17044 have a pin for alert host about low level state of charge and
this alert can be configured in a threshold from 1% up to 32% of SOC.

Tested on Toradex Colibri iMX7D, with a SparkFun Lipo Fuel Gauge module
based on MAXIM MAX17043.

Thanks Krzysztof for your time reviewing it. Let me know what you think about
the fixes.

Changes since v5:
(Suggested by Krzysztof Kozlowski)
- Rearrange code and add max17040_enable_alert_irq on patch 1/5
- Remove useless dev_info

Changes since v4:
(Suggested by Krzysztof Kozlowski)
- Fix code style and alignment issues
- Keep IRQF_TRIGGER_FALLING | IRQF_ONESHOT instead client->flags

(Suggested by Rob Herring)
- Add reference to the MFD description
- Fix the dt-bindings commit description

Matheus Castello (5):
  power: supply: max17040: Add IRQ handler for low SOC alert
  dt-bindings: power: supply: Max17040: Add DT bindings for max17040
    fuel gauge
  devicetree: mfd: max14577: Add reference to max14040_battery.txt
    descriptions
  power: supply: max17040: Config alert SOC low level threshold from FDT
  power: supply: max17040: Send uevent in SOC and status change

 .../devicetree/bindings/mfd/max14577.txt      |   2 +
 .../power/supply/max17040_battery.txt         |  33 ++++
 drivers/power/supply/max17040_battery.c       | 141 +++++++++++++++++-
 3 files changed, 171 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

--
2.24.0.rc2

