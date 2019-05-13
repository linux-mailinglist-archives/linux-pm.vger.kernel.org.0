Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D61B19F
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfEMH52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 03:57:28 -0400
Received: from shell.v3.sk ([90.176.6.54]:59038 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfEMH52 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 03:57:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B34EB1041D3;
        Mon, 13 May 2019 09:57:25 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uYeRQP673Bdc; Mon, 13 May 2019 09:57:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EF7781041C7;
        Mon, 13 May 2019 09:56:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oLi719uWZqBL; Mon, 13 May 2019 09:56:47 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 96EBC1041D5;
        Mon, 13 May 2019 09:56:45 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v7 10/10] Platform: OLPC: Add restart support to XO-1.75 EC driver
Date:   Mon, 13 May 2019 09:56:41 +0200
Message-Id: <20190513075641.1277716-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513075641.1277716-1-lkundrak@v3.sk>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This hooks to arm_pm_restart instead od utilizing a restart handler
notifier, because the reboot dance on XO 1.75 needs to sleep (it pokes a
GPIO and waits for the EC to initiate the command transaction) and the
restart handler is called in atomic context. Sad.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v4:
- Split off from the driver.

 drivers/platform/olpc/Kconfig         |  2 +-
 drivers/platform/olpc/olpc-xo175-ec.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
index 858ac1d2290a..02b232c34444 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -4,7 +4,7 @@ config OLPC_EC
=20
 config OLPC_XO175_EC
 	tristate "OLPC XO 1.75 Embedded Controller"
-	depends on ARCH_MMP || COMPILE_TEST
+	depends on ARM && (ARCH_MMP || COMPILE_TEST)
 	select SPI_SLAVE
 	select OLPC_EC
 	help
diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olp=
c/olpc-xo175-ec.c
index 344d14f3da54..b64443605a03 100644
--- a/drivers/platform/olpc/olpc-xo175-ec.c
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
+#include <asm/system_misc.h>
=20
 struct ec_cmd_t {
 	u8 cmd;
@@ -580,6 +581,14 @@ static int olpc_xo175_ec_set_event_mask(unsigned int=
 mask)
 	return olpc_ec_cmd(CMD_WRITE_EXT_SCI_MASK, args, 2, NULL, 0);
 }
=20
+static void olpc_xo175_ec_restart(enum reboot_mode mode, const char *cmd=
)
+{
+	while (1) {
+		olpc_ec_cmd(CMD_POWER_CYCLE, NULL, 0, NULL, 0);
+		mdelay(1000);
+	}
+}
+
 static void olpc_xo175_ec_power_off(void)
 {
 	while (1) {
@@ -651,6 +660,8 @@ static int olpc_xo175_ec_remove(struct spi_device *sp=
i)
 {
 	if (pm_power_off =3D=3D olpc_xo175_ec_power_off)
 		pm_power_off =3D NULL;
+	if (arm_pm_restart =3D=3D olpc_xo175_ec_restart)
+		arm_pm_restart =3D NULL;
=20
 	spi_slave_abort(spi);
=20
@@ -718,6 +729,8 @@ static int olpc_xo175_ec_probe(struct spi_device *spi=
)
=20
 	if (pm_power_off =3D=3D NULL)
 		pm_power_off =3D olpc_xo175_ec_power_off;
+	if (arm_pm_restart =3D=3D NULL)
+		arm_pm_restart =3D olpc_xo175_ec_restart;
=20
 	dev_info(&spi->dev, "OLPC XO-1.75 Embedded Controller driver\n");
=20
--=20
2.21.0

