Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8380665191A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiLTCrl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiLTCrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:36 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF913CD3
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:33 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j4so16668835lfk.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hdm4k36lSgKUduI+vKUza9+RFJV80P07x7VO1CheZLk=;
        b=ZEW/q4CPQQh14b5AD4e5WhJRpoFMflEmiGcT1jRaat3wt8m3hAyu8/wTQkCxcjglx7
         1hXpmDgvhK4S+MIkFG/ef9NgmEtmCpxBlnP6Subk1fX1c5kxQfTIS12jb4mwpVO8Rqtx
         wYtzuRl+eHEv7CnHHT22Jog54ovXf8O8jUOcGf1UqfSEvTjog4jZFb5OhrvAAGIu+6NM
         Nq+SoqQ9OXED+ooxObkC8jyX6L7rf8zjRnd2Ixvdq6CCovgiPsDYTyrQUnDqKxOXab6H
         XwWPjz1I4C1LuQJrB66Sfopqwh83TXtm4Y1xAZPi8C34FzHFfoBP9aZYDJkAKBTly/8J
         7AnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hdm4k36lSgKUduI+vKUza9+RFJV80P07x7VO1CheZLk=;
        b=l+22Mc/HwA8tTKdqacnU5tmfnDdMjpQVYiqu78hJjDWs+UQ4OZ6KnCwZqcHaBBAF6H
         Tuw4v0iUtktXCn3ksvP/9LWR1ssw+KHcurf5pUBA6XMq8fwEHFwSwRCwSbfWbrwr3Tkf
         gRnMohxh9PHBZLDC+PT9EtGM9oHOhZNhONcoJNlijft5TetlbMlhww5h8O4f/yBDtZlY
         1+0nYxBwwWyoVk3BMS1fS/fvTHC/974lKrlQULBU0xOEsYBMIkTkZpGdrUo1Ld0nO0xd
         CpIPYMFbzzOwMALDsiVAMn6yeNm9VIq7/75aOHzXONW0hg1JoDKpNrfYufHeByJ6/AtI
         vDNA==
X-Gm-Message-State: AFqh2ko8eaggkDkDLz4gm28vo4/5mHMn3BKFVt9URc2ISl/oGTNynya8
        5Y/jjAqRgvYpveTzaGajmLdlz6BYnaNWjG0Wto0aRQ==
X-Google-Smtp-Source: AMrXdXsAWjhuEkwrPJY9JAVSigEnTsCNDNTNq0Ni4ZYUV1yew2cMGiQwO5LnbTTgKlfDonD+iF7KYQ==
X-Received: by 2002:ac2:5501:0:b0:4b6:fcb9:e467 with SMTP id j1-20020ac25501000000b004b6fcb9e467mr195830lfk.0.1671504453475;
        Mon, 19 Dec 2022 18:47:33 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:32 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 12/15] arm64: dts: qcom: msm8916: specify per-sensor calibration cells
Date:   Tue, 20 Dec 2022 04:47:18 +0200
Message-Id: <20221220024721.947147-13-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Specify pre-parsed per-sensor calibration nvmem cells in the tsens
device node rather than parsing the whole data blob in the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 70 ++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 2ca8e977fc2a..af7ba66bb7cd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -442,11 +442,57 @@ qfprom: qfprom@5c000 {
 			reg = <0x0005c000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			tsens_caldata: caldata@d0 {
-				reg = <0xd0 0x8>;
+			tsens_base1: base1@d0 {
+				reg = <0xd0 0x1>;
+				bits = <0 7>;
 			};
-			tsens_calsel: calsel@ec {
-				reg = <0xec 0x4>;
+			tsens_s0_p1: s0_p1@d0 {
+				reg = <0xd0 0x2>;
+				bits = <7 5>;
+			};
+			tsens_s0_p2: s0_p2@d1 {
+				reg = <0xd1 0x2>;
+				bits = <4 5>;
+			};
+			tsens_s1_p1: s1_p1@d2 {
+				reg = <0xd2 0x1>;
+				bits = <1 5>;
+			};
+			tsens_s1_p2: s1_p2@d2 {
+				reg = <0xd2 0x2>;
+				bits = <6 5>;
+			};
+			tsens_s2_p1: s2_p1@d3 {
+				reg = <0xd3 0x1>;
+				bits = <3 5>;
+			};
+			tsens_s2_p2: s2_p2@d4 {
+				reg = <0xd4 0x1>;
+				bits = <0 5>;
+			};
+			tsens_s3_p1: s3_p1@d4 {
+				reg = <0xd4 0x2>;
+				bits = <5 5>;
+			};
+			tsens_s3_p2: s3_p2@d5 {
+				reg = <0xd5 0x1>;
+				bits = <2 5>;
+			};
+			tsens_s4_p1: s4_p1@d5 {
+				reg = <0xd5 0x2>;
+				bits = <7 5>;
+			};
+			tsens_s4_p2: s4_p2@d6 {
+				reg = <0xd6 0x2>;
+				bits = <4 5>;
+			};
+			tsens_base2: base2@d7 {
+				reg = <0xd7 0x1>;
+				bits = <1 7>;
+			};
+			tsens_mode: mode@ec {
+				reg = <0xef 0x1>;
+				bits = <5 3>;
 			};
 		};
 
@@ -473,8 +519,20 @@ tsens: thermal-sensor@4a9000 {
 			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
 			reg = <0x004a9000 0x1000>, /* TM */
 			      <0x004a8000 0x1000>; /* SROT */
-			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-			nvmem-cell-names = "calib", "calib_sel";
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>, <&tsens_base2>,
+				      <&tsens_s0_p1>, <&tsens_s0_p2>,
+				      <&tsens_s1_p1>, <&tsens_s1_p2>,
+				      <&tsens_s2_p1>, <&tsens_s2_p2>,
+				      <&tsens_s3_p1>, <&tsens_s3_p2>,
+				      <&tsens_s4_p1>, <&tsens_s4_p2>;
+			nvmem-cell-names = "mode",
+					   "base1", "base2",
+					   "s0_p1", "s0_p2",
+					   "s1_p1", "s1_p2",
+					   "s2_p1", "s2_p2",
+					   "s3_p1", "s3_p2",
+					   "s4_p1", "s4_p2";
 			#qcom,sensors = <5>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow";
-- 
2.35.1

