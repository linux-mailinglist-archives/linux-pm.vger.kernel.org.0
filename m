Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0C12972F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLWOUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 09:20:51 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40188 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLWOUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 09:20:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id DF6FC3F75F;
        Mon, 23 Dec 2019 15:20:48 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=OQo7slig;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QFDBZ42vUjD2; Mon, 23 Dec 2019 15:20:48 +0100 (CET)
Received: from flawful.org (ua-84-217-220-205.bbcust.telenor.se [84.217.220.205])
        (Authenticated sender: mb274189)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 105483F72C;
        Mon, 23 Dec 2019 15:20:45 +0100 (CET)
Received: by flawful.org (Postfix, from userid 1001)
        id 5032F1451; Mon, 23 Dec 2019 15:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1577110844; bh=QxU7dQ1hA9pBBbft+aq6Xdh0G5XZTnumkFMlEkTba08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQo7sligqJUEI4PGsaW+eJXyktnuzNJUo4aGW4+wpu7vdLPL4a+kCMLbCMAietd1r
         WEz0ozHtvbIwLgd+l4godkebBHXYlH4BOt7xQCm2yu0Mvo1ybUvhbY7u9TEPmYrduf
         urtODC5psM9B7y7a1K3V7lIc7OywBGC951L/tc8s=
From:   Niklas Cassel <nks@flawful.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: [PATCH 1/5] power: avs: qcom-cpr: fix invalid printk specifier in debug print
Date:   Mon, 23 Dec 2019 15:19:30 +0100
Message-Id: <20191223141934.19837-2-nks@flawful.org>
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

drivers/power/avs/qcom-cpr.c:838:15:
warning: format ‘%ld’ expects argument of type ‘long int’, but argument 6 has type ‘ssize_t’

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Niklas Cassel <nks@flawful.org>
---
 drivers/power/avs/qcom-cpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index a3187973bbb5..a52d2cef1300 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -835,7 +835,7 @@ static int cpr_read_efuse(struct device *dev, const char *cname, u32 *data)
 		*data |= ret[i] << (8 * i);
 
 	kfree(ret);
-	dev_dbg(dev, "efuse read(%s) = %x, bytes %ld\n", cname, *data, len);
+	dev_dbg(dev, "efuse read(%s) = %x, bytes %zd\n", cname, *data, len);
 
 	return 0;
 }
-- 
2.24.1

