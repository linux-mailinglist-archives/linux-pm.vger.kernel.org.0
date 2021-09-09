Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFFF405937
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbhIIOjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:39:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhIIOjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:39:47 -0400
Date:   Thu, 09 Sep 2021 14:38:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8Mqj62jGaENQmnLjctCcb4fHxNdWaum4ee0ga2G8/8=;
        b=QMpdoMVgox40ikSc3+uh02E8xhtz7jw8M9u5uXJTXG5CVM1YL7ER4d5ux9VEExnOXdG6O8
        JIoyDp/vtQ2g9SwZlkianXD6b0w+SaGnT8zv42bAgAw10HEj8Ykwz3nhT+wQm3wvYcrdoz
        XxerGdjv3eYhZr7uq2VS+pVm2VWuFwxM32Kdq9YK1lKd4+UTGyfnnLBF0q10S6TZEAkTT6
        yd1500Se7Msc5VixEPRKr21JLZuMRPe+L0t/KzvEJczUMqJWLfBc7zUpvpLwU+bv4535nN
        Plfeik/sRkgn2xlg3C5ogn8FuZLIdtYw2vFNqp6DkbxBspp+9r7uS1dFOVchTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8Mqj62jGaENQmnLjctCcb4fHxNdWaum4ee0ga2G8/8=;
        b=IVmFnJ4NPFmj+viEdTo9P1cDZgWjQ7kgZr3jI5nXHgJWvtRKLhTa0iLaHMOdaa8Ye9v3o2
        KC7wXobbfavCitBA==
From:   "thermal-bot for Dmitry Osipenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tegra-soctherm: Silence
 message about clamped temperature
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210712002353.17276-1-digetx@gmail.com>
References: <20210712002353.17276-1-digetx@gmail.com>
MIME-Version: 1.0
Message-ID: <163119831665.25758.2530106288475136335.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     16f944291a4ab896895e78934623b9d33af810cf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//16f944291a4ab896895e78934623b9d33af810cf
Author:        Dmitry Osipenko <digetx@gmail.com>
AuthorDate:    Mon, 12 Jul 2021 03:23:53 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 15:44:15 +02:00

thermal/drivers/tegra-soctherm: Silence message about clamped temperature

The Tegra soctherm driver prints message about the clamped temperature
trip each time when thermal core disables the low/high trip. The message
is confusing and creates illusion that driver is malfunctioning. Turn that
noisy info message into a debug message.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210712002353.17276-1-digetx@gmail.com
---
 drivers/thermal/tegra/soctherm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 8e303e9..210325f 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -450,8 +450,8 @@ static int enforce_temp_range(struct device *dev, int trip_temp)
 
 	temp = clamp_val(trip_temp, min_low_temp, max_high_temp);
 	if (temp != trip_temp)
-		dev_info(dev, "soctherm: trip temperature %d forced to %d\n",
-			 trip_temp, temp);
+		dev_dbg(dev, "soctherm: trip temperature %d forced to %d\n",
+			trip_temp, temp);
 	return temp;
 }
 
