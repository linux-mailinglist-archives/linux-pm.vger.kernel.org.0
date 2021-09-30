Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8641D860
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350306AbhI3LHT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 07:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350311AbhI3LHK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 07:07:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B94C06176E;
        Thu, 30 Sep 2021 04:05:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b26so20760736edt.0;
        Thu, 30 Sep 2021 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Mqq1EJ2H9lT3Ci5TT8crEf2RCsTlu4B8737O9t40fk=;
        b=ctXoSjBkvSIYNULZaa1/V0zomtPR9Dg6hGyso+EDovmgaYUAbYEJved1OfeTZDjx6r
         jsoMIVFfzEgEXtg4ZDNQzkyDlcbUG2cXX28Oor5BNgfMVRzhkznGLlwUKyxC41i0rUlz
         0qxCqfQm9eeFVI+qQbpRezTR8Zzw7pGb9cpBicROrwpunIC0ncneATZnp28rqnrvYiwA
         DuLwhPNGZLnTczsAJbUljTCACCW6ADDdxDo9hhnSoHEZLZbp9S36tQaQeppsrDhKPzgI
         u5iWrGW/oUQ8smSzPXPqamjbW8X8kmCFGoAnobN42fYwMX9AmjY8zJrUluzhcbpqtc93
         fgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Mqq1EJ2H9lT3Ci5TT8crEf2RCsTlu4B8737O9t40fk=;
        b=H+IPqSzsuSCZxX9n7qZ+JeF6ar35jIuxcTvsmsobGXv32KBCqDqLDyHDWh0Z8ENnpK
         Eg95f7pR6twMyRvmCMBvMyqAYdiQvWfrdgD8M7anmMHxX6DYe/ov5socHffPtQvddZAQ
         0+L9i/PBIl+ZBoPFXyuHzcZ7w6BtBlWhoLVZ0WJojhoQsaU1pmn8sWri0ynYsgA9YU3Z
         AFe1ewTKYsd1XDlhTi75pTd7K7IN3oNnbqG3DrONAa/VFSlqe9hCkBe4+Qg6/dVM5O1d
         3kyNyyN2knAGBYa1PuVjv6L4ya0VzLhHfZk9YcGEdAVtnykNA2DpaTJS3I6hwdS+pcS7
         GgYg==
X-Gm-Message-State: AOAM5314jNkfb4vrlNAVxBHoFOb1hVkN7sGo1SUI1ivfjJIQ7fcGWvXY
        f5cM451S4qa0c7vOWu8wzSM=
X-Google-Smtp-Source: ABdhPJwn+zUQkIe2nFFlWlA6BpEh0kKo3gLy3lRh6spCZ8VNO5YuDcImrQXlufA2biBRs2ZX2uzc7w==
X-Received: by 2002:a50:fa93:: with SMTP id w19mr6405648edr.365.1632999926386;
        Thu, 30 Sep 2021 04:05:26 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i2sm1305158edv.7.2021.09.30.04.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:05:26 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: fix resets in tsadc node for rk356x.dtsi
Date:   Thu, 30 Sep 2021 13:05:17 +0200
Message-Id: <20210930110517.14323-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930110517.14323-1-jbx6244@gmail.com>
References: <20210930110517.14323-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the rockchip_thermal.c driver we now get the resets with
a devm_reset_control_array_get() function, so remove
the reset-names property as it is no longer needed.
Although no longer required in rockchip-thermal.yaml
sort tsadc-apb as first item.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index e42fbac61..d013348bc 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -838,9 +838,8 @@
 		assigned-clock-rates = <17000000>, <700000>;
 		clocks = <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
 		clock-names = "tsadc", "apb_pclk";
-		resets = <&cru SRST_TSADC>, <&cru SRST_P_TSADC>,
+		resets = <&cru SRST_P_TSADC>, <&cru SRST_TSADC>,
 			 <&cru SRST_TSADCPHY>;
-		reset-names = "tsadc", "tsadc-apb", "tsadc-phy";
 		rockchip,grf = <&grf>;
 		rockchip,hw-tshut-temp = <95000>;
 		pinctrl-names = "init", "default", "sleep";
-- 
2.20.1

