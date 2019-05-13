Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7E61B19D
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfEMH5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 03:57:25 -0400
Received: from shell.v3.sk ([90.176.6.54]:59027 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfEMH5Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 03:57:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 981DC1041BC;
        Mon, 13 May 2019 09:57:22 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uYwm9noTadyR; Mon, 13 May 2019 09:57:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 935DD1041C9;
        Mon, 13 May 2019 09:56:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZgpmFMjcmnCY; Mon, 13 May 2019 09:56:46 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4BD341041CB;
        Mon, 13 May 2019 09:56:44 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v7 05/10] Platform: OLPC: Use BIT() and GENMASK() for event masks
Date:   Mon, 13 May 2019 09:56:36 +0200
Message-Id: <20190513075641.1277716-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513075641.1277716-1-lkundrak@v3.sk>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just a cosmetic tidy-up.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---
Changes since v5:
- Added Andy Shevchenko's Reviewed-by tag

Changes since v1:
- This patch was added to the set.

 include/linux/olpc-ec.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
index 7fa3d27f7fee..f7b6a7eda232 100644
--- a/include/linux/olpc-ec.h
+++ b/include/linux/olpc-ec.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_OLPC_EC_H
 #define _LINUX_OLPC_EC_H
=20
+#include <linux/bits.h>
+
 /* XO-1 EC commands */
 #define EC_FIRMWARE_REV			0x08
 #define EC_WRITE_SCI_MASK		0x1b
@@ -17,17 +19,16 @@
 #define EC_EXT_SCI_QUERY		0x85
=20
 /* SCI source values */
-#define EC_SCI_SRC_EMPTY        0x00
-#define EC_SCI_SRC_GAME         0x01
-#define EC_SCI_SRC_BATTERY      0x02
-#define EC_SCI_SRC_BATSOC       0x04
-#define EC_SCI_SRC_BATERR       0x08
-#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
-#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
-#define EC_SCI_SRC_ACPWR        0x40
-#define EC_SCI_SRC_BATCRIT      0x80
-#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
-#define EC_SCI_SRC_ALL          0x1FF
+#define EC_SCI_SRC_GAME         BIT(0)
+#define EC_SCI_SRC_BATTERY      BIT(1)
+#define EC_SCI_SRC_BATSOC       BIT(2)
+#define EC_SCI_SRC_BATERR       BIT(3)
+#define EC_SCI_SRC_EBOOK        BIT(4)    /* XO-1 only */
+#define EC_SCI_SRC_WLAN         BIT(5)    /* XO-1 only */
+#define EC_SCI_SRC_ACPWR        BIT(6)
+#define EC_SCI_SRC_BATCRIT      BIT(7)
+#define EC_SCI_SRC_GPWAKE       BIT(8)   /* XO-1.5 only */
+#define EC_SCI_SRC_ALL          GENMASK(8, 0)
=20
 struct platform_device;
=20
--=20
2.21.0

