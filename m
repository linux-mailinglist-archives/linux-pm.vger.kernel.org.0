Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35533BAE2A
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGDSFF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 14:05:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55804 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhGDSFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 14:05:05 -0400
Date:   Sun, 04 Jul 2021 18:02:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625421748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dk64yZnRfCLaUolBAMMCBJiCGRWJKV7unKN3HXUe3kQ=;
        b=Zb35XzRimsK1ZxlhruQMCwqgRBygK9YknWJAKHSSiaK860qk1/KGN55TQb8tZun6nHzn8p
        Hv9D2ZnCEYpp7dao1Rqt6b+1mOlNbUI4/8buZ1FHWGmloaSQyWZbM9eNUFLJqPKMZGcLSw
        9h3CU2TZKaoXf9VohSVYqF7/VQ+Pv/u00wpRILAHp7vSvA20iQGm+uEVpy4zYj+UU0FUym
        nBf5dsBFX03evx8wd8WLwfQptbnVSX1N6m39uIf7CRIdJUfos/supOegCcuXzcxLqhaa5K
        nM5ThWAxGognYK8+AQMIkNTvyPFUejCeIu2xFL/2S9w8zbLCm9QZ+uRHYcgJEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625421748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dk64yZnRfCLaUolBAMMCBJiCGRWJKV7unKN3HXUe3kQ=;
        b=6JwmHVlXHfCX7mlHYfq/xiMP3Jmt9G5kvTY+QszQDILqZmYkGUuIRGd/iUivrRUu9sN77e
        POySoPbNbuvSoxDQ==
From:   "thermal-bot for Yang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: devfreq_cooling: Fix kernel-doc
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <162542174778.395.16269952890099570850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8b2ea897328c3e042ef7c3e80503c802db24a678
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8b2ea897328c3e042ef7c3e80503c802db24a678
Author:        Yang Li <yang.lee@linux.alibaba.com>
AuthorDate:    Wed, 09 Jun 2021 15:22:30 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 04 Jul 2021 18:28:04 +02:00

thermal: devfreq_cooling: Fix kernel-doc

Fix function name in devfreq_cooling.c comment to remove a
warning found by kernel-doc.

drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
devfreq_cooling_em_register_power(). Prototype was for
devfreq_cooling_em_register() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 3a788ac..5a86cff 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
 EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
 /**
- * devfreq_cooling_em_register_power() - Register devfreq cooling device with
+ * devfreq_cooling_em_register() - Register devfreq cooling device with
  *		power information and automatically register Energy Model (EM)
  * @df:		Pointer to devfreq device.
  * @dfc_power:	Pointer to devfreq_cooling_power.
