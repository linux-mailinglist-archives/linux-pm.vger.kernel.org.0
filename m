Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94C64249FB
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhJFWof (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbhJFWoe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 18:44:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6CBC061746
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 15:42:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y26so16794948lfa.11
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w74AS8bsnQBpuPJtXKLsNk6KYmEVqK2eVVFusa1JBP4=;
        b=UB0sVHc98SgQxmoowCS/iRCeO8WO6MRXYF1U0P68CbWbbz7CUnWacOqRdRwoq29V8A
         y9ZsPGGwzPBsIuvd+/JKiKyzpcKOchR8U3dvs02vI05oPYc7Fud9rBmwv3hJpRejUNfH
         BaPhOGo51VdmJxrrLJXQSGOkfwdSZKX5cXh5FSwdjlUOtThTAKUIpU3bWQkORxmcqCvv
         Y5DNCaTsj/tb44R1UUSfFr+mQKgWu/FzttgFGie295lv5vfa8NyCEX65njIkEt/kLh2w
         BumcIKzLqLdtl2sGE2HeopE4Lx495rHKoHYnJw0sDD8NkEU+kuzjThcYNpTxO1LKAbBJ
         At0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w74AS8bsnQBpuPJtXKLsNk6KYmEVqK2eVVFusa1JBP4=;
        b=45fekhDLTFJ8o83h3NR8G2t8l1SVgAhMlIxY2AnppiDMKKoSqZ5NDy5AobSS7zoVtL
         0BU0yXWxJZg3fT9eXzyIEMYqt7e4f1jIakwnFxcVuH12TKIy1gk9d5twWraIGy1Aubkd
         TrmWDJa3Smv2YqlASSVhqTSaAlDmpfd5Z1jZr4cEgR4r+dbF+C5L7TgrF4uq78os2Ez9
         DSBcDK9d4gSeNSZh4X8gG1Vow3Eoh08sjVYWNsAQ/xKmeyFXA0JFiUkHNkTCyWhqhzCd
         agCzKjkupgkq5nclUcmBNIztB4GCd2YxydE4fTWzRVqQzQenuZ780PVzwLAyPjt5v9Hs
         1A6Q==
X-Gm-Message-State: AOAM532nvXNJC6TtvfQf2UwNMypqcCGaxpe4ULLkA4X+laCEccuvA0Nv
        BdVwhxP2P4vqFwX7uZBS8tzXqmBPbFWQ4g==
X-Google-Smtp-Source: ABdhPJyna9uGfd/nPlWr/xg5wILA52+JFyIJaH4n88bGDLjvRqaOGC5zJ1loeCg1K8AZbEgkRqUxFw==
X-Received: by 2002:a05:6512:3ed:: with SMTP id n13mr670775lfq.282.1633560159592;
        Wed, 06 Oct 2021 15:42:39 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g7sm2368103lfc.123.2021.10.06.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:42:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] power: supply: ab8500_bmdata: Use standard phandle
Date:   Thu,  7 Oct 2021 00:40:07 +0200
Message-Id: <20211006224008.394191-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006224008.394191-1-linus.walleij@linaro.org>
References: <20211006224008.394191-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Look up the battery using the "monitored-battery" phandle
as is nowadays a standard DT binding. The actual bindings
for these charger elements are not upstream so let's sort
out this mess by conforming to the standard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on v5.13-rc1
---
 drivers/power/supply/ab8500_bmdata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 6f5fb794042c..bfc1245d7912 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -497,8 +497,7 @@ int ab8500_bm_of_probe(struct device *dev,
 	const char *btech;
 	int i;
 
-	/* get phandle to 'battery-info' node */
-	battery_node = of_parse_phandle(np, "battery", 0);
+	battery_node = of_parse_phandle(np, "monitored-battery", 0);
 	if (!battery_node) {
 		dev_err(dev, "battery node or reference missing\n");
 		return -EINVAL;
-- 
2.31.1

