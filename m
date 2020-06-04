Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8121EDAD9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jun 2020 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgFDBxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 21:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgFDBx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 21:53:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E7C08C5C6
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 18:53:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j32so3932671qte.10
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cx1RfItm8P+5zdZthMwhmTFP4jusIpmaSOa4M7MTCuw=;
        b=PSKnA+A32FTYGNyVZ3JCedIaquwwdMV72TXnPo6jQ5OtwjCTbqy4v+cayuXvcEV+h3
         zdwZeJ8nrs6vtj5J4AFvYymjLdeGkrP7+DzUYcHY3H5dq429Gd+ioqTgp2GB256edagr
         sin0Mxjm1Ra82p1Ny8wMEEm/SuvoitD95Xr3cZVdoYK+AVezR0e+1Prav2RMCe6iU/4N
         j1wM0QWac4RMmJtIRdAVp7wUCmO68mfJzJrebTnWL+k6lvZzFmAdxWU+7SulimOiLd9C
         Jh18p/7qP8dlgFw5GljRiy5MWLAyuGZylM0Pb46DCNgWAaP4u1VrXQ8eo0cUk++O30yp
         R+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx1RfItm8P+5zdZthMwhmTFP4jusIpmaSOa4M7MTCuw=;
        b=VnlIzls8DBWSuF6uh5TTtWRND6XEYyDG7RFOxwZktJfpsnlOZnlacBnfTJQzE1Yd8s
         kCejAfDcrwECfKB3CcIz0aUWXJetBiDHSV5em3LrpjWwo4t4zUOAbaK55xThR/fv8+Jm
         JBgm8/yhqcv4iWTZ6nyJbwJdnf7i4hsWjmvFxsI7peRGCddppnU2DxyZTXebFZZdPcwc
         /tj0Qi5fOXdm3MsJ6qSG3y+rvmXfU9LyBbBWMKsHPhoRzgh7Ndg3T7QDW91o/V6TV4Rc
         xms1FnOVokG882wDGH8TfKQWcf/IW5VpoaLYohDAG39VPwujoH0RttVIPT1Aynqi423e
         amQA==
X-Gm-Message-State: AOAM531kP/hJmouEc+zEJ9vOmnI9dXyPKK/RcbONETT2DmZFySNLTKOP
        F1Zgx/lmWTRBGFD2Z1aP1RjjLA==
X-Google-Smtp-Source: ABdhPJzFuQ11RGaUFX9ez2ZUYVbvhFKr+5CSf9niClZmUapncKEZa/DruY85eifIRSadG1SF4IIQrg==
X-Received: by 2002:ac8:450a:: with SMTP id q10mr2274459qtn.328.1591235608210;
        Wed, 03 Jun 2020 18:53:28 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id t74sm2986439qka.21.2020.06.03.18.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 18:53:27 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] arm64: dts: qcom: Indicate rpmhpd hosts a power domain that can be used as a warming device.
Date:   Wed,  3 Jun 2020 21:53:17 -0400
Message-Id: <20200604015317.31389-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604015317.31389-1-thara.gopinath@linaro.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RPMh hosts mx power domain that can be used to warm up the SoC.  Indicate
this by using #cooling-cells property.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

v3->v4:
	- Removed subnode to indicate that mx power domain is a warming
	  device. Instead #cooling-cells is used as a power domain
	  provider property to indicate if the provider hosts a power
	  domain that can be used as a warming device.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8eb5a31346d2..dcc3bcd16b68 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3854,6 +3854,7 @@
 			rpmhpd: power-controller {
 				compatible = "qcom,sdm845-rpmhpd";
 				#power-domain-cells = <1>;
+				#cooling-cells = <2>;
 				operating-points-v2 = <&rpmhpd_opp_table>;
 
 				rpmhpd_opp_table: opp-table {
-- 
2.20.1

