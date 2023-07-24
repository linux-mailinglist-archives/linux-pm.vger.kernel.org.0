Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33E376016D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGXVnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGXVmx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 17:42:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582F511F;
        Mon, 24 Jul 2023 14:42:52 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583f99641adso15854037b3.2;
        Mon, 24 Jul 2023 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234971; x=1690839771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqsP4uN6ZTppOmII0KV9Wnz7n7beM5l3mioJmObzpWE=;
        b=nz2gxsklnibcRhXiYe2SIm2dWVOx4+Kui6CAk3JHo/cjL7dPG/nvlvKETGF72Qwm6u
         5XUVpNt9P/A3lpmLmTUqrm8UXtyLOKxhqzLoqN2Dvcycpu36LgpaYSRH6OPNk7kI87+X
         94u8NDBS8HsVJLV4JsjEWsCQW7OgeRkZV80fleQJJJqF1qmA66ezf9oxy7Xh9QyHx3OA
         Dgi13VZolAaRJNZWqRHa0/LIn5OOVxjRvyea2L44WjeekIpkl532VZUz/RP2k+oDj/SF
         +L87RiWuwi97aLGnqaY6dsx3VijqsA8YgHdtX+XZ+qz3Hh8ckKvunZE8+yeOgevpirlt
         nFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234971; x=1690839771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqsP4uN6ZTppOmII0KV9Wnz7n7beM5l3mioJmObzpWE=;
        b=cue5aaLwLsvbJMsnRBvGkbf1FTp3hTAh4J2rMz75CcRmy0AD1YWaieGzm2emOtBTXh
         Ig7LPRn4N3hc2QM1cs0ujfZtl1Oeq+EtaBqVrBYLhWRVMgEfas6tnPaaGbBb4rq/4kK/
         ODd1CRz6LcZ7nVo8eyX+l3gMkQ0a+fWbqwm5z6+amMPx8rjExPHdOhRqS0KYfRho/M/z
         TGF6dxhyweQ0lDyKXQeANqwUCfXF8iIVgvtsSjFE3UMRK4M9CkPQwCQTPDzIZ6EpwyiN
         dKOj4I7xWeFwa4oL0uQ6cjHQh6BFq0qJUjHQtseYppYZZz1X7DEpOIqmuhrwdHrm0ezf
         TosA==
X-Gm-Message-State: ABy/qLYaSpTzSoOrO0IfgPiekR0x3HbYrQ7YWxAkl/JxwGFXhCNNU3xp
        cuU4FOUQY5EZKLhPAGFBR+g=
X-Google-Smtp-Source: APBJJlE+QK9sxQeEmBCQPmbp/Ks0oMVcLCkEbuUE0uLKCm27z88QxGPXcrs36hCenCrU2o8tZZWNAw==
X-Received: by 2002:a81:4fd6:0:b0:583:741c:5fe6 with SMTP id d205-20020a814fd6000000b00583741c5fe6mr5630219ywb.52.1690234971245;
        Mon, 24 Jul 2023 14:42:51 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::3cbb])
        by smtp.gmail.com with ESMTPSA id h198-20020a816ccf000000b005773ca61111sm2113827ywc.42.2023.07.24.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:42:50 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 2/4] arm64: dts: qcom: sdm670: add osm l3
Date:   Mon, 24 Jul 2023 17:42:12 -0400
Message-ID: <20230724214209.208699-8-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724214209.208699-6-mailingradian@gmail.com>
References: <20230724214209.208699-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the interconnect node for L3 cache on SDM670.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index a1c207c0266d..45f9633d2d2c 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1354,5 +1354,15 @@ intc: interrupt-controller@17a00000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <3>;
 		};
+
+		osm_l3: interconnect@17d41000 {
+			compatible = "qcom,sdm670-osm-l3", "qcom,osm-l3";
+			reg = <0 0x17d41000 0 0x1400>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#interconnect-cells = <1>;
+		};
 	};
 };
-- 
2.41.0

