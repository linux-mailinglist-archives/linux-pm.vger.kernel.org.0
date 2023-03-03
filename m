Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373C46AA481
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 23:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjCCWf6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 17:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjCCWfn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 17:35:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74184EC42
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 14:33:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s11so16085296edy.8
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677882723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N802Fr0mvYVFoYKvgL4Iscqjub6mN4UuWcVLOyObAeQ=;
        b=anqfWCxg596yDFS2J6yTLMEkbdpNSt+TlEzxeRpphJ4g76mAM6QGRd0G0+N5NYYEbC
         fNwgkzRbRjPGvSAltOc2H6w5+qzL8sH82dwLll/H90TBjIzro3IPSPh0usy9JJWtz4Cq
         kI31IM4qQ+i9I5PfPfp4KBtE/unnTeYE1J+H9TCVJVnAp3EZI6YVs1H7EU275Gz9uFCc
         iVNHqUOmcH/X7SHFMiFO2VWooA1QFbz7GC/62e1CDzu9CozGylcoXzrQmEzbg1HtYgbS
         5aqIyyOg2Bhe4EL8kt9OoN7tQBzmE8QN0zLDQMfBIlxOxqgFeJ+rchhSLcQzQ0mfLQrX
         ieYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677882723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N802Fr0mvYVFoYKvgL4Iscqjub6mN4UuWcVLOyObAeQ=;
        b=2TLL0p5uRg3+1/+tebkN7tjUxL6lGSjlWlgbhmRbq+VjQmbCU36omZOQBSlAiR1hJ7
         4HiYJB33nMPM+btvB6Je3f5vQXkTHIWWie4OJ7Yjxg5lMdcwST3J2aLK+1P038/0mf+j
         ptGijyf8VIT80e7xf8vGRaEKfhbzOjD/bKtuCF4CTcpMrIqoDUNGiH/iwNzjZymF3p+f
         ItKkTp4FgOLplFoyIU5/ZzAprjfUA0a/wAPC9K/TvQ+lwJIFhg7AJf7zKMCrlzvw3j15
         n4+IMMKZek19YH8+YKAk1RHR+zClYzeGLYJPKSHV3jE+s71Ta7+vvxpQZob7JIkldczl
         n+3A==
X-Gm-Message-State: AO0yUKXqKVonCed4gv8bAqqTqAeF/I+/dIkizDrI/CCKYJl1p4E2GC3W
        9NlqKAW6/YmmzLZGQ4YFE5uXUSl16ylSXAkKzRE=
X-Google-Smtp-Source: AK7set8Fdfy5WOEqMgqPc2rdpcjhWkLcJquvS80WpInpqtI8xhRl5yrormBUiwIZnCdnpW6je8iNDw==
X-Received: by 2002:ac2:4462:0:b0:4b5:8f03:a2bc with SMTP id y2-20020ac24462000000b004b58f03a2bcmr921031lfl.9.1677880698708;
        Fri, 03 Mar 2023 13:58:18 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:05 +0100
Subject: [PATCH 05/15] arm64: dts: qcom: sm6375: Add IMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-5-8c8d94fba6f0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=952;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XeByskUh4IJy5GUSRGVEOURhAeiNtSqMfR5ebBA6Oes=;
 b=4BGCWuRt4pHZDEFG5NnlENa82CtqJNl0M7IwD7B0smCe7QLF2yvSlwkP01BJ7lIgUrn6TL3n7+R7
 Yqfs45A3AJM1sn6WX5CatJztLRKbi85YddngzJDzDLOMdYW9lsNU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a node for the IMEM block on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index de5882c0ff81..5a0abb7f7124 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1233,6 +1233,20 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			};
 		};
 
+		sram@c125000 {
+			compatible = "qcom,sm6375-imem", "syscon", "simple-mfd";
+			reg = <0 0x0c125000 0 0x1000>;
+			ranges = <0 0 0x0c125000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6375-smmu-500", "arm,mmu-500";
 			reg = <0 0x0c600000 0 0x100000>;

-- 
2.39.2

