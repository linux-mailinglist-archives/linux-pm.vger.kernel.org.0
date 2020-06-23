Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C60205A38
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbgFWSI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733304AbgFWSI5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E3C061573;
        Tue, 23 Jun 2020 11:08:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so2065651wmh.4;
        Tue, 23 Jun 2020 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohValdVxRvvh6aqrpMpmYg4qV2+S9kNyoOWHWloB/ak=;
        b=jTRxaysyBS8dV09lAA6JLpCZVZm391Lx/XTsiqjQ2xU7Hnbw0P8qTm9sOmTIcLZJPz
         SGCxXr1HP4TnKP4CCV1E61JzYJz03egvyN05PxkGmbq8oYehVdQAQpgwVzPzBRdxD319
         09Na+5NranAcO0JZs5n2ixMgvsoqxSQRBIjKCnVok+mDy/NjlG8MbSSfjmQVREF7gFLd
         CmPz/oBJku8YQ9ZU4EDsCYYi7CuUIgofLlKejynssRpuHm6+kG05QNcpQf1iyRZ9+50+
         tRZFqRhipOQi0+vYEQKr28knAfJu6OmUUkWNoDIc60gmNft09o4UDC916rJ3GOS1aryb
         4OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohValdVxRvvh6aqrpMpmYg4qV2+S9kNyoOWHWloB/ak=;
        b=VDVVI2itWNMS2Lnjjk/ZSeCpNe4lXlUqSalSMNiwr4noxFvDkZvNVE1+wgcYFEtlQX
         wsTKE7CaUrBAJjSPZLwJS93GI0473zj9qDpLx2aZtwLi0i5syPHJXM+aCWn9BK4LP3Hb
         eTh4/aSpXGdGMmiRxbTq8ZNcYXqmgxllD5LQXGZ5aflFY0tEA63O2YY8P8iptcCFJkHk
         fc3Cks8fXISaMiTRub5LAx1LPLwhkn+MPHSwzHZI6+fUd8hB2wMFhSTRXQXW8k0tB7vV
         4vEjIg1IGpg0Gq6aMoZOCfvC1EMqFSFBSLbnmvr37RXVg/81noYHZNXO06vGiFGpBU8b
         OYRQ==
X-Gm-Message-State: AOAM5313S1sE0SLuyfwIy5HgCHAr2G+JJ7bX3zUmhA/06W71N2UYASqJ
        sw+llDwygxcTUU0TeAeiJDw=
X-Google-Smtp-Source: ABdhPJzGMfxzv/fIS+kxcuoagxxxwWqFYU0tXuqxrUtS9uBEV0HnzHOIF2Z0EUHh2/p511fDG+BSUw==
X-Received: by 2002:a1c:2901:: with SMTP id p1mr26351547wmp.144.1592935735115;
        Tue, 23 Jun 2020 11:08:55 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:54 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: qcom: sdm630: ganges: Change addresses to phandles
Date:   Tue, 23 Jun 2020 20:08:32 +0200
Message-Id: <20200623180832.254163-9-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623180832.254163-1-konradybcio@gmail.com>
References: <20200623180832.254163-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This brings the DT in line with the style used
in other device trees.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../dts/qcom/sdm630-sony-xperia-ganges.dtsi   | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi
index cf2e8b5d60e8..12d4d1c25027 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges.dtsi
@@ -13,13 +13,6 @@
 #include "sdm630-sony-xperia-nile.dtsi"
 
 / {
-	chosen {
-		framebuffer@9d400000 {
-			reg = <0 0x9d400000 0 (2520 * 1080 * 4)>;
-			height = <2520>;
-		};
-	};
-
 	/* Yes, this is intentional.
 	 * Ganges devices only use gpio-keys for
 	 * Volume Down, but currently there's an
@@ -27,14 +20,15 @@ framebuffer@9d400000 {
 	 * Until then, let's not make the kernel panic
 	 */
 	/delete-node/ gpio-keys;
+};
 
-	soc {
-
-		i2c@c175000 {
-			status = "okay";
+&framebuffer0 {
+	reg = <0 0x9d400000 0 (2520 * 1080 * 4)>;
+	height = <2520>;
+};
 
-			/* Novatek touchscreen */
-		};
-	};
+&blsp_i2c1 {
+	status = "okay";
 
+	/* Novatek touchscreen */
 };
-- 
2.27.0

