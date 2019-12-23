Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2BC12974D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLWO0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 09:26:42 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:13431 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLWO0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 09:26:42 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 09:26:41 EST
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 0C58F3F719;
        Mon, 23 Dec 2019 15:20:55 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=eBaGpOHS;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lwOSmu6K9FBX; Mon, 23 Dec 2019 15:20:54 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 52D933F6BF;
        Mon, 23 Dec 2019 15:20:54 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id E72401451; Mon, 23 Dec 2019 15:20:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1577110854; bh=EVSdvjDj26Gix+tIhFTyvvE5GErU3GO5VoBVKSCGr7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBaGpOHSK/RfhpoUK84NvRX174ijyj896C0x8fx2SWvy+v/MtILAx/6ja4TmoS4HS
         GJ07Xzw/cvB9FfZ7JKpbuL1CXfiPQnvjAqesaR7MAhKDNkZgCEGYqpH4Y1Hy8IcWql
         kXVfT9ImosR9ig9iHIXGdA2+1tp/UiINGJbr79Jo=
From:   Niklas Cassel <nks@flawful.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [PATCH 3/5] power: avs: qcom-cpr: make sure that regmap is available
Date:   Mon, 23 Dec 2019 15:19:32 +0100
Message-Id: <20191223141934.19837-4-nks@flawful.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191223141934.19837-1-nks@flawful.org>
References: <20191223141934.19837-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

drivers/power/avs/qcom-cpr.c:402:4:
error: implicit declaration of function ‘regmap_multi_reg_write’

Signed-off-by: Niklas Cassel <nks@flawful.org>
---
 drivers/power/avs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index c21882908a66..b8fe166cd0d9 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -16,6 +16,7 @@ config QCOM_CPR
 	tristate "QCOM Core Power Reduction (CPR) support"
 	depends on POWER_AVS
 	select PM_OPP
+	select REGMAP
 	help
 	  Say Y here to enable support for the CPR hardware found on Qualcomm
 	  SoCs like QCS404.
-- 
2.24.1

