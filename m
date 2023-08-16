Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986BC77EDA7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347128AbjHPXGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347150AbjHPXFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 19:05:45 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A62D54;
        Wed, 16 Aug 2023 16:05:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-586a684e85aso76752587b3.2;
        Wed, 16 Aug 2023 16:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692227124; x=1692831924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oIXoXw3iCQERPKiCUkp1m6V9XHgqy/WrG1QNjvjRs0=;
        b=FAxyotBfThY6ofuOJGH82km1ykRWdeowkyDRnu3Oxc3GLBdrIRJWWFg99QZ/8A4aNG
         L7r2ob9mQgaJwwUcvhzU/3RVfeUAQNGmDPYCoPpTCd+RrQe9RQev4RsxAUsEOGL8yjua
         6wCT6/xyuiLnH7fWhF0XrbmrBkAn8/PIz1fcKR1YeJnXLoap8fzcmJSQx2Q7OisKPdA5
         Q2WfLMNE2s1hT6frAXlM5PESWYYI1Q6BeSTEtbyDwpPS+rooXpcbZRC/nO9lHpXcKW3v
         48qRt+oPWaROBZa+ZtBcIe6iEJZW+fwGIsl1n0EcDuD1va8XVbm/uOvdf1ZC7QowGAjj
         U8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692227124; x=1692831924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oIXoXw3iCQERPKiCUkp1m6V9XHgqy/WrG1QNjvjRs0=;
        b=JeRal+/gyrk9r17X5B9A+lunNkuIzYe179Ml9dH+Gfu/nL11LBJHkIwpGC5TVkq3Nl
         jOLNsAuTC9OK+GICLusv7SN4T2TAac2PubRIvm5Gk2fUCSPF37K0y4JPt1zSJP/R+udE
         aEkYFpj9z4TZUPgkJfhZkDXdEth/0bGHd4RXRN9nPR9O85bhbR1uC6T+Bj7JwzCpJ4jp
         xT4lAKjEPZA0kP2T8J7W+qrJoi8nNP9+5SD02Tn9cuak/r9l36ECapB4mCoaeu1n1voX
         twziGLdE/H6Hkj0njjCaZ8Fqsq9Y/0C/QpcAonMZCwpt3gBBYPCVlXxlQMw/vPUS7+FT
         2BmQ==
X-Gm-Message-State: AOJu0YyQOtc6/tEYG3Q0J1CqHA+JC/sPoqUlsWSJp08r1cOX6uNlYO3t
        UvT18yMVctCVI+6mKVEtULY=
X-Google-Smtp-Source: AGHT+IE9pQnDKsbZD8oda8/yH/+xl/gQYMxi/COGfADsQAVYMh+llqa0WP6cK8Vo2J7OWR7uds9WQQ==
X-Received: by 2002:a0d:db89:0:b0:589:ea3e:304 with SMTP id d131-20020a0ddb89000000b00589ea3e0304mr2781437ywe.35.1692227124071;
        Wed, 16 Aug 2023 16:05:24 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::5ee])
        by smtp.gmail.com with ESMTPSA id u63-20020a0deb42000000b00589fb1f296dsm1574075ywe.51.2023.08.16.16.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:05:23 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm670: add specific cpufreq compatible
Date:   Wed, 16 Aug 2023 19:04:17 -0400
Message-ID: <20230816230412.76862-9-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816230412.76862-6-mailingradian@gmail.com>
References: <20230816230412.76862-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The bindings for the CPU frequency scaling driver require a specific
compatible for the SoC. Add the compatible.

Fixes: 0c665213d126 ("arm64: dts: qcom: sdm670: add cpu frequency scaling")
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 84cd2e39266f..dae426b08e86 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1531,7 +1531,7 @@ osm_l3: interconnect@17d41000 {
 		};
 
 		cpufreq_hw: cpufreq@17d43000 {
-			compatible = "qcom,cpufreq-hw";
+			compatible = "qcom,sdm670-cpufreq-hw", "qcom,cpufreq-hw";
 			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 
-- 
2.41.0

