Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA83BAE2C
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhGDSFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 14:05:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55804 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhGDSFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 14:05:06 -0400
Date:   Sun, 04 Jul 2021 18:02:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625421750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWkMsLP9kyDsySmEYSeUH1sShfk/CtzyNukgTzR4kfs=;
        b=EQ+U3qeY+Fm6JJktnfiEIP6/Vshbytcts24Mu906tbJfD7KeyZhx+Vsf2UJuXDur7nE39r
        SgGlmUKaH/lBBKOJ84i5s99jXoffqMGzqltOwzSMXzj9jg3IVj5VySbbRUNIVhkHeSonYC
        qgQ6xYwxJEB/BBxHk2ONV4tt/Qar8q37ReFr+vfTYPwXogYkhWRAx1WrgZ/8c8ZPHVFDWx
        K1hKAc+WCeETkvvUvu8tWDb3adS2PYXcoTKoTzbjknFAFFV9P3ayXbiyYq3cDJ0mxzrgft
        Lbt4zOYcaL5+qSQWzOoErsdFeEwBYlC7trjFCE8BTKJPYKm7INzHbRr39QSkfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625421750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWkMsLP9kyDsySmEYSeUH1sShfk/CtzyNukgTzR4kfs=;
        b=ka4V/jX5/foC/Bk9AuWRX+LL5JP71Pl9AFRKlCP6mgo9XDmsZK4tA6pPAoMttFtctNM7B0
        s8jJHrpv5EnlJzDQ==
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
Message-ID: <162542174936.395.9435708040322109262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4b14c055a6f644cbeb1156ba24647e92fe51ec69
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4b14c055a6f644cbeb1156ba24647e92fe51ec69
Author:        Ezequiel Garcia <ezequiel@collabora.com>
AuthorDate:    Thu, 06 May 2021 14:55:13 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 04 Jul 2021 18:28:04 +02:00

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
