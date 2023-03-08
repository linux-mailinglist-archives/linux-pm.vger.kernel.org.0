Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EEE6AFC58
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 02:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCHB1l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 20:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCHB1g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 20:27:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590AC87DB8
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 17:27:27 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s20so19459599lfb.11
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 17:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678238845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKOVO54SiVpfxv4+5zgH7MWB6ZLGjxgqeNl0uxBicO4=;
        b=qYx+PK8xju6nmSnWKlmCpbBpWZJQjs2PqTpuOqky6k3t1bnVBvYm80xxP7q8l3BhoA
         JIgYo5/l/E8r2+OnIq0kFtpRePwPfV0/zKM6w9+Quq/cquXG5afX06BjI8G6k28w7fqT
         KTbz1KH5rr8i1C1ChoBJ6Jm1K10S3W6dgH0AwdWGhdDNEM2J7UTfmlM33C8R2HEeeVzV
         6bzINX9G2giHg3wzwktG0l6ONP+MjmyNdbJ4v4316OYv3Pgd1tIvgcGy3pOs33TSH58Z
         dMXWt0TQq925km6cDa2QH3/J2nm+OIZysld5DeshBOqw/h1akQWyAB+SOrrOnoXbRESp
         Iknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKOVO54SiVpfxv4+5zgH7MWB6ZLGjxgqeNl0uxBicO4=;
        b=gr8/KG1cU7PKJmWSX/i601ZjJ3oyKC2DTF55tjltY07YmXEuIDp3ecC0xzAvsdUexG
         pNnDxcv5bmHg5Q9NWwMWky7ZjfX1fokD7XsLAkSLOvp8F7k+yAV3fakimt2+BrpgufBJ
         +kzbEAP1yRbB+H7Rj2/BBSPIzCk5dv+s0NgA4XtXYTsJeCcGyARxsP2ZU+a3GImb3YLG
         7nE5abULSCXC0NXb7dFxeA0Yy3QSY95mbrinQfFsseWJLL5Uhy5gxw+InDIbzCK5AxE3
         3aZosQWbAb/cQasXAYrSSqenFhes0stvK1K2DFjpSSlrXOrovpOfArOIQdcVMi6Q+43k
         skaw==
X-Gm-Message-State: AO0yUKUwy1WZ2OOk28Hcipmg7JGNLO83GrkQUj0f9kswyncmuLl37JcO
        oVq5STieib3v2jDgD00MmjQhnw==
X-Google-Smtp-Source: AK7set9UqDkj4+BXq1sW1C5c0COf2YrAQcsUo3O44VivI78Hc2B/mpXTUhVDiHer84R2120h5ualjA==
X-Received: by 2002:a05:6512:951:b0:4b5:1545:222b with SMTP id u17-20020a056512095100b004b51545222bmr5028114lft.47.1678238845611;
        Tue, 07 Mar 2023 17:27:25 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b004a2c447598fsm2182944lfb.159.2023.03.07.17.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 17:27:25 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 02:27:03 +0100
Subject: [PATCH 6/8] arm64: dts: qcom: sm6115: Add SoC-specific compatible
 to cpufreq_hw
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-topic-cpufreq_bindings-v1-6-3368473ec52d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678238834; l=756;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RU8Ns/8Vu4I/6Nvy8BWPrvWThEZ3MktRh9CnLyJhBWs=;
 b=oBwciSdBkhIqhFhs8iBQeo0lNm052icB/7xOxOj6O0CmrW0YEdR3Ao5cGx5szEXNko2lSVzEIFi9
 yseFhglbC61p9U3g7l2FNVaC4ZFBbm/me9vaEXAe02WZXZS0Gz84
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
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 4d6ec815b78b..fae30bf31e08 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -2114,7 +2114,7 @@ intc: interrupt-controller@f200000 {
 		};
 
 		cpufreq_hw: cpufreq@f521000 {
-			compatible = "qcom,cpufreq-hw";
+			compatible = "qcom,sm6115-cpufreq-hw", "qcom,cpufreq-hw";
 			reg = <0x0 0x0f521000 0x0 0x1000>,
 			      <0x0 0x0f523000 0x0 0x1000>;
 

-- 
2.39.2

