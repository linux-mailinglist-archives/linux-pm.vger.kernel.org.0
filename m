Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239B25121C3
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiD0Szj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiD0Sy4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 14:54:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B6EC130
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:41:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u3so3726529wrg.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVrG7ytRhvfMLwg4sL6jbIdDhYj5gKeUGxhEwn4Bejk=;
        b=ZAC4yqnCU6wxempNAQjukbfA7gdhyP8AD5WocLKEYsl/gZINdkKhmxS+6Z2qcNMADd
         mGOsyczPBem9bXvz6wIfp0Wrg6RVR/OFnMOgte2G0zwYWb8axX09E5A8PFRl75F1P5On
         w2dCiweJHmbMEs+gCfSsr7PB9jYWgVGl7QVtBKtB+/XY2mO88bRGKbJjb2Rd71l30nhJ
         exqWYro7lwYZKkXqwSLahj2abOPV5zQAyUIwVz1GQ91qXC4IUPWY7N/RCpgocYvLQrjV
         5GyLrVQ2Vw6t3gjIDFhEK4U5i1xGGPQBR6xbhCeJ9i7RvREwG9sJusvMGZv/SRPmQzaq
         567w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVrG7ytRhvfMLwg4sL6jbIdDhYj5gKeUGxhEwn4Bejk=;
        b=D6IcRt0srWhqpoCj5ViJd7MrztcvAYMgBX3tJCBM5PM4pmp3NpZEAurrxzAj6AlieT
         WGzKxdqjkMmv1rpuoK+6A3g2qCvGs+pM/jiYWKWtuVyeSUOt5hMGd/q2m6qLvyky5/pl
         K82B+ox2kPtQvp50knEVjIIxjcq4IleZKbXXmrlEmlt54/BMvxi4PUPeyGPvHSkrbR8Z
         Pqm5qnH+1a4IfILVP7CrwFuExqo4v3D4nNQW/mwIpmzmjAyF4dgJaBYBIZcAZWBqC9oP
         TXfIR5rYS+pWPiE3z5immgkEwhZjwuRRJG8T6QawZJmXdodsckl3XynAbiiQEX7g9ZW4
         cEQQ==
X-Gm-Message-State: AOAM531mnKSNvgCc8hkrGo4cwZG5ewjxbNvMKlOrqAQpsqNbrYFRhZNs
        Bp6xQfn57OqMWHZiYoqUStlIUg==
X-Google-Smtp-Source: ABdhPJwfIY1q/Y7VLG8aAarDaGGN9RFvQqfUgeR6vZl0dr1HP1xURjBNjME2pLvudhLaJr2H/jheew==
X-Received: by 2002:a5d:6211:0:b0:1ef:85dd:c96b with SMTP id y17-20020a5d6211000000b001ef85ddc96bmr22790270wru.456.1651084882164;
        Wed, 27 Apr 2022 11:41:22 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d64c3000000b0020aef267950sm1992798wri.49.2022.04.27.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:41:21 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 5/6] arm64: dts: qcom: sdm845-xiaomi-beryllium enable pmi8998 charger
Date:   Wed, 27 Apr 2022 19:40:30 +0100
Message-Id: <20220427184031.2569442-6-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427184031.2569442-1-caleb.connolly@linaro.org>
References: <20220427184031.2569442-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable the smb2 charger driver and add a battery node to report the
battery stats correctly.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index b3b6aa4e0fa3..1a5e127d7a43 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -109,6 +109,14 @@ rmtfs_mem: memory@f6301000 {
 		};
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+
+		charge-full-design-microamp-hours = <4000000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4400000>;
+	};
+
 	vreg_s4a_1p8: vreg-s4a-1p8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vreg_s4a_1p8";
@@ -302,6 +310,11 @@ vol_up_pin_a: vol-up-active {
 	};
 };
 
+&pmi8998_charger {
+	status = "okay";
+	monitored-battery = <&battery>;
+};
+
 &pm8998_pon {
 	resin {
 		compatible = "qcom,pm8941-resin";
-- 
2.36.0

