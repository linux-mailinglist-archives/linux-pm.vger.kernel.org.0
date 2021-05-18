Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2D388345
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 01:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhERXog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 19:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhERXof (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 19:44:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E4C06175F;
        Tue, 18 May 2021 16:43:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id et19so10136779ejc.4;
        Tue, 18 May 2021 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5mKTMQmxEVFJG8UOfkeKjZ+h743hA9emYKF3Ch8SzM=;
        b=XIpq0m+V4Kvo9Ej7/M6YyR98UcXaTrp/mTf8JNnAN+EGZwNNulqKY6fo8XLO66l0VP
         gvTJLz1KmoKzjAEk9TXjtlGrCV4HMiomWhFsWZJIdg/yqAEzyeWw8bSV6bEeV6Ph1hCb
         sf4WrA6g4Sbl+2QyxosI80l9oPiW8r4IM3P4F30fv77JLXWTJlbU+eqGhdcszuxD+mb3
         s16ni4x2KSH6JYogXmm+SEcvOY9zZLxQ1H3r+xohtR9pmQ9tPi8XkapXWid2ThJ/w99F
         yQTBZwXCDmsEkzsdnn5Ak6UgRd4n0yNdvu5sUNfmRNN42mSZNru4+31217jsn1dqTBt/
         VWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5mKTMQmxEVFJG8UOfkeKjZ+h743hA9emYKF3Ch8SzM=;
        b=rX2Fvp/IMPCPrBTd2xIGT6NV5bSsFnWTBWo0wBt0UvndNJ64p8q56Ygs4IpPD00wJW
         2YeRl9zCQV6gwF5cI0aqLG/CICznWsfeZDFt6Oxt28n1HUPlGWpXTmVa0M6tv2pV+9uh
         y/DfEpY5iPkLL8tJg27aYahloSOe42kbtUDTtTCuKH+8OR/O671sMHi8/cPHaK5+LbMq
         ziKrGixm9vhXG4k3op5XCvXPp52JciEpXVMigiPq+MxrMdnzF97ouoMVia7mPaWXMdXN
         l8tvHEDEB6pnSUb7/OliSWHjLbNRE1DupnF6fRbn4qJhlOmeyT8hz2k79NL5vEahhWit
         y8Cw==
X-Gm-Message-State: AOAM532Th2Twf3U9XHhbDfK5lidKHpy7vFSoUK24Wz5NFb6CVSjZXsWb
        uzaKBJTfxhF63rsens+zcIk=
X-Google-Smtp-Source: ABdhPJwLjEeb02TK5+29ocCxmFtlOrcQuMOqbIE3NW9M9jU2buYnEUOgFH8TjPLadgSpKXAnA2QzDQ==
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr8545634ejb.91.1621381395319;
        Tue, 18 May 2021 16:43:15 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id bm13sm11220567ejb.75.2021.05.18.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:43:14 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drivers: thermal: tsens: fix wrong check for tzd in irq handlers
Date:   Wed, 19 May 2021 01:43:08 +0200
Message-Id: <20210518234309.29014-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518234309.29014-1-ansuelsmth@gmail.com>
References: <20210518234309.29014-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some device can have some thermal sensor disabled from the factory. The
current 2 irq handler functions check all the sensor by default and the
check if the sensor was actually registered is wrong. The tzd is
actually never set if the registration fail hence the IS_ERR check is
wrong.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4c7ebd1d3f9c..b1162e566a70 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -417,7 +417,7 @@ static irqreturn_t tsens_critical_irq_thread(int irq, void *data)
 		const struct tsens_sensor *s = &priv->sensor[i];
 		u32 hw_id = s->hw_id;
 
-		if (IS_ERR(s->tzd))
+		if (!s->tzd)
 			continue;
 		if (!tsens_threshold_violated(priv, hw_id, &d))
 			continue;
@@ -467,7 +467,7 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 		const struct tsens_sensor *s = &priv->sensor[i];
 		u32 hw_id = s->hw_id;
 
-		if (IS_ERR(s->tzd))
+		if (!s->tzd)
 			continue;
 		if (!tsens_threshold_violated(priv, hw_id, &d))
 			continue;
-- 
2.30.2

