Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B05B570C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiILJRO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 05:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiILJRK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 05:17:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CFD1EED5
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 02:17:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so7578657pjl.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VfxC3lsR97ieyPGCHokvUezbB3N1rVvH51NTIDralEU=;
        b=t6PkA6B7cjsKTF9QjdS16ux9959LLtqBhayei1W1Cwu3yqy7Y0GGj1vjwpfUNPR4+O
         7UV9wHIHZSWJisL8dTrYNL9Sr7wzXqkTMIx9UjTrLOmbdKsFLmzp393OGRbw4ztjEo/C
         yB+wYg4GOrK/oiZsEUvM8VSiOmNq6MLfsYGMFTy3cMmYEogzG2IcLPxA3QOeaf00sYyg
         UWjLhY66esZSRsCqpiTJTGgmaF+bK0/BVERLbst7rVrHvWrlEamXQHIXxeVlrj5i6sdR
         7e4n1n5UXByugQRmF3lLwaXr2CdP0WLjPr600g/yrGu2LvlYavYdpA3rq39b/y8Oj4f6
         7m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VfxC3lsR97ieyPGCHokvUezbB3N1rVvH51NTIDralEU=;
        b=sWChY62hfPG0HXgutP0IZ50SWlMjIy/oXcQ0EIVezx8XXIN/KL+dbdtlW0Jd9TDMyz
         687rRSBQSkKbNEiom7v1XG5Qf91/OQMMBwuT36keAL8UzrXF1ansz6bCmDUh9rxYpRGR
         U80CBwJ7Yruastapcf67vkKsJ2jbA16ovEt2N845WyNqOGP5gtOUTprb/V8PE048sAzw
         Ds1ND8GV6dzm85FnP27ggr/Es0rhrHKam5o62Aoi0N3AHm9AIrBbzXpSchSnUMH7OKnO
         dGQaDtJH16F+oi4ww2MaVwszUiH3lCBS19D7GqH6HG6Ua0DKJ9eMif6gs3XxLl64xYkY
         hYgg==
X-Gm-Message-State: ACgBeo0EVd9zQs75sTK8bZk30gp6kkT0F3XcdL2mahTeZT0ICiOsBg8i
        TGJZEUQyKwc/B7zKnSfazxmX1w==
X-Google-Smtp-Source: AA6agR7+uw1CPyq3OB2InUONklyP65utZqSMCqxC4boTNGxiCi96L6MKrhK9oonX7X0durbZQ0hmnA==
X-Received: by 2002:a17:902:ea11:b0:176:b283:9596 with SMTP id s17-20020a170902ea1100b00176b2839596mr25455733plg.69.1662974229198;
        Mon, 12 Sep 2022 02:17:09 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id o65-20020a62cd44000000b0052dbad1ea2esm4857026pfg.6.2022.09.12.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 02:17:08 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        rafael@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sa8155p-adp: Enable qmi cooling device
Date:   Mon, 12 Sep 2022 14:46:42 +0530
Message-Id: <20220912091643.3537857-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220912091643.3537857-1-bhupesh.sharma@linaro.org>
References: <20220912091643.3537857-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable qmi cooling devices for sa8155p adp platform.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: andersson@kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index ba547ca9fc6b..0c5d1fd5bc47 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -364,6 +364,10 @@ rgmii_phy: phy@7 {
 	};
 };
 
+&qmi_tmd_devices {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.37.1

