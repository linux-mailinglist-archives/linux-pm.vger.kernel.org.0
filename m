Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4865630D63A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 10:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhBCJZZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 04:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbhBCJYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 04:24:46 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7280FC06174A
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 01:24:06 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i7so16896805pgc.8
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2021 01:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmEy+MM4K3YkzTAoCzjXjvWdqyK8YoxPSSq7rOO1Ck4=;
        b=NEpsgWWF/Vr7FJ8ymDS5oltb6nI4gFB86S/58dHPgy+mZDSALuh7MhPPqyusAqs6nG
         yqmeJlLN/OmeoLtgLU0gnKO7PZRop7QFARQAEgLD4NVouUt6F3dyf0aLTo9ZIrseEEDU
         Rlr7QpLIiTI8sC5kRWUg5WAVlW8euzvFfSRXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmEy+MM4K3YkzTAoCzjXjvWdqyK8YoxPSSq7rOO1Ck4=;
        b=k/S6J9Fhr+8PslCxWln5ktnYt+toSTayJ2BpLjjznTqOK58PWpOpTxBmvDO1o3L2bT
         uXxd/iEtTtsq2YgdsEJbiXn/JkY44GiNOdLU+vRI3mXy1lBbNKURWzJ3iSjoOBJth8a4
         V2xvS0oMxYUgQ3TLnGu23vwcLpFDEZpulyFIZb0oYWXA5NE3VqpF35+/rJmRf9FnqH63
         19j/eYS+j3G7dkpnMcGDDxqG/aPjabZAMBWb/9XbZdKq3GUUshEyBY0fDHEdUu2MUlNS
         +O/6v0Be9Cu18X7nqu+ZKIFASvQPptkYL17Z+0/LOHjH6ztyb1FdJBkWPO+HC72AQetK
         y7cw==
X-Gm-Message-State: AOAM530gmP6Rb8Q1TYebIb7F4bSS2wctK+JqAzjrmFIZZRiJ5I/GAcMR
        LLfVyaLPPLhwIHspz7S6q06iUg==
X-Google-Smtp-Source: ABdhPJx/ThGdGiVmzVs8W3gH8WUwX5Zzb6zCDKnO5/Qdo5QFC8/oLJNS8v92G3o/lBaWZ0rkN0vtNQ==
X-Received: by 2002:a63:e30d:: with SMTP id f13mr2677675pgh.39.1612344245931;
        Wed, 03 Feb 2021 01:24:05 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id u20sm932294pjy.36.2021.02.03.01.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 01:24:05 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 0/3] Add required-opps support to devfreq passive gov
Date:   Wed,  3 Feb 2021 17:23:57 +0800
Message-Id: <20210203092400.1791884-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq passive governor scales the frequency of a "child" device based
on the current frequency of a "parent" device (not parent/child in the
sense of device hierarchy). As of today, the passive governor requires one
of the following to work correctly:
1. The parent and child device have the same number of frequencies
2. The child device driver passes a mapping function to translate from
   parent frequency to child frequency.

When (1) is not true, (2) is the only option right now. But often times,
all that is required is a simple mapping from parent's frequency to child's
frequency.

Since OPPs already support pointing to other "required-opps", add support
for using that to map from parent device frequency to child device
frequency. That way, every child device driver doesn't have to implement a
separate mapping function anytime (1) isn't true.

Some common (but not comprehensive) reason for needing a devfreq passive
governor to adjust the frequency of one device based on another are:

1. These were the combination of frequencies that were validated/screened
   during the manufacturing process.
2. These are the sensible performance combinations between two devices
   interacting with each other. So that when one runs fast the other
   doesn't become the bottleneck.
3. Hardware bugs requiring some kind of frequency ratio between devices.

For example, the following mapping can't be captured in DT as it stands
today because the parent and child device have different number of OPPs.
But with this patch series, this mapping can be captured cleanly.

In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
like this with the following changes:

	bus_g2d_400: bus0 {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu_top CLK_ACLK_G2D_400>;
		clock-names = "bus";
		operating-points-v2 = <&bus_g2d_400_opp_table>;
		status = "disabled";
	};

	bus_noc2: bus9 {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
		clock-names = "bus";
		operating-points-v2 = <&bus_noc2_opp_table>;
		status = "disabled";
	};

	bus_g2d_400_opp_table: opp_table2 {
		compatible = "operating-points-v2";
		opp-shared;

		opp-400000000 {
			opp-hz = /bits/ 64 <400000000>;
			opp-microvolt = <1075000>;
			required-opps = <&noc2_400>;
		};
		opp-267000000 {
			opp-hz = /bits/ 64 <267000000>;
			opp-microvolt = <1000000>;
			required-opps = <&noc2_200>;
		};
		opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
			opp-microvolt = <975000>;
			required-opps = <&noc2_200>;
		};
		opp-160000000 {
			opp-hz = /bits/ 64 <160000000>;
			opp-microvolt = <962500>;
			required-opps = <&noc2_134>;
		};
		opp-134000000 {
			opp-hz = /bits/ 64 <134000000>;
			opp-microvolt = <950000>;
			required-opps = <&noc2_134>;
		};
		opp-100000000 {
			opp-hz = /bits/ 64 <100000000>;
			opp-microvolt = <937500>;
			required-opps = <&noc2_100>;
		};
	};

	bus_noc2_opp_table: opp_table6 {
		compatible = "operating-points-v2";

		noc2_400: opp-400000000 {
			opp-hz = /bits/ 64 <400000000>;
		};
		noc2_200: opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
		};
		noc2_134: opp-134000000 {
			opp-hz = /bits/ 64 <134000000>;
		};
		noc2_100: opp-100000000 {
			opp-hz = /bits/ 64 <100000000>;
		};
	};

-Saravana

v4 -> v5:
- drop patch "OPP: Improve required-opps linking" and rebase to 
  https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=opp/linux-next
- Compare pointers in dev_pm_opp_xlate_required_opp().

v3 -> v4:
- Fixed documentation comments
- Fixed order of functions in .h file
- Renamed the new xlate API
- Caused _set_required_opps() to fail if all required opps tables aren't
  linked.
v2 -> v3:
- Rebased onto linux-next.
- Added documentation comment for new fields.
- Added support for lazy required-opps linking.
- Updated Ack/Reviewed-bys.
v1 -> v2:
- Cached OPP table reference in devfreq to avoid looking up every time.
- Renamed variable in passive governor to be more intuitive.
- Updated cover letter with examples.

Saravana Kannan (3):
  OPP: Add function to look up required OPP's for a given OPP
  PM / devfreq: Cache OPP table reference in devfreq
  PM / devfreq: Add required OPPs support to passive governor

 drivers/devfreq/devfreq.c          |  6 ++++
 drivers/devfreq/governor_passive.c | 20 ++++++++---
 drivers/opp/core.c                 | 58 ++++++++++++++++++++++++++++++
 include/linux/devfreq.h            |  2 ++
 include/linux/pm_opp.h             | 11 ++++++
 5 files changed, 92 insertions(+), 5 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

