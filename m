Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A365262DB4E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 13:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiKQMkU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 07:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiKQMjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 07:39:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83EC742C8
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 04:39:11 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so2531388lfb.13
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 04:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHKEAmsNgrv5kSrbKaB4tLuFW91sEV9E738nyh8xMYc=;
        b=nGQ/qhtua+7pLZ4YSQyBIVtNYJgSwlmE5TpLx1oateA+BN4Fkgc57IFGtVkEd3XOUY
         OUU8btqbDJ87U0Vfh9BOtEQ2QX0NRwxWic0CiPkHzjuXerJtF9mMEkr2ctaBjbhrsI9l
         xzGUr6iwCmwuZJQDlBRY2v/DLhzCQr7D56BI7V0HJS8FlOgLbPwUK7GCnhOiKnqE3nN1
         mYXEYUE33TxRnczOoemTDlOmAGh89yBAu2koQyBjxYbKJIE2WkCdMeNzg9Krk9/Emy+R
         nUorOO10hpgyDies6XynMDR4bAeszb76YUfWXo7dU95L68xj0jSU7qa5bYpT4o4P506L
         LQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHKEAmsNgrv5kSrbKaB4tLuFW91sEV9E738nyh8xMYc=;
        b=nEeYzRRZm2Fi8SIzXgzMmXzbQb+jkiCK8JYRlRkxbARtWCgr7/B0GQoycfrMOOKbNa
         cylFEe+E1gp8rhKaWAgJnfRkdozXpIlOI+y794UQaJOxnjdq8HZerCtFJSIaQC7RISlm
         1HTqPUPSyYCYqDAgTFv25lfj7p1eTqRrTMGfvL2LNVTQ3gou3bQb4STbkFz6vsASKWB6
         sSaYOuPT3Q1FKD6nXY4WYsqTB0nc5vm19m7dXPCicHEZH/BcERx9qoQAlEzgVLDJtLz+
         LKTHWQMF3VJy2BhgKYratL4mqbT9EY3oS4YZEE+wK1w3Op+yJO/ekYZ4T0s/GPqLtX/I
         KTkA==
X-Gm-Message-State: ANoB5plJvgXHuo8R67K634TnfnRu5vSbeY31xVGY1k1p2ly2wYNpZVdP
        pPi/ZGMyyUqAZVMUG0JoXTL1uA==
X-Google-Smtp-Source: AA0mqf7bJF5hus73SI6iLS9vfYrboHghUm1Qt5VwLMlR9isaWE2bW+dP7MA4lSYoYUkY+ERTSndLsg==
X-Received: by 2002:ac2:4c46:0:b0:4a2:4f6d:78d6 with SMTP id o6-20020ac24c46000000b004a24f6d78d6mr819625lfk.679.1668688749810;
        Thu, 17 Nov 2022 04:39:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b004972b0bb426sm127855lfq.257.2022.11.17.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:39:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH 3/9] dt-bindings: clock: st,stm32mp1-rcc: add proper title
Date:   Thu, 17 Nov 2022 13:38:44 +0100
Message-Id: <20221117123850.368213-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
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

