Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EAB3AE663
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFUJtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43228 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFUJs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:48:59 -0400
Date:   Mon, 21 Jun 2021 09:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQ4y63EXvVriZjFSsw/b76onsc/CSPBMqXtjg/6D1Z0=;
        b=Dsou/Bnzu4nDhfu0m5EdCwzdxDG9F2tQbhL3tnbYFvzQnlAtYtdPgQPE5pOH95AqJXInRO
        i9ke/1sxz07l1oIvBAYWmHWnL2YuGyI2k4bFedjXmE7NDXyMnyihRIXi1D13lcphpfK64z
        F2ddT4OcnVViDwiImmrpmI/vrrputrb2FasusjaW2Y191SuZExKokV2jUTQ7P9zB/cnVyT
        qQ/8ARRM9+JJANlBHBKAP3VQObMDpFbQHV99kEIjhmHmAMOVagUpbg6n+pAR3TbFSgEgr7
        xL0dhOcug8TQLBc6AAiJJBhJf1/RtzX2TK+ZZUB8VweDKM4M9zvss+EEahn7zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQ4y63EXvVriZjFSsw/b76onsc/CSPBMqXtjg/6D1Z0=;
        b=yR3TvCvcvUxYbt1UX6bxfJME14OusrAHY14NLChOic5EQ1k1Pg4mGrxOQsVkipg+Wf+McU
        1X2186D0nDJaMlAg==
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
Message-ID: <162426880307.395.3890058875463840927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     add9a126cfb59375c36e779bf739fc765219ed11
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//add9a126cfb59375c36e779bf739fc765219ed11
Author:        Dmitry Osipenko <digetx@gmail.com>
AuthorDate:    Wed, 16 Jun 2021 22:04:13 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Jun 2021 12:39:50 +02:00

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
