Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63115436BE5
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhJUUTH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 16:19:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhJUUTG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 16:19:06 -0400
Date:   Thu, 21 Oct 2021 20:16:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634847409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jL6wyZNqlf2H9e//+80GqcfAdGQXJsVxVfyydZ6D924=;
        b=IMUEjv3hMEpFJheRcXqFHdbw+6aNZC6tqeM0wv43C7wNK8p43BXOgxMzl726E0STf2/4/g
        9lkaF1yQOUDzb8nsRm3o4jmnn8qr2flfStjHXRmWdvHhP3lXXom9IGW5EWXPk30/MH9gGO
        3vAB6cvf0atW4fzv/Vv15lxZbwXEyvjpwmsx3TgzhiAngsGzrctEf9IIOUF3xnuJ8+00oQ
        n6+umIptNv4GQwFp3CHqOzU1cfHFfOk2SZvCYAFBBkQVtP2b9n8tP8y3bZXh6jYWa7ZfM4
        g3sFhDZHY1wBhUd9QRl+M+W2GhMNiI1AgtJ1pHWREkHIC8cKDTQWodUX5ArTrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634847409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jL6wyZNqlf2H9e//+80GqcfAdGQXJsVxVfyydZ6D924=;
        b=/GGYFOqvUiu17n4nefL3mSk6btWYh/5qb697fGq3AYXZKBY+ixWL/9qH+qHl5sWNJrnd4o
        Eup8LztnEdW9/hCw==
From:   "thermal-bot for Kunihiko Hayashi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/uniphier: Add compatible
 string for NX1 SoC
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1634520891-16801-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634520891-16801-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Message-ID: <163484740810.25758.18225294692290217017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     fb6de59d3967f87fe4cae4b08f55cbe0d5a30b77
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//fb6de59d3967f87fe4cae4b08f55cbe0d5a30b77
Author:        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
AuthorDate:    Mon, 18 Oct 2021 10:34:51 +09:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Oct 2021 14:00:13 +02:00

thermal/drivers/uniphier: Add compatible string for NX1 SoC

Add basic support for UniPhier NX1 SoC. This includes a compatible string
and the same SoC-dependent data as LD20 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1634520891-16801-3-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/uniphier_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index bba2284..4cae556 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -358,6 +358,10 @@ static const struct of_device_id uniphier_tm_dt_ids[] = {
 		.compatible = "socionext,uniphier-pxs3-thermal",
 		.data       = &uniphier_ld20_tm_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-thermal",
+		.data       = &uniphier_ld20_tm_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, uniphier_tm_dt_ids);
