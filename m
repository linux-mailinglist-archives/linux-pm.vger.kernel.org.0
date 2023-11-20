Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FA27F206C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Nov 2023 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjKTWfq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Nov 2023 17:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTWfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Nov 2023 17:35:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E1FC4
        for <linux-pm@vger.kernel.org>; Mon, 20 Nov 2023 14:35:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C1FC433C7;
        Mon, 20 Nov 2023 22:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700519741;
        bh=x9xycIkTae6WcCNvi+WWU3VyU+4mfQhz9WaLpAhlaeM=;
        h=From:Date:Subject:To:Cc:From;
        b=uwrhbGV3OS9sJPKBM9X2WcwKPk7LUKY3lWFErrqTlqmSykQ3jVvGMto8aSJhwlcgn
         MmuBxRpQIoQOMzFFJ6vfEwO8iYNjsirvcgpS5yudOcSk3yqwfyhiK3fdXYA3COUbPi
         07LdoCUnctrj/w8MkclmN+sri0rOYDpuP/7pYjz0XgIHppx8tQDhV4ph/3Cu9DAmio
         YORdYG8FVYpyr5g7om/mZYbBAp3BYuFiRaO7GEwu2rwpKMt+JM4O5Fs+55rEuebdCg
         SAawLHEHzRTdaVi5Dd9j0BIvPn7/K46/UOf9nJCpzPm0hOuP7e6Ir4dNEkPbjN/7+9
         v+B0HA99ZcqiQ==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Mon, 20 Nov 2023 15:35:32 -0700
Subject: [PATCH] power: reset: at91: Drop '__init' from
 at91_wakeup_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-fix-at91-modpost-warnings-v1-1-813671933863@kernel.org>
X-B4-Tracking: v=1; b=H4sIADPfW2UC/x2MMQrDMAwAvxI0R2ArQ2m/UjLItppqqB2skASC/
 x7T8eDuLjCpKgav4YIqu5qW3MGPA8Qv50VQU2cgR5P35PCjJ/L29PgraS224cE1a14Mg3BIFDg
 +iKD3a5Uu/9/vubUb3tJXt2sAAAA=
To:     sre@kernel.org
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, u.kleine-koenig@pengutronix.de,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=nathan@kernel.org;
 h=from:subject:message-id; bh=x9xycIkTae6WcCNvi+WWU3VyU+4mfQhz9WaLpAhlaeM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKnR920m3DViLfbOF5/cnsE4x5xr4Yr4KpX5viyJhfdO/
 mGILufuKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABOZZM7I0Dk1QXr6hNUfJtUz
 WE1SaRb8nKa7PmFLrkuX8UlLC8ZdwQz/tGMv7RT2eyUQvuLUMlGJFNuN4gn3ctynrBN+zrK/7MF
 +RgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When building with clang, there are two section mismatch warnings:

  WARNING: modpost: vmlinux: section mismatch in reference: at91_poweroff_probe+0x7c (section: .text) -> at91_wakeup_status (section: .init.text)
  WARNING: modpost: vmlinux: section mismatch in reference: at91_shdwc_probe+0xcc (section: .text) -> at91_wakeup_status (section: .init.text)

Drop '__init' from at91_wakeup_status() to clear up the mismatch.

Fixes: dde74a5de817 ("power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_probe()")
Fixes: 099806de68b7 ("power: reset: at91-poweroff: Stop using module_platform_driver_probe()")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I suspect this is not visible for GCC due to inlining
at91_wakeup_status() but I did not actually check.
---
 drivers/power/reset/at91-poweroff.c      | 2 +-
 drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 126e774e210c..93eece027865 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -57,7 +57,7 @@ static struct shdwc {
 	void __iomem *mpddrc_base;
 } at91_shdwc;
 
-static void __init at91_wakeup_status(struct platform_device *pdev)
+static void at91_wakeup_status(struct platform_device *pdev)
 {
 	const char *reason;
 	u32 reg = readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index af95c7b39cb3..959ce0dbe91d 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -107,7 +107,7 @@ static const unsigned long long sdwc_dbc_period[] = {
 	0, 3, 32, 512, 4096, 32768,
 };
 
-static void __init at91_wakeup_status(struct platform_device *pdev)
+static void at91_wakeup_status(struct platform_device *pdev)
 {
 	struct shdwc *shdw = platform_get_drvdata(pdev);
 	const struct reg_config *rcfg = shdw->rcfg;

---
base-commit: b55d073e6501dc6077edaa945a6dad8ac5c8bbab
change-id: 20231120-fix-at91-modpost-warnings-beabd2bac722

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

