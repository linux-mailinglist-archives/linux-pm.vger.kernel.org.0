Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2064852C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiLIP0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiLIP0i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCD58F0A3
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:33 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Du3zQvYb5b+hUA4JRwWIvl2n1iMBuKNrQ1M8PHGTuXQ=;
        b=zQK5QLC98E9ujxFEZcKLL5YHP3RAPiuF312OMcfBqqQ1si0KpRPDNcHbHqOskSOEzok3EI
        O9UhNqkHGQNZOcjA/VT/x5EaZFWwYHdlSlbpQuhx1TUmS8Tz7iVWW/bpmCWAImjKFqqRTn
        V4l28peMMQn7jt9dc4gbKQxbDmHPkvSWG3tIYjnJXCx1s2Z9km7AWnLocjWzf52lLkSPO5
        B9SNjFY6+utLpWrcMLDdxFXwA7Vgo2+/a6h4QOQ0tGJ90zNfPwyjpkUV9rg6A8QKwo6b5K
        jgmfpKKwrtXANaOxFTLA3UCxeOZ83XM6+XG2EXJbL0Zef8Nx2c6fDHFmNFBqNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Du3zQvYb5b+hUA4JRwWIvl2n1iMBuKNrQ1M8PHGTuXQ=;
        b=AEZDDd2R/11dZCXhCIDbZgmpF7InY4kERQC2fT8YIhH0owRchSJ2IJ7CQb/OJjo0D3/Jez
        jzVrU8G9rZxvlXCg==
From:   "thermal-bot for Christian Marangi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/tsens: Fix wrong version
 id dbg_version_show
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20221022125657.22530-3-ansuelsmth@gmail.com>
References: <20221022125657.22530-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <167059958922.4906.8782182432203072147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f48301cee9719fdfa469bb619297655aa8c811f0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f48301cee9719fdfa469bb619297655aa8c811f0
Author:        Christian Marangi <ansuelsmth@gmail.com>
AuthorDate:    Sat, 22 Oct 2022 14:56:56 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:44 +01:00

thermal/drivers/qcom/tsens: Fix wrong version id dbg_version_show

For VER_0 the version was incorrectly reported as 0.1.0.

Fix that and correctly report the major version for this old tsens
revision.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20221022125657.22530-3-ansuelsmth@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3ac7804..5f8d8f0 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -713,7 +713,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
 			return ret;
 		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
 	} else {
-		seq_puts(s, "0.1.0\n");
+		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
 	}
 
 	return 0;
