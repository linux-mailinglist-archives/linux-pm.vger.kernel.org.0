Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631131C1EA4
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 22:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgEAUd2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAUd1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 16:33:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEABC061A0C;
        Fri,  1 May 2020 13:33:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so977155wmc.5;
        Fri, 01 May 2020 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gi8sSSVku7Mlpq18er+Og+2c/7n3qFHLiGD+J3MmAY=;
        b=NttStywRerq7mMzWBEZrz3MODSaNdsKg4mrxq3e0HIOBMO5/lsl5d4c5NKuGGxqSBk
         //sHlYew56zhRyzH/zHQNhMkv/EfmQOeWHz4dw7Y6KHC1V1Gx7Co/bTeMgTeDxv1O0rT
         OPd2YjaoinDSZkmVTOHK+3SpRqEOOQsKPGKNnTDwrx9nNEuWNepF345yIq3mVAa7SpJm
         hK3Z9odw/UmWzlYbspfpxJ5vQK13MY//neDCWHuWK2FAvx312D1iOjvVcq2X5vLsSJgH
         S7lirTmGYmL6iN0NEiQOCAaCOqsAh5vE71Il4jNUcQ2zg5UfHSGaiYszRdSgaWtUbXCS
         tNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gi8sSSVku7Mlpq18er+Og+2c/7n3qFHLiGD+J3MmAY=;
        b=MRmHajK4qJKZMMv9wQ3TCk3s/iLTx+GFSAUhMSJZA3zwBQIBSTQuumpOecmmVZhoIy
         86fyho/tBTH47ZvFGSGYSlgS5T7MsXeaBnjm4pdgJTQBHlxHk5Z4PFbBs25S5pa+kX51
         I3tcxoAJxj0f7CKdvr7GTQAmrMrJMZmGQE77nhICIT7B3oz7AZ39McLsBwALUd/BIgoT
         Zqu/fpmdfQP3SN0XCUmGkW0CSjuISs5Ma1Z6yqEkFKunf0dixW+X3ypIvpNYBsis/5jO
         lDxHpiofD0iT2VYQ8Sc5aSnWE3/fThcKevZLpB4Kg5dN1vF1k/bE4UupC0UZlh6FCnm3
         fyxA==
X-Gm-Message-State: AGi0Puaijn9lXBnBU6qj7Yhkj3rN9/3I6sZ0sRCkN5a/aQvtek1TchN5
        k1Z+xjnYVHueBNlsS5KaJ/w=
X-Google-Smtp-Source: APiQypIsczhxCrYfanzHyEK3ClgSdH0yyElY6Ck5mmF5WXWrp1u+mNT0faa6Lp01kxHCjbMlTnbjMA==
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr1197330wmb.75.1588365204918;
        Fri, 01 May 2020 13:33:24 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id i129sm1104341wmi.20.2020.05.01.13.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:33:24 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: tsens: qcom: Document MSM8939 compatible
Date:   Fri,  1 May 2020 22:33:11 +0200
Message-Id: <20200501203311.143934-3-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200501203311.143934-1-konradybcio@gmail.com>
References: <20200501203311.143934-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 2ddd39d967662..2ce489ccbf902 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -23,6 +23,7 @@ properties:
         items:
           - enum:
               - qcom,msm8916-tsens
+              - qcom,msm8939-tsens
               - qcom,msm8974-tsens
           - const: qcom,tsens-v0_1
 
-- 
2.26.1

