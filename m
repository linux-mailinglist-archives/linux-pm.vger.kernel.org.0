Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC82670D6D1
	for <lists+linux-pm@lfdr.de>; Tue, 23 May 2023 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbjEWINT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 04:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjEWIMo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 04:12:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4419E1FC2
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 01:11:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30a892c45c4so1708932f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684829473; x=1687421473;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGUDGH7rhz14YCB1cVpAZLKAtrf81F9TTztogU96Cm0=;
        b=EvnGzmJUPfQ8KdtpEigUXryImN6v0v/3K7eIiy7Ar6Nv7RtCwMROvVxOUOAALvft7s
         g8flhowqXn1kaqGSjamvwA16iTu8BIR29qrnUQ5Fx0hXpDWI19+U9rDrOt6ZXpV4it2n
         xVjPiehnMvYulSHcDUNmztqZM0+ImwrMimMPE7o/PoAlvyI6+GFbKjVO2nJmimvP3Tkr
         EHHixinnO8VmqTlKt1jOKf2yfsNJLFO1ohhWiLvvbK32GmG0zLTnU9f8EXj+zORGCq33
         0pO/LtCHjw9Ycy1k2km2jN8HMHCTGBcrZDmFyxAB+lMMu6MRjtRcEFsT/RVgpR7ZnqeG
         rsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684829473; x=1687421473;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGUDGH7rhz14YCB1cVpAZLKAtrf81F9TTztogU96Cm0=;
        b=Nh9/3mXRUoyVk/vaqi9muTNvaen+T5uZR/GtoRYys7StUcIB3moAv+Nh+qeKvmq1gQ
         QdfK6kxGlX06TxFjnnuTytoDH//xaQeWlbj3vxfzRLCnTti9mTrZwnJhWfUvU0PBD5+M
         QTWUIBjvtZfx9N5jf2HxIECNCjYTv/gnYfYRW2egSSVIFDOGY9Xzk8qcH4JJWd6m9WwM
         MeXXcFXj+K5B03iWbaH/rVBG9eMAztSGeYTkpVQrxumxUNw+/f5FeNQKX0YXEdZPVBaG
         TJVsffIiw1+6JTyEKgqIgsxSR0OBbDqds66x6388xCwua/Xxg+Iu0X+JVpb27fTGzxin
         4zuA==
X-Gm-Message-State: AC+VfDzY7E8GU4yYkmnbMyvO9KbKrBLxvsLX03XIktEjiQSbtOa1tUTX
        mZLMWS9aM3rL8f2SOWQPOnFznQ==
X-Google-Smtp-Source: ACHHUZ74BDXgDTVesfh4PK5yfNReO97zBxk9tr7IB8NXqFzhBagMkPdIOkquK4+vZRWk9dR79qOjzQ==
X-Received: by 2002:adf:f1ce:0:b0:306:64b7:5413 with SMTP id z14-20020adff1ce000000b0030664b75413mr8935653wro.71.1684829472945;
        Tue, 23 May 2023 01:11:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d62d0000000b002fb60c7995esm10343562wrv.8.2023.05.23.01.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:11:11 -0700 (PDT)
Date:   Tue, 23 May 2023 11:11:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] interconnect: qcom: rpm: allocate enough data in probe()
Message-ID: <a0f6184c-c2b5-4e8d-9b8a-867ae83f3094@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This was allocating "sizeof(qp->intf_clks)" which is the size of a
pointer instead of "sizeof(*qp->intf_clks)" which is the size of the
struct (8 bytes vs 16 bytes on a 64bit system).

Fixes: 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface clocks")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index f4627c4a1bdd..7a21a03a0382 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -436,7 +436,7 @@ int qnoc_probe(struct platform_device *pdev)
 	if (!qp)
 		return -ENOMEM;
 
-	qp->intf_clks = devm_kzalloc(dev, sizeof(qp->intf_clks), GFP_KERNEL);
+	qp->intf_clks = devm_kzalloc(dev, sizeof(*qp->intf_clks), GFP_KERNEL);
 	if (!qp->intf_clks)
 		return -ENOMEM;
 
-- 
2.39.2

