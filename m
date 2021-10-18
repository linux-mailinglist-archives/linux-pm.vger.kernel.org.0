Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439C24317C2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhJRLsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhJRLsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3249C061714
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 04:46:06 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:46:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Ydnsvz6MxmqcU4EfvUZ2Kg3B8A9nRR/97E5u17El7E=;
        b=AOVRbHaBKDR3aYDkeRCWX/TAoy2GmJj2iEcRXRQHzbqWnqeZUi/0+wIy0xy75MmOETGjGe
        Pz1VGNtiy/Gz2wlXTo3giGkjh4ROvvxM6cnpOyYRuGYXa/kj2rLCCJb4zNZ1jS71/QhHWD
        Ov1gZNtUNUxmOtnZmezpQZ5w81fS+zJshNzswaNqEtNlTQRJVJuavCPRBE3QxPDKe7WjcQ
        kxxDhJB2DFYWOzS/TilNu24MdRcQs7Mc2cpDvi5DRlUZ5++JBYj9DNVfNXOXgwwgKVpwQX
        8rHy+bwjqzChM43ewbi5TCW4utImjQBtQC1UG77Yd627CccZS0dR1zrlxJSUgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Ydnsvz6MxmqcU4EfvUZ2Kg3B8A9nRR/97E5u17El7E=;
        b=5IWV89wiDp9vhzEcjJrNhmYuLf36X6mLVyeFlAp7YPIA7EpYwmlQlmiKOkl/jVi01sJ/Ay
        ViuMtmPF/DwWW5DQ==
From:   "thermal-bot for Rikard Falkeborn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/thermal_mmio: Constify static
 struct thermal_mmio_ops
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Talel Shenhar <talel@amazon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210920203849.32136-1-rikard.falkeborn@gmail.com>
References: <20210920203849.32136-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Message-ID: <163455756445.25758.15774779720456234515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     69c560d2eb3cff7ebe876cd224a3dc05852990b5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//69c560d2eb3cff7ebe876cd224a3dc05852990b5
Author:        Rikard Falkeborn <rikard.falkeborn@gmail.com>
AuthorDate:    Mon, 20 Sep 2021 22:38:49 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 07 Oct 2021 15:18:31 +02:00

thermal/drivers/thermal_mmio: Constify static struct thermal_mmio_ops

The only usage of thermal_mmio_ops is to pass its address to
devm_thermal_zone_of_sensor_register(), which has a pointer to const
struct thermal_zone_of_device_ops as argument. Make it const to allow
the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Acked-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210920203849.32136-1-rikard.falkeborn@gmail.com
---
 drivers/thermal/thermal_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index ded1dd0..360b0df 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -34,7 +34,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops thermal_mmio_ops = {
+static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
 	.get_temp = thermal_mmio_get_temperature,
 };
 
