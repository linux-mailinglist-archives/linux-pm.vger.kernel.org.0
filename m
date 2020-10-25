Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5829846F
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419207AbgJYWR4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419195AbgJYWRz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:17:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2706C061755;
        Sun, 25 Oct 2020 15:17:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a5so7685764ljj.11;
        Sun, 25 Oct 2020 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9sDSp9UsTOyPg5KK8o0S3uHbpxl1X+CxL9GNXFca6g=;
        b=FxPsN+6J8h2aIRcjDbmWlta0K0EQg++E8JM2eiQpYPDHBJKT5SkDIM1gHxiYDuQGWn
         1JaUQE95oGdqOHmMGIZpKB3Ggp6NfKMrvGb9su8kd29EJsh1RL+YTuYCvmxKswsBJNPH
         KcF2Ej0UsdXaKiLM9qTEThqccUEuxAH1QiWxbW1fD184w+CInvpJNpKBXWmyPZGWUX90
         su5CdTIdxFroVnxlczmm+fajT1vHFSnBOFTpOrqjp7rIbY6XH+hSCDLs3DW6Ng2709iQ
         tnyV44RGx906uM8VUlypVg2NU0MhN4uTk7krMA5jHzEZnqFSG0NSfUUejjKGxUSJFlRx
         b/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9sDSp9UsTOyPg5KK8o0S3uHbpxl1X+CxL9GNXFca6g=;
        b=jOTGYB9Md5sxkiAPlsca3MJmRDxzF5syqfXdUwPD7HK+ENyit+4jTjELyF24KpCzuM
         sScLLP/tRpzRUuBI56H2I/FXYHiBmZFt//7PmL4coKxUrCz+wniqKyxFScF6CEfg7jpg
         e/AFJLt/VM//8iyKqA5xDJ3jZapa1B7bpLcMKyL4Nh3oUR0mCV/nZp62FG7yxS4iJDZk
         8TFXuN0728BUg1vr6Ri46Ekm+VsCSqKoiyA6OGK7GCY9TQv4I9oj8yPy/yl9p6Ydwr21
         KT0miUeceGBSLduv4jmBvhiEkFE2QxAD/Z6zvVxQot7c5j7tbk/D8jxc+EV6IHCwxcx2
         p0kA==
X-Gm-Message-State: AOAM531Kp59G670+rYgsTCKvuCyEWISolsYHz4Y8hjgYWh3wvSHiQ9XO
        34cMbkWO4xe9PX5iLcUUZX4rK3bI+fw=
X-Google-Smtp-Source: ABdhPJz3/rmupBxM7znTEZcoQz0lcN70Q+F7s1Js9PKzMr5SOvpvEIsR50oykwy7mnr5miBDEH5Mmg==
X-Received: by 2002:a2e:9bce:: with SMTP id w14mr4590245ljj.439.1603664273376;
        Sun, 25 Oct 2020 15:17:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:52 -0700 (PDT)
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
Subject: [PATCH v6 04/52] dt-bindings: memory: tegra20: emc: Document nvidia,memory-controller property
Date:   Mon, 26 Oct 2020 01:16:47 +0300
Message-Id: <20201025221735.3062-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
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

