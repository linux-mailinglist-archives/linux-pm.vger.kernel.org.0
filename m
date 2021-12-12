Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254B14719C5
	for <lists+linux-pm@lfdr.de>; Sun, 12 Dec 2021 12:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhLLLUj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Dec 2021 06:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhLLLUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Dec 2021 06:20:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E595C061714
        for <linux-pm@vger.kernel.org>; Sun, 12 Dec 2021 03:20:39 -0800 (PST)
Date:   Sun, 12 Dec 2021 11:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639308037;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdlUtJezWr+1zboAQFOk/Veklt/yi6aUzJY5HAZYCog=;
        b=yY1mrwDWUT/MqKIBkQnkVf0HA+mes8g8+ne96ZNB/ffQ7/iCrTA1iwBPiAV8SO6r6KqE7v
        +spuJqemhUJbeqpPUpTkRiyzD8pTqjPLbeFwJy+o0z+fzwU17YFHxVvZvmbUGKvEt9D1uv
        wxEEEOqK21HGWuBJ1uHZvjNru+FJ0gFo8Y8qGydHVfsZxc5hZWeOutdwdXZCEMjvoWJam6
        Ib5C/s9YKUgvS6ZzWa4+Hr5/fBL19QrnH3fYNzJFEnIl4c21/GU0VAOduxxi8vZg/GB7xA
        2P7QEQTSoVhFHu/yixSFPFaaPj46QIqJlOwTmnoSCJqL+VTuuX7CFHesXIp0dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639308037;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdlUtJezWr+1zboAQFOk/Veklt/yi6aUzJY5HAZYCog=;
        b=C/zawVukcHwsgMtccQ5WLy2vgxn+6RYDgwA97gIMJlnYeq2/r9a161xVgyTj107OGNabl8
        71Il55MLhmYy4qAw==
From:   "thermal-bot for Rikard Falkeborn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/intel_powerclamp: Constify
 static thermal_cooling_device_ops
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211128214641.30953-1-rikard.falkeborn@gmail.com>
References: <20211128214641.30953-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Message-ID: <163930803664.23020.3518453177211102978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8152d2a9e73deb2b483bef9035d53ded27f50317
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8152d2a9e73deb2b483bef9035d53ded27f50317
Author:        Rikard Falkeborn <rikard.falkeborn@gmail.com>
AuthorDate:    Sun, 28 Nov 2021 22:46:41 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 30 Nov 2021 15:42:39 +01:00

thermal/drivers/intel_powerclamp: Constify static thermal_cooling_device_ops

The only usage of powerclamp_cooling_ops is to pass its address to
thermal_cooling_device_register(), which takes a pointer to const struct
thermal_cooling_device_ops. Make it const to allow the compiler to put
it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Link: https://lore.kernel.org/r/20211128214641.30953-1-rikard.falkeborn@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 9b68489..1425642 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -641,7 +641,7 @@ exit_set:
 }
 
 /* bind to generic thermal layer as cooling device*/
-static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
+static const struct thermal_cooling_device_ops powerclamp_cooling_ops = {
 	.get_max_state = powerclamp_get_max_state,
 	.get_cur_state = powerclamp_get_cur_state,
 	.set_cur_state = powerclamp_set_cur_state,
