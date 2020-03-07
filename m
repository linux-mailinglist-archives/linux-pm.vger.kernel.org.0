Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C817CA60
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 02:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCGBcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 20:32:52 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41214 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgCGBcv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 20:32:51 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BDB41A0DCE;
        Sat,  7 Mar 2020 02:32:49 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 24E7B1A0DC3;
        Sat,  7 Mar 2020 02:32:29 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2EC1A4029B;
        Sat,  7 Mar 2020 09:32:16 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, dmitry.torokhov@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        linux@roeck-us.net, daniel.baluta@nxp.com, linux@rempel-privat.de,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, robh@kernel.org, yuehaibing@huawei.com,
        ronald@innovation.ch, krzk@kernel.org, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 5/7] input: keyboard: imx_sc_key: Fix build warning for !CONFIG_IMX_SCU case
Date:   Sat,  7 Mar 2020 09:25:57 +0800
Message-Id: <1583544359-515-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
References: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
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
new patch.
---
 drivers/input/keyboard/imx_sc_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/imx_sc_key.c b/drivers/input/keyboard/imx_sc_key.c
index 9f809ae..26a12fb 100644
--- a/drivers/input/keyboard/imx_sc_key.c
+++ b/drivers/input/keyboard/imx_sc_key.c
@@ -72,6 +72,7 @@ static void imx_sc_check_for_events(struct work_struct *work)
 	hdr->func = IMX_SC_MISC_FUNC_GET_BUTTON_STATUS;
 	hdr->size = 1;
 
+	msg.state = 0;
 	error = imx_scu_call_rpc(priv->key_ipc_handle, &msg, true);
 	if (error) {
 		dev_err(&input->dev, "read imx sc key failed, error %d\n", error);
-- 
2.7.4

