Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8BE2FED9C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 15:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbhAUOzf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 09:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbhAUOyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 09:54:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A31C06178B
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 06:53:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j18so1684850wmi.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 06:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4wdqxJTegCBCyudkxp306qF0hGkVyYVDvgQVJoeSCk=;
        b=i0TAZnF8mXhOlA8h4KBwAMX6kIijqujfjhv0IlCDx/80JiwI/iVBW/rnEiZDNQrF9x
         PrQwSWDBO6L4bgJDXqGaQau+AK71C7/x3rbNhVby2SfvNI+nFzUfNZ5MYtIrryREyUeu
         1vdYR8vDFWIT938VboG27nf6IhAfshWBgi+bodT+PQh5bx6XqqGuMaJV7Nr38qT8GiVf
         MmZNLldBCoxLKnT7m4PM+Kv66bd3g0Z2qycOkmjjTwv/OvBHsmIpUh4BIG12FQY50hgQ
         iICzC75+YJsi0puJMBduKi4qHIp0JD/JcXKTDiXWzWZwVjcTkfU0Mb9bDL1NM4yyz+hf
         +a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4wdqxJTegCBCyudkxp306qF0hGkVyYVDvgQVJoeSCk=;
        b=h6hPaQNrf31isdW4WtSiWbO5VwUryTY+cdXc7hrjPToH8eAXGCa84Kq1nSsoKlLvBV
         HFpSWna6w86dsMe/7QMSU+XKFb2kVX6cxDrkEpI927c4rDN3FQdtCDREwhb9lITFrPJT
         sTRcBjdcmWC/JRQ0fj6UA+rUa7jiBodpKYrMdFm3Mb97s34Jl7aN7eqzmsRnnxiaUiij
         c7RyKzSjgNnqR/rEYBnrUcsgKT7+1g9U3zyFOkK692scF4Wnk19iff/ZKT9oVTCy8lx3
         WzLM0CHg8Yfm/HZyKOXjBHdq8rUIVWAIMpXYQ1ycneTtniU795NKDkKSOU0HR69THxio
         VcsQ==
X-Gm-Message-State: AOAM531EWy5RlCCFXXA8q+Z4WpYVyX5togYF2Eypk+YY1vd/gHgiiriS
        j/RGz4VyzR1n6Cp+i/3DxWJxvbMuIJSvcw==
X-Google-Smtp-Source: ABdhPJy14pKkimPBMZLcUFcqTO3N/p4HlHo4oRUVSxAy0QmPrmPmNPb2zeKLFfOScJlLR6sJ9dDdEQ==
X-Received: by 2002:a1c:9844:: with SMTP id a65mr9394986wme.113.1611240797414;
        Thu, 21 Jan 2021 06:53:17 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a25sm7921770wmb.25.2021.01.21.06.53.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 06:53:16 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] dt-bindings: interconnect: Fix the expected number of cells
Date:   Thu, 21 Jan 2021 16:53:20 +0200
Message-Id: <20210121145320.2383-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"make dtbs_check" complains that the number of interconnect-cells
for some RPMh platforms is not "const: 1" (as defined in the schema).

That's because the interconnect-cells now can be 1 or 2, depending
on what is supported by the specific interconnect provider. Let's
reflect this in the schema.

Fixes: 9a34e7ad2e12 ("dt-bindings: interconnect: Document the support of optional path tag")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index f9b150b817d8..799e73cdb90b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -73,7 +73,7 @@ properties:
       - qcom,sm8250-system-noc
 
   '#interconnect-cells':
-    const: 1
+    enum: [ 1, 2 ]
 
   qcom,bcm-voters:
     $ref: /schemas/types.yaml#/definitions/phandle-array
