Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227852984B0
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419783AbgJYWWc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419205AbgJYWR4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:17:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC92C061755;
        Sun, 25 Oct 2020 15:17:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y16so7733070ljk.1;
        Sun, 25 Oct 2020 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bx8gx8+d1g03DAKla/SIGpVTuVq7snjdNHpSyCav3o=;
        b=i947Rcj1upUno+xtTpk05tqFfb8+q/5AIzJJvuhnPOcfBtRNeVcE8iww4PN98oK+3z
         xxrAvSpkFvy9hrpK351SoA7AZyki2zig6s/0uSyjzUvlPLTTgTqft54DEjo4rVGospAq
         8Xe7h2hJj6AJdjUYZ+uuxLwX6vqQ7xGUL3xUA79RAPMnMXA0m0CPeNTXQo1XtHgwiw3c
         wMS7bL9Pw3Z96EaOw2TAqWJjtdhWJl2QRym5uLqITgcKLZXMurA58bdGTibokajBORWO
         wnnWUJPaxJGjzB4fe72NVtUiNdVNPflO361f0nHsEF5HSGu0iQj1SEFIn3/bWypLqSYH
         nXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bx8gx8+d1g03DAKla/SIGpVTuVq7snjdNHpSyCav3o=;
        b=lRCEc/i9SaLCMtzVkpz+tA5OBlShOjYOWcKjNKG4swt5eInVF44wUMw7kDbptQQ/39
         q2DBxP4PS+kYaRwMv5/Uc0NzHNGLqa0sOvgTDJs+X0fT2aT2VQHJw++kqbAqxXiVDuD8
         SOXG7vg3DIKM/CP0sMRkUlcn6BBNUuklWKuPyv7RTXNYm114ZZqIewiVmrAtd5BAjWXs
         klUKP4kifCLXLhalF/8yg+84kEtp3LcMc91qgkJ65nCA8QDYZq/T7t4ySrkLG57V90I/
         By2787k5bH3fxx1zvxg4a2gZT+baDFUWb8WNHezye+NgZRSrukqWDbHzMcHLDkXo3V3P
         8RBA==
X-Gm-Message-State: AOAM5319l7IJfsdlBxXk+MuoZbSoFGspKsJO5WCUephDBYvwkEmmvcUq
        GLmMl4oZARjndwhSjpklTJE=
X-Google-Smtp-Source: ABdhPJz+1LjXdbQ+D/yc8viE9lMCwBHY23zU4GE4LsvRVfk/mxSEXHmG1SbwFx1wcRejokAz+Em7+w==
X-Received: by 2002:a2e:7217:: with SMTP id n23mr4699165ljc.43.1603664274503;
        Sun, 25 Oct 2020 15:17:54 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:54 -0700 (PDT)
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
Subject: [PATCH v6 05/52] dt-bindings: memory: tegra20: mc: Document new interconnect property
Date:   Mon, 26 Oct 2020 01:16:48 +0300
Message-Id: <20201025221735.3062-6-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
External Memory Controller. Document new interconnect property which
turns memory controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-mc.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
index e55328237df4..739b7c6f2e26 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
@@ -16,6 +16,8 @@ Required properties:
   IOMMU specifier needed to encode an address. GART supports only a single
   address space that is shared by all devices, therefore no additional
   information needed for the address encoding.
+- #interconnect-cells : Should be 1. This cell represents memory client.
+  The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>.
 
 Example:
 	mc: memory-controller@7000f000 {
@@ -27,6 +29,7 @@ Example:
 		interrupts = <GIC_SPI 77 0x04>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
 	video-codec@6001a000 {
-- 
2.27.0

