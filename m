Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFD799E66
	for <lists+linux-pm@lfdr.de>; Sun, 10 Sep 2023 14:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbjIJMxB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Sep 2023 08:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJMxB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Sep 2023 08:53:01 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00326CCC;
        Sun, 10 Sep 2023 05:52:55 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5711d5dac14so869686eaf.0;
        Sun, 10 Sep 2023 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694350375; x=1694955175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a+wuJLbWRTyVfU1bagE+bARgYrIJ9juNamK94yJ+QA=;
        b=DoRC9jwOLbw96sjIux1+UFK7x30snhXhOE+o+B26Sd4N50DFi2vOnKzesFZMdPgxEZ
         8GK8qhzqj0X32zoLGdXnUHNFtk3dTspeclcTJz3/ogDi2V6/2s81lwLCQQsBphRl211C
         3m40mWRLS84ld15hLPdTyknfmWZZGPChve+irLKu6sEJUtsKRwh913Rwu5KtcehIa20y
         4QtIyT+zS2SBDB7UEhun4tZQpEx49cMobEvc5+SESPfbwEBQcT+gleS1p/CHJZGHvjiQ
         HcWR+jcQmFM3VXvoWCdaDcT3nzkN8yOBgS8VhxTh9FnCF/TotyLA5L+z2yHbY98pU7Jg
         l+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694350375; x=1694955175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a+wuJLbWRTyVfU1bagE+bARgYrIJ9juNamK94yJ+QA=;
        b=YopOWmRIgCMWLD+X4KtRKzNZPiUmO1LeumdFh7azJfegFO+T4LwcyFwEDJ4D6p4nD/
         DuAcQj9F4khazBN1D8+1fvmWfpaD4azz8Vadgc2NzLjKHPIpOASwFcoNXHV9BCvE/znD
         1XDbsBJvYOusX2Mup6UDFU9OkScc+IX3w2ILxj5oqZ2LBFzA1RBV8gMcEGh26MbmseRC
         UIQdqo8YavPwu8yrMgdGv/Nhuq2tBNLPlQmY56yFZEaWgcYEwnuPWY0/IqpeWDmwC64G
         XcdSNjPyAAojiz1/rlrhwJLIHlksg6O4IXf1NfhOejhaPotMWj/+MHX4DfFkyTEG6n6y
         OIdg==
X-Gm-Message-State: AOJu0Yw92fp2uvsAZBdxMDGmmSRYot1WCQiu7tkAOJYtmf0ZU7MUv7xN
        qYghclSDKVToI9X19tE50ZWbPU0SWSM=
X-Google-Smtp-Source: AGHT+IER5qFqWVOUGzZwOpI1ZWsVhjpL2C1f0zDrs8OSj9TWvQl1sywFldWOM0H94S1ryAcjCV+oQA==
X-Received: by 2002:a05:6870:b014:b0:1c3:c45b:92a7 with SMTP id y20-20020a056870b01400b001c3c45b92a7mr7372293oae.0.1694350375208;
        Sun, 10 Sep 2023 05:52:55 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8ae8:e729:67d1:f8d9])
        by smtp.gmail.com with ESMTPSA id li9-20020a05687c354900b001d4de767807sm2972308oac.28.2023.09.10.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 05:52:54 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] dt-bindings: thermal: qoriq-thermal: Adjust fsl,tmu-range maxItems
Date:   Sun, 10 Sep 2023 09:52:43 -0300
Message-Id: <20230910125243.1242722-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230910125243.1242722-1-festevam@gmail.com>
References: <20230910125243.1242722-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

imx93 has a maximum of seven entries for fsl,tmu-range.

Change it accordingly.

This fixes the following schema warning:

imx93-11x11-evk.dtb: /soc@0/bus@44000000/anatop@44480000: failed to match any schema with compatible: ['fsl,imx93-anatop', 'syscon']
/home/festevam/linux-next/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: tmu@44482000: fsl,tmu-range: 'oneOf' conditional failed, one must be fixed:
	[2147483866, 2147483881, 2147483906, 2147483946, 2147484006, 2147484071, 2147484086] is too long

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index 145744027234..d3734fc66f78 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -33,7 +33,8 @@ properties:
     description: |
       The values to be programmed into TTRnCR, as specified by the SoC
       reference manual. The first cell is TTR0CR, the second is TTR1CR, etc.
-    maxItems: 4
+    minItems: 4
+    maxItems: 7
 
   fsl,tmu-calibration:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
-- 
2.34.1

