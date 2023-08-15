Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550A377D619
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 00:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbjHOWb6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Aug 2023 18:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbjHOWbv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2023 18:31:51 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB20268F;
        Tue, 15 Aug 2023 15:31:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64189860374so29778276d6.0;
        Tue, 15 Aug 2023 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692138698; x=1692743498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OomGyd0GSBAwNJRjE2nyNQobuXxIzf9X/MGFA0o94qc=;
        b=Ck8mWeH0ribxy+qr3OidONH5JyPv7xIFKC2ciBSri5aPQUIagF3mUH/BvJXeZGALvx
         M0bwwDwIukJhUyWzQ2torPCOQfEE2I0gZ98yv+hNsR3U+dyB/xEGvrH6091eXxMe0q00
         NYkjSmp2DMXQ4+8ZJE4Bq3HaoVhc9IhTi8DbyD2v3o/r6cVnebtAsDXxtZ8Gp8lpkxV+
         OAVSWEQIvnePmhOK9kAubM7WoJRhrs7UZepjW8o2Yob85U4RU3gkcen+utVb0LuaB+U9
         44FNL837ZNqAsJyul50lL/qRbTXKWzQbg5DQidhEdVbLTq9kAVY7FdwsKe85p5b2+/kD
         Rqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138698; x=1692743498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OomGyd0GSBAwNJRjE2nyNQobuXxIzf9X/MGFA0o94qc=;
        b=GaabPj80mfbZRB7sgo77u6ktYNvyGCt3u5T5PclM3DexJ/mMiNGAkLzoHa1UScvZZJ
         j8F+1BPk4HxV91ScjKWOBN4WvhTqenGGojSJW261JkXFQsGTB2bcE2U3LEdJaB1XSR+9
         KNlLiCkyRBSUUPXVFHuXF4OcM8ewwsa4wRzkF4lN0UTHf7mo9dGDKwx6ArJeRUGNfSyz
         Qsf55SL5jS6QLtipojh2fgpGiYVA7rW1oDTRTACzrRVjnMsBxiMmaE6JDi8SYzRCMV3E
         7wMwR3BB+QcnTDIqKYtWkFCo5fr+O3qYLx2URR4aXqihjEjHBC13hCZx1Lqq/qeePmUT
         94hA==
X-Gm-Message-State: AOJu0YxtbXzM75PSuNwp/5YZxRRzGdYBGMqZed1ukF2QckV6nEBbVRXT
        pf5XPbyuzRlZRbbS94yBqnQ=
X-Google-Smtp-Source: AGHT+IFegE5lTvsMgT1ktCmwoJXrg2/AmOYJ/uCDmR0QRlT/ZQ66+uLEXzzOqreVhTdhfXteleyepg==
X-Received: by 2002:a0c:e246:0:b0:623:557d:91ba with SMTP id x6-20020a0ce246000000b00623557d91bamr98231qvl.34.1692138697814;
        Tue, 15 Aug 2023 15:31:37 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::bdee])
        by smtp.gmail.com with ESMTPSA id e6-20020a0cb446000000b00626161ea7a3sm4474507qvf.2.2023.08.15.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:31:37 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: qcom: sdm670: add specific cpufreq compatible
Date:   Tue, 15 Aug 2023 18:31:12 -0400
Message-ID: <20230815223108.306018-8-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815223108.306018-5-mailingradian@gmail.com>
References: <20230815223108.306018-5-mailingradian@gmail.com>
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
index 0ac39d3d68ca..77ec0de08c2c 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1520,7 +1520,7 @@ osm_l3: interconnect@17d41000 {
 		};
 
 		cpufreq_hw: cpufreq@17d43000 {
-			compatible = "qcom,cpufreq-hw";
+			compatible = "qcom,sdm670-cpufreq-hw", "qcom,cpufreq-hw";
 			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 
-- 
2.41.0

