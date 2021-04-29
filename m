Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA736E2DC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Apr 2021 03:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhD2BJX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 21:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhD2BJW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 21:09:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850DCC06138C;
        Wed, 28 Apr 2021 18:08:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s15so76573731edd.4;
        Wed, 28 Apr 2021 18:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz76RNUBUiSvgOZlt1STlZAYDVuBfhrQmUmpeHF1XO4=;
        b=IyhSJ1qq0jkoqIUaNzdzRAYr/TUy0nAmc54GPkC9W3tOvMicYGJwgvASzsEYswt44f
         ZU8kiBvE0y1VMOIsWP+ZD/PDzOXzgDGRsfadPKIb4aXrTLD18W3PgjQJ656lUiMBwNPT
         h3loBW6hXZMHUNSRzB357JjuoGLP2GW4fI9HR/kRjzOFVQ1wKUF8LR/Q6TJ8ZNe+88iP
         isHGEAFlF1VN6snMNN7/X72d4e0fGuEY67wCiz68241zrLhTo2wkFvObXTpe24CRg7Iw
         tgPQXDy84Jz1B7+JxpXxw90Wrcj3SSBoqnnTOFn3bdayga2rcDOk6t54Vn1ghepnd9PA
         zDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz76RNUBUiSvgOZlt1STlZAYDVuBfhrQmUmpeHF1XO4=;
        b=IqdbSNKkdOJf3xaMOxRWxrt63xB85Wi0UGEEJq0mptutDr2vInyp+/W22rHaisuDd3
         PnlkHHKAxfnL77OWqH8XIgZoZ/7RyKM2jQklVsMQHDN1S8kUNKF1qyzPrORSMxwm7AVu
         GvUgWavlYgDQnAhBcG6aMCb6pG2ZBdk0tq7ZrWKwuhAkLC+OlgI3kKNRldKiNuJlaGJ/
         pqhY1rfXpt5DYGRfPwGolbqdT41ADOiSqh1yJj5XrChSp9j1LY5Mnge6OmCCS07sM+om
         glTpe7pKghdnw2KPUSf3kM2u7NvmU5R4EYqaufaTBTWvJXQsTC1Um2xCyLeNfWmK+VeJ
         prPA==
X-Gm-Message-State: AOAM532Er2WtICZEzR/QPkRIM8KclJEXRjUSscmhGEID766DUlyVc92S
        Egbekw5l81jxDLxYXRVGTRo=
X-Google-Smtp-Source: ABdhPJwdyZlFKp02dtlraFIRmrjZ2PnufeWBgjKivY0sxvkTvGu9JBL5qmLrNFNr3pImccc4ypKyNg==
X-Received: by 2002:a05:6402:17d7:: with SMTP id s23mr13821160edy.66.1619658513961;
        Wed, 28 Apr 2021 18:08:33 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id d5sm1113398edt.49.2021.04.28.18.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 18:08:33 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [thermal-next PATCH v2 1/2] thermal: qcom: tsens: init debugfs only with successful probe
Date:   Thu, 29 Apr 2021 03:05:17 +0200
Message-Id: <20210429010518.13319-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210429010518.13319-1-ansuelsmth@gmail.com>
References: <20210429010518.13319-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

calibrate and tsens_register can fail or PROBE_DEFER. This will cause a
double or a wrong init of the debugfs information. Init debugfs only
with successful probe fixing warning about directory already present.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..b37d5fd71f3a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -845,8 +845,6 @@ int __init init_common(struct tsens_priv *priv)
 	if (tsens_version(priv) >= VER_0_1)
 		tsens_enable_irq(priv);
 
-	tsens_debug_init(op);
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
@@ -1057,7 +1055,12 @@ static int tsens_probe(struct platform_device *pdev)
 		}
 	}
 
-	return tsens_register(priv);
+	ret = tsens_register(priv);
+
+	if (!ret)
+		tsens_debug_init(pdev);
+
+	return ret;
 }
 
 static int tsens_remove(struct platform_device *pdev)
-- 
2.30.2

