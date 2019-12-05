Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A91143EC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfLEPof (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 10:44:35 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.93]:36867 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729899AbfLEPoe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 10:44:34 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 06C28C3F
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 09:44:32 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id ctItiQwzf4kpjctIui1TL8; Thu, 05 Dec 2019 09:44:32 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kono/osY8LIAISwNgMpURkYC4W/4gFk0QH7aAaQbSh4=; b=KFPZkvkv3OWyCyMPD6wcT7unhC
        6aEdRcRYif0kIHhl0yXyKrMY0hNpFsLqZU+CGUJ72XPDGmA/z0S68k4QpNmw3eFyojrDCpCm4KDg9
        RE3dD8aremRzo2tpfiHf/SQdqpw8UnxUTxoScV0BVsbOvOMQS+EZsyqjv81tRdnJa7jF0J4+GI51G
        WQHoL6FVUyhm1jhXfydD+1KYUiXeakCrC5eCWoAMYVnRD28432aYw2Ol0jOTWQTci4PEb2ENaRyCR
        fBxa7ucU20kx9IIWzJ1J2T21gWbVVlG/O8Rv/zXCxmm44uZZC8CO1cxdLdQQx5vqPj1AwSfuYSmX9
        cPiukfrA==;
Received: from [191.31.196.215] (port=35544 helo=castello.bz.toradex.local)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1ictIs-001jEH-US; Thu, 05 Dec 2019 12:44:31 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v8 0/5] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date:   Thu,  5 Dec 2019 12:44:05 -0300
Message-Id: <20191205154410.29462-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.215
X-Source-L: No
X-Exim-ID: 1ictIs-001jEH-US
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.bz.toradex.local) [191.31.196.215]:35544
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

Thanks Krzysztof Kozlowski, Lee Jones, Rob Herring and Sebastian Reichel for
your time reviewing it.

Changes since v7:
(Suggested by Sebastian Reichel)
- Fix unrelated change
- Use device_property_read_u32() and simplify the code
- Check the irq and of_device_is_compatible in the first patch

Changes since v6:
(Suggested by Lee Jones)
- Use relative paths in documentation

Matheus Castello (5):
  power: supply: max17040: Add IRQ handler for low SOC alert
  dt-bindings: power: supply: Max17040: Add DT bindings for max17040
    fuel gauge
  devicetree: mfd: max14577: Add reference to max14040_battery.txt
    descriptions
  power: supply: max17040: Config alert SOC low level threshold from FDT
  power: supply: max17040: Send uevent in SOC and status change

 .../devicetree/bindings/mfd/max14577.txt      |   2 +
 .../power/supply/max17040_battery.txt         |  33 +++++
 drivers/power/supply/max17040_battery.c       | 130 +++++++++++++++++-
 3 files changed, 161 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

--
2.24.0.rc2

