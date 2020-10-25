Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C902984AA
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419774AbgJYWWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419218AbgJYWR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:17:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F46C061755;
        Sun, 25 Oct 2020 15:17:57 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so9431501lfl.2;
        Sun, 25 Oct 2020 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWu/mMLdPTGio8YSQylDeD3S9LBmx+ajaTXUfXipIPE=;
        b=FZZV5aOHHxAcLl8vvVYkO+lmSej36EV0gZ3ub+YcHLnIr8Dtb5vglgR5pUr4kX388G
         lSnK6cs63/zQQf0hzUNYFT+TTaYrUanI8RCj9MY304sa/FxuHqfJTOWCbAJ3U4gVuyd0
         /cxoHnaYURF5/RdAefp79Q0SHQPuvX105yKy9SCyncGfwmltsjG4087Ml4OFt9EznGfu
         cpIDu61s4EBGE2kulCHmTsuz+KplPDpZi59ShikSxSDukloobbl4oVnDns41fcSKI50/
         1tIlnaLewqoK7jcvPYjejSlsQIWOqvAXDFIQM9EpZm4CdgFg9vzw4ph1fAHR7wSEmfGE
         xddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWu/mMLdPTGio8YSQylDeD3S9LBmx+ajaTXUfXipIPE=;
        b=nYmCX1Wukh5e1aQyicGSAEu1i12mjsT/RRRc3F/DAN6t8K59pMZaoJOkMis3Z+vfkT
         KD4danPqlbfi8WuwWIA/uAOMwXPYJp3/Haj+JN/F+sTdAgRq6itU04WLeVeG8BNC1SKY
         B2yvl02WPI3SDWpjqYkkVQLWfeXr4xHf8Xk9OlAKvXVpd1rodZhwrNBW7XaBKtNHDOUP
         HXL4wsHPx2Ct0/ROkdAck+ZMxdIf/Vq5CKDcUkVXcKGp19ti4lroTx232DbZnsHIHAz3
         lxs8mvULHL1pFz40ZmKWE2qs2a2+Kch79QwH1KdubX6WoGhm5HOs1FHVIoFmHPb73dz6
         iruA==
X-Gm-Message-State: AOAM530ER3NQDsmLINt0CUJzVt+i+VkqtjCD7CZouiYlyZuaUjZxRCZZ
        yQrK90W1jFYbD04HgI+lDX0=
X-Google-Smtp-Source: ABdhPJzA53mkM4J1Nl0Ouu4LDwd4GMj+pfYIySmoHsV/wNETKZbiy8fCBMKxrhMwExjUJR50dfgAsw==
X-Received: by 2002:a05:6512:3490:: with SMTP id v16mr3848789lfr.61.1603664275759;
        Sun, 25 Oct 2020 15:17:55 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:55 -0700 (PDT)
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
Subject: [PATCH v6 06/52] dt-bindings: memory: tegra20: emc: Document new interconnect property
Date:   Mon, 26 Oct 2020 01:16:49 +0300
Message-Id: <20201025221735.3062-7-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

External Memory Controller is interconnected with memory controller and
with external memory. Document new interconnect property which turns EMC
into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index 1b0d4417aad8..0a53adc6ccba 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -13,6 +13,7 @@ Properties:
 - interrupts : Should contain EMC General interrupt.
 - clocks : Should contain EMC clock.
 - nvidia,memory-controller : Phandle of the Memory Controller node.
+- #interconnect-cells : Should be 0.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -21,6 +22,7 @@ Example:
 	memory-controller@7000f400 {
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
+		#interconnect-cells = < 0 >;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x400>;
 		interrupts = <0 78 0x04>;
-- 
2.27.0

