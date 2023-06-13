Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C593C72E4D0
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbjFMODR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242496AbjFMODN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 10:03:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A270E1B2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 07:03:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1bf74e080so68062661fa.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686664990; x=1689256990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4gn37z49ZtWSh9ik86q07lLH6vDKJpjqwf/xsIE+Io=;
        b=sAeyVHLEgw1RgHR8KkIY0j3/eyzDX0PMYh9Nvx1mrM8VY9Z0R4e+08KpYNPfYQoezl
         oke8hnYcGEs9l1BgTRK9rZi0Il5B/sQdNDMB+oWvX2+up/SX+cQFW3QETSdcwmzsXNjg
         Byg+zvs9+UzueaWTsBOb37D65xJO5sS1ozwVpzc/OwbgB3v5H/iMoe662frJAhv2rWs2
         QdjMiz8wvLqlNoMiaczfMB69mCEecL5VEhw6d5RsvgCEdoE+u0egtxpzH+JZjMc/Nzxc
         3y034xacj4RTEF4skLv1oKlp+Qe0oC2iFxK0k/6M03vpS6QZ2MEspDDl2XGHWOySeBlc
         JP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686664990; x=1689256990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4gn37z49ZtWSh9ik86q07lLH6vDKJpjqwf/xsIE+Io=;
        b=CQJ5c+im0ypkrMzJQOfCBuc9AI8HKBtjWGmEOV2jpqJa765WLTdO8iiCNElyXyK1ha
         CJheOvaSB92puijn5jZofw38udr1ou6IKFeJy2UzHtoQnYZK3qxNHDf69BixnA23gwVA
         vAeGRz8IAs/7BzqRIuA6Y9NuFkoNKRzPhWOY9oF6Aomdhd4Tyu6UB8e/6IbLSj4Bzf2N
         5z6empzFTEpg+ur6LDT0In8cJXqal6t14WtsWL1hMaNbUFvlSG2D9MwdLFKl88uZow2H
         CIiq0Sith1XZMxHXssQEgI/06IrCF42vk/WfpegdgGOW4ZqB2no/XC3tgQXWljUvFIDA
         zVCw==
X-Gm-Message-State: AC+VfDxhoHScbncgVk42LmqUmF5bMvj4ysbROlFDWDUTkpxrrTnyPPtZ
        B1JiL+WcmqVXlR4LbAQ5nMcKhg==
X-Google-Smtp-Source: ACHHUZ6UbD/yDXGsozfeOBZXrAPGrdbVtYylAv8PC5AEjShyij0hpBKBTwBusLL1B7qgyZAYPTmhgA==
X-Received: by 2002:a2e:87d9:0:b0:2af:332e:3039 with SMTP id v25-20020a2e87d9000000b002af332e3039mr3233033ljj.11.1686664989878;
        Tue, 13 Jun 2023 07:03:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:09 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:01 +0200
Subject: [PATCH v4 01/22] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-1-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=918;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1W+eH+8wPS6dtSY8tNN5L1cSWMudrCjAT7V4K+wZK5I=;
 b=rjesZpqF257PaYkN1VaGHN0u0rlpZHMpF6ybJd/8YkQANrtWJk0948a8FJvkcIlYPn0M5ds7q
 YiWq0WZsUNwBZqc3E/x10a/Wsf4AhYWI7XLWxdygGb65d+3DfEGJH8U
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SMD RPM interconnect driver requires different icc tags to the
RPMh driver. Add bindings to reflect that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/interconnect/qcom,rpm-icc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,rpm-icc.h b/include/dt-bindings/interconnect/qcom,rpm-icc.h
new file mode 100644
index 000000000000..2cd56f91e5c5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,rpm-icc.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
+
+#define RPM_ACTIVE_TAG		(1 << 0)
+#define RPM_SLEEP_TAG		(1 << 1)
+#define RPM_ALWAYS_TAG		(RPM_ACTIVE_TAG | RPM_SLEEP_TAG)
+
+#endif

-- 
2.41.0

