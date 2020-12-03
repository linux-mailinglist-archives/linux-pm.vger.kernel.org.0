Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C412CDEC7
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 20:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgLCTZf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 14:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbgLCTZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 14:25:34 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5089C061A4E;
        Thu,  3 Dec 2020 11:24:53 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so4388939lfc.4;
        Thu, 03 Dec 2020 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WUhKJyasXG2LBKITKz4o43ZB62Ht6r3ypNcA03zC6GA=;
        b=piGC8uTtwm+ToJJ3OM+dvwV39aEqVZGjI8n4Bbn/lXm9Umo3CS1+ycC3T0gOosRlxL
         uZHpFeHecPv+Ih4UYrGS/HGdYU70ttFQc40caN1Z4PeOGcQ8P1oI3xm7nKmmSmFu1dg9
         tDblp2woZRIL6fk1HZ8oL5gEIB47rb7fW2jzjopLDWCI8bqhrELv+S2y4dzIbg4wu65Z
         Jz2HGwnDv+t5Fkb7UWDeixf1NQcS9ORqvVckvBc+z4x3vwFDjQIB8WqjnaJz05YSobhY
         Pt85u6jH1Yl5uu6NPyP6QN7rjgwQ38vJtkpQ/PjxzoK6FMHbvNS+QX6gTxdputOZHwtY
         tGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUhKJyasXG2LBKITKz4o43ZB62Ht6r3ypNcA03zC6GA=;
        b=tUmtWZUI0EtQ2nZQ1dFPCCMYhCLVZsAdSa4QYc+sI+6sAqr5l9tvd2dGYkpXwHXaOh
         4tx9F04Tt4y2umCHo/ZV8KhOCv8xueZJ92pSXB2ImXuxYJhaZqBBBqi3Y2uf2hOU2igb
         ksl/2g4f9vDL8j1IN0UJqo/LtUq9HhUY/g6x/Ec8ZVTlNoHps930184fCb5xjT/sGeRx
         DxT59O9mkzs9IHDd0HNnJ1SAADquOx7hDCjI+pjMLPDPoNrFGSFDFHlvxOyb1lAQjYpQ
         lHkT2kG0CuUg+pwBXT4KATD1Ni8h3Vq3bKo5e3RD5AtxrsbskvB9hz7EgeElFIcbl7Y1
         1n0w==
X-Gm-Message-State: AOAM5309eZL3Xkr/Nax0Vi9SMaQCSpETCiGUz0oBsbAymUH8MmqOuqps
        Eu8HW/xqxfo3H7jgsxFNZlO0q8WvVAM=
X-Google-Smtp-Source: ABdhPJyaASpHVGCirgSfO/q5vizNXp8daCV4N7sSu9YBJ9ArVgBxlQn2qEeoa2k4nh9uBlcmQKlIkA==
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr1866998lfk.338.1607023492203;
        Thu, 03 Dec 2020 11:24:52 -0800 (PST)
Received: from localhost.localdomain (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.gmail.com with ESMTPSA id z7sm861932lfq.50.2020.12.03.11.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:24:51 -0800 (PST)
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
Subject: [PATCH v11 01/10] dt-bindings: memory: tegra20: emc: Document opp-supported-hw property
Date:   Thu,  3 Dec 2020 22:24:30 +0300
Message-Id: <20201203192439.16177-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203192439.16177-1-digetx@gmail.com>
References: <20201203192439.16177-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document opp-supported-hw property, which is not strictly necessary to
have on Tegra20, but it's very convenient to have because all other SoC
core devices will use hardware versioning, and thus, it's good to maintain
the consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-emc.txt      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index 67ac8d1297da..cc443fcf4bec 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -16,6 +16,12 @@ Properties:
 - #interconnect-cells : Should be 0.
 - operating-points-v2: See ../bindings/opp/opp.txt for details.
 
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: One bitfield indicating SoC process ID mask
+
+	A bitwise AND is performed against this value and if any bit
+	matches, the OPP gets enabled.
+
 Optional properties:
 - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
-- 
2.29.2

