Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E53B8494
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhF3OC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 10:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhF3OCQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Jun 2021 10:02:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3BAB61433;
        Wed, 30 Jun 2021 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625061587;
        bh=v5OBimTBlCfEF3FaB0xZQ7fhYUBBxeJ8vnG2hTzl9Cs=;
        h=From:To:Cc:Subject:Date:From;
        b=UhLf0L0iSKvyXCME1IfDYudvAIZPdd4PQmpptJiSx+90b7BBLlGxrREffX1Tex0ya
         TpbhJ/jPRSrwKQHYtnhLNUohgPV//0fLxm892CGhORXa/KRy7R2rYHnukRj/rHrOG9
         7QYbyaDeh6F1DS+6CUuULIWbRoetgplaBYx61UWB/TdFUFCZLrTpyprYfN1ZkXCy1V
         FQOaotL2JSAehjffWlpXVcsNQnCCGt9ST1/Pt57yKMo58wpe0lxiRh6kKAHCeO1KFP
         wtDeAu7Ae1k68QDqviz1hjokeXEPS7w8NWqMbLYwNJRTc+QH5p/E/Nal/DgHNikB1W
         TJK1eUYXdly0w==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        linux-pm@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Konstantin Porotchkin <kostap@marvell.com>,
        nnet <nnet@fastmail.fm>, Nadav Haklai <nadavh@marvell.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.iorg>
Subject: [PATCH] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant
Date:   Wed, 30 Jun 2021 15:59:42 +0200
Message-Id: <20210630135942.29730-1-kabel@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 1.2 GHz variant of the Armada 3720 SOC is unstable with DVFS: when
the SOC boots, the WTMI firmware sets clocks and AVS values that work
correctly with 1.2 GHz CPU frequency, but random crashes occur once
cpufreq driver starts scaling.

We do not know currently what is the reason:
- it may be that the voltage value for L0 for 1.2 GHz variant provided
  by the vendor in the OTP is simply incorrect when scaling is used,
- it may be that some delay is needed somewhere,
- it may be something else.

The most sane solution now seems to be to simply forbid the cpufreq
driver on 1.2 GHz variant.

Signed-off-by: Marek Behún <kabel@kernel.iorg>
Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
---
If someone from Marvell could look into this, it would be great since
basically 1.2 GHz variant cannot scale, which is a feature that was
claimed to be supported by the SOC.
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 3fc98a3ffd91..1ef3dde9a40b 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -104,7 +104,13 @@ struct armada_37xx_dvfs {
 };
 
 static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
+#if 0
+	/*
+	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
+	 * unstable because we do not know how to configure it properly.
+	 */
 	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
+#endif
 	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
 	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
 	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
-- 
2.31.1

