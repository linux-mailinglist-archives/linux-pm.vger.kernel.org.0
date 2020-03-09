Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B037217D760
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 01:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCIApI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 20:45:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55016 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgCIApH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Mar 2020 20:45:07 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 668CD1A16A7;
        Mon,  9 Mar 2020 01:45:05 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DEC71A078B;
        Mon,  9 Mar 2020 01:44:46 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0EC814024E;
        Mon,  9 Mar 2020 08:44:32 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, dmitry.torokhov@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        linux@roeck-us.net, daniel.baluta@nxp.com,
        gregkh@linuxfoundation.org, linux@rempel-privat.de,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de,
        ronald@innovation.ch, krzk@kernel.org, robh@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Date:   Mon,  9 Mar 2020 08:38:14 +0800
Message-Id: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add stubs for those i.MX SCU APIs to make those modules depending
on IMX_SCU can pass build when COMPILE_TEST is enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- return error for stubs.
---
 include/linux/firmware/imx/ipc.h | 11 +++++++++++
 include/linux/firmware/imx/sci.h | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 8910574..9e3d808 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -34,6 +34,7 @@ struct imx_sc_rpc_msg {
 	uint8_t func;
 };
 
+#ifdef CONFIG_IMX_SCU
 /*
  * This is an function to send an RPC message over an IPC channel.
  * It is called by client-side SCFW API function shims.
@@ -55,4 +56,14 @@ int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp);
  * @return Returns an error code (0 = success, failed if < 0)
  */
 int imx_scu_get_handle(struct imx_sc_ipc **ipc);
+#else
+static inline int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp)
+{
+	return -ENOENT;
+}
+static inline int imx_scu_get_handle(struct imx_sc_ipc **ipc)
+{
+	return -ENOENT;
+}
+#endif
 #endif /* _SC_IPC_H */
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 17ba4e4..022129b 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -16,8 +16,27 @@
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
 
+#ifdef CONFIG_IMX_SCU
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
+#else
+static inline int imx_scu_enable_general_irq_channel(struct device *dev)
+{
+	return -ENOENT;
+}
+static inline int imx_scu_irq_register_notifier(struct notifier_block *nb)
+{
+	return -ENOENT;
+}
+static inline int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENOENT;
+}
+static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
+{
+	return -ENOENT;
+}
+#endif
 #endif /* _SC_SCI_H */
-- 
2.7.4

