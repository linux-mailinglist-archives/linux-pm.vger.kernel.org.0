Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A440C2441F8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHNAH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgHNAHZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE3BC061757;
        Thu, 13 Aug 2020 17:07:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i80so3925212lfi.13;
        Thu, 13 Aug 2020 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2EFJxFHRRzm3oVjJIWeziT+lWBzLWjopR8bsePJKjY=;
        b=gCLmokeJ8inUJ64Wv4qZoc9xBFaNU6P54dhzlUIu5SlzNuE5ZDDqIAdu0Gnkr2vBSf
         yvhv83NVNMlBt49BK/TThw7IQ2KUdyCQwfHLOkPkbQMseIz7k81oA60MDiaEPfZXGWAZ
         g+H8DYJ+DEn7Gm3vwqups1sBZ17Xc2U64wXre5DxnK+5j+pbil+6qN7JQ02tDIhXXIZu
         ojHm1J+UMxK+iR6aLjRaBm+dFThXqiOGpiIWqsRwSTp7hKcwucfCPHH71BiA02jUnU75
         KtBbOpZNSjrruXOKE3EiNa7SnbGd6+cfDjTKoC2RreOLy30CcCrg2zt01SKYrUI1uFJm
         o51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2EFJxFHRRzm3oVjJIWeziT+lWBzLWjopR8bsePJKjY=;
        b=f7dH9v095MbIcREWXHaDzDXeCtbKnKj/v1qvjfoJXVuctJ+M6XQVtDokjPE7teCYpF
         ERJENAW2x9/f9HzXT5ns9ndWBBKL0pM6RCnTal3DhwonaerrZjM2RTF1WI5DVtJcqOHg
         0TLCsOADtghOFw3YXXc4gt/RZOm7j/CjB4YvOJv1IC5FMk1wivqfDXkC87/hzdYKVJ0O
         5CZOKoF11LhL13eJsbzKtHLjQAhlyts92fXZZUesLlfrj7pWnI0ahCo8ZNdHO060EkUO
         cjUdcdIv6CO8C+vHsGSoI1JSiFLWhXATV9eXg3BcDCYdll7bqKCJ7LR0SIHzVPMCKyDs
         lGcw==
X-Gm-Message-State: AOAM531pQmM/HNNK2Vr9ByEh/n3TFNCpPmGSGkclp4xkLnGzno+23NYS
        lI6f51WpPZ8GkSx8dn+lGzs=
X-Google-Smtp-Source: ABdhPJxkP/AmmrkF2DUBKBVT1VxNCH83s2+ZUFMnRJUNWGq20hs6pISg5ezMRacDLEuvgFM4869JMg==
X-Received: by 2002:a19:c7d0:: with SMTP id x199mr3333278lff.205.1597363643504;
        Thu, 13 Aug 2020 17:07:23 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:22 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 20/36] dt-bindings: memory: tegra30: mc: Document new interconnect property
Date:   Fri, 14 Aug 2020 03:06:05 +0300
Message-Id: <20200814000621.8415-21-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
turns memory controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
index 84fd57bcf0dc..5436e6d420bc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
@@ -57,6 +57,9 @@ properties:
   "#iommu-cells":
     const: 1
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -120,6 +123,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -135,6 +139,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-1 {
             nvidia,ram-code = <1>;
-- 
2.27.0

