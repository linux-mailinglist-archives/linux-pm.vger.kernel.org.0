Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0D36CBEB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbhD0TpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbhD0TpQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:16 -0400
Date:   Tue, 27 Apr 2021 19:44:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+fDsaXtL8BuYIyFkm4b7pLocHxzwnjKlB3ZJRrXb2s=;
        b=paXQfbWUuJUhiPsTltL3HicF+QHSIW0OGV/Aq81f/bDECOjZoOhNpqufHrVpuqaIfBmO8o
        GzMOzypmGAb9c5STwDa4LUatHz8G0NAWVK+Vn3dCShAHkD/+6YZRQcCvvQHX91K8dzUkaF
        vjSYDA+rO4bUAyUJ22Bt6UxcLTx0Wfzgu+/DWJQIZxbMtmNkVAaIWyU77pl6AZL8d8TaQ2
        RgbeAsybmx5TOEzE6TS9gCP8bZ4g1o37VobDJf1Sdq8W7845daD8CcwhYHfFv7iA6HoAfd
        dyCHs0AXoC2/HE/uDECfq4Zfuc9x+7Mqngi/fv4iATu6xB9Wfiw2MAeEv4xLvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+fDsaXtL8BuYIyFkm4b7pLocHxzwnjKlB3ZJRrXb2s=;
        b=BWFcNlRfFYkSCELDIeTkJaSpmxxZPdvk6SZb93LhPd+ffLXPKndrf/FqGRi2ibQIsHMR+Q
        U/DLraeP/bEK4ACQ==
From:   "thermal-bot for Lin Ruizhe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/ti-soc-thermal/bandgap Remove
 unused variable 'val'
Cc:     Hulk Robot <hulkci@huawei.com>, Lin Ruizhe <linruizhe@huawei.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210421084256.57591-1-linruizhe@huawei.com>
References: <20210421084256.57591-1-linruizhe@huawei.com>
MIME-Version: 1.0
Message-ID: <161955267138.29796.3566387171712555298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     d473327f8f53418691cb2944a45da3e9ea51f9bf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d473327f8f53418691cb2944a45da3e9ea51f9bf
Author:        Lin Ruizhe <linruizhe@huawei.com>
AuthorDate:    Wed, 21 Apr 2021 16:42:56 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 21 Apr 2021 13:37:18 +02:00

thermal/drivers/ti-soc-thermal/bandgap Remove unused variable 'val'

The function ti_bandgap_restore_ctxt() restores the context at resume
time. It checks if the sensor has a counter, reads the register but
does nothing with the value.

The block was probably omitted by the commit b87ea759a4cc.

Remove the unused variable as well as the block using it as we can
consider it as dead code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: b87ea759a4cc ("staging: omap-thermal: fix context restore function")
Signed-off-by: Lin Ruizhe <linruizhe@huawei.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210421084256.57591-1-linruizhe@huawei.com
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 008fbed..ebe7cb7 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1142,14 +1142,10 @@ static int ti_bandgap_restore_ctxt(struct ti_bandgap *bgp)
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
 		struct temp_sensor_registers *tsr;
 		struct temp_sensor_regval *rval;
-		u32 val = 0;
 
 		rval = &bgp->regval[i];
 		tsr = bgp->conf->sensors[i].registers;
 
-		if (TI_BANDGAP_HAS(bgp, COUNTER))
-			val = ti_bandgap_readl(bgp, tsr->bgap_counter);
-
 		if (TI_BANDGAP_HAS(bgp, TSHUT_CONFIG))
 			ti_bandgap_writel(bgp, rval->tshut_threshold,
 					  tsr->tshut_threshold);
