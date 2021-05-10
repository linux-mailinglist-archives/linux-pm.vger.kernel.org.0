Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB303799B9
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 00:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhEJWKh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 18:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhEJWKg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 18:10:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD96C06175F;
        Mon, 10 May 2021 15:09:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a2so4658222lfc.9;
        Mon, 10 May 2021 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DL2m5cGSzenHZYyzVc1zRqz7veWJz1V6YDyNEMjnPOM=;
        b=cMRTmTkFUEX5YA8DdYrOZj/TlrRyxftNaL1SShCZOjdJ91tmiy9kzLemzCocvv4eJa
         0YltFrh5/dAdlkZD8wBHItu9hun9rwPQddWDLGJmsPTuMNKfrH4S05gLdhdQ24G8EZhr
         moWEojgJobsi8IXm3Y29nVb3TAL8FCwZ2kWfy0Eh8shHBvwud+g+4Uu8MoKq107dTHRr
         qT1tYDWiUrgdTG6YJfAv3WCCn/2flfvG+5isvzbRflrq6aeMfhXNXQlz8DlT38G17gbj
         ud6PkhuclE1uayuWvgor6iDZTiOH4oQ8yQpco/N/o8368Qph1fIRBclzlC+9psPLC4HZ
         bHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DL2m5cGSzenHZYyzVc1zRqz7veWJz1V6YDyNEMjnPOM=;
        b=eGwFvAZby1Q6m5XKaFhxKWJiBDPc65jQe4/lODLFt4cmHL3VWRaWCuwxE+Rbp3Vcty
         xFCXmW4hB+SS8RnxF2G+eOHcIqqx4Yg5cf9Gy8Ns2XEDBsk2T2NDyo44n1Old2lNGp97
         QKibT6rmq8q6Q/mfq8IqUG8nvmiuV5B2AHU/1w0HMLdqNHbLtq5GGKVXGug5cG1Ot+XS
         mkkkh7rydvNMCsrgaFqDsfAWonnq5hDOh70ZqEo1s/bj8fftusqUGtre2CwZCadSlkEV
         WZ//lfDIeCdPK8f2JCGSqDyNvqgpCYPSimbnwMtahyy7h82cQGKQ3OU2LyzqRFN+0wvE
         m1iQ==
X-Gm-Message-State: AOAM53193+Oa0SaQOE3MzlDgGEB/TDueSyGJvmYJagpo1nDhh/s6u02/
        jyYp5NgvLygKW361k7oNbiJR7vO3dSY=
X-Google-Smtp-Source: ABdhPJyTZq4wwg1BAFI5gRI5StWdqqAbGj2wkgv//edRaFerxIvNMzzO83a3y2DbUA5YG2MmdKDBLA==
X-Received: by 2002:a05:6512:31c2:: with SMTP id j2mr10980517lfe.69.1620684568613;
        Mon, 10 May 2021 15:09:28 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id y5sm2381479lfa.148.2021.05.10.15.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:09:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] power: supply: sbs-battery: Fall back to Li-ion battery type for bq20z75
Date:   Tue, 11 May 2021 01:08:27 +0300
Message-Id: <20210510220827.11595-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510220827.11595-1-digetx@gmail.com>
References: <20210510220827.11595-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The older bq20z75 controller doesn't support reporting the battery type
and the type is Li-ion in this case.

Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # TF101
Tested-by: Nikola Milosavljević <mnidza@outlook.com> # TF101
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index b71fbf543428..fec6c139d4ff 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -813,9 +813,17 @@ static int sbs_get_chemistry(struct i2c_client *client,
 	else
 		val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 
-	if (val->intval == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
+	if (val->intval == POWER_SUPPLY_TECHNOLOGY_UNKNOWN) {
+		struct sbs_info *chip = i2c_get_clientdata(client);
+
 		dev_warn_once(&client->dev, "Unknown chemistry: %s\n", chemistry);
 
+		if (chip->flags & SBS_FLAGS_TI_BQ20ZX5) {
+			dev_warn_once(&client->dev, "Falling back to Li-ion\n");
+			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.30.2

