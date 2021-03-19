Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECC341A6F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCSKuG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 06:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhCSKtf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 06:49:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44CC06175F
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 03:49:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y124-20020a1c32820000b029010c93864955so7053451wmy.5
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CepUcafGtrFUpUZtYhucDpANeVxiqNaK7mNfdLMmOyM=;
        b=zu6kEtsgJp2yJyo5y9yaZyeIslO8DJEBjXDq/dHhC5q2XALqTz8lRFBBt3LEG7rrw8
         LMppSHvuoL/pqe0Lh5m6jyYpdcp0hgeCN8wbk6vwOPIJ7BtXCMyXQxnwkWVYQ3ErJ8p6
         BgcnYPkFdAd9ACa+V6zluQZWhJOaD8+OkXa/99jKbqEnSfdZrNllLntAVlbXGTEJPZKt
         F0KzkWYEZ/d2ohnQnPiOpwP+RPwUPx3FHLDUdBcENq6oOmPwAw59KiiEV0LL4ObJdd+k
         abKk+Bu217H/NOeH/98zyztUzq3JxgJJDR4yjqHGDCDXo8FnpahpqGxZiHfg0SPrW4Mb
         jbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CepUcafGtrFUpUZtYhucDpANeVxiqNaK7mNfdLMmOyM=;
        b=Byv77EqzqqglA00yXEi9p411laVed12KZEFTwWlpc++VoTw3MGEO3AeIxadq+Oa9/m
         9I5YMLBbQqMuEpqgbSyOnoK9UdJRx+m+h/m/aEIHrp4h68nMFvGvT3G7jU0O6C6JQuOf
         nu0DFAYevFu2VFZszJ3WT3MsHbZg8/VJJ8gNnJ53ocI1Cqf83hjg+R5Yt5L1soXrBFCQ
         RFcn21Y/C81ofY1SchHQh3wM5opb5nPS2zuCfVJUPydGi3VvC8jgWFbqHXc97wWrsYYa
         /v09CLDVHI4YFqZS2/6pTgEVmYV+5NbOvQLfhn0kHHmf4babDjbQEfgWo5I/RhlkEcI4
         VPdA==
X-Gm-Message-State: AOAM530SAm69alPaquEA5o/95FIdsTzLTdqer0mRGpapE3Ohx76pkPRB
        0kz42zCe0Vv2OhGsNHQw9QjD/w==
X-Google-Smtp-Source: ABdhPJyHEH6apFgqPDDVWjovz+O8j/BxFJef1bbaqK1m/dkdKmD6T3k9KdkKIMgqOMAIYTb5OwE+9Q==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr3139217wmi.28.1616150973768;
        Fri, 19 Mar 2021 03:49:33 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id y18sm7416224wrw.39.2021.03.19.03.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 03:49:33 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     amitk@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vinod.koul@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1 1/2] dt-bindings: thermal: qcom-tsens: Add compatible for sm8350
Date:   Fri, 19 Mar 2021 11:48:54 +0100
Message-Id: <20210319104855.85075-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add tsens bindings for sm8350.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e071ab4..e788378eff8d 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -43,6 +43,7 @@ properties:
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
+              - qcom,sm8350-tsens
           - const: qcom,tsens-v2
 
   reg:
-- 
2.27.0

