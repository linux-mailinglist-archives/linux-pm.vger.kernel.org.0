Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3AC306BDB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 05:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhA1EFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 23:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhA1EFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 23:05:08 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF4C061355
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 20:04:28 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 63so3998572oty.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 20:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbTyrwsOUFeBKx/wZBbc/RTueffgUmDZNCpk3OrcQUc=;
        b=ChVoei/DhScC9Gpja9dK8cCUFgP0rOt5TK8HXznv4PXif/JHazoXu1SRciZogaw6P+
         8Blg9wNWM945EsmAS9O6UKkFs+gK60+8YUo5VlXoLZXgdBYZe5S4XWFGWhekl4T1+C5g
         ORJJr6EJjq8bU5i/uLm5MZPjnFTKBTgYAytEtl4xt470vwZSiU/Npmc39sCHwqm6/D1l
         ZFXLtuMGqXxEiFf0ZGIsncdF61rMzsruJAS8OV0eUYwScC3taNYDguJAn/rGoJsOFzMS
         MRo0cAw5FAdBKUgFCVxQX4hy1hO1Rd2l6Q31HPmu3IVVvZlGGble7L6Lc90OqOq+1a0y
         3kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cbTyrwsOUFeBKx/wZBbc/RTueffgUmDZNCpk3OrcQUc=;
        b=cxZdf0MgC5qXna07mHRPSR3cUgSS6RtiJGGQGDZznWtNdND+YFg4n8XAk0q0pjROX3
         qIpc80sVO+HZwD48Z8oU1qcmThjuuXTYWNjbayoVOcmooZnaGTG/D5kuiAL0n7L/EJ1I
         I9YSYTTcZz3TYcRByCX2IqyOQrLw1J0xybGlZU5U0NOLMweYnlORSDIebmR3i7u01xv8
         YjC3lWdzPy8mdB5ktISpaGsNAHK8oO4vnvX4ZpiLFXoA5ZegRGWoPNAtZ1LMDav6YGtV
         EAihQtVFGngeDfZbAI07h7crf0cnvhDaC7Wu05ilzFJI7Yib+JDzO5gwUtPzevwNC/Qf
         U1YA==
X-Gm-Message-State: AOAM530b17nrkkG9iiTU1ug+zoQvHyBrDoRydqp7kyNWYP6blx82UUkV
        tepBYJEjEIAwl0KM7p1vrqdsZw==
X-Google-Smtp-Source: ABdhPJxGfqVHUm+2Z5bAjtM7pk9jPcdyIL6KBmg3RYFwdLJHvzNMFduWntEiPNXss68vK/KeFyE03w==
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr9893373oti.245.1611806667872;
        Wed, 27 Jan 2021 20:04:27 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g23sm810745otk.72.2021.01.27.20.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 20:04:27 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] opp: Allow dev_pm_opp_set_opp() to be called without opp
Date:   Wed, 27 Jan 2021 20:04:26 -0800
Message-Id: <20210128040426.953529-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

a6xx_gmu_stop() calls dev_pm_opp_set_opp() with NULL as opp in order to
drop its bandwidth request, which was valid with dev_pm_opp_set_bw().
But after the transition to dev_pm_opp_set_opp() this leads to a NULL
dereference before jumping into _set_opp(), which does disable the
vote as expected.

Fixes: a0d67b94e2ef ("opp: Implement dev_pm_opp_set_opp()")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 583bb1274df9..3ff05f40e443 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1157,7 +1157,7 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 		return PTR_ERR(opp_table);
 	}
 
-	ret = _set_opp(dev, opp_table, opp, opp->rate);
+	ret = _set_opp(dev, opp_table, opp, opp ? opp->rate : 0);
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
-- 
2.29.2

