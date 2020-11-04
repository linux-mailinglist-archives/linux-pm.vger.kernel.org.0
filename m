Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE552A6A45
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgKDQtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbgKDQti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:38 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F56C0613D4;
        Wed,  4 Nov 2020 08:49:37 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 23so23664674ljv.7;
        Wed, 04 Nov 2020 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YsN85nbqgTsS+El/SUQtmvE9KBR1cwbaNWWJDf0k4lI=;
        b=AJScU/2VUzKHgW+HOaC7NTJ41vUc4OxAtWpYQE0GFtojrKMFUpLQ745q30moeWMQon
         wdSZH2uwscd0ZtQ9Bxe/r8H76c5JsoD+DYz5P9HXNH0jWbXL3Qd/pUQIxrX+3YXHpktg
         OHlC9MvIadTH8DhHcqHoTzi0p9L/baJp6A352nxlijtsH4m9VdyC0QG3R5/rM5xeg1pn
         Cr95ssc0FkGQq7kFj4Ah5fSx8ng9IWh7aZhRSVwAx0Smf68mIuZZJYzt9QzIk7G55Fwv
         4QxHxt07hJywqn8vAAhoRNiEV2aIPTVlR6v7hOcjkyMimua468+F6/Oa3ruEJg48Ix0B
         05Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsN85nbqgTsS+El/SUQtmvE9KBR1cwbaNWWJDf0k4lI=;
        b=qeTBVoczxK4ZZzjqSr/apyCuQmZN52L9pXORVPDDCPodvrfrP0sNLFCh5BHYudoiyq
         maISiHF0oQs3MRBMl7C19cB83v0RPZz395J9DTi2Z+8HPMhczz4Fa8oFvvHIWdap/ikR
         pXYrCX6WqXw+bJxD/rV8LmdO3oEBWqJK9li8F1WBj4zLw1ERAQTp9rSTG+gxCVn7vEoq
         8ER44tje2twPbU3aAJJWfAYB+qGAyp7Lj3IvgJ3FhXmRXn25L0Q9wyiW9g0rjWpgPE7S
         SjRGd1+55c3k9V75cwdbtJI2nCzGmXN5lQw//U/U6tFEcmoVfVQpgeLpetu9mF/q9G9M
         ncIw==
X-Gm-Message-State: AOAM532PIGvI5hf/chavkZwT+VvLp+lhdaaae+KBUU9gxii2gIX0u3UZ
        0u0KzGK9NLGR9WdnbNRlWg8=
X-Google-Smtp-Source: ABdhPJyVVSkc3ic01jwE4gY9fzJuqHoq8xVpnZn9HxWe+YprF9XVQzXAYL9UyDIGqgA8ZUVOH735wA==
X-Received: by 2002:a2e:b4e9:: with SMTP id s9mr11895122ljm.141.1604508576389;
        Wed, 04 Nov 2020 08:49:36 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:35 -0800 (PST)
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
Subject: [PATCH v7 05/47] dt-bindings: memory: tegra20: emc: Document nvidia,memory-controller property
Date:   Wed,  4 Nov 2020 19:48:41 +0300
Message-Id: <20201104164923.21238-6-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra20 External Memory Controller talks to DRAM chips and it needs to be
reprogrammed when memory frequency changes. Tegra Memory Controller sits
behind EMC and these controllers are tightly coupled. This patch adds the
new phandle property which allows to properly express connection of EMC
and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
par with Tegra30+ EMC bindings, which is handy to have.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index 567cffd37f3f..1b0d4417aad8 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -12,6 +12,7 @@ Properties:
   irrespective of ram-code configuration.
 - interrupts : Should contain EMC General interrupt.
 - clocks : Should contain EMC clock.
+- nvidia,memory-controller : Phandle of the Memory Controller node.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -24,6 +25,7 @@ Example:
 		reg = <0x7000f400 0x400>;
 		interrupts = <0 78 0x04>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
+		nvidia,memory-controller = <&mc>;
 	}
 
 
-- 
2.27.0

