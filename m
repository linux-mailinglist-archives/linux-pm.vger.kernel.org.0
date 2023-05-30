Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D91715B79
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 12:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjE3KUq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjE3KUb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 06:20:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086212A
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3b5881734so4789682e87.0
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442015; x=1688034015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyt3egYQ4ZXwXortJqKnfq0jNA9L3ka+zbPWgIHRD7s=;
        b=LH67/zhwHHjr6N5quOb5F/GjMiXeHM+XmgCoA5fLikqGcZ6ZVD2Nr5rH5JVRPZefg8
         2Kzbuz3z2jsrUzSroRSPEU31LtROiIJIt7fHCkO85wXUHlhT8faseCkyH61gsX4DRzxn
         2a+Tj6b4AJAHrODAvDRbtc8EGYtLUpwvKDIVlB0aEZBnbs4eoJ1vL5eoy/j8hMc3Llgo
         Fbc4Vrg5r4M9tFlH4I8up9RSJ6leIak7A/ATGd1aQBC8/nHKulj7T3F0a/yGdeIGDcLN
         s7BPhA7ALJPbPs4SFvbfHPJQSHwGCVaMMSmIGcYGQVRcA/KYz0CXUDanKliA3vO/irgC
         J0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442015; x=1688034015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyt3egYQ4ZXwXortJqKnfq0jNA9L3ka+zbPWgIHRD7s=;
        b=PpJc/+pAP7FNhXEu48XtHKG38ohG7h/Slf3A6nA2eaTQZQNrfyakM84MOn58D9SHPv
         N+JFZjkj3RlC/ngM7bZLW+iu+bpuGKP4alrK/6SWVIkTPO+ty97yFAU7+tqeYVctcIv0
         /fJJnxAAtjuvRehWJoJItx/0xnZWDNEeE53SxtVORWsKIXctAN5NH5BOd1J6gUMrXu22
         RUWnNDRAjrz9t7C9M4PwWNC3iCjdd6xO9I2gF/g+KbX8pYI/CLjBA9N4yMqryPE+dBRu
         /q05o5UkELL3JK2JScLUDURqz9lMSY0yT9K20yHXxXqex2NMC5J78dfgZRiSTVTrjZRQ
         wUtg==
X-Gm-Message-State: AC+VfDxPbnT0DCyMappOh0uYRmRoiihN44dohC/Nq3aaNcjYQaGkmLrc
        9S+5Xmuu7bTjr7Yg0568JBCiYA==
X-Google-Smtp-Source: ACHHUZ5o20dbYFk+vD9wZn++JjWHjzWIkzo6uhuwMxBu1uxae32FdX1IMksGvjvWYCi0U+vP2SeOZg==
X-Received: by 2002:ac2:5dc1:0:b0:4f4:6189:1d0 with SMTP id x1-20020ac25dc1000000b004f4618901d0mr575192lfq.7.1685442015510;
        Tue, 30 May 2023 03:20:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:08 +0200
Subject: [PATCH 09/20] interconnect: qcom: Add missing headers in icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-9-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=740;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jTkx4EPVwXQN5FFZMT7EdA8vRYwWcRLDeFIEIuIiyzQ=;
 b=0/T2QmK3afylcI3Vrr1VjeycV0no3AjFREcQ8+Jjm103oHojwnH7NaZLHhWInbWiSc7tIUO7v
 AI6tRrVqk7gDgHmwPiO8rgO52Ife1mka9aSw4eN9pbVtDoMLomssIIp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the header does not provide all the required dependencies.
Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index aec192321411..09abdd0c891e 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
+#include <linux/platform_device.h>
+#include <linux/interconnect-provider.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 #include <dt-bindings/interconnect/qcom,icc.h>

-- 
2.40.1

