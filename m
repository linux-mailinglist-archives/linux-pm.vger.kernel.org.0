Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D36DCBE9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDJUAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDJUAV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:00:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A01FCE
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:00:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e20so6108953lji.6
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681156816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKRal6B5cFjvfNLZnlDYPlfZqeycJ2Ag6YtWR3USaN4=;
        b=P0iaqi+sXRHVJpVW5FVejsNal4iFABhX3Kbx0GLK9SUxiLP86eIWpa8KyXXf4RRsqz
         GplydGpC3R2YNJSs7MZbLy4bDn6uZdGf+FAUSLNpdCvm3bditKBymkzH0fT2lU/AB4pM
         88jyrJ+EGkhdr2eTpYA2qvic581BXXSk7lNoj0+0S7esKQa0ChBXqMoz0Ab3fhP3O86w
         IIGhkUvQh9qe2+39e9Dt5Gp59wEsZb7Nx6TwQAOwDNIeKQMS1fvek9+ibCdeQITGjtNp
         hlJrZy+h/5KHSFKZwQGrEX0/Ec/viyzLCgwBWIlxAb2cef7W2ZHYBYX9yQnYGtbCmSR6
         D8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKRal6B5cFjvfNLZnlDYPlfZqeycJ2Ag6YtWR3USaN4=;
        b=iKkc15AHXp9i1N8mrXBFauRukHMBh4Z0MyF/nwPjHK28RM6VVYKCdxRd80g/2DBe1E
         xjngYcZ/Ow+jGIpzFDa5Yu8F7vRkDvs5t2l8NQKQYyy+uecos2hzQ5dTxAWT2j3r89MG
         NWD6ZZ49XqO9V+T28U5AEK2a5xiazx9+l6atO8zF4EAei7y+pPx6CofW14G2dXjEKESi
         XXcoe8BmE5DCsc+yAin7Mb8J3SXYynwWOfIWGn2RbxgPIVnKdx4TxbwpxHnzILtAgRgA
         BNGEUmvfabvvJ3/tywsySATr3Z308YHsRqdodEhQbXYeC7f2srln+JvdimSA7CFDFRFi
         GMhQ==
X-Gm-Message-State: AAQBX9cQb4g7TDc/jXjRJ2FEirLWkuCxA/N6nZnxzNMLtSgvGFIOL2KK
        SQoU6r3DGCG9xgMFdrpi2XruFw==
X-Google-Smtp-Source: AKy350Z6dxIZttINfw9deC1gaWfo9qG334+O8ZJFx4QOD1I5Nh9pg6hyE9Bb754U2Z8a7GVFprId8g==
X-Received: by 2002:a2e:7015:0:b0:2a7:8a2e:3891 with SMTP id l21-20020a2e7015000000b002a78a2e3891mr68026ljc.43.1681156816640;
        Mon, 10 Apr 2023 13:00:16 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e8e82000000b002a7729eea3dsm973482ljk.88.2023.04.10.13.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:00:16 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: interconnect/msm8996-cbf: add defines to be used by CBF
Date:   Mon, 10 Apr 2023 23:00:11 +0300
Message-Id: <20230410200014.432418-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
References: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On msm8996 CBF interconnects power and performance CPU clusters. Add
corresponding interconnect defines to be used in device trees.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/dt-bindings/interconnect/qcom,msm8996-cbf.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h

diff --git a/include/dt-bindings/interconnect/qcom,msm8996-cbf.h b/include/dt-bindings/interconnect/qcom,msm8996-cbf.h
new file mode 100644
index 000000000000..aac5e69f6bd5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8996-cbf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Linaro Ltd. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_CBF_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_CBF_H
+
+#define MASTER_CBF_M4M		0
+#define SLAVE_CBF_M4M		1
+
+#endif
-- 
2.30.2

