Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711E661E6E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfGHMdG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 08:33:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39819 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHMdG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 08:33:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so8214791pls.6;
        Mon, 08 Jul 2019 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cntnp9SEPAH6TMjcFYHFy/Dtz76FraqpSedF+U7vCtc=;
        b=Jp/gP13MfHrbwP0SyRCmDqy2TfkvrRrQhmHTO1KMNY/VkcSUq9q2C4vlZgUouoMxLF
         2Rd082mZZGkgNUF57FXDCSe9U/z2qsim4x5xM4yuQeSRMDpzeQVRh4uqEx7+jmbvqsBC
         LR+Q0qbIZB72jfeHkMrr296f3qNkMs4wzZRcvQPBnfeAVJ+RwxyxsWUpS/DphJ2sCkCf
         Y5/0uQe93AGCM2bHxjpubd64BFxufURbqkJwOzQwT/DXTPLLbszKEnYdTqNY3hlQ4yyN
         1eGGLRuhq3MTmoUKp9ksibnlduTZDVn4c4M7tbjaoG/5KNKDkJOIWYJGVUUsiYUjvHtk
         avNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cntnp9SEPAH6TMjcFYHFy/Dtz76FraqpSedF+U7vCtc=;
        b=DLceoynVCHPUSfKND+8YQhnYXibtpDPbfbZIFr8q2r8YwF5Zfo0E4Sd/jYDG1eS+2B
         ALofk8oanwPOm0aj467mbtHBXX+rysAHIs+mqQWYkGB0W0AWTOQcxibhXZ/IwRr8Q1cU
         ybYlTZtVS3Xf9EHelqvOd6dCeFAGRnn6On2N9FxiYMTdGEYTKuCSsSDgPKS6L4pE9wCP
         /pDXFOZ+t/pf8FbcngF607CuS6PAY4+WOnZJrDIofT7x9oaq/taL4djsvu4Aak+xxpga
         0TW6c86QJbSLArpzN5alwjlJsaAmXe5f62mZeCATrzNtLjxUz+2bXvkbhqb1fQc4/OO8
         P7mg==
X-Gm-Message-State: APjAAAWRDWIM4JK/0u6QsysDdFzoIjxdrKXkBPp6PAy3GsU6yIve2wBb
        s5aOZo1ik2ZSumfL51zvMBU=
X-Google-Smtp-Source: APXvYqzYWjFP+nhZ470GYs56Hyj6CIw1WicGs+mdOLgv7qbpWHyytpIcf6Zz2U/mY84c7QAcuslyYw==
X-Received: by 2002:a17:902:2a27:: with SMTP id i36mr24118599plb.161.1562589185682;
        Mon, 08 Jul 2019 05:33:05 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id w12sm19354724pgp.56.2019.07.08.05.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:33:05 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 04/14] power: supply: sc27xx: Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date:   Mon,  8 Jul 2019 20:32:59 +0800
Message-Id: <20190708123259.11805-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

devm_add_action_or_reset() is introduced as a helper function which 
internally calls devm_add_action(). If devm_add_action() fails 
then it will execute the action mentioned and return the error code.
This reduce source code size (avoid writing the action twice) 
and reduce the likelyhood of bugs.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 9c184d80088b..58b2970cd359 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1023,9 +1023,8 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action(dev, sc27xx_fgu_disable, data);
+	ret = devm_add_action_or_reset(dev, sc27xx_fgu_disable, data);
 	if (ret) {
-		sc27xx_fgu_disable(data);
 		dev_err(dev, "failed to add fgu disable action\n");
 		return ret;
 	}
-- 
2.11.0

