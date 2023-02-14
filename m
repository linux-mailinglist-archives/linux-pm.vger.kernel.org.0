Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10F695E6E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 10:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjBNJK0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 04:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjBNJKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 04:10:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2B2244AE
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 01:08:57 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a3so4365299ejb.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 01:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnnkKXnJ9t7DnYEPY2SUMLg12Ga3VeSpmXZ/jSFU5FM=;
        b=W3Ep99yjBrO0M2WZ0wqaBiqXJWEFGiAIHSmgjvuBwuct05BR3rFver3b5LQUD9oS30
         tAyc1PIMr9CC1t7bECdoowfEkHAtwbkA2sUVdnotInDNwtgG+yH7lX5evgsD8z4FSKJk
         SFvAZJFGEKu43IavWdALapoFI323+sSabcSbbBdMVYbq96neEpOtQLu9K9R/RWXbqrGH
         zQtLycXgrDLP7lzzMtzpJcLdM0s9XlOSCB2F8ybXMt0axFSL7IjPN1UE+3+G2EQT59i2
         yFTSzdFAcpHARD2L+w4sfBrJWgEeMJRjx9NzkgTNziluED3WUXrhaoEmqWgSWbxt/uSd
         JRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnnkKXnJ9t7DnYEPY2SUMLg12Ga3VeSpmXZ/jSFU5FM=;
        b=Qh3QDCZd5Wbu9qF9xnEKMohEuEqtSwcPXRpBUK3AJSe5OR4xqhib2kWd/uDyXxTJVr
         m+VqE3FCarx6qHwlXQiGbQnGs67MH9D/vzoB+1ElglyirxbTmiodOvQHwacdqpT/u2ZN
         F6z8yd175f35gbwWm3xv6Z9Iow0+CT4xx2JPgXKFZ9Yr6aii6PO3d2U9BRAFLW86lIIp
         izW0rMvcaHFQnf0ancf7g7iqOCxFO8oR9qYLnQmHcHwc4u5rmEZ8TmJTlyEWAZ0PiLTl
         M/6vf6wbaQxepMW5L5UrCbsoYOo1+fl7Hgtl48SVRrDHoMkAT42/+bLn104VfKdmLe0p
         gtag==
X-Gm-Message-State: AO0yUKXHLoL4TTzrA6x4Hrg2F9TA26aXwwOTqm46+H5B+hppQiEhCwKY
        FE3dYmY+2Nvd1ZDXo/pf93ebgw==
X-Google-Smtp-Source: AK7set/MbAJYS0NXNV9i7Pc5fr00kHKW4gsDjwFLUqHIx6jwT/ngrM5IolsPOgn2vHN4SNISxQtjjA==
X-Received: by 2002:a17:907:910a:b0:872:82d3:4162 with SMTP id p10-20020a170907910a00b0087282d34162mr1688022ejq.44.1676365736187;
        Tue, 14 Feb 2023 01:08:56 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906040600b008838b040454sm7998110eja.95.2023.02.14.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:08:55 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add a specific compatible for coincell chg
Date:   Tue, 14 Feb 2023 10:08:49 +0100
Message-Id: <20230214090849.2186370-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
References: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
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

Add a PM8998-specific compatibel to the coincell charger and keep the
PM8941 one as fallback.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:

No changes

 arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index adbba9f4089a..340033ac3186 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -72,7 +72,7 @@ pm8998_temp: temp-alarm@2400 {
 		};
 
 		pm8998_coincell: charger@2800 {
-			compatible = "qcom,pm8941-coincell";
+			compatible = "qcom,pm8998-coincell", "qcom,pm8941-coincell";
 			reg = <0x2800>;
 
 			status = "disabled";
-- 
2.39.1

