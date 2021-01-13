Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C12F499B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 12:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbhAMLGp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 06:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbhAMLGo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 06:06:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E51C061786;
        Wed, 13 Jan 2021 03:06:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b6so970171edx.5;
        Wed, 13 Jan 2021 03:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAyq9g0d7+JzFu52aSiUagBWIroviqXUqIhKxXyrEzw=;
        b=e72TK9j3gAcNIhH9UAJHW/8/s+OktO1hrpTtZs3cmFspf1db2q6nEJUoeZBAKkggao
         O25nJGT4vZ/VvO4OPgIOtHgOXDSma6hb4nwlrfIUOkv5naxpqGYqLMqHUaaHQCZdwpI4
         VYGw6FbGldR1UfwIM41wa2s/6P1mlVrLXDDQBewaVLu9vvL/4BrFH9B7IlibKv1JsSTd
         TwAU1vTy451xSazQkzWGYG9uuSb3Mo+BEeBxhEZE0zPE/XdMJ0rd1vvIA/Geuxc9e7ld
         /fNsnFK12Z42Tgngd79BEEEzWepVBaciIChLHfBLPBNJo0ef5fW6SKE2QMBMtSQtYnxX
         Zvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAyq9g0d7+JzFu52aSiUagBWIroviqXUqIhKxXyrEzw=;
        b=Fuze8KoGDATmj8wCOxtOadjbFlPTIKnU61puaj189sGl2u4cFvRxAJLmu2hZqgHOap
         Hzwp4wLxzANjQv5ywmg8eayljOUFvevUUE+30zRxJsI15tL+iXsiLLYrFLcLZbMpwTg3
         CxMfpzNrRUOdfrWQ7qXfDstq1j6KXHgV6NzLZJZTx/4vJgIGcgB0wTlKfhxfYeCh468c
         XLYhKGwoOpwKdhddo+0Tn+Ho7eNiOG08yAopsGVuxLQozk2t75hYNq0od7L/LtaWMRLO
         Jpjj1+CIqVLbpWx4FMnTcx1Qr/448jO2Jp5f2lG5AsGvbUR7heNFZvrOZyz9qiy+P3b9
         z7Pw==
X-Gm-Message-State: AOAM530+cF8ZSd2vZqjkN2Gn1ZmADLCYO4VBdsR/Ys3oyFKcKqXU9fBY
        bbQqZymAGq+Y9MIIla4kFH0=
X-Google-Smtp-Source: ABdhPJzbd9MyV/gyU92mF+qfH/jhxq9qwhMEA4Awv6lRltvE3WBb+NE0TZcc3wcfNNv4ZNvyommO5w==
X-Received: by 2002:a50:8b02:: with SMTP id l2mr1297960edl.322.1610535961901;
        Wed, 13 Jan 2021 03:06:01 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id zn8sm597343ejb.39.2021.01.13.03.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:06:01 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/7] dt-bindings: input: Add reset-time-sec common property
Date:   Wed, 13 Jan 2021 13:05:51 +0200
Message-Id: <dfa2b49142ed00835050f4ccfd80b1f48e4aa71d.1610534765.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
References: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new common property 'reset-time-sec' to be used in conjunction
with the devices supporting the key pressed reset feature.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
 - None

Changes in v4:
 - Added Reviewed-by from Rob

Changes in v3:
 - This patch was not present in v2

 Documentation/devicetree/bindings/input/input.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index ab407f266bef..caba93209ae7 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -34,4 +34,11 @@ properties:
       specify this property.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  reset-time-sec:
+    description:
+      Duration in seconds which the key should be kept pressed for device to
+      reset automatically. Device with key pressed reset feature can specify
+      this property.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 additionalProperties: true
-- 
2.30.0

