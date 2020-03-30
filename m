Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FF1971DB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgC3BJm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44882 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgC3BJj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so16282792lji.11;
        Sun, 29 Mar 2020 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THnwhwTdTmg4c86hFlh2qknbtHQvbfTX5IFqa2InF7g=;
        b=Pg3NEZBItMfCSgDZPKnxTIcXNI+xr/d79Of+mkt+dYMW5wLwo4Ok4roS8EnABFr8to
         xwy1Sr5/1/6SLKsSJM0j0LjHENfTxhyPHZyEORqb2qJlsTpnub+E1FEtrgj1IRH81M6t
         dNlP8O6iO/HB5amOL4OsRy3/ZOzQ7DIz7nIygl7Mi5CFGOFhObTMot7NqF94YE0HnILN
         6u3UmhkiAOd9W++3BaZ6hFxXzZtoKFDtBLhW0Iw1k/suQz/MPpg7FJucm/Sl5yiKtdWS
         soby3PljbjCvP0aiph0jIIhGe13/Y2UxSrt1aRvhemGgtUV3to0eaAg5RFUHE6fBl9A2
         i9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THnwhwTdTmg4c86hFlh2qknbtHQvbfTX5IFqa2InF7g=;
        b=n1UPFzo9HMSHUCyNNzRMPTy6KtT1oGYci9+6UlgdEdtp5UonSbawd5/ZiedeT5ejdB
         mMcRR2UGJljjKDWXwLcqQrolkI0IN+ZsqTJIyce7DPOUVHUQ4fPs8zyu3W1o3uJwPaSK
         UULNabYHpp/+yI0t0qbotZHVH8wvs07a6aDw8dZpvNlPUggDZdkl1dqNcXUTznoxoA8V
         adiXPq268yjlnUOGJgTb3sUxEQbl+CreR1OfjIy1bJC4juFsp8iOFAxTK9yq7NyiUNHN
         Zca+OqH0L4Ea8gL5o+ArKlMp6of9uNi3r/aTG9pSUT068nASkUs3r+vq/McxXkXrzhQv
         Cigw==
X-Gm-Message-State: AGi0PuZYdGWHIYNkX1BXGktdANjjHUzATtfx6pSSQEYWMbN+DDJsfSpc
        MulMBvonJNWdQlvgd3CGOnE=
X-Google-Smtp-Source: APiQypKDy2Ro7EQKBqSUe7PyjSLNAnaV0wdFF27xRufe2z5meT1FtGCGpLLX8lEkaMU6PMzGngPfnA==
X-Received: by 2002:a05:651c:552:: with SMTP id q18mr5910854ljp.1.1585530576340;
        Sun, 29 Mar 2020 18:09:36 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 02/22] dt-bindings: memory: tegra20: emc: Document new interconnect property
Date:   Mon, 30 Mar 2020 04:08:44 +0300
Message-Id: <20200330010904.27643-3-digetx@gmail.com>
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
 .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
index add95367640b..f51da7662de4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
@@ -12,6 +12,7 @@ Properties:
   irrespective of ram-code configuration.
 - interrupts : Should contain EMC General interrupt.
 - clocks : Should contain EMC clock.
+- #interconnect-cells : Should be 0.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -20,6 +21,7 @@ Example:
 	memory-controller@7000f400 {
 		#address-cells = < 1 >;
 		#size-cells = < 0 >;
+		#interconnect-cells = < 0 >;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
 		interrupts = <0 78 0x04>;
-- 
2.25.1

