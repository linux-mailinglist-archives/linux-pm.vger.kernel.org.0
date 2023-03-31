Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94DC6D1A15
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjCaIfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Mar 2023 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCaIez (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2023 04:34:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368731A97B
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 01:34:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r11so21576892wrr.12
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680251689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqQMlPFjpwyJDFMp/Q+5qT+SRMNMN9WWVCzGVB/CCjE=;
        b=Z8O/YlVKluZ3frIjBWHinHyf35Hl9tXFgyrb2DvpZeBIUlCdj7trg1eKmtw4ORy470
         mjOyF9tBJQi2Ey8HheeRE65rpBTqzTq9i3mTVsYp3fwCYypvkM8U5gPx6qo1NyW4w1AT
         RfYhDtpld7nV252R85LScU8iMrj1F28/lGNNhzXDXFzbXr5XuNt/qTx3rFv33Dysc9qj
         ng2S0S7/e4gg8Qc0+fK2hotP9nkIwGeMnI0zHMmxfcMcDiw6soURCd1MEiMLog9EoaiT
         Chmx1245yKaUYuvICD7WIsPKuFiAmHnlmK5dBY5gRvaOBgG75ZXytjZ5wMeIuLRKYD2k
         uZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqQMlPFjpwyJDFMp/Q+5qT+SRMNMN9WWVCzGVB/CCjE=;
        b=pvUCIYCcm5hyxp7kBRK8yqBJMVfcCt2q3OH/g/pZpWo1wVVWB8rVXfbl52oeaK4HZ/
         Ojs+bpDzJuPR5MWBV/k/ECFBJfXVzuOHF9zWl7ZXL1SLdRjx6sAxTG0ayjSEeApkW/rZ
         0gLg5jRgrTKVPqtqe1npAyDHF5h9//Fahp6MROmJouCE/kiLCYVk2Uh7cn+f0nNSlyWG
         NhQodj7bkNCLxuTus7XMFIctCxopxcI36NS2wp8syq6sbqkzo98xw29qjO7keIVRD9O9
         ZADDu9jhAAYGcM4HT0zF/PfQwn+navpV7u3VX8MmjsIFNlreHrebRBqvqSwPmNFNpf/d
         rfgQ==
X-Gm-Message-State: AAQBX9cE9xeBwMTD86155PWQBj9MdhDJeBjcO/IYCa17Ljxzk1e15zjA
        0EEyvvfwhUH1wqCHNdPSv4J4/A==
X-Google-Smtp-Source: AKy350aYMRhuGCU7lgJkqotrX72DL9blN95WJq8/pg0rFFj2/jBzU25Plf3PTEmdwgAKOY8ASbmEgw==
X-Received: by 2002:a5d:5742:0:b0:2d0:c37a:5ebd with SMTP id q2-20020a5d5742000000b002d0c37a5ebdmr19721443wrw.64.1680251689686;
        Fri, 31 Mar 2023 01:34:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d4e8b000000b002cde626cd96sm1563153wru.65.2023.03.31.01.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 01:34:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 31 Mar 2023 10:34:42 +0200
Subject: [PATCH RFC 04/20] dt-bindings: arm: oxnas: remove obsolete
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-oxnas-upstream-remove-v1-4-5bd58fd1dd1f@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 SoC and boards bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/oxnas.txt | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/oxnas.txt b/Documentation/devicetree/bindings/arm/oxnas.txt
deleted file mode 100644
index ac64e60f99f1..000000000000
--- a/Documentation/devicetree/bindings/arm/oxnas.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family device tree bindings
--------------------------------------------
-
-Boards with the OX810SE SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox810se"
-
-Boards with the OX820 SoC shall have the following properties:
-  Required root node property:
-    compatible: "oxsemi,ox820"
-
-Board compatible values:
-  - "wd,mbwe" (OX810SE)
-  - "cloudengines,pogoplugv3" (OX820)

-- 
2.34.1

