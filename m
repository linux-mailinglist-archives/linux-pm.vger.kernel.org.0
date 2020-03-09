Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6617D773
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 01:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCIApT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 20:45:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59206 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgCIApS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Mar 2020 20:45:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5738A201518;
        Mon,  9 Mar 2020 01:45:16 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4BA0D20096A;
        Mon,  9 Mar 2020 01:44:57 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 31881402D5;
        Mon,  9 Mar 2020 08:44:42 +0800 (SGT)
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
Subject: [PATCH V3 5/7] input: keyboard: imx_sc_key: Fix build warning for !CONFIG_IMX_SCU case
Date:   Mon,  9 Mar 2020 08:38:18 +0800
Message-Id: <1583714300-19085-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix below build warning when COMPILE_TEST is enabled while IMX_SCU is not:

drivers/input/keyboard/imx_sc_key.c: In function ‘imx_sc_check_for_events’:
drivers/input/keyboard/imx_sc_key.c:87:27: warning: ‘msg.state’ is used
uninitialized in this function [-Wuninitialized]
state = (bool)(msg.state & 0xff);
                             ^
AR      drivers/input/keyboard/built-in.a

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 drivers/input/keyboard/imx_sc_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/imx_sc_key.c b/drivers/input/keyboard/imx_sc_key.c
index 2672fd4..1b55348 100644
--- a/drivers/input/keyboard/imx_sc_key.c
+++ b/drivers/input/keyboard/imx_sc_key.c
@@ -69,6 +69,7 @@ static void imx_sc_check_for_events(struct work_struct *work)
 	hdr->func = IMX_SC_MISC_FUNC_GET_BUTTON_STATUS;
 	hdr->size = 1;
 
+	msg.state = 0;
 	error = imx_scu_call_rpc(priv->key_ipc_handle, &msg, true);
 	if (error) {
 		dev_err(&input->dev, "read imx sc key failed, error %d\n", error);
-- 
2.7.4

