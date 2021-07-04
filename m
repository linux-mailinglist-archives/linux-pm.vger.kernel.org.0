Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94E3BAE32
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhGDSFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 14:05:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55822 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGDSFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 14:05:07 -0400
Date:   Sun, 04 Jul 2021 18:02:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625421751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2bOABJSUPaOltw/CsIIIt8UAzEBFBY8/8CEGv21obI=;
        b=JtvLKw2ZTmx9tv0py3rom/so7kDeexAIMz7O31ErfhnVQi3/uRXcYsgZv257qpUrf33jhL
        ARQnhkkIuXVko7jsmlM931v95uw/7UoMSs+Cl4VysvnVpo1jHXmx/575uQ5XTk3+9wSfIz
        uVgrFp7itcoTUyu7d0S//K85bDwrSPTXeVtrTW+csbENCYlRBVPjBAGcOTPkn7oktc5UUK
        a97Iski+nDw9X7TLZYXojPdi8aNHTDKabn+RItWu2etv5rq/9cYY1cLSvEBbF1ixEdCQUU
        vwGIEeZYxX6F8DMSTcHqRWT8+KzNDc/p4djy2lq3XyA+dS2JTMMWFghrGphZgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625421751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2bOABJSUPaOltw/CsIIIt8UAzEBFBY8/8CEGv21obI=;
        b=k2DhAy1xLIXBCRX78oeAHCNgfv3c76viRmDxiWvAFUsBd/U8ms5uW5xy7W+TUNYVT182y6
        0AZIw7wafgrhaRDA==
From:   "thermal-bot for Dmitry Osipenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core/thermal_of: Stop zone device
 before unregistering it
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210616190417.32214-3-digetx@gmail.com>
References: <20210616190417.32214-3-digetx@gmail.com>
MIME-Version: 1.0
Message-ID: <162542175042.395.9959013006651549705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     5e5c9f9a75fc4532980c2e699caf8a36070a3a2e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//5e5c9f9a75fc4532980c2e699caf8a36070a3a2e
Author:        Dmitry Osipenko <digetx@gmail.com>
AuthorDate:    Wed, 16 Jun 2021 22:04:13 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 04 Jul 2021 18:28:04 +02:00

thermal/core/thermal_of: Stop zone device before unregistering it

Zone device is enabled after thermal_zone_of_sensor_register() completion,
but it's not disabled before senor is unregistered, leaving temperature
polling active. This results in accessing a disabled zone device and
produces a warning about this problem. Stop zone device before
unregistering it in order to fix this "use-after-free" problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210616190417.32214-3-digetx@gmail.com
---
 drivers/thermal/thermal_of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5b76f9a..6379f26 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -559,6 +559,9 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	if (!tz)
 		return;
 
+	/* stop temperature polling */
+	thermal_zone_device_disable(tzd);
+
 	mutex_lock(&tzd->lock);
 	tzd->ops->get_temp = NULL;
 	tzd->ops->get_trend = NULL;
