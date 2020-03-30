Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353531971ED
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgC3BLG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:11:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38702 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgC3BJk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so16277661ljh.5;
        Sun, 29 Mar 2020 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EC82F0fSy3SGAzZ5vo6pkiYKuzU18mbiBELCUdjdApo=;
        b=aAfRh2hPeJ5U8aqPYvJk9kV4DbkEc3hB2h3TgpqjZNydVjAJl7Tvnh7VWeRlsUZNJi
         RqmVtFDLMuERdmbPCWaM5BIBv/Lo1hIu6d3UpKM/dWrbvbanJU0WUzwNqOxIldVRGwtV
         CRCs/cOWwqqxiYHAigdROhOK01KYBKVOLNWyZaMeictkfj3voWItSh6IOAzzZUHZS3y8
         cAY04+Pwpn8yyTpXMvNFGSKr9QtWsLszeDFNmvZpqeJiUpXLecaUAzkUx1SpHsVAnNAs
         63Q4ugparHN/KsR8ZQ9fAnrDXAWF2TB+YrtREY/PfNXjz/fPCV3ejgYYL2zrXKFTQvdR
         V3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EC82F0fSy3SGAzZ5vo6pkiYKuzU18mbiBELCUdjdApo=;
        b=ekkxO4554kXpnzn5deurLCouLIJXgrLlxWHHlkC3lovEzkQXKuIZrly5d4DQnU0L4u
         8nhybfe8tjoYhVfllTfIhhazi4N6Z+aS7lU+0yEnO/y966xaZ0H1GUo5eKxmhVs4kH3r
         cYfnGcGFACgFxHeOS/gbLGfu73oxEhDr09G2slTX9mTMFPyU/o68kQNEBRlWA6u6ZxrM
         mw9Knep7QHPldl1AlLACSn8vnRr/ETTMkr7N5v+1boObVwROeL8XituyHzvHctck4oo4
         LBnsGh65q45fFPktjV25A3H+chyD08v1HOdg19Zhh9JKMkzVqunR+qNz6fSMCz9aQTC3
         lG4w==
X-Gm-Message-State: AGi0PuaWGUvi9DH33VxVOaNHagjeCmFFJNHjpWDYIw14RiO85S+q9PpR
        iQIKe3J0Kwfw752UkJRBb9o=
X-Google-Smtp-Source: APiQypK+LJHCIcBln1YFym+wyJQvikaZ6KKCNt2Pt1rTIIshYKQAwMhdCBctd/5zaYU6dVLvDlO7AQ==
X-Received: by 2002:a2e:9d83:: with SMTP id c3mr5746993ljj.3.1585530578298;
        Sun, 29 Mar 2020 18:09:38 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 04/22] dt-bindings: memory: tegra30: emc: Document new interconnect property
Date:   Mon, 30 Mar 2020 04:08:46 +0300
Message-Id: <20200330010904.27643-5-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which turns
external memory controller into interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-emc.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
index e4135bac6957..2d7aed245552 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
@@ -31,6 +31,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  "#interconnect-cells":
+    const: 0
+
   nvidia,memory-controller:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -217,6 +220,7 @@ required:
   - interrupts
   - clocks
   - nvidia,memory-controller
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -230,6 +234,8 @@ examples:
 
         nvidia,memory-controller = <&mc>;
 
+        #interconnect-cells = <0>;
+
         emc-timings-1 {
             nvidia,ram-code = <1>;
 
-- 
2.25.1

