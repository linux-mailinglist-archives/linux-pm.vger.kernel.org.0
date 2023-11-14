Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E217EADD9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Nov 2023 11:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjKNKUB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Nov 2023 05:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKNKUA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2023 05:20:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394C1A8
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 02:19:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so46947385e9.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 02:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699957195; x=1700561995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1QWKo5v1x3RldbHoETv2ObEXLCGaOLMr/Qq6NkPTAw=;
        b=slwWsjAiu3nkpkU54skAv6EME0H3gWV0VPr+pLTm/kwOi83uBiLdJPhyCOfAnW2oMT
         Mcxaf/tjRuRcuFTcwOH/77MxVbaIdeB6V077IgjR39meWs8SnZjc9rxVVHPAlfFRoVDC
         NDMfyjl1EPdKcHuBpB6G8DG9myrB87sS00CEw7qOkx0OnHS+nld/KvTd/ptm1527KVDP
         eHMtEQbrXLSaoihWdZcVafV/AAzM7bQfrWmQL8Lu+s28BOCQbnKEdRs6pnu17h79caWz
         UxNyTuWWmRSFrBRsPoClx7GdUfGs/wJw8UIXzBTU+pJyO0P3CjPjChf08QuPX0L8khtz
         /IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699957195; x=1700561995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1QWKo5v1x3RldbHoETv2ObEXLCGaOLMr/Qq6NkPTAw=;
        b=oc7KWu1NX8zpnc4sQI/PCl7DrPtGKchks2kHkOCGf+L8gHPYVhcKI/9wbIDudc3Q89
         zGjZ9v1mbcdTHGKE5rgRDOpKa4zcdqcflSy9Efg7TILhJTCJTecxQPY04gPo2bx6raep
         uSxywzDLkgj/qnWmlhjRpDWB6mg3bhVWT7X+RUWQyKtExM7HarP1ya/R8o31uEobYzI5
         mZ7K8okko+KBJWAuKvKCRDuOn01qmelJwSQ3RjemWmrdlJk7JAdYbopQVPUcmPtiLBpk
         7Vq+xSRIsQPwhCOCbLNmiWAvoaqb+V42MRJSNoqlc31sJ46dKCG9Bgpqy7JfhyvQwjCp
         NE/g==
X-Gm-Message-State: AOJu0Ywo2slXtGuVNBqSxQmKlew/9JSULnyxHTQq/lhuYeM1iJ/3fstX
        /LFYspuBQUMaSBh1HYQ645vwKQ==
X-Google-Smtp-Source: AGHT+IEtRy6/1TJjxurvCCcvkAtUDZaID1wnEiQdKSWVWSMY+EUI5ohY3QFVq9O366Nao94h1NMqJw==
X-Received: by 2002:a05:6000:bce:b0:324:8239:2873 with SMTP id dm14-20020a0560000bce00b0032482392873mr5689990wrb.37.1699957195651;
        Tue, 14 Nov 2023 02:19:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d43c9000000b0032da022855fsm7419675wrr.111.2023.11.14.02.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:19:55 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 14 Nov 2023 11:19:50 +0100
Subject: [PATCH 1/2] dt-bindings: power: meson-g12a-power: document ISP
 power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-1-f01e6fca67a0@linaro.org>
References: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-0-f01e6fca67a0@linaro.org>
In-Reply-To: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-0-f01e6fca67a0@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=643;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=TxQCQp8KexETWz0DJ5Ct9muX5KYY3F1pMZr7p8jc1eY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlU0nJN8WGk5SnAfQY6NQMuQ9Y2QaJiEjnrNK28CTN
 3KX/EhuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVNJyQAKCRB33NvayMhJ0c3aEA
 Cojhb5oA95QAfgsCKWFyi0lXKqq0xsdU+OqBoQahY5LJYvKMov4oy1eWZO8JgU4DbIzXZMXKKv8Fvt
 occrcqxosWG/hDs5U5qEdWM5N6PoLVgYtofaqm/7GD9Zsm4GRpqIbFgkFZhXAt+VifzXwgYf4STkMM
 JPYa9O+itDHAOkLyN+kT4Gf9qQunbGaqNQTMs6RMM3Mb6ka6YYRuOm2qopuEv31DE86+U5Cin5TpbM
 xCUob2ZbP5bL9ue2UcHBsFQ7wJ1FKSByJcEiN0pd8TFWZH2zRLkBWORx1knQ2tObqCzNiNdGJucSS5
 i397W51sjErzBVTnBoHLq8Qs6PA8Rimrqdw0LwP6ED+b79yCiyhsjjpRhmiPMO5Wr+iXc7rjWf0i5e
 00UhsuZG8ruOVONe8zi0kr9EdG3pvwdiJ1Mzfg2U/YRgfXkBGotX0w5ww2xnaeUHiw5NGRnd0BXUyB
 2azZ3kOSKNtAxfd90b5GOoDFmUWCRB2g/LStbmpM2Qj4c7MHaA3ItuWkxR2Og6cnAb2ljJk9h0+bpU
 ocgbE9Kb5Xf6R2wytOISOQ7JuzLBW69l91xmGTkCdPVjTQfm4vze8RE/sxl9NI85H4dHaG0kYW+EE7
 V9e26rxwkJdHD74bj0B0B0rXhA79oQ1GRpXDyQPn0YWJJKEbSeYmD+Tu+tvQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add MIPI ISP power domain ID to the G12A Power domains bindings header

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/power/meson-g12a-power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
index 44ec0c50e340..01fd0ac4dd08 100644
--- a/include/dt-bindings/power/meson-g12a-power.h
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -10,5 +10,6 @@
 #define PWRC_G12A_VPU_ID		0
 #define PWRC_G12A_ETH_ID		1
 #define PWRC_G12A_NNA_ID		2
+#define PWRC_G12A_ISP_ID		3
 
 #endif

-- 
2.34.1

