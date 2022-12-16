Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9422B64EF62
	for <lists+linux-pm@lfdr.de>; Fri, 16 Dec 2022 17:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiLPQjH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Dec 2022 11:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiLPQi3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2022 11:38:29 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8F2EF6B
        for <linux-pm@vger.kernel.org>; Fri, 16 Dec 2022 08:38:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b9so2726241ljr.5
        for <linux-pm@vger.kernel.org>; Fri, 16 Dec 2022 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB2IYQh6x04DNB10zL/CmKCXzeUTmaj+65fl29Cqpg8=;
        b=uVg3ZPHy2EpCn1WaZLJw7whZ1p9Hg8kuJ8Hu0byIVGS5dicapwpfsq5nmGGeVfFJef
         Hu/MxseBMTu3Z0NQNszjc9HyGfHZjdcSGEKsNBGiNgr8pHYiTcpBozktaglA26U3Q2o9
         XjGMWsBVlPaeTE2dpnCK8hsYPepqiPjjVxajaKqYEurNug7reKp1ZlrXGJikr5tFKUTP
         +kan/R2tOMEoHZh6L79CKSIiMhbsvAPHDdS9dkIu7jSPxbUlJ6v8bn+snEDCXCAzWYdb
         oU/PY5GCsNY006OE6yqA/QMCiVy/tNNdlFsx8BJi8r3Fv92h+oipAU9Hdsh4QpeV3eqA
         tJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB2IYQh6x04DNB10zL/CmKCXzeUTmaj+65fl29Cqpg8=;
        b=m12j5nQuVK5F3QXE28uUvtUJUxjYiD92ubADUYv8fTxR8j8PnecSdgAscbn8Zrvwuq
         NxZdCDjrKLHDZostRotQ7Io4OnWTssWvK5QViCn+Jahw/075FA0XIvytw3nEAusPjnQL
         fkwRG84YEYdORu9I+a+UNa8Z6qVY51lnaa2381H9Iw+QIKR94mPQ2ZzBK7GbXGWcjn7U
         3pMgx7+DGPsu8Ow1MvECxzH8Q0QUMMsF2jgulQcQKnnU1kYmGW1v2mnsJsChNkMxatS+
         6mtDCojPVI5qiTeWsbhpOrKX/rAPZCAsNWdODUmHQwuvUNSKqFy44FC6iSdroGRO5gKc
         YmFA==
X-Gm-Message-State: AFqh2koDGQd1ZrvYb4BEWhrk2d9IWhXNNbAvpxjJqwQDmPtbf945rFoK
        JFauTwU+EAYUaEz1+LUeaRMQHg==
X-Google-Smtp-Source: AMrXdXubTe0D+EfslMGdUtSrdWGMhnMozYFHYH02/3eOQQGq911tTzgLYzuhquCnebuvp0CaLBRuhw==
X-Received: by 2002:a2e:7c0b:0:b0:27e:cfe6:228c with SMTP id x11-20020a2e7c0b000000b0027ecfe6228cmr2060671ljc.21.1671208704979;
        Fri, 16 Dec 2022 08:38:24 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eba0a000000b0026fc79fd67dsm193930lja.74.2022.12.16.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:38:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 3/9] dt-bindings: clock: st,stm32mp1-rcc: add proper title
Date:   Fri, 16 Dec 2022 17:38:09 +0100
Message-Id: <20221216163815.522628-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
References: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device name in the title, because "Reset Clock Controller" sounds
too generic.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # MMC
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
index 242fe922b035..5194be0b410e 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/st,stm32mp1-rcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Reset Clock Controller Binding
+title: STMicroelectronics STM32MP1 Reset Clock Controller
 
 maintainers:
   - Gabriel Fernandez <gabriel.fernandez@foss.st.com>
-- 
2.34.1

