Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36FF662D6D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbjAIRsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 12:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjAIRqI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 12:46:08 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1F620E
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 09:45:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so9007585wrv.7
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 09:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xAI9+hoDQl0gIh7l8xjgLBDEEAheVpkPOXXZU5K65s=;
        b=vYbo+RN3IGIu1L68Mz0sVQN55VEVH1gBBcL3Vu4WzbeG/l2jIlQavDLsZ/CToOaRS/
         LJHBGqpoUrr/dUM7bcSuB+J5slqte28SpJxPDWLaSrmIPTWlJ2VOU3Dw36JFCZotwIsA
         hGV0TYF8bxY3Uv8s5ICuE8q8E5JNuQq/9OFBn9vDxP0eTt6t9YU1xTFhq6WvGZzb9RQJ
         uTnGj8D/vweiySCvPNmghB6zAAhRYGoeLGLNyb7cLgDLi7FwtyV0FQvbaemqXvJtHPSB
         fjrCJo95Eb3A9AVv1aUd5hYfNi4Zz4L+h4GSLOUiyB0wzDRMRlwmLyreYx0PSlVL6Hqa
         8xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xAI9+hoDQl0gIh7l8xjgLBDEEAheVpkPOXXZU5K65s=;
        b=gFZm9/iaPndh1J/4KSnuqc0ueh1lMvCPYTcEpmKbbwKe6XOKMmuGhBiriahJzTBWmQ
         86F0EVAlm9VVoj7iTELcucXTypoxU+gVS9FzCX4ZVx3aORZfqSliZINM970Q2j5JxMiI
         +WlBZAWfZRmvEdNgOjbhq9SHaKxcgp7oxQuynmolr74tGMcwzXY/918qHfEy/OVO+uQl
         lhNVVODSJq63vSpAs27tr0XGrEKkApzwCyFSczZKbLNSrRndzwLjKNUfCI6zQjpy0FhN
         KOxk+Y7FTWxYGjTpOAm6iPMpN703aKuyLhDjGMI3oKRovphee8E9ZORoSekc2B4oIkNa
         Jehw==
X-Gm-Message-State: AFqh2krSdeLgxONy8hTn2uNbfhLAfrNzmcOhu9v3AcCvXBTqOQlvNtUw
        AyIT2bzhMkcZ8Jm9QvWgCTm8bA==
X-Google-Smtp-Source: AMrXdXuywrgYvo8ydXRYPt5rGyvaKqhiKQwnIcogX2OYu/GqhT0DVMV+fYyJIw6l0/lBt3+fmqdVQQ==
X-Received: by 2002:a05:6000:228:b0:2bb:e8f2:5d2e with SMTP id l8-20020a056000022800b002bbe8f25d2emr3679182wrz.51.1673286349720;
        Mon, 09 Jan 2023 09:45:49 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 13/18] dt-bindings: power: qcom,rpmpd: document sa8775p
Date:   Mon,  9 Jan 2023 18:45:06 +0100
Message-Id: <20230109174511.1740856-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230109174511.1740856-1-brgl@bgdev.pl>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a compatible for sa8775p platforms and relevant defines to the include
file.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 include/dt-bindings/power/qcom-rpmpd.h        | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 633d49884019..1778d9851510 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -30,6 +30,7 @@ properties:
       - qcom,qcs404-rpmpd
       - qcom,qdu1000-rpmhpd
       - qcom,sa8540p-rpmhpd
+      - qcom,sa8775p-rpmhpd
       - qcom,sdm660-rpmpd
       - qcom,sc7180-rpmhpd
       - qcom,sc7280-rpmhpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 1e19e258a74d..3117bf7d5ebf 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -4,6 +4,25 @@
 #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
 #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
 
+/* SA8775P Power Domain Indexes */
+#define SA8775P_CX	0
+#define SA8775P_CX_AO	1
+#define SA8775P_DDR	2
+#define SA8775P_EBI	3
+#define SA8775P_GFX	4
+#define SA8775P_LCX	5
+#define SA8775P_LMX	6
+#define SA8775P_MMCX	7
+#define SA8775P_MMCX_AO	8
+#define SA8775P_MSS	9
+#define SA8775P_MX	10
+#define SA8775P_MX_AO	11
+#define SA8775P_MXC	12
+#define SA8775P_MXC_AO	13
+#define SA8775P_NSP0	14
+#define SA8775P_NSP1	15
+#define SA8775P_XO	16
+
 /* SDM670 Power Domain Indexes */
 #define SDM670_MX	0
 #define SDM670_MX_AO	1
-- 
2.37.2

