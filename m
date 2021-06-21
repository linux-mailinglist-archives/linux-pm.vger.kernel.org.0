Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698E53AE680
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhFUJzN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUJzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:55:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02365C061574
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:52:59 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:52:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624269177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/tI/la7AGQMvOnD2pR9k1PAs6DrWZeu/zAIY0usu4o=;
        b=N3OYsvPcTf8QchaOLduK6MMdUdzzgcm6tJdm33uNtZl8aCkXDmKRCR65kBnJqt371RqqaE
        7X9gGSw4reN8xsRZPW5F5NPqdKD/gCn54lt2IfuPwcBItS8IMCf0lSG39VNztFH6nbAjw0
        /mc1iGf+HM3noIJf4mFu3meJalm7PiVn86kp6ff4vTrgpQn3t/sZUy8fkkFEZf8/5KRKMW
        tTOum9ggdnAL3bE+eEUIoql7C3zuMlyAPZNXzc8OEPP5lkLtzX8nYDijojXqd0YH6Fh31H
        d4QF60MiQThwpAcsWcJPmr1goHn95lzIAENrGR+1XjJoKct4usdx3CH8oKljUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624269177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/tI/la7AGQMvOnD2pR9k1PAs6DrWZeu/zAIY0usu4o=;
        b=YSCpZDyloJr7OPMEyq1DBxJzSrvcLVGSuUzMTEwNwRUON6+R+5BN8HdvEVvKTlQ24XoDbS
        3v+3oHl7jjeTmnCA==
From:   "thermal-bot for Ezequiel Garcia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: rockchip-thermal: Support the
 RK3568 SoC compatible
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210506175514.168365-4-ezequiel@collabora.com>
References: <20210506175514.168365-4-ezequiel@collabora.com>
MIME-Version: 1.0
Message-ID: <162426917672.395.8926075497478975348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c5c9dfdcaea216bc1bd21402081540a8f9940e1a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c5c9dfdcaea216bc1bd21402081540a8f9940e1a
Author:        Ezequiel Garcia <ezequiel@collabora.com>
AuthorDate:    Thu, 06 May 2021 14:55:13 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 21 Jun 2021 11:50:36 +02:00

dt-bindings: rockchip-thermal: Support the RK3568 SoC compatible

Add a new compatible for the thermal sensor device on RK3568 SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210506175514.168365-4-ezequiel@collabora.com
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
index 8385e8a..b96ea27 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3328-tsadc # RK3328 SoCs
       - rockchip,rk3368-tsadc # RK3368 SoCs
       - rockchip,rk3399-tsadc # RK3399 SoCs
+      - rockchip,rk3568-tsadc # RK3568 SoCs
 
   reg:
     maxItems: 1
