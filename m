Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63402A6B0B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgKDQyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731426AbgKDQtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:39 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14313C0613D3;
        Wed,  4 Nov 2020 08:49:39 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 23so23664751ljv.7;
        Wed, 04 Nov 2020 08:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bx8gx8+d1g03DAKla/SIGpVTuVq7snjdNHpSyCav3o=;
        b=E4fVzzEbN2YOZaT7L0YMq0MzZmwK0d5G6U1UdsHOygRHeg4qD9/kMAl31z/C7UvzgG
         3wfNw+SsSCew6J8BJc1FkTG6ol/t1QiIa1Ix/1hrZilYXxIBY4jsknB+cNHgZMWOJTA1
         LTytMvkcgBF8OEXqBMsuC5+boAbL6idy3aCojRnyMjNUn4VzjFvuIi1/qV8lMIsR3tjG
         Rklpa7X8zpedENSm9wa+kGSTC1tRrCSwsnqPBtDYo0M/PxgPvpCMC3lTZx6Vx3zR8JLi
         ituiJ3sgD8uk5s6N4B7KHODv4BIgVUZh8uuDolNZcIpSB4tutXKVidPdcwIjV5eBO8J+
         ebjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bx8gx8+d1g03DAKla/SIGpVTuVq7snjdNHpSyCav3o=;
        b=NDUbA5yU8vD64UV3EOcXCLs2pxB7wVR79hLCJr6cw7hHqiZi5oEIhkKsk+PidKwrtH
         iOK/MDCTJjR9FtICx5yAYhOSzXwWuKf/x07ftuATtVPcE1Ed41qdxnotJBarkLqDywyw
         I8naSLW+Btamdz88/GSClSkCMqwwhm6xR/OzFiZaTw8Uk7Vhbca9yaQ0T2aSpHaV/ene
         9+/sQqBL6Z+mSr2gIaXgHCpwsZ1imAwzjV61nk10lvthrksfXGfOwMJ14U+y/oZ61kfu
         vptI893LgXe82C/FoeKJOiick2vWs7+lR3/cYJzrDVDLqIdlIO50/jQsT4dQ/eRX3ZSK
         rXHA==
X-Gm-Message-State: AOAM532mSc8yj10Gw3LYLlTGI/Q+ZT9aIBN/oSJRRebqK5AlPilbDWKi
        3gyVDNFAyjd5sacjWtrb3rQ=
X-Google-Smtp-Source: ABdhPJwGNgNsjt7GM+mUEmujJb3ulRATwMxAQBV2JYiJ+8jaEaSL5rtWnNfZYbAIRZqj86M0zhzGjw==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr6607807ljg.460.1604508577584;
        Wed, 04 Nov 2020 08:49:37 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:37 -0800 (PST)
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
Subject: [PATCH v7 06/47] dt-bindings: memory: tegra20: mc: Document new interconnect property
Date:   Wed,  4 Nov 2020 19:48:42 +0300
Message-Id: <20201104164923.21238-7-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
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

