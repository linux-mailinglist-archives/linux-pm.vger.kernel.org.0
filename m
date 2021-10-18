Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE634317B7
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJRLsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRLsF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:05 -0400
Date:   Mon, 18 Oct 2021 11:45:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vg/f8ysec9c6jW11Duuq41ejPfFTm6LXtOic6G6uyq4=;
        b=41ch11jKHwBE85OB5iX367qOrmdeFqBjrp91WPtbbNFSD8JylbsMHBOrwzR16mU86kDdqn
        Onf5NIMvTo8H/zGklBHsTLG/CjRdfoqOKuYWqXw9QuoZG/FCU62Vn5HGm1bu9jO9xInZpt
        3a1BZJWjJPbqBPMqBGe1wcwhkhoZ3tYW7OCG5QeDTHK/1FLoF8wrZd3LtlgknjeKhJFR9I
        N3IeKCUiXRoEmBnfE6rJldTQMc9MhOzO3vyFstUCznPCfyEjXK6yQsNMNrOKmucSiO1GqE
        Y2RYRmXXzsbHrjJNCffVv4LoRuBUa6o8ShBMzljqFkbIKNGQik/8TbUDZGIyRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vg/f8ysec9c6jW11Duuq41ejPfFTm6LXtOic6G6uyq4=;
        b=rh3/Qtc85j4wZ7UKeB4/Cmb9PiA+anvCT6g7m3PWgb5XI9XbIwdhXJxCdDTHVZBdyztqeS
        z+lL1TFIfL/fiaDQ==
From:   "thermal-bot for Johan Jonker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rockchip_thermal: Allow more
 resets for tsadc node
Cc:     Johan Jonker <jbx6244@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210930110517.14323-3-jbx6244@gmail.com>
References: <20210930110517.14323-3-jbx6244@gmail.com>
MIME-Version: 1.0
Message-ID: <163455755179.25758.6510823420851766419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     02832ed8ae2c8b130efea4e43d3ecac50b4b7933
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//02832ed8ae2c8b130efea4e43d3ecac50b4b7933
Author:        Johan Jonker <jbx6244@gmail.com>
AuthorDate:    Thu, 30 Sep 2021 13:05:16 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 17 Oct 2021 00:15:09 +02:00

thermal/drivers/rockchip_thermal: Allow more resets for tsadc node

The tsadc node in rk356x.dtsi has more resets then currently supported
by the rockchip_thermal.c driver, so use
devm_reset_control_array_get() to reset them all.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://lore.kernel.org/r/20210930110517.14323-3-jbx6244@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 657d84b..dc3a9c2 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1383,7 +1383,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(thermal->regs))
 		return PTR_ERR(thermal->regs);
 
-	thermal->reset = devm_reset_control_get(&pdev->dev, "tsadc-apb");
+	thermal->reset = devm_reset_control_array_get(&pdev->dev, false, false);
 	if (IS_ERR(thermal->reset)) {
 		error = PTR_ERR(thermal->reset);
 		dev_err(&pdev->dev, "failed to get tsadc reset: %d\n", error);
