Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD274EE84
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjGKMVo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjGKMVP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:21:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383C2709
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:20:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69923a715so88795001fa.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077956; x=1691669956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RreYIt3ZnMFF0R9LfEKzWTch1LksZzSPzwy9Jv7pG2k=;
        b=UwgYDVcLVGsIgP/ul5vpQw0hx6+bu2iy8Agkr7kA9N8pBiK3//ng6xrO25UP4qL1ZW
         YvBrCHpSDUUr5VGPC49Oj0guxiEAeuTT1fP2CgJVXJfnv0eFa2I+jWRZjMnSci9HoRje
         1gac9xsR9b2FN1iB+n3+2BG6iAHDYNAo/HJU/VwF0jfELddSI+ohQWheRi5uu86jmxNM
         ro6d0hvVDe4n3s8YYwZMjfrlNpYdWGpYJubRJs5MgIprExCpBDGcxww/MhD0Db5lqmfh
         oqK2cr8KK2r2a1uWmwbFyvIOVZTFKFW59abQwt7RXqSixEs1GG0ireUHukqvWskJVr7Z
         HhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077956; x=1691669956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RreYIt3ZnMFF0R9LfEKzWTch1LksZzSPzwy9Jv7pG2k=;
        b=JKCINVgH0J1P+S7bmC8PrBiPrNzPwclHj00o+BikAYBb3R/2ysTRgvmecmd2qbaaZv
         X51X55FSFNpbdjJ9DxoYCJ69V9jElFxCjNPVoEyLVFF4JQWJ3HlwqxfUe375K3TqJACp
         D1cjIFvMjd1r88XOPQybtTHBUd+14aFjoCla1vSBqTXhV13v+G8cmTI9QzJevg1aB++8
         Hy/yRKCAnc+U3hKeooeUvLnAsPGJzSxo4iH6VNpa8ZJ6nRx8Mm926J+/reAAw5DDmYnT
         9UGCZZFNu7x6OrIqQMa9zmRkGAEJrQpdSJpg0gQl0mCAgX6JcMs5ey8AzAQHbCQYIQaT
         f+wA==
X-Gm-Message-State: ABy/qLZGT5aR/Rt7EtPYod6NBMw4FWQelecUzX6Sd/Ru2W1FyNidAm+j
        b14LzuTDo96zCkJ0ixXb6Qv5nA==
X-Google-Smtp-Source: APBJJlHQ3oe1G8p+PWR24oULJ5EqoNFC0vkRQ/1PtF1/nlVMR1EgTq9h3Rr/GNdy+Qyd37/obOIDoQ==
X-Received: by 2002:a2e:99d3:0:b0:2b6:e3e2:5045 with SMTP id l19-20020a2e99d3000000b002b6e3e25045mr14566230ljj.18.1689077955830;
        Tue, 11 Jul 2023 05:19:15 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:36 +0200
Subject: [PATCH 37/53] arm64: dts: qcom: sc8180x: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-37-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1043;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QsxBAhmF4V+7cAeh292jLOJ0EyFZPEAL/VdNYG6uwy0=;
 b=EcINMFAuqr9POkjtP9ouV28bSDwaunALS/IJtAXkha5ZPq8MnvKlayBi1+JHun4UsH1AaxL5q
 VCJU1VpxMvoBWzhtrdtBzwPXQ4C90YZjC7B812kmR/BQepghhNjS74J
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
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 11dcad9c6e94..b12d6d573678 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,gcc-sc8180x.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8180x.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -3500,6 +3501,7 @@ apps_rsc: rsc@18200000 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 			rpmhcc: clock-controller {

-- 
2.41.0

