Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9801A1B5D52
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgDWOIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 10:08:46 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58798 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgDWOIp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 10:08:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3DBF81A0023;
        Thu, 23 Apr 2020 16:08:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D7771A000A;
        Thu, 23 Apr 2020 16:08:38 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8F4F9402D5;
        Thu, 23 Apr 2020 22:08:30 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        leonard.crestez@nxp.com, linux@rempel-privat.de, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] firmware: imx: Remove unused include of linux/firmware/imx/types.h
Date:   Thu, 23 Apr 2020 22:00:05 +0800
Message-Id: <1587650406-20050-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587650406-20050-1-git-send-email-Anson.Huang@nxp.com>
References: <1587650406-20050-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that linux/firmware/imx/types.h is removed, remove it from the
include list in imx-scu.c driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index f71eaa5..f3340fa 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/firmware/imx/types.h>
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
-- 
2.7.4

