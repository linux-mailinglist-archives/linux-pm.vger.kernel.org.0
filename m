Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F813E5134
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 04:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhHJCzR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 22:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbhHJCzR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 22:55:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52FC061799;
        Mon,  9 Aug 2021 19:54:55 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a7-20020a9d5c870000b029050333abe08aso6637590oti.13;
        Mon, 09 Aug 2021 19:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTuSMH4A7Ffb6ZlHMh0V3hg0lEYSc6xST4UQtOrkdPg=;
        b=Mc8XzRnKYGwBFbKGq0j1Ioq0aMvAl1z7h8aGveQLoAawDFeikygiS+FmjQGTkn26vh
         4BgmKsfTk5KVrMfxGHzRS3ql0ZXfzscKc49wgFpeZPFjE0V/Yg+McqqW0P39yHbLU+ht
         uUAQuiDfXpuXiC3CZcmH9eGUDqI6egyuAkbiQmKEZbeb6B2dQ78+1OrW89Xsk0/LwYIQ
         IAX0+mwqRcmC8f+r13bw5mKSxvfuK6RHEB9Udcjc3ldzIUfso67veXp08xMTdNre26ot
         4MqAl66bsCfJhxY3IeJFGb93PEVee1q+CrPnuJeFe87a5Yan+kvD16DqNKhXBtoZ/qlO
         le0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTuSMH4A7Ffb6ZlHMh0V3hg0lEYSc6xST4UQtOrkdPg=;
        b=TZvy5SMkn81u8XzjFMmclLFVTM0LkCrD6h4tpJc9WPw80jEN15p++7MoiT3C6AI6Ve
         W+gPIuugyDuBzwKzG9ejX3XKp7nC+eonQMhrjISqQgiF/U1T5rCDY1Q21t4dQMevmpL5
         BpV1/gbLxlN4BL5kPW9EXbGMgGBADwobHkmGgd0ndMzjt4uH4H+69zrcWmDu5joiWsHu
         RaaTfkHGDy8uS5NAubktxmcXP1HDuawE6ZplaDn2ld+QAuIT9DrkHhUEDb/kPlzmF2Y8
         nTK/LFihvqz9ZuoKCCy6CXa0l6cnrxeuP9HvUjjVIRk9GwkWBrDvL50J+xQc3s8/i392
         Javw==
X-Gm-Message-State: AOAM530lunSQY3J6K+cuFBONJN4O01+AN3Z2+yJOgTDMr8MYpNdnM+w2
        BfKKn4IWsBgQ7tYvyA/EXX45Gzsd2+s=
X-Google-Smtp-Source: ABdhPJwlRVu7yKGk3mooNF1L4OP8yzSS8BwyFARWD8TW5wtBBXh6+oSlKwOLSOpq7w6GK3rgAQJJww==
X-Received: by 2002:a9d:67d9:: with SMTP id c25mr13471087otn.65.1628564094777;
        Mon, 09 Aug 2021 19:54:54 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id h187sm3654898oif.48.2021.08.09.19.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 19:54:54 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, lee.jones@linaro.org, pgwipeout@gmail.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v3 4/4] arm64: dts: rockchip: add rk817 charger to Odroid Go Advance
Date:   Mon,  9 Aug 2021 21:54:36 -0500
Message-Id: <20210810025436.23367-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810025436.23367-1-macroalpha82@gmail.com>
References: <20210810025436.23367-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add the new rk817 charger driver to the Odroid Go Advance. Create a
monitored battery node as well for the charger to use. All values
from monitored battery are gathered from the BSP kernel for the
Odroid Go Advance provided by HardKernel.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 7fc674a99a6c..aff8d0768c5a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -52,6 +52,25 @@ backlight: backlight {
 		pwms = <&pwm1 0 25000 0>;
 	};
 
+	battery_cell: battery-cell {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3000000>;
+		charge-term-current-microamp = <300000>;
+		constant-charge-current-max-microamp = <2000000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <180000>;
+		voltage-max-design-microvolt = <4100000>;
+		voltage-min-design-microvolt = <3500000>;
+
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 =	<4106000 100>, <4071000 95>, <4018000 90>, <3975000 85>,
+					<3946000 80>, <3908000 75>, <3877000 70>, <3853000 65>,
+					<3834000 60>, <3816000 55>, <3802000 50>, <3788000 45>,
+					<3774000 40>, <3760000 35>, <3748000 30>, <3735000 25>,
+					<3718000 20>, <3697000 15>, <3685000 10>, <3625000 5>,
+					<3500000 0>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -462,6 +481,13 @@ regulator-state-mem {
 			};
 		};
 
+		rk817_battery: battery {
+			monitored-battery = <&battery_cell>;
+			rockchip,resistor-sense-micro-ohms = <10000>;
+			rockchip,sleep-enter-current-microamp = <300000>;
+			rockchip,sleep-filter-current-microamp = <100000>;
+		};
+
 		rk817_codec: codec {
 			rockchip,mic-in-differential;
 		};
-- 
2.25.1

