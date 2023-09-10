Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98E8799E6A
	for <lists+linux-pm@lfdr.de>; Sun, 10 Sep 2023 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbjIJM5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Sep 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJM5t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Sep 2023 08:57:49 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47DBCCD;
        Sun, 10 Sep 2023 05:57:45 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso1126650fac.0;
        Sun, 10 Sep 2023 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694350665; x=1694955465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgwfLaYSJ5WLNmQQVlnmctv4wdhVxz6XAmlsUYvHCyU=;
        b=kAs2YlizvrT7+AhqbtYHN8ypbGj0lHSRUjexb4OT4ollPzGGkQlOuLmeaHr7auZ/DA
         w62zZqBW16TvhPo8QxplU/t3oXudROdQbeo4GAekAdKPFdR0WVOR2aCQm6CU7vPvTbvL
         nu55DQj5qW7aXhXl9/zo6ufLcbeWwxRUwcL7L6GQsD2h/rz85G3zB1aIOWBXVuV4TvlL
         mnapSlI/iBJNHPAqjdaSr6igCtm9bqj9V00l8P/9/yK1tI97foA0LFyo6mxpEg3F/N6g
         ggoRUM7efQxAf/2Oll4+xCQ5bFnKohLsQLdFzS8FgwF4jukjHC7xDQCoEPAat7DcQ+xA
         ALwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694350665; x=1694955465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgwfLaYSJ5WLNmQQVlnmctv4wdhVxz6XAmlsUYvHCyU=;
        b=ZLAbVB7dWdgpNNPu8XwXDR1DkfEHO+51Z8BIdXSvyhiyh7NWfhzNCQzBJe7wy/hlFm
         6UyBobzlf166NfdCYD3SXcbfoA6ZilaqlsCWB8suqWtlh2siFb3uGMfinZ2SAaOPAukI
         ZjemaJTYDMT7f/w+SJhigQbeSz+8ZdnWNUULZc1vAnjBs+afrAoHBNaMMilbe/O8xrd9
         +wVd7JQ3221aG8u8WrjH6vcJem+ms8uy4nYE7dW2jutKd8k76hoHj/BhlomuvIGKBAuy
         YFiUFIQKiY3squTXzXdMbD1YmVDs1TluL7nNEuBj69mSCBPr5JFUQSOcwzh+K+HpxikU
         MoTw==
X-Gm-Message-State: AOJu0Yx7BZ/BRkMX8zi9y2pqGFKS9YPToZKWbMo1ij+p6x9qk86LmFtk
        Iw6rKuskT1+eFhMV1CvNBEU=
X-Google-Smtp-Source: AGHT+IGQYCYevNYPYqdUE8fLe1mdOJ2joHXFt0x+hbNSkhZOhcio0Q1nFxqVJzMl5p0v01YSKVGXWQ==
X-Received: by 2002:a05:6870:970f:b0:1bf:9fa2:bfa3 with SMTP id n15-20020a056870970f00b001bf9fa2bfa3mr7252379oaq.1.1694350664922;
        Sun, 10 Sep 2023 05:57:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8ae8:e729:67d1:f8d9])
        by smtp.gmail.com with ESMTPSA id y2-20020a056870e3c200b001c4ede43955sm3003140oad.31.2023.09.10.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 05:57:44 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/2] dt-bindings: thermal: qoriq-thermal: Adjust fsl,tmu-range maxItems
Date:   Sun, 10 Sep 2023 09:57:26 -0300
Message-Id: <20230910125726.1243652-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230910125726.1243652-1-festevam@gmail.com>
References: <20230910125726.1243652-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

imx93-11x11-evk.dtb: tmu@44482000: fsl,tmu-range: 'oneOf' conditional failed, one must be fixed:
	[2147483866, 2147483881, 2147483906, 2147483946, 2147484006, 2147484071, 2147484086] is too long

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Reduce the context of the schema warning in the commit log.

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

