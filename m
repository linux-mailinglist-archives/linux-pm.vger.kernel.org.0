Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2B252CDC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 13:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgHZLux (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgHZLuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 07:50:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48DCC061795
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 04:50:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x143so854294pfc.4
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBfSxqGewdmgqv+MqirStMARwcP9jOnx8CudDAuj8N4=;
        b=j2/+JFzvW/o4MtYwgPJgGB1/hmO3WTaD7uyivV4STDRbE42T5q8F2+3AG7rYqbHT9F
         2Y+tksDrhYQlmhLtQeI7i2RYvhqyRkIYftTEyAeGjMtUszGvxvWoIyTDr5wZ6R1aCViA
         eAn4cmOYkSC8phQ36CSGhyXaw0/jTGzroxer8E2Ll1T+5hd3HGwTpESFosrS7WywfsLa
         +wCpXdszE3bKqU5WDO4DAyizF0XO9NLE5l/xcySKN8rPceXSCcfbp060BXJwRPPgIwht
         lw7C+a8b4AvrR1h8jLBKhC38gdM4fi2WTw/tLfgX4YKp50xtH9HB09VDl17iII9RDPhZ
         I2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBfSxqGewdmgqv+MqirStMARwcP9jOnx8CudDAuj8N4=;
        b=dPGfrWUnrehKoQbm7d9x3ZafSdvlInkcEp/pwWARrdoVm7ZKbYVzLeHHEBi2He2FwY
         pA4TvvRs7g/zS8ZgLbCOCUhQuH8sLCdpxiVeyV4rk/QNBEXDnR14yb0hKxWoIBG15Hl8
         RhjIuFHDuLTLB3U9fOWRSg16ZTDjo9CjLBB6l6xmkqWcE6TsMPIgZJVyaRnQLx8pFoBs
         LcMxhVj4bqsubwIo9ffauK+afqMjwlSDnQ6CgoD/0OIJxIN8LysdxNarTbggViqWJou2
         PtshdomQkt2jB7C3dCRU1ZlL3gEBVoizXH7NWPRKMrPIYFpJqAFV09m8t8fdLRZf68Jq
         bUyw==
X-Gm-Message-State: AOAM5331b9FJxMu9O0WXcCWxLw0YJnsLoJlarXDTG0Npv2Nyy+phv9n5
        9vZP0EuQGZUrG+iWcBbHCr8JsA==
X-Google-Smtp-Source: ABdhPJwvl+y6ZWGao7YMxGBN1XA7sn0sxPJqCHEifmy40XejHezA8W66zOzhmYS0St1ioo8tqsrhvA==
X-Received: by 2002:a63:354:: with SMTP id 81mr3180046pgd.216.1598442643293;
        Wed, 26 Aug 2020 04:50:43 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id j1sm3083230pfg.6.2020.08.26.04.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 04:50:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: opp: Allow opp-supported-hw to contain multiple versions
Date:   Wed, 26 Aug 2020 17:20:28 +0530
Message-Id: <552554ad2e77cc7fe2098d9f2807d0ec8c0de23a.1598442485.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1598442485.git.viresh.kumar@linaro.org>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A single list of versions for a hierarchy of hardware levels is not
sufficient in some cases. For example, if the hardware version has two
levels, i.e. X.Y and we want an OPP to support only version 2.1 and 1.2,
we will set the property as:

	opp-supported-hw = <0x00000003 0x00000003>;

What this also does is enable hardware versions 2.2 and 1.1, which we
don't want.

Extend the property to accept multiple versions, so we can define the
property as:

	opp-supported-hw = <0x00000002 0x00000001>, <0x00000001 0x00000002>;

While at it, also reword the property description.

Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 53 +++++++++++--------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 9d16d417e9be..9847dfeeffcb 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -154,25 +154,27 @@ properties.
 - opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
   in the table have this, the OPP with highest opp-hz will be used.
 
-- opp-supported-hw: This enables us to select only a subset of OPPs from the
-  larger OPP table, based on what version of the hardware we are running on. We
-  still can't have multiple nodes with the same opp-hz value in OPP table.
-
-  It's a user defined array containing a hierarchy of hardware version numbers,
-  supported by the OPP. For example: a platform with hierarchy of three levels
-  of versions (A, B and C), this field should be like <X Y Z>, where X
-  corresponds to Version hierarchy A, Y corresponds to version hierarchy B and Z
-  corresponds to version hierarchy C.
-
-  Each level of hierarchy is represented by a 32 bit value, and so there can be
-  only 32 different supported version per hierarchy. i.e. 1 bit per version. A
-  value of 0xFFFFFFFF will enable the OPP for all versions for that hierarchy
-  level. And a value of 0x00000000 will disable the OPP completely, and so we
-  never want that to happen.
-
-  If 32 values aren't sufficient for a version hierarchy, than that version
-  hierarchy can be contained in multiple 32 bit values. i.e. <X Y Z1 Z2> in the
-  above example, Z1 & Z2 refer to the version hierarchy Z.
+- opp-supported-hw: This property allows a platform to enable only a subset of
+  the OPPs from the larger set present in the OPP table, based on the current
+  version of the hardware (already known to the operating system).
+
+  Each block present in the array of blocks in this property, represents a
+  sub-group of hardware versions supported by the OPP. i.e. <sub-group A>,
+  <sub-group B>, etc. The OPP will be enabled if _any_ of these sub-groups match
+  the hardware's version.
+
+  Each sub-group is a platform defined array representing the hierarchy of
+  hardware versions supported by the platform. For a platform with three
+  hierarchical levels of version (X.Y.Z), this field shall look like
+
+  opp-supported-hw = <X1 Y1 Z1>, <X2 Y2 Z2>, <X3 Y3 Z3>.
+
+  Each level (eg. X1) in version hierarchy is represented by a 32 bit value, one
+  bit per version and so there can be maximum 32 versions per level. Logical AND
+  (&) operation is performed for each level with the hardware's level version
+  and a non-zero output for _all_ the levels in a sub-group means the OPP is
+  supported by hardware. A value of 0xFFFFFFFF for each level in the sub-group
+  will enable the OPP for all versions for the hardware.
 
 - status: Marks the node enabled/disabled.
 
@@ -503,7 +505,6 @@ Example 5: opp-supported-hw
 			 */
 			opp-supported-hw = <0xF 0xFFFFFFFF 0xFFFFFFFF>
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <915000 900000 925000>;
 			...
 		};
 
@@ -516,7 +517,17 @@ Example 5: opp-supported-hw
 			 */
 			opp-supported-hw = <0x20 0xff0000ff 0x0000f4f0>
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <915000 900000 925000>;
+			...
+		};
+
+		opp-900000000 {
+			/*
+			 * Supports:
+			 * - All cuts and substrate where process version is 0x2.
+			 * - All cuts and process where substrate version is 0x2.
+			 */
+			opp-supported-hw = <0xFFFFFFFF 0xFFFFFFFF 0x02>, <0xFFFFFFFF 0x01 0xFFFFFFFF>
+			opp-hz = /bits/ 64 <900000000>;
 			...
 		};
 	};
-- 
2.25.0.rc1.19.g042ed3e048af

