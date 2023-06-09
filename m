Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA5B72A44A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjFIUTY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjFIUTV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 16:19:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA4D30DA
        for <linux-pm@vger.kernel.org>; Fri,  9 Jun 2023 13:19:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so24592501fa.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2023 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341958; x=1688933958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SD+82Kp64qdWpl/p0nHwxIb/l/7wz0DuQnwuSSdR/H4=;
        b=OwO3Auy7crryfX+wyX7S6r2o2fCVI6oNqvTgeY15i1gE0hbXu2gsulroECVxaoo9sC
         niEjxY9zH9dpnsNjX/snxyi0+Xx0iAIWGvFMo2afjLUWEMJickIKFW/Isb47V5Fr3nZ2
         AnlnE+j3LsVcsodRYQiFP6fkLXcRoVZZrfciC4kmFpxJTvppJVjC99o6kLysc3B03yjN
         NCzpLqA443Rd0yy68YOhLLikqYMFAZbgQNPWaUSfWqb6yasOoXvsOZaOIz6DNqTeKOOY
         n7CDZtwp9an9glGdZLrSYwHzsrBxsUEz7f7G6BzJA65o6uLMFGZH1qSHc5BcQ0kU1w7V
         kk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341958; x=1688933958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD+82Kp64qdWpl/p0nHwxIb/l/7wz0DuQnwuSSdR/H4=;
        b=Fh75aJPvCe07WXlQGX6uAOSJlpcpOm3Jd2+ldnMWfiRDe7eXdwLBNlhItkAl0CIb+m
         V7rgnMr/6Pjx4Fhwt8I8kwaf0fsOq770Rw6uE8k/RWO6Bgabu8xjSFgu/SGutab7dCP4
         W/0wcfloKmewuRfBCaWmRWo9FkgvwKMC1fPr+RM9UqAWQtJCZC5/dUaRnftXf/A+/4aa
         WpJobc8HlIOTC4ihssByBWJ4k50aMjXa2vbOvp+8jCAMkRBz1xzxUPBqv22rITdvlYRQ
         Cu8FdDUd+AoX/HdbcbqKwtVV95ai6Q+/rs2cYSRYNSB5eVhnOKpgoVRSA9a1pnTawFYF
         A6JA==
X-Gm-Message-State: AC+VfDwCrxJgU8lFI2ifL8LqyeiFXk8FX51woxY5Ln1khGj5sS8Qdk+P
        AxfPDeFNrzccoKSkYKMzUB4J8puL5AbUDN2PaM4=
X-Google-Smtp-Source: ACHHUZ7LdOiaJTmOwHVlsOJ+APt3wnSuCgU+CvvBtV+8zV3h6+LeQH7ffqgZLX0oq9ReZ4lq5Lpfnw==
X-Received: by 2002:ac2:465b:0:b0:4f6:4f9a:706e with SMTP id s27-20020ac2465b000000b004f64f9a706emr1631988lfo.15.1686341957684;
        Fri, 09 Jun 2023 13:19:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:07 +0200
Subject: [PATCH v2 02/22] soc: qcom: smd-rpm: Use tabs for defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-2-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=691;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7uAPa6YDjXHLJZjqpcpTS8PIWFtwDRP9qtCSKC7URyY=;
 b=qa3oHWLAPbUw8lJ/y8dB+VV8T9hoLLxb/r+MlOEOVrT1eiCEXbkhS5tyyyg+RB/JAOUo7Sq47
 AHZelBVy83aBdpxj4Krpw7Lqa7eAIdwks9cxjHyJ4xcZTKF+WAixqxy
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

Use tabs for defines to make things spaced consistently.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/soc/qcom/smd-rpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index e468f94fa323..99499e4b080e 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -4,8 +4,8 @@
 
 struct qcom_smd_rpm;
 
-#define QCOM_SMD_RPM_ACTIVE_STATE        0
-#define QCOM_SMD_RPM_SLEEP_STATE         1
+#define QCOM_SMD_RPM_ACTIVE_STATE	0
+#define QCOM_SMD_RPM_SLEEP_STATE	1
 #define QCOM_SMD_RPM_STATE_NUM		2
 
 /*

-- 
2.41.0

