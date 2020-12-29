Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931D62E729E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 18:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgL2RcJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 12:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2RcI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 12:32:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E1C061796;
        Tue, 29 Dec 2020 09:31:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id x16so19010397ejj.7;
        Tue, 29 Dec 2020 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdDwrQdREUWjQQ38ek4QAiAhdk257aoXXy59w1MRvOA=;
        b=QEKnbY79sTegMdqOm2AKm9aZQf976pJBuilkII4eQlZXHt2Hw3DL9j8OMJIpQWjozy
         /LumL32xXJTeoFeo5ByKQQfwb9er0RP3Q4d4NmKK68pB5Cc7NwGZao4VcKMhPsw9dzhO
         PkDyngTPR/SKOFEpFyn9IBSi1C1gXeQ3QbzlTqZ0XnC3dDlo7rSRS0ORICDSwr7BmSqN
         BGAeHsNIqbi/o+zpPk2mQTZ15cr3HoasfLAwNI/PNcrmWAM6lQ+P+CzWXu75max/C44M
         m8hyu3SplkB/uqax1G1MPg3XuPL17KyqodSy9O8BWUuzThgTZp6lzG20lIeKKhXOGeFu
         h4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdDwrQdREUWjQQ38ek4QAiAhdk257aoXXy59w1MRvOA=;
        b=B2y7NK5btHPBR3xqGd6gVBv/ECzHxGT8zA4wNGfozHsaJCG9ngIcgTl8G6Ej5HXBEp
         SblGwfUfbE5Bwt7NwmCld38yuwq580wG2adRpjDdtIjxW2SKBEcQo7ciIIFnOm+WqG6O
         ntQDwsu7k6I+aJqVi9wBDcqR9z1z/eXppbD0JkY5k9ILO5gKQaMycvw81sVfgMn+86cn
         rYdWZq8PEQE68M1udlCT+tDm5XWumJ8H/MEuuehNpZGVl5VfbLtL2K6sUYvSsdqswiC4
         GyCtTHVlBJHQYRVTOt3M5MzA21I8jyU8cvRsnr4RJbj/kud903f05rXl3fEa7hPhmAEQ
         tEaw==
X-Gm-Message-State: AOAM530kxZSHnCQvw5Bda65OJqDYlf10LgJ3aQVlqDa1i/pxyP6hMYmn
        mURAPS3JE6cyhcBIrUQttrA=
X-Google-Smtp-Source: ABdhPJzXvjnVv3P6kGMUG3T+BnJNSKijM8jHjUdis3XvKGQnESb6YeRzcnlU366qJq1apEhYWXyiLg==
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr46836642ejc.216.1609263087021;
        Tue, 29 Dec 2020 09:31:27 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id q25sm37385362eds.85.2020.12.29.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:31:26 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/7] dt-bindings: input: Add reset-time-sec common property
Date:   Tue, 29 Dec 2020 19:31:16 +0200
Message-Id: <90ca662ad709dd53d18e11885c4234817627184d.1609258905.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
References: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new common property 'reset-time-sec' to be used in conjunction
with the devices supporting the key pressed reset feature.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
 - Added Reviewed-by from Rob

Changes in v3:
 - This patch was not present in v2

 Documentation/devicetree/bindings/input/input.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index ab407f266bef..caba93209ae7 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -34,4 +34,11 @@ properties:
       specify this property.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  reset-time-sec:
+    description:
+      Duration in seconds which the key should be kept pressed for device to
+      reset automatically. Device with key pressed reset feature can specify
+      this property.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 additionalProperties: true
-- 
2.30.0

