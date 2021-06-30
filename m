Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF23B8AA4
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhF3W6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 18:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232397AbhF3W6g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Jun 2021 18:58:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F54613D1;
        Wed, 30 Jun 2021 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625093767;
        bh=1XbpMrAHLknLLoDhzLADpsI4YXpwMU7vvfhNLq5DXh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gg1GriXGY/N+rrmX/YSR1NIBzGTRhex6grbfuCbGsS6L6q2SqsXM358PqRyWjLxZ5
         BflxoiOroAxRzWQKMbH2C+RkkuTWE3nwdn5WYL/Cz4g6Dz+qmzC/TJ17plQq3iqTM+
         87fQuZOABInlaf0b4jUMep1lOaAv0YzKr4U58J24rScMqI8vUcoZVuQdrz0wMddd3+
         bwEeXbhY4NHPISSA8PxEOmlzK5k4/tNzWHijTkB7OgBmzoI9uDu5Wu3hbdtVmGn9PK
         W1jV216OcTVSPfxfv0is6LuaWRd1I24Wr8Wuok/c9n5S+InXTOqY8MWinIrsB4FqlM
         MkyTrTnahYjKw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ken Ma <make@marvell.com>, Victor Gu <xigu@marvell.com>
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
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant
Date:   Thu,  1 Jul 2021 00:56:01 +0200
Message-Id: <20210630225601.6372-1-kabel@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630135942.29730-1-kabel@kernel.org>
References: 
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

Signed-off-by: Marek Behún <kabel@kernel.org>
Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
---
If someone from Marvell could look into this, it would be great since
basically 1.2 GHz variant cannot scale, which is a feature that was
claimed to be supported by the SOC.

Ken Ma / Victor Gu, you have worked on commit
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/d6719fdc2b3cac58064f41b531f86993c919aa9a
in linux-marvell.
Your patch takes away the 1202 mV constant for 1.2 GHz base CPU
frequency and instead adds code that computes the voltages from the
voltage found in L0 AVS register (which is filled in by WTMI firmware).

Do you know why the code does not work correctly for some 1.2 GHz
boards? Do we need to force the L0 voltage to 1202 mV if it is lower,
or something?
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 3fc98a3ffd91..c10fc33b29b1 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -104,7 +104,11 @@ struct armada_37xx_dvfs {
 };
 
 static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
-	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
+	/*
+	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
+	 * unstable because we do not know how to configure it properly.
+	 */
+	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
 	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
 	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
 	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
-- 
2.31.1

