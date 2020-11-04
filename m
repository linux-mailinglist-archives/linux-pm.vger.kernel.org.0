Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1007C2A6AFC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgKDQxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbgKDQtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:45 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B78C0613D4;
        Wed,  4 Nov 2020 08:49:44 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 184so28004152lfd.6;
        Wed, 04 Nov 2020 08:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPe+0/YRUBexi5uMN/GkvJXoQXyO1wntuOhCKO4PYjA=;
        b=YQlZjqd3Y0ufLowRJA3QsB31Y7NpZIgj+06IXOQ6+eq9+UnKMvGEu24QLivpB6A7LQ
         2C4zW+03RNLuCWi8xFQ3gLq27KGfqOHNnckzGWy5EMLQX8IaP87Sts3240FZtSAKYN+E
         SUCUDbRt73VFUFuE8y7oUdcGaU5ZVsSyy63i/5N96/TwKBxQ5TMKlm7/iHexN1/xofuu
         925pFVVX4je6OnR3uoJqKOhnCNGrWKUj9Rh3RG5JRO4QyTHrS/K2WECqVzyMfyLQlPdN
         +sjgDWbxOGKXItzCcp9/TE2GjGEEO0gznzTODO5xC3nTw+nbnK9DUYjQB4uxiLkZw9gn
         OC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPe+0/YRUBexi5uMN/GkvJXoQXyO1wntuOhCKO4PYjA=;
        b=fWahjaPiAHfhxhRgBT2yBLcgOIhf3s2SU1dyKhYmt3dbTARyiLg1h8aYljOTcRVv+R
         sviCc32d0LG9qEe4EpdYJMDNw9gDVYfWN1SM1Bwqq4A9AZ+jmL5BFAOsUhZTPSwnDv+Y
         zjFTM6sm/4BmzNrkbThp9ePMJE5D72YACJQow2sGXq1ZeM6hy227478fDoDB8JlccRPP
         9Yuy4sOytlfyqf+Et3wtYB/XMYhH7vJGxudCgaBdjDDp1RzXw+FU3o9IsYEyLY/vvpRY
         NoQV/hyNwqpvzBgXDfwUJ7rpnYm+ZuvzWdmKz0vzzzHqmlZ3CLCjmA6LdI2VOtcllpGR
         0svw==
X-Gm-Message-State: AOAM532JJ+rjji1nB4t5FnMqfLjIqcqXpcV2qeuiEP8V73R14vjHcHag
        uSYHYFSa9ScnHcuYo2XQqwc=
X-Google-Smtp-Source: ABdhPJwgk4Q5UghCChg1NU+InTF2TRZHDkQb/vK7YBZF0U7epGDBX9SNAFzBVs1YHi/JLGyKJCc3EQ==
X-Received: by 2002:a05:6512:358d:: with SMTP id m13mr10940243lfr.435.1604508583465;
        Wed, 04 Nov 2020 08:49:43 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:43 -0800 (PST)
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
Subject: [PATCH v7 11/47] dt-bindings: memory: tegra30: emc: Document OPP table and voltage regulator
Date:   Wed,  4 Nov 2020 19:48:47 +0300
Message-Id: <20201104164923.21238-12-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document new OPP table and voltage regulator properties which are needed
for supporting dynamic voltage-frequency scaling of the memory controller.
Some boards may have a fixed core voltage regulator, hence it's optional
because frequency scaling still may be desired.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../memory-controllers/nvidia,tegra30-emc.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
index c243986db420..0a2e2c0d0fdd 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
@@ -39,6 +39,15 @@ properties:
     description:
       Phandle of the Memory Controller node.
 
+  core-supply:
+    description:
+      Phandle of voltage regulator of the SoC "core" power domain.
+
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property, which
+      is a bitfield indicating SoC speedo ID mask.
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -218,6 +227,7 @@ required:
   - clocks
   - nvidia,memory-controller
   - "#interconnect-cells"
+  - operating-points-v2
 
 additionalProperties: false
 
@@ -230,6 +240,8 @@ examples:
         clocks = <&tegra_car 57>;
 
         nvidia,memory-controller = <&mc>;
+        operating-points-v2 = <&dvfs_opp_table>;
+        core-supply = <&vdd_core>;
 
         #interconnect-cells = <0>;
 
-- 
2.27.0

