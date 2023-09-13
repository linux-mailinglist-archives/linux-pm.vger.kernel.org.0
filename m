Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE879EA27
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 15:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjIMN4U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 09:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbjIMN4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 09:56:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544BE19B6
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 06:56:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7120C433CB;
        Wed, 13 Sep 2023 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694613370;
        bh=9eSoQKn81k97ZS3dPFMO8j6znDqsfS9i9/EwB0IgH0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXIDbRgaTvRE9wOoUV1pRzrzmyXKk5c4VzDGUqW17nHjTjv3EmCm1IDZ0+E8Sjd8G
         S9LTCpOl8wkvxyeIVQJrl6aM0b/fALVuTbtBhVXVBm69apSCwbJcpfIyzu1DfUT313
         2I44VdkZPk1/HXYdmWuQ7kP7Dvf8TqeHq5Ntk5yujhU4pJarqvxuNXG/eJxUW8LfC6
         E3uSkuoi8YW3ljbluieEdqqDhAgaN/Io3px4U2XsoYAqYibKxKF5o+rAA+5haE754r
         zdhE7Rjj/J651MbD6eCKWfpuMwDzNW1oxA3C+ossSFgGuA4SXu/Q95Z9IG4p/mi052
         ryQUDGc8nhidQ==
From:   Conor Dooley <conor@kernel.org>
To:     ulf.hansson@linaro.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        arnd@arndb.de, changhuang.liang@starfivetech.com,
        jiajie.ho@starfivetech.com, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh@kernel.org,
        walker.chen@starfivetech.com
Subject: [GIT PULL 1/5] pmdomain: starfive: Explicitly include correct DT includes
Date:   Wed, 13 Sep 2023 14:54:24 +0100
Message-Id: <20230913-swooned-ecosphere-aff4a05c1556@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=i5+EOM4kxuguOQSjSgCFjQq+qj0s7s7Br7dC6PPPcmY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmM+/ljbe0VzzMoZG1WemA2Z9vaAyvvPzZYVjppw9Xrv ur1zue3dJSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiyZIM/6Pe562TLPp+WELm vnCNyM/0uYXRZ64ZinVHscw4ut1t62GG/xGZe7Qubue2cdLKqW7/5lv8l/tQH9uO2VsOMBXNmK1 7mwUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Herring <robh@kernel.org>

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pmdomain/starfive/jh71xx-pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/starfive/jh71xx-pmu.c b/drivers/pmdomain/starfive/jh71xx-pmu.c
index 7d5f50d71c0d..d3b78a619d40 100644
--- a/drivers/pmdomain/starfive/jh71xx-pmu.c
+++ b/drivers/pmdomain/starfive/jh71xx-pmu.c
@@ -10,7 +10,6 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <dt-bindings/power/starfive,jh7110-pmu.h>
-- 
2.39.2

