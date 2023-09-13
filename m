Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9564E79EA29
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbjIMN4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 09:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbjIMN4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 09:56:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B7519B1
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 06:56:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3854C433C9;
        Wed, 13 Sep 2023 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694613374;
        bh=WyGoT/IpS4j5guw4pY2xjfZcTVdCNCPd7Kqn0VeALVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIJP4AIvy0hbT5V2SKk9Xef/Tet7mmZsFqwesBKgS0l/MJcvZRnrwSfaYQOg5sI5B
         VDszCrfPZYxDgVjH4Kli3Ra6USYi6QnTBzWeMrDxDruxZq2XSABptBehKv0irJ+VN6
         egn88/8CYZrfyS4KHwd5sQXx1hLX7sxg8cpUGMu/rippOTS3zSO9IOFVEOtOqrkMQn
         vYwaS+3kggf0yyDlYZ4a/uTxc63xZfXrIMdqaVIyDSDrI/fNfzDrgRxZNqL46Wm8B2
         VmzY/t4NirRGAhKKJV1ULWXhVyBgtAcuN1BJjsg12EH7aALHIGTs/wCxllbpzcGVxm
         uy0Kukji+LjlA==
From:   Conor Dooley <conor@kernel.org>
To:     ulf.hansson@linaro.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        arnd@arndb.de, changhuang.liang@starfivetech.com,
        jiajie.ho@starfivetech.com, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh@kernel.org,
        walker.chen@starfivetech.com
Subject: [GIT PULL 3/5] pmdomain: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
Date:   Wed, 13 Sep 2023 14:54:26 +0100
Message-Id: <20230913-legibly-treachery-567cffcb5604@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ROTpWeJDGZli0o85OeBFiNqOQk1oLZRZwx1V2xQWjsQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmM+wX8dq5l7svdNaMwJ6/jAdvtOas8BA7q+j4+cPNqI /Om+DiDjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEykZDnDL+Yd3r82bvJefniC NLvGiYRLn6qET0y3LZHdtmBHwNG25ZIMf3ivbNmzOuDpg03rQkS46vortgjZ9HY8bb+c3Cq6dLe WITMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Changhuang Liang <changhuang.liang@starfivetech.com>

Using ARCH_FOO symbol is preferred than SOC_FOO.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/starfive/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
index bdb96dc4c989..1e9b0c414fec 100644
--- a/drivers/soc/starfive/Kconfig
+++ b/drivers/soc/starfive/Kconfig
@@ -3,8 +3,8 @@
 config JH71XX_PMU
 	bool "Support PMU for StarFive JH71XX Soc"
 	depends on PM
-	depends on SOC_STARFIVE || COMPILE_TEST
-	default SOC_STARFIVE
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	default ARCH_STARFIVE
 	select PM_GENERIC_DOMAINS
 	help
 	  Say 'y' here to enable support power domain support.
-- 
2.39.2

