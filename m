Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3399B185159
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 22:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgCMVp4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 17:45:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40877 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVpz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 17:45:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id h17so11700845otn.7;
        Fri, 13 Mar 2020 14:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWJwxZI/fi+71hyjac5cwcxWIxN5PdXUwOvw7zPGV9A=;
        b=cfOJpVwidcEA/rdgot38aH4yOYCA7fpqc/m/4t2DVG+5cF1wGosy1o3yeoEKMCgbZd
         YKEuC9wjE3PqOUN6AGbLsaKjYSDbuUc8xz72qB32+EqAGrdR6aJC0ORlligF0kL4/I4j
         lHzH62YJ+3MdQ6qf3jJFZ/Y1ph8zDtFmt4f3IsWOynoy4R1ZAvMFUklmHNhTyIaHfF4y
         fPGW7Rt/Tb4LW2KLl7mp/QrSPoxXW0PUqcIm6YvxNZYX3MLVsbitRuepBtJTvWstSasn
         MmjFRLdTJ8Te5oDzkVb413PFJMT+DiYo4ViIVup7fSotM0Ig5bwR0w39UxFiCacHShpF
         Tr9w==
X-Gm-Message-State: ANhLgQ08ZYI787HRl9nkzbTs6XhLut4w5di4vWbHGpzXWX2oBfFUxzA9
        cGbYMg8o00UimxPf0Z+22g==
X-Google-Smtp-Source: ADFU+vute7JWTg08hhBbrVBK3UeqalFgHU7teo6XMDCQ86zY987SkNKcL2RKFdqAQ3zgOaahfxPZ8w==
X-Received: by 2002:a9d:1920:: with SMTP id j32mr12302370ota.221.1584135955148;
        Fri, 13 Mar 2020 14:45:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h6sm11518707otq.63.2020.03.13.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:45:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: thermal: qcom-tsens: Remove redundant 'maxItems'
Date:   Fri, 13 Mar 2020 16:45:52 -0500
Message-Id: <20200313214552.845-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313214552.845-1-robh@kernel.org>
References: <20200313214552.845-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There's no need to specify 'maxItems' with the same value as the number
of entries in 'items'. A meta-schema update will catch future cases.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index c0ed030d0960..62b97a6d9b65 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -43,7 +43,6 @@ properties:
           - const: qcom,tsens-v2
 
   reg:
-    maxItems: 2
     items:
       - description: TM registers
       - description: SROT registers
-- 
2.20.1

