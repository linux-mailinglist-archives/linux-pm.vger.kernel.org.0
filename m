Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D271751F6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 03:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCBC5i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 21:57:38 -0500
Received: from inva021.nxp.com ([92.121.34.21]:39574 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgCBC5i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Mar 2020 21:57:38 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB877200E2A;
        Mon,  2 Mar 2020 03:57:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A0CF200C80;
        Mon,  2 Mar 2020 03:57:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 762004029E;
        Mon,  2 Mar 2020 10:57:24 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx_sc_thermal: Align imx sc thermal msg structs to 4
Date:   Mon,  2 Mar 2020 10:51:25 +0800
Message-Id: <1583117485-30922-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The i.MX SCU API strongly assumes that messages are composed out
of 4-bytes words but some of our message structs have odd sizeofs,
use __packed __aligned(4) to avoid potential oopses.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
This patch is based on https://patchwork.kernel.org/patch/11397719/ which is accepted.
---
 drivers/thermal/imx_sc_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 4955dfd..dbb277a 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -27,12 +27,12 @@ struct imx_sc_sensor {
 struct req_get_temp {
 	u16 resource_id;
 	u8 type;
-} __packed;
+} __packed __aligned(4);
 
 struct resp_get_temp {
 	u16 celsius;
 	u8 tenths;
-} __packed;
+} __packed __aligned(4);
 
 struct imx_sc_msg_misc_get_temp {
 	struct imx_sc_rpc_msg hdr;
@@ -40,7 +40,7 @@ struct imx_sc_msg_misc_get_temp {
 		struct req_get_temp req;
 		struct resp_get_temp resp;
 	} data;
-};
+} __packed __aligned(4);
 
 static int imx_sc_thermal_get_temp(void *data, int *temp)
 {
-- 
2.7.4

