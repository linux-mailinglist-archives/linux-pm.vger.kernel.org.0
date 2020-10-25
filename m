Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F85298470
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419203AbgJYWR4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419190AbgJYWRy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:17:54 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36E8C0613D0;
        Sun, 25 Oct 2020 15:17:53 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l28so9411408lfp.10;
        Sun, 25 Oct 2020 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/a3gv2AYUyxirfwrA7rzcTGHo2Zy7KgU1OVTj3xJww=;
        b=ObYcZgUx+SaP7LqHDAeEz2WRgz82BIoMe3e6Wy0p5n0geMQ8hPcVndGrFEpIFBaDl8
         DcS4JDNyy0GkN/f8wuZOa4COaTBYdmLeGomolgAPoUpN9Rr+Rpc4ERtZts5ZAdJKXg+v
         RpJtEtB9KAJMANMZYEpEUh5tbALJE3iQc4Y6l0CBpinPo+kqynxajGLn+H4VGEGDO2NC
         e2wAsYFKDhjgtAUCkF7eLtPZarSFb/fLj4eyLP+i0+d9VdRvHFFoGLL7jIhnF0KO/unY
         Nl91rWDlLeup58a5iD8/RDkPq7Z+Zrbt6NDF0WBdt5VcTgDEYkaThRKYh6v/QhfX5el6
         x1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/a3gv2AYUyxirfwrA7rzcTGHo2Zy7KgU1OVTj3xJww=;
        b=bpKwSGhgXpvMWE2HPTJCwcfzfoWsy8EMesJS2i03fDiuBa/OTRgLxCLB6+O6/EQkbl
         M8eRNf6813lecOe0g47xYMSWXrGjssv5mh0mjico/4/Iwiy+VD6keO6qhMaqqx0o1jCT
         tIvya7kVnhsITg0I75TebsdNSCUJTI0bg91YLJSRFOtLdni2yTPuhrLKhdUa+7z4mbGB
         tY1RVeuy7LNEvXuMr5ntokwaHoBNJwlPBqIMSmvA6xqIoYqiB+MlDc4OPB+FrIFzOJKT
         WNGK+BkHTLByZ6mJG2RlvGYyOKNynpfsVbP+DYIK+eRWIKuo0TOD036FlUBRTHxqkCTB
         Z90Q==
X-Gm-Message-State: AOAM533/laX2luIIbT2HBDrUXlFl64gy8/P+aBXDpCcDUgMcOzvL+BOI
        V590ssdxhRbjwR7LrsIpp28=
X-Google-Smtp-Source: ABdhPJzkAQEflxUEUyIu+FDg08TzL0+YPQxbPHKvkiy04QyTo2AhWvcREt2iDMcDPG+nPZJAgQ96xA==
X-Received: by 2002:a19:8c07:: with SMTP id o7mr3834013lfd.525.1603664272272;
        Sun, 25 Oct 2020 15:17:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:51 -0700 (PDT)
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
Subject: [PATCH v6 03/52] dt-bindings: memory: tegra20: emc: Correct registers range in example
Date:   Mon, 26 Oct 2020 01:16:46 +0300
Message-Id: <20201025221735.3062-4-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is superfluous zero in the registers base address and registers
size should be twice bigger.

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

