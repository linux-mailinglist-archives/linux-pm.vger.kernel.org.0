Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971A43F4803
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhHWJ5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 05:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhHWJ5J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 05:57:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B58C061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 02:56:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oa17so11613933pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BE8fpo1IPS4WaWbrwgpc41ljoGnxNleD3tBDfDXUpo0=;
        b=sz+peK4yTihqrtfujr5xRqIz2KrBhobv12Ch5iDT8DGX7NnQeA7O1xRCHOW2gMFBIE
         4ETbeDs4DG6XwO86vHdBQu7v6jNpXzDdiKBgorpJNbK0PC2rxAeQoXlc+zegg6w7zup/
         cq0k3S10ibsJS/TPP9g240umJMnRyR7DzpJ3lmRXwsswl++f4+2wsaOv6yUDYQKhYyfM
         64y//vVUgSmg9bUZFVEKrbFJZmwwzhGu/p9F0tMJUbjULYoW5IH1o+Wjo25aPDWWm2H2
         JFpt/HhGrQ7yG6aajTyZBcfGPoNap/tpfO49j08+v8KlJOmpRvYiq+Mf6bjr+Lyth4E+
         jlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BE8fpo1IPS4WaWbrwgpc41ljoGnxNleD3tBDfDXUpo0=;
        b=tCjPS9dgyKXHyTft5LqcGgTRzSfiOk9bIJGyA2ap9oU+ugKTlg5WEditrlbMU0fDBt
         mvE5ZjSdJUupLFlufO6rB98EUYkXTQtuvj3gqWmzxCjb1GLtPlzTkdOStw2TWHW+J6h/
         3+DfkfvU0vLcnlArrbdbQfpIVYspVaWWIxvfKsTzOHqL5jEKfozVgHfcRqw6wBiNm51h
         2YTb++WckSpU0ZOAmULezqu1Y8ZQHAQbWqnWNiPNOP/dK8XXOxQu5NNiETdT1Vx/Kmfn
         oWhaUKvQ+T9Fghj+iFzXjPGpd9Z7nKymQmFLhhblPSY2hfKglaanzJECCv0EllYfwRN/
         FO7w==
X-Gm-Message-State: AOAM532IlJiy0Vzj8idU0pdHEwThPhuKIqMiU041l3Xodlbn7Ur5DoKW
        0Ptr6elH8LhYRL5i0dYpxJAPTg==
X-Google-Smtp-Source: ABdhPJy7rRyrNJodAJlJ/B6G+mmbDon4rhd+aXew8owetNGutwnIh8IWn1M8vv8FcfrEwJJpxovwKw==
X-Received: by 2002:a17:902:db0b:b0:12d:bd2c:6e6e with SMTP id m11-20020a170902db0b00b0012dbd2c6e6emr27266933plx.26.1629712587038;
        Mon, 23 Aug 2021 02:56:27 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id z24sm18708230pjq.43.2021.08.23.02.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 02:56:26 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sdm630: Add missing a2noc qos clocks
Date:   Mon, 23 Aug 2021 17:56:03 +0800
Message-Id: <20210823095603.5538-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823095603.5538-1-shawn.guo@linaro.org>
References: <20210823095603.5538-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It adds the missing a2noc clocks required for QoS registers programming
per downstream kernel[1].

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 9153e6616ba4..b3a7f3bf1560 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -652,11 +652,22 @@
 
 		a2noc: interconnect@1704000 {
 			compatible = "qcom,sdm660-a2noc";
-			reg = <0x01704000 0xc100>;
+			reg = <0x01704000 0x1c000>;
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
+			clock-names = "bus",
+				      "bus_a",
+				      "ipa",
+				      "ufs_axi",
+				      "aggre2_ufs_axi",
+				      "aggre2_usb3_axi",
+				      "cfg_noc_usb2_axi";
 			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
+				 <&rpmcc RPM_SMD_IPA_CLK>,
+				 <&gcc GCC_UFS_AXI_CLK>,
+				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				 <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
 		};
 
 		mnoc: interconnect@1745000 {
-- 
2.17.1

