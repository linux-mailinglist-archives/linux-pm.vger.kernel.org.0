Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5971F2C219E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgKXJgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731415AbgKXJgp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:45 -0500
Date:   Tue, 24 Nov 2020 09:36:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3l4BzCI8goj/iv2JoAQsSj8xAsEOqpCy/YHg3A72i1o=;
        b=mHtWMHumkMkdhnu8HrObZB195zweXBPlCwTxU/wjYWN/OpfBNuzrLkUZOBDHR1kvRxbGWU
        LZpw+UrVlydZzItdW5XJC89OUwJ/BFsipO6jgaIKUpEG8PmF3mJre8DtRzf+CXt88QSuum
        +HuAQ6YryH1x3wcAtVLwM4rHuYRftwxRGz1SiPNaYI9jiRRYgrB2zHxvqDlnf5kbDIkQY+
        j1fFPdbqNGjjNXJUHwaLAzUzKdtK/V0RmN/vBT3Z9wqmBblmCvW9kriU2BzGJl6ScVqX+O
        soBYJg7I/RNeDoWqPAs/agsHpHXZVc43t6JkHXZbv9B40vQZVWeoi6eeAP42cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3l4BzCI8goj/iv2JoAQsSj8xAsEOqpCy/YHg3A72i1o=;
        b=2VtrFOQHiR6EqLNgRA7LVRJgL6t39BSpEPkxLo8BuvWvcP/jQynUKuOHKNyMTGhE5bfnA8
        S0CrFpcnfG848BAQ==
From:   "thermal-bot for Tian Tao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar: Replace
 spin_lock_irqsave by spin_lock in hard IRQ
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1603760790-37748-1-git-send-email-tiantao6@hisilicon.com>
References: <1603760790-37748-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Message-ID: <160621060206.11115.3591765536623361655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4eb7d0cd590d99b6010b5b87a88804cda09a85da
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4eb7d0cd590d99b6010b5b87a88804cda09a85da
Author:        Tian Tao <tiantao6@hisilicon.com>
AuthorDate:    Tue, 27 Oct 2020 09:06:30 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Oct 2020 10:45:22 +01:00

thermal/drivers/rcar: Replace spin_lock_irqsave by spin_lock in hard IRQ

On RT or even on mainline with 'threadirqs' on the command line all
interrupts which are not explicitly requested with IRQF_NO_THREAD
run their handlers in thread context. The same applies to soft interrupts.
That means they are subject to the normal scheduler rules and no other
code is going to acquire that lock from hard interrupt context either,
so the irqsave() here is pointless in all cases.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1603760790-37748-1-git-send-email-tiantao6@hisilicon.com
---
 drivers/thermal/rcar_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 5c2a13b..6ae757d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -409,16 +409,15 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 {
 	struct rcar_thermal_common *common = data;
 	struct rcar_thermal_priv *priv;
-	unsigned long flags;
 	u32 status, mask;
 
-	spin_lock_irqsave(&common->lock, flags);
+	spin_lock(&common->lock);
 
 	mask	= rcar_thermal_common_read(common, INTMSK);
 	status	= rcar_thermal_common_read(common, STR);
 	rcar_thermal_common_write(common, STR, 0x000F0F0F & mask);
 
-	spin_unlock_irqrestore(&common->lock, flags);
+	spin_unlock(&common->lock);
 
 	status = status & ~mask;
 
