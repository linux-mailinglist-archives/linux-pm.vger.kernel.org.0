Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5396EE90AA
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 21:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJ2URd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 16:17:33 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37012 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2URd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 16:17:33 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8F6A88365D;
        Wed, 30 Oct 2019 09:17:30 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1572380250;
        bh=1NDB38j3F4cCSGI+6V0EArx27d0tCRp4xDSgyfevY+8=;
        h=From:To:Cc:Subject:Date;
        b=FwMCU2xprN9SGMSh14m+pL4coCpiJMApawe2YLBx+Od6K7S5Y/xI/FM00wfiiTXKR
         3rTvK4qW5loQH9anCmTMRKs7LaS8KgrOvyQIayz4Q7giwudqDBLUnKmlr4AiqgefMq
         bQl6RmGnT7Oqd/er3rPUS+FRJt3d6BuKVOKxsECqq/6h/TIcrgxeucVNdRxY8dEY24
         6LQDG3YluaXNDAsbxORSNUIEM2GJ9EzxDkfA3kzEmUEfZnhUv2N0p5Ijx0UVeFQnXx
         sX9CClS/06+JYDKYxngxg0yMO03y1a5ngtAR7Mnb5h+gNE+Cp2UIx06cPz7ZwRUEW/
         5yh1Qp83veXUg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5db89e580000>; Wed, 30 Oct 2019 09:17:30 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id DEB2513EED4;
        Wed, 30 Oct 2019 09:17:28 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D0A4728005C; Wed, 30 Oct 2019 09:17:28 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2] power: reset: gpio-restart: don't error on deferral
Date:   Wed, 30 Oct 2019 09:17:26 +1300
Message-Id: <20191029201726.12786-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Don't generate an error message when devm_gpiod_get fails with
-EPROBE_DEFER.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - use PTR_ERR_OR_ZERO() to avoid excessive PTR_ERR()

 drivers/power/reset/gpio-restart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpi=
o-restart.c
index 308ca9d9d276..5466eeea261c 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -64,9 +64,11 @@ static int gpio_restart_probe(struct platform_device *=
pdev)
=20
 	gpio_restart->reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL,
 			open_source ? GPIOD_IN : GPIOD_OUT_LOW);
-	if (IS_ERR(gpio_restart->reset_gpio)) {
-		dev_err(&pdev->dev, "Could not get reset GPIO\n");
-		return PTR_ERR(gpio_restart->reset_gpio);
+	ret =3D PTR_ERR_OR_ZERO(gpio_restart->reset_gpio);
+	if (ret) {
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get reset GPIO\n");
+		return ret;
 	}
=20
 	gpio_restart->restart_handler.notifier_call =3D gpio_restart_notify;
--=20
2.23.0

