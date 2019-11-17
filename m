Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB4FFA23
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2019 15:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfKQOOB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Nov 2019 09:14:01 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.250]:24376 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfKQOOA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Nov 2019 09:14:00 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id DDEDF49EC
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2019 08:13:59 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id WLJPiP0zmqNtvWLJPiCr2V; Sun, 17 Nov 2019 08:13:59 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pf1d0psg4OicB0p6AYwuL4Z2uixARtDFKC8KIILlS4I=; b=fi0H0IiTPcB6x+Ne4JDhttwPb+
        CbcTViSswk2Qof7oMLFgyKaBCl1rjoTaHcI6fxAg5r/VJXvej6uFl/AnmMszv3/kLUtBbBU1NoyN3
        8I3rRbXo8l2ybpItbAv7wZxbm963oevrXw1603HY1UhpZExWg+yrmnvx0QZ0YJ1ISPzF9OZ/K21mO
        EYtbW1Z4VHlAQmZPN5nu8OktSYudBFASfCEkiWfnTuy0KhXB+f/Nbbpfwq1cHnHNV3Qm8pwsNIWOm
        dF0B4s6Qpwm3TNay+1p6GQWLA0G2TBI3zVMUjc+dPnVAUrE9TnE5lwz2tl++4OD/c0CMvwAEaydd4
        20wddm1g==;
Received: from [186.222.229.111] (port=47408 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iWLJP-001Ad4-0o; Sun, 17 Nov 2019 11:13:59 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v7 0/5] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date:   Sun, 17 Nov 2019 11:13:30 -0300
Message-Id: <20191117141335.23404-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 186.222.229.111
X-Source-L: No
X-Exim-ID: 1iWLJP-001Ad4-0o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [186.222.229.111]:47408
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 3
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

Thanks Krzysztof Kozlowski, Lee Jones and Rob Herring for your time reviewing
it.

Changes since v6:
(Suggested by Lee Jones)
- Use relative paths in documentation

Changes since v5:
(Suggested by Krzysztof Kozlowski)
- Rearrange code and add max17040_enable_alert_irq on patch 1/5
- Remove useless dev_info

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

