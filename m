Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059D0240367
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 10:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgHJI1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 04:27:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51870 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJI1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 04:27:43 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k539f-00075p-BE; Mon, 10 Aug 2020 08:27:39 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: thermal: Kconfig: fix spelling mistake "acces" -> "access"
Date:   Mon, 10 Aug 2020 09:27:39 +0100
Message-Id: <20200810082739.48007-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig text, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/st/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/st/Kconfig b/drivers/thermal/st/Kconfig
index 3c3b695cc3e9..58ece381956b 100644
--- a/drivers/thermal/st/Kconfig
+++ b/drivers/thermal/st/Kconfig
@@ -23,5 +23,5 @@ config STM32_THERMAL
 	help
 	  Support for thermal framework on STMicroelectronics STM32 series of
 	  SoCs. This thermal driver allows to access to general thermal framework
-	  functionalities and to acces to SoC sensor functionalities. This
+	  functionalities and to access to SoC sensor functionalities. This
 	  configuration is fully dependent of MACH_STM32MP157.
-- 
2.27.0

