Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8E2BFD5F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 01:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKWAbR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 19:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKWAbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 19:31:16 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A71C0613CF;
        Sun, 22 Nov 2020 16:31:15 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so21416080lfd.9;
        Sun, 22 Nov 2020 16:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiKxinntaaBhKNDA6LHo2vQincTmnZ6b702qKhoDqBY=;
        b=efaz58nHi7ZIPNTz1vsAj1hnSBa0M1ImwOfX2KoyXe1MoVJ48V7MkK76CAiFX9Llis
         JC7VMkN+rIr8dQEBBJYTPMLkPHND3na3EjyX8Jl18Bh0JuNMwAEyXb14kyyXSwsFBX3r
         2nSsamHEb3exucuwwPUd8QU0NnAVWFp7kap+4TABQVuMuAmq+3R510d/dxvJ1/N12Y1v
         MkwYeR1oYVCe31LVUmvFfsFfHD8CclGXcHoYCpd4xrhrh60VG3aEdpoPObEPhy4Ar1oK
         8Q3bvL+iKcah8cCrbmhF2QedMtE+FL6Hl0goHN2nq+kiIIFT4CJjfL/PSnTabI+acx6C
         rZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiKxinntaaBhKNDA6LHo2vQincTmnZ6b702qKhoDqBY=;
        b=ebagHgBSj/0yxEpiysIZEC+ilxNx5QxYmC+Qke2c4Eb/tFEw/G/otTMUqt0ayZDbES
         CiHhaSpbqwEZPPxFuZ+P4QZ4gI0+JgHFpo+WD7N40RSTHNAc2zvRkZzwtIbChsur1+3C
         M+BFb2B2kFUM/BKTwUU91mSi71Xd1TKyJUfj5QQEA8eFcmDS7wDOZxWogWdyTkxLCxiC
         fwjRcdxm/24e8JNpDcEDq4QMxwLVcJLicmIHM2z+fl8mlWyW1ro1dOrQ9ekMKQFcgSBy
         YFymjLAsVDcaJfJ7suu+bARxnA+1RjztpGwUIdN3UsqRq/MI6g52plxdnuNtTpWOKfNB
         xkqQ==
X-Gm-Message-State: AOAM5312bTo/kFoh02CFh8ivAdPjk2yUax/TKZSECQ8vxBvtS4kxKpT7
        ZOZ38I8Ny1ct3Mz24tMfqjg=
X-Google-Smtp-Source: ABdhPJwJcon4kwwSKPI2+abWib1wTP3B2tcX9CDwpGJUURqjxaPIly5wScJkIBxUc6uYOv3TCwHzvQ==
X-Received: by 2002:a19:ca57:: with SMTP id h23mr885032lfj.12.1606091474437;
        Sun, 22 Nov 2020 16:31:14 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id r27sm1225823lfn.290.2020.11.22.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 16:31:13 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v10 01/19] dt-bindings: memory: tegra20: emc: Document opp-supported-hw property
Date:   Mon, 23 Nov 2020 03:27:05 +0300
Message-Id: <20201123002723.28463-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123002723.28463-1-digetx@gmail.com>
References: <20201123002723.28463-1-digetx@gmail.com>
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
index 67ac8d1297da..fe99ce1013bd 100644
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

