Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD74E6E0E51
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjDMNRZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjDMNRX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 09:17:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5613E
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 06:17:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o29so3148518wro.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681391840; x=1683983840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9pQrW38n6jH3lAaxTQPjhAzjBmtv9LEC6ladjD0geM=;
        b=S7JJaJQUgf3JJMM3lkyNLH6OBAtESwaKX10aoRHX2UHUKIe7kHl71MFD9fMexZwcVm
         js9oqmJK84FHyccqwePq0s81Xs5Llc99VqL3yJa89LysqOxb1TZ+o3XkJccAr7UM5kHg
         uYE3J2LaMLkTIOlZ25D49b24vuz3tJIRIxgV9XhWFJ75pXshAWWjwVgi91cKDUm/QrTP
         a6NajHr9w2FG23SQm9u5M7KCsaQRpXgGnKAgUi+Aq/dVSLzNFaWS/L3gwCXtc1mnvZCX
         bWuEGGuYFy4SoBkZ/rla4B0v5bSJLjOwo7OhIiJXgHBsDJ7e4xKuw4iYhYHaWO/va+B9
         RYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391840; x=1683983840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9pQrW38n6jH3lAaxTQPjhAzjBmtv9LEC6ladjD0geM=;
        b=TjfQqZb9Y+VOlq0p/ooWx+JqUy//i7x3mVfEmGyMPfaF0fdJUCoFjvkV673uJoyZYx
         pVFH8c0+stVbbXu0lAw1nxVcWVISP9eT45ODSovaUvHQ4xtlQS/nkxE7+nADDS02yVRR
         QqsOJ4fk8i4eR9QQPwOwEl7GXtdj3I3XABHZOkk0139tzyrUYHhboGbsQeYcYwr9Q2ID
         I3tIyl37lLjkR4Yn9woXtHUdqhZDUFCGjyhlVBEZTTTUZeErFOk4wwfduDn25n49WcL1
         5zh7k9yM9BPcb0uxgOhdrNnHo6lOZE6lo89GxTU6EgyFY75xj73+fcMi1PcHzgfu6z28
         ZqNw==
X-Gm-Message-State: AAQBX9coDIsusU5yzdgfWH99Zl9J+PSx9VDVNcLNpIKTTQRE7h8/jRka
        GhoppUn6ag434+cPKrJOn1Ohqw==
X-Google-Smtp-Source: AKy350ZyvWh6DeTmvqd0RAb8r3WiahK7Z/XKVX0rCaM+oS4kQ7JeGN7DdSu52htk6753FAxZuxYjsQ==
X-Received: by 2002:adf:f04c:0:b0:2cf:e34c:a229 with SMTP id t12-20020adff04c000000b002cfe34ca229mr1797769wro.8.1681391840666;
        Thu, 13 Apr 2023 06:17:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:814c:fc8a:da02:39ad])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003f04646838esm1796400wmh.39.2023.04.13.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:17:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sa8775p: pmic: add the sdam_0 node
Date:   Thu, 13 Apr 2023 15:17:05 +0200
Message-Id: <20230413131705.3073911-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413131705.3073911-1-brgl@bgdev.pl>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Parikshit Pareek <quic_ppareek@quicinc.com>

Introduce sdam_0 node, which is to be used via nvmem for power on
reasons during reboot. Add supported PoN reaons supported via sdam_0
node.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 5abdc239d3a6..49bf7b08f5b6 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -88,6 +88,14 @@ trip1 {
 			};
 		};
 	};
+
+	reboot_reason {
+		compatible = "nvmem-reboot-mode";
+		nvmem-cells = <&reboot_reason>;
+		nvmem-cell-names = "reboot-mode";
+		mode-recovery = <0x01>;
+		mode-bootloader = <0x02>;
+	};
 };
 
 &spmi_bus {
@@ -133,6 +141,19 @@ pmm8654au_0_gpios: gpio@8800 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmm8654au_0_sdam_0: nvram@7100 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7100 0x100>;
+
+			reboot_reason: reboot-reason@48 {
+				reg = <0x48 0x1>;
+				bits = <1 7>;
+			};
+		};
 	};
 
 	pmm8654au_1: pmic@2 {
-- 
2.37.2

