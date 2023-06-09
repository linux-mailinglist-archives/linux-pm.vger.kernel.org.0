Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21791729C54
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjFIOIe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 10:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFIOIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 10:08:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C893C24
        for <linux-pm@vger.kernel.org>; Fri,  9 Jun 2023 07:07:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1c30a1653so20110681fa.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2023 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319655; x=1688911655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2/WZ9XTOzPX5a0+7wZ6YBA8xUco86oZHAnUM6PsZjHk=;
        b=Q3qtIbZ7+NeCPE82f8AYHJU6fFUiNAqMOgeeacCve6RxPeHokozbt8ovmqN4kv10UU
         Mfm7BURb2x3iA2f6/drdRAUtaQp1uxw8BKP0jbVgpLMFcIxbxBXctxlpgFxp1rIHgX1I
         ofevWxKgUYxXdJ6zTv4JwS2scqF7IeMZ/eZcun2QAezpkB6jq/H4upWjUJOe3nwz5xOs
         YNUrIGiAC6LkBIu+bhaX4tjjd0sVK2HqgYtckgxBlL9DKEz+eHnUNLCbRn/7fSMKSbPx
         tyxCp9oTlR57riUWxh1g1TGa4dzL3u12pp5HSMT4/4SEgkcu61Qkyt6Ccafy9PIwuR60
         W+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319655; x=1688911655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/WZ9XTOzPX5a0+7wZ6YBA8xUco86oZHAnUM6PsZjHk=;
        b=eYuKQAD4u5zzUrRYUUrXnBImG5B9K8fiXj7JbALeLblqfU7or45KXp8+tbViHJ2NNx
         rdchtG0TFIBtkbqAt7SUWkNdaIrUuGxrl3n7zRgNlIREQJ3znblDvwMq/9tCyiZcHIIl
         sbi8sEpB0C4ijJDNnt8EYJl2iVh2pu3IYiEhU+zIZGrnrGo9cYF6PmfiaT5aj8PbWWWT
         qde+HTQ/i2y5aLHUySMTk/LYdlIOwaJMyf9ZhTqBi2UIkEHjY6iWiCUV6DVBV/YY6ib4
         vbqWvhE54+RNDR5vuEd67G+cVvnuLvtHchoaI5kagRfsFjzp1tgajXIvFU8VKOE5zpsK
         rRRg==
X-Gm-Message-State: AC+VfDxNc8FFThZajONJ+uSQQn1O/US9YkGXd5BPP0w8CbfdjD/4SEfi
        0DIplAVBqor/V+THFAl8xLNqCA==
X-Google-Smtp-Source: ACHHUZ6JwuYTFNz2MQ0ZGxyMpoO7QgBUmQUVIXSFcMxEUmRYbmUboPNfpQXm7f4t5gP1xDIJES/45Q==
X-Received: by 2002:a2e:9b0c:0:b0:2b1:af36:93d9 with SMTP id u12-20020a2e9b0c000000b002b1af3693d9mr1201261lji.26.1686319654998;
        Fri, 09 Jun 2023 07:07:34 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f11-20020aa7d84b000000b00514ad0e3167sm1824011eds.71.2023.06.09.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interconnect: fsl,imx8m-noc: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:07:32 +0200
Message-Id: <20230609140732.64828-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index f7a5e31c506e..fc21fe3e7b37 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -51,7 +51,7 @@ properties:
     type: object
 
   fsl,ddrc:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Phandle to DDR Controller.
 
-- 
2.34.1

