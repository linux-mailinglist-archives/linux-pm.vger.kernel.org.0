Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCA3B98FF
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhGAXbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhGAXbF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4456C061762;
        Thu,  1 Jul 2021 16:28:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r16so10774689ljk.9;
        Thu, 01 Jul 2021 16:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SML1OBamr0TUgzCC96aAGiD3deCXhPAv4rbJetyQAzM=;
        b=IVl4qmggU/F0OJSbxuR8b5rdgnnF2Hpwobg881L7bV1B9nrL8btowjGebZq97kShv7
         CiWabSDs8uqP5OXJ+vmBeyRUAThF0xDUrp6gIWSfSZfW9MlOCaO77EJYtlfE1Bq7X6cC
         vvrVYm7Ed9rORzKqvt8fgIJygge7qhV/3L1vrDwmJ3HlCzYcVWq8jAhmp7bbY0dPmf70
         YbwFhNppQyxTZgQchJLBjhQ6g/zbpZAWFYir3PlIecXiGeE87hSP5s7qv9yA+XtmfAAX
         r40TNPhEDEnulL6hSLJLZSzwUXu8N1lh35xIAy3GCas9SYPcT2tfvPcYag6CuHDn9DcM
         MtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SML1OBamr0TUgzCC96aAGiD3deCXhPAv4rbJetyQAzM=;
        b=mAPIt1xxnln/rMOnR0Jnsh1ZU0GyoXRrpICUtqBFAhdZ72OQZN3AtwUmjOynhVVKhj
         GfQmo9j7FZNWxYF1QwQa0zF9prVyMNK8dyhvfcRLK7kF/BVpSghisZoDlHWcmm+XaI7s
         fNM7x1doxVG3yJzCBXlgKZcrJ99w19yceIQEwSGd0wgQv6p1eALZTCGDhchl3+TSJzPG
         DBQCbabh0ZOtz5QF3KGsp3OZIrYSjusG7Ak0xsdJbq4uHylEX5iPcBoEX+1PmiRXlmDs
         psehzalqipA29VhGjUS/nOG2o5vDygDygwA6vFqr8TJWcnpAXDG8YGIFSBVMxBhcjK9+
         0uog==
X-Gm-Message-State: AOAM5321j9lXPeK1RQu/5M2p3x2Ddg4NznkCe0scYjS7lJ9y+gmAYFAZ
        GlF224zSpI4bAXlULuNsJY8=
X-Google-Smtp-Source: ABdhPJxmS6+zpCvM0cX3GmXJWAnU5+svwv9pK0Cei3IR8uUPgR6Mj6rs4PWZBBqHhUChhqTZ3Y3/Mw==
X-Received: by 2002:a05:651c:1695:: with SMTP id bd21mr1480566ljb.316.1625182111068;
        Thu, 01 Jul 2021 16:28:31 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 03/37] soc/tegra: Don't print error message when OPPs not available
Date:   Fri,  2 Jul 2021 02:26:54 +0300
Message-Id: <20210701232728.23591-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously we assumed that devm_tegra_core_dev_init_opp_table() will
be used only by drivers that will always have device with OPP table,
but this is not true anymore. For example now Tegra30 will have OPP table
for PWM, but Tegra20 not and both use the same driver. Hence let's not
print the error message about missing OPP table in the common helper,
we can print it somewhere else.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd33e99249c3..a42d4f98c078 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -111,9 +111,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	 */
 	err = devm_pm_opp_of_add_table(dev);
 	if (err) {
-		if (err == -ENODEV)
-			dev_err_once(dev, "OPP table not found, please update device-tree\n");
-		else
+		if (err != -ENODEV)
 			dev_err(dev, "failed to add OPP table: %d\n", err);
 
 		return err;
-- 
2.30.2

