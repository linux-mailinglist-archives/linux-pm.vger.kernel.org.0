Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0654425FB6E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgIGN2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 09:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbgIGN2R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Sep 2020 09:28:17 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5079221481;
        Mon,  7 Sep 2020 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599485245;
        bh=zduFED1gZ/Fbzt3bmZjWW745p5Gw8g0LTixr2qTH6j0=;
        h=From:To:Cc:Subject:Date:From;
        b=W7w2/HJnEneckbuZBV8qdPGq1ZRMfgpRBjAW+AIF/Im1UxWxiRgYfGn4hmFxSmlDI
         Wl2kjguXnaWzvzfv5Mp3SQw99es+ontfMDoZxzQAp3pPeqhU293tbFA4mXIDBFNTj8
         A3hRdXeg02UAXMc9c/5K+L1Lit0tXq+cdkG3vPuA=
Received: by pali.im (Postfix)
        id C2321814; Mon,  7 Sep 2020 15:27:22 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: armada-37xx: Add missing MODULE_DEVICE_TABLE
Date:   Mon,  7 Sep 2020 15:27:16 +0200
Message-Id: <20200907132716.6379-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CONFIG_ARM_ARMADA_37XX_CPUFREQ is tristate option and therefore this
cpufreq driver can be compiled as a module. This patch adds missing
MODULE_DEVICE_TABLE which generates correct modalias for automatic
loading of this cpufreq driver when is compiled as an external module.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 92ce45fb875d7 ("cpufreq: Add DVFS support for Armada 37xx")
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index df1c941260d1..46f33c3a7316 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -484,6 +484,12 @@ static int __init armada37xx_cpufreq_driver_init(void)
 /* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
 late_initcall(armada37xx_cpufreq_driver_init);
 
+static const struct of_device_id armada37xx_cpufreq_of_match[] = {
+	{ .compatible = "marvell,armada-3700-nb-pm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, armada37xx_cpufreq_of_match);
+
 MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
 MODULE_DESCRIPTION("Armada 37xx cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

