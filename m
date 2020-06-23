Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF5205A42
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbgFWSIw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733250AbgFWSIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF54CC061573;
        Tue, 23 Jun 2020 11:08:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so3815708wmi.3;
        Tue, 23 Jun 2020 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SbSS6Q7ih4Cl9fLtFlG7XnZcbimVHNnRw1LIqkjYrvc=;
        b=Dh2KPp6dWusUM2ed5XBU4NsjAVmtV9V9mgObKv4pnPlyVn1u4kZ0AbYWWjE3b0grG7
         fYHnQYvxBwkAt8LEKW+ZVCDQGLcwWJp9KvLDTcIPN0cu87o4xCxJy+5kbU9T6YHv+0Ac
         b7O1/RXuU7//rTqEpM2PZJYJH38twNqZWtaBDbLtWFkm5wmhP/Kk1A5yRSrhRe5kwTVW
         OKcYyZMv2VWEfTtnYYXSJHVJqgRjzBsLtBFtcLsR2TdjliOWNHMg8AfFf8HGr62PHV74
         wn5uO3BBQ+ekt4dFfJd/rPNhWmRLbQkEHTUvLzzD2vLuaTE5aERT1NmiZJHAFKl24cxD
         NHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbSS6Q7ih4Cl9fLtFlG7XnZcbimVHNnRw1LIqkjYrvc=;
        b=BpQ7SFQ4s2BW1OZN+E+McV9OxCg3pBLeavXP3HGQ6c7GGR8nFBp8KOxf+OivvWf/MJ
         Rk3LcWgbyR0GIhIukiKWf1ivaHIrWD0lx4AHCOqYNIsMUvRnS1Pp4izpPpXvnhlB4/6U
         xbShBLrK+Jh8WmCWJp8TMj8IuDNhm/fspl3dOn9AUgaSZz3VKpz7FZ1Qvre1j3UosrIP
         A6cKaEGBcxz8GWlYOx2MTHkiJL2HoZ5Seaj3+H27qgI5VrWwGD5KqUwhEjOynkXmbyaX
         TJ9cFXAPvpPYFWfnkYRH9PAcZEmQHWUiwjA68H8s6YiImgXxiS/AA8LXRHBCPB9lc2Fb
         w2Ng==
X-Gm-Message-State: AOAM531YH5yeHK1IiX2f+WQZ5mMKTo3c4Uh1oJUjZkIXlPfkz98BnRjI
        e3i+YPUe5y3D9VZ0RPEQCII=
X-Google-Smtp-Source: ABdhPJyeRdw/97iNmtdCxvCJTdk4jETW/ttvMyIxkChAIxc17cUSyavRu3Uve54U+pI5thqu376b2g==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr2880386wme.50.1592935728558;
        Tue, 23 Jun 2020 11:08:48 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:48 -0700 (PDT)
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
Subject: [PATCH 5/8] arm64: dts: qcom: sdm630: Fix the pinctrl node
Date:   Tue, 23 Jun 2020 20:08:29 +0200
Message-Id: <20200623180832.254163-6-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623180832.254163-1-konradybcio@gmail.com>
References: <20200623180832.254163-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously present pinctrl node didn't show
problems, but I have in fact misconfigured it.

Fix it to actually enable the use of GPIOs.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 92bf4ae6a590..25c18edcb1fa 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -582,14 +582,18 @@ tcsr_mutex_regs: syscon@1f40000 {
 			reg = <0x01f40000 0x20000>;
 		};
 
-		tlmm: pinctrl@3000000 {
+		tlmm: pinctrl@3100000 {
 			compatible = "qcom,sdm630-pinctrl";
-			reg = <0x03000000 0xc00000>;
+			reg = <0x03100000 0x400000>,
+				  <0x03500000 0x400000>,
+				  <0x03900000 0x400000>;
+			reg-names = "south", "center", "north";
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
-			#gpio-cells = <0x2>;
+			gpio-ranges = <&tlmm 0 0 114>;
+			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <0x2>;
+			#interrupt-cells = <2>;
 
 			blsp1_uart1_default: blsp1-uart1-default {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
-- 
2.27.0

