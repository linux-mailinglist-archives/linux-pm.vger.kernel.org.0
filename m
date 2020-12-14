Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819982D9A2D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440034AbgLNOlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 09:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407887AbgLNOlH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 09:41:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465AC0613D3
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 06:40:23 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/AV/TRYJw5ZyMQ2/iHK53gbZ3jRwBOqlnFaVOjQnr0=;
        b=f09GiC8/YXD5zObuVbUeqoJFx3XI5bjByYshVL7thEk//84s98P9bdidrXlqA9U/y0OD92
        qJD5FguIjSI2GE1JmjJGPFfWqTUnrsziTSC67ioimGpfOZz5KCyYCB1VnUXNJCLKiufm+A
        es3rX0zKwEVSLmpFwz4MxFPXmYidORfokvbHtuoRGx+WaKdHteRE0haLMgQOxv6H359N11
        xUsjaSkM+U/3ks4+IBhevpmp6JVInXEOqAsxPh8y2uKCsDH5JXMOpJ9sUjZz02MDdOHbbZ
        jAqCuTG9meuPxulZrwLjJ0+cPWpiJz/59x0uMks04p7/mqcKmVLcctVRYJC1pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/AV/TRYJw5ZyMQ2/iHK53gbZ3jRwBOqlnFaVOjQnr0=;
        b=hgvSPlaiHSOqM4tDDr6cR3FrcV7vshn4nu9j4/7l8v0mhKJndPG6fuK4QV9LO18iNKWkjx
        oNVZ7LwaTPFQCFCA==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drm/panfrost: Register devfreq cooling and
 attempt to add Energy Model
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201210143014.24685-6-lukasz.luba@arm.com>
References: <20201210143014.24685-6-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160795681965.3364.14937680834302806548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     23e9d781413ab6dd2b743d61439423c575347fc4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//23e9d781413ab6dd2b743d61439423c575347fc4
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 10 Dec 2020 14:30:14 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Dec 2020 14:10:44 +01:00

drm/panfrost: Register devfreq cooling and attempt to add Energy Model

Register devfreq cooling device and attempt to register Energy Model. This
will add the devfreq device to the Energy Model framework. It will create
a dedicated and unified data structures used i.e. in thermal framework.
It uses simplified Energy Model, created based on voltage, frequency
and DT 'dynamic-power-coefficient'.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201210143014.24685-6-lukasz.luba@arm.com
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 8ab025d..0d97176 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -143,7 +143,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	}
 	pfdevfreq->devfreq = devfreq;
 
-	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
+	cooling = devfreq_cooling_em_register(devfreq, NULL);
 	if (IS_ERR(cooling))
 		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
 	else
