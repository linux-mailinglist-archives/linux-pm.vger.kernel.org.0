Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B116D1A2F
	for <lists+linux-pm@lfdr.de>; Fri, 31 Mar 2023 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCaIfd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Mar 2023 04:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCaIfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2023 04:35:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816F01CBA5
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 01:34:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i9so21597000wrp.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2023 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680251692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wf9SwyOhQz7g6EiRpZy5Wi8C0ELh2QJL8BxOtMQjNQ=;
        b=KOfHL6QnQCbHbqPXUqo6ZvEG2z1yZ++Zi9D2AelVIxvkp3v4CBUgHj9Knl5oyIiOkB
         RrLOU3ZwudVZ4jmfljtYSayheSg0vohkiDofTFnTQhoEha1hc0cuTi9XKRouKDzXZhEr
         J9XyeJo0ntnzkjZsx99LRBmjqS5GHaMww2M2xDFwaAvJzpSGXfs/qmrNrcmQRbSAdJ9P
         xmGZEQokLL06b9oHiwSanHGu2Q5TyyUzNnrPVGdbyUw9MDXkSyki0njbE2Agt7SfqB0D
         D7v/KRdGjRtIvJ2ttztoo255ZEcYzA6ZAXEMdFTzwMRTu+yhrAtLfGcHK4n+pYDtPeRB
         Recg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wf9SwyOhQz7g6EiRpZy5Wi8C0ELh2QJL8BxOtMQjNQ=;
        b=11/9D7lTBAzh0DnglX1QQuNb2mwh7klToEiuJaaaHsiHO8HlYFrZ5Ms5vqfDzE5NeC
         ObbSYZ+9DxZPjhzFfgUEgcsc76pBSf2Pqn2vylm6QtCNCOrq4oSFAaz9quvVMmyhsO+o
         /LoYFPu+39PIqca/Qcz3NeeoSHF5C6SA9t1wLYqoK7+jtm5L1+yQM6S4I9DUMMzmHUev
         /pen6ApHixac5gYKCNiPoykk9N9qUDGJusL5ML8iLfi0k9VLNw2FWw1kTktXNI12jcwP
         hKryeJfqAbE9TjSdp+i8Fo1m/sBrXm8qC0SsJW0jUxOW3TZ40M9uy/y/TxON6FyEVoRd
         DaZg==
X-Gm-Message-State: AAQBX9dggzF2GgzhQeEu6bB3aFRWW4jwbS+GHTGOILM6LtIPAmMQQP/i
        ZLUsFnkVb4Gm7DoOTm8d8TcWaw==
X-Google-Smtp-Source: AKy350abqfIAr0v3P1V1HSk/CRdjBgvVisNOx4Kso+mcTsWdfBK5jYsqahojN5zQQJmGitx5MuUOFA==
X-Received: by 2002:adf:ff85:0:b0:2e4:aa42:787e with SMTP id j5-20020adfff85000000b002e4aa42787emr4054721wrr.51.1680251692431;
        Fri, 31 Mar 2023 01:34:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d4e8b000000b002cde626cd96sm1563153wru.65.2023.03.31.01.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 01:34:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 31 Mar 2023 10:34:44 +0200
Subject: [PATCH RFC 06/20] dt-bindings: clk: oxnas: remove obsolete
 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-oxnas-upstream-remove-v1-6-5bd58fd1dd1f@linaro.org>
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
OX810 and OX820 clock bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/clock/oxnas,stdclk.txt     | 28 ----------------------
 1 file changed, 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/oxnas,stdclk.txt b/Documentation/devicetree/bindings/clock/oxnas,stdclk.txt
deleted file mode 100644
index b652f3fb7796..000000000000
--- a/Documentation/devicetree/bindings/clock/oxnas,stdclk.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Oxford Semiconductor OXNAS SoC Family Standard Clocks
-================================================
-
-Please also refer to clock-bindings.txt in this directory for common clock
-bindings usage.
-
-Required properties:
-- compatible: For OX810SE, should be "oxsemi,ox810se-stdclk"
-	      For OX820, should be "oxsemi,ox820-stdclk"
-- #clock-cells: 1, see below
-
-Parent node should have the following properties :
-- compatible: For OX810SE, should be
-		"oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd"
-	      For OX820, should be
-		"oxsemi,ox820-sys-ctrl", "syscon", "simple-mfd"
-
-example:
-
-sys: sys-ctrl@000000 {
-	compatible = "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd";
-	reg = <0x000000 0x100000>;
-
-	stdclk: stdclk {
-		compatible = "oxsemi,ox810se-stdclk";
-		#clock-cells = <1>;
-	};
-};

-- 
2.34.1

