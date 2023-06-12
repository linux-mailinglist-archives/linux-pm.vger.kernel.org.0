Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C472B778
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjFLFjf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjFLFjb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0507E7B
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so4643286e87.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548368; x=1689140368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGnHAekcnte/A+Ps2QLnDxKSGlNLw/z/9VQTDAnwwP4=;
        b=gNSE4vO/alaX8addvd+hdJ9wBJ5E/Ki9Q07y0MFJznqy5VnlrKPgdg7C62stsgbEFG
         fvpLe/MiZcwMNLUZFLgWWnCLLjbKA45+giJJxZSjLjaZ5iZZg0ayjqkgkLPKp1h7fyxQ
         aZ5OQ4wk+p0zUn5gF84KdeOMUVTuEgkw9kz47txjs3RWruEUx7zV+z7VYtdiIoAHLd0E
         2Qvvo9jwKzyhCpT5q+yfZ+dh+kZ6TkHuPkqvEU9h8MVyg0RfiP3Ngu/5xPhD1xrCXYeN
         toFIdMZDNa3UXgnT+g7ZN1LdRn5JDy6+UgzJKm4Wp1gbEl9pbCspAzRji2+i0Wzl40C7
         18Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548368; x=1689140368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGnHAekcnte/A+Ps2QLnDxKSGlNLw/z/9VQTDAnwwP4=;
        b=Vg+zI3HmCr+XxE03tVwYE6BQsbKtka5jacmukM7MCKxrJowjv/KDOgErGdGR2XkXCY
         xYDhstGn9seS96dRESOGsLaKJQE6Tadw6JDFRngZgnn2vxkWgMRCmmBeoUwUyJtGqR0D
         coOchHUfQk+JB6BloOLliNpz2hPjIffbjb8irn2pkfeUVFXXZeRCCleHL1ogjqvyP9Bs
         lJkbb7lFXRTNu62rcqUfvi2HvEqu1BP4cB20ePVSUNrwHLQAFVuEsclCcDHWbrZVmPq5
         um75/PF60aeJvLPgJXqU8hOcHE8v5nZZG1ayrWi3F8okmSpzh642mOTEbPd332ndTKp6
         WLIA==
X-Gm-Message-State: AC+VfDxx0EVCNINymZALUZAVSjGcyQTZawbKqhJdih5wjGpB2s6Ih3Ry
        PlSm9NTtktsAAqFn3LlaIH/LSQ==
X-Google-Smtp-Source: ACHHUZ4F+OFgfegjzjl39hw0+pIRZcD2vKY9PNR9NQ1RJKnvxTotHoUl3iOEr/HZFaXYp425PHvaTA==
X-Received: by 2002:ac2:499e:0:b0:4f6:924:8fa3 with SMTP id f30-20020ac2499e000000b004f609248fa3mr3031790lfl.58.1686548368073;
        Sun, 11 Jun 2023 22:39:28 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 04/18] dt-bindings: clock: qcom,krait-cc: Krait core clock controller
Date:   Mon, 12 Jun 2023 08:39:08 +0300
Message-Id: <20230612053922.3284394-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Define bindings for the Qualcomm Krait CPU and L2 clock controller. This
device is used on old Qualcomm SoCs (APQ8064, MSM8960) and supports up
to 4 core clocks and a separate L2 clock. Furthermore, L2 clock is
represented as the interconnect to facilitate L2 frequency scaling
together with scaling the CPU frequencies.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/dt-bindings/clock/qcom,krait-cc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,krait-cc.h

diff --git a/include/dt-bindings/clock/qcom,krait-cc.h b/include/dt-bindings/clock/qcom,krait-cc.h
new file mode 100644
index 000000000000..c3542b6d73e2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,krait-cc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Linaro Ltd. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_KRAIT_CC_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_KRAIT_CC_H
+
+#define KRAIT_CPU_0		0
+#define KRAIT_CPU_1		1
+#define KRAIT_CPU_2		2
+#define KRAIT_CPU_3		3
+#define KRAIT_L2		4
+
+#define KRAIT_NUM_CLOCKS	5
+
+#define MASTER_KRAIT_L2		0
+#define SLAVE_KRAIT_L2		1
+
+#endif
-- 
2.39.2

