Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC33BB550
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 04:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhGECxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 22:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhGECxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 22:53:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BC8C061762
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 19:50:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 67-20020a17090a0fc9b02901725ed49016so8015011pjz.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Jul 2021 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=77N/67rSOupK1Chm3/4oKVH0HtWBRmi/Fw54y3WWFfQ=;
        b=S6Zwf1e/LnhulYerNCjOfNqfeDM2VNDoZdMluwc3wcHJSiqhctzalDIDSatEGVnmOB
         VQkDMHBpuhJEsiy2S27bV/QZly6xp8pB747+9EbgURxw2OCg248OBM4ZmZIYdlbTyqI2
         NcCI/WwKylPxOgQaMxi4dmS4tZlIxQUOIzCqeIzbxR/JUzuw7v2l0y52xwnRcFzi0Sjt
         KmOZVzz9Vl1L2EizywSdr42sg+iGV5zyo1yI712mGkDA/ivTAlkeyKRGX9ZUnra0vByF
         cWSnCKx9r6sb80MUZfwir9AVb2w3mBmQmwcf0Xrzg788T8txOttYtmh7AJ21irw2iMpv
         SZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=77N/67rSOupK1Chm3/4oKVH0HtWBRmi/Fw54y3WWFfQ=;
        b=DFyEHITk3ksqA0cQIA/lfTzdLwlks3m6fs0Vgl7+WBTBTB1/WKq3lB5YpU6h20W/1G
         WXO9IEhHSfSlGmoPR3MfZiA4ouMgjMCu9E9R1cmh5alkwMXrWXukQvZ5iiOMQgtV6W46
         aHYfTPTjHFmiizp5UITPtz1T9r6sIu/urasiJRnJwJ9asAI7dn/MPY890HhWRAqm81UP
         j5JDM7OptWP4aiv5skuBwTgJ3BXO3DOjU0CCVS8jJYW9O+OpDnwXBTs2IZ3K+gpQ34D2
         mBbOe3DeKcx+VsnmlxCwc35lcFx99zgXho5uM1/03GdRrLBLBByrueo9ogTuzf/znByR
         0lxw==
X-Gm-Message-State: AOAM531VkGP/5cnvJPenh5J0FoYYyrEJxR4gVvtJ6MwRoLi5ElSEHYlx
        d6h+sP7qJd+oVcuino38jemC7g==
X-Google-Smtp-Source: ABdhPJzY3f2gHVvXij7AuGGJdzr5F1gId59J7RbuJOiaJF1b0tz0kXpXacL91zrmEuq87bpq31xp6Q==
X-Received: by 2002:a17:90b:1085:: with SMTP id gj5mr12758117pjb.166.1625453457107;
        Sun, 04 Jul 2021 19:50:57 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id i13sm11891041pgm.26.2021.07.04.19.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 19:50:56 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/3] dt-bindings: qcom,pon: Add 'qcom,pon-reboot-not-used' property
Date:   Mon,  5 Jul 2021 10:50:31 +0800
Message-Id: <20210705025032.12804-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705025032.12804-1-shawn.guo@linaro.org>
References: <20210705025032.12804-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add an optional 'qcom,pon-reboot-not-used' property for devices, which
do not use PON register to pass reboot mode but other mechanism, e.g.
particular IMEM address.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 7764c804af1d..584eff179904 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -23,6 +23,10 @@ properties:
   reg:
     maxItems: 1
 
+  qcom,pon-reboot-not-used:
+    description: Support of reboot mode passing through PON register is not used
+    type: boolean
+
 patternProperties:
   "^mode-.+":
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.17.1

