Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFEA33F098
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhCQMjp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49830 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhCQMjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:15 -0400
Date:   Wed, 17 Mar 2021 12:39:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARCO5KCfACZBigTFCTnrtk/v2PMqczRTlNOrkHR/zbo=;
        b=eAItY99QWsJgEo7LoyTaIzNBCobTsVN3HOdaG+L4dj9nXkIsX6KUsowsr+0ioh4FE25xn0
        nBq+CQC51VaYSv+CHDbupJw0LFphTB5H0rNS68GPMfQOMQKBrKhTnojQTI4OvNiMVYQDia
        OI+1Cy/UeN+ra52Lb1GWGoBIqkA5+sA0KCam95l7CfdIzgDnXJ1wkxXER2yN5gDdZE9Ta7
        lwy/qCFl+OEgeFj1t8N01k5T2zU1S1AyjROL5xRBFXJA8T6xU3G/g2d0jNTd6jJeFPtuJY
        DMKLLgLIrXSNwjE4catcg2cCaeHikjAw/8ZyIKP2A4whk69+0aEV34SvsTBAXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARCO5KCfACZBigTFCTnrtk/v2PMqczRTlNOrkHR/zbo=;
        b=7FuNyal/TwhgwbJTla7P8iS2zvwql3xe6BovPRJUWOKTRpQmpnZOXn2JXlO/2CoYk9Hivv
        h6FYQ8e1z31Qj/Dg==
From:   "thermal-bot for Bhaskar Chowdhury" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: Fix a typo in the file soctherm.c
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210305015320.7614-1-unixbhaskar@gmail.com>
References: <20210305015320.7614-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Message-ID: <161598475392.398.11513913230541974962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6606800192008bd2929c55614697645f53e07427
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6606800192008bd2929c55614697645f53e07427
Author:        Bhaskar Chowdhury <unixbhaskar@gmail.com>
AuthorDate:    Fri, 05 Mar 2021 07:23:20 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 10 Mar 2021 12:54:58 +01:00

thermal: Fix a typo in the file soctherm.c

s/calibaration/calibration/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210305015320.7614-1-unixbhaskar@gmail.com
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 66e0639..8b8fbd4 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2195,7 +2195,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	/* calculate tsensor calibaration data */
+	/* calculate tsensor calibration data */
 	for (i = 0; i < soc->num_tsensors; ++i) {
 		err = tegra_calc_tsensor_calib(&soc->tsensors[i],
 					       &shared_calib,
