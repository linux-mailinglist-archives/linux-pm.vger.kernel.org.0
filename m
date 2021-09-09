Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1944940593A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbhIIOkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:40:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60186 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbhIIOjz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:39:55 -0400
Date:   Thu, 09 Sep 2021 14:38:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+XGyWD9UgYKJCioFQxUJ1JXB2zqKDZHWjkbBzPkf8U=;
        b=ZKcYE0vlz85/dyko5uTb76FyS6XXaBlnNAyvluF3P0LPS0ikgapEH0SNPQjaEG7goq4upx
        pnonY2cEG0DawYaTh24CQiPDL/TFM+44AaZP5vS5CNBMKnaA8l7Revsz6IJp47JC0H8f5m
        s2B47DqHdh1Meexni+auVNPCJshIaQ3l0zrEK16qig5akZwk2gcdeHwAZ8HM+mhvwIQNx/
        SV42mi4Ugwe0n7i/am0HCubu/nNI6XaTxDEbev+61mej2EUPr/LK28tUZsXFczY2DZWdWa
        LjSqkIcfL+WdRfoRyZKa6xPnl7/7mqzcuZaAq329izMHKp5Gzurx+Ex5LSFflQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+XGyWD9UgYKJCioFQxUJ1JXB2zqKDZHWjkbBzPkf8U=;
        b=m5kGyORubbFqdlaR9jIHx2yKfyIVD7sOVv3OorodGHrJ7UqeeVKBlhpGp7g5Bq2HZu+Qe6
        KxUdCiq9vUa14qDg==
From:   "thermal-bot for Dmitry Osipenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tegra: Correct
 compile-testing of drivers
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210617072403.3487-1-digetx@gmail.com>
References: <20210617072403.3487-1-digetx@gmail.com>
MIME-Version: 1.0
Message-ID: <163119832446.25758.5156579765179827360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8f8d8b0334cc4e7908b78e73936a7673bbef0411
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8f8d8b0334cc4e7908b78e73936a7673bbef0411
Author:        Dmitry Osipenko <digetx@gmail.com>
AuthorDate:    Thu, 17 Jun 2021 10:24:03 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 12:24:06 +02:00

thermal/drivers/tegra: Correct compile-testing of drivers

All Tegra thermal drivers support compile-testing, but the drivers are
not available for compile-testing because the whole Kconfig meny entry
depends on ARCH_TEGRA, missing the alternative COMPILE_TEST dependency
option. Correct the Kconfig entry.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210617072403.3487-1-digetx@gmail.com
---
 drivers/thermal/tegra/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
index 019e3a2..cfa41d8 100644
--- a/drivers/thermal/tegra/Kconfig
+++ b/drivers/thermal/tegra/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "NVIDIA Tegra thermal drivers"
-depends on ARCH_TEGRA
+depends on ARCH_TEGRA || COMPILE_TEST
 
 config TEGRA_SOCTHERM
 	tristate "Tegra SOCTHERM thermal management"
