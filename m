Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453DB1B1A1
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfEMH5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 03:57:33 -0400
Received: from shell.v3.sk ([90.176.6.54]:59057 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbfEMH5d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 03:57:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3858D1041C5;
        Mon, 13 May 2019 09:57:31 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 451xcjCkArF6; Mon, 13 May 2019 09:57:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5D74D1041DD;
        Mon, 13 May 2019 09:56:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jL4piaf-GE9r; Mon, 13 May 2019 09:56:44 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C91311041C7;
        Mon, 13 May 2019 09:56:43 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v7 03/10] Platform: OLPC: Move EC-specific functionality out from x86
Date:   Mon, 13 May 2019 09:56:34 +0200
Message-Id: <20190513075641.1277716-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513075641.1277716-1-lkundrak@v3.sk>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the olpc-ec driver away from the X86 OLPC platform so that it could =
be
used by the ARM based laptops too. Notably, the driver for the OLPC batte=
ry,
which is also used on the ARM models, builds on this driver's interface.

It is actually plaform independent: the OLPC EC commands with their argum=
ent
and responses are mostly the same despite the delivery mechanism is
different.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v4:
- A whitespace fix
- s/unisgned char ec_byte/u8 ec_byte/

Changes since v1:
- Cosmetic changes in line wrapping.
- Remove an old extra copy of EC_SCI_* defines
- Change version to u8
- Explain which parts are platform independent are in the commit message

 arch/x86/include/asm/olpc.h         |  31 --------
 arch/x86/platform/olpc/olpc.c       | 119 +++++-----------------------
 drivers/platform/olpc/olpc-ec.c     |  99 ++++++++++++++++++++++-
 drivers/power/supply/olpc_battery.c |   1 -
 include/linux/olpc-ec.h             |  32 +++++++-
 5 files changed, 145 insertions(+), 137 deletions(-)

diff --git a/arch/x86/include/asm/olpc.h b/arch/x86/include/asm/olpc.h
index c2bf1de5d901..6fe76282aceb 100644
--- a/arch/x86/include/asm/olpc.h
+++ b/arch/x86/include/asm/olpc.h
@@ -9,12 +9,10 @@
 struct olpc_platform_t {
 	int flags;
 	uint32_t boardrev;
-	int ecver;
 };
=20
 #define OLPC_F_PRESENT		0x01
 #define OLPC_F_DCON		0x02
-#define OLPC_F_EC_WIDE_SCI	0x04
=20
 #ifdef CONFIG_OLPC
=20
@@ -64,13 +62,6 @@ static inline int olpc_board_at_least(uint32_t rev)
 	return olpc_platform_info.boardrev >=3D rev;
 }
=20
-extern void olpc_ec_wakeup_set(u16 value);
-extern void olpc_ec_wakeup_clear(u16 value);
-extern bool olpc_ec_wakeup_available(void);
-
-extern int olpc_ec_mask_write(u16 bits);
-extern int olpc_ec_sci_query(u16 *sci_value);
-
 #else
=20
 static inline int machine_is_olpc(void)
@@ -83,14 +74,6 @@ static inline int olpc_has_dcon(void)
 	return 0;
 }
=20
-static inline void olpc_ec_wakeup_set(u16 value) { }
-static inline void olpc_ec_wakeup_clear(u16 value) { }
-
-static inline bool olpc_ec_wakeup_available(void)
-{
-	return false;
-}
-
 #endif
=20
 #ifdef CONFIG_OLPC_XO1_PM
@@ -101,20 +84,6 @@ extern void olpc_xo1_pm_wakeup_clear(u16 value);
=20
 extern int pci_olpc_init(void);
=20
-/* SCI source values */
-
-#define EC_SCI_SRC_EMPTY	0x00
-#define EC_SCI_SRC_GAME		0x01
-#define EC_SCI_SRC_BATTERY	0x02
-#define EC_SCI_SRC_BATSOC	0x04
-#define EC_SCI_SRC_BATERR	0x08
-#define EC_SCI_SRC_EBOOK	0x10	/* XO-1 only */
-#define EC_SCI_SRC_WLAN		0x20	/* XO-1 only */
-#define EC_SCI_SRC_ACPWR	0x40
-#define EC_SCI_SRC_BATCRIT	0x80
-#define EC_SCI_SRC_GPWAKE	0x100	/* XO-1.5 only */
-#define EC_SCI_SRC_ALL		0x1FF
-
 /* GPIO assignments */
=20
 #define OLPC_GPIO_MIC_AC	1
diff --git a/arch/x86/platform/olpc/olpc.c b/arch/x86/platform/olpc/olpc.=
c
index f0e920fb98ad..c6c62b4f251f 100644
--- a/arch/x86/platform/olpc/olpc.c
+++ b/arch/x86/platform/olpc/olpc.c
@@ -30,9 +30,6 @@
 struct olpc_platform_t olpc_platform_info;
 EXPORT_SYMBOL_GPL(olpc_platform_info);
=20
-/* EC event mask to be applied during suspend (defining wakeup sources).=
 */
-static u16 ec_wakeup_mask;
-
 /* what the timeout *should* be (in ms) */
 #define EC_BASE_TIMEOUT 20
=20
@@ -186,83 +183,6 @@ static int olpc_xo1_ec_cmd(u8 cmd, u8 *inbuf, size_t=
 inlen, u8 *outbuf,
 	return ret;
 }
=20
-void olpc_ec_wakeup_set(u16 value)
-{
-	ec_wakeup_mask |=3D value;
-}
-EXPORT_SYMBOL_GPL(olpc_ec_wakeup_set);
-
-void olpc_ec_wakeup_clear(u16 value)
-{
-	ec_wakeup_mask &=3D ~value;
-}
-EXPORT_SYMBOL_GPL(olpc_ec_wakeup_clear);
-
-/*
- * Returns true if the compile and runtime configurations allow for EC e=
vents
- * to wake the system.
- */
-bool olpc_ec_wakeup_available(void)
-{
-	if (!machine_is_olpc())
-		return false;
-
-	/*
-	 * XO-1 EC wakeups are available when olpc-xo1-sci driver is
-	 * compiled in
-	 */
-#ifdef CONFIG_OLPC_XO1_SCI
-	if (olpc_platform_info.boardrev < olpc_board_pre(0xd0)) /* XO-1 */
-		return true;
-#endif
-
-	/*
-	 * XO-1.5 EC wakeups are available when olpc-xo15-sci driver is
-	 * compiled in
-	 */
-#ifdef CONFIG_OLPC_XO15_SCI
-	if (olpc_platform_info.boardrev >=3D olpc_board_pre(0xd0)) /* XO-1.5 */
-		return true;
-#endif
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(olpc_ec_wakeup_available);
-
-int olpc_ec_mask_write(u16 bits)
-{
-	if (olpc_platform_info.flags & OLPC_F_EC_WIDE_SCI) {
-		__be16 ec_word =3D cpu_to_be16(bits);
-		return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *) &ec_word, 2,
-				   NULL, 0);
-	} else {
-		unsigned char ec_byte =3D bits & 0xff;
-		return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
-	}
-}
-EXPORT_SYMBOL_GPL(olpc_ec_mask_write);
-
-int olpc_ec_sci_query(u16 *sci_value)
-{
-	int ret;
-
-	if (olpc_platform_info.flags & OLPC_F_EC_WIDE_SCI) {
-		__be16 ec_word;
-		ret =3D olpc_ec_cmd(EC_EXT_SCI_QUERY,
-			NULL, 0, (void *) &ec_word, 2);
-		if (ret =3D=3D 0)
-			*sci_value =3D be16_to_cpu(ec_word);
-	} else {
-		unsigned char ec_byte;
-		ret =3D olpc_ec_cmd(EC_SCI_QUERY, NULL, 0, &ec_byte, 1);
-		if (ret =3D=3D 0)
-			*sci_value =3D ec_byte;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(olpc_ec_sci_query);
-
 static bool __init check_ofw_architecture(struct device_node *root)
 {
 	const char *olpc_arch;
@@ -296,6 +216,10 @@ static bool __init platform_detect(void)
 	if (success) {
 		olpc_platform_info.boardrev =3D get_board_revision(root);
 		olpc_platform_info.flags |=3D OLPC_F_PRESENT;
+
+		pr_info("OLPC board revision %s%X\n",
+			((olpc_platform_info.boardrev & 0xf) < 8) ? "pre" : "",
+			olpc_platform_info.boardrev >> 4);
 	}
=20
 	of_node_put(root);
@@ -315,27 +239,8 @@ static int __init add_xo1_platform_devices(void)
 	return PTR_ERR_OR_ZERO(pdev);
 }
=20
-static int olpc_xo1_ec_probe(struct platform_device *pdev)
-{
-	/* get the EC revision */
-	olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0,
-			(unsigned char *) &olpc_platform_info.ecver, 1);
-
-	/* EC version 0x5f adds support for wide SCI mask */
-	if (olpc_platform_info.ecver >=3D 0x5f)
-		olpc_platform_info.flags |=3D OLPC_F_EC_WIDE_SCI;
-
-	pr_info("OLPC board revision %s%X (EC=3D%x)\n",
-			((olpc_platform_info.boardrev & 0xf) < 8) ? "pre" : "",
-			olpc_platform_info.boardrev >> 4,
-			olpc_platform_info.ecver);
-
-	return 0;
-}
 static int olpc_xo1_ec_suspend(struct platform_device *pdev)
 {
-	olpc_ec_mask_write(ec_wakeup_mask);
-
 	/*
 	 * Squelch SCIs while suspended.  This is a fix for
 	 * <http://dev.laptop.org/ticket/1835>.
@@ -359,15 +264,27 @@ static int olpc_xo1_ec_resume(struct platform_devic=
e *pdev)
 }
=20
 static struct olpc_ec_driver ec_xo1_driver =3D {
-	.probe =3D olpc_xo1_ec_probe,
 	.suspend =3D olpc_xo1_ec_suspend,
 	.resume =3D olpc_xo1_ec_resume,
 	.ec_cmd =3D olpc_xo1_ec_cmd,
+#ifdef CONFIG_OLPC_XO1_SCI
+	/*
+	 * XO-1 EC wakeups are available when olpc-xo1-sci driver is
+	 * compiled in
+	 */
+	.wakeup_available =3D true,
+#endif
 };
=20
 static struct olpc_ec_driver ec_xo1_5_driver =3D {
-	.probe =3D olpc_xo1_ec_probe,
 	.ec_cmd =3D olpc_xo1_ec_cmd,
+#ifdef CONFIG_OLPC_XO1_5_SCI
+	/*
+	 * XO-1.5 EC wakeups are available when olpc-xo15-sci driver is
+	 * compiled in
+	 */
+	.wakeup_available =3D true,
+#endif
 };
=20
 static int __init olpc_init(void)
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 981955dce926..2a647455a368 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -32,6 +32,7 @@ struct ec_cmd_desc {
=20
 struct olpc_ec_priv {
 	struct olpc_ec_driver *drv;
+	u8 version;
 	struct work_struct worker;
 	struct mutex cmd_lock;
=20
@@ -41,6 +42,12 @@ struct olpc_ec_priv {
=20
 	struct dentry *dbgfs_dir;
=20
+	/*
+	 * EC event mask to be applied during suspend (defining wakeup
+	 * sources).
+	 */
+	u16 ec_wakeup_mask;
+
 	/*
 	 * Running an EC command while suspending means we don't always finish
 	 * the command before the machine suspends.  This means that the EC
@@ -149,6 +156,88 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 =
*outbuf, size_t outlen)
 }
 EXPORT_SYMBOL_GPL(olpc_ec_cmd);
=20
+void olpc_ec_wakeup_set(u16 value)
+{
+	struct olpc_ec_priv *ec =3D ec_priv;
+
+	if (WARN_ON(!ec))
+		return;
+
+	ec->ec_wakeup_mask |=3D value;
+}
+EXPORT_SYMBOL_GPL(olpc_ec_wakeup_set);
+
+void olpc_ec_wakeup_clear(u16 value)
+{
+	struct olpc_ec_priv *ec =3D ec_priv;
+
+	if (WARN_ON(!ec))
+		return;
+
+	ec->ec_wakeup_mask &=3D ~value;
+}
+EXPORT_SYMBOL_GPL(olpc_ec_wakeup_clear);
+
+int olpc_ec_mask_write(u16 bits)
+{
+	struct olpc_ec_priv *ec =3D ec_priv;
+
+	if (WARN_ON(!ec))
+		return -ENODEV;
+
+	/* EC version 0x5f adds support for wide SCI mask */
+	if (ec->version >=3D 0x5f) {
+		__be16 ec_word =3D cpu_to_be16(bits);
+
+		return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *)&ec_word, 2, NULL, 0=
);
+	} else {
+		u8 ec_byte =3D bits & 0xff;
+
+		return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
+	}
+}
+EXPORT_SYMBOL_GPL(olpc_ec_mask_write);
+
+/*
+ * Returns true if the compile and runtime configurations allow for EC e=
vents
+ * to wake the system.
+ */
+bool olpc_ec_wakeup_available(void)
+{
+	if (WARN_ON(!ec_driver))
+		return false;
+
+	return ec_driver->wakeup_available;
+}
+EXPORT_SYMBOL_GPL(olpc_ec_wakeup_available);
+
+int olpc_ec_sci_query(u16 *sci_value)
+{
+	struct olpc_ec_priv *ec =3D ec_priv;
+	int ret;
+
+	if (WARN_ON(!ec))
+		return -ENODEV;
+
+	/* EC version 0x5f adds support for wide SCI mask */
+	if (ec->version >=3D 0x5f) {
+		__be16 ec_word;
+
+		ret =3D olpc_ec_cmd(EC_EXT_SCI_QUERY, NULL, 0, (void *)&ec_word, 2);
+		if (ret =3D=3D 0)
+			*sci_value =3D be16_to_cpu(ec_word);
+	} else {
+		u8 ec_byte;
+
+		ret =3D olpc_ec_cmd(EC_SCI_QUERY, NULL, 0, &ec_byte, 1);
+		if (ret =3D=3D 0)
+			*sci_value =3D ec_byte;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(olpc_ec_sci_query);
+
 #ifdef CONFIG_DEBUG_FS
=20
 /*
@@ -276,14 +365,16 @@ static int olpc_ec_probe(struct platform_device *pd=
ev)
 	ec_priv =3D ec;
 	platform_set_drvdata(pdev, ec);
=20
-	err =3D ec_driver->probe ? ec_driver->probe(pdev) : 0;
+	/* get the EC revision */
+	err =3D olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ec->version, 1);
 	if (err) {
 		ec_priv =3D NULL;
 		kfree(ec);
-	} else {
-		ec->dbgfs_dir =3D olpc_ec_setup_debugfs();
+		return err;
 	}
=20
+	ec->dbgfs_dir =3D olpc_ec_setup_debugfs();
+
 	return err;
 }
=20
@@ -293,6 +384,8 @@ static int olpc_ec_suspend(struct device *dev)
 	struct olpc_ec_priv *ec =3D platform_get_drvdata(pdev);
 	int err =3D 0;
=20
+	olpc_ec_mask_write(ec->ec_wakeup_mask);
+
 	if (ec_driver->suspend)
 		err =3D ec_driver->suspend(pdev);
 	if (!err)
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index c628d3a47e14..4ccd242fcf72 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -20,7 +20,6 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/olpc-ec.h>
-#include <asm/olpc.h>
=20
=20
 #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
index 79bdc6328c52..7fa3d27f7fee 100644
--- a/include/linux/olpc-ec.h
+++ b/include/linux/olpc-ec.h
@@ -16,14 +16,28 @@
 #define EC_SCI_QUERY			0x84
 #define EC_EXT_SCI_QUERY		0x85
=20
+/* SCI source values */
+#define EC_SCI_SRC_EMPTY        0x00
+#define EC_SCI_SRC_GAME         0x01
+#define EC_SCI_SRC_BATTERY      0x02
+#define EC_SCI_SRC_BATSOC       0x04
+#define EC_SCI_SRC_BATERR       0x08
+#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
+#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
+#define EC_SCI_SRC_ACPWR        0x40
+#define EC_SCI_SRC_BATCRIT      0x80
+#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
+#define EC_SCI_SRC_ALL          0x1FF
+
 struct platform_device;
=20
 struct olpc_ec_driver {
-	int (*probe)(struct platform_device *);
 	int (*suspend)(struct platform_device *);
 	int (*resume)(struct platform_device *);
=20
 	int (*ec_cmd)(u8, u8 *, size_t, u8 *, size_t, void *);
+
+	bool wakeup_available;
 };
=20
 #ifdef CONFIG_OLPC
@@ -33,11 +47,27 @@ extern void olpc_ec_driver_register(struct olpc_ec_dr=
iver *drv, void *arg);
 extern int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf,
 		size_t outlen);
=20
+extern void olpc_ec_wakeup_set(u16 value);
+extern void olpc_ec_wakeup_clear(u16 value);
+
+extern int olpc_ec_mask_write(u16 bits);
+extern int olpc_ec_sci_query(u16 *sci_value);
+
+extern bool olpc_ec_wakeup_available(void);
+
 #else
=20
 static inline int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbu=
f,
 		size_t outlen) { return -ENODEV; }
=20
+static inline void olpc_ec_wakeup_set(u16 value) { }
+static inline void olpc_ec_wakeup_clear(u16 value) { }
+
+static inline bool olpc_ec_wakeup_available(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_OLPC */
=20
 #endif /* _LINUX_OLPC_EC_H */
--=20
2.21.0

