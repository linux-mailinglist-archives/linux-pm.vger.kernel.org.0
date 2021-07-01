Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12B3B986C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 00:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhGAWHz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 18:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhGAWHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 18:07:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D610FC061762
        for <linux-pm@vger.kernel.org>; Thu,  1 Jul 2021 15:05:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so7795299wms.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Jul 2021 15:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhX2Mg0CbXtX1p2YJNW9DlH0vmyssHZThE9e24bn2XY=;
        b=qC4jcFuA4Bhi55ztsdNvJvQHF+BThtvQZ/ZfIcAISxB+zxH6gb9pQRY6uon4ryIRpS
         pu92MTMmaa31U9CFyNzqZcz6q+9DBf+geiGPEGqL4HbwSgf6xifeBVHsGXTtSBFB8O2I
         yuyQAePWOt1oLJRmauc9oX2dqCMjzReamrH3o2tkx3VLGqu2n4ReyZ6EWPKMypg3m+Ru
         p4u79reBkGJvaw6wQnmoKBFmj1IpbINUTFoPN4eHT1TCsnYrun334Ae2kfndgMVMWWwF
         O8F93iXzVATh5NjtkKHEr/yS4qqBxtOPnfFMBY661SzhEQ617JHqgixfmjzm6OoT5ckZ
         Ed6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhX2Mg0CbXtX1p2YJNW9DlH0vmyssHZThE9e24bn2XY=;
        b=jPC3wsiGlqDh0bGA1VMYXF/arF87wnoPeA5TBnYzXjcfYbHskIGJohWT0OTAQ5To6H
         6MuoJOY2ijUQq090fWMgAfRPNITDkR+4VGASXKDfK0zm7f1Wl8yOYTX22+m24V9F34QS
         aeeU5J/+UcK7vX/giNlZIkxaoj6ZDWnaQc3zowrNAC5saJcIC10n9vETMZxEQnpMT66A
         2BZriMxgrAYx+1cdRidnQuWtnEkeF1YJgHXqeXKP5MwrehGcCwuuDCW5J0RSxooN1T4w
         reEJR9K7EKDEv+ad9uBV+2AM1d8kHcaa9C6F1M2E1cCJhJEjdf2YqrPxMWET2vXCVboy
         lmPQ==
X-Gm-Message-State: AOAM530dKFk6PuYXu9LYh/6Zx/xOPfaIv5m1wgPhJE2FBraVVTkDnPGT
        xK8x+o8ioKFEb1gu+adis94=
X-Google-Smtp-Source: ABdhPJyStxsCl8adctqFcFb3bxlmuTOcQx/p1gHVJNFsRNqOI/pNN5KdOnbTn+NEOw2dEmI8Dbonnw==
X-Received: by 2002:a05:600c:4848:: with SMTP id j8mr1959669wmo.7.1625177122419;
        Thu, 01 Jul 2021 15:05:22 -0700 (PDT)
Received: from morpheus.roving-it.com.com (f.c.9.1.f.e.c.d.1.e.0.0.2.b.5.5.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:55b2:e1:dcef:19cf])
        by smtp.googlemail.com with ESMTPSA id y20sm1097340wmi.25.2021.07.01.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 15:05:21 -0700 (PDT)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] power: supply: cw2015: use dev_err_probe to allow deferred probe
Date:   Thu,  1 Jul 2021 23:05:16 +0100
Message-Id: <20210701220516.2738398-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Deal with deferred probe using dev_err_probe so the error is handled
and avoid logging lots probe defer information like the following:

[    9.125121] cw2015 4-0062: Failed to register power supply
[    9.211131] cw2015 4-0062: Failed to register power supply

Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/power/supply/cw2015_battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index d110597746b0..091868e9e9e8 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -679,7 +679,9 @@ static int cw_bat_probe(struct i2c_client *client)
 						    &cw2015_bat_desc,
 						    &psy_cfg);
 	if (IS_ERR(cw_bat->rk_bat)) {
-		dev_err(cw_bat->dev, "Failed to register power supply\n");
+		/* try again if this happens */
+		dev_err_probe(&client->dev, PTR_ERR(cw_bat->rk_bat),
+			"Failed to register power supply\n");
 		return PTR_ERR(cw_bat->rk_bat);
 	}
 
-- 
2.31.1

