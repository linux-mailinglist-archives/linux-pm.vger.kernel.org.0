Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2746AA4C5
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 23:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjCCWtD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 17:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjCCWtA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 17:49:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84EB136D8
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 14:48:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j2so3670570wrh.9
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677883635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQTyZcO6FNqmddoHzVzEIHqpO3JKFdaOcoa693p0iLI=;
        b=fCKvXD1DfV9VqN/WOq30MqmyFR6Y6zN5K3dCv1yjhe98QbjCAbtsJ7+N0RjBYQw949
         AXS/FsQB25JaV1MNnbqW0HN/zxu8HznruS/K7qubmBckJpVCI74qcgxRDRrjCt2lDKKC
         lrKTZwiP8fGLE3ILKtIKaf8DzwSEPG+acL3ZMsUmHY9VRfxYudatHn3EbK/484oWDfU6
         R5JmCIsE179cDzTzpxLEDLMlqY5xXsGUMURfusoSSBbIOicrigC6JTLXuny7swoWJbSX
         D5rRsr1AC3AJfYGo3QYa1vvjyzHXGdP5YiCPwoJ5nlVocdZfPMD1OHhCpnwnzftvvG9P
         hLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677883635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQTyZcO6FNqmddoHzVzEIHqpO3JKFdaOcoa693p0iLI=;
        b=S7veRFLkzOLE+f7yyPq6rBgvuJQbkTzppppWOm/85fwFeuVhKdkAXhe9i+33QNGo8+
         xmmn3z65Gibp9PwZaMbrD5f7G4/tHYvk5LkEPp+hJg99mbvAIQ2Bdczu+fQU0g6+pNJR
         k/hgVWzEdciUxGeAqjQwpNr39o9kRyvTkovWhP2ESFeXQEBjq1QGJvURU02fIYRJy8S8
         w3zqGyYs4fSftnlIqjMGhbALmLC7DwPnc7G8P0Q4u73KICUI7L0r0Lau75kK5/nM3PTA
         d7ekd7QAh/CgmN4UGBXmjvyC3/R+6qCfUOKnFaTo5vxcNH3wCOiBdCTGwRkBM/UybSP2
         Qihw==
X-Gm-Message-State: AO0yUKW52fZb6XNyAjuR8RWRxoNUyNqYavAoSamhW92m6eku4WnRpWiG
        iSVFbAiZ/Sl/HwN6ljUHsaJLfmJd0NecNjYtcvE=
X-Google-Smtp-Source: AK7set/ceSNzp69S+7cNWbZnj09upQzochmePhhDJoDjboVTFBTe8YeTm/F/6/I76KsLj2vqbDgnCg==
X-Received: by 2002:a19:a403:0:b0:4b5:8fbf:7dd6 with SMTP id q3-20020a19a403000000b004b58fbf7dd6mr992286lfc.61.1677880700119;
        Fri, 03 Mar 2023 13:58:20 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:19 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:06 +0100
Subject: [PATCH 06/15] arm64: dts: qcom: sm6375: Add RMTFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-6-8c8d94fba6f0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=1141;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uH0RgNHZmHlst/xmB30MnTlB0owLxkAZmTcQ5HED9bM=;
 b=c1OTL8Pm7s2fqz6fkw2Q2S7TqG+CV8SbQ83c236r6ugiZYmDtO1jjb/MmcGNer7UpIO/hJW4Or7p
 yD5jPVsfAKNpR0U15c+u7qbGmyj9QcORxF6TUzxTAufmAE9w5CgN
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

Add a node for RMTFS on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 5a0abb7f7124..2cdd000a4e2b 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/clock/qcom,sm6375-gcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -424,6 +425,15 @@ removed_mem: removed@c0000000 {
 			no-map;
 		};
 
+		rmtfs_mem: rmtfs@f3900000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xf3900000 0 0x280000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA QCOM_SCM_VMID_NAV>;
+		};
+
 		debug_mem: debug@ffb00000 {
 			reg = <0 0xffb00000 0 0xc0000>;
 			no-map;

-- 
2.39.2

