Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C13A2A6AF7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgKDQtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgKDQth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:37 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DEFC0613D3;
        Wed,  4 Nov 2020 08:49:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l28so27977089lfp.10;
        Wed, 04 Nov 2020 08:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4fEi3wCPpoua/qDylZx+LzNx6L93XnSjhKMe6q9RTI=;
        b=Ewh2p2GdPp3YErWuvEMBgwrJyrpprOiY9HGheGbE7yGeOgRh4QBLnjOfP3Z7J6V/WB
         rCunzf5c1YCFkQamSR5BPXH/rwDZWWGCLoAsAqM3Q7jmEYWMKmXWirHQXv9Q94bmDqGy
         czL3WgXgHUHeIrdzUCQe0dmm/jPDLUIjYpizFa2J9u1EFskOFQ5x4k0lS1hBLQju0gL7
         feB3SQEX3iofrOfTAlUdZGy4wOPpiO4dgF34prS2mpK9QbaXwJwrQukoRAE3Fnw5lHEE
         pNje1OHhaycPJod04a34HbSsk0lhi98gFglTejRdEA1C5EbdF6U42k1xFeHvVuRVqMbr
         7fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4fEi3wCPpoua/qDylZx+LzNx6L93XnSjhKMe6q9RTI=;
        b=jkkKC/aA8uQ+mNmZMGLZhxPfVqWzpKhFSkFtYSUPsmM+0Et4Y5K+Z25faLRHCdCLq5
         K+FrrtsqHM9rx/K6H9jnfjxSNlRw8nMPXdudtwJJvv+gRk2xPs77gApBQjON/T9tPkSB
         yXPtTUNkJTeCLAAkQKCmST3gn2Nlti1WGa77FqMCejKCxIgB18J4ZjSy/I+RmkQtwftW
         LQNSm4dw8JSPfGKZGzTb7jJlpkBu+9UzKojR6rew/U/rdlWlwHMKJaNBN9e2gQM6tkhd
         amAhw2nxohvWaIuqOSubmMEfoDXPbzxeoUjMeqe20pf6qCnZIT2ylLOkyg5+r/0pPGbO
         Zo3w==
X-Gm-Message-State: AOAM530eRQKw4gCOCYyzhqWpTyj8rHDRFXDaPb/8emMZ39RJ5Ze3VVuY
        zNj5zD4KPR589u4lh/NfeRs=
X-Google-Smtp-Source: ABdhPJytaqJbhmbF+AyRx+dDbl9jnyMGeieAeK3YQ3FzCyw01EWXEE8xUVlyNtTNvsWUIPKw12LPpA==
X-Received: by 2002:a05:6512:290:: with SMTP id j16mr9505173lfp.62.1604508575190;
        Wed, 04 Nov 2020 08:49:35 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:34 -0800 (PST)
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
Subject: [PATCH v7 04/47] dt-bindings: memory: tegra20: emc: Correct registers range in example
Date:   Wed,  4 Nov 2020 19:48:40 +0300
Message-Id: <20201104164923.21238-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is superfluous zero in the registers base address and registers
size should be twice bigger.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index add95367640b..567cffd37f3f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -21,7 +21,7 @@ Example:
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
 		compatible = "nvidia,tegra20-emc";
-		reg = <0x7000f4000 0x200>;
+		reg = <0x7000f400 0x400>;
 		interrupts = <0 78 0x04>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 	}
-- 
2.27.0

