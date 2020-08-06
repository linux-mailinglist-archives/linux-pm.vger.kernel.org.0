Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD723DC35
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgHFQrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 12:47:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50650 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgHFQn3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:43:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3izC-0004aV-Ms; Thu, 06 Aug 2020 16:43:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thermal: mediatek: remove redundant initialization of variables
Date:   Thu,  6 Aug 2020 17:43:22 +0100
Message-Id: <20200806164322.91568-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several variables that are being initialized with values
that are never read and the variables are being re-assigned later
on. Remove the redundant initializations.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/mtk_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0bd7aa564bc2..88f3cf75af0d 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -573,12 +573,12 @@ static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw)
 
 static int raw_to_mcelsius_v2(struct mtk_thermal *mt, int sensno, s32 raw)
 {
-	s32 format_1 = 0;
-	s32 format_2 = 0;
-	s32 g_oe = 1;
-	s32 g_gain = 1;
-	s32 g_x_roomt = 0;
-	s32 tmp = 0;
+	s32 format_1;
+	s32 format_2;
+	s32 g_oe;
+	s32 g_gain;
+	s32 g_x_roomt;
+	s32 tmp;
 
 	if (raw == 0)
 		return 0;
-- 
2.27.0

