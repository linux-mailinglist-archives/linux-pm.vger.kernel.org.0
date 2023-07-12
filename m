Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71CF7504BC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 12:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjGLKgX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjGLKgG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 06:36:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84B26B9
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 03:35:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3752152b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158141; x=1691750141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFjFH233scMmITorrcsknOFXDQIt6REL4AFr2F5rKyQ=;
        b=lIVCmzfiGwhfAfz2uGWIeowYRjp8+snpOAbDHq407AwZMTnzrc4J+wx8Asm+l7qzDb
         kCTgBogsYRUG8pjm+WjahHIJXlxP7tiPbqIS7C+nbGG0Kb9D62m0DetF5ThSudMjWwvT
         WVCwixX/CMN5IgU70Mud2LkOqVxlYiculIKtHSzA54JOwl2RUid3c7aVbZu8J/P3718D
         7C7BqRfMWICwRutqA46xEBikGgHEHZgX/Gif8d6cLcp1gQqgk/k/9fY2I6t9SdRduQ12
         X+6AwX1HvRIZHPuBA1XMlfXTlwwQb4Hb8Wyv2/oe7EMQ1ljuWj8IfWYlDgEz9paL9dG5
         A7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158141; x=1691750141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFjFH233scMmITorrcsknOFXDQIt6REL4AFr2F5rKyQ=;
        b=CvDGv1V93E5Nb5nrW6MdCCj2Q7eokXE/tIkWXkyfFZo4Lq3zTPe3Ur/vJp5MciJS36
         KBZEJhjL/H7Z+a7e/Hl3vHZcXp/HLRhs/K7fXmAvKzEllm0DbBLD4x8bsZuNuAZ5RKEt
         s8VR+zfwbrUn9uO+87+DFQYYiNEAQByWjNKAX4QtBpUHaUFceSZJJDEyvo0w1ln5iACG
         gPyQv8NiBqeToPHwEj62+Qp3nqjUrwHGi1QhCj1nVla1kbN7MBmgdunQsfwIN6xMctRx
         Ixdn0oHmpBNwpF+9rFlV5j4nvYQoLne+vnaKubBUU7KNQ49NOcETtwKsE9V8y9rVLs+N
         fm3A==
X-Gm-Message-State: ABy/qLbcdtuqAZZJ+uvaXWTR5vEuu95VlWySNvnmMDhu2yZq6PsUtt5b
        To1Z9yXwJppA/yHS1K7iHEkm
X-Google-Smtp-Source: APBJJlHucdxTMqfscWol8RUreM0FmijLjojt9xs1ggj8CN1q3gyLLdtC5SLntjVqsk0CbUiftfpcbg==
X-Received: by 2002:a05:6a00:3920:b0:67e:bf65:ae68 with SMTP id fh32-20020a056a00392000b0067ebf65ae68mr15634358pfb.3.1689158141166;
        Wed, 12 Jul 2023 03:35:41 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:35:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/13] arm64: dts: qcom: sm8250: Add interconnect paths to UFSHC
Date:   Wed, 12 Jul 2023 16:02:10 +0530
Message-Id: <20230712103213.101770-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UFS host controller requires interconnect path configuration for proper
working. So let's specify them for SM8250 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 72fd66db9c51..7a495ff7512f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2197,6 +2197,10 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			operating-points-v2 = <&ufs_opp_table>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
 			status = "disabled";
 
 			ufs_opp_table: opp-table {
-- 
2.25.1

