Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC901436BE6
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhJUUTH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 16:19:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhJUUTG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 16:19:06 -0400
Date:   Thu, 21 Oct 2021 20:16:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634847409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BR451V9gHV5d2tMJ9zMTbGDioaMQw/Et568tIau39FA=;
        b=RWFDsvBwNuuYg+m/yXL27crgnc3RCG0H6kh88EQEl+Yi3KSnlb1veH2XQZiVJS/XE2h25i
        znmFgA8q7D4W0luVscHOBL+AF79M/HhEaOsHsmqO/Ndct1x0gYFN1IQMFI2MNkljDNFP7g
        FWt4Bos2WhPVdMSPfub0jmFK1PqKrqwV88+4OH88s/07AhCKLjFu+xMzyKx82Ps+1Dv37j
        xc9pV52lx1WxoogVnZIPfLqUQ2xxKcRrmKUO+o3gLfCT6OF/0oyeVQikE0O9izTePVQJDe
        EsoQauCMYs0QzGhpmcCEkXK7Ciuo09tNjCQrcw5rmbqgAr1xSBg5Gq78AToaHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634847409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BR451V9gHV5d2tMJ9zMTbGDioaMQw/Et568tIau39FA=;
        b=SdJzlqD+wb+Qpq5AU38fekV1wEKyk1udw1D+OhPESgjeu1jNHmYrsKRCzXpniPvbCa3XAH
        Yx7OS2FGf999ypCw==
From:   "thermal-bot for Kunihiko Hayashi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: uniphier: Add binding
 for NX1 SoC
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1634520891-16801-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634520891-16801-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Message-ID: <163484740875.25758.5680896084824244200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     5041e63aaf36021f71b5f6244811a9cf2fe89fb4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//5041e63aaf36021f71b5f6244811a9cf2fe89fb4
Author:        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
AuthorDate:    Mon, 18 Oct 2021 10:34:50 +09:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Oct 2021 13:59:57 +02:00

dt-bindings: thermal: uniphier: Add binding for NX1 SoC

Update thermal binding document for UniPhier NX1 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1634520891-16801-2-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
index 553c9dc..c5b25ce 100644
--- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
@@ -20,6 +20,7 @@ properties:
       - socionext,uniphier-pxs2-thermal
       - socionext,uniphier-ld20-thermal
       - socionext,uniphier-pxs3-thermal
+      - socionext,uniphier-nx1-thermal
 
   interrupts:
     maxItems: 1
