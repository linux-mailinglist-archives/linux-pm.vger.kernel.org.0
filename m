Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A2B75A590
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jul 2023 07:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGTFly (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jul 2023 01:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGTFls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2023 01:41:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0FD2130
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 22:41:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb119be881so2793655ad.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831704; x=1690436504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XqdszzNXl0iGLUqn70eMf6bYl+0XxF6aThipavUI1U=;
        b=CCpuZSLAv4mIw9enQakiM7AssvWm2KvtnySDXhurdzO2yRaaciCQ9Fvyg+f8c6iB2b
         l6pV4U7qiwHYGlO7vQLop7oWoZHnFLMA0HmPyOEsdcu09qdcYRsMgbAoz8egb84mGA/n
         CGopBFTVmnixaUK9NAm0C/ygM/dkjB+dc5P3Z91CMcP5oTu/SZYB8Nd5VpDwChUKX9gn
         KUnyxkG8kLMkKq2/zkz/pD2YTJhvopag/Ebptwz5aE/ihHdgHM0MaQ01HVnE6xJQdld+
         2BpVhylFSAecPrswhy1Kiu3vcvcWEDcmrYhiqTaAIhfqK9XM5+1tw0ACl8Eb7d3/2sbY
         bSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831704; x=1690436504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XqdszzNXl0iGLUqn70eMf6bYl+0XxF6aThipavUI1U=;
        b=kHNpkp8gVkz+U8ELF6zYbWuQy0cihFFWkBeb44eMKltWD4TnPSPisla1ivBM2PqQ9O
         MydpE4RsE5rF+10Z9/0sYIpG+5AI3vlhdcJGuWFLXG9h/cdsml3NwvcMWowPLFPBjfo9
         GPO/c/MOX9qqP2JFrrpmEV80NSahB2QkKOtSg9zeqq9zXktskb04zaShmvte4QOIcuq6
         f4flrQ1xRctFDfH4NjwbAI8Cf1Syn0qDIRCj1IVIqnTe16DQnCCGnmGMlgBPthjc1lZz
         DIueG4LQ2fF6S6f69zjh6YhtyPjV+veZJZSHGAed5TSib2z7BDFd/ZtoskvkbzbdGpZb
         qckg==
X-Gm-Message-State: ABy/qLaama5NsLWD6miDrlqJq9HbYxttN63LbeY/GNltpADVEzrptejB
        8KlKHbQ/G5jEsA/0i15mIQQe
X-Google-Smtp-Source: APBJJlFtA4mXtOl8jmGLyYaSajSP/ArONwQmk0FfD51LF8n93HyBqmCspIiV8+ubnvEC4ZETfoTZxA==
X-Received: by 2002:a17:902:8a8a:b0:1b9:e913:b5b7 with SMTP id p10-20020a1709028a8a00b001b9e913b5b7mr1035999plo.44.1689831704434;
        Wed, 19 Jul 2023 22:41:44 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:41:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 02/15] dt-bindings: opp: Increase maxItems for opp-hz property
Date:   Thu, 20 Jul 2023 11:10:47 +0530
Message-Id: <20230720054100.9940-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current limit of 16 will be exhausted by platforms specifying the frequency
for 9 clocks using opp-hz, like Qcom SDM845 SoC. For instance, specifying
the frequency for 9 clocks with 64bit specifier as below would consume
(9 * 2 = 18) items.

	opp-50000000 {
		opp-hz = /bits/ 64 <50000000>,
			 /bits/ 64 <0>,
			 /bits/ 64 <0>,
			 /bits/ 64 <37500000>,
			 /bits/ 64 <0>,
			 /bits/ 64 <0>,
			 /bits/ 64 <0>,
			 /bits/ 64 <0>,
			 /bits/ 64 <75000000>;
	};

So let's increase the limit to 32 which should be enough for most platforms
(hopefully).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 47e6f36b7637..e2f8f7af3cf4 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -56,7 +56,7 @@ patternProperties:
           need to be configured and that is left for the implementation
           specific binding.
         minItems: 1
-        maxItems: 16
+        maxItems: 32
         items:
           maxItems: 1
 
-- 
2.25.1

