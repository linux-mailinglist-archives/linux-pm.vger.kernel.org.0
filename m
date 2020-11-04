Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA282A6B01
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgKDQxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731453AbgKDQto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A94C0613D3;
        Wed,  4 Nov 2020 08:49:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 126so27996521lfi.8;
        Wed, 04 Nov 2020 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaLXEDjIP3Iag/w2fX7ni9eaMug2cPZsxsXqnpeU2P0=;
        b=jU1LtOKTa1OCnxA2EvAhw8VWIKlCBTqza86WrKpewfv5UDC4XuW4u/3tUQtoiUPSbV
         0qmW5Gbz8IsaDineQtGolE4RHswCgvWUGdN4KfLiwdXip/wQxKn+R/N0StmVgZyqC8lk
         d8BRY3PVEFm4RnqQR1ImZw2IqCL4yRG9VHt+EFVYvKx5pYkxOEy62Gb/UiOMK9WbfMC7
         N0ZS3gGan9v+0JaIAdbEpAmRdy3puZkqFl3nMBmUtJgfBEM4sBx2z05vcxf4w2ybUy2X
         dRtYXwip9CaGjL95VhkB5n8W8ZfO0Q+I7yuDnIyBhRDpM64M99+PH2Mrfe5Q4OripU61
         dMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaLXEDjIP3Iag/w2fX7ni9eaMug2cPZsxsXqnpeU2P0=;
        b=KUOVVjV5xoAtinubtPxbFg4zKJqBQxhD+xj/2FmspIKGb1mIMseSFYJw9RJniLI+EG
         8JXAWnTXI9xJNQLIn1hgQrK/eGhaIFDDtk5pLGojCKTuDSg9RZjf+WsG9PoEQ1Yzuyst
         iNeo970BUz6cSrj69R/D2leNN0kKwoypKdv3tMUESPzTYnvmcdX74lBs/QYKuWfGvV7N
         NTBCpb/VGTyd9L/G1Mvdgf7SXdfcvOIU/sGuYEE4opTkStPeYxD5gwyLX3fgIXUgTiAy
         4in55eEX40NLcybz+kKMxVemZLdQoZqV8WbFfc4/2lEOxnT4im5t9tGKpPbrCwC2tp29
         9UBA==
X-Gm-Message-State: AOAM533y4Y6VOpWHurHYQIEcdRhQMo89rQuVXqJgjQVC8Iy4TNMVTuyb
        qCC7gkFYONraqHcMIZmDzrFWOLrBMjE=
X-Google-Smtp-Source: ABdhPJw14MqYybDzcLqjY71bV/g9tODhxZ1LoCGsAysETlILk8YtOaRXbvBh3Mjq4ifD3OezTNn9Lg==
X-Received: by 2002:a19:e0c:: with SMTP id 12mr10739491lfo.328.1604508582300;
        Wed, 04 Nov 2020 08:49:42 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 10/47] dt-bindings: memory: tegra30: emc: Document new interconnect property
Date:   Wed,  4 Nov 2020 19:48:46 +0300
Message-Id: <20201104164923.21238-11-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which turns
External Memory Controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-emc.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
index 112bae2fcbbd..c243986db420 100644
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
@@ -214,6 +217,7 @@ required:
   - interrupts
   - clocks
   - nvidia,memory-controller
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -227,6 +231,8 @@ examples:
 
         nvidia,memory-controller = <&mc>;
 
+        #interconnect-cells = <0>;
+
         emc-timings-1 {
             nvidia,ram-code = <1>;
 
-- 
2.27.0

