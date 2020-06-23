Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A6205A31
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbgFWSIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWSIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13FC061573;
        Tue, 23 Jun 2020 11:08:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so2962461wmg.1;
        Tue, 23 Jun 2020 11:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bxtTT24XCUFSEzo9TJrraJWvnIZVMAljX8QaOMq9yc=;
        b=Jcx19HzyIeI9OHcm1n3h/bdnMyZhZPsIz9dXVeWTPlkqRHbGjaiwkPQSlbpVHaAq9U
         CVbyaA965pR0hgK8AsZBvZs7O3cgqmQ+dYfSsH9s54t3Ym4lkh4qRYAHog0MV+dSgt6r
         D+82qr8AsbQaltWWzUTmTm10mfD5BABAj6MmZuWpz5Np5a9LbBcBpMGK6j59s6aLPfLS
         DZWrwPND6IqZs8XUFCfEkOVcZMRVVXUcy40J75VdLoMuZQm/vgjD9/zxex4Xf5fAlY/l
         x00C6YN+E5dP4/G/hsDLdiZKmOM8Qs1DynorU3mSCCx5QXbifidrze8vgMtliSRRqUmp
         2MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bxtTT24XCUFSEzo9TJrraJWvnIZVMAljX8QaOMq9yc=;
        b=uSgKMtCkSfd97hzegaoh5bKjNYKB6iDbwqrIc0cHkCP7oTO5Ddy8SMnYi2GTGx1EQ8
         MqRHRw0zdSFwenH/EkQgwcVIXgcv6fz73rHp8AGrp4++mLVdfpPqoRzfRX/zZqWXMqzl
         5AMgwMEMGAWXofF+oQ+zIdKeVBs7jFviTgvpIeE4o2jg22CWfUso5XDRpWbxkO30XrAs
         cPdZURO7lFI16CqsA1HZD6fHdBg1fBoF8L+Fy2tkMlwtCDETU8i6oFC6se0ZycdKPq+S
         W75hsDd3vJqG1+f/OvvKLuT9DsC9ndHqP6nKWuBNh1oKdrOAjsP0R+J7G9P4VMynCB7w
         ZC+A==
X-Gm-Message-State: AOAM5305ennSJ5VbdhUckHhxyQ+8k4TJXVfcOER3danhO0uBEy9cdfNr
        Ibn2Vd+wdYfaE4Hlckjtpjs=
X-Google-Smtp-Source: ABdhPJxdGyFnxemry6uyd0/iseA2W/X2LRPcYYo/8lFhH9JKSLyNtNM7oIsZIaiTOMX0cylU15YRhg==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr19448487wmi.75.1592935726407;
        Tue, 23 Jun 2020 11:08:46 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:46 -0700 (PDT)
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
Subject: [PATCH 4/8] arm64: dts: qcom: sdm630: nile: Enable BLSP1_UART2
Date:   Tue, 23 Jun 2020 20:08:28 +0200
Message-Id: <20200623180832.254163-5-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623180832.254163-1-konradybcio@gmail.com>
References: <20200623180832.254163-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the second UART interface used on this board.
Also convert the DT to use phandles instead of addresses
to make it coherent with other device trees.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     | 50 ++++++++++---------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 9ba359c848d0..de06fa809488 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -99,38 +99,40 @@ removed_region@85800000 {
 			no-map;
 		};
 	};
+};
 
-	soc {
-		sdhci@c0c4000 {
-			status = "okay";
+&blsp_i2c1 {
+	status = "okay";
 
-			mmc-ddr-1_8v;
-			/* SoMC Nile platform's eMMC doesn't support HS200 mode */
-			mmc-hs400-1_8v;
-		};
+	/* Synaptics touchscreen */
+};
 
-		i2c@c175000 {
-			status = "okay";
+&blsp_i2c2 {
+	status = "okay";
 
-			/* Synaptics touchscreen */
-		};
+	/* SMB1351 charger */
+};
 
-		i2c@c176000 {
-			status = "okay";
+/* I2C3, 4, 5, 7 and 8 are disabled on this board. */
 
-			/* SMB1351 charger */
-		};
+&blsp_i2c6 {
+	status = "okay";
 
-		serial@c1af000 {
-			status = "okay";
-		};
+	/* NXP NFC */
+};
 
-		/* I2C3, 4, 5, 7 and 8 are disabled on this board. */
+&blsp1_uart2 {
+	status = "okay";
+};
 
-		i2c@c1b6000 {
-			status = "okay";
+&blsp2_uart1 {
+	status = "okay";
+};
 
-			/* NXP NFC */
-		};
-	};
+&sdhc_1 {
+	status = "okay";
+
+	mmc-ddr-1_8v;
+	/* SoMC Nile platform's eMMC doesn't support HS200 mode */
+	mmc-hs400-1_8v;
 };
-- 
2.27.0

