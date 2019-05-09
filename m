Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A491947D
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfEIVTg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:19:36 -0400
Received: from shell.v3.sk ([90.176.6.54]:45816 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfEIVTg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:19:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6E0BD10402A;
        Thu,  9 May 2019 23:19:34 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id e6GD6NUekwiZ; Thu,  9 May 2019 23:19:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5F785104020;
        Thu,  9 May 2019 23:19:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9nKtqCLUeS6g; Thu,  9 May 2019 23:19:18 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 95918104026;
        Thu,  9 May 2019 23:19:17 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        James Cameron <quozl@laptop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 3/7] dt-bindings: marvell,mmp2: Add id for the GPU power domain
Date:   Thu,  9 May 2019 23:19:07 +0200
Message-Id: <20190509211911.17998-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509211911.17998-1-lkundrak@v3.sk>
References: <20190509211911.17998-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power management unit on MMP2 is able to gate clock for the GC860 GPU=
,
and maybe more peripherals (unknown -- no data sheet).

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 include/dt-bindings/power/marvell,mmp2.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 include/dt-bindings/power/marvell,mmp2.h

diff --git a/include/dt-bindings/power/marvell,mmp2.h b/include/dt-bindin=
gs/power/marvell,mmp2.h
new file mode 100644
index 000000000000..f773713ef2ad
--- /dev/null
+++ b/include/dt-bindings/power/marvell,mmp2.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DTS_MARVELL_MMP2_POWER_H
+#define __DTS_MARVELL_MMP2_POWER_H
+
+#define MMP2_POWER_DOMAIN_GPU		0
+
+#define MMP2_NR_POWER_DOMAINS		1
+
+#endif
--=20
2.21.0

