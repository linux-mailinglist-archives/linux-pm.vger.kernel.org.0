Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063BE6518FE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLTCr3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiLTCr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F513D65
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:26 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z26so16560915lfu.8
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ms1zUNlDRsohNrXvw0gNoQaDLt0r2JwKikY8Nms/5Pg=;
        b=kRooxlmCt/VjLbn5kXtyZKyPGe5+A3FDiF+jq65Tdgmhbe+UCcE63dQ7X+WB5QoYRg
         9polnWe/Qp1zCb1Ukd38mrBDIKIxBFREoxY1xcfHE0jWFlIHZKEgdhI/bNMuUKVDzBub
         GFSWoiSCcnMQgq1VbJbR+/kC72w6JTByeAm0k52kCyKc9fk4wBA1dYk2Km1pJCxSEtgi
         taU1VXe4B03su4JXTnLjP5JwZb8ngkRH3//8Kljn4cF+c0/J1CsAYV0FqGd8v/RgCQrr
         MmNfl6u9jANde8tBC8IoCuuzLdB7cYeInXW5Qx6kCKI50hdZuPsbVJuXjxXoMAPWOmEx
         WWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms1zUNlDRsohNrXvw0gNoQaDLt0r2JwKikY8Nms/5Pg=;
        b=wZttzORWn7T50kv5Y3PP43Nz51V6rv/OA7NRPlOrA5nyLC77BXxicK5oRRRECHPrTz
         4Zi01Lld72thFwh+cuLtVyMECWrtNch/Yd86fA7Kmth9oReWCaM81mZSxj8+QysawORr
         URAqd4bqkngcu9hmkOoA99Zwp7X7O86MRA961CqOF2wMFMiKfY0YnCCFCEBuTQ/wBYfn
         5P96U0WPaRI6DYp2/w8aX3ZkpDY2FVZzsr8artpGimjitm8VfyfQ/Zbk4AuaP7zeri/+
         /HK5oB5a/iBzNw85ajFowdtBlKt0NbGHK8FX+DXul1LhmQHoplYI90acX1+jNa7JOsm6
         8Qwg==
X-Gm-Message-State: ANoB5pmLIddYTjAl9o84NN3ihS5tBXXEbVmBw06gxIr9eLC+DDGzq8nM
        H7kzXT0TN3ujWErZNaTILcb4DA==
X-Google-Smtp-Source: AA0mqf4yjU9amk5WZAyYKV+jkCrn8WwniNKlWzMxdJXpdLB/Q3UrJzXfkLS4i0W6kekMcPYdSTbBng==
X-Received: by 2002:a05:6512:1599:b0:4b6:f119:c820 with SMTP id bp25-20020a056512159900b004b6f119c820mr10407208lfb.40.1671504445926;
        Mon, 19 Dec 2022 18:47:25 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:25 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 04/15] thermal/drivers/tsens: Drop unnecessary hw_ids
Date:   Tue, 20 Dec 2022 04:47:10 +0200
Message-Id: <20221220024721.947147-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tsens driver defaults to using hw_id equal to the index of the
sensor. Thus it is superfluous to declare such hw_id arrays. Drop such
arrays from mdm9607 and msm8976 data.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 1 -
 drivers/thermal/qcom/tsens-v1.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 04d012e4f728..0bc4e5cec184 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -635,7 +635,6 @@ static const struct tsens_ops ops_9607 = {
 struct tsens_plat_data data_9607 = {
 	.num_sensors	= 5,
 	.ops		= &ops_9607,
-	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4 },
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 1d7f8a80bd13..96ef12d47bff 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -387,7 +387,6 @@ static const struct tsens_ops ops_8976 = {
 struct tsens_plat_data data_8976 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8976,
-	.hw_ids		= (unsigned int[]){0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
-- 
2.35.1

