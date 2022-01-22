Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D45496C88
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jan 2022 14:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiAVN0D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jan 2022 08:26:03 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44424
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231774AbiAVN0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jan 2022 08:26:02 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D64BC3F19E
        for <linux-pm@vger.kernel.org>; Sat, 22 Jan 2022 13:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642857958;
        bh=8fMesucJS/Q/CHcDtWavokH1YLXI1OKktuJiUdUDTLs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=GzUqFmu1KOVpaDKr/t6akjdkqEqJ/4Yogf0L3IYwdf5ZGHVkKF0jd7ZArvD5hziWz
         1SLwY1frzkw+5n5sPzk/xEiADGOTGuTJ2EGR6ntRBeLKhUlX1MY1EFKcZzY3xew6Ad
         UcneQ0zSEWePdFi09Aq8X6wx8wcaB+J3r+mRIo3jzi+p0xtaKAAcsp4jPGwDUOKsjZ
         QJ3z2Qdq599+pd8aWbiYtcSUBXVp1Q6gDTNeGMIIGaytXcHHUjpZOhvLps8VDiwCYg
         dKXkucRU+wsRvt1GHhRrF7xhhjKPFk91moFSEyjeZglNcAXkfV3psYlaKxJmCCl8xQ
         gEx+Ltddsm+YA==
Received: by mail-ej1-f72.google.com with SMTP id q19-20020a1709064c9300b006b39291ff3eso948546eju.5
        for <linux-pm@vger.kernel.org>; Sat, 22 Jan 2022 05:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8fMesucJS/Q/CHcDtWavokH1YLXI1OKktuJiUdUDTLs=;
        b=nIoTTbBGw8IimlJ6nEeFyNRUJm8uwU5XbRVS8N46tqFQTIYMTFiB2soQ8Vn7H0QBi9
         Kksf7aXf0JGi1IvLLebcgV/WDs7Wi+O5o9vYiQy/tEpJ4fpu/H5HXDeY7f8c+yLi4bRM
         7+vMPdml59jFTtjDRsp6S/OsKzwlsXwPLGb/jj+6MATVbAmR00ZTCmUbGK5F7lFewT4H
         Z51xSl8zXuOREadVfwTzG16g6Egbw86KdwVuaUUP55kzEZVgONGx0czWeUVlW2W47s70
         4eDpx+n3UVfzCDjsS77LPdl5tPhxt5uBsm8OMLet6JJ3ZBJt+0Tmt2soknGCbmHO86ol
         soUg==
X-Gm-Message-State: AOAM530rNIejTm2o31tm2umfkpaiEMwOBLj5Ow1atpW5hPsnNRdwLFVb
        YjmDvc3ZX3Cm/KyuNQIdGQqcgiIOm0Uog2npGOZfQ0wVzWLQqUR99YKn8tXOk3US4MryBxfJJqr
        /E5azt6gOwaHpCtCc5haEVc03y3Epxl5ZCBYr
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr6700211ejc.493.1642857958428;
        Sat, 22 Jan 2022 05:25:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNLq+wl/T1aIhyqPK0PgngG1nTaJ+rpaL0m5ALl8KOG7N8L+TA5ORWK4t1DsKSjwTs3nbw4w==
X-Received: by 2002:a17:907:2da3:: with SMTP id gt35mr6700198ejc.493.1642857958277;
        Sat, 22 Jan 2022 05:25:58 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v2sm2373060ejb.114.2022.01.22.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 05:25:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: exynos: drop old thermal properties from Exynos4210
Date:   Sat, 22 Jan 2022 14:25:52 +0100
Message-Id: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The samsung,tmu_gain and samsung,tmu_reference_voltage properties of
Exynos Thermal Management Unit driver are not used since April 2018.
They were removed with commit fccfe0993b5d ("thermal: exynos: remove
parsing of samsung,tmu_gain property") and commit 61020d189dbc
("thermal: exynos: remove parsing of samsung, tmu_reference_voltage
property"), so drop them also from Exynos4210 DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

I'll take this patch via Samsung SoC. Adding here for reference, so
Rob's robot will not spot DTS issues when checking against dtschema.
---
 arch/arm/boot/dts/exynos4210.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 7e7d65ce6585..2c25cc37934e 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -527,8 +527,6 @@ &tmu {
 	compatible = "samsung,exynos4210-tmu";
 	clocks = <&clock CLK_TMU_APBIF>;
 	clock-names = "tmu_apbif";
-	samsung,tmu_gain = <15>;
-	samsung,tmu_reference_voltage = <7>;
 };
 
 #include "exynos4210-pinctrl.dtsi"
-- 
2.32.0

