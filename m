Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9273618AE64
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 09:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgCSIdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 04:33:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42242 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgCSIdg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Mar 2020 04:33:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4016420153A;
        Thu, 19 Mar 2020 09:33:35 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B637320155C;
        Thu, 19 Mar 2020 09:33:29 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4789F402E4;
        Thu, 19 Mar 2020 16:33:23 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx_sc_thermal: Fix incorrect data type
Date:   Thu, 19 Mar 2020 16:26:20 +0800
Message-Id: <1584606380-9972-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The temperature value passed from SCU could be negative value,
the data type should be signed instead of unsigned.

Fixes: ed0843633fee ("thermal: imx_sc: add i.MX system controller thermal support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_sc_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index dbb277a..a8723b1 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -30,8 +30,8 @@ struct req_get_temp {
 } __packed __aligned(4);
 
 struct resp_get_temp {
-	u16 celsius;
-	u8 tenths;
+	s16 celsius;
+	s8 tenths;
 } __packed __aligned(4);
 
 struct imx_sc_msg_misc_get_temp {
-- 
2.7.4

