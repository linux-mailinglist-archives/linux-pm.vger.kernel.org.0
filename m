Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF623539E4
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhDDUfo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhDDUf0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:35:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE735C06178C;
        Sun,  4 Apr 2021 13:35:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dd20so3416277edb.12;
        Sun, 04 Apr 2021 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vvpDlvlraOIdoUzIW5H4uGiOSzjTMGPHJIWK4bxYUM=;
        b=C0D7Mbxv9sfBvnKZc4QHHznrU6EKL+tu9rkF+brzwi/syphuHPGTrObh2NG9zfhdSy
         sKOBwfvmsZP4wPz3ydo5PAlKy02rVl9M30qXSCrMzFre1az6Fx29jji0xzVkhi/14Rg7
         j0AFHD2FN5XEXGxsyTjlA6zU2Xd1H+5z24g7jwbYHqQpoSBGgzZD+eTWFAqcLgEVpHcq
         TjFH2Z5/d9CEjUsPVtfbyvf9EUyA72QjhpOYGQmfGSK9w+xds4KxpgB2e5YDkuPlz4bp
         Uc8feYJGYa7Gp+/6JaC8reUf3A/6gHJcwSza948TghvAjWf72LAa4/R/W5gfBWhxCiRi
         /BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vvpDlvlraOIdoUzIW5H4uGiOSzjTMGPHJIWK4bxYUM=;
        b=EBpEB/Ho1hKeGU53U/hXwKsTpOwV1/W4SfOPjuKPe31zPRQgy4SfFdwxXsTqOuOjLh
         eUzncTwm+aHy5KPbic0ouMP4oCcIaNCierpYxPW76xbmcgqQNwf7y5ZvPapTegY3su17
         uygHtpHerF2xHk7Qv96gm7nqWv13/VNB2MET7YE7SPR/dvwt0MOLmIBu0bPNOaFhUqXe
         /cxAGZhCDrdN8dd2JnYbmZeWTmK/ZYAzKgr0PdAd0BybyfO66613dBFSNKts8LbdVpg5
         qhBKpSKsT2Lek9pOPiVARwqUUE3rM8WOGCtWRjagYs/UdmzDUWwJrzS1lG5TuV2ip9yU
         6+og==
X-Gm-Message-State: AOAM531hGgBa7ewnBnwG4QjjFtceabpPwmS9FLFYn9gLotTHyye2DS0T
        r3Gx0KgLhDTXF9tkVydLhSo=
X-Google-Smtp-Source: ABdhPJwqP6atKY9GH9tk0azNO+jfyBYEQdG6uSkhS2+OeQN8Rgury4gCcEGrr0b7TdAk8jkrmd71aA==
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr13398187edv.174.1617568518375;
        Sun, 04 Apr 2021 13:35:18 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-52-251-187.retail.telecomitalia.it. [79.52.251.187])
        by smtp.googlemail.com with ESMTPSA id s4sm7191140ejf.108.2021.04.04.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:35:18 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14 8/9] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Sun,  4 Apr 2021 16:48:22 +0200
Message-Id: <20210404144823.31867-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210404144823.31867-1-ansuelsmth@gmail.com>
References: <20210404144823.31867-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 38b9936def1a..58073dc5d30b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -966,6 +966,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.30.2

