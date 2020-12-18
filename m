Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299B82DDF67
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 09:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgLRIKr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 03:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgLRIKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2020 03:10:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCFEC0617B0
        for <linux-pm@vger.kernel.org>; Fri, 18 Dec 2020 00:10:06 -0800 (PST)
Date:   Fri, 18 Dec 2020 08:10:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608279002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QnruANJYe7Pz6UVLMs1EeEgZG9La84iFrm78ZTkZBc=;
        b=3ZJ9yJ8lzWg5/4tizL8PYUb1e5/elA6ewwU6jrTxhq5+bCWOoEJdJdvdcKnEDwLDz4GrXW
        aUbYiZUStLYgx8iL6/2P4IWomgVondhf/egzAqL+VDm2ToChXKUgmejeqbA/sCXMwSzMpD
        9dBPfNPrV85Hdt6RTcY2XT2UR9leoUrFdnqAhchqFTthA+uVHjZAgG4SZFT9j7VmlmC84X
        tNfw4JS5YB61xMySr/NN1dDp5xAhi8EyUFpToOpXTd7DVLlI5hqeGZKp7RkuO+ULMGB6sF
        ZaROSeLuf++DZ/ZrLsuFsD36Zi2iAKYao+rx9fDPw01x2v+UHIVaFaaqKoKU1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608279002;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QnruANJYe7Pz6UVLMs1EeEgZG9La84iFrm78ZTkZBc=;
        b=1LjxGOFMOnLKtoINorxk0dY9oKQJAZJWAfNT5r1bQRRvwhNTFjwaDQUGiX0AnJ6EqeP9En
        0JrlCjwN4Wn6YIAw==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: int340x: Support Alder Lake
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201117194802.503337-1-srinivas.pandruvada@linux.intel.com>
References: <20201117194802.503337-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160827900139.22759.11476982334025900593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     67698880ac9d56367ebf22f8336ccab6234f9feb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//67698880ac9d56367ebf22f8336ccab6234f9feb
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Tue, 17 Nov 2020 11:48:02 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 17 Dec 2020 15:29:30 +01:00

thermal: int340x: Support Alder Lake

Add ACPI IDs for thermal drivers for Alder Lake support.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201117194802.503337-1-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 0966551..823354a 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -584,6 +584,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 static const struct acpi_device_id int3400_thermal_match[] = {
 	{"INT3400", 0},
 	{"INTC1040", 0},
+	{"INTC1041", 0},
 	{}
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index ec1d58c..c3c4c4d 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -284,6 +284,7 @@ static int int3403_remove(struct platform_device *pdev)
 static const struct acpi_device_id int3403_device_ids[] = {
 	{"INT3403", 0},
 	{"INTC1043", 0},
+	{"INTC1046", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
