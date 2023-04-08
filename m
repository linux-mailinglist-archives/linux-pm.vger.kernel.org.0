Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CD6DBE06
	for <lists+linux-pm@lfdr.de>; Sun,  9 Apr 2023 01:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDHXth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Apr 2023 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDHXth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Apr 2023 19:49:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6F47ECC
        for <linux-pm@vger.kernel.org>; Sat,  8 Apr 2023 16:49:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a23so2989572lfk.4
        for <linux-pm@vger.kernel.org>; Sat, 08 Apr 2023 16:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680997774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBn9oSiF3o/A0b+8tH08ZlFNUTIn05KGxA3dKhpQgjA=;
        b=aU/pZEQpgtxWT4D1sJ9d87Vg6iB+8sTit4o1ya+byIsqwyf06c1GBAIyV2bFUzWxC4
         VU3895+Xib7MWEDQtksEvFpQzxu+rNi3ELsioVYNxzknKfhka+qjJ3lnXdqCsQbPmOor
         TMx7t/1QwOBpZUrdHZjHuiY1QvK8WxUCQm8NsSK1rP3dbHKm3Bco22Zo1hUk1Z+O53AC
         qS/N1XzP44Fl2pEL2IFg7GMblJOJTP6TZRYPNYNbEwfMULJSxoqJaheprLyVIwi75Oi3
         YLSrGMuTTk2bnMaR56DDufzvCcmZFHEElWjZignpn5rbPe8VyVZQU1vmTdMZ0Ovc01Un
         vH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680997774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBn9oSiF3o/A0b+8tH08ZlFNUTIn05KGxA3dKhpQgjA=;
        b=XEJPhLohavGflQ+55kXeleAaEtll7n8hT0Z2a3UkjDqVb4wyz64q0V5aVWme5Vc51r
         5Mq26Et7Xc9wjE6xsjm9ee5dTgjt+zQV7DGqV98ZqmSz+GOJF7btvsh3a15NUYhUhDbl
         bq3zzIaMm5cLLVZMmlvHRfr5sXKP+9pQIHYIfbba3IIXMIYmLS6+W/5Zwy3h+DMPM29F
         P3va0jTG3rkhFnyI4KyNruMMyhVlNflNGyU845Ocrx7JoNY9s8cc0Ja5T1OPInlVUf8R
         wMSlwZjZMhYz4z0SISHBrQ6evjjw+5fr34LYSLHxAopb3Ae8zI8f9T2JjvXm09l9asez
         tsiw==
X-Gm-Message-State: AAQBX9e2FbeES/+b3f1mD56LlKvvNTqTQLZJ/rjdusesSJ13aO69VThL
        qnZIBzdzKMwPYtsCNtNuwLQoNw==
X-Google-Smtp-Source: AKy350bNy+8d1aymxSFpoiVA1ON9UiMQ9E8OV0VXgLD9oiLfFcsgh1On05ALDTN0eyeLvGR27hEuoQ==
X-Received: by 2002:ac2:5ddc:0:b0:4e8:3cf8:5d64 with SMTP id x28-20020ac25ddc000000b004e83cf85d64mr810807lfq.37.1680997774176;
        Sat, 08 Apr 2023 16:49:34 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q26-20020ac2529a000000b004e7fa99f3f4sm1353008lfm.265.2023.04.08.16.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 16:49:33 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindints: interconnect/msm8996-cbf: add defines to be used by CBF
Date:   Sun,  9 Apr 2023 02:49:29 +0300
Message-Id: <20230408234932.2363302-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
References: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
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

