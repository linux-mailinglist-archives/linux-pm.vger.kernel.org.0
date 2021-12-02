Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78176466D09
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 23:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbhLBWli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 17:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377280AbhLBWla (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 17:41:30 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355D4C06175A
        for <linux-pm@vger.kernel.org>; Thu,  2 Dec 2021 14:38:07 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m25so1364904qtq.13
        for <linux-pm@vger.kernel.org>; Thu, 02 Dec 2021 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YgkxkUgYa3cGXFN75ZNVpxqudNeMPhQu2Vflsaslk8=;
        b=kXDO6ZiBZCIi/mnCweRXGLA2xMwJarSMYy8jU8Z8J97OsNm9qT9phk279CqJLkXe6C
         5DZfMIaCv0yJnDUQC1GhxA9g+q2wTyOiTURiMqwAqAmMLBMnlrXu8UOsTSKS14GWUisV
         2w/D3o4NV3RxmAFx2gxN4xub2KfvmqX/rbRQRbewW+bHRa/aEvsgl56iTkPKQrIZyrNe
         P5ZX4ntuJFRUFY5HC1ZTXzSVx+/jvgFWCC74+7oCctqssZ+zC3vV/VqF9amWg8tkWiFB
         n0+ZJmcNgWxSoxD2JmOboNsMenMN+6zrbu4iD/TWCEcy+kXDlJY8zzPNYl2olhOZ6D/B
         DEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YgkxkUgYa3cGXFN75ZNVpxqudNeMPhQu2Vflsaslk8=;
        b=egNoyQBBKX+0Gv2DXNcZCLHcZNP9tdb827lEZzfg9VyjQaMbavi+e8nvtC1p1BOiT5
         z3/VTyk6xK5vjySbJd63am0g590ozFLLbDncj0BxeQDCgHXW1DyjaopuzvsIZx4+Wr1E
         YiQZmv+qsu1kNml4/tE+SUyLfv6yIOLEAB7C5PXA+p9gqQMemLlo3h9ISLPsRSEvyNZ0
         tR4mTGlNDFCJqJozlo1yZUaFjO4KE96y4t+MMGSwWeKKYvkGK2vtAW6GhQnkx4y3Fmdk
         Q2EOXAQqTR+5/T/2NouzrL9oHsW9f/rvpmHrosYK8fUjb4eiCjGWkU7M1UOXlgrhVzeW
         YLgg==
X-Gm-Message-State: AOAM531d5TsO8KPptNWyM1sO2sy/32hZIisM5nu9KByQyTmifAAe6N53
        jswyIzsylu0p4Lfia0mctkVq0Q==
X-Google-Smtp-Source: ABdhPJw5thbB/dwtKRrrsemIkR0hgl49PqQvYWmXUWSSKHPwBpOe14Uc2RUufrjd5T2vkX1MAo4jAg==
X-Received: by 2002:ac8:5c53:: with SMTP id j19mr16615598qtj.40.1638484686382;
        Thu, 02 Dec 2021 14:38:06 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h3sm961152qko.78.2021.12.02.14.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:38:06 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: thermal: Add sm8150 compatible string for LMh
Date:   Thu,  2 Dec 2021 17:38:02 -0500
Message-Id: <20211202223802.382068-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202223802.382068-1-thara.gopinath@linaro.org>
References: <20211202223802.382068-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend the LMh dt binding document to include compatible string
supporting sm8150 SoC.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 289e9a845600..a9b7388ca9ac 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - qcom,sdm845-lmh
+      - qcom,sm8150-lmh
 
   reg:
     items:
-- 
2.25.1

