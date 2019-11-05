Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98571EF552
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 07:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfKEGDh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 01:03:37 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.182]:30052 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730566AbfKEGDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 01:03:36 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id B8520FB8E
        for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2019 23:42:33 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id RrbtipWRGW4frRrbtiIz4i; Mon, 04 Nov 2019 23:42:33 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0e1qX27Ap8ajDLmuZXwZOfgehLgO/33J03C0zj3Kqnk=; b=ShdaYUK+4tFBVA/UwyB2NUaYwa
        9K0Hr9Vt9i9qFwvqRrsYMSTeu2kpsP87ztp8xoEE6JWiRbKunU9FyjV8Y5W9AiNv40SnbOByMcZqM
        veoNKzz6qgq8q7bwGcnJRrhpof+H9PM77m/WmlY6HDCKmko1ZMsS/70R3mZDTCLtFoTpCtloMUq2R
        9dTWC69fw4JC5sAfhn+ezZbPuHk8P+GkQfIMCUYLQec4Q2Qc0cqrE633vjMVFJP/DxwQkZCAx24ve
        5ok+zLy7azXnqufh1k646xFH9iiPJ/orn7l8EStfeIkHwfjH6BCQCmrhzG5IS2aAzCq5dVn+O15HK
        g8javk7g==;
Received: from [191.31.196.28] (port=37450 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iRrbt-002sjK-0w; Tue, 05 Nov 2019 02:42:33 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v5 3/5] devicetree: mfd: max14577: Add reference to max14040_battery.txt descriptions
Date:   Tue,  5 Nov 2019 02:42:16 -0300
Message-Id: <20191105054218.29826-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191105054218.29826-1-matheus@castello.eng.br>
References: <20191105015827.GA332@bogus>
 <20191105054218.29826-1-matheus@castello.eng.br>
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
X-Exim-ID: 1iRrbt-002sjK-0w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.196.28]:37450
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 51
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

max77836 MFD has a fuel gauge that has a low SOC alert feature that is
described in Documentation/devicetree/bindings/power/supply/max17040_battery.txt.
Adding the reference to de documentation here.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 Documentation/devicetree/bindings/mfd/max14577.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
index fc6f0f4e8beb..04d790b1513c 100644
--- a/Documentation/devicetree/bindings/mfd/max14577.txt
+++ b/Documentation/devicetree/bindings/mfd/max14577.txt
@@ -5,6 +5,8 @@ Battery Charger and SFOUT LDO output for powering USB devices. It is
 interfaced to host controller using I2C.

 MAX77836 additionally contains PMIC (with two LDO regulators) and Fuel Gauge.
+For the description of Fuel Gauge low SOC alert interrupt see:
+Documentation/devicetree/bindings/power/supply/max17040_battery.txt


 Required properties:
--
2.24.0.rc2

