Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B746AA3E8
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 23:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjCCWJ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 17:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjCCWI6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 17:08:58 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199F6505C
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 13:59:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r27so5359594lfe.10
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677880704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWAOIVbzD3ODnOMgViwIQx1FVg4CoSqp6I3sD+4ntxI=;
        b=QfDtxP9PvrCkp60LKDn/6SebPtDFX/Dz+7DGSmiT0tCtTOKvsZw8qfYbfIy3ZVNztc
         XkrmN64VQHLJC2zFilxo8M1wCofQsXNTt8jy9bh2v6EOoZoi+JevY9z4VUAjiqpgAAP8
         teHO+iNEtcC4SWO2aSoEvyR1P0cd+W5g/aDXAGbSAC8naqFQV5ZmNwGZRs/dLMT2W4SA
         h9vld61hgdhOIYYXD5ecZ5VEpimdo/9nXtgt9TcxwYPOyHfL8e6Eb2HrYwYcx8K3d+nF
         IQTaOQA0pKN44WdqS7DwLy4uquDEIYgkzc1GyLwC7M6LcTFhxgBfkFlWvFQzVwrotANJ
         0H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677880704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWAOIVbzD3ODnOMgViwIQx1FVg4CoSqp6I3sD+4ntxI=;
        b=aWdSsE8QDU8BSwaFN47Hxt9QXZVqM2pz51nopewFn10DjyaXJUZHVapwJYlR8zT3Tt
         TKagwxIKESZ9ibh18jGhdJmIuY4ZW3TbXOItIv6mXRq3hRpDtDVM0kwLcuS3VMgC4a/Q
         JGhlm7CIZni7TAFpooIxNWILxdSlYvsnLYcm2mD2zXoTfQEplg8xJduiVcx9P3mdG9dC
         DYZCYP3uX/ACGddx5yDFK70FSITXgku/mHwm/tK3UveAa1p/4s/JYGmCB1vwqZPt5UQn
         1ME+38uE0VmIp2jx7aI0W8cJpFpH/TwYVfA83hS8/rmgcBlSC8UZySNocpQFZHsGLkwm
         LPTQ==
X-Gm-Message-State: AO0yUKVD0zs1rpe0d/Dmo+t/oRYhstUfqJzmM09A28hakFfCzPjCe1E6
        oB4aFl6IEz7JMCgOri0+WDl+Xw==
X-Google-Smtp-Source: AK7set+OPV7K0/mvLa99j6SicswhBa1k4NpBWzDVW2y628iijgo/Wt+cJQcCcbFvfELiv4K2ez71LA==
X-Received: by 2002:ac2:46ed:0:b0:4df:b686:ed1 with SMTP id q13-20020ac246ed000000b004dfb6860ed1mr912444lfo.20.1677880704436;
        Fri, 03 Mar 2023 13:58:24 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:24 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:09 +0100
Subject: [PATCH 09/15] arm64: dts: qcom: sm6375: Add CPUCP L3 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-9-8c8d94fba6f0@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=940;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PG4nWGIMA7R5r2PHGgF9vSeONgecCRpRFxoaCPCnR2A=;
 b=LBHxFf5+1bMcsNYButrWGDVgqu7yhIFjlktHhoVYS3O8HLobezGdLKd5PX3tIJCmsK0QWrCJmf/f
 DhsJ1OyNBnC/yqKV63sGdNjLReJEZ8wLRnfpQQLqhjMoj+6YTUM+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the CPUCP block responsible for scaling the L3 cache.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 90f18754a63b..59d7ed25aa36 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1505,6 +1505,15 @@ frame@f42d000 {
 			};
 		};
 
+		cpucp_l3: interconnect@fd90000 {
+			compatible = "qcom,sm6375-cpucp-l3", "qcom,epss-l3";
+			reg = <0 0x0fd90000 0 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@fd91000 {
 			compatible = "qcom,sm6375-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0 0x0fd91000 0 0x1000>, <0 0x0fd92000 0 0x1000>;

-- 
2.39.2

