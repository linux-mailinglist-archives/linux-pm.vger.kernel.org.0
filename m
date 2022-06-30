Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844D9561220
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 07:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiF3F61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 01:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiF3F6X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 01:58:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7415EB5
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 22:58:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so1787827pjl.5
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 22:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=VS39FgceRCVipIQogedEwFgAvy76jT2W0c4CCyo+PPlTZ+QmI4LuhhM5ya3OhUWgWF
         QPvSs0x8ZBrkGUEbnsTwwk+hTcepX62ot6CeQYGJa4CGvLU+DCyb8NimPa/IrxPKfKc2
         biY1yU6Ik/GLFoi7O2JpRFUigsurzegwUbhqweNzdN84a6ZP+z1zEm7OPxlMocj3ZayL
         kPm3w/mh3QkHZvUL74aMKZcdARNsvXczHQbrlgZplcslom4R9KZ1S/ab7tJPyIGnxFA0
         /2EPSY2vue/DvhZYkKbi76YVmTfYQfvXoPQ3BE7kumPvexU6GeJHZtmxqmZm6Wk3Fx/l
         l44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=Sy56Iy7PDJPqMVP9lQi8TA+U8WIDUIhzDzzEsOg/Akb1fSS9/3dzirWXVOwYGAlHAg
         0bi3CSARmmuocrwB5uwn4nFTQtLJ9WYGrn6CT020i3RFvpV8PB0+Nm0Ms/G3b9Yyqy67
         aBkiDYHLrzhVX7aWmMEIHXkLt5Mxa63op3dvqUx9w4O1u+u65RysDUrNQ60LZYVaHCeC
         M6CT4fCJNw5IkesvSaiIy/EmP9+nhssQliX8i1Az6iMxBrIBAgOTpL+dOVKYfXTAoBpz
         WqT9dlFGN6w/gB3oGJP+HwIyZKJrajQshCSa4EeaYRtl6y0HiVStGaq0EimzL1uhwR6n
         1vBw==
X-Gm-Message-State: AJIora98Om5V55SIDtOYcDJRA7q7j+hpsIuhSXIRN/cOv0i6TuXr6CLr
        jamSdPxdQTzJPE9Qw9VixhD0UQ==
X-Google-Smtp-Source: AGRyM1tnxFIiHLBlvCMuIDhD6msTNejBsQvf+bkwYfMoJ42aiYgUpwvzjCg/xjcSPx12/zKVCAfeQw==
X-Received: by 2002:a17:90b:248b:b0:1ec:9869:59a0 with SMTP id nt11-20020a17090b248b00b001ec986959a0mr8110417pjb.37.1656568698192;
        Wed, 29 Jun 2022 22:58:18 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090a550e00b001e31f4cc977sm3309288pji.56.2022.06.29.22.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 22:58:17 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 3/5] interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
Date:   Thu, 30 Jun 2022 13:57:20 +0800
Message-Id: <20220630055723.704605-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630055723.704605-1-leo.yan@linaro.org>
References: <20220630055723.704605-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit changes to use callback qcom_icc_xlate_extended().  This
is a preparation for population path tags from the interconnect DT
binding, it doesn't introduce functionality change for the existed DT
binding without path tags.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 7e8bcbb2f5db..8c9d5cc7276c 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include "smd-rpm.h"
+#include "icc-common.h"
 #include "icc-rpm.h"
 
 /* QNOC QoS */
@@ -414,7 +415,7 @@ int qnoc_probe(struct platform_device *pdev)
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
 	provider->aggregate = icc_std_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	provider->data = data;
 
 	ret = icc_provider_add(provider);
-- 
2.25.1

