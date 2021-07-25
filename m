Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE63D4B12
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jul 2021 05:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGYCTz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Jul 2021 22:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhGYCTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jul 2021 22:19:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CF5C061757
        for <linux-pm@vger.kernel.org>; Sat, 24 Jul 2021 20:00:22 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t14so6835703oiw.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Jul 2021 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUU0F6F+EwCOUqAHdrS1FCoIIs2D4cf6PA8YqPnT4Ok=;
        b=xPKhK+TngIGr6ibzCQQAHh56+6viK/fjLQsjNxpj9o1L0D3nTkNVysVOnmtdaPpJRl
         BylnrClMCn/Sjt4QUdyXkhJyPnaugKm9p9UXyHgIIakhgg9ai+62yHwdyRyK79Vk7AK2
         XA1PInaBVh/teMAOr6jRiD77NNY7uP31rZmFE905axej/FJYlhTWeipUg9JbISTjhTHq
         nC7mrzUvcXte7rDm00CKpoVcMJd6CrwRahKHMWRF6uhWgDRoRwcR6EwlgP4Yi+SClx9y
         loc7HlH7WI6Pd/p6aI6Jo3G9ieiymEfOMuxjH+AjBLl5p2tgx2jRuMgrzPOAu8IufN76
         7KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUU0F6F+EwCOUqAHdrS1FCoIIs2D4cf6PA8YqPnT4Ok=;
        b=WehoQfo9GnDmlpFWGtmLh/XsRGRQb7zHSwGbHV1Ox/K/G9Uc1xiEgi1bAUcP6VZUWa
         N8zGwwyWXF3GiDgJbSp0xoiAykg4PR3JJTZL+kvvyTwsvAgDPnRHArMhjYKo9QsAGG6R
         B9im89cWHZoJc/qvoaTkHs4/gicVc1Tq4Sd2fA1UIUDNVfiSBoQoMvYof7HBA6wjaWkP
         CuhTHX5V1RyyovldMsx1qigCel9DXPkEjzW/NC6Ow7MMFLlXEXeEQr/sQ8Jlni6j10XM
         NKMgktRS17GTgW8gkCc2oBB5niN9b9008Dt+i4bjtlndId65xOm1yTXHQOkPywVYusXT
         wung==
X-Gm-Message-State: AOAM530G9BDYHmjepnGDr37O6fdbSSG8mZ1Lgxr9z9sMzB1seKdJXJRI
        xLKEvxliSi4hdlIM1Me5JDoo/g==
X-Google-Smtp-Source: ABdhPJy+XcdhLqbOYNh6pE6M0i0lKoEDuhjNOqllSpvpqPWH8v5m0pGEQi2v+AeegYeOKpf4G0lq8g==
X-Received: by 2002:aca:47ca:: with SMTP id u193mr13024685oia.116.1627182021358;
        Sat, 24 Jul 2021 20:00:21 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n202sm3366180oig.10.2021.07.24.20.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 20:00:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: interconnect: Add SC8180x to OSM L3 DT binding
Date:   Sat, 24 Jul 2021 19:58:33 -0700
Message-Id: <20210725025834.3941777-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SC8180x has an OSM L3, add compatible for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index d6a95c3cb26f..e701524ee811 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,sc7180-osm-l3
+      - qcom,sc8180x-osm-l3
       - qcom,sdm845-osm-l3
       - qcom,sm8150-osm-l3
       - qcom,sm8250-epss-l3
-- 
2.29.2

