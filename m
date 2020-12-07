Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF56E2D1275
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgLGNr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLGNr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:47:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679DFC0613D3
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 05:47:16 -0800 (PST)
Date:   Mon, 07 Dec 2020 13:47:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607348834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjMHStLz3aHxn+cz/AVxTTnAgCR2nVUA8LcQ7fahf80=;
        b=sjinzMlKTmhrvHP4NSqSpM+WK7aHsk+VtALaVWnqYWZycYiMAPP+WRt7lxdAsqoN+9WNT0
        kF6OoFF21ZrWl2eqFPuDG6Ee8Jvsrpn0LFewHh7GW9x2YvQq1w6Vl0Qxj9jeKT8zmXXwO/
        sJd+RIScN8UU+drtBnYexhUSgWEEyZEcivBHUJj4LQJl2y0kzBs9kmVUkLhyB6OVkARqq3
        spgkwSFnz7g/576GyG4xfTXZPRmXfzprSkjB2Gb1egXQrAnzj2gOJ3meF0K29PGyS/9+5x
        sf/SSIaLNZowfqSWIhxhRHX9YEFEQ9HeoPGxy1jlbjWdnjOXUVo2q/ahnp5SGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607348834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjMHStLz3aHxn+cz/AVxTTnAgCR2nVUA8LcQ7fahf80=;
        b=CVbsnRZAoddTujP4HLOUO8Ai9W9+jB8HFA/BYxDFHBTcYbStvzwzHY4KhruZA7eETA3mfj
        XWCR+3XCqIJRzdDQ==
From:   "thermal-bot for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel_pch_thermal: fix build for
 ACPI not enabled
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
In-Reply-To: <20201117023807.8266-1-rdunlap@infradead.org>
References: <20201117023807.8266-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <160734883428.3364.5035247709632805604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     be133722df5168d2f304cc59b80d3d21d6ea9433
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//be133722df5168d2f304cc59b80d3d21d6ea9433
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Mon, 16 Nov 2020 18:38:07 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 17 Nov 2020 10:05:43 +01:00

thermal: intel_pch_thermal: fix build for ACPI not enabled

The reference to acpi_gbl_FADT causes a build error when ACPI is not
enabled. Fix by making that conditional on CONFIG_ACPI.

../drivers/thermal/intel/intel_pch_thermal.c: In function 'pch_wpt_suspend':
../drivers/thermal/intel/intel_pch_thermal.c:217:8: error: 'acpi_gbl_FADT' undeclared (first use in this function); did you mean 'acpi_get_type'?
  if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
        ^~~~~~~~~~~~~

Fixes: ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH temperature above threshold")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201117023807.8266-1-rdunlap@infradead.org
---
 drivers/thermal/intel/intel_pch_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 32e1b28..d7c05c0 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -214,8 +214,12 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 	}
 
 	/* Do not check temperature if it is not a S0ix capable platform */
+#ifdef CONFIG_ACPI
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
 		return 0;
+#else
+	return 0;
+#endif
 
 	/* Do not check temperature if it is not s2idle */
 	if (pm_suspend_via_firmware())
