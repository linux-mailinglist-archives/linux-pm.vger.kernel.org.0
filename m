Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254E52D1273
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgLGNrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLGNrz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:47:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E400DC0613D0
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 05:47:14 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVfaR6x2vgLeEHDJybecidzaHaOCB1phlOu3Pp7eVDk=;
        b=ySSPp8vVq5jQcz56TNMuxrtXNMQv8LDViWeanqsM++vfkYWFUq5RC36xKmtM6RFO1CEYnU
        z9biRA6sfyAZf1TkZhdpUMLyQgez1UXsK/05KP/SyzIxlPifsa3lxYct1gg/JqU4ZU+gTh
        Jmn6zXEGHnwDaRNidXRW1NUFGIgfZPbjE/TJIrRTneU502pQmmH7uqseZ5LDhlxKGaPU+x
        ZkpADZHUe7qPBuNgI5S3unVo3h0/iZZHFvAWffDhqUu+Rk06CP5S6ATADvi5GlOxlNwweO
        xZBUIdQawPpeRvL2OzP/yGyzTV6qUb0MJHVTaZxBF1T3H3BiGuaQNIqMbk4xAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVfaR6x2vgLeEHDJybecidzaHaOCB1phlOu3Pp7eVDk=;
        b=Y78iF3coaWY3ZDDWkBY/XIs6SyefXa3x+L6nezVIfQ21FSCYP9qQbFLd1e8q0bCB5ecviq
        PAyx5WsYAIAuRyAQ==
From:   "thermal-bot for Fabio Estevam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: imx8mm: Print the correct error code
Cc:     Fabio Estevam <festevam@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201202232448.2692-1-festevam@gmail.com>
References: <20201202232448.2692-1-festevam@gmail.com>
MIME-Version: 1.0
Message-ID: <160734883254.3364.9824171514292521688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ce662ccde5c6ae4f4d89fe71570bf59441004eb9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ce662ccde5c6ae4f4d89fe71570bf59441004eb9
Author:        Fabio Estevam <festevam@gmail.com>
AuthorDate:    Wed, 02 Dec 2020 20:24:47 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 04 Dec 2020 20:46:03 +01:00

thermal: imx8mm: Print the correct error code

Currently the error message does not print the correct error code.

Fix it by initializing 'ret' to the proper error code.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201202232448.2692-1-festevam@gmail.com
---
 drivers/thermal/imx8mm_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index a1e4f9b..ce7cb64 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -166,10 +166,11 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 							     &tmu->sensors[i],
 							     &tmu_tz_ops);
 		if (IS_ERR(tmu->sensors[i].tzd)) {
+			ret = PTR_ERR(tmu->sensors[i].tzd);
 			dev_err(&pdev->dev,
 				"failed to register thermal zone sensor[%d]: %d\n",
 				i, ret);
-			return PTR_ERR(tmu->sensors[i].tzd);
+			return ret;
 		}
 		tmu->sensors[i].hw_id = i;
 	}
