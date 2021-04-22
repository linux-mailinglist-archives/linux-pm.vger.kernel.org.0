Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1E368003
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhDVMEu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 08:04:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33584 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhDVMEt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 08:04:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lZY44-00040i-Ua; Thu, 22 Apr 2021 12:04:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: mtk_thermal: remove redundant initializations of several variables
Date:   Thu, 22 Apr 2021 13:04:12 +0100
Message-Id: <20210422120412.246291-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Several variables are being initialized with values that is never
read and being updated later with a new value. The initializations
are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/mtk_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 149c6d7fd5a0..97e8678ccf0e 100644
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
2.30.2

