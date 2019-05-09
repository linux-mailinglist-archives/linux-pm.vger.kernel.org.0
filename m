Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 689171947C
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEIVTf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:19:35 -0400
Received: from shell.v3.sk ([90.176.6.54]:45809 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfEIVTf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:19:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E5AF9104029;
        Thu,  9 May 2019 23:19:32 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id We7yaFsnBu8b; Thu,  9 May 2019 23:19:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 90253104024;
        Thu,  9 May 2019 23:19:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 88RNB5lrXCgV; Thu,  9 May 2019 23:19:17 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C1B53104020;
        Thu,  9 May 2019 23:19:16 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        James Cameron <quozl@laptop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 1/7] dt-bindings: clock: make marvell,mmp2 a power controller
Date:   Thu,  9 May 2019 23:19:05 +0200
Message-Id: <20190509211911.17998-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509211911.17998-1-lkundrak@v3.sk>
References: <20190509211911.17998-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a binding for the MMP2 power management units. As such apart from
providing the clocks, they also manage the power domains.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/clock/marvell,mmp2.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt b/D=
ocumentation/devicetree/bindings/clock/marvell,mmp2.txt
index 23b52dc02266..0387348f7211 100644
--- a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
@@ -13,7 +13,8 @@ Required Properties:
   "mpmu", "apmu", "apbc". So three reg spaces need to be defined.
=20
 - #clock-cells: should be 1.
-- #reset-cells: should be 1.
+- #reset-cells: should be 1
+- #power-domain-cells: should 1
=20
 Each clock is assigned an identifier and client nodes use this identifie=
r
 to specify the clock which they consume.
--=20
2.21.0

