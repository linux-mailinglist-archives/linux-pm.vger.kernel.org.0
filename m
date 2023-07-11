Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9E74EEED
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGKMcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjGKMcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:32:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF8E6F
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:31:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso693278666b.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078642; x=1691670642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9v4ZXfNPn9qlJhxs+gp/ant1A453p1BhRobLNcBnVk=;
        b=e1MUuaQudYmYDnpX6KsjzBFC8cvTYU0mRI2Qm9OWTLdeAXa/1kG9xXII/PnYSxW+Pt
         0I7cTHMJPx9+HeAMblUxRhhVzXiUcKamuqrheMn3kyE1acxZtiSuEavfrj0F9P+BWrBq
         OQzUVRVUITMr4x8VoXkEqv3ud/vw6UzUUT5tcS1y0yOQllOPoe0edF21QKj7gS3Dk4b9
         UNRa0mnIUlj4JWUi1k9BfCxC4lykbfGAXNr+aQh9HAns8v91wtSsRkKukJdC1H6WR3O+
         Jw58WgAg8xRvOOluub929SUSiY6FpHUYqOqzTt5cjCZoNrV4oUA2lOHdgODDqB6pIVUg
         p0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078642; x=1691670642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9v4ZXfNPn9qlJhxs+gp/ant1A453p1BhRobLNcBnVk=;
        b=JemP9P54/WEhCHaTIxuhZ7IcuPCNuET1zrP+Um/zrkaPReNQtNqZSgNoMwK/Gf+2Yw
         IVMvpOiIIJZfNjso7gKB4GW74YiObhELA3BA0BTD7i78tMnugLmGYeqN9hkNSrgSfilp
         BWLhoG0a9fLOr4p9LP5zD1MGC3/c6g/yad6S17Jz/jBFsuopELBypb4rnnG+dYbbz3Jm
         5t3XCunW/Fq2CjFOyNVhA1TLeU0xJYY1V8ya7itoMutkQMVs5Mxj6FuOY/bKI8SVvJT3
         f3eq+w7NwGTazriWeQXELL3haWaLiSoxVp6udfV/vh4Zx2c+MQ7V0cGya72LE4cfCCsN
         5G0Q==
X-Gm-Message-State: ABy/qLaytLza4nTOWVw9Fv0f7zG0O/6DkHw/KqJU/VmqhmK48e2BYmdZ
        rme7p841sU28hV+5+5plEvEij1xeHdwZML7gdba/vg==
X-Google-Smtp-Source: APBJJlGt975r1L3ME9SiPu7XfWBzrD6W9t9yg+ez2+RHTRoOIxDF6/VsWrx6pvoj7Iig1uZMdsOG9g==
X-Received: by 2002:a2e:9c07:0:b0:2b6:e17c:151e with SMTP id s7-20020a2e9c07000000b002b6e17c151emr12101413lji.48.1689077961981;
        Tue, 11 Jul 2023 05:19:21 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:41 +0200
Subject: [PATCH 42/53] arm64: dts: qcom: sm6350: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-42-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=644;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3BXN4Qsquy4y5qOl9KpHX7nLXTZ8ImSw5T4ipGBkQ1A=;
 b=L4P2R1cTX0Mx5tC2KxNyNlk0tY9lOiawmJDvaVn06l3qHluLU/5INXihMYZKQCkrUV54h+PyO
 evh0Q52kgDYDMKkfN9XL1doUqB6VtMhBVyMInXNS4GKDnYkZ4s3SEBh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index c2b5d56ba242..1f52f63c5a57 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2563,6 +2563,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 		};
 

-- 
2.41.0

