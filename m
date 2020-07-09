Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067F821AA02
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGIVvt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 17:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGIVvs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 17:51:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3D0C08C5CE;
        Thu,  9 Jul 2020 14:51:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so3021006edm.4;
        Thu, 09 Jul 2020 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7hfnd49qzQu+v3pW4+QTWy4zDs6kHByKCCdtVpj2B8=;
        b=r5h0iFWjZ7yH13ovMinMCtA81sozhr/xHJCZRQYGfsl91fLXkpE1CuLVOxJ1JNIMa6
         5HvQUA6Or0vxyQmrWQsPDrllVOYBZG5miYMMVGZbFfATIuUm+if3QjFPsuxcRUTUVW4o
         uNIUjL/HfLVCikDzSBVX33hnZV9sVtaVIKJbsqWhaWxQWnBT3NXEGIRQ43ZwOG5TwG82
         FqodmZ4y9htxX4Irot9gr8t6kZG1+56A2sSU7hHNTjAbTf3Clvxi8TmXmfRjx6Hg51gK
         D1Z5jWo6nQFHOz080HwvQFzgdJCIrJ3DzTDRkVgRGyyFbluD+leUHJQeP9RvPN/3b/GO
         01Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7hfnd49qzQu+v3pW4+QTWy4zDs6kHByKCCdtVpj2B8=;
        b=Xyidy+WW44el7zOHzjq2DXr8w6TIHp9pFiVkhigFOnGEFjIEQ9U6vozBmWN/LClj3P
         2U+ZO41C4jezmAri4B9ZzucWevRFfPBd1ITHSCEJf46KoRMBKVHgcVz0rPbqMAca3jut
         mNQ3NZKke/7cPwIbwNS6cuqKt8vMpFawRQAu6eRAGqg7nWqvzxe4Mq7URwSp2V9uGNQy
         iXm9ssozeMIyLEzTiCROxgoyasQjj1is60jKEzUb4pWuqadlAAhV5IVusp3nMfEcyeqe
         v+7dP3FfChg860LecjbRTheLw+fSSCwnC913pXQaxdDq8mN16kwRXjjmL11dub+LStGz
         0qFw==
X-Gm-Message-State: AOAM532ErIpcGOHOPEng2bSrWXEjCics5NLGgulucHjNdDEhJSEh+SWY
        iHlX6vE52yi3HjFiCduDRBtyIxMfPcI=
X-Google-Smtp-Source: ABdhPJzTQNAbhhjqi6NgjyNS5C5PZWM2vFRNRRB4kJ09PuTvqqBriaUIP7PlkcdMJTSmRai8ioRf7w==
X-Received: by 2002:aa7:d049:: with SMTP id n9mr69202956edo.39.1594331506867;
        Thu, 09 Jul 2020 14:51:46 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id e16sm2498260ejt.14.2020.07.09.14.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:51:46 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] drivers: thermal: tsens: add ipq8064 support
Date:   Thu,  9 Jul 2020 23:51:32 +0200
Message-Id: <20200709215136.28044-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709215136.28044-1-ansuelsmth@gmail.com>
References: <20200709215136.28044-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ipq8064 SoCs based use the same 8960 driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 39c4462e38f6..2985a064a0d1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -907,6 +907,9 @@ static const struct of_device_id tsens_table[] = {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
 	}, {
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8060,
+	} {
 		.compatible = "qcom,tsens-v1",
 		.data = &data_tsens_v1,
 	}, {
-- 
2.27.0

