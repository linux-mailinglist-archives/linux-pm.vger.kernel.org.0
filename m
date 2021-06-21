Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717393AE666
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFUJtO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhFUJtA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:00 -0400
Date:   Mon, 21 Jun 2021 09:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gC6Pg5+iCeyJs7kMmRwCfJAUgvX4qml+huVWv97VUag=;
        b=ej2aktoed8qEIbND5kzgxOShDqnS7iHQYmpTG5Yk7MypIj15BvAs9y08hkNo+iBlwgJzcv
        iqFUCCkLCriuOmCKP07B9Y/c7kw4OH7ZGvBf36opIBCZ4CgDbpza/Izm6w6ZTxObjVf+wk
        XGTRkJJLzaJCYOUFTczCCAKz0Uu2KaY2GVrHQ9KbEGdMmvRN3GcaXuBNJiSBnRS6VFNHdN
        kU19PUwFqejrICeSwET7TwWrmxpvJVkv5KzR/iB9jGtiWzTnhWLkGgQj7kDllwVLm+Jhxv
        fqc7Joe4clRtfYSa4rhLMTBNdZ5DqNJTVwWkMmKjrfy7FWvMXmx2M7JOAbjA6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gC6Pg5+iCeyJs7kMmRwCfJAUgvX4qml+huVWv97VUag=;
        b=Jwvvw+ZBWfoUi961seBHxakNsovsDg27sOaPkLG09l0HW7HnkC16bettM++QYLCU1LRIov
        Sq2ghULiQ7ApXuAA==
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
Message-ID: <162426880422.395.3306659775280091620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1f9c5936b10c8ac38bfd3a931915b6c50b72ba05
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1f9c5936b10c8ac38bfd3a931915b6c50b72ba05
Author:        Dmitry Osipenko <digetx@gmail.com>
AuthorDate:    Thu, 17 Jun 2021 10:24:03 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 17 Jun 2021 17:59:00 +02:00

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
index 46c2215..eca61c5 100644
--- a/drivers/thermal/tegra/Kconfig
+++ b/drivers/thermal/tegra/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "NVIDIA Tegra thermal drivers"
-depends on ARCH_TEGRA
+depends on ARCH_TEGRA || COMPILE_TEST
 
 config TEGRA_SOCTHERM
 	tristate "Tegra SOCTHERM thermal management"
