Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72502C21A1
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgKXJgw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731411AbgKXJgn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6324C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 01:36:43 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:36:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wExZYRNkp/HIMhjeYFYbwhs8Jj28DvP1cT5nP0o6670=;
        b=4qDxxqvc+Fpj9V5R/qXEUvLe3+ruwJoI6VM7452ojH5XUWfIp6bB/IM3z7NK2jzI59dt4e
        7lrBPIxjYhzQN0JKDS4OjvN7vroxdcJXV1rYxNewwzj+e7H1itN4xtrqvj0x58jRuQxPBl
        0ydPwWO/v8cIPibDmFXViWC0H4t90WTeLlqxLoUqx5K9fwlPf0gK4vJmMel6R3zSTbwVpw
        ZQyIVUhZnbuSscHz2ZA0UEXi8ui7IkOhz45HDPbnseOEdOVP2mfSRLlYhe0XL750on7HIQ
        LTb96z3b8OttoY4JzNwM7mzmR4GL4CfGkzp2V3qqsXKU+E5x6BPQuq9RueEItQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wExZYRNkp/HIMhjeYFYbwhs8Jj28DvP1cT5nP0o6670=;
        b=KVCET2l73Q/LE0JtS/rKdc0uqgKx3PWx21UqKqvs/9kuFa2jKQeQZfWm7+3FaRgg2PHeYk
        +ZKBEeGqTJResEAw==
From:   "thermal-bot for Fabien Parent" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: mediatek: make resets
 property optional
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201021164231.3029956-1-fparent@baylibre.com>
References: <20201021164231.3029956-1-fparent@baylibre.com>
MIME-Version: 1.0
Message-ID: <160621060139.11115.15221822048764705565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     07df39d03c34bd7baf4c26e41a5dd92ec56e9081
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//07df39d03c34bd7baf4c26e41a5dd92ec56e9081
Author:        Fabien Parent <fparent@baylibre.com>
AuthorDate:    Wed, 21 Oct 2020 18:42:29 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Oct 2020 11:18:29 +01:00

dt-bindings: thermal: mediatek: make resets property optional

MT8516 Thermal IP does not support reset. Make the resets property
optional in order to be able to support MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201021164231.3029956-1-fparent@baylibre.com
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 1e249c4..2d20f6b 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -20,12 +20,12 @@ Required properties:
                        clocks are:
 		       "therm":	 Main clock needed for register access
 		       "auxadc": The AUXADC clock
-- resets: Reference to the reset controller controlling the thermal controller.
 - mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
 - mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
 - #thermal-sensor-cells : Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
 
 Optional properties:
+- resets: Reference to the reset controller controlling the thermal controller.
 - nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
                unspecified default values shall be used.
 - nvmem-cell-names: Should be "calibration-data"
