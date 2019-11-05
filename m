Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99311EF547
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 07:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfKEGCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 01:02:43 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.228]:25474 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfKEGCn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 01:02:43 -0500
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 01:02:42 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id B170AB398
        for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2019 23:42:24 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id RrbkijZn8PUvSRrbkiAZQJ; Mon, 04 Nov 2019 23:42:24 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XzVcb7tGAONUw/MGZuqDTvZTFYKEVcjqC7bTyT+W++E=; b=J6ALkRzpiRDm5X9ZdaST4cneod
        BrjezjeL/IrdYUoMKUVlYMNuP3yDUwfkH3lhXZd97t8danEYqui1HSN1GYwqIko52jLrgTO04i4bM
        +9y7CDKzppKukf24XpImCOswMRdNNbktbD4545x5v5sjfwLTtZi5hJtyil9TcvpqJRMFZtcTIi5gF
        eWCEpKoQSOK2yIjECxrDdmROxabYDX2Rh93c483uyH0dS899jDOkoTqzF1oDWBLYee7HpDGAhaeuC
        NCTwFdELZMbVXIVB+vAq2Gr8KokAQXwdHSee5nIB4Upey+dziCWUjua07gtNgV83YIvL9v6NuEWAD
        qUmpIZgQ==;
Received: from [191.31.196.28] (port=37450 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iRrbj-002sjK-SJ; Tue, 05 Nov 2019 02:42:24 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v5 0/5] power: supply: MAX17040: Add IRQ for low level and alert SOC changes
Date:   Tue,  5 Nov 2019 02:42:13 -0300
Message-Id: <20191105054218.29826-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191105015827.GA332@bogus>
References: <20191105015827.GA332@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.28
X-Source-L: No
X-Exim-ID: 1iRrbj-002sjK-SJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.196.28]:37450
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
 drivers/power/supply/max17040_battery.c       | 142 +++++++++++++++++-
 3 files changed, 172 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

--
2.24.0.rc2

