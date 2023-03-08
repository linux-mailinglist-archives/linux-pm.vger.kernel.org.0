Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9306AFC5C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 02:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCHB1n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 20:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCHB1g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 20:27:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45F92737
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 17:27:27 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id t11so19501220lfr.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 17:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678238847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uK/plytj2pGh3hnWNU3A4OsxYVbVd2G45N7GCK+reGA=;
        b=ZO/pu5w8RX3as2eYI0FqEb7KM/sh1Ev4U1ow0QZX0mol1tlCvCwFEAuC+UnwH6u/pD
         kOOi+LVvZEnm2el9sWCvhvTaU0lDQDV5Xfj0j8zi4A0zxEdW1RiGkc/PSPWts0kSioN6
         8OVrALhNaneE3lV/Xb+vwgTN8kvmI/kvfF3QwuUnzRDIpmxlW38dECTCG/T4XmTAT3EX
         qRXgogvkE2vzSzAjIXRtut5FIa39ppOmmm9ycKD8tnHBTpHDTAj5wm+hMlIvctRjCZxi
         srQAb+Y5nTuF3qwKEyieVfjzBLd6ZERrMFxBFHlLjCZqpqwFn4j7sWnypkS+VjhjNRqr
         d5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uK/plytj2pGh3hnWNU3A4OsxYVbVd2G45N7GCK+reGA=;
        b=ijTBN+UWUSmFcYdN/W0P7hMG6Hd1VtyS8tgNb72010jNpiXgYc8PAYDwVsOUsllZzP
         QKhIYromfDvR8bwoS0BV8y7HrUaL642SwU7M4JJGUIJx5ti3sMiR28lmzsxyNki2lcF/
         bvLbQeF2dqhgGQ8SMlnuMjHSYi5ylfodTSMdCzJ+scWKG+fMIP89n/oTh/ACNlQakQQe
         EGTJU3EErhtuDnRtO7S8vkmBiSk469nIQA3kdBNlRHfS5E6DJT+o2yQ0gsQkMIXhBmDC
         +MdrGv50LaJTjO+qxgZv41nYo1sPB1vEM4oHipUoZ0n4aKFgGNpELF/LkyAseGuzD1fr
         BfMg==
X-Gm-Message-State: AO0yUKXAwjL0oqy8wblg69bJuNEmrE7WUnzumuzL8veRgDPTlpTHHt8q
        JyXME15n44bmTg5GBusyS+23kg==
X-Google-Smtp-Source: AK7set+8UZ76Ii7/yJJ75KWZzTyIzgVB7VSw92xi8kyqMwdeEda6lmvSWK+4eGnUQTSpd41yuvueTA==
X-Received: by 2002:a05:6512:481:b0:4a4:68b9:60ae with SMTP id v1-20020a056512048100b004a468b960aemr4587431lfq.57.1678238847021;
        Tue, 07 Mar 2023 17:27:27 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b004a2c447598fsm2182944lfb.159.2023.03.07.17.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 17:27:26 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 02:27:04 +0100
Subject: [PATCH 7/8] arm64: dts: qcom: sm6350: Add SoC-specific compatible
 to cpufreq_hw
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-topic-cpufreq_bindings-v1-7-3368473ec52d@linaro.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678238834; l=831;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+CETfRtA+2dftHc8AjtHAgxUAslRxj6c2rgtY/K3MCM=;
 b=1Cok6m8m/10QMMyHcZsY7afVxCNFdOabAQIebdgi2ivqUtBwBa4T/cynfRcKo7KxvQEi59S0OosR
 Y7MA/jV8AG6NrYM40LFINQgQsJZXIMhQl9JQSj2rV7HQ3WvYZUE8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a SoC-specific compatbile to cpufreq_hw for compliancy with bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 1e1d366c92c1..c18ca947618e 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1995,7 +1995,7 @@ osm_l3: interconnect@18321000 {
 		};
 
 		cpufreq_hw: cpufreq@18323000 {
-			compatible = "qcom,cpufreq-hw";
+			compatible = "qcom,sm6350-cpufreq-hw", "qcom,cpufreq-hw";
 			reg = <0 0x18323000 0 0x1000>, <0 0x18325800 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1";
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;

-- 
2.39.2

